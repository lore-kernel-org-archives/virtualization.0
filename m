From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 00/25] xen: Xen implementation for paravirt_ops
Date: Mon, 23 Apr 2007 16:09:19 -0700
Message-ID: <462D3C9F.2030402@goop.org>
References: <20070423215638.563901986@goop.org> <200704240050.06615.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200704240050.06615.ak@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> On Monday 23 April 2007 23:56:38 Jeremy Fitzhardinge wrote:
>   
>> Hi Andi,
>>
>> It applies to 2.6.21-rc7 + your patches + the last batch of pv_ops
>> patches 
>>     
>
> I got most of those except for the broken sched_clock change.
>   

Er, we had a bit of back-and-forward with that.  How did that end up?

>> I posted. 
>>     
>
> How much testing outside Jeremylabs has it gotten? Some beta
> testing before merging would be good, otherwise we'll just have
> a flood of fixes shortly when it is exposed to users.
>   

Yes.  I'm just prepping a tree for xen-devel, and I primed people at the
Xen Summit last week.

>> This patch generally restricts itself to Xen-specific parts of the tree,
>> though it does make a few small changes elsewhere.
>>     
>
> The general problem is that it is much more than just an architecture update.
>
>   
>> These patches include:
>>  - some helper routines for allocating address space and walking pagetables
>>     
>
> Needs review from mm people.
>   

These have been pretty well looked at already.  They have been posted
repeatedly, and I think all the comments have been sorted out. 
alloc_vm_area() will be a bit affected by Andrew's -mm patch to make
vmalloc_sync_all a globally-visible arch export, but they merge nicely.

>>  - Xen interface header files
>>  - Core Xen implementation
>>  - Efficient late-pinning/early-unpinning pagetable handling 
>>     
>
> The number of new paravirt hooks makes me thing of renaming it to
> everything_ops @|
>   

There's only one new op in this series, and I couldn't work out a way to
avoid it, other than putting a #ifdef CONFIG_XEN in kernel/setup.c.  The
last patch posting didn't add any new hooks.  Which ones are you
referring to?

>>  - Virtualized time, including stolen time
>>     
>
> Can you let it be reviewed by the time people? (Thomas, Ingo, John, Roman etc.)
>   

Thomas has looked at and generally approves of the Xen clocksource/event
code.  The stolen time code is really only used to generate a few
numbers in /proc, and so has very little direct impact on the rest of
the kernel, and hasn't really attracted much interest as a result.  I've
posted the patch to implement sched_clock in terms of unstolen time to
the various time people repeatedly, and nobody has responded, so I guess
it doesn't irritate anyone too much; it would be nice to have some
definite feedback though.

>>  - Xen console, based on hvc console
>>  - Xenbus
>>     
>
> That one would need to be reviewed first. It's so much code that I can't
> do it all myself.
>   

I put a specific plea for GregKH to look at this.

>>  - Netfront, the paravirtualized network device
>>     
>
> That one should go through the network device maintainer/netdev.
>   

Stephen Hemminger has looked at this in the past and we've addressed all
his comments so far.  But it would be nice to get some more net
developers to review this; it was cc:d to netdev.

>>  - Blockfront, the paravirtualized block device
>>     
>
> And that needs a block device review and whoever maintains that (Jens?) 
>   

He was cc:d.  I'll ask him specifically.

    J
