From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Xen & VMI?
Date: Wed, 07 Mar 2007 12:15:54 +0100
Message-ID: <1173266155.24738.613.camel@localhost.localdomain>
References: <45ED82D9.6050204@codemonkey.ws>
	 <8FFF7E42E93CC646B632AB40643802A80229779B@scsmsx412.amr.corp.intel.com>
	 <20070306203712.GC21736@elte.hu>
	 <1173228246.4644.85.camel@localhost.localdomain>
	 <20070307081510.GB15111@elte.hu>  <45EE8315.3020800@vmware.com>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422726AbXCGLJt@vger.kernel.org>
In-Reply-To: <45EE8315.3020800@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Ingo Molnar <mingo@elte.hu>, Rusty Russell <rusty@rustcorp.com.au>, "Nakajima, Jun" <jun.nakajima@intel.com>, virtualization <virtualization@lists.osdl.org>, Roland McGrath <roland@redhat.com>, Anthony Liguori <anthony@codemonkey.ws>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@novell.com>, Daniel Hecht <dhecht@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-03-07 at 01:17 -0800, Zachary Amsden wrote:
> Ingo Molnar wrote:
> > For example, VMI_CALL_SetAlarm takes a 'cycles' argument. Cycles is a 
> > quite bad unit for an API, it should be absolute time, nanosec or 
> > picosec based instead. We could easily see CPUs that have /no concept of 
> >   
> 
> Actually, putting the unit in terms of cycles is more portable and 
> flexible.  Rather than perform a conversion from cycles to 
> nano/femto/pico seconds, the raw cycle count is exposed, along with the 
> current clock frequency.  This allows the timer infrastructure to merely 
> do one conversion, from cycles to real time, rather than converting to 
> an arbitrary time unit which may change with operating systems and time 
> and thus break the ABI.

Putting the unit in terms of cycles is just ugly. Virtual hardware
should provide the easiest interface and in case of time this _IS_
nanoseconds. 

nanoseconds is neither an arbitrary time unit nor will it change anytime
soon to femtoseconds. So your argument that the ABI might break is just
a strawman.

The cycles conversion gets ugly as hell, as you want to have absolute
time for your clock event reprogramming. This requires 128 bit math in
the reprogramming path for nothing and I'm not going to put it there.

Even worse on a Linux host we would convert ktime_t to some virtual
hardware clock on the guest side, feed it through paravirt to the host
and convert it back to ktime_t as the host uses an hrtimer to schedule
the next guest event.

The whole rush of paravirt ops leads to an arbitrary number of virtual
clock source and clock event devices instead of having one virtual
silicon with a sane design and a per hypervisor backend. Paravirtualized
kernels should provide _sane_ silicon emulations rather than dumping
more crap on the kernel developers by competing with the real silicon
vendors for the BDHA (Brain Damaged Hardware Award).

	tglx
