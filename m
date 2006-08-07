From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/4] x86 paravirt_ops: implementation of paravirt_ops
Date: Mon, 07 Aug 2006 16:13:41 +1000
Message-ID: <1154931222.7642.21.camel@localhost.localdomain>
References: <1154925835.21647.29.camel@localhost.localdomain>
	 <1154925943.21647.32.camel@localhost.localdomain>
	 <1154926048.21647.35.camel@localhost.localdomain>
	 <200608070739.33428.ak@muc.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750819AbWHGGNp@vger.kernel.org>
In-Reply-To: <200608070739.33428.ak@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@muc.de>
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2006-08-07 at 07:39 +0200, Andi Kleen wrote:
> On Monday 07 August 2006 06:47, Rusty Russell wrote:
> > This patch does the dumbest possible replacement of paravirtualized
> > instructions: calls through a "paravirt_ops" structure.  Currently
> > these are function implementations of native hardware: hypervisors
> > will override the ops structure with their own variants.
> 
> You should call it HAL - that would make it clearer what it is.

People get visions of grandeur when HAL is mentioned: they think it'll
abstract everything.  I really only want to do the minimum needed for
the hypervisors we have on the table today.

Maybe one day it will abstract everything, then we can call it a HAL.
But I won't be doing that work 8)

> I think I would prefer to patch always. Is there a particular
> reason you can't do that?

We could patch all the indirect calls into direct calls, but I don't
think it's worth bothering: most simply don't matter.

The implementation ensures that someone can get boot on a new hypervisor
by populating the ops struct.  Later they can go back and implement the
patching stuff.

> It would be better to merge this with the existing LOCK prefix patching
> or perhaps the normal alternative() patcher (is there any particular
> reason you can't use it?)
> 
> Three alternative patching mechanisms just seems to be too many

Each backend wants a different patch, so alternative() doesn't cut it.
We could look at generalizing alternative() I guess, but it works fine
so I didn't want to touch it.

Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law
