From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/4] x86 paravirt_ops: create no_paravirt.h for native
	ops
Date: Mon, 07 Aug 2006 16:03:37 +1000
Message-ID: <1154930617.7642.10.camel@localhost.localdomain>
References: <1154925835.21647.29.camel@localhost.localdomain>
	 <200608070730.17813.ak@muc.de>  <44D6D315.2030907@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751100AbWHGGDk@vger.kernel.org>
In-Reply-To: <44D6D315.2030907@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2006-08-06 at 22:43 -0700, Jeremy Fitzhardinge wrote:
> Andi Kleen wrote:
> >> +/* Stop speculative execution */
> >> +static inline void sync_core(void)
> >> +{
> >> +	unsigned int eax = 1, ebx, ecx, edx;
> >> +	__cpuid(&eax, &ebx, &ecx, &edx);
> >> +}
> >>     
> >
> > Actually I don't think this one should be para virtualized at all.
> > I don't see any reason at all why a hypervisor should trap it and it
> > is very time critical. I would recommend you move it back into the 
> > normal files without hooks.

I don't see where it's time-critical...

Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law
