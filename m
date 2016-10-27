From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RESEND PATCH v3 kernel 6/7] virtio-balloon: define feature bit
	and head for misc virt queue
Date: Thu, 27 Oct 2016 21:29:38 +0300
Message-ID: <20161027211928-mutt-send-email-mst__2486.95619307018$1477593023$gmane$org@kernel.org>
References: <1477031080-12616-1-git-send-email-liang.z.li@intel.com>
	<1477031080-12616-7-git-send-email-liang.z.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1477031080-12616-7-git-send-email-liang.z.li@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Liang Li <liang.z.li@intel.com>
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, amit.shah@redhat.com, dave.hansen@intel.com, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, pbonzini@redhat.com, virtualization@lists.linux-foundation.org, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 21, 2016 at 02:24:39PM +0800, Liang Li wrote:
> Define a new feature bit which supports a new virtual queue. This
> new virtual qeuque is for information exchange between hypervisor
> and guest. The VMM hypervisor can make use of this virtual queue
> to request the guest do some operations, e.g. drop page cache,
> synchronize file system, etc.

Can we call this something more informative pls?
host request vq?

> And the VMM hypervisor can get some
> of guest's runtime information through this virtual queue, e.g. the
> guest's unused page information, which can be used for live migration
> optimization.

I guess the idea is that guest gets requests from host and
then responds to them on this vq. Pls document.

> 
> Signed-off-by: Liang Li <liang.z.li@intel.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> Cc: Amit Shah <amit.shah@redhat.com>
> ---
>  include/uapi/linux/virtio_balloon.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index d3b182a..3a9d633 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -35,6 +35,7 @@
>  #define VIRTIO_BALLOON_F_STATS_VQ	1 /* Memory Stats virtqueue */
>  #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
>  #define VIRTIO_BALLOON_F_PAGE_BITMAP	3 /* Send page info with bitmap */
> +#define VIRTIO_BALLOON_F_MISC_VQ	4 /* Misc info virtqueue */
>  
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
> @@ -101,4 +102,25 @@ struct balloon_bmap_hdr {
>  	__virtio64 bmap_len;
>  };
>  
> +enum balloon_req_id {
> +	/* Get unused pages information */

unused page information


> +	BALLOON_GET_UNUSED_PAGES,
> +};
> +
> +enum balloon_flag {
> +	/* Have more data for a request */
> +	BALLOON_FLAG_CONT,
> +	/* No more data for a request */
> +	BALLOON_FLAG_DONE,
> +};

is this a bit number or a value? Pls name consistently.

> +
> +struct balloon_req_hdr {
> +	/* Used to distinguish different request */

requests

> +	__virtio16 cmd;
> +	/* Reserved */
> +	__virtio16 reserved[3];
> +	/* Request parameter */
> +	__virtio64 param;
> +};
> +
>  #endif /* _LINUX_VIRTIO_BALLOON_H */


Prefix structs with virtio_ as well pls.
Also, wouldn't it simplify code if we use __le for new structs?

> -- 
> 1.8.3.1
