% ***********************************
% hyperbolae
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

function [ Y ] = hyperbolae( X, A, B, n )
%HYPERBOLAE Calculate a hyperbolae
%NB could extend to allow more powers of n - vecotrise n and coefficient
%vector
n = 1;


Y = A + ( 1 ./ ( B * (X .^ n)));

end

