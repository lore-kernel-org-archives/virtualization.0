Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795230809;
	b=NCc9H1lJyYTsUjpcsPUW8Gl9z8jQtKEBMWur3ibPg0yERbje1Zrgb5zUZhQJg10UWC5n
	 UTMWl2aPhTcZRQUYHHWX7PRxCYHbtlnou2phVOZgOgDFmvjkvJArIR/1K2/k/UomvO2B2
	 u2nfciSBKRoM2kdAK1WRxzarsM2/iW5Ts99n405FdnWnnWNT45fvsKhqJokLrGrgoQECq
	 yAyHPOewMfE3aIFaPk2xZIMRd5yopapz+N6ZDvrsAFTJsIbJfNi5NNqDl/fMYSDOSV9tO
	 fr/qKlozdd+IZSw9fsKNcBC34mq7eIQFd29NVHmphXOxkkV9ePp5yTSiVFGIKWy43rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795230809;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=N3cX0BMGcAwhg/9cxMNLY5HCHkTkQSHwOn7S5DAqn08=;
	b=ioTtYqcPKSGFcZd/3ttTzquiXff3yWeoaJFuV4EAFNBpiHSZT1naWNPj9XmVZpciVXBm
	 PSFiHx6VpB3dMYmTpmr3ML9hBtf9IOYRocFPqj3uOCrUwLhS/McHHCI1XHvy2+K4hcHjt
	 qSLvXSxudMXGnOcMqD9IKZ0xAFYdBJLV8TtlRihQAxxdKmMh9OrkopCEXPUaXHU+be2dH
	 pa6QeJPft2RiYCovRTsFusJnO0RFEbsoapQbOj3mvxps60FZDnFy4c+Lrc97GQmvpmIUE
	 kD2i3VHo/C1/GtC5NI7vaRA9jxGcpWuGD7iIlaUhyf03KjhtjVJIJXRitxEyl35m2bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cgzwGwCr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FBD606A693
	for <virtualization@lists.linux.dev>; Sat, 21 Nov 2026 03:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cgzwGwCr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C1E1F000C0;
	Sat, 21 Nov 2026 03:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795230809;
	bh=N3cX0BMGcAwhg/9cxMNLY5HCHkTkQSHwOn7S5DAqn08=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cgzwGwCrzGHZMJtILtAWd4Fh8npbOKJWVmvNjc5q0CmIzASRh7VDxwB0FotV9sLl8
	 3Yhv5/qILvfLoZH0kY97lL+BaizA7Ub7kHHO5DVRtrvJy695DgAkXe8vOpXnBdIfaW
	 1KlPpcZp8+xLurRp88uQu+KFCdpBaEW+nyA/iGcGjQBMPnjvdusY9QZzMWxz5z6jZz
	 9FvCHgL40YFAotxeSxeiZTizrM18hh1JS9Ms9eIQK5TCOQuBQbR1GkKpNBxiaMTdCN
	 EQDT/XAFLLes9E2Tansafogju8HuKpQ1viwZjMVfHoIbAZXPA24ZO432AaDhE0oJkd
	 G7zRhl8Ncsnmg==
Message-ID: <sashiko-outbox-226562@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 1/6] media: virtio: Add core driver and session
 management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brian Daniels" <briandaniels@google.com>
Cc: virtualization@lists.linux.dev, media-ci@linuxtv.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261121025007.3445723-2-briandaniels@google.com>
References: <20261121025007.3445723-1-briandaniels@google.com>
 <20261121025007.3445723-2-briandaniels@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 03:13:28 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [High] media: virtio: UAF and NULL deref on close after
  virtio_media_remove()
- [High] media: virtio: unsynchronized commandq access and cb_param
  wakeup race
- [Medium] media: virtio: stack cb_param left queued if virtqueue_kick()
  fails
- [Medium] media: virtio: unsigned status negation and missing le32
  conversions
- [Low] media: Kconfig: MEDIA_VIRTIO depends on hidden VIDEO_DEV in
  filter menu
- [Low] media: virtio: kernel-doc warnings and C++ comment in UAPI
  header
--

commit 737186f1522940e8113c5acf117d0e10e560174d
Author: Alexandre Courbot <gnurou@gmail.com>

media: virtio: Add core driver and session management

This commit adds the initial virtio-media driver core, build system
integration, MAINTAINERS entry, and V4L2 session lifecycle management.

> diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
> index 6abc9302cd84d..ce7d088e74418 100644
> --- a/drivers/media/Kconfig
> +++ b/drivers/media/Kconfig
> @@ -136,6 +136,19 @@ config MEDIA_PLATFORM_SUPPORT
> =20
>  	  Say Y when you want to be able to see such devices.
> =20
> +config MEDIA_VIRTIO
> +	tristate "Virtio-media Driver"
> +	depends on VIRTIO && VIDEO_DEV && 64BIT && (X86 || CPU_LITTLE_ENDIAN)
> +	select VIDEOBUF2_CORE
> +	select VIDEOBUF2_MEMOPS
> +	help
> +	  Enables the virtio-media driver.
> +
> +	  This driver is used to virtualize media devices such as cameras or
> +	  decoders from a host into a guest using the V4L2 protocol.
> +
> +	  If unsure, say N.
> +
>  config MEDIA_TEST_SUPPORT
>  	bool
>  	prompt "Test drivers" if MEDIA_SUPPORT_FILTER

[Severity: Low]
Can MEDIA_VIRTIO be selected when MEDIA_SUPPORT_FILTER=3Dy unless another
media device category is also enabled?

When MEDIA_SUPPORT_FILTER=3Dy, VIDEO_DEV has no prompt and is only enabled =
by
its default expression (MEDIA_CAMERA_SUPPORT || MEDIA_ANALOG_TV_SUPPORT ||
MEDIA_RADIO_SUPPORT || MEDIA_SDR_SUPPORT || MEDIA_PLATFORM_SUPPORT ||
MEDIA_TEST_SUPPORT).  Because MEDIA_VIRTIO is placed inside the "Media
device types" filter menu with a dependency on VIDEO_DEV rather than under
"Media drivers" (or included in VIDEO_DEV's default rule), it stays hidden
unless an unrelated device category is enabled.

> diff --git a/drivers/media/virtio/virtio_media_driver.c b/drivers/media/v=
irtio/virtio_media_driver.c
> new file mode 100644
> index 0000000000000..39c5a38d20b1b
> --- /dev/null
> +++ b/drivers/media/virtio/virtio_media_driver.c
[ ... ]
> +static void commandq_callback(struct virtqueue *queue)
> +{
> +	unsigned int len;
> +	struct virtio_media_cmd_callback_param *param;
> +
> +process_bufs:
> +	while ((param =3D virtqueue_get_buf(queue, &len))) {
> +		param->resp_len =3D len;
> +		param->done =3D true;
> +		wake_up(&param->vv->wq);
> +	}
> +
> +	if (!virtqueue_enable_cb(queue)) {
> +		virtqueue_disable_cb(queue);
> +		goto process_bufs;
> +	}
> +}
> +
> +/**
> + * virtio_media_kick_command() - send a command to the commandq.
> + * @vv: virtio-media device in use.
> + * @sgs: descriptor chain to send.
> + * @out_sgs: number of device-readable descriptors in @sgs.
> + * @in_sgs: number of device-writable descriptors in @sgs.
> + * @resp_len: output parameter. Upon success, contains the size of the r=
esponse
> + *            in bytes.
> + */
> +static int virtio_media_kick_command(struct virtio_media *vv,
> +				     struct scatterlist **sgs,
> +				     const size_t out_sgs, const size_t in_sgs,
> +				     size_t *resp_len)
> +{
> +	struct virtio_media_cmd_callback_param cb_param =3D {
> +		.vv =3D vv,
> +		.done =3D false,
> +		.resp_len =3D 0,
> +	};
> +	struct virtio_media_resp_header *resp_header;
> +	int ret =3D virtqueue_add_sgs(vv->commandq, sgs, out_sgs, in_sgs,
> +		  &cb_param, GFP_ATOMIC);
> +	if (ret) {
> +		v4l2_err(&vv->v4l2_dev,
> +			 "failed to add sgs to command virtqueue\n");
> +		return ret;
> +	}
> +
> +	if (!virtqueue_kick(vv->commandq)) {
> +		v4l2_err(&vv->v4l2_dev, "failed to kick command virtqueue\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Wait for the response. */
> +	wait_event(vv->wq, cb_param.done);

[Severity: High]
Can commandq_callback() race with virtio_media_kick_command() on both the
stack-allocated cb_param and vv->commandq?

CPU0 (commandq_callback)          CPU1 (virtio_media_kick_command)
param =3D virtqueue_get_buf(...)
param->resp_len =3D len;
param->done =3D true;
                                  wait_event(vv->wq, cb_param.done)
                                    /* sees cb_param.done =3D=3D true */
                                  return 0; /* pops cb_param */
wake_up(&param->vv->wq);
  <-- stack use-after-return on param->vv

                                  /* next command under vv->vlock */
                                  virtqueue_add_sgs(vv->commandq, ...)
virtqueue_enable_cb(queue)        virtqueue_kick(vv->commandq)
  <-- concurrent unsynchronized virtqueue access

wait_event() checks cb_param.done before taking vv->wq.lock, so CPU1 can
observe param->done =3D=3D true and return from virtio_media_kick_command()
before CPU0 reads param->vv in wake_up(&param->vv->wq).  Once CPU1 wakes,
it or the next caller acquiring vv->vlock can also call virtqueue_add_sgs()
and virtqueue_kick() while commandq_callback() is still calling
virtqueue_get_buf(), virtqueue_enable_cb(), and virtqueue_disable_cb() on
vv->commandq without a spinlock, violating virtio_ring's caller
serialization requirement.

[Severity: Medium]
If virtqueue_kick() fails after virtqueue_add_sgs() succeeds, does
returning -EINVAL leave the stack address &cb_param and the caller's
command buffer queued in vv->commandq?

virtio_media_device_close() ignores the error from
virtio_media_session_close() and frees session while session->cmd.close is
still in the vring, and any later completion in commandq_callback() will
write through the dangling &cb_param stack pointer.  Also, once
virtqueue_kick() succeeds, wait_event(vv->wq, cb_param.done) sleeps
uninterruptibly under vv->vlock with no timeout or removal wake condition,
which will hang the caller and block virtio_media_remove() if the host
stops responding.

> +
> +	if (resp_len)
> +		*resp_len =3D cb_param.resp_len;
> +
> +	if (in_sgs > 0) {
> +		/*
> +		 * If we expect a response, make sure we have at least a
> +		 * response header - anything shorter is invalid.
> +		 */
> +		if (cb_param.resp_len < sizeof(*resp_header)) {
> +			v4l2_err(&vv->v4l2_dev,
> +				 "received response header is too short\n");
> +			return -EINVAL;
> +		}
> +
> +		resp_header =3D sg_virt(sgs[out_sgs]);
> +		if (resp_header->status)
> +			/* Host returns a positive error code. */
> +			return -resp_header->status;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Can negating the unsigned __le32 resp_header->status produce a positive
return value that virtio_media_send_command() treats as success?

Because resp_header->status is an unsigned 32-bit __le32,
-resp_header->status is computed in unsigned arithmetic before converting
to int.  If a buggy host writes a value with bit 31 set (such as a negative
errno like -EINVAL =3D 0xffffffea), virtio_media_kick_command() returns a
positive int, which bypasses the "if (ret < 0)" check in
virtio_media_send_command() and causes virtio_media_device_open() to
proceed with an invalid resp_open->session_id.  Status values between
MAX_ERRNO + 1 and 0x80000000 also yield negative values below -MAX_ERRNO
that VFS open() does not recognize as errors in IS_ERR().

In addition, resp_header->status, cmd_open->hdr.cmd, resp_open->session_id,
cmd_close->hdr.cmd, and cmd_close->session_id are all __le32 protocol
fields accessed without le32_to_cpu() / cpu_to_le32(), which triggers
Sparse -Wbitwise warnings.

[ ... ]

> +static void virtio_media_remove(struct virtio_device *virtio_dev)
> +{
> +	struct virtio_media *vv =3D virtio_dev->priv;
> +	struct list_head *p, *n;
> +
> +	/* Remove the video device to stop accessing the commandq virtqueue */
> +	video_unregister_device(&vv->video_dev);
> +
> +	/*
> +	 * Acquire vlock to ensure no concurrent accesses to the commandq
> +	 * virtqueue
> +	 */
> +	mutex_lock(&vv->vlock);
> +
> +	/* Stop all virtqueue callbacks */
> +	virtio_reset_device(virtio_dev);
> +
> +	/*
> +	 * Only detach the unused buffers to allow internal virtqueue clean up.
> +	 * The actual buffers are freed in virtio_media_release()
> +	 */
> +	while (virtqueue_detach_unused_buf(vv->commandq))
> +		;
> +
> +	/* Delete the virtqueues */
> +	virtio_dev->config->del_vqs(virtio_dev);
> +
> +	mutex_unlock(&vv->vlock);
> +
> +	list_for_each_safe(p, n, &vv->sessions) {
> +		struct virtio_media_session *s =3D
> +			list_entry(p, struct virtio_media_session, list);
> +
> +		virtio_media_session_remove(vv, s);
> +		virtio_media_session_free(s);
> +	}
> +
> +	v4l2_device_put(&vv->v4l2_dev);
> +}

[Severity: High]
What happens when a userspace process closes an open /dev/videoX file
descriptor during or after virtio_media_remove()?

video_unregister_device() prevents new opens, but existing open file
descriptors stay open until userspace closes them, at which point
v4l2_release() still invokes virtio_media_device_close().  Meanwhile,
virtio_media_remove() destroys vv->commandq via del_vqs() and frees every
active session in vv->sessions (without holding vv->sessions_lock across
the list walk), and virtio_media_session_free() -> v4l2_fh_del() sets
file->private_data =3D NULL.  When the open file descriptor is later closed,
virtio_media_device_close() computes session =3D
fh_to_session(file->private_data) (which is NULL, or a freed pointer if
virtio_media_device_close() raced with virtio_media_remove()), dereferences
session in virtio_media_session_close(), queues a command onto the already
deleted vv->commandq, and frees the session a second time.

> diff --git a/include/uapi/linux/virtio_media.h b/include/uapi/linux/virti=
o_media.h
> new file mode 100644
> index 0000000000000..ad05d742165c7
> --- /dev/null
> +++ b/include/uapi/linux/virtio_media.h
> @@ -0,0 +1,118 @@
[ ... ]
> +/**
> + * struct virtio_media_config - Video device configuration space.
> + * @device_caps: flags representing the device capabilities as used in &=
struct
> + *               v4l2_capability. It corresponds with the device_caps fi=
eld in
> + *               the &struct video_device
> + * @ device_type: informs the driver of the type of the video device. It
> + *                corresponds to with the ``vfl_devnod_type`` field of t=
he
> + *                device.
> + * @card: name of the device, a NUL-terminated UTF-8 string. It correspo=
nds
> + *        with the card field of the struct v4l2_capability. If all the
> + *        characters of the field are used, it does not need to be
> + *        NUL-terminated.
> + */
> +struct virtio_media_config {
> +	__le32 device_caps;
> +	__le32 device_type;
> +	__u8 card[32];
> +};
[ ... ]
> +#endif // _UAPI__LINUX_VIRTIO_MEDIA_H

[Severity: Low]
In include/uapi/linux/virtio_media.h, the space in "@ device_type:" keeps
scripts/kernel-doc from recognizing the member description, and the "//"
comment on the #endif line violates the C90 requirement (-std=3Dc90) for
exported UAPI headers.  In drivers/media/virtio/session.h and
drivers/media/virtio/virtio_media.h, scripts/kernel-doc also warns on
__dma_from_device_group_begin() and __dma_from_device_group_end() inside
the kernel-doc documented structs virtio_media_session and virtio_media.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121025007.3445=
723-1-briandaniels@google.com?part=3D1
