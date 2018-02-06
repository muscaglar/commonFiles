% ***********************************
% hyperbolaeFit
%   Export many experiments to same file
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

function [ A,B,n, Y_fitted ] = hyperbolaeFit( X,Y, A0, B0, n0, X_fit  )
%HYPERBOLAEFIT Summary of this function goes here
%   Detailed explanation goes here

if(nargin < 6)
    X_fit = X;
end

Params0 = [A0 B0 n0];
ParamFinal = fminsearch(@(Params0) hyperbolaeCost(X,Y,Params0), Params0);

A = ParamFinal(1);
B = ParamFinal(2);
n = ParamFinal(3);

Y_fitted = hyperbolae(X_fit, A,B,n);

end

