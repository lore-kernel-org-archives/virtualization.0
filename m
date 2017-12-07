From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/1] virtio/s390: implement PM operations for virtio_ccw
Date: Thu, 7 Dec 2017 16:48:19 +0100
Message-ID: <07d71303-ebb5-a0ca-a526-21fb90e2ea77__16404.1602555246$1512661704$gmane$org@redhat.com>
References: <20171207141102.70190-1-borntraeger@de.ibm.com>
	<20171207141102.70190-2-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171207141102.70190-2-borntraeger@de.ibm.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 07.12.2017 15:11, Christian Borntraeger wrote:
> Suspend/Resume to/from disk currently fails. Let us wire
> up the necessary callbacks. This is mostly just forwarding
> the requests to the virtio drivers. The only thing that
> has to be done in virtio_ccw itself is to re-set the
> virtio revision.
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index b18fe201..330b3fa 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -1300,6 +1300,9 @@ static int virtio_ccw_cio_notify(struct ccw_device *cdev, int event)
>  		vcdev->device_lost = true;
>  		rc = NOTIFY_DONE;
>  		break;
> +	case CIO_OPER:
> +		rc = NOTIFY_OK;
> +		break;
>  	default:
>  		rc = NOTIFY_DONE;
>  		break;
> @@ -1312,6 +1315,25 @@ static struct ccw_device_id virtio_ids[] = {
>  	{},
>  };
>  
> +static int virtio_ccw_freeze(struct ccw_device *cdev)
> +{
> +	struct virtio_ccw_device *vcdev = dev_get_drvdata(&cdev->dev);
> +
> +	return virtio_device_freeze(&vcdev->vdev);
> +}
> +
> +static int virtio_ccw_restore(struct ccw_device *cdev)
> +{
> +	struct virtio_ccw_device *vcdev = dev_get_drvdata(&cdev->dev);
> +	int ret;
> +
> +	ret = virtio_ccw_set_transport_rev(vcdev);
> +	if (ret)
> +		return ret;
> +
> +	return virtio_device_restore(&vcdev->vdev);
> +}
> +
>  static struct ccw_driver virtio_ccw_driver = {
>  	.driver = {
>  		.owner = THIS_MODULE,
> @@ -1324,6 +1346,9 @@ static struct ccw_driver virtio_ccw_driver = {
>  	.set_online = virtio_ccw_online,
>  	.notify = virtio_ccw_cio_notify,
>  	.int_class = IRQIO_VIR,
> +	.freeze = virtio_ccw_freeze,
> +	.thaw = virtio_ccw_restore,
> +	.restore = virtio_ccw_restore,
>  };
>  
>  static int __init pure_hex(char **cp, unsigned int *val, int min_digit,
> 

Really neat, hope we haven't forgotten to reinitialize anything. (guess
if it works, we should be 99.9% fine)

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
