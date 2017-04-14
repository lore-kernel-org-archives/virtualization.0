From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v9 3/5] mm: function to offer a page block on the free list
Date: Fri, 14 Apr 2017 10:30:27 +0800
Message-ID: <58F03443.9040202__16459.688373334$1492136944$gmane$org@intel.com>
References: <1492076108-117229-1-git-send-email-wei.w.wang@intel.com>	<1492076108-117229-4-git-send-email-wei.w.wang@intel.com>
	<20170413130217.2316b0394192d8677f5ddbdf@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170413130217.2316b0394192d8677f5ddbdf@linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org, amit.shah@redhat.com, liliang.opensource@gmail.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, cornelia.huck@de.ibm.com, pbonzini@redhat.com, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 04/14/2017 04:02 AM, Andrew Morton wrote:
> On Thu, 13 Apr 2017 17:35:06 +0800 Wei Wang <wei.w.wang@intel.com> wrote:
>
>> Add a function to find a page block on the free list specified by the
>> caller. Pages from the page block may be used immediately after the
>> function returns. The caller is responsible for detecting or preventing
>> the use of such pages.
>>
>> ...
>>
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -4498,6 +4498,93 @@ void show_free_areas(unsigned int filter)
>>   	show_swap_cache_info();
>>   }
>>   
>> +/**
>> + * Heuristically get a page block in the system that is unused.
>> + * It is possible that pages from the page block are used immediately after
>> + * inquire_unused_page_block() returns. It is the caller's responsibility
>> + * to either detect or prevent the use of such pages.
>> + *
>> + * The free list to check: zone->free_area[order].free_list[migratetype].
>> + *
>> + * If the caller supplied page block (i.e. **page) is on the free list, offer
>> + * the next page block on the list to the caller. Otherwise, offer the first
>> + * page block on the list.
>> + *
>> + * Return 0 when a page block is found on the caller specified free list.
>> + */
>> +int inquire_unused_page_block(struct zone *zone, unsigned int order,
>> +			      unsigned int migratetype, struct page **page)
>> +{
> Perhaps we can wrap this in the appropriate ifdef so the kernels which
> won't be using virtio-balloon don't carry the added overhead.
>
>

OK. What do you think if we add this:

#if defined(CONFIG_VIRTIO_BALLOON) || defined(CONFIG_VIRTIO_BALLOON_MODULE)



Best,
Wei
