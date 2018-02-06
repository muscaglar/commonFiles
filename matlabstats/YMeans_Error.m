% ***********************************
% YMeans_Error
%   For a given Y and X Data scatter convert into Y mean and Y error for
%   given X points
%   
%   (C) Michael Walker 2016 - All Rights Reserved
%
% The above copyright notice and this permission notice shall be included in
% all copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.
%%***********************************

function [ XY ] = YMeans_Error(XValues, X, Y, Y_Std )
%YMeans_Error - pass in a Y X pair, where X is discontinuous
%Find the mean and Std of the Y values at each XValue.


%Need to find the values in X. For each group the Y points and find their
%std and Mean.
n = length(XValues);
Mean = zeros(n,1);
Var = zeros(n,1);
Std = zeros(n,1);
NoPoints = zeros(n,1);
Skew = zeros(n,1);
Med = zeros(n,1);
for i = 1:n
    y_atX = Y(X == XValues(i));
    if ~isempty(y_atX)
        y_atX = y_atX(~isnan(y_atX));
        if(~isempty(y_atX))
            
            NoPoints(i) = max(size(y_atX));
            Mean(i) = mean(y_atX);
            
            if nargin <4
                %Just calc the Var and Std from the Mean values
                Var(i) = ( (1 /NoPoints(i) ) * sum( (y_atX - Mean(i)) .^ 2 ) );
                Std(i) = sqrt(Var(i));
                Skew(i) = (1 / (Std(i) ^ 3)) * ( (1/ NoPoints(i)) * sum( (y_atX - Mean(i)) .^ 3 )  ) ;
            else
                %There are error values
                Y_e_atX = Y_Std(X == XValues(i));  %note may need to imrpove this line
                %Now combine these errors
                Var(i) =  (1 /NoPoints(i) ) * ( sum(Y_e_atX .^2 ) + ( sum( (y_atX - Mean(i)) .^ 2 ) ) );
                Std(i) = sqrt(Var(i));
                %Not updated to correct operation
                Skew(i) = (1 / (Std(i) ^ 3)) * ( (1/ NoPoints(i)) * sum( (y_atX - Mean(i)) .^ 3 )  ) ;
            end
            
            Med(i) = median(y_atX);
            
        end
    end
    
end

%https://en.wikipedia.org/wiki/Standard_error
StdErrMean = Std ./ (NoPoints .^ 0.5);

XY = [XValues' Mean Std NoPoints Skew Med StdErrMean];

%Remove Xvalues where the NoPoints is 0 - this makes plotting better as not
%points on 0 Axis
XY = XY(XY(:,4) > 0,:);

end

