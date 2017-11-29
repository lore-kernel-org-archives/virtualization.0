From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] virtio: release virtio index when fail to device_register
Date: Wed, 29 Nov 2017 10:50:44 +0100
Message-ID: <20171129105044.3a4b0ab3.cohuck@redhat.com>
References: <20171129012301.GA6637@localhost.didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171129012301.GA6637@localhost.didichuxing.com>
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

On Wed, 29 Nov 2017 09:23:01 +0800
weiping zhang <zwp10758@gmail.com> wrote:

> index can be reused by other virtio device.
> 
> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

> ---
>  drivers/virtio/virtio.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 48230a5..bf7ff39 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -333,6 +333,8 @@ int register_virtio_device(struct virtio_device *dev)
>  	/* device_register() causes the bus infrastructure to look for a
>  	 * matching driver. */
>  	err = device_register(&dev->dev);
> +	if (err)
> +		ida_simple_remove(&virtio_index_ida, dev->index);
>  out:
>  	if (err)
>  		virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);

I think your patch is correct (giving up the index if we failed to
register), but this made me look at our error handling if a virtio
device failed to register.

We hold an extra reference to the struct device, even after a failed
register, and it is the responsibility of the caller to give up that
reference once no longer needed. As callers toregister_virtio_device()
embed the struct virtio_device, it needs to be their responsibility.
Looking at the existing callers,

- ccw does a put_device
- pci, mmio and remoteproc do nothing, causing a leak
- vop does a free on the embedding structure, which is a big no-no

Thoughts?
