From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 5/5] virtio: add comments for virtio_register_device
Date: Tue, 19 Dec 2017 12:11:59 +0100
Message-ID: <20171219121159.17b8c060.cohuck@redhat.com>
References: <cover.1513517240.git.zhangweiping@didichuxing.com>
	<56d8ecc6f11b7580f3d38adcc0fd71ac60f72b02.1513517240.git.zhangweiping@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <56d8ecc6f11b7580f3d38adcc0fd71ac60f72b02.1513517240.git.zhangweiping@didichuxing.com>
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

On Sun, 17 Dec 2017 21:48:05 +0800
weiping zhang <zwp10758@gmail.com> wrote:

> As mentioned at drivers/base/core.c:
> /*
> * NOTE: _Never_ directly free @dev after calling this function, even
> * if it returned an error! Always use put_device() to give up the
> * reference initialized in this function instead.
> */
> virtio_register_device may fail before/after call device_register, the
> caller should do a proper cleanup. Caller cann't use kfree directly,
> if virtio_register_device has already called device_register. Caller
> cann't use put_device directly, if virtio_register_device has not yet
> call device_register, because kobject_put may give a warning cause
> dev->kobj has not been initialized.

This comment makes me inclined to think that we should also rethink
register_virtio_device(). On failure, we cannot do kfree() due to
driver core interaction; but we cannot do a put_device() either, since
the refcount may not yet have been initialized -- unless we check the
device status, which triggers I/O (at least on s390).

We really want to do the same cleanup on error in every case. What
about splitting device_register() into device_initialize() and
device_add()? If we move device_initialize() before getting an index,
we should be fine with doing put_device() on error in every case.

> 
> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> ---
>  drivers/virtio/virtio.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index c5b057bd..4f0718b 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -309,6 +309,19 @@ void unregister_virtio_driver(struct virtio_driver *driver)
>  }
>  EXPORT_SYMBOL_GPL(unregister_virtio_driver);
>  
> +/**
> + * register_virtio_device - register virtio device
> + *
> + * @dev	: virtio device interested
> + *
> + * This funciton may fail after call device_register, as mentioned at
> + * drivers/base/core.c we must use put_device(), _never_ directly free @dev.
> + * The caller should take care of the status of @dev and determine to use
> + * put_device or kfree. If @dev in VIRTIO_CONFIG_S_ACKNOWLEDGE status that
> + * means caller should use put_device otherwise use kfree directly.
> + *
> + * Returns: 0 on success, error on failure.
> + */
>  int register_virtio_device(struct virtio_device *dev)
>  {
>  	int err;
