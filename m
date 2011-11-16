From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-mmio: Correct the name of the guest features
	selector
Date: Wed, 16 Nov 2011 11:15:14 +1030
Message-ID: <87pqgsopyd.fsf@rustcorp.com.au>
References: <1321366638-28408-1-git-send-email-levinsasha928@gmail.com>
	<1321367122.3137.142.camel@hornet.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1321367122.3137.142.camel@hornet.cambridge.arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pawel Moll <pawel.moll@arm.com>, Sasha Levin <levinsasha928@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 15 Nov 2011 14:25:22 +0000, Pawel Moll <pawel.moll@arm.com> wrote:
> On Tue, 2011-11-15 at 14:17 +0000, Sasha Levin wrote:
> > Guest features selector spelling mistake.
> >
> > diff --git a/include/linux/virtio_mmio.h b/include/linux/virtio_mmio.h
> > index 27c7ede..5c7b6f0 100644
> > --- a/include/linux/virtio_mmio.h
> > +++ b/include/linux/virtio_mmio.h
> > @@ -63,7 +63,7 @@
> >  #define VIRTIO_MMIO_GUEST_FEATURES	0x020
> >  
> >  /* Activated features set selector - Write Only */
> > -#define VIRTIO_MMIO_GUEST_FEATURES_SET	0x024
> > +#define VIRTIO_MMIO_GUEST_FEATURES_SEL	0x024
> >  
> >  /* Guest's memory page size in bytes - Write Only */
> >  #define VIRTIO_MMIO_GUEST_PAGE_SIZE	0x028
> 
> Damn. Sorry about it. But if you change the header you'll need to change
> the driver:
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 1f25bb9..10bb8b9 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -161,7 +161,7 @@ static void vm_finalize_features(struct virtio_device *vdev)
>         vring_transport_features(vdev);
>  
>         for (i = 0; i < ARRAY_SIZE(vdev->features); i++) {
> -               writel(i, vm_dev->base + VIRTIO_MMIO_GUEST_FEATURES_SET);
> +               writel(i, vm_dev->base + VIRTIO_MMIO_GUEST_FEATURES_SEL);
>                 writel(vdev->features[i],
>                                 vm_dev->base + VIRTIO_MMIO_GUEST_FEATURES);
>         }

Rolled together and applied.

Thanks,
Rusty.
