From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 1/4] virtio: split device_register into
	device_initialize and device_add
Date: Wed, 20 Dec 2017 16:53:16 +0100
Message-ID: <20171220165316.5545b24c.cohuck@redhat.com>
References: <cover.1513700444.git.zhangweiping@didichuxing.com>
	<95ad7cb52d9e65b27f09a23c7f330128388502fa.1513700444.git.zhangweiping@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <95ad7cb52d9e65b27f09a23c7f330128388502fa.1513700444.git.zhangweiping@didichuxing.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: weiping zhang <zwp10758@gmail.com>
Cc: virtualization@lists.linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 20 Dec 2017 12:26:25 +0800
weiping zhang <zwp10758@gmail.com> wrote:

[you used a different mail address in your From: than in your s-o-b:;
same for the other patches]

> In order to make caller do a simple cleanup, we split device_register
> into device_initialize and device_add. device_initialize always sucess,

s/success/succeeds/

> the caller can always use put_device when fail to register virtio_device

"so the caller can always use put_device when register_virtio_device
failed,"

> no matter fail at ida_simple_get or at device_add.

"no matter whether it failed..."

> 
> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> Suggested-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  drivers/virtio/virtio.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index bf7ff39..3c9f211 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -303,11 +303,21 @@ void unregister_virtio_driver(struct virtio_driver *driver)
>  }
>  EXPORT_SYMBOL_GPL(unregister_virtio_driver);
>  
> +/**
> + * register_virtio_device - register virtio device
> + * @dev        : virtio device interested

"virtio device to be registered"

> + *
> + * If an error occurs, the caller must use put_device, instead of kfree, because
> + * device_initialize and device_add will increase @dev->dev's reference count.

That's not correct: It's not because of device_add increasing the
reference count (it releases it again on failure), but because another
code path may have obtained a reference.

What about:

"On error, the caller must call put_device on &@dev->dev (and not
kfree), as another code path may have obtained a reference to @dev."

> + *
> + * Returns: 0 on suceess, -error on failure
> + */
>  int register_virtio_device(struct virtio_device *dev)
>  {
>  	int err;
>  
>  	dev->dev.bus = &virtio_bus;
> +	device_initialize(&dev->dev);
>  
>  	/* Assign a unique device index and hence name. */
>  	err = ida_simple_get(&virtio_index_ida, 0, 0, GFP_KERNEL);
> @@ -330,9 +340,11 @@ int register_virtio_device(struct virtio_device *dev)
>  
>  	INIT_LIST_HEAD(&dev->vqs);
>  
> -	/* device_register() causes the bus infrastructure to look for a
> -	 * matching driver. */
> -	err = device_register(&dev->dev);
> +	/*
> +	 * device_add() causes the bus infrastructure to look for a matching
> +	 * driver.

FWIW, I would just have done s/device_register/device_add/ in the
comment, but this is ok as well.

> +	 */
> +	err = device_add(&dev->dev);
>  	if (err)
>  		ida_simple_remove(&virtio_index_ida, dev->index);
>  out:

Your code change is fine.
