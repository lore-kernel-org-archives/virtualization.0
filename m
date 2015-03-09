From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_mmio: generation support
Date: Mon, 9 Mar 2015 09:40:02 +0100
Message-ID: <20150309084002.GB22567@redhat.com>
References: <1425593244-18869-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1425593244-18869-1-git-send-email-mst@redhat.com>
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

On Thu, Mar 05, 2015 at 11:09:42PM +0100, Michael S. Tsirkin wrote:
> virtio_mmio currently lacks generation support which
> makes multi-byte field access racy.
> Fix by getting the value at offset 0xfc for version 2
> devices. Nothing we can do for version 1, so return
> generation id 0.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> Pawel, you mentioned you have a working virtio 1.0
> hypervisor, can you pls confirm this works correctly?

Same here - can you ack pls?

>  drivers/virtio/virtio_mmio.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 0375456..69b2e4d 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -237,6 +237,16 @@ static void vm_set(struct virtio_device *vdev, unsigned offset,
>  	}
>  }
>  
> +static u32 vm_generation(struct virtio_device *vdev)
> +{
> +	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> +
> +	if (vm_dev->version == 1)
> +		return 0;
> +	else
> +		return readl(vm_dev->base + VIRTIO_MMIO_CONFIG_GENERATION);
> +}
> +
>  static u8 vm_get_status(struct virtio_device *vdev)
>  {
>  	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> @@ -503,6 +513,8 @@ static const char *vm_bus_name(struct virtio_device *vdev)
>  static const struct virtio_config_ops virtio_mmio_config_ops = {
>  	.get		= vm_get,
>  	.set		= vm_set,
> +	.generation	= vm_generation,
> +	.get_status	= vm_get_status,
>  	.get_status	= vm_get_status,
>  	.set_status	= vm_set_status,
>  	.reset		= vm_reset,
> -- 
> MST
