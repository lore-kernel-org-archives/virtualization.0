Received: from mail.mindbit.ro (xs1.mindbit.ro [80.86.107.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E40917A2E8
	for <virtualization@lists.linux.dev>; Thu,  3 Sep 2026 00:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.86.107.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788395387; cv=none; b=salccdieQ2PSWGdcDq+UBAi6qxCtSmRxx2abxq/JrVhOSYmUFffqBpARj4Xpl/yQWnWd5u2OoOrFA4rlEmCV7btlLiZir8YjwzMn3Qh5b47TpgDLMPx/SWcx6CPdrse5++t/4wSd3Quck2R2Q5c53VD8wJiY0wyifM9Hj79B2Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788395387; c=relaxed/simple;
	bh=Uy4oG8bPKjoV3bpajNN372klUhvEFC76VKH7wSHsCvA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=irgdnEfn7tULbzmiN0QEcfcSZXvOkehSmfhghhiW99fyRMFjHbqoDDVWAkepl0VBOOgHXmuTgGEKY5baFOumJSyIdaZoGkpaLpeHD23cZXEudsw7VVtzUyYdesxnCrjZCOB6sxaQPFcK7N+y+/oWm6QNggouKDrg5tutWyyWZKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net; spf=pass smtp.mailfrom=rendec.net; dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b=ZKfEHMgK; arc=none smtp.client-ip=80.86.107.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rendec.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b="ZKfEHMgK"
Received: from dog.kanata.rendec.net (pool-174-112-193-187.cpe.net.cable.rogers.com [174.112.193.187])
	by mail.mindbit.ro (Postfix) with ESMTPSA id E084ECCE4F;
	Thu,  3 Sep 2026 03:29:39 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro E084ECCE4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1788395381;
	bh=Z2bFdkACgkeAhV/tSLVI0sVlqDoPanJ5OaFsK8NuFwg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ZKfEHMgKv1mW9qsbxES7Cgo0a4SO8FF8RMkw9YVb5yAMIQjsOpeXGdffWa8dparvA
	 H+B1oXgkOKlIckeuZ3iFzP6+YMCWhL1r0CRt9b/get/2Tlr2pi6je8tO2Y0WR7SZpF
	 /uLBG0lZftWE7wSGZKv0h0XKk1NbDhVJr5mIwkAFCMOwpJdA9uhMHlZ9qw/kFum2+f
	 RgfR+rUrOwrKPNxmHbYHKid8jKczKwtMKSDKryiCoO7xHef5i1FKI5w9q5QdWUmvb7
	 uFEXYH16Sx/XWgkNqHnzK8qUM1XT/Dp6VSZZxS+2iIKb8OuQoic6JQlN3GWIAVsW/S
	 pPmLs1IY0Q8hg==
Message-ID: <fc18ef99fdd4444b0c997f6473bb88530247115a.camel@rendec.net>
Subject: Re: [RFC PATCH] virtio: avoid hanging forever in reset
From: Radu Rendec <radu@rendec.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>,  Eugenio =?ISO-8859-1?Q?P=E9rez?=	
 <eperezma@redhat.com>, Bjorn Andersson <andersson@kernel.org>, Mathieu
 Poirier	 <mathieu.poirier@linaro.org>, virtualization@lists.linux.dev, 
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 02 Sep 2026 20:29:38 -0400
In-Reply-To: <20260902021849-mutt-send-email-mst@kernel.org>
References: <20260902020741.3686084-1-radu@rendec.net>
	 <20260902021849-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Wed, 2026-09-02 at 05:30 -0400, Michael S. Tsirkin wrote:
> On Tue, Sep 01, 2026 at 10:07:41PM -0400, Radu Rendec wrote:
> > Under certain conditions(*) vp_modern_get_status() can always return
> > 0xff. This has a ripple effect that ultimately makes the system fail to
> > boot if the drivers are built-in and the virtio devices are probed
> > during boot:
> > =C2=A0* vp_reset() for the virtio-net-pci device spins forever in the l=
oop
> > =C2=A0=C2=A0 around vp_modern_get_status(mdev), which always returns 0x=
ff.
> > =C2=A0* vp_reset() is called in the context of the probe() function for=
 the
> > =C2=A0=C2=A0 virtio-net-pci device, so probe() never returns.
> > =C2=A0* the init task gets stuck in wait_for_device_probe() before it
> > =C2=A0=C2=A0 executes the real init binary.
> >=20
> > Add a timeout to the reset function and make the device probing fail if
> > the reset function times out.
>=20
> Generally, I like using gdb stub in qemu to debug kernel

That's what I did too. It took a while, because init and the kthread
that runs probe() are different tasks, and it's not obvious why init
doesn't run while the kernel is still alive. It would've been *much*
faster/easier if the probe() function complained instead of silently
waiting indefinitely.

> and anything that will make things time out and fail
> is unwelcome.

So a probe() that never returns and makes the system fail to fully boot
is preferable? That's... surprising. IMHO it's also not what most
probe() functions do when there is something wrong with the device.

> > (*) This is not a theoretical problem. It happens on imx8mp-evk under
> > Qemu due to a relatively recent change to the dw_pcie driver that's
> > incompatible with the dw_pcie emulation in Qemu. I reported that bug
> > separately as a follow up to the patch that introduced it:
> > https://lore.kernel.org/all/ed86629d74368c6811e9f3b8f169584c0faf71ce.ca=
mel@rendec.net/
>=20
> So presumably it will be fixed in qemu? Or find a different way,
> e.g. poke at device/vendor id of virtio. or add a workaround
> in the driver if you prefer.

Yes, one of those (probably qemu). But this patch is not about fixing
it. In fact, it doesn't even fix it. It just aims to make life a bit
easier for the next poor soul who runs into a similar problem.

> > Signed-off-by: Radu Rendec <radu@rendec.net>
> > ---
> > =C2=A0drivers/remoteproc/remoteproc_virtio.c |=C2=A0 4 +++-
> > =C2=A0drivers/virtio/virtio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 +++++---
> > =C2=A0drivers/virtio/virtio_mmio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 ++++-
> > =C2=A0drivers/virtio/virtio_pci_legacy.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 4 +++-
> > =C2=A0drivers/virtio/virtio_pci_modern.c=C2=A0=C2=A0=C2=A0=C2=A0 | 15 +=
+++++++++++---
> > =C2=A0include/linux/virtio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A0include/linux/virtio_config.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A07 files changed, 29 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remotepro=
c/remoteproc_virtio.c
> > index d5e9ff045a28..d103b80b1faf 100644
> > --- a/drivers/remoteproc/remoteproc_virtio.c
> > +++ b/drivers/remoteproc/remoteproc_virtio.c
> > @@ -231,7 +231,7 @@ static void rproc_virtio_set_status(struct virtio_d=
evice *vdev, u8 status)
> > =C2=A0	dev_dbg(&vdev->dev, "status: %d\n", status);
> > =C2=A0}
> > =C2=A0
> > -static void rproc_virtio_reset(struct virtio_device *vdev)
> > +static int rproc_virtio_reset(struct virtio_device *vdev)
> > =C2=A0{
> > =C2=A0	struct rproc_vdev *rvdev =3D vdev_to_rvdev(vdev);
> > =C2=A0	struct fw_rsc_vdev *rsc;
> > @@ -240,6 +240,8 @@ static void rproc_virtio_reset(struct virtio_device=
 *vdev)
> > =C2=A0
> > =C2=A0	rsc->status =3D 0;
> > =C2=A0	dev_dbg(&vdev->dev, "reset !\n");
> > +
> > +	return 0;
> > =C2=A0}
> > =C2=A0
> > =C2=A0/* provide the vdev features as retrieved from the firmware */
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index 75bb4ffe3b87..9542e4f7cb31 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -250,7 +250,7 @@ static int virtio_features_ok(struct virtio_device =
*dev)
> > =C2=A0 * call/workqueue/bh.=C2=A0 Invoking virtio_break_device then flu=
shing any such
> > =C2=A0 * contexts is one way to handle that.
> > =C2=A0 * */
> > -void virtio_reset_device(struct virtio_device *dev)
> > +int virtio_reset_device(struct virtio_device *dev)
> > =C2=A0{
> > =C2=A0#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > =C2=A0	/*
> > @@ -263,7 +263,7 @@ void virtio_reset_device(struct virtio_device *dev)
> > =C2=A0	virtio_synchronize_cbs(dev);
> > =C2=A0#endif
> > =C2=A0
> > -	dev->config->reset(dev);
> > +	return dev->config->reset(dev);
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_GPL(virtio_reset_device);
> > =C2=A0
> > @@ -567,7 +567,9 @@ int register_virtio_device(struct virtio_device *de=
v)
> > =C2=A0
> > =C2=A0	/* We always start by resetting the device, in case a previous
> > =C2=A0	 * driver messed it up.=C2=A0 This also tests that code path a l=
ittle. */
> > -	virtio_reset_device(dev);
> > +	err =3D virtio_reset_device(dev);
> > +	if (err)
> > +		goto out_of_node_put;
> > =C2=A0
> > =C2=A0	/* Acknowledge that we've seen the device. */
> > =C2=A0	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
> > diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.=
c
> > index 316f03b97356..537d38841331 100644
> > --- a/drivers/virtio/virtio_mmio.c
> > +++ b/drivers/virtio/virtio_mmio.c
> > @@ -249,7 +249,7 @@ static void vm_set_status(struct virtio_device *vde=
v, u8 status)
> > =C2=A0	writel(status, vm_dev->base + VIRTIO_MMIO_STATUS);
> > =C2=A0}
> > =C2=A0
> > -static void vm_reset(struct virtio_device *vdev)
> > +static int vm_reset(struct virtio_device *vdev)
> > =C2=A0{
> > =C2=A0	struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev=
);
> > =C2=A0
> > @@ -260,7 +260,10 @@ static void vm_reset(struct virtio_device *vdev)
> > =C2=A0		/* Wait for reset to complete. */
> > =C2=A0		while (vm_get_status(vdev))
> > =C2=A0			fsleep(1000);
> > +		/* TODO: add timeout */
> > =C2=A0	}
> > +
> > +	return 0;
> > =C2=A0}
> > =C2=A0
> > =C2=A0
> > diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio=
_pci_legacy.c
> > index d9cbb02b35a1..2882756c7084 100644
> > --- a/drivers/virtio/virtio_pci_legacy.c
> > +++ b/drivers/virtio/virtio_pci_legacy.c
> > @@ -90,7 +90,7 @@ static void vp_set_status(struct virtio_device *vdev,=
 u8 status)
> > =C2=A0	vp_legacy_set_status(&vp_dev->ldev, status);
> > =C2=A0}
> > =C2=A0
> > -static void vp_reset(struct virtio_device *vdev)
> > +static int vp_reset(struct virtio_device *vdev)
> > =C2=A0{
> > =C2=A0	struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
> > =C2=A0	/* 0 status means a reset. */
> > @@ -100,6 +100,8 @@ static void vp_reset(struct virtio_device *vdev)
> > =C2=A0	vp_legacy_get_status(&vp_dev->ldev);
> > =C2=A0	/* Flush pending VQ/configuration callbacks. */
> > =C2=A0	vp_synchronize_vectors(vdev);
> > +
> > +	return 0;
> > =C2=A0}
> > =C2=A0
> > =C2=A0static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16=
 vector)
> > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio=
_pci_modern.c
> > index 6d8ae2a6a8ca..4a6906a18cfa 100644
> > --- a/drivers/virtio/virtio_pci_modern.c
> > +++ b/drivers/virtio/virtio_pci_modern.c
> > @@ -21,6 +21,7 @@
> > =C2=A0#include "virtio_pci_common.h"
> > =C2=A0
> > =C2=A0#define VIRTIO_AVQ_SGS_MAX	4
> > +#define VIRTIO_PCI_RESET_TIMEOUT_MS 1000
> > =C2=A0
> > =C2=A0static void vp_get_features(struct virtio_device *vdev, u64 *feat=
ures)
> > =C2=A0{
> > @@ -543,10 +544,11 @@ static void vp_set_status(struct virtio_device *v=
dev, u8 status)
> > =C2=A0		vp_modern_avq_activate(vdev);
> > =C2=A0}
> > =C2=A0
> > -static void vp_reset(struct virtio_device *vdev)
> > +static int vp_reset(struct virtio_device *vdev)
> > =C2=A0{
> > =C2=A0	struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
> > =C2=A0	struct virtio_pci_modern_device *mdev =3D &vp_dev->mdev;
> > +	int timeout =3D VIRTIO_PCI_RESET_TIMEOUT_MS;
> > =C2=A0
> > =C2=A0	/* 0 status means a reset. */
> > =C2=A0	vp_modern_set_status(mdev, 0);
> > @@ -555,13 +557,20 @@ static void vp_reset(struct virtio_device *vdev)
> > =C2=A0	 * This will flush out the status write, and flush in device wri=
tes,
> > =C2=A0	 * including MSI-X interrupts, if any.
> > =C2=A0	 */
> > -	while (vp_modern_get_status(mdev))
> > -		msleep(1);
> > +	while (vp_modern_get_status(mdev)) {
> > +		if (!timeout--) {
> > +			dev_warn(&vdev->dev, "reset timeout");
> > +			return -ETIMEDOUT;
> > +		}
> > +		msleep(1000);
>=20
>=20
> 1 second is a long time. normally devices reset immediately.

Sorry, the msleep() should have been unchanged. It was something I did
for debugging and forgot to change back. The intention was to use the
existing 1ms sleep and spin at most VIRTIO_PCI_RESET_TIMEOUT_MS times.
This is what happens when you send patches at 10pm :)

> > +	}
> > =C2=A0
> > =C2=A0	vp_modern_avq_cleanup(vdev);
> > =C2=A0
> > =C2=A0	/* Flush pending VQ/configuration callbacks. */
> > =C2=A0	vp_synchronize_vectors(vdev);
> > +
> > +	return 0;
> > =C2=A0}
> > =C2=A0
> > =C2=A0static int vp_active_vq(struct virtqueue *vq, u16 msix_vec)
>=20
>=20
> So now if the device does not reset, during cleanup we
> previously blocked and now it will corrupt memory.

That was not the intention, obviously. The patch as it is also adds a
TODO comment to vm_reset() (instead of adding a max count), which is
clearly unacceptable for a real patch.

This is a RFC patch, and my intention was essentially to ask if
something like this is desirable/acceptable. In all honesty, I didn't
even test it (other than make sure it compiles). I intentionally didn't
spend too much time on it because one of the two possible answers to my
question could be "no", and then that time would be wasted time.

If that changes anything and a polished and properly tested version of
the patch makes sense, I can work on that. If not, that's fine too - at
least now I know what to look for if I see a system hang during boot
and virtio is used.

In any case, thanks for looking into this and for the feedback!

> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index f923e42cfd01..568e1bd95e4c 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -212,7 +212,7 @@ void virtio_config_driver_enable(struct virtio_devi=
ce *dev);
> > =C2=A0int virtio_device_freeze(struct virtio_device *dev);
> > =C2=A0int virtio_device_restore(struct virtio_device *dev);
> > =C2=A0#endif
> > -void virtio_reset_device(struct virtio_device *dev);
> > +int virtio_reset_device(struct virtio_device *dev);
> > =C2=A0void virtio_device_shutdown(struct virtio_device *dev);
> > =C2=A0int virtio_device_reset_prepare(struct virtio_device *dev);
> > =C2=A0int virtio_device_reset_done(struct virtio_device *dev);
> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_confi=
g.h
> > index 69f84ea85d71..153426b0ae79 100644
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -117,7 +117,7 @@ struct virtio_config_ops {
> > =C2=A0	u32 (*generation)(struct virtio_device *vdev);
> > =C2=A0	u8 (*get_status)(struct virtio_device *vdev);
> > =C2=A0	void (*set_status)(struct virtio_device *vdev, u8 status);
> > -	void (*reset)(struct virtio_device *vdev);
> > +	int (*reset)(struct virtio_device *vdev);
> > =C2=A0	int (*find_vqs)(struct virtio_device *vdev, unsigned int nvqs,
> > =C2=A0			struct virtqueue *vqs[],
> > =C2=A0			struct virtqueue_info vqs_info[],
> > --=20
> > 2.55.0

--=20
Best regards,
Radu
