From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER to
 handle THP spilt issue
Date: Tue, 31 Mar 2020 16:29:02 +0200
Message-ID: <118bc13b-76b2-f5a1-6aca-65bd10a22f6c@redhat.com>
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
 <20200331101117-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200331101117-mutt-send-email-mst@kernel.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: pagupta@redhat.com, Alexander Duyck <alexander.h.duyck@linux.intel.com>, qemu-devel@nongnu.org, mojha@codeaurora.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, namit@vmware.com, Hui Zhu <teawaterz@linux.alibaba.com>, akpm@linux-foundation.org, Hui Zhu <teawater@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On 31.03.20 16:18, Michael S. Tsirkin wrote:
> On Tue, Mar 31, 2020 at 04:09:59PM +0200, David Hildenbrand wrote:
> 
> ...
> 
>>>>>>>>>>>>> So if we want to address this, IMHO this calls for a new API.
>>>>>>>>>>>>> Along the lines of
>>>>>>>>>>>>>
>>>>>>>>>>>>>    struct page *alloc_page_range(gfp_t gfp, unsigned int min_order,
>>>>>>>>>>>>>                    unsigned int max_order, unsigned int *order)
>>>>>>>>>>>>>
>>>>>>>>>>>>> the idea would then be to return at a number of pages in the given
>>>>>>>>>>>>> range.
>>>>>>>>>>>>>
>>>>>>>>>>>>> What do you think? Want to try implementing that?
> 
> ..
> 
>> I expect the whole "steal huge pages from your guest" to be problematic,
>> as I already mentioned to Alex. This needs a performance evaluation.
>>
>> This all smells like a lot of workload dependent fine-tuning. :)
> 
> 
> So that's why I proposed the API above.
> 
> The idea is that *if we are allocating a huge page anyway*,
> rather than break it up let's send it whole to the device.
> If we have smaller pages, return smaller pages.
> 

Sorry, I still fail to see why you cannot do that with my version of
balloon_pages_alloc(). But maybe I haven't understood the magic you
expect to happen in alloc_page_range() :)

It's just going via a different inflate queue once we have that page, as
I stated in front of my draft patch "but with an
optimized reporting interface".

> That seems like it would always be an improvement, whatever the
> workload.
> 

Don't think so. Assume there are plenty of 4k pages lying around. It
might actually be *bad* for guest performance if you take a huge page
instead of all the leftover 4k pages that cannot be merged. Only at the
point where you would want to break a bigger page up and report it in
pieces, where it would definitely make no difference.

I guess Hui Zhu now has something to look into/work on :)

-- 
Thanks,

David / dhildenb
