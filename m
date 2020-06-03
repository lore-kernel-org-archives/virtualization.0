From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] s390/virtio: remove unused pm callbacks
Date: Wed, 3 Jun 2020 08:43:56 +0200
Message-ID: <20200603084356.326d66aa.cohuck@redhat.com>
References: <20200526093629.257649-1-cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200526093629.257649-1-cohuck@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Friendly ping.

On Tue, 26 May 2020 11:36:29 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> Support for hibernation on s390 has been recently been removed with

(one 'been' too much here, I just noticed :)

> commit 394216275c7d ("s390: remove broken hibernate / power management
> support"), no need to keep unused code around.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c | 26 --------------------------
>  1 file changed, 26 deletions(-)
> 
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index 957889a42d2e..5730572b52cd 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -1372,27 +1372,6 @@ static struct ccw_device_id virtio_ids[] = {
>  	{},
>  };
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int virtio_ccw_freeze(struct ccw_device *cdev)
> -{
> -	struct virtio_ccw_device *vcdev = dev_get_drvdata(&cdev->dev);
> -
> -	return virtio_device_freeze(&vcdev->vdev);
> -}
> -
> -static int virtio_ccw_restore(struct ccw_device *cdev)
> -{
> -	struct virtio_ccw_device *vcdev = dev_get_drvdata(&cdev->dev);
> -	int ret;
> -
> -	ret = virtio_ccw_set_transport_rev(vcdev);
> -	if (ret)
> -		return ret;
> -
> -	return virtio_device_restore(&vcdev->vdev);
> -}
> -#endif
> -
>  static struct ccw_driver virtio_ccw_driver = {
>  	.driver = {
>  		.owner = THIS_MODULE,
> @@ -1405,11 +1384,6 @@ static struct ccw_driver virtio_ccw_driver = {
>  	.set_online = virtio_ccw_online,
>  	.notify = virtio_ccw_cio_notify,
>  	.int_class = IRQIO_VIR,
> -#ifdef CONFIG_PM_SLEEP
> -	.freeze = virtio_ccw_freeze,
> -	.thaw = virtio_ccw_restore,
> -	.restore = virtio_ccw_restore,
> -#endif
>  };
>  
>  static int __init pure_hex(char **cp, unsigned int *val, int min_digit,
