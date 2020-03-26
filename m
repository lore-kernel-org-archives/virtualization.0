From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER
 to handle THP spilt issue
Date: Thu, 26 Mar 2020 05:49:51 -0400
Message-ID: <20200326054554-mutt-send-email-mst@kernel.org>
References: <20200326031817-mutt-send-email-mst@kernel.org>
 <C4C6BAF7-C040-403D-997C-48C7AB5A7D6B@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <C4C6BAF7-C040-403D-997C-48C7AB5A7D6B@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>
Cc: Hui Zhu <teawater@gmail.com>, jasowang@redhat.com, akpm@linux-foundation.org, pagupta@redhat.com, mojha@codeaurora.org, namit@vmware.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, Hui Zhu <teawaterz@linux.alibaba.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 26, 2020 at 08:54:04AM +0100, David Hildenbrand wrote:
> 
> 
> > Am 26.03.2020 um 08:21 schrieb Michael S. Tsirkin <mst@redhat.com>:
> > 
> > ﻿On Thu, Mar 12, 2020 at 09:51:25AM +0100, David Hildenbrand wrote:
> >>> On 12.03.20 09:47, Michael S. Tsirkin wrote:
> >>> On Thu, Mar 12, 2020 at 09:37:32AM +0100, David Hildenbrand wrote:
> >>>> 2. You are essentially stealing THPs in the guest. So the fastest
> >>>> mapping (THP in guest and host) is gone. The guest won't be able to make
> >>>> use of THP where it previously was able to. I can imagine this implies a
> >>>> performance degradation for some workloads. This needs a proper
> >>>> performance evaluation.
> >>> 
> >>> I think the problem is more with the alloc_pages API.
> >>> That gives you exactly the given order, and if there's
> >>> a larger chunk available, it will split it up.
> >>> 
> >>> But for balloon - I suspect lots of other users,
> >>> we do not want to stress the system but if a large
> >>> chunk is available anyway, then we could handle
> >>> that more optimally by getting it all in one go.
> >>> 
> >>> 
> >>> So if we want to address this, IMHO this calls for a new API.
> >>> Along the lines of
> >>> 
> >>>    struct page *alloc_page_range(gfp_t gfp, unsigned int min_order,
> >>>                    unsigned int max_order, unsigned int *order)
> >>> 
> >>> the idea would then be to return at a number of pages in the given
> >>> range.
> >>> 
> >>> What do you think? Want to try implementing that?
> >> 
> >> You can just start with the highest order and decrement the order until
> >> your allocation succeeds using alloc_pages(), which would be enough for
> >> a first version. At least I don't see the immediate need for a new
> >> kernel API.
> > 
> > OK I remember now.  The problem is with reclaim. Unless reclaim is
> > completely disabled, any of these calls can sleep. After it wakes up,
> > we would like to get the larger order that has become available
> > meanwhile.
> > 
> 
> Yes, but that‘s a pure optimization IMHO.
> So I think we should do a trivial implementation first and then see what we gain from a new allocator API. Then we might also be able to justify it using real numbers.
> 

Well how do you propose implement the necessary semantics?
I think we are both agreed that alloc_page_range is more or
less what's necessary anyway - so how would you approximate it
on top of existing APIs?


> > 
> >> -- 
> >> Thanks,
> >> 
> >> David / dhildenb
> > 
