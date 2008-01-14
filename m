From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] KVM virtio balloon driver
Date: Tue, 15 Jan 2008 10:32:08 +1100
Message-ID: <200801151032.09495.rusty@rustcorp.com.au>
References: <20080114200357.GA18354@dmt>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080114200357.GA18354@dmt>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 15 January 2008 07:03:57 Marcelo Tosatti wrote:
> Hi Rusty,
>
> It was agreed that the balloon driver should be merged through the
> virtio tree, so here it goes. It depends on the config_changed patch
> posted earlier.

Hi Marcelo,

    Excellent!  Although the main user will be kvm, it'd be nice to have a 
demonstration in-tree using lguest; any chance of you conjuring up an 
appropriate patch?

If not, I can whip something up.

> +config KVM_BALLOON
> +	tristate "KVM balloon driver (EXPERIMENTAL)"
> +	depends on VIRTIO_PCI
> +	---help---
> +	 This driver provides support for ballooning memory in/out of a
> +	 KVM paravirt guest.
> +
> +	 If unsure, say M.

Please don't define "balloon" in terms of "ballooning".  How about "This 
driver supports increasing and decreasing the amount of memory within a KVM 
guest." ?

> +	uint32_t target_nrpages;

I prefer u32 within the kernel, but no big deal.

> +static int send_balloon_buf(struct virtballoon *v, uint8_t cmd,
> +			    struct balloon_buf *buf)
> +{
> +	struct scatterlist sg[VIRTIO_MAX_SG];
> +	int err = 0;
> +
> +	buf->hdr.cmd = cmd;
> +
> +	sg_init_table(sg, VIRTIO_MAX_SG);
> +	sg_set_buf(&sg[0], &buf->hdr, sizeof(buf->hdr));
> +	sg_set_buf(&sg[1], &buf->data, sizeof(buf->data));

Since these are adjacent, can't you just combine them into one sg element?  Or 
does the kvm code rely on the sg as a boundary between header and data?

> +static int kvm_balloon_inflate(struct virtballoon *v, int32_t npages)
> +{
> +	LIST_HEAD(tmp_list);
> +	struct page *page, *tmp;
> +	struct balloon_buf *buf;
> +	u32 *pfn;
> +	int allocated = 0;
> +	int i, r = -ENOMEM;
> +
> +	buf = alloc_balloon_buf(v->vdev, GFP_KERNEL);
> +	if (!buf)
> +		return r;
> +
> +	pfn = (u32 *)&buf->data;
> +	*pfn++ = (u32)npages;

OK, this seems strange.  You always use the data portion as an array of u32s, 
yet you declare it as char[200].  You have a perfectly good header, but you 
put the number of pages in the first element of the data array: and you hand 
the entire data array even though you normally only use part of it.

You can intuit the number from the sg len, I suggest you do that instead.

Looking at this driver, I just don't think this needs to be so complicated: 
it's not a high speed device, after all.  Perhaps allocate one buffer up 
front, and just reuse that.  One simple thread loop, less locking needed.

> +	for (i = 0; i < npages; i++) {
> +		page = alloc_page(GFP_HIGHUSER | __GFP_NORETRY);
> +		if (!page)
> +			goto out_free;
> +		list_add(&page->lru, &tmp_list);
> +		allocated++;
> +		*pfn = page_to_pfn(page);
> +		pfn++;
> +	}

I think it might be simpler to defer adding to any list until after the 
callback is done?  Helpers to add an array to the balloon array (on 
successful inflate, or unsuccessful deflate) and to free them (unsuccessful 
inflate, or successful deflate) would also make the code more readable.

> +	gfns_per_buf = MAX_BALLOON_PAGES_PER_OP;
> +
> +	/*
> +	 * Call the balloon in PAGE_SIZE*pfns-per-buf
> +	 * iterations
> +	 */
> +	iterations = DIV_ROUND_UP(abspages, gfns_per_buf);
> +	dprintk(&v->vdev->dev, "%s: iterations=%d\n", __func__, iterations);
> +
> +	for (i = 0; i < iterations; i++) {

This logic seems overly complex.  How about in the main thread:

	/* We're woken when target changes, in config_changed() */
	if (wait_event_interruptible(&v->wq,
		(diff = atomic_read(&v->target_pages) - total_pages)) == 0) {

		/* If we submit inflate/deflate request, wait for it to finish. */
		if (xflate(v, diff) == 0)
			wait_for_completion(&v->complete);
	}

xflate just does as much as it can (up to "diff"), and then the interrupt 
handler adds/removes from the linked list, frees pages, etc and fires the 
completion.

No need for locking, since there's only one pending request at any time.

Cheers,
Rusty.
