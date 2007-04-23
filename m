From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 00/25] xen: Xen implementation for paravirt_ops
Date: Tue, 24 Apr 2007 00:50:06 +0200
Message-ID: <200704240050.06615.ak@suse.de>
References: <20070423215638.563901986@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754433AbXDWWuN@vger.kernel.org>
In-Reply-To: <20070423215638.563901986@goop.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Monday 23 April 2007 23:56:38 Jeremy Fitzhardinge wrote:
> Hi Andi,
> 
> It applies to 2.6.21-rc7 + your patches + the last batch of pv_ops
> patches 

I got most of those except for the broken sched_clock change.

> I posted. 

How much testing outside Jeremylabs has it gotten? Some beta
testing before merging would be good, otherwise we'll just have
a flood of fixes shortly when it is exposed to users.

> This patch generally restricts itself to Xen-specific parts of the tree,
> though it does make a few small changes elsewhere.

The general problem is that it is much more than just an architecture update.

> These patches include:
>  - some helper routines for allocating address space and walking pagetables

Needs review from mm people.

>  - Xen interface header files
>  - Core Xen implementation
>  - Efficient late-pinning/early-unpinning pagetable handling 

The number of new paravirt hooks makes me thing of renaming it to
everything_ops @|

>  - Virtualized time, including stolen time

Can you let it be reviewed by the time people? (Thomas, Ingo, John, Roman etc.)

>  - SMP support
>  - Preemption support
>  - Batched pagetable updates

>  - Xen console, based on hvc console
>  - Xenbus

That one would need to be reviewed first. It's so much code that I can't
do it all myself.

>  - Netfront, the paravirtualized network device

That one should go through the network device maintainer/netdev.

>  - Blockfront, the paravirtualized block device

And that needs a block device review and whoever maintains that (Jens?) 

-Andi
