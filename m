From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [PATCH kernel v5 5/5] virtio-balloon: tell host vm's unused
	page info
Date: Sun, 4 Dec 2016 13:13:23 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E3A12D814__23728.6894386218$1480857213$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <1480495397-23225-1-git-send-email-liang.z.li@intel.com>
	<1480495397-23225-6-git-send-email-liang.z.li@intel.com>
	<438dd41a-fdf1-2a77-ef9c-8c103f492b2f@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <438dd41a-fdf1-2a77-ef9c-8c103f492b2f@intel.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Hansen, Dave" <dave.hansen@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mhocko@suse.com" <mhocko@suse.com>, Amit Shah <amit.shah@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> On 11/30/2016 12:43 AM, Liang Li wrote:
> > +static void send_unused_pages_info(struct virtio_balloon *vb,
> > +				unsigned long req_id)
> > +{
> > +	struct scatterlist sg_in;
> > +	unsigned long pos = 0;
> > +	struct virtqueue *vq = vb->req_vq;
> > +	struct virtio_balloon_resp_hdr *hdr = vb->resp_hdr;
> > +	int ret, order;
> > +
> > +	mutex_lock(&vb->balloon_lock);
> > +
> > +	for (order = MAX_ORDER - 1; order >= 0; order--) {
> 
> I scratched my head for a bit on this one.  Why are you walking over orders,
> *then* zones.  I *think* you're doing it because you can efficiently fill the
> bitmaps at a given order for all zones, then move to a new bitmap.  But, it
> would be interesting to document this.
> 

Yes, use the order is somewhat strange, but it's helpful to keep the API simple. 
Do you think it's acceptable?

> > +		pos = 0;
> > +		ret = get_unused_pages(vb->resp_data,
> > +			 vb->resp_buf_size / sizeof(unsigned long),
> > +			 order, &pos);
> 
> FWIW, get_unsued_pages() is a pretty bad name.  "get" usually implies
> bumping reference counts or consuming something.  You're just "recording"
> or "marking" them.
> 

Will change to mark_unused_pages().

> > +		if (ret == -ENOSPC) {
> > +			void *new_resp_data;
> > +
> > +			new_resp_data = kmalloc(2 * vb->resp_buf_size,
> > +						GFP_KERNEL);
> > +			if (new_resp_data) {
> > +				kfree(vb->resp_data);
> > +				vb->resp_data = new_resp_data;
> > +				vb->resp_buf_size *= 2;
> 
> What happens to the data in ->resp_data at this point?  Doesn't this just
> throw it away?
> 

Yes, so we should make sure the data in resp_data is not inuse.

> ...
> > +struct page_info_item {
> > +	__le64 start_pfn : 52; /* start pfn for the bitmap */
> > +	__le64 page_shift : 6; /* page shift width, in bytes */
> > +	__le64 bmap_len : 6;  /* bitmap length, in bytes */ };
> 
> Is 'bmap_len' too short?  a 64-byte buffer is a bit tiny.  Right?
> 

Currently, we just use the 8 bytes and 0 bytes bitmap, should we support more than 64 bytes?

> > +static int  mark_unused_pages(struct zone *zone,
> > +		unsigned long *unused_pages, unsigned long size,
> > +		int order, unsigned long *pos)
> > +{
> > +	unsigned long pfn, flags;
> > +	unsigned int t;
> > +	struct list_head *curr;
> > +	struct page_info_item *info;
> > +
> > +	if (zone_is_empty(zone))
> > +		return 0;
> > +
> > +	spin_lock_irqsave(&zone->lock, flags);
> > +
> > +	if (*pos + zone->free_area[order].nr_free > size)
> > +		return -ENOSPC;
> 
> Urg, so this won't partially fill?  So, what the nr_free pages limit where we no
> longer fit in the kmalloc()'d buffer where this simply won't work?
> 

Yes.  My initial implementation is partially fill, it's better for the worst case.
I thought the above code is more efficient for most case ...
Do you think partially fill the bitmap is better?
 
> > +	for (t = 0; t < MIGRATE_TYPES; t++) {
> > +		list_for_each(curr, &zone->free_area[order].free_list[t]) {
> > +			pfn = page_to_pfn(list_entry(curr, struct page, lru));
> > +			info = (struct page_info_item *)(unused_pages +
> *pos);
> > +			info->start_pfn = pfn;
> > +			info->page_shift = order + PAGE_SHIFT;
> > +			*pos += 1;
> > +		}
> > +	}
> 
> Do we need to fill in ->bmap_len here?

For integrity, the bmap_len should be filled, will add.
Omit this step just because QEMU assume the ->bmp_len is 0 and ignore this field.

Thanks for your comment!

Liang
