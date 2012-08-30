From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] Add a page cache-backed balloon device driver.
Date: Thu, 30 Aug 2012 11:57:24 +0300
Message-ID: <20120830085724.GF10269@redhat.com>
References: <1340742778-11282-1-git-send-email-fes@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1340742778-11282-1-git-send-email-fes@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Frank Swiderski <fes@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, riel@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mikew@google.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 26, 2012 at 01:32:58PM -0700, Frank Swiderski wrote:
> +static void fill_balloon(struct virtio_balloon *vb, size_t num)
> +{
> +	int err;
> +
> +	/* We can only do one array worth at a time. */
> +	num = min(num, ARRAY_SIZE(vb->pfns));
> +
> +	for (vb->num_pfns = 0; vb->num_pfns < num; vb->num_pfns++) {
> +		struct page *page;
> +		unsigned long inode_pfn = find_available_inode_page(vb);
> +		/* Should always be able to find a page. */
> +		BUG_ON(!inode_pfn);
> +		page = read_mapping_page(the_inode.inode.i_mapping, inode_pfn,
> +					 NULL);
> +		if (IS_ERR(page)) {
> +			if (printk_ratelimit())
> +				dev_printk(KERN_INFO, &vb->vdev->dev,
> +					   "Out of puff! Can't get %zu pages\n",
> +					   num);
> +			break;
> +		}
> +
> +		/* Set the page to be dirty */
> +		set_page_dirty(page);
> +
> +		vb->pfns[vb->num_pfns] = page_to_pfn(page);
> +	}
> +
> +	/* Didn't get any?  Oh well. */
> +	if (vb->num_pfns == 0)
> +		return;

Went to look at this driver, and noticed caller will re-invoke
this immediately if this triggers, so we busy-wait
re-trying this. When does read_mapping_page fail?
Is there any condition we could wait on?

-- 
MST
