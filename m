From: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 2/2] virtio_balloon: fix race between migration and
	ballooning
Date: Sat, 9 Jan 2016 08:43:56 +0900
Message-ID: <20160108234356.GA10100__30752.7567180388$1452296670$gmane$org@blaptop.local>
References: <1451259313-26353-1-git-send-email-minchan@kernel.org>
	<1451259313-26353-2-git-send-email-minchan@kernel.org>
	<20160101102756-mutt-send-email-mst@redhat.com>
	<20160108195613.GK6808@t510.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160108195613.GK6808@t510.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rafael Aquini <aquini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Konstantin Khlebnikov <koct9i@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 08, 2016 at 02:56:14PM -0500, Rafael Aquini wrote:
> On Fri, Jan 01, 2016 at 11:36:13AM +0200, Michael S. Tsirkin wrote:
> > On Mon, Dec 28, 2015 at 08:35:13AM +0900, Minchan Kim wrote:
> > > In balloon_page_dequeue, pages_lock should cover the loop
> > > (ie, list_for_each_entry_safe). Otherwise, the cursor page could
> > > be isolated by compaction and then list_del by isolation could
> > > poison the page->lru.{prev,next} so the loop finally could
> > > access wrong address like this. This patch fixes the bug.
> > > 
> > > general protection fault: 0000 [#1] SMP
> > > Dumping ftrace buffer:
> > >    (ftrace buffer empty)
> > > Modules linked in:
> > > CPU: 2 PID: 82 Comm: vballoon Not tainted 4.4.0-rc5-mm1-access_bit+ #1906
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> > > task: ffff8800a7ff0000 ti: ffff8800a7fec000 task.ti: ffff8800a7fec000
> > > RIP: 0010:[<ffffffff8115e754>]  [<ffffffff8115e754>] balloon_page_dequeue+0x54/0x130
> > > RSP: 0018:ffff8800a7fefdc0  EFLAGS: 00010246
> > > RAX: ffff88013fff9a70 RBX: ffffea000056fe00 RCX: 0000000000002b7d
> > > RDX: ffff88013fff9a70 RSI: ffffea000056fe00 RDI: ffff88013fff9a68
> > > RBP: ffff8800a7fefde8 R08: ffffea000056fda0 R09: 0000000000000000
> > > R10: ffff8800a7fefd90 R11: 0000000000000001 R12: dead0000000000e0
> > > R13: ffffea000056fe20 R14: ffff880138809070 R15: ffff880138809060
> > > FS:  0000000000000000(0000) GS:ffff88013fc40000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> > > CR2: 00007f229c10e000 CR3: 00000000b8b53000 CR4: 00000000000006a0
> > > Stack:
> > >  0000000000000100 ffff880138809088 ffff880138809000 ffff880138809060
> > >  0000000000000046 ffff8800a7fefe28 ffffffff812c86d3 ffff880138809020
> > >  ffff880138809000 fffffffffff91900 0000000000000100 ffff880138809060
> > > Call Trace:
> > >  [<ffffffff812c86d3>] leak_balloon+0x93/0x1a0
> > >  [<ffffffff812c8bc7>] balloon+0x217/0x2a0
> > >  [<ffffffff8143739e>] ? __schedule+0x31e/0x8b0
> > >  [<ffffffff81078160>] ? abort_exclusive_wait+0xb0/0xb0
> > >  [<ffffffff812c89b0>] ? update_balloon_stats+0xf0/0xf0
> > >  [<ffffffff8105b6e9>] kthread+0xc9/0xe0
> > >  [<ffffffff8105b620>] ? kthread_park+0x60/0x60
> > >  [<ffffffff8143b4af>] ret_from_fork+0x3f/0x70
> > >  [<ffffffff8105b620>] ? kthread_park+0x60/0x60
> > > Code: 8d 60 e0 0f 84 af 00 00 00 48 8b 43 20 a8 01 75 3b 48 89 d8 f0 0f ba 28 00 72 10 48 8b 03 f6 c4 08 75 2f 48 89 df e8 8c 83 f9 ff <49> 8b 44 24 20 4d 8d 6c 24 20 48 83 e8 20 4d 39 f5 74 7a 4c 89
> > > RIP  [<ffffffff8115e754>] balloon_page_dequeue+0x54/0x130
> > >  RSP <ffff8800a7fefdc0>
> > > ---[ end trace 43cf28060d708d5f ]---
> > > Kernel panic - not syncing: Fatal exception
> > > Dumping ftrace buffer:
> > >    (ftrace buffer empty)
> > > Kernel Offset: disabled
> > > 
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > ---
> > >  mm/balloon_compaction.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> > > index d3116be5a00f..300117f1a08f 100644
> > > --- a/mm/balloon_compaction.c
> > > +++ b/mm/balloon_compaction.c
> > > @@ -61,6 +61,7 @@ struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_info)
> > >  	bool dequeued_page;
> > >  
> > >  	dequeued_page = false;
> > > +	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> > >  	list_for_each_entry_safe(page, tmp, &b_dev_info->pages, lru) {
> > >  		/*
> > >  		 * Block others from accessing the 'page' while we get around
> > > @@ -75,15 +76,14 @@ struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_info)
> > >  				continue;
> > >  			}
> > >  #endif
> > > -			spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> > >  			balloon_page_delete(page);
> > >  			__count_vm_event(BALLOON_DEFLATE);
> > > -			spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> > >  			unlock_page(page);
> > >  			dequeued_page = true;
> > >  			break;
> > >  		}
> > >  	}
> > > +	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> > >  
> > >  	if (!dequeued_page) {
> > >  		/*
> > 
> > I think this will cause deadlocks.
> > 
> > pages_lock now nests within page lock, balloon_page_putback
> > nests them in the reverse order.
> > 
> > Did you test this with lockdep? You really should for
> > locking changes, and I'd expect it to warn about this.
> > 
> > Also, there's another issue there I think: after isolation page could
> > also get freed before we try to lock it.
> > 
> > We really must take a page reference before touching
> > the page.
> > 
> > I think we need something like the below to fix this issue.
> > Could you please try this out, and send Tested-by?
> > I will repost as a proper patch if this works for you.
> >
> 
> Nice catch! Thanks for spotting it. I just have one minor nit. See
> below

Hmm, As I replied mst's mail, I really cannot understand what you
gouys are pointing out.

If we use lock_page in balloon_page_dequeue, I agree it's deadlock
but we used trylock_page so it's not a deadlock.

About the page refcount, we don't need take a page reference because
if one of page in the list was isolated for migration, the page
shouldn't stay in b_dev_info->pages list so balloon_page_dequeue
cannot touch the page.

Could you elaborate it more detail if I have missed something?
It's a stable patch so I want to be careful.

Thanks.

balloon_page_isolate
{
        trylock_page(page)
        spin_lock_irqsave(&b_dev_info->pages_lock)
        list_del(&page->lru);
}

balloon_page_dequeue
{
        spin_lock_irqsave(&b_dev_info->pages_lock)
        list_for_each_entry_safe(page, tmp, &b_dev_info->pages, lru) {
                trylock_page(page)
        }

}
