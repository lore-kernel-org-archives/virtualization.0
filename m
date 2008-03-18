From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [Xen-devel] Re: Xen paravirt frontend block hang
Date: Tue, 18 Mar 2008 09:01:31 -0700
Message-ID: <47DFE75B.7080404__49114.6479537294$1205856487$gmane$org@goop.org>
References: <4772AC8E.7010007@theshore.net>
	<47C712EF.1060703@goop.org>	<47C9F818.4020200@theshore.net>
	<47CAC931.1000107@goop.org> <47CACFBE.5010007@theshore.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47CACFBE.5010007@theshore.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Christopher S. Aker" <caker@theshore.net>
Cc: xming <xmingske@gmail.com>, Xen-devel <xen-devel@lists.xensource.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Christopher S. Aker wrote:
> Jeremy Fitzhardinge wrote:
>> Are you running an SMP or UP domain?  I found I could get hangs very 
>> easily with UP (but I need confirm it isn't a result of some other 
>> very experimental patches).
>
> The hang occurs with both SMP and UP compiled pv_ops kernels.  SMP 
> kernels are still slightly responsive after the hang occurs, which 
> makes me think only one proc gets stuck at a time, not the entire kernel. 

The patch I posted yesterday - "xen: fix RMW when unmasking events" - 
should definitively fix the hanging-under-load bugs (I hope).  It 
problem came from returning to userspace with pending events, which 
would leave them hanging around on the vcpu unprocessed, and eventually 
everything would deadlock.  This was caused by using an unlocked 
read-modify-write operation on the event pending flag - which can be set 
by another (real) cpu - meaning that the pending event wasn't noticed 
until too late.  It would only be a problem on an SMP host.

The patch should back-apply to 2.6.24.

    J
