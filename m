From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RESEND PATCH v3 kernel 2/7] virtio-balloon: define new feature
	bit and page bitmap head
Date: Mon, 24 Oct 2016 09:51:19 -0700
Message-ID: <580E3C07.701@intel.com>
References: <1477031080-12616-1-git-send-email-liang.z.li@intel.com>
	<1477031080-12616-3-git-send-email-liang.z.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1477031080-12616-3-git-send-email-liang.z.li@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Liang Li <liang.z.li@intel.com>, mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, amit.shah@redhat.com, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, pbonzini@redhat.com, virtualization@lists.linux-foundation.org, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 10/20/2016 11:24 PM, Liang Li wrote:
> Add a new feature which supports sending the page information with
> a bitmap. The current implementation uses PFNs array, which is not
> very efficient. Using bitmap can improve the performance of
> inflating/deflating significantly

Why is it not efficient?  How is using a bitmap more efficient?  What
kinds of cases is the bitmap inefficient?

> The page bitmap header will used to tell the host some information
> about the page bitmap. e.g. the page size, page bitmap length and
> start pfn.

Why did you choose to add these features to the structure?  What
benefits do they add?

Could you describe your solution a bit here, and describe its strengths
and weaknesses?

The same comments apply, even if (especially if) you change the data
structure.

> Signed-off-by: Liang Li <liang.z.li@intel.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> Cc: Amit Shah <amit.shah@redhat.com>
> ---
>  include/uapi/linux/virtio_balloon.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index 343d7dd..d3b182a 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -34,6 +34,7 @@
>  #define VIRTIO_BALLOON_F_MUST_TELL_HOST	0 /* Tell before reclaiming pages */
>  #define VIRTIO_BALLOON_F_STATS_VQ	1 /* Memory Stats virtqueue */
>  #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
> +#define VIRTIO_BALLOON_F_PAGE_BITMAP	3 /* Send page info with bitmap */
>  
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
> @@ -82,4 +83,22 @@ struct virtio_balloon_stat {
>  	__virtio64 val;
>  } __attribute__((packed));
>  
> +/* Page bitmap header structure */
> +struct balloon_bmap_hdr {
> +	/* Used to distinguish different request */
> +	__virtio16 cmd;
> +	/* Shift width of page in the bitmap */
> +	__virtio16 page_shift;
> +	/* flag used to identify different status */
> +	__virtio16 flag;
> +	/* Reserved */
> +	__virtio16 reserved;
> +	/* ID of the request */
> +	__virtio64 req_id;
> +	/* The pfn of 0 bit in the bitmap */
> +	__virtio64 start_pfn;
> +	/* The length of the bitmap, in bytes */
> +	__virtio64 bmap_len;
> +};

FWIW this is totally unreadable.  Please do something like this:

> +struct balloon_bmap_hdr {
> +	__virtio16 cmd; 	/* Used to distinguish different ...
> +	__virtio16 page_shift; 	/* Shift width of page in the bitmap */
> +	__virtio16 flag; 	/* flag used to identify different...
> +	__virtio16 reserved;	/* Reserved */
> +	__virtio64 req_id;	/* ID of the request */
> +	__virtio64 start_pfn;	/* The pfn of 0 bit in the bitmap */
> +	__virtio64 bmap_len;	/* The length of the bitmap, in bytes */
> +};

and please make an effort to add useful comments.  "/* Reserved */"
seems like a waste of bytes to me.
