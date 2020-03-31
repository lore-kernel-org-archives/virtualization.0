From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER
 to handle THP spilt issue
Date: Tue, 31 Mar 2020 10:18:17 -0400
Message-ID: <20200331101117-mutt-send-email-mst@kernel.org>
References: <20200326031817-mutt-send-email-mst@kernel.org>
 <C4C6BAF7-C040-403D-997C-48C7AB5A7D6B@redhat.com>
 <20200326054554-mutt-send-email-mst@kernel.org>
 <f26dc94a-7296-90c9-56cd-4586b78bc03d@redhat.com>
 <20200331091718-mutt-send-email-mst@kernel.org>
 <02a393ce-c4b4-ede9-7671-76fa4c19097a@redhat.com>
 <20200331093300-mutt-send-email-mst@kernel.org>
 <b69796e0-fa41-a219-c3e5-a11e9f5f18bf@redhat.com>
 <20200331100359-mutt-send-email-mst@kernel.org>
 <85f699d4-459a-a319-0a8f-96c87d345c49@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <85f699d4-459a-a319-0a8f-96c87d345c49@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>
Cc: Hui Zhu <teawater@gmail.com>, jasowang@redhat.com, akpm@linux-foundation.org, pagupta@redhat.com, mojha@codeaurora.org, namit@vmware.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, Hui Zhu <teawaterz@linux.alibaba.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 31, 2020 at 04:09:59PM +0200, David Hildenbrand wrote:

...

> >>>>>>>>>>> So if we want to address this, IMHO this calls for a new API.
> >>>>>>>>>>> Along the lines of
> >>>>>>>>>>>
> >>>>>>>>>>>    struct page *alloc_page_range(gfp_t gfp, unsigned int min_order,
> >>>>>>>>>>>                    unsigned int max_order, unsigned int *order)
> >>>>>>>>>>>
> >>>>>>>>>>> the idea would then be to return at a number of pages in the given
> >>>>>>>>>>> range.
> >>>>>>>>>>>
> >>>>>>>>>>> What do you think? Want to try implementing that?

..

> I expect the whole "steal huge pages from your guest" to be problematic,
> as I already mentioned to Alex. This needs a performance evaluation.
> 
> This all smells like a lot of workload dependent fine-tuning. :)


So that's why I proposed the API above.

The idea is that *if we are allocating a huge page anyway*,
rather than break it up let's send it whole to the device.
If we have smaller pages, return smaller pages.

That seems like it would always be an improvement, whatever the
workload.

-- 
MST
