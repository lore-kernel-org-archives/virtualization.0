From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH RESEND] mm: don't zero ballooned pages
Date: Mon, 07 Aug 2017 17:35:32 +0800
Message-ID: <59883464.700__24954.9379376278$1502098426$gmane$org@intel.com>
References: <1501761557-9758-1-git-send-email-wei.w.wang@intel.com>
	<9ac31505-0996-2822-752e-8ec055373aa0@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <9ac31505-0996-2822-752e-8ec055373aa0@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtualization@lists.linux-foundation.org, mhocko@kernel.org, mst@redhat.com, zhenwei.pi@youruncloud.com
Cc: Andrea Arcangeli <aarcange@redhat.com>, dave.hansen@intel.com, akpm@linux-foundation.org, mawilcox@microsoft.com
List-Id: virtualization@lists.linuxfoundation.org

On 08/07/2017 04:44 PM, David Hildenbrand wrote:
> On 03.08.2017 13:59, Wei Wang wrote:
>> This patch is a revert of 'commit bb01b64cfab7 ("mm/balloon_compaction.c:
>> enqueue zero page to balloon device")'
>>
>> Ballooned pages will be marked as MADV_DONTNEED by the hypervisor and
>> shouldn't be given to the host ksmd to scan. Therefore, it is not
>> necessary to zero ballooned pages, which is very time consuming when
>> the page amount is large. The ongoing fast balloon tests show that the
>> time to balloon 7G pages is increased from ~491ms to 2.8 seconds with
>> __GFP_ZERO added. So, this patch removes the flag.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>   mm/balloon_compaction.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
>> index 9075aa5..b06d9fe 100644
>> --- a/mm/balloon_compaction.c
>> +++ b/mm/balloon_compaction.c
>> @@ -24,7 +24,7 @@ struct page *balloon_page_enqueue(struct balloon_dev_info *b_dev_info)
>>   {
>>   	unsigned long flags;
>>   	struct page *page = alloc_page(balloon_mapping_gfp_mask() |
>> -				__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_ZERO);
>> +				       __GFP_NOMEMALLOC | __GFP_NORETRY);
>>   	if (!page)
>>   		return NULL;
>>   
>>
> Your assumption here is, that the hypervisor will always supply a zero
> page. Unfortunately, this assumption is wrong (and it stems from the
> lack of different page size support in virtio-balloon).

I think this would be something that we can improve the balloon.

For example, the balloon request from the device should be aligned
to the host page size before sending to the guest driver:
On PPC, if the command requests for 140K memory to inflate, it can
be aligned to 128K.


>
> Think about these examples:
>
> 1. Guest is backed by huge pages (hugetbfs). Ballooning kicks in.
>
> MADV_DONTNEED is simply ignored in the hypervisor (hugetlbfs requires
> fallocate punshhole). Also, trying to zap 4k on e.g. 1MB pages will
> simply be ignored.

For the hugetlbfs case, I think the balloon size can be aligned to
the huge page size (i.e 2M or 1GB).


Best,
Wei
