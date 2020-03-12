From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER to
 handle THP spilt issue
Date: Thu, 12 Mar 2020 09:51:25 +0100
Message-ID: <45756694-560d-0276-d39e-cc2fd1c4e3a7@redhat.com>
References: <1583999395-9131-1-git-send-email-teawater@gmail.com>
 <3e1373f4-6ade-c651-ddde-6f04e78382f9@redhat.com>
 <20200312043859-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200312043859-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Hui Zhu <teawater@gmail.com>, jasowang@redhat.com, akpm@linux-foundation.org, pagupta@redhat.com, mojha@codeaurora.org, namit@vmware.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, Hui Zhu <teawaterz@linux.alibaba.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On 12.03.20 09:47, Michael S. Tsirkin wrote:
> On Thu, Mar 12, 2020 at 09:37:32AM +0100, David Hildenbrand wrote:
>> 2. You are essentially stealing THPs in the guest. So the fastest
>> mapping (THP in guest and host) is gone. The guest won't be able to make
>> use of THP where it previously was able to. I can imagine this implies a
>> performance degradation for some workloads. This needs a proper
>> performance evaluation.
> 
> I think the problem is more with the alloc_pages API.
> That gives you exactly the given order, and if there's
> a larger chunk available, it will split it up.
> 
> But for balloon - I suspect lots of other users,
> we do not want to stress the system but if a large
> chunk is available anyway, then we could handle
> that more optimally by getting it all in one go.
> 
> 
> So if we want to address this, IMHO this calls for a new API.
> Along the lines of
> 
> 	struct page *alloc_page_range(gfp_t gfp, unsigned int min_order,
> 					unsigned int max_order, unsigned int *order)
> 
> the idea would then be to return at a number of pages in the given
> range.
> 
> What do you think? Want to try implementing that?

You can just start with the highest order and decrement the order until
your allocation succeeds using alloc_pages(), which would be enough for
a first version. At least I don't see the immediate need for a new
kernel API.

-- 
Thanks,

David / dhildenb
