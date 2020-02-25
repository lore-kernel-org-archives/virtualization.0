From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH RFC v4 12/13] mm/vmscan: Export drop_slab() and
 drop_slab_node()
Date: Tue, 25 Feb 2020 18:06:19 +0100
Message-ID: <20200225170619.GC32720@dhcp22.suse.cz>
References: <20191212171137.13872-1-david@redhat.com>
 <20191212171137.13872-13-david@redhat.com>
 <20200225145829.GW22443@dhcp22.suse.cz>
 <afdf8600-2339-6d74-5e3d-fa1a23384318@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <afdf8600-2339-6d74-5e3d-fa1a23384318@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue 25-02-20 16:09:29, David Hildenbrand wrote:
> On 25.02.20 15:58, Michal Hocko wrote:
> > On Thu 12-12-19 18:11:36, David Hildenbrand wrote:
> >> We already have a way to trigger reclaiming of all reclaimable slab objects
> >> from user space (echo 2 > /proc/sys/vm/drop_caches). Let's allow drivers
> >> to also trigger this when they really want to make progress and know what
> >> they are doing.
> > 
> > I cannot say I would be fan of this. This is a global action with user
> > visible performance impact. I am worried that we will find out that all
> > sorts of drivers have a very good idea that dropping slab caches is
> > going to help their problem whatever it is. We have seen the same patter
> > in the userspace already and that is the reason we are logging the usage
> > to the log and count invocations in the counter.
> 
> Yeah, I decided to hold back patch 11-13 for the v1 (which I am planning
> to post in March after more testing). What we really want is to make
> memory offlining an alloc_contig_range() work better with reclaimable
> objects.
> 
> > 
> >> virtio-mem wants to use these functions when it failed to unplug memory
> >> for quite some time (e.g., after 30 minutes). It will then try to
> >> free up reclaimable objects by dropping the slab caches every now and
> >> then (e.g., every 30 minutes) as long as necessary. There will be a way to
> >> disable this feature and info messages will be logged.
> >>
> >> In the future, we want to have a drop_slab_range() functionality
> >> instead. Memory offlining code has similar demands and also other
> >> alloc_contig_range() users (e.g., gigantic pages) could make good use of
> >> this feature. Adding it, however, requires more work/thought.
> > 
> > We already do have a memory_notify(MEM_GOING_OFFLINE) for that purpose
> > and slab allocator implements a callback (slab_mem_going_offline_callback).
> > The callback is quite dumb and it doesn't really try to free objects
> > from the given memory range or even try to drop active objects which
> > might turn out to be hard but this sounds like a more robust way to
> > achieve what you want.
> 
> Two things:
> 
> 1. memory_notify(MEM_GOING_OFFLINE) is called after trying to isolate
> the page range and checking if we only have movable pages. Won't help
> much I guess.

You are right, I have missed that. Can we reorder those two calls?

> 2. alloc_contig_range() won't benefit from that.

True.

> Something like drop_slab_range() would be better, and calling it from
> the right spots in the core (e.g., set_migratetype_isolate() see below).
> 
> Especially, have a look at mm/page_isolation.c:set_migratetype_isolate()
> 
> "FIXME: Now, memory hotplug doesn't call shrink_slab() by itself. We
> just check MOVABLE pages."

shrink_slab is really a large hammer for this purpose. The notifier
mechanism sounds more appropriate to me. If that means to move it
outside of its current position then let's try to experiment with that.
But there is a long route to have per pfn range reclaim.
-- 
Michal Hocko
SUSE Labs
