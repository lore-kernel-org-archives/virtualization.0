From: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH 2/9] Sched clock paravirt op fix.patch
Date: 13 Mar 2007 15:01:29 +0100
Message-ID: <20070313140129.GB92373@muc.de>
References: <200703020254.l222sOaM009656@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030298AbXCMOBd@vger.kernel.org>
Date: Tue, 13 Mar 2007 15:01:29 +0100
Content-Disposition: inline
In-Reply-To: <200703020254.l222sOaM009656@zach-dev.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Dan Hecht <dhecht@vmware.com>, Dan Arai <arai@vmware.com>, Andrew Morton <akpm@osdl.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Walker <dwalker@mvista.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 01, 2007 at 06:54:24PM -0800, Zachary Amsden wrote:
> The custom_sched_clock hook is broken.  The result from sched_clock needs to be
> in nanoseconds, not in CPU cycles.  The TSC is insufficient for this purpose,
> because TSC is poorly defined in a virtual environment, and mostly represents
> real world time instead of scheduled process time (which can be interrupted
> without notice when a virtual machine is descheduled).
> 
> To make the scheduler consistent, we must expose a different nature of time,
> that is scheduled time.  So deprecate this custom_sched_clock hack and turn it
> into a paravirt-op, as it should have been all along.  This allows the tsc.c
> code which converts cycles to nanoseconds to be shared by all paravirt-ops
> backends.
> 
> It is unfortunate to add a new paravirt-op, but this is a very distinct
> abstraction which is clearly different for all virtual machine implementations,
> and it gets rid of an ugly indirect function which I ashamedly admit I hacked
> in to try to get this to work earlier, and then even got in the wrong units.
> 
> Please apply.

I think it's better to remove this completely and not allow paravirt
to hook into sched_clock.  After all a hypervisor stealing time is no
different from interrupts stealing time and we don't try to handle
that either. 

I will remove the custom hook.

-Andi
