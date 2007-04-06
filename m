From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 18/20] clean up tsc-based sched_clock
Date: Fri, 6 Apr 2007 16:22:33 -0700
Message-ID: <20070406162233.b835bd4c.akpm@linux-foundation.org>
References: <20070404191151.009821039@goop.org>
	<20070404191206.476822257@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933404AbXDFXWj@vger.kernel.org>
In-Reply-To: <20070404191206.476822257@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 04 Apr 2007 12:12:09 -0700 Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Three cleanups:
>  - change "instable" -> "unstable"
>  - its better to use get_cpu_var for getting this cpu's variables
>  - change cycles_2_ns to do the full computation rather than just the
>    tsc->ns scaling.  Its a simpler interface, and it makes the function
>    more generally useful.
> 
> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
> 
> ---
>  arch/i386/kernel/sched-clock.c |   35 +++++++++++++++++++++--------------

I'm dropping the relevant patch from Andi's tree due to it causing
mysterious hangs when initscripts start ondemand.  So I'll need to drop
this patch and "[patch 19/20] Add a sched_clock paravirt_op".


I still need to work out why that hang is happening - it is very
mysterious.  I got as far as working out that it was hanging on
write_seqlock_irqsave(xtime_lock), then remembered that it's with
CONFIG_SMP=n so I stomped off to bed in disgust.  Later.
