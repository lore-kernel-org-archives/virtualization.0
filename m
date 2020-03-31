From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER
 to handle THP spilt issue
Date: Tue, 31 Mar 2020 11:28:41 -0400
Message-ID: <20200331112730-mutt-send-email-mst@kernel.org>
References: <f26dc94a-7296-90c9-56cd-4586b78bc03d@redhat.com>
 <20200331091718-mutt-send-email-mst@kernel.org>
 <02a393ce-c4b4-ede9-7671-76fa4c19097a@redhat.com>
 <20200331093300-mutt-send-email-mst@kernel.org>
 <b69796e0-fa41-a219-c3e5-a11e9f5f18bf@redhat.com>
 <20200331100359-mutt-send-email-mst@kernel.org>
 <85f699d4-459a-a319-0a8f-96c87d345c49@redhat.com>
 <20200331101117-mutt-send-email-mst@kernel.org>
 <118bc13b-76b2-f5a1-6aca-65bd10a22f6c@redhat.com>
 <00dc8bad-05e5-6085-525c-ce9fded672cc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <00dc8bad-05e5-6085-525c-ce9fded672cc@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>
Cc: Hui Zhu <teawater@gmail.com>, jasowang@redhat.com, akpm@linux-foundation.org, pagupta@redhat.com, mojha@codeaurora.org, namit@vmware.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, Hui Zhu <teawaterz@linux.alibaba.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 31, 2020 at 04:34:48PM +0200, David Hildenbrand wrote:
> On 31.03.20 16:29, David Hildenbrand wrote:
> > On 31.03.20 16:18, Michael S. Tsirkin wrote:
> >> On Tue, Mar 31, 2020 at 04:09:59PM +0200, David Hildenbrand wrote:
> >>
> >> ...
> >>
> >>>>>>>>>>>>>> So if we want to address this, IMHO this calls for a new API.
> >>>>>>>>>>>>>> Along the lines of
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>    struct page *alloc_page_range(gfp_t gfp, unsigned int min_order,
> >>>>>>>>>>>>>>                    unsigned int max_order, unsigned int *order)
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> the idea would then be to return at a number of pages in the given
> >>>>>>>>>>>>>> range.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> What do you think? Want to try implementing that?
> >>
> >> ..
> >>
> >>> I expect the whole "steal huge pages from your guest" to be problematic,
> >>> as I already mentioned to Alex. This needs a performance evaluation.
> >>>
> >>> This all smells like a lot of workload dependent fine-tuning. :)
> >>
> >>
> >> So that's why I proposed the API above.
> >>
> >> The idea is that *if we are allocating a huge page anyway*,
> >> rather than break it up let's send it whole to the device.
> >> If we have smaller pages, return smaller pages.
> >>
> > 
> > Sorry, I still fail to see why you cannot do that with my version of
> > balloon_pages_alloc(). But maybe I haven't understood the magic you
> > expect to happen in alloc_page_range() :)
> > 
> > It's just going via a different inflate queue once we have that page, as
> > I stated in front of my draft patch "but with an
> > optimized reporting interface".
> > 
> >> That seems like it would always be an improvement, whatever the
> >> workload.
> >>
> > 
> > Don't think so. Assume there are plenty of 4k pages lying around. It
> > might actually be *bad* for guest performance if you take a huge page
> > instead of all the leftover 4k pages that cannot be merged. Only at the
> > point where you would want to break a bigger page up and report it in
> > pieces, where it would definitely make no difference.
> 
> I just understood what you mean :) and now it makes sense - it avoids
> exactly that. Basically
> 
> 1. Try to allocate order-0. No split necessary? return the page
> 2. Try to allocate order-1. No split necessary? return the page
> ...
> 
> up to MAX_ORDER - 1.
> 
> Yeah, I guess this will need a new kernel API.

Exactly what I meant. And whever we fail and block for reclaim, we
restart this.

> 
> -- 
> Thanks,
> 
> David / dhildenb
