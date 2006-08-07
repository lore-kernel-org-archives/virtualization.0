From: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH 1/4] x86 paravirt_ops: create no_paravirt.h for native ops
Date: Mon, 7 Aug 2006 08:16:03 +0200
Message-ID: <200608070816.03261.ak@muc.de>
References: <1154925835.21647.29.camel@localhost.localdomain> <44D6D315.2030907@goop.org> <1154930617.7642.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751111AbWHGGUp@vger.kernel.org>
In-Reply-To: <1154930617.7642.10.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: virtualization@lists.osdl.org
Cc: Rusty Russell <rusty@rustcorp.com.au>, Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

On Monday 07 August 2006 08:03, Rusty Russell wrote:
> On Sun, 2006-08-06 at 22:43 -0700, Jeremy Fitzhardinge wrote:
> > Andi Kleen wrote:
> > >> +/* Stop speculative execution */
> > >> +static inline void sync_core(void)
> > >> +{
> > >> +	unsigned int eax = 1, ebx, ecx, edx;
> > >> +	__cpuid(&eax, &ebx, &ecx, &edx);
> > >> +}
> > >>     
> > >
> > > Actually I don't think this one should be para virtualized at all.
> > > I don't see any reason at all why a hypervisor should trap it and it
> > > is very time critical. I would recommend you move it back into the 
> > > normal files without hooks.
> 
> I don't see where it's time-critical...

See explanation in my other email. Also in general we want this one fast.

-Andi
