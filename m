From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] [RFC] virtio: Limit the retries on a virtio device reset
Date: Thu, 24 Aug 2017 13:07:46 +0200
Message-ID: <20170824130746.25f80368.cohuck@redhat.com>
References: <1503505982-29568-1-git-send-email-pmorel@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1503505982-29568-1-git-send-email-pmorel@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 23 Aug 2017 18:33:02 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> Reseting a device can sometime fail, even a virtual device.
> If the device is not reseted after a while the driver should
> abandon the retries.
> This is the change proposed for the modern virtio_pci.
> 
> More generally, when this happens,the virtio driver can set the
> VIRTIO_CONFIG_S_FAILED status flag to advertise the caller.
> 
> The virtio core can test if the reset was succesful by testing
> this flag after a reset.
> 
> This behavior is backward compatible with existing drivers.
> This behavior seems to me compatible with Virtio-1.0 specifications,
> Chapters 2.1 Device Status Field.
> There I definitively need your opinion: Is it right?

Will have to double check with the spec.

> 
> This patch also lead to another question:
> do we care if a device provided by the hypervisor is buggy?

Getting into a hang because of a broken device is not nice, but I'm not
sure we need to plan for this. Have you seen this in the wild?

> 
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> ---
>  drivers/virtio/virtio.c            |  4 ++++
>  drivers/virtio/virtio_pci_modern.c | 11 ++++++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 48230a5..6255dc4 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -324,6 +324,8 @@ int register_virtio_device(struct virtio_device *dev)
>  	/* We always start by resetting the device, in case a previous
>  	 * driver messed it up.  This also tests that code path a little. */
>  	dev->config->reset(dev);
> +	if (dev->config->get_status(dev) & VIRTIO_CONFIG_S_FAILED)
> +		return -EIO;
>  
>  	/* Acknowledge that we've seen the device. */
>  	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
> @@ -373,6 +375,8 @@ int virtio_device_restore(struct virtio_device *dev)
>  	/* We always start by resetting the device, in case a previous
>  	 * driver messed it up. */
>  	dev->config->reset(dev);
> +	if (dev->config->get_status(dev) & VIRTIO_CONFIG_S_FAILED)
> +		return -EIO;

virtio-ccw prior to rev 2 won't ever see this (as the read command did
not exist then), but this is not really a problem.

>  
>  	/* Acknowledge that we've seen the device. */
>  	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 2555d80..bfc5fc1 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -270,6 +270,7 @@ static void vp_set_status(struct virtio_device *vdev, u8 status)
>  static void vp_reset(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	int retry_count = 10;

When you're touching this anyway, it would be a good time to add an
extra blank line :)

>  	/* 0 status means a reset. */
>  	vp_iowrite8(0, &vp_dev->common->device_status);
>  	/* After writing 0 to device_status, the driver MUST wait for a read of
> @@ -277,8 +278,16 @@ static void vp_reset(struct virtio_device *vdev)
>  	 * This will flush out the status write, and flush in device writes,
>  	 * including MSI-X interrupts, if any.
>  	 */
> -	while (vp_ioread8(&vp_dev->common->device_status))
> +	while (vp_ioread8(&vp_dev->common->device_status) && retry_count--)
>  		msleep(1);
> +	/* If the read did not return 0 before the timeout consider that
> +	 * the device failed.
> +	 */
> +	if (retry_count <= 0) {
> +		virtio_add_status(vdev, VIRTIO_CONFIG_S_FAILED);
> +		return;
> +	}
> +	virtio_add_status(vdev, VIRTIO_CONFIG_S_ACKNOWLEDGE);

Adding ACK here seems wrong?

>  	/* Flush pending VQ/configuration callbacks. */
>  	vp_synchronize_vectors(vdev);
>  }
