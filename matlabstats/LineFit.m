% ***********************************
% LineFit
%   Fit a line to data, return gradient, intercept, fitted data
%   
%   (C) Michael Walker 2015 - All Rights Reserved
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

function [ Parameters, StdErrors, Y_Fit, r2] = LineFit( X , Y, X_fit )
%LineFit Fit a line - but also do error and fit analysis.
%   Note would be quite easy to generalise to higher dimension fits, should
%   aim to do this

%See: http://stats.stackexchange.com/questions/44838/how-are-the-standard-errors-of-coefficients-calculated-in-a-regression

if nargin < 3
    X_fit = X;
end
if length(Y) == length(X) 
n = length(Y);

X = reshape(X,[1,n]);
Y = reshape(Y,[1,n]);
%--------------------------------------
%Remove rows with NAN
Z = [X' Y'];
%Z = Z(~any(isnan(Z),2),:) ;
%Z = Z(~any(isnan(Z),1),:) ;
Z = Z(~(isnan(Z(:,2))),:) ;
Z = Z(~(isnan(Z(:,1))),:) ;
X = Z(:,1)';
Y = Z(:,2)';
n = max(size(Y));
%---------------------------------------
Parameters = polyfit(X,Y,1);
Y_Fit = polyval(Parameters,X_fit);

Y_Fn = polyval(Parameters,X);
Y_Mean = mean(Y);
%Total Sum of squares
SS_tot = sum((Y - Y_Mean).^2);
%Residual Sum of squares
SS_res = sum((Y - Y_Fn).^2);

%Standard Deviations
std_Data = ((1/n) *(SS_tot)) ^ 0.5;
std_Fit =  ((1/n) *(SS_res)) ^ 0.5;

% R2 value from http://en.wikipedia.org/wiki/Coefficient_of_determination
r2 = 1- (SS_res / SS_tot);

Xmat = [ones(n,1) X'];

Var_Params = (std_Fit^2) * inv(Xmat' * Xmat);

StdErrors = diag(Var_Params) .^ 0.5;
%reverse StdErrors so it matches the order of Poly fit  - ie highest order
%first.
StdErrors = StdErrors(end:-1:1);
else
    Parameters = [];
    StdErrors =[];
    Y_Fit=[]; r2 =[];
end
end

