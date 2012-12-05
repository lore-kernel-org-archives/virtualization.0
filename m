From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/3] virtio: add drv_to_virtio to make code clearly
Date: Wed, 5 Dec 2012 13:17:47 +0200
Message-ID: <20121205111747.GA10446@redhat.com>
References: <1354691009-25966-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<1354691009-25966-3-git-send-email-gaowanlong@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1354691009-25966-3-git-send-email-gaowanlong@cn.fujitsu.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 05, 2012 at 03:03:29PM +0800, Wanlong Gao wrote:
> Add drv_to_virtio wrapper to get virtio_driver from device_driver.
> 
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

IMHO a function would be slightly better.

> ---
>  drivers/virtio/virtio.c | 11 ++++-------
>  include/linux/virtio.h  |  1 +
>  2 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 1346ae8..1c01ac3 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -73,7 +73,7 @@ static int virtio_dev_match(struct device *_dv, struct device_driver *_dr)
>  	struct virtio_device *dev = dev_to_virtio(_dv);
>  	const struct virtio_device_id *ids;
>  
> -	ids = container_of(_dr, struct virtio_driver, driver)->id_table;
> +	ids = drv_to_virtio(_dr)->id_table;
>  	for (i = 0; ids[i].device; i++)
>  		if (virtio_id_match(dev, &ids[i]))
>  			return 1;
> @@ -97,8 +97,7 @@ void virtio_check_driver_offered_feature(const struct virtio_device *vdev,
>  					 unsigned int fbit)
>  {
>  	unsigned int i;
> -	struct virtio_driver *drv = container_of(vdev->dev.driver,
> -						 struct virtio_driver, driver);
> +	struct virtio_driver *drv = drv_to_virtio(vdev->dev.driver);
>  
>  	for (i = 0; i < drv->feature_table_size; i++)
>  		if (drv->feature_table[i] == fbit)
> @@ -111,8 +110,7 @@ static int virtio_dev_probe(struct device *_d)
>  {
>  	int err, i;
>  	struct virtio_device *dev = dev_to_virtio(_d);
> -	struct virtio_driver *drv = container_of(dev->dev.driver,
> -						 struct virtio_driver, driver);
> +	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
>  	u32 device_features;
>  
>  	/* We have a driver! */
> @@ -152,8 +150,7 @@ static int virtio_dev_probe(struct device *_d)
>  static int virtio_dev_remove(struct device *_d)
>  {
>  	struct virtio_device *dev = dev_to_virtio(_d);
> -	struct virtio_driver *drv = container_of(dev->dev.driver,
> -						 struct virtio_driver, driver);
> +	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
>  
>  	drv->remove(dev);
>  
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 30fc3c9..8da5811 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -109,6 +109,7 @@ struct virtio_driver {
>  #endif
>  };
>  
> +#define drv_to_virtio(drv) container_of(drv, struct virtio_driver, driver)
>  int register_virtio_driver(struct virtio_driver *drv);
>  void unregister_virtio_driver(struct virtio_driver *drv);
>  #endif /* _LINUX_VIRTIO_H */
> -- 
> 1.8.0
