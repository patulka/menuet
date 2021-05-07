-- Most used uncategorized ingredients
SELECT I.name, COUNT(1) as CNT FROM ingredients as I JOIN ingredient_relations IR ON I.id=IR.child_id
  JOIN recipe_ingredients as RI ON RI.ingredient_id=IR.child_id
  GROUP BY IR.child_id, I.name
  HAVING COUNT(CASE WHEN IR.parent_id IN (1200, 1000, 1748, 632, 1709, 405, 1721, 1708, 1391) THEN 1 ELSE NULL END)=0
  ORDER BY CNT DESC;

-- Most used roots
SELECT I.name, COUNT(1) as CNT FROM ingredients as I
JOIN ingredient_relations AS IR1 ON I.id=IR1.child_id
JOIN ingredient_relations AS IR2 ON I.id=IR2.parent_id
  JOIN recipe_ingredients as RI ON RI.ingredient_id=I.id
  GROUP BY I.id, I.name
  HAVING COUNT(DISTINCT IR1.parent_id)=1 AND COUNT(DISTINCT IR2.child_id)=1
  ORDER BY CNT DESC;


