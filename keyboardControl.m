% Keyboard stuff for testing would need to be changed
BucketMoveSize = 0.5;
% Key Right
if (double(get(gcf,'CurrentCharacter'))==28)
  xBucket = xBucket - BucketMoveSize;
end
% Key Left
if (double(get(gcf,'CurrentCharacter'))==29)
  xBucket = xBucket + BucketMoveSize;
end

% Key Up
if (double(get(gcf,'CurrentCharacter'))==30)
  yBucket = yBucket + BucketMoveSize;
end
% Key Down
if (double(get(gcf,'CurrentCharacter'))==31)
  yBucket = yBucket - BucketMoveSize;
end

set(gcf,'CurrentCharacter',char(1));