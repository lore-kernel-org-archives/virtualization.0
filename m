From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH kernel v5 5/5] virtio-balloon: tell host vm's unused page
	info
Date: Mon, 5 Dec 2016 09:22:25 -0800
Message-ID: <70ece7a5-348b-2eb9-c40a-f21b08df042c@intel.com>
References: <1480495397-23225-1-git-send-email-liang.z.li@intel.com>
	<1480495397-23225-6-git-send-email-liang.z.li@intel.com>
	<438dd41a-fdf1-2a77-ef9c-8c103f492b2f@intel.com>
	<F2CBF3009FA73547804AE4C663CAB28E3A12D814@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <F2CBF3009FA73547804AE4C663CAB28E3A12D814@shsmsx102.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Li, Liang Z" <liang.z.li@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mhocko@suse.com" <mhocko@suse.com>, Amit Shah <amit.shah@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 12/04/2016 05:13 AM, Li, Liang Z wrote:
>> On 11/30/2016 12:43 AM, Liang Li wrote:
>>> +static void send_unused_pages_info(struct virtio_balloon *vb,
>>> +				unsigned long req_id)
>>> +{
>>> +	struct scatterlist sg_in;
>>> +	unsigned long pos = 0;
>>> +	struct virtqueue *vq = vb->req_vq;
>>> +	struct virtio_balloon_resp_hdr *hdr = vb->resp_hdr;
>>> +	int ret, order;
>>> +
>>> +	mutex_lock(&vb->balloon_lock);
>>> +
>>> +	for (order = MAX_ORDER - 1; order >= 0; order--) {
>>
>> I scratched my head for a bit on this one.  Why are you walking over orders,
>> *then* zones.  I *think* you're doing it because you can efficiently fill the
>> bitmaps at a given order for all zones, then move to a new bitmap.  But, it
>> would be interesting to document this.
> 
> Yes, use the order is somewhat strange, but it's helpful to keep the API simple. 
> Do you think it's acceptable?

Yeah, it's fine.  Just comment it, please.

>>> +		if (ret == -ENOSPC) {
>>> +			void *new_resp_data;
>>> +
>>> +			new_resp_data = kmalloc(2 * vb->resp_buf_size,
>>> +						GFP_KERNEL);
>>> +			if (new_resp_data) {
>>> +				kfree(vb->resp_data);
>>> +				vb->resp_data = new_resp_data;
>>> +				vb->resp_buf_size *= 2;
>>
>> What happens to the data in ->resp_data at this point?  Doesn't this just
>> throw it away?
> 
> Yes, so we should make sure the data in resp_data is not inuse.

But doesn't it have valid data that we just collected and haven't told
the hypervisor about yet?  Aren't we throwing away good data that cost
us something to collect?

>> ...
>>> +struct page_info_item {
>>> +	__le64 start_pfn : 52; /* start pfn for the bitmap */
>>> +	__le64 page_shift : 6; /* page shift width, in bytes */

What does a page_shift "in bytes" mean? :)

>>> +	__le64 bmap_len : 6;  /* bitmap length, in bytes */ };
>>
>> Is 'bmap_len' too short?  a 64-byte buffer is a bit tiny.  Right?
> 
> Currently, we just use the 8 bytes and 0 bytes bitmap, should we support more than 64 bytes?

It just means that with this format, you end up wasting at least ~1/8th
of the space with metadata.  That's a bit unfortunate, but I guess it's
not fatal.

I'd definitely call it out in the patch description and make sure other
folks take a look at it.

There's a somewhat easy fix, but that would make the qemu implementation
more complicated: You could just have bmap_len==0x3f imply that there's
another field that contains an extended bitmap length for when you need
long bitmaps.

But, as you note, there's no need for it, so it's a matter of trading
the extra complexity versus the desire to not habing to change the ABI
again for longer (hopefully).

>>> +static int  mark_unused_pages(struct zone *zone,
>>> +		unsigned long *unused_pages, unsigned long size,
>>> +		int order, unsigned long *pos)
>>> +{
>>> +	unsigned long pfn, flags;
>>> +	unsigned int t;
>>> +	struct list_head *curr;
>>> +	struct page_info_item *info;
>>> +
>>> +	if (zone_is_empty(zone))
>>> +		return 0;
>>> +
>>> +	spin_lock_irqsave(&zone->lock, flags);
>>> +
>>> +	if (*pos + zone->free_area[order].nr_free > size)
>>> +		return -ENOSPC;
>>
>> Urg, so this won't partially fill?  So, what the nr_free pages limit where we no
>> longer fit in the kmalloc()'d buffer where this simply won't work?
> 
> Yes.  My initial implementation is partially fill, it's better for the worst case.
> I thought the above code is more efficient for most case ...
> Do you think partially fill the bitmap is better?

Could you please answer the question I asked?

Because if you don't get this right, it could mean that there are system
that simply *fail* here.
