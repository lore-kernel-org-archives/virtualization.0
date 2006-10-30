From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/5] Skip timer works.patch
Date: Tue, 31 Oct 2006 00:50:51 +0100
Message-ID: <200610310050.51912.ak@suse.de>
References: <200610200009.k9K09MrS027558@zach-dev.vmware.com> <20061030231251.GB98768@muc.de> <454689C7.6030009@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422756AbWJ3XvA@vger.kernel.org>
In-Reply-To: <454689C7.6030009@vmware.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org


> It doesn't happen often, but it is a possibility that the kernel 
> calibrates the delay wrong because of timing glitches caused by CPU 
> migration, paging, or other phenomena which are supposed to be 
> transparent to the kernel (but cause temporal lapse).

We're supposed to handle those because they happen on real hardware
too with long running SMM handlers. Or at least there was a effort some time ago
to do this. If it wasn't enough we'll likely need to fix the code.

> In that case, the  
> kernel may not make enough progress in a spin delay loop to properly 
> reach the number of microseconds required for N number of timer ticks to 
> occur.  

Hmm, mdelay is polling RDTSC and assumes it makes forward progress
and waits until the time that was estimated at the original TSC<->PIT
calibration passed.  While there is a spin loop it is definitely 
polling a timer that is supposed to tick properly even in virtualization.

You're saying that doesn't work on vmware? Does it have trouble
with RDTSC?

Anyways if polling against TSC doesn't work I suppose we could
change it to poll against some other timer.
 
> In theory this can happen on a real machine, as SMM mode could 
> be active, doing USB device emulation or something that takes a while 
> during the lpj calibration and throwing the computation off.

Yep.

> By changing the parameters (N ticks at K Hz in T seconds), it is easy to 
> create an unstable measurement that can achieve high failure rates, 
> although in practice the Linux parameters appear to be reasonable enough 
> that it is not a major problem.

Hmm, why exactly? 

-Andi
