Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC154F85DF
	for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789666891; cv=none; b=cxFGvhvhQEKP6npzJmOqKEtAf9INBW3rtPmRHB7W9oyha74pDRq+UEH0y600L1yISkp6QCr9AoTTebDb3lfn7z93PhGbpFg32VAwi8DbKFDVnPl2B8BM+GCWiN280xWU7qEulK7W0qgGXsmgrUVUaGIajjQZ5wfHyZGxeAUwA7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789666891; c=relaxed/simple;
	bh=ULrv8xgR83CTRxV5MwRdd2F3nm6F8jY8tioGkD6tRi0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oRcGDdj+WuVR9DMXzoS90kEvkKcmUy/c9tkqXa6LN6lOdj9owoWaNc0bxsCoZSZ6jGHUeW7jOgFjqJ4lr057hS/31ku8p/vqffPKAuOo2Wwbc9GA3ygJ6wsNwUoUO2RpFEy/uKcJ2qQuH8lncjbOkJu/DIBfzTiGSXG4ZQff+ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vb5wcj1b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vb5wcj1b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80C31F000FF;
	Thu, 17 Sep 2026 17:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789666890;
	bh=wi/mBI7GI3XU8D9jk3b+dyqSNTlEnZgD3yJQC2hge9M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vb5wcj1beRDGf/kQSZ+/PlmsSSt3uwqikQiu9Ry1jbhGzTQUdH5QtzV7/Bz8GkdwK
	 uVq/jP4Ml+N8FQy/DdM81lF7OgmPFci90PP2dKEmQtjMZvzgEG3Ujnyss6I0h2TwPu
	 WbhS/o6jVDGVWoVQx/w50q7U7uRcW+BVS8P7XUDO5oqq1MJDMT1F2cGbLDGpZXmKV0
	 7fjXvWcbxSz9Wj6lmbEyNXPwgAq5HU/pm96Jgdm26Z3VctPBPVPkQUeVzuUmkQm6F4
	 qbaSG7jPIouTVlf0DaVX++p07lndaN+LUQKO+Q4hES4TEFGQ6qfCcoGsftbyZocBK8
	 dIu85N3uv7J1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/4] media: virtio: Add skeleton virtio-media driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brian Daniels" <briandaniels@google.com>
Cc: media-ci@linuxtv.org, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260917171921.2810550-2-briandaniels@google.com>
References: <20260917171921.2810550-1-briandaniels@google.com>
 <20260917171921.2810550-2-briandaniels@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 17:41:29 +0000
Message-Id: <20260917174129.B80C31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] virtio-media: use-after-free when device is unbound with open file=
 handles
- [High] virtio-media: architecture-dependent types in UAPI protocol break =
cross-arch ABI
- [High] virtio-media: teardown order inversion destroys virtqueues before =
unregistering device
- [High] virtio-media: untrusted hardware config mapped directly to interna=
l kernel enum
- [High] virtio-media: use of errno as struct member in UAPI header breaks =
userspace compilation
- [Medium] virtio-media: missing 64-bit alignment padding in struct virtio_=
media_cmd_mmap
- [Medium] virtio-media: video device exposed to userspace before virtio DR=
IVER_OK
--

commit b20027764c6d7c66eb489de254863fb2d6937cf0
Author: Alexandre Courbot <gnurou@gmail.com>

media: virtio: Add skeleton virtio-media driver

This commit adds a skeleton driver for virtualizing media devices using
the V4L2 protocol over virtio. It defines the UAPI protocol headers,
internal driver structures, and basic device probing and removal hooks.

> diff --git a/drivers/media/virtio/virtio_media_driver.c b/drivers/media/v=
irtio/virtio_media_driver.c
> index 0000000000000..25f2ceaa6c480
> --- /dev/null
> +++ b/drivers/media/virtio/virtio_media_driver.c
[ ... ]
> +static int virtio_media_probe(struct virtio_device *virtio_dev)
> +{
[ ... ]
> +	vd =3D &vv->video_dev;
> +	vd->v4l2_dev =3D &vv->v4l2_dev;
> +	vd->vfl_type =3D VFL_TYPE_VIDEO;
> +	vd->fops =3D &virtio_media_fops;
> +	vd->release =3D video_device_release_empty;
> +	strscpy(vd->name, "virtio-media", sizeof(vd->name));
> +
> +	video_set_drvdata(vd, vv);
> +
> +	vd->device_caps =3D virtio_cread32(virtio_dev, 0);
> +	if (vd->device_caps & (V4L2_CAP_VIDEO_M2M | V4L2_CAP_VIDEO_M2M_MPLANE))
> +		vd->vfl_dir =3D VFL_DIR_M2M;
> +	else if (vd->device_caps &
> +		 (V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_VIDEO_OUTPUT_MPLANE))
> +		vd->vfl_dir =3D VFL_DIR_TX;
> +	else
> +		vd->vfl_dir =3D VFL_DIR_RX;
> +
> +	ret =3D video_register_device(vd, virtio_cread32(virtio_dev, 4), 0);

[Severity: High]
Is it safe to pass the hardware config value directly into an internal
kernel enum?

video_register_device() expects an enum vfl_devnode_type as its second
argument. Using virtio_cread32(virtio_dev, 4) directly leaks the untrusted
hardware config space value into an unstable Linux-internal enum. If offset=
 4
was intended to be the node number (nr), the arguments are swapped.

> +	if (ret)
> +		goto err_register_device;
> +
> +	virtio_device_ready(virtio_dev);

[Severity: Medium]
Could exposing the video device before signaling DRIVER_OK violate the
virtio specification?

video_register_device() exposes the /dev/videoX node to userspace.
A userspace process can open the device and issue commands (which kicks the
virtqueues) before the virtio driver has signaled the DRIVER_OK status, whi=
ch
might cause the host to ignore commands or fault the guest.

> +	return 0;
> +
> +err_register_device:
> +	virtio_dev->config->del_vqs(virtio_dev);
> +err_find_vqs:
> +	v4l2_device_unregister(&vv->v4l2_dev);
> +	return ret;
> +}
> +
> +static void virtio_media_remove(struct virtio_device *virtio_dev)
> +{
> +	struct virtio_media *vv =3D virtio_dev->priv;
> +
> +	virtio_reset_device(virtio_dev);
> +	v4l2_device_unregister(&vv->v4l2_dev);
> +	virtio_dev->config->del_vqs(virtio_dev);
> +	video_unregister_device(&vv->video_dev);

[Severity: High]
Does this cleanup order risk a use-after-free or null pointer dereference?

Destroying the virtqueues via del_vqs() before calling
video_unregister_device() leaves a window where a concurrent userspace
process can open the device or issue an ioctl, attempting to access the
already freed virtqueues.

[Severity: High]
Can this lead to a use-after-free when the device is unbound?

virtio_media_probe() allocates vv using devm_kzalloc() and sets
vd->release to video_device_release_empty.

During removal, virtio_media_remove() unregisters the device and returns,
allowing devres to immediately free vv. If a userspace process still has
the /dev/videoX node open, a subsequent ioctl or close will access the freed
video_device embedded in vv. The V4L2 subsystem requires reference-counted
memory management via the release callback for dynamically allocated
devices.

> diff --git a/include/uapi/linux/virtio_media.h b/include/uapi/linux/virti=
o_media.h
> index 0000000000000..ac3d75c752d92
> --- /dev/null
> +++ b/include/uapi/linux/virtio_media.h
[ ... ]
> +struct virtio_media_cmd_mmap {
> +	struct virtio_media_cmd_header hdr;
> +	__le32 session_id;
> +	__le32 flags;
> +	__le32 offset;
> +};

[Severity: Medium]
Is this structure missing a 4-byte padding field to align to 64 bits?

It consists of an 8-byte header followed by three 4-byte fields, totaling 20
bytes. The compiler will not implicitly pad it to 24 bytes, which contradic=
ts
the design of ensuring 64-bit alignment for virtio-media protocol structure=
s.

[ ... ]
> +struct virtio_media_event_error {
> +	struct virtio_media_event_header hdr;
> +	__le32 errno;

[Severity: High]
Will this break userspace compilation?

In POSIX environments, errno is usually defined as a macro in <errno.h>.
Using it as a struct member name in a UAPI header will cause the preprocess=
or
to expand it into an invalid identifier for programs including both headers.

> +	__le32 __reserved;
> +};
[ ... ]
> +struct virtio_media_event_dqbuf {
> +	struct virtio_media_event_header hdr;
> +	struct v4l2_buffer buffer;
> +	struct v4l2_plane planes[VIRTIO_MEDIA_MAX_PLANES];
> +};
> +
> +/**
> + * struct virtio_media_event_event - V4L2 event.
> + * @hdr: header for the event.
> + * @event: description of the event that occurred.
> + *
> + * This event signals that a V4L2 event has been emitted for a session.
> + */
> +struct virtio_media_event_event {
> +	struct virtio_media_event_header hdr;
> +	struct v4l2_event event;
> +};

[Severity: High]
Are cross-architecture ABI guarantees broken by these embedded structures?

struct v4l2_buffer and struct v4l2_event contain pointers and
architecture-dependent types (like struct timespec and unsigned long userpt=
r).

The sizes and layouts of these structures will differ between 32-bit and
64-bit platforms, meaning a 64-bit host cannot safely interpret messages fr=
om
a 32-bit guest.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917171921.2810=
550-1-briandaniels@google.com?part=3D1
