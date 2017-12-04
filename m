From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v18 07/10] virtio-balloon: VIRTIO_BALLOON_F_SG
Date: Mon, 04 Dec 2017 11:46:46 +0800
Message-ID: <5A24C526.2060400__29294.3821092651$1512359099$gmane$org@intel.com>
References: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com>
	<1511963726-34070-8-git-send-email-wei.w.wang@intel.com>
	<20171201171746-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171201171746-mutt-send-email-mst@kernel.org>
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

On 12/01/2017 11:38 PM, Michael S. Tsirkin wrote:
> On Wed, Nov 29, 2017 at 09:55:23PM +0800, Wei Wang wrote:
>> +static void send_one_desc(struct virtio_balloon *vb,
>> +			  struct virtqueue *vq,
>> +			  uint64_t addr,
>> +			  uint32_t len,
>> +			  bool inbuf,
>> +			  bool batch)
>> +{
>> +	int err;
>> +	unsigned int size;
>> +
>> +	/* Detach all the used buffers from the vq */
>> +	while (virtqueue_get_buf(vq, &size))
>> +		;
>> +
>> +	err = virtqueue_add_one_desc(vq, addr, len, inbuf, vq);
>> +	/*
>> +	 * This is expected to never fail: there is always at least 1 entry
>> +	 * available on the vq, because when the vq is full the worker thread
>> +	 * that adds the desc will be put into sleep until at least 1 entry is
>> +	 * available to use.
>> +	 */
>> +	BUG_ON(err);
>> +
>> +	/* If batching is requested, we batch till the vq is full */
>> +	if (!batch || !vq->num_free)
>> +		kick_and_wait(vq, vb->acked);
>> +}
>> +
> This internal kick complicates callers. I suggest that instead,
> you move this to callers, just return a "kick required" boolean.
> This way callers do not need to play with num_free at all.

Then in what situation would the function return true of "kick required"?

I think this wouldn't make a difference fundamentally. For example, we 
have 257 sgs (batching size=256) to send to host:

while (i < 257) {
     kick_required = send_sgs();
     if (kick_required)
         kick(); // After the 256 sgs have been added, the caller 
performs a kick().
}

Do we still need a kick here for the 257th sg as before? Only the caller 
knows if the last added sgs need a kick (when the send_sgs receives one 
sg, it doesn't know if there are more to come).

There is another approach to checking if the last added sgs haven't been 
sync-ed to the host: expose "vring_virtqueue->num_added" to the caller 
via a virtio_ring API:

     unsigned int virtqueue_num_added(struct virtqueue *_vq)
    {
         struct vring_virtqueue *vq = to_vvq(_vq);

         return vq->num_added;
   }



>> +/*
>> + * Send balloon pages in sgs to host. The balloon pages are recorded in the
>> + * page xbitmap. Each bit in the bitmap corresponds to a page of PAGE_SIZE.
>> + * The page xbitmap is searched for continuous "1" bits, which correspond
>> + * to continuous pages, to chunk into sgs.
>> + *
>> + * @page_xb_start and @page_xb_end form the range of bits in the xbitmap that
>> + * need to be searched.
>> + */
>> +static void tell_host_sgs(struct virtio_balloon *vb,
>> +			  struct virtqueue *vq,
>> +			  unsigned long page_xb_start,
>> +			  unsigned long page_xb_end)
>> +{
>> +	unsigned long pfn_start, pfn_end;
>> +	uint64_t addr;
>> +	uint32_t len, max_len = round_down(UINT_MAX, PAGE_SIZE);
>> +
>> +	pfn_start = page_xb_start;
>> +	while (pfn_start < page_xb_end) {
>> +		pfn_start = xb_find_next_set_bit(&vb->page_xb, pfn_start,
>> +						 page_xb_end);
>> +		if (pfn_start == page_xb_end + 1)
>> +			break;
>> +		pfn_end = xb_find_next_zero_bit(&vb->page_xb,
>> +						pfn_start + 1,
>> +						page_xb_end);
>> +		addr = pfn_start << PAGE_SHIFT;
>> +		len = (pfn_end - pfn_start) << PAGE_SHIFT;
> This assugnment can overflow. Next line compares with UINT_MAX but by
> that time it is too late.  I think you should do all math in 64 bit to
> avoid surprises, then truncate to max_len and then it's safe to assign
> to sg.

Sounds reasonable, thanks.


>> +
>> +	xb_clear_bit_range(&vb->page_xb, page_xb_start, page_xb_end);
>> +}
>> +
>> +static inline int xb_set_page(struct virtio_balloon *vb,
>> +			       struct page *page,
>> +			       unsigned long *pfn_min,
>> +			       unsigned long *pfn_max)
>> +{
>> +	unsigned long pfn = page_to_pfn(page);
>> +	int ret;
>> +
>> +	*pfn_min = min(pfn, *pfn_min);
>> +	*pfn_max = max(pfn, *pfn_max);
>> +
>> +	do {
>> +		ret = xb_preload_and_set_bit(&vb->page_xb, pfn,
>> +					     GFP_NOWAIT | __GFP_NOWARN);
>> +	} while (unlikely(ret == -EAGAIN));
> what exactly does this loop do? Does this wait
> forever until there is some free memory? why GFP_NOWAIT?

Basically, "-EAGAIN" is returned from xb_set_bit() in the case when the 
pre-allocated per-cpu ida_bitmap is NULL. In that case, the caller 
re-invokes xb_preload_and_set_bit(), which re-invokes xb_preload to 
allocate ida_bitmap. So "-EAGAIN" actually does not indicate a status 
about memory allocation. "-ENOMEM" is the one to indicate the failure of 
memory allocation, but the loop doesn't re-try on "-ENOMEM".

GFP_NOWAIT is used to avoid memory reclaiming, which could cause the 
deadlock issue we discussed before.




>   	return num_freed_pages;
>   }
>   
> +/*
> + * The regular leak_balloon() with VIRTIO_BALLOON_F_SG needs memory allocation
> + * for xbitmap, which is not suitable for the oom case. This function does not
> + * use xbitmap to chunk pages, so it can be used by oom notifier to deflate
> + * pages when VIRTIO_BALLOON_F_SG is negotiated.
> + */
> I guess we can live with this for now.

Agree, the patchset has been big. We can get the basic implementation in 
first, and leave the following as future work. I can add it in the 
commit log.

> Two things to consider
> - adding support for pre-allocating indirect buffers
> - sorting the internal page queue (how?)


Best,
Wei
