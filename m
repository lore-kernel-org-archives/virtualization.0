From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCHv5 1/3] virtio: find_vqs/del_vqs virtio operations
Date: Thu, 14 May 2009 08:35:24 +0200
Message-ID: <200905140835.24627.borntraeger__31828.4697518267$1242283016$gmane$org@de.ibm.com>
References: <cover.1242241196.git.mst@redhat.com>
	<20090513190858.GA3990@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090513190858.GA3990@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, avi@redhat.com, kvm@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Wednesday 13 May 2009 21:08:58 schrieb Michael S. Tsirkin:
> This replaces find_vq/del_vq with find_vqs/del_vqs virtio operations,
> and updates all drivers. This is needed for MSI support, because MSI
> needs to know the total number of vectors upfront.

[...]

> --- a/drivers/s390/kvm/kvm_virtio.c
> +++ b/drivers/s390/kvm/kvm_virtio.c
> @@ -227,6 +227,38 @@ static void kvm_del_vq(struct virtqueue *vq)
>  				       KVM_S390_VIRTIO_RING_ALIGN));
>  }
> 
> +static void vp_del_vqs(struct virtio_device *vdev)
s/vp_del_vqs/kvm_del_vqs/ :

drivers/s390/kvm/kvm_virtio.c: In function 'kvm_find_vqs':
drivers/s390/kvm/kvm_virtio.c:258: error: implicit declaration of function 'kvm_del_vqs'
drivers/s390/kvm/kvm_virtio.c: At top level:
drivers/s390/kvm/kvm_virtio.c:274: error: 'kvm_del_vqs' undeclared here (not in a function)
make[2]: *** [drivers/s390/kvm/kvm_virtio.o] Error 1

> +{
> +	struct virtqueue *vq, *n;
> +
> +	list_for_each_entry_safe(vq, n, &vdev->vqs, list)
> +		kvm_del_vq(vq);
> +}
> +
> +static int kvm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
> +			struct virtqueue *vqs[],
> +			vq_callback_t *callbacks[],
> +			const char *names[])
> +{
> +	struct kvm_device *kdev = to_kvmdev(vdev);
> +	int i;
> +
> +	/* We must have this many virtqueues. */
> +	if (nvqs > kdev->desc->num_vq)
> +		return -ENOENT;
> +
> +	for (i = 0; i < nvqs; ++i) {
> +		vqs[i] = kvm_find_vq(vdev, i, callbacks[i], names[i]);
> +		if (IS_ERR(vqs[i]))
> +			goto error;
> +	}
> +	return 0;
> +
> +error:
> +	kvm_del_vqs(vdev);
> +	return PTR_ERR(vqs[i]);
> +}
> +
>  /*
>   * The config ops structure as defined by virtio config
>   */
> @@ -238,8 +270,8 @@ static struct virtio_config_ops kvm_vq_configspace_ops = {
>  	.get_status = kvm_get_status,
>  	.set_status = kvm_set_status,
>  	.reset = kvm_reset,
> -	.find_vq = kvm_find_vq,
> -	.del_vq = kvm_del_vq,
> +	.find_vqs = kvm_find_vqs,
> +	.del_vqs = kvm_del_vqs,
>  };
> 
>  /*


> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
[...]
needs an 

 #ifdef __KERNEL__
+#include <linux/err.h>
 #include <linux/virtio.h>

[...]
> +	int err = vdev->config->find_vqs(vdev, 1, &vq, callbacks, names);
> +	if (err < 0)
> +		return ERR_PTR(err);

Otherwise ERR_PTR does not compile.
