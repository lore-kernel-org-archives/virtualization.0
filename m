From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next v2 3/5] virtio_ring: add packed ring support
Date: Wed, 12 Sep 2018 12:22:22 -0400
Message-ID: <20180912121650-mutt-send-email-mst__46347.5445322276$1536769258$gmane$org@kernel.org>
References: <20180711022711.7090-1-tiwei.bie@intel.com>
	<20180711022711.7090-4-tiwei.bie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180711022711.7090-4-tiwei.bie@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: virtio-dev@lists.oasis-open.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 11, 2018 at 10:27:09AM +0800, Tiwei Bie wrote:
> This commit introduces the support (without EVENT_IDX) for
> packed ring.
> 
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
>  drivers/virtio/virtio_ring.c | 495 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 487 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index c4f8abc7445a..f317b485ba54 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -55,12 +55,21 @@
>  #define END_USE(vq)
>  #endif
>  
> +#define _VRING_DESC_F_AVAIL(b)	((__u16)(b) << 7)
> +#define _VRING_DESC_F_USED(b)	((__u16)(b) << 15)
> +
>  struct vring_desc_state {
>  	void *data;			/* Data for callback. */
>  	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
>  };
>  
>  struct vring_desc_state_packed {
> +	void *data;			/* Data for callback. */
> +	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
> +	int num;			/* Descriptor list length. */
> +	dma_addr_t addr;		/* Buffer DMA addr. */
> +	u32 len;			/* Buffer length. */
> +	u16 flags;			/* Descriptor flags. */
>  	int next;			/* The next desc state. */
>  };
>  

Idea: how about using data to chain these descriptors?
You can validate it's pointing within an array to distinguish
e.g. on detach.

-- 
MST
