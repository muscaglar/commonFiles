% ***********************************
% logXHistogram
%   plot a histogram on a log X axis
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

function [ X,Y ] = logXHistogram( Data, nbins, colour , xrange, scaling )
%UNTITLED Summary of this function goes here
%   See answers here for this method: http://stackoverflow.com/questions/11933787/log-scale-x-axis-histogram

if nargin < 5
    scaling = 1;
end
if nargin < 4
    xrange = [floor((log10(min(Data)))) ceil(log10(max(Data)))];
end
if nargin < 3
    colour = 'r';
end
if nargin < 2
    nbins = 10;
end


edges = logspace(xrange(1),xrange(2),nbins);
X = (sqrt(edges(1:end-1).*edges(2:end)))';
%Note using histC the final value in Y is the scalar value for the final
%value in edges
%X = [X edges(end)];
%I think histcount fixes this annomaly and doesn't create an extra point as
%its final point includes the right edge of the last bin.
%http://uk.mathworks.com/help/matlab/ref/histc.html
%

Y = histc(Data,edges);
Y = Y/sum(Y)
%Take off the final point as its not in a bin - its on the final edge
Y = Y(1:end-1);

%Use either hist which centres the bars over the x ticks, or histc which
%makes them span x ticks.
h = bar(X,Y,'style','hist');
set(h,'FaceColor',colour)
set(gca,'xscale','log')

%xlim([0.5,length(X)+0.5])
%set(gca,'xticklabel',num2str(X(:),'%5.2f'))

end

