import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wger/models/nutrition/ingredient.dart';
import 'package:wger/providers/nutrition.dart';

import '../fixtures/fixture_reader.dart';
import '../measurements/measurement_provider_test.mocks.dart';

void main() {
  late NutritionPlansProvider nutritionProvider;
  late MockWgerBaseProvider mockWgerBaseProvider;

  setUp(() {
    mockWgerBaseProvider = MockWgerBaseProvider();
    nutritionProvider = NutritionPlansProvider(mockWgerBaseProvider, []);

    const String planInfoUrl = 'nutritionplaninfo';
    const String planUrl = 'nutritionplan';
    const String diaryUrl = 'nutritiondiary';
    const String ingredientUrl = 'ingredient';

    final Map<String, dynamic> NutritionalPlanInfoResponse = jsonDecode(
      fixture('nutrition/nutritional_plan_info_detail_response.json'),
    );
    final Map<String, dynamic> NutritionalPlanDetailResponse = jsonDecode(
      fixture('nutrition/nutritional_plan_detail_response.json'),
    );
    final List<dynamic> NutritionDiaryResponse = jsonDecode(
      fixture('nutrition/nutrition_diary_response.json'),
    )['results'];
    final Map<String, dynamic> Ingredient59887Response = jsonDecode(
      fixture('nutrition/ingredient_59887_response.json'),
    );
    final Map<String, dynamic> Ingredient10065Response = jsonDecode(
      fixture('nutrition/ingredient_10065_response.json'),
    );
    final Map<String, dynamic> Ingredient58300Response = jsonDecode(
      fixture('nutrition/ingredient_58300_response.json'),
    );

    final ingredientList = [
      Ingredient.fromJson(Ingredient59887Response),
      Ingredient.fromJson(Ingredient10065Response),
      Ingredient.fromJson(Ingredient58300Response),
    ];

    nutritionProvider.ingredients = ingredientList;

    final Uri planInfoUri = Uri(
      scheme: 'http',
      host: 'localhost',
      path: 'api/v2/$planInfoUrl/1',
    );
    final Uri planUri = Uri(
      scheme: 'http',
      host: 'localhost',
      path: 'api/v2/$planUrl',
    );
    final Uri diaryUri = Uri(
      scheme: 'http',
      host: 'localhost',
      path: 'api/v2/$diaryUrl',
    );
    when(mockWgerBaseProvider.makeUrl(planInfoUrl, id: anyNamed('id'))).thenReturn(planInfoUri);
    when(mockWgerBaseProvider.makeUrl(planUrl, id: anyNamed('id'))).thenReturn(planUri);
    when(mockWgerBaseProvider.makeUrl(diaryUrl, query: anyNamed('query'))).thenReturn(diaryUri);
    when(mockWgerBaseProvider.fetch(planInfoUri)).thenAnswer(
      (realInvocation) => Future.value(NutritionalPlanInfoResponse),
    );
    when(mockWgerBaseProvider.fetch(planUri)).thenAnswer(
      (realInvocation) => Future.value(NutritionalPlanDetailResponse),
    );
    when(mockWgerBaseProvider.fetchPaginated(diaryUri)).thenAnswer(
      (realInvocation) => Future.value(NutritionDiaryResponse),
    );
  });

  group('fetchAndSetPlanFull', () {
    test('should correctly load a full nutritional plan', () async {
      // arrange
      await nutritionProvider.fetchAndSetPlanFull(1);

      // assert
      expect(nutritionProvider.items.isEmpty, false);
    });
  });
}
