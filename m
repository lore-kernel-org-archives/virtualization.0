Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793262856;
	b=ibfPQshvzU/IU5VEc8SfEzA/VuNoEY6dtzaDQWJibXFJIdlD4H5RvzmIeCrYCZ/rFd4c
	 hu0v9Zj57x5ysq8aNMmPW0hhepTP9iarx8xi6y6UMOaGNTP60Z+Ia43Blzb2iZca7Ifsx
	 QrIwYPo6MC841/2I9hv9r9nXJ4UwERRu2BQtCJp9P6GNGNNqlo9uhR6QAOb365wvtuLGw
	 wS2pfJN77AZwnlfiGrX5lPB21g/uO0QGyhz91SJIIRpeBPDB87gSOBfJ7cd4I67PmyIHq
	 uy0eplM+UdNeDmdK0coFb+I5KcQ6+XXyfVTXfa/tav/kY+r7RaZUhFpeG6VMkCPCwwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793262856;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=udwg5iTq6AynpYlm/gR3hWTijpTLO0SC8Cp3HMKQs3U=;
	b=O0W3M6SJFKWHhzfVvLuuA90lvHSVOt8ulUHofrMrjtJ2i99blfMEit0XQkX5WtYbSyqP
	 w5+dBS9nGOpTgdDk2WJbfx9WPrhrrwhtxkqwfsoFKt2hObWUQRBEKFnn9DJj37YwnG+c6
	 CFAAeJOSg1M3b5RbonJwyfvni0LVGviaorR5F+IoGv4ewm8iu3ZeH56Dd66Ui2fuBClJC
	 2c+o/XK60MUNJKrxPsr8vf3hEg4ekPTek4Lq8KiZr0j1OVXrN9t4eIbv5F/w3GVX5SYoy
	 dm4Bt65HQihh+dn9iwrBimUiTkljoRifcmMWe8CQJMkpsFb1IP+Pt+xd4ALOUywHWjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OfeewIsZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4977E606A322
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 08:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OfeewIsZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8D11F031E4;
	Thu, 29 Oct 2026 08:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793262856;
	bh=udwg5iTq6AynpYlm/gR3hWTijpTLO0SC8Cp3HMKQs3U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OfeewIsZ/sxin/uunPuqU3gBGjBxich46k0zor72k3TaeuNqsnCz/WUmxWmkkv8BU
	 8cKaiZQt3cZRJ3ZlYqPL38RKyWcOuwRgi4BZlxMPp9VuKAoZ17p9bsE/WyeTNFSZH5
	 Szwg1CY4JX6gZkr5k4YudKjHJJ5AZXGFhSrzIk+k48hm7fTziZx9RPR+kBZo5PUumB
	 aVdKroQh0zJo490mBSXnolg95xd6ZAPGwIYhzKSigkyLBIeZdSHMlzd5ScSZoOj1uT
	 Dh9vYNnHMRacQW0yk61DarJvdvxsE9xByiiriDGELaBEz8AJzGL8+McSl9WFUwj4C+
	 SiR2dtkSw5Kkg==
Message-ID: <sashiko-outbox-188968@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] rpmb: add a virtio RPMB device driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haruka Kuze" <harukak@zohomail.eu>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029081317.2264887-3-harukak@zohomail.eu>
References: <20261029081317.2264887-1-harukak@zohomail.eu>
 <20261029081317.2264887-3-harukak@zohomail.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 08:34:15 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] rpmb: virtio_rpmb_probe() erroneously divides max_wr by 2
- [Medium] virtio_rpmb: vr->vq published in virtio_rpmb_init_vq() before de=
vice ready
--

commit 0fd82617fed90856fa2c50ebdd578db85ac1bddd
Author: Haruka Kuze <harukak@zohomail.eu>

rpmb: add a virtio RPMB device driver

This commit adds a driver for virtio-rpmb devices (virtio ID 28) and regist=
ers
them with the RPMB subsystem as RPMB_TYPE_EMMC so in-kernel consumers such =
as
OP-TEE can use them.

Link: https://lore.kernel.org/all/20220405093759.1126835-4-alex.bennee@lina=
ro.org/

> diff --git a/drivers/misc/virtio_rpmb.c b/drivers/misc/virtio_rpmb.c
> new file mode 100644
> index 0000000000000..f02bdf13aa43c
> --- /dev/null
> +++ b/drivers/misc/virtio_rpmb.c

[ ... ]

> +static int virtio_rpmb_init_vq(struct virtio_rpmb *vr)
> +{
> +	struct virtqueue *vq;
> +
> +	vq =3D virtio_find_single_vq(vr->vdev, virtio_rpmb_done, "request");
> +	if (IS_ERR(vq))
> +		return PTR_ERR(vq);
> +
> +	mutex_lock(&vr->lock);
> +	vr->vq =3D vq;
> +	mutex_unlock(&vr->lock);
> +	return 0;
> +}

[ ... ]

> +static int virtio_rpmb_probe(struct virtio_device *vdev)
> +{
> +	struct rpmb_descr descr =3D {
> +		/* Frames and their semantics are that of eMMC */
> +		.type =3D RPMB_TYPE_EMMC,
> +		.route_frames =3D virtio_rpmb_route_frames,
> +		.dev_id =3D (u8 *)virtio_rpmb_dev_id,
> +		.dev_id_len =3D sizeof(virtio_rpmb_dev_id),
> +	};
> +	struct virtio_rpmb *vr;
> +	u8 capacity;
> +	int ret;
> +
> +	capacity =3D virtio_cread8(vdev, offsetof(struct virtio_rpmb_config,
> +						capacity));
> +	if (!capacity || capacity > 0x80)
> +		return dev_err_probe(&vdev->dev, -EINVAL,
> +				     "invalid capacity %u\n", capacity);
> +
> +	vr =3D devm_kzalloc(&vdev->dev, sizeof(*vr), GFP_KERNEL);
> +	if (!vr)
> +		return -ENOMEM;
> +
> +	vdev->priv =3D vr;
> +	vr->vdev =3D vdev;
> +	mutex_init(&vr->lock);
> +	vr->max_wr =3D virtio_cread8(vdev, offsetof(struct virtio_rpmb_config,
> +						  max_wr_cnt));
> +	vr->max_rd =3D virtio_cread8(vdev, offsetof(struct virtio_rpmb_config,
> +						  max_rd_cnt));
> +
> +	ret =3D virtio_rpmb_init_vq(vr);
> +	if (ret)
> +		return ret;
> +
> +	virtio_device_ready(vdev);
> +
> +	/*
> +	 * eMMC reports the reliable wr count in 512 byte sectors, but the devi=
ce
> +	 * limit is in 256 byte blocks.
> +	 */
> +	descr.capacity =3D capacity;
> +	descr.reliable_wr_count =3D (vr->max_wr ?: U8_MAX) / 2;

[Severity: High]
Should descr.reliable_wr_count be set without dividing vr->max_wr by 2?

Each 256-byte RPMB data block is carried inside a single 512-byte
struct virtio_rpmb_frame, so one 256-byte RPMB block corresponds 1-to-1 with
one 512-byte RPMB frame/sector. This matches how virtio_rpmb_route_frames()
validates write requests against vr->max_wr:

	case VIRTIO_RPMB_REQ_DATA_WRITE:
		if (req_len % VIRTIO_RPMB_FRAME_SIZE ||
		    resp_len !=3D VIRTIO_RPMB_FRAME_SIZE)
			return -EINVAL;
		if (vr->max_wr && req_len / VIRTIO_RPMB_FRAME_SIZE > vr->max_wr)
			return -EINVAL;

When a virtio-rpmb device reports max_wr_cnt =3D=3D 1, dividing vr->max_wr =
by 2
truncates descr.reliable_wr_count to 0. In-kernel consumers such as OP-TEE
receive rdev->descr.reliable_wr_count directly in
handle_rpc_func_rpmb_probe_next(), so reporting 0 makes the device unusable
for writes when max_wr_cnt is 1, and halves the maximum write count for lar=
ger
values.

> +
> +	vr->rdev =3D rpmb_dev_register(&vdev->dev, &descr);
> +	if (IS_ERR(vr->rdev)) {
> +		virtio_rpmb_del_vq(vr);
> +		return PTR_ERR(vr->rdev);
> +	}
> +
> +	return 0;
> +}
> +
> +static void virtio_rpmb_remove(struct virtio_device *vdev)
> +{
> +	struct virtio_rpmb *vr =3D vdev->priv;
> +
> +	rpmb_dev_unregister(vr->rdev);
> +	virtio_rpmb_del_vq(vr);
> +}
> +
> +static int virtio_rpmb_freeze(struct virtio_device *vdev)
> +{
> +	virtio_rpmb_del_vq(vdev->priv);
> +	return 0;
> +}
> +
> +static int virtio_rpmb_restore(struct virtio_device *vdev)
> +{
> +	return virtio_rpmb_init_vq(vdev->priv);
> +}

[Severity: Medium]
Can virtio_rpmb_restore() allow virtio_rpmb_xfer() to kick the virtqueue
before the device is marked VIRTIO_CONFIG_S_DRIVER_OK?

During freeze and restore, vr->rdev remains registered with the RPMB core, =
and
virtio_rpmb_xfer() uses vr->vq under vr->lock to check whether the device is
available:

	mutex_lock(&vr->lock);
	if (!vr->vq) {
		ret =3D -ENODEV;
		goto out;
	}

	ret =3D virtqueue_add_sgs(vr->vq, sgs, 1, 1, &req, GFP_KERNEL);
	if (ret)
		goto out;

	virtqueue_kick(vr->vq);
	wait_for_completion(&req.done);

In drivers/virtio/virtio.c, virtio_device_restore_priv() only calls
virtio_device_ready(dev) after drv->restore(dev) returns:

	if (restore) {
		if (drv->restore) {
			ret =3D drv->restore(dev);
			if (ret)
				goto err;
		}
	...
	/* If restore didn't do it, mark device DRIVER_OK ourselves. */
	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
		virtio_device_ready(dev);

Because virtio_rpmb_init_vq() sets vr->vq =3D vq and releases vr->lock befo=
re
virtio_device_ready(vdev) is called, a concurrent rpmb_route_frames() ->
virtio_rpmb_route_frames() -> virtio_rpmb_xfer() call can observe a non-NULL
vr->vq and call virtqueue_add_sgs() and virtqueue_kick() before
VIRTIO_CONFIG_S_DRIVER_OK is set (or while vq->broken is still true under
CONFIG_VIRTIO_HARDEN_NOTIFICATION).

Should virtio_device_ready(vr->vdev) be called inside virtio_rpmb_init_vq()
before publishing vr->vq under vr->lock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029081317.2264=
887-1-harukak@zohomail.eu?part=3D2
