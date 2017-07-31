From: ZhenweiPi <zhenwei.pi@youruncloud.com>
Subject: Re: [PATCH] mm: don't zero ballooned pages
Date: Mon, 31 Jul 2017 15:39:35 +0800
Message-ID: <7146526c-fb47-80c1-363b-319b01ea7eb1__16452.6228014894$1509078867$gmane$org@youruncloud.com>
References: <1501474413-21580-1-git-send-email-wei.w.wang@intel.com>
	<20170731065508.GE13036@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170731065508.GE13036@dhcp22.suse.cz>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Michal Hocko <mhocko@kernel.org>, Wei Wang <wei.w.wang@intel.com>
Cc: mst@redhat.com, mawilcox@microsoft.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

on qemu upstream, code in qemu/util/osdep.c

int qemu_madvise(void *addr, size_t len, int advice)

{

     if (advice == QEMU_MADV_INVALID) {

         errno = EINVAL;

         return -1;

     }

#if defined(CONFIG_MADVISE)

     return madvise(addr, len, advice);

#elif defined(CONFIG_POSIX_MADVISE)

     return posix_madvise(addr, len, advice);

#else

     errno = EINVAL;

     return -1;

#endif

}

Host OS maybe not support MADV_DONTNEED.
And madvise syscall uses more time.


On 07/31/2017 02:55 PM, Michal Hocko wrote:
> On Mon 31-07-17 12:13:33, Wei Wang wrote:
>> Ballooned pages will be marked as MADV_DONTNEED by the hypervisor and
>> shouldn't be given to the host ksmd to scan.
> Could you point me where this MADV_DONTNEED is done, please?
>
>> Therefore, it is not
>> necessary to zero ballooned pages, which is very time consuming when
>> the page amount is large. The ongoing fast balloon tests show that the
>> time to balloon 7G pages is increased from ~491ms to 2.8 seconds with
>> __GFP_ZERO added. So, this patch removes the flag.
> Please make it obvious that this is a revert of bb01b64cfab7
> ("mm/balloon_compaction.c: enqueue zero page to balloon device").
>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
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
>> -- 
>> 2.7.4
>>
