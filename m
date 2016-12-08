From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/2] virtio_ring: Do not call dma_map_page if sg is
	already mapped.
Date: Thu, 8 Dec 2016 18:46:23 +0200
Message-ID: <20161208184441-mutt-send-email-mst@kernel.org>
References: <1481180353-11139-1-git-send-email-jliang@xilinx.com>
	<1481180353-11139-2-git-send-email-jliang@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1481180353-11139-2-git-send-email-jliang@xilinx.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wendy Liang <wendy.liang@xilinx.com>
Cc: linux-remoteproc@vger.kernel.org, Wendy Liang <jliang@xilinx.com>, bjorn.andersson@linaro.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 07, 2016 at 10:59:12PM -0800, Wendy Liang wrote:
> If sg is already dma mapped, do not call dma_map_page() in
> vring_map_one_sg().
> 
> In case of rpmsg, rpmsg uses dma_alloc_coherent() to allocate
> memory to share with the remote. There is no pages setup
> in dma_alloc_coherent().
> 
> In this case, we cannot convert the virtual address back to the
> physical address. In this case, we can setup the sg_dma_addr to
> store the DMA address, and also mark the sg is already mapped.
> 
> In the vring, we can detect if the address is already mapped
> by checking the sg_dma_addr. If yes, do not call dma_map_page().
> 
> Signed-off-by: Wendy Liang <jliang@xilinx.com>
> ---
>  drivers/virtio/virtio_ring.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 489bfc6..9793e1f 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -180,6 +180,12 @@ static dma_addr_t vring_map_one_sg(const struct vring_virtqueue *vq,
>  	if (!vring_use_dma_api(vq->vq.vdev))
>  		return (dma_addr_t)sg_phys(sg);
>  
> +	/* If the sg is already mapped, return the DMA address */

How come we even reach this code for rpmsg?
Does vring_use_dma_api return true for rpmsg?

> +	if (sg_dma_address(sg)) {
> +		sg->length = sg_dma_len(sg);
> +		return sg_dma_address(sg);
> +	}
> +

Is there a rule that says 0 is not a valid address?

>  	/*
>  	 * We can't use dma_map_sg, because we don't use scatterlists in
>  	 * the way it expects (we don't guarantee that the scatterlist
> -- 
> 1.9.1
