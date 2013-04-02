From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [PATCH 05/22] virtio: add support for 64 bit features.
Date: Tue, 02 Apr 2013 18:09:18 +0100
Message-ID: <1364922558.3019.45.camel@hornet>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
	<1363854584-25795-6-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363854584-25795-6-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Brian Swetland <swetland@google.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2013-03-21 at 08:29 +0000, Rusty Russell wrote:
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index d933150..84ef5fc 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
[...]
>  static void vm_finalize_features(struct virtio_device *vdev)
> @@ -160,7 +162,9 @@ static void vm_finalize_features(struct virtio_device *vdev)
>  	vring_transport_features(vdev);
>  
>  	writel(0, vm_dev->base + VIRTIO_MMIO_GUEST_FEATURES_SEL);
> -	writel(vdev->features, vm_dev->base + VIRTIO_MMIO_GUEST_FEATURES);
> +	writel((u32)vdev->features, vm_dev->base + VIRTIO_MMIO_GUEST_FEATURES);
> +	writel(1, vm_dev->base + VIRTIO_MMIO_GUEST_FEATURES_SEL);
> +	writel(vdev->features >> 32, vm_dev->base + VIRTIO_MMIO_GUEST_FEATURES);

Maybe (u32)(vdev->features >> 32), just to keep the lines consistent?

I'm just being fussy... ;-)

>  }

Otherwise perfectly fine with me (together with "04/22 virtio: use u32,
not bitmap for struct virtio_device's features")

Acked-by: Pawel Moll <pawel.moll@arm.com>

Pawel
