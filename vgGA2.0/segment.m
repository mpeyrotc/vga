function seg = segment(r,k,varargin)
% segment(r, k, delta=2, rMin=0)
%
% Segment of width delta starting at, and incluiding,
% value k. (delta >= 2). Works for integer and reals, but
% delta must be an integer.
%
% Examples:
%
%   a = [2 1 2 0 0]*(3.^[0 1 2 3 4]')
%
%   a =
%
%      23   
%
%   segment(23,3.^[0 1 2 3 4],3) =
%
%      2   1   2   0   0
%
%   segment(23,3.^[0 1 2 3 4],9) =
%
%      5   7   2   0   0
%
%   segment(23,3.^[0 1 2 3 4],27) =
%
%     23   7   2   0   0
%
% See also: digit

%************************************************************
%*                                                          *
%*   vgGA2.0: The Virtual Gene Genetic Algorithm            *
%*                                                          *
%*   Copyright (c) All Rights Reserved 2003-2017            *
%*   Manuel Valenzuela-Rendón                               *
%*   manuel.valenzuela.r@gmail.com                          *
%*   http://sites.google.com/site/manuelvalenzuelar/        *
%*                                                          *
%************************************************************

if length(varargin) >= 1
  delta = varargin{1};
else
  delta = 2;
end
if length(varargin) >= 2
  rMin = varargin{2};
else
  rMin = 0;
end

seg = low(highh(r-rMin,k-rMin),delta);

end