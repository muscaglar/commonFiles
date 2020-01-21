function y=lssmooth(x,tau,ord)
% LSSMOOTH  Least-Squares Smoother.
%    Y = LSSMOOTH(X,TAU) returns a smoothed version of vector X, with
%    smoothness controlled by TAU, the response time in samples.  TAU is
%    comparable to the length of a moving average filter in its effect on
%    the smoother's bandwidth, and is continuously variable, TAU >= 0.
%    If X is a matrix, smoothing is performed on each column.
%
%    Y = LSSMOOTH(X,TAU,ORD) suppresses output derivatives of order > ORD,
%    where 0 <= ORD <= 4 and the default is 2.  The greater ORD, the less
%    damping, the sharper the frequency response knee, and the more sinc-
%    like the impulse response.  The table below shows ORD's effect on
%    step response.
%
%    Higher order, larger TAU, and longer signal length (L) make the
%    calculation more challenging from a matrix conditioning standpoint.
%    If conditioning is poor, LSSMOOTH will reduce ORD as necessary to
%    improve conditioning and obtain a trustworthy solution, and display a
%    notice.  For a given ORD, the unaffected space of TAU and L depends
%    on the machine and MATLAB version, so the rightmost constants in the
%    table below are approximate.
%
%                       Step Response               Approximate
%      Order              Overshoot             Domain of L and TAU
%      -----            -------------        -------------------------
%        0                  None                  L^2 * TAU  <  1e28
%        1                  3.3%              L^(2/3) * TAU  <  2.7e9
%        2 (default)        5.6%              L^(2/5) * TAU  <  5.3e5
%        3                  6.8%              L^(2/7) * TAU  <  13000
%        4                  7.5%              L^(2/9) * TAU  <  1800
%
%    Note that as TAU surpasses the input length, the output approaches a
%    polynomial fit of order ORD.
%
%    See also IRLSSMOOTH
%

% Written by James S. Montanaro, February 2015

% ----------------------------- Check Inputs -----------------------------

if nargin < 2
    error('Not enough inputs.')
elseif tau < 0
    error('TAU must not be negative.')
elseif nargin < 3
    ord=2;
elseif ord < 0 || ord > 4
    error('ORD must be in the range 0 to 4.')
else
    ord=round(ord);
end
[m,n]=size(x);
row=(m == 1);
if row
    x=x.';
    m=n;
    n=1;
end
if m < ord+1
    error(['At least ' int2str(ord+1) ' input points required.'])
end
ordstart=ord;

% ------------------------------- Algorithm -------------------------------

% Tau normalizers for orders 0:4
tau0=[4.000 3.416 3.404 3.411 3.417];

% Prepare to reduce ORD if calculation is ill-conditioned
warnID='MATLAB:rankDeficientMatrix';    % MATLAB warning ID
s0=warning('off',warnID);               % disable warning message
done=false;                             % completion status

% If necessary, repeat calculations until conditioning is good
while ~done
    lastwarn('');                           % clear warning indicator
    
    % Compute differencing coefficients
    h=[-1 1];                               % 1st-order diff
    for i=1:ord
        h=conv(h,[-1 1]);                       % higher-order diff
    end
    
    % Compute LS solution from overdetermined matrix equation
    k=ord+1;                                % for convenience
    h=repmat(h,m-k,1);                      % diagonals-to-be
    wd=(tau/tau0(k))^k;                     % weight of differencing part
    A=[speye(m); wd*spdiags(h,0:k,m-k,m)];  % sparse matrix
    v=[x; zeros(m-k,n)];                    % target vector
    y=A\v;                                  % LS solution
    % Note: Theoretically, computing y=(A'*A)\x gives the same solution
    % faster, but the numerics degrade more easily and without warning.
    
    % Check condition of calculation
    [lastmsg,lastID]=lastwarn;
    if strcmp(lastID,warnID)
        ord=ord-1;
    else
        done=true;
    end
    
end
warning(s0);                            % restore warning state

% -------------------------------- Notices --------------------------------

if ord < ordstart                       % if order was reduced
    disp(['Notice: LSSMOOTH order ORD was reduced from ' ...
          int2str(ordstart) ' to ' int2str(ord) ...
          ' for conditioning.'])
    disp('  ')
end

% Convert back to row vector if necessary
if row
    y=y.';
end
