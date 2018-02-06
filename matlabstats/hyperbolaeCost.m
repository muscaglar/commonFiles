% ***********************************
% hyperbolaeCost
%   
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

function [ cost ] = hyperbolaeCost(X,Y,Params0)
%HYPERBOLAECOST Calculate the sum of the sqaure resids between the data and
%the fit

cost = sum((Y - hyperbolae(X, Params0(1), Params0(2), Params0(3) ) ).^2);

end

