From: Zachary Amsden <zach@vmware.com>
Subject: Re: [patch 14/21] Xen-paravirt: Add XEN config options
 and disable unsupported config options.
Date: Thu, 15 Feb 2007 22:15:27 -0800
Message-ID: <45D54BFF.80100@vmware.com>
References: <20070216022449.739760547@goop.org>
	<20070216022531.570154735@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070216022531.570154735@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Avi Kivity <avi@qumranet.com>, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> The XEN config option enables the Xen paravirt_ops interface, which is
> installed when the kernel finds itself running under Xen. (By some
> as-yet fully defined mechanism, implemented in a future patch.)
>
> Xen is no longer a sub-architecture, so the X86_XEN subarch config
> option has gone.
>
> The disabled config options are:
> - PREEMPT: Xen doesn't support it
> - HZ: set to 100Hz for now, to cut down on VCPU context switch rate.
>   This will be adapted to use tickless later.
> - kexec: not yet supported
>
> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
> Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
> Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
>   

We do support different HZ values, although 100HZ is actually preferable 
for us, so I don't object to that.  PREEMPT is supported by us, but not 
as tested as I would like, so I also don't object to dropping it for 
generic paravirt guests - Rusty - Avi any objections to dropping preempt 
in terms of lguest/KVM paravirtualization?

Paravirt-ops definitely needs a hook for kexec, although we should not 
disable kexec for the natively booted paravirt-ops.  Eric - is there a 
way to disable it at runtime?

We do support the doublefault task gate, and it would be good to keep 
it, but I can't complain so much if it is gone from generic paravirt 
kernels for now, because it is non-essential, and generally fatal 
anyway.  We do need it for native boots of paravirt-ops kernels, 
however, so turning off the config option still needs to be revisited.

Zach
