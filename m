From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Wed, 07 Mar 2007 08:48:36 +0100
Message-ID: <1173253716.24738.540.camel@localhost.localdomain>
References: <200703060654.l266sVxr014860@shell0.pdx.osdl.net>
	 <45ED16D2.3000202@vmware.com> <20070306084258.GA15745@elte.hu>
	 <20070306084647.GA16280@elte.hu>  <45ED2C82.3080008@vmware.com>
	 <1173178774.24738.311.camel@localhost.localdomain>
	 <45EDD82F.90204@vmware.com>
	 <1173225182.24738.507.camel@localhost.localdomain>
	 <45EE0A68.6010406@vmware.com>
	 <1173230571.24738.534.camel@localhost.localdomain>
	 <45EE190E.4060904@vmware.com>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161204AbXCGHmc@vger.kernel.org>
In-Reply-To: <45EE190E.4060904@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Hecht <dhecht@vmware.com>
Cc: Zachary Amsden <zach@vmware.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, ak@suse.de, Virtualization Mailing List <virtualization@lists.osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-03-06 at 17:44 -0800, Dan Hecht wrote:
> >>> 2) As I said above. The time accounting for virtualization needs to be
> >>> fixed in a generic way.
> >>>
> >>> I'm not going to accept some weird hackery for virtualization, which is
> >>> of exactly ZERO value for the kernel itself. Quite the contrary it will
> >>> make the cleanup harder and introduce another hard to remove thing,
> >>> which will in the worst case last for ever.
> >>>
> >> Okay, to confirm I'm on the same page as you, you want to move process 
> >> time accounting from being periodic sampled based to being trace based? 
> >> i.e. at the system-call/interrupt boundaries, read clocksource and 
> >> compute directly the amount of system/user/process time?
> > 
> > At least for the paravirt guests this is the correct approach. Once the
> > CPU vendors come up with a sane solution for a reliable and fast clock
> > source we might use that on real hardware as well.
> > 
> 
> I thought your preference was to not do things differently from real 
> hardware?  I guess this case you are okay with since you'd like to see 
> the real hardware case follow eventually?

Real hardware _IS_ broken and slow. If we add the facilities for
virtualization we want it in a way, which is usable by real hardware as
well.

> > Yes, with todays hardware it is simply a PITA. PowerPC has some basic
> > support for this though, IIRC.
> > 
> 
> I think S390 maybe too.

One more reason to make it a generic solution rather than some extra
hackery.

	tglx
