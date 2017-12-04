From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v18 10/10] virtio-balloon: don't report free pages when
	page poisoning is enabled
Date: Mon, 04 Dec 2017 13:39:28 +0800
Message-ID: <5A24DF90.5070401__11486.6707161584$1512365858$gmane$org@intel.com>
References: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com>
	<1511963726-34070-11-git-send-email-wei.w.wang@intel.com>
	<20171201173951-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171201173951-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: yang.zhang.wz@gmail.com, kvm@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, aarcange@redhat.com, virtio-dev@lists.oasis-open.org, mawilcox@microsoft.com, willy@infradead.org, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com, cornelia.huck@de.ibm.com, mhocko@kernel.org, linux-kernel@vger.kernel.org, amit.shah@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 12/01/2017 11:49 PM, Michael S. Tsirkin wrote:
> On Wed, Nov 29, 2017 at 09:55:26PM +0800, Wei Wang wrote:
>> The guest free pages should not be discarded by the live migration thread
>> when page poisoning is enabled with PAGE_POISONING_NO_SANITY=n, because
>> skipping the transfer of such poisoned free pages will trigger false
>> positive when new pages are allocated and checked on the destination.
>> This patch skips the reporting of free pages in the above case.
>>
>> Reported-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> ---
>>   drivers/virtio/virtio_balloon.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
>> index 035bd3a..6ac4cff 100644
>> --- a/drivers/virtio/virtio_balloon.c
>> +++ b/drivers/virtio/virtio_balloon.c
>> @@ -652,7 +652,9 @@ static void report_free_page(struct work_struct *work)
>>   	/* Start by sending the obtained cmd id to the host with an outbuf */
>>   	send_one_desc(vb, vb->free_page_vq, virt_to_phys(&vb->start_cmd_id),
>>   		      sizeof(uint32_t), false, true, false);
>> -	walk_free_mem_block(vb, 0, &virtio_balloon_send_free_pages);
>> +	if (!(page_poisoning_enabled() &&
>> +	    !IS_ENABLED(CONFIG_PAGE_POISONING_NO_SANITY)))
>> +		walk_free_mem_block(vb, 0, &virtio_balloon_send_free_pages);
>>   	/*
>>   	 * End by sending the stop id to the host with an outbuf. Use the
>>   	 * non-batching mode here to trigger a kick after adding the stop id.
> PAGE_POISONING_ZERO is actually OK.

I think the 0-filled pages still need to be sent. If the host on the 
destination doesn't use PAGE_POISONING_ZERO, then the pages it offers to 
the guest on the destination may have non-0 values.



>
> But I really would prefer it that we still send pages to host,
> otherwise debugging becomes much harder.
>
> And it does not have to be completely useless, even though
> you can not discard them as they would be zero-filled then.
>
> How about a config field telling host what should be there in the free
> pages? This way even though host can not discard them, host can send
> them out without reading them, still a win.
>
>

OK, but I think we would need two 32-bit config registers:

__u32 page_poison_val; // stores the PAGE_POISON VALUE, but it couldn't 
indicate if page poisoning is in use

__u32 special_features; // set bit 0 to indicate page poisoning is in use

#define VIRTIO_BALLOON_SF_PAGE_POISON (1 << 0)


Best,
Wei
