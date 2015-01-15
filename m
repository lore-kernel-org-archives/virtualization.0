From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_pci_modern: validate features
Date: Thu, 15 Jan 2015 20:19:20 +0200
Message-ID: <20150115181920.GA30932@redhat.com>
References: <1421345588-30805-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1421345588-30805-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 15, 2015 at 08:13:44PM +0200, Michael S. Tsirkin wrote:
> Spec says devices must set VIRTIO_1 feature bit.
> Fail gracefully if they don't.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Oops, this is not needed: we already have this in finalize_features

        if (!__virtio_test_bit(vdev, VIRTIO_F_VERSION_1)) {
                dev_err(&vdev->dev, "virtio: device uses modern interface "
                        "but does not have VIRTIO_F_VERSION_1\n");
                return -EINVAL;
        }

Pls disregard this patch.


> ---
>  drivers/virtio/virtio_pci_modern.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 17f0228..a8fd267 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -570,6 +570,7 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
>  	int err, common, isr, notify, device;
>  	u32 notify_length;
>  	u32 notify_offset;
> +	u64 features;
>  
>  	check_offsets();
>  
> @@ -676,12 +677,19 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
>  		vp_dev->vdev.config = &virtio_pci_config_nodev_ops;
>  	}
>  
> +	features = vp_get_features(vdev);
> +	if (!features & (1ULL << VIRTIO_F_VERSION_1))
> +		goto err_valid_features;
> +
>  	vp_dev->config_vector = vp_config_vector;
>  	vp_dev->setup_vq = setup_vq;
>  	vp_dev->del_vq = del_vq;
>  
>  	return 0;
>  
> +err_valid_features:
> +	if (vp_dev->device)
> +		pci_iounmap(pci_dev, vp_dev->device);
>  err_map_device:
>  	if (vp_dev->notify_base)
>  		pci_iounmap(pci_dev, vp_dev->notify_base);
> -- 
> MST
