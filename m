From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 1/3] virtio: add notify() callback to virtio_driver
Date: Thu, 21 Nov 2013 08:44:50 +0200
Message-ID: <20131121064450.GJ19005@redhat.com>
References: <1384960923-31463-1-git-send-email-graalfs@linux.vnet.ibm.com>
	<1384960923-31463-2-git-send-email-graalfs@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1384960923-31463-2-git-send-email-graalfs@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Cc: borntraeger@de.ibm.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 20, 2013 at 04:22:01PM +0100, Heinz Graalfs wrote:
> Add an optional notify() callback to virtio_driver. A backend
> driver can provide this callback to perform actions for a lost
> device.
> 
> notify() event values are inherited from virtio_ccw's notify()
> callback. We might want to support even more of them lateron.
> 
> notify() return values are defined in include/linux/notifier.h.
> 
> Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
> ---
>  drivers/virtio/virtio.c |  8 ++++++++
>  include/linux/virtio.h  | 10 ++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index ee59b74..a09abb4 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -186,6 +186,14 @@ void unregister_virtio_driver(struct virtio_driver *driver)
>  }
>  EXPORT_SYMBOL_GPL(unregister_virtio_driver);
>  
> +int notify_virtio_device(struct virtio_device *vdev, int event)
> +{
> +	struct virtio_driver *drv = drv_to_virtio(vdev->dev.driver);
> +
> +	return drv->notify ? drv->notify(vdev, event) : NOTIFY_DONE;

Also pls include linux/notifier.h for this value.

> +}
> +EXPORT_SYMBOL_GPL(notify_virtio_device);
> +
>  int register_virtio_device(struct virtio_device *dev)
>  {
>  	int err;
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index f15f6e7..da18e9a 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -110,6 +110,15 @@ int register_virtio_device(struct virtio_device *dev);
>  void unregister_virtio_device(struct virtio_device *dev);
>  
>  /**
> + * notify event values
> + * @VDEV_GONE: device gone
> + */
> +enum {
> +	VDEV_GONE		= 1,

Seems a bit short, can lead to namespace pollution.
Let's rename to VIRTIO_DEVICE_GONE ?

> +};
> +int notify_virtio_device(struct virtio_device *dev, int event);
> +
> +/**
>   * virtio_driver - operations for a virtio I/O driver
>   * @driver: underlying device driver (populate name and owner).
>   * @id_table: the ids serviced by this driver.
> @@ -129,6 +138,7 @@ struct virtio_driver {
>  	void (*scan)(struct virtio_device *dev);
>  	void (*remove)(struct virtio_device *dev);
>  	void (*config_changed)(struct virtio_device *dev);
> +	int (*notify)(struct virtio_device *dev, int event);
>  #ifdef CONFIG_PM
>  	int (*freeze)(struct virtio_device *dev);
>  	int (*restore)(struct virtio_device *dev);
> -- 
> 1.8.3.1
