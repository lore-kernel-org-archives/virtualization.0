From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v33 1/4] mm: add a function to get free page blocks
Date: Thu, 28 Jun 2018 16:39:30 +0800
Message-ID: <5B349EC2.80207__5220.20988069034$1530174808$gmane$org@intel.com>
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
	<1529037793-35521-2-git-send-email-wei.w.wang@intel.com>
	<CA+55aFzhuGKinEq5udPsk_uYHShkQxJYqcPO=tLCkT-oxpsgPg@mail.gmail.com>
	<20180626045118-mutt-send-email-mst@kernel.org>
	<CA+55aFwFpDPvfL=KPdabO-x1r0FnwpfPk5oN8+e01TKqAPNYbw@mail.gmail.com>
	<20180627220402-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180627220402-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, Rik van Riel <riel@redhat.com>, quan.xu0@gmail.com, KVM list <kvm@vger.kernel.org>, nilal@redhat.com, liliang.opensource@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, linux-mm <linux-mm@kvack.org>, Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 06/28/2018 03:07 AM, Michael S. Tsirkin wrote:
> On Wed, Jun 27, 2018 at 09:05:39AM -0700, Linus Torvalds wrote:
>> [ Sorry for slow reply, my travels have made a mess of my inbox ]
>>
>> On Mon, Jun 25, 2018 at 6:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>> Linus, do you think it would be ok to have get_from_free_page_list
>>> actually pop entries from the free list and use them as the buffer
>>> to store PAs?
>> Honestly, what I think the best option would be is to get rid of this
>> interface *entirely*, and just have the balloon code do
>>
>>      #define GFP_MINFLAGS (__GFP_NORETRY | __GFP_NOWARN |
>> __GFP_THISNODE | __GFP_NOMEMALLOC)
>>
>>      struct page *page =  alloc_pages(GFP_MINFLAGS, MAX_ORDER-1);
>>
>>   which is not a new interface, and simply removes the max-order page
>> from the list if at all possible.
>>
>> The above has the advantage of "just working", and not having any races.
>>
>> Now, because you don't want to necessarily *entirely* deplete the max
>> order, I'd suggest that the *one* new interface you add is just a "how
>> many max-order pages are there" interface. So then you can query
>> (either before or after getting the max-order page) just how many of
>> them there were and whether you want to give that page back.
>>
>> Notice? No need for any page lists or physical addresses. No races. No
>> complex new functions.
>>
>> The physical address you can just get from the "struct page" you got.
>>
>> And if you run out of memory because of getting a page, you get all
>> the usual "hey, we ran out of memory" responses..
>>
>> Wouldn't the above be sufficient?
>>
>>              Linus


Thanks for the elaboration.

> I think so, thanks!
>
> Wei, to put it in balloon terms, I think there's one thing we missed: if
> you do manage to allocate a page, and you don't have a use for it, then
> hey, you can just give it to the host because you know it's free - you
> are going to return it to the free list.
>

I'm not sure if this would be better than Linus' previous suggestion, 
because live migration is expected to be performed without disturbing 
the guest. If we do allocation to get all the free pages at all 
possible, then the guest applications would be seriously affected. For 
example, the network would become very slow as the allocation of sk_buf 
often triggers OOM during live migration. If live migration happens from 
time to time, and users try memory related tools like "free -h" on the 
guest, the reported statistics (e.g. the fee memory becomes very low 
abruptly due to the balloon allocation) would confuse them.

With the previous suggestion, we only get hints of the free pages (i.e. 
just report the address of free pages to host without taking them off 
the list).

Best,
Wei
