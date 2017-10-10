From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v16 3/5] virtio-balloon: VIRTIO_BALLOON_F_SG
Date: Tue, 10 Oct 2017 15:28:58 +0800
Message-ID: <59DC76BA.7070202__42327.4546199993$1507620463$gmane$org@intel.com>
References: <1506744354-20979-1-git-send-email-wei.w.wang@intel.com>
	<1506744354-20979-4-git-send-email-wei.w.wang@intel.com>
	<20171009181612-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171009181612-mutt-send-email-mst@kernel.org>
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
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mawilcox@microsoft.com, qemu-devel@nongnu.org, amit.shah@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, willy@infradead.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, yang.zhang.wz@gmail.com, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mhocko@kernel.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 10/09/2017 11:20 PM, Michael S. Tsirkin wrote:
> On Sat, Sep 30, 2017 at 12:05:52PM +0800, Wei Wang wrote:
>> +static inline void xb_set_page(struct virtio_balloon *vb,
>> +			       struct page *page,
>> +			       unsigned long *pfn_min,
>> +			       unsigned long *pfn_max)
>> +{
>> +	unsigned long pfn = page_to_pfn(page);
>> +
>> +	*pfn_min = min(pfn, *pfn_min);
>> +	*pfn_max = max(pfn, *pfn_max);
>> +	xb_preload(GFP_KERNEL);
>> +	xb_set_bit(&vb->page_xb, pfn);
>> +	xb_preload_end();
>> +}
>> +
> So, this will allocate memory
>
> ...
>
>> @@ -198,9 +327,12 @@ static unsigned leak_balloon(struct virtio_balloon *vb, size_t num)
>>   	struct page *page;
>>   	struct balloon_dev_info *vb_dev_info = &vb->vb_dev_info;
>>   	LIST_HEAD(pages);
>> +	bool use_sg = virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_SG);
>> +	unsigned long pfn_max = 0, pfn_min = ULONG_MAX;
>>   
>> -	/* We can only do one array worth at a time. */
>> -	num = min(num, ARRAY_SIZE(vb->pfns));
>> +	/* Traditionally, we can only do one array worth at a time. */
>> +	if (!use_sg)
>> +		num = min(num, ARRAY_SIZE(vb->pfns));
>>   
>>   	mutex_lock(&vb->balloon_lock);
>>   	/* We can't release more pages than taken */
> And is sometimes called on OOM.
>
>
> I suspect we need to
>
> 1. keep around some memory for leak on oom
>
> 2. for non oom allocate outside locks
>
>

I think maybe we can optimize the existing balloon logic, which could 
remove the big balloon lock:

It would not be necessary to have the inflating and deflating run at the 
same time.
For example, 1st request to inflate 7G RAM, when 1GB has been given to 
the host (so 6G left), the
2nd request to deflate 5G is received. Instead of waiting for the 1st 
request to inflate 6G and then
continuing with the 2nd request to deflate 5G, we can do a diff (6G to 
inflate - 5G to deflate) immediately,
and got 1G to inflate. In this way, all that driver will do is to simply 
inflate another 1G.

Same for the OOM case: when OOM asks for 1G, while inflating 5G is in 
progress, then the driver can
deduct 1G from the amount that needs to inflate, and as a result, it 
will inflate 4G.

In this case, we will never have the inflating and deflating task run at 
the same time, so I think it is
possible to remove the lock, and therefore, we will not have that 
deadlock issue.

What would you guys think?

Best,
Wei
