From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 3/3] virtio: put reference count of virtio_device.dev
Date: Tue, 12 Dec 2017 11:33:58 +0100
Message-ID: <20171212113358.17ecfd7b.cohuck@redhat.com>
References: <cover.1513007310.git.zhangweiping@didichuxing.com>
	<f761f1f5a032b7233288bc6e6ae45e44867a31bc.1513007310.git.zhangweiping@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <f761f1f5a032b7233288bc6e6ae45e44867a31bc.1513007310.git.zhangweiping@didichuxing.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: weiping zhang <zhangweiping@didichuxing.com>
Cc: virtualization@lists.linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 11 Dec 2017 23:55:38 +0800
weiping zhang <zhangweiping@didichuxing.com> wrote:

> rproc_virtio_dev_release will be called iff virtio_device.dev's
> refer count became to 0. Here we should put vdev.dev, and then
> rproc->dev's cleanup will be done in rproc_virtio_dev_release.
> 
> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> ---
>  drivers/remoteproc/remoteproc_virtio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index 2946348..b0633fd 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -327,7 +327,7 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
>  
>  	ret = register_virtio_device(vdev);
>  	if (ret) {
> -		put_device(&rproc->dev);
> +		put_device(&vdev->dev);
>  		dev_err(dev, "failed to register vdev: %d\n", ret);
>  		goto out;
>  	}

Uh, rproc_vdev is really weird. It embeds a struct virtio_device, and
in addition a struct kref. At a glance, it seems to be correct, though.
Your change is more obviously sane.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
