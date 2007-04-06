From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 18/20] clean up tsc-based sched_clock
Date: Fri, 6 Apr 2007 16:45:36 -0700
Message-ID: <20070406164536.9d747160.akpm@linux-foundation.org>
References: <20070404191151.009821039@goop.org>
	<20070404191206.476822257@goop.org>
	<20070406162233.b835bd4c.akpm@linux-foundation.org>
	<4616D758.6020300@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933410AbXDFXpm@vger.kernel.org>
In-Reply-To: <4616D758.6020300@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 06 Apr 2007 16:27:20 -0700 Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> > I still need to work out why that hang is happening - it is very
> > mysterious.  I got as far as working out that it was hanging on
> > write_seqlock_irqsave(xtime_lock), then remembered that it's with
> > CONFIG_SMP=n so I stomped off to bed in disgust.  Later.
> >   
> 
> Hangs always, or just sometimes?  I haven't seen any problems with it.

100%.  On the Vaio, of course.  The kernel's canary.
