From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv3 1/2] virtio: delete vq from list
Date: Sun, 26 Jul 2009 18:41:27 +0300
Message-ID: <20090726154127.GA21203__41104.9259514131$1248623025$gmane$org@redhat.com>
References: <cover.1248612107.git.mst@redhat.com>
	<20090726124801.GB20740@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090726124801.GB20740@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemonkey.ws>, kvm@vger.kernel.org, avi@redha
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Jul 26, 2009 at 03:48:01PM +0300, Michael S. Tsirkin wrote:
> This makes delete vq the reverse of find vq.
> This is required to make it possible to retry find_vqs
> after a failure, otherwise the list gets corrupted.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio_pci.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
> index 7e21389..2eaf1fb 100644
> --- a/drivers/virtio/virtio_pci.c
> +++ b/drivers/virtio/virtio_pci.c
> @@ -464,7 +464,11 @@ static void vp_del_vq(struct virtqueue *vq)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
>  	struct virtio_pci_vq_info *info = vq->priv;
> -	unsigned long size;
> +	unsigned long flags, size;
> +
> +        spin_lock_irqsave(&vp_dev->lock, flags);
> +        list_del(&info->node);
> +        spin_unlock_irqrestore(&vp_dev->lock, flags);

Grr, whitespace damage. Not sure how this got in, resending a corrected
patch. Sorry about the churn.

>  	iowrite16(info->queue_index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
>  
> -- 
> 1.6.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
