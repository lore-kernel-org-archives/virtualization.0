Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213195;
	b=oQorB+3zcfQDSiQ2fa/4KKZF48WI4kk9hsRFmMnjpOosMaVmNaI4t+0S74qreeXkYYSM
	 pVNgYkamYNGxB+xv/mgymluvCebDSFJKDb0fJZG8ulsPKvZsYWktcLas3ENM8PXTxcNTr
	 AHbt9xui0mi4738Lluh4oCoqY8ugHXcrFUtEdTW5W9jeSSPrScJRYNC79AL41u+K0sgnd
	 u8xaegSmb/L3Jr3NGLdTIV6PAQwWukjjhm2dPyWEBZ/5uHdJYFirGdhQNEImLuLBOt0Su
	 kh5ZS7/ee1V58ecckUhMVfomRAwIk223BNZ7i7ohWI5ln5/cPOmK+GrEiGdQlf2iDBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213195;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5HFP43GztLhbk6YsfU1UIDtaO9Af2qip43cVLkeNEpE=;
	b=3qBQgDy69PERh9kPhIU3QywzwLf5XB1HGmMhgh7kLd6cMREve40HLegl6jVnXF5reiMN
	 PXSvubQoB1VwJrKqzkNJttuZYcwIJ5hZFEq07FNPX4Qc7Lax9OKGUhcEQ7Wxe5Wo9vUQP
	 qiEZ+8dZzNq2K0WnzoIICQMR5jykSwAox4j3MgJwehiIsd7zxtOG8ZAJlXBtilNSi9eaX
	 TYgdmpqWxm2gIQJXbIUQRY1LiFVogJutDeLtqWVXVj38Hvjbg0dOQt1aRpPMWhOWjeK0W
	 dlqZyEdlRlNZIjo3jeJre4sfhkNihDa8o0jYutGQuaUVacRpd7vup2jT8LkcpbupPSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aA/WXSZO";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3762606A335
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 22:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aA/WXSZO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBA91F000CA;
	Fri, 20 Nov 2026 22:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795213195;
	bh=5HFP43GztLhbk6YsfU1UIDtaO9Af2qip43cVLkeNEpE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aA/WXSZOBV+//i50Ql0Fm5BEq5E7/GniK48U9QYBP2Mj8WeA0hHnYyUBiu38OKlL1
	 /Zq1AuVk+Y6sUDX191lhfneyv3IMMWjyJCi8rnjFomDrnXfvsvzp/mbzNiTo8KO2h4
	 mpRXy78IYhnespyamF9oDEofRZ4e/cG96AU0GRCqhOY2eRoAyX5a4z1z8QZMSl44i/
	 jU569+r9835ddl7dmar8B5zczYQjzndZTabkD0cqbEDk5YX+aQX2LW2yPsB01GxCHv
	 /7r5oF0L44If2CysRLtU2fWHDuWmrUiRVrAi+gPSsoGLGkGxF6iTIJsdHNffXBgK0s
	 QNgISwIF7I2Qg==
Message-ID: <sashiko-outbox-226244@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/6] media: virtio: Add core driver and session
 management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brian Daniels" <briandaniels@google.com>
Cc: virtualization@lists.linux.dev, media-ci@linuxtv.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261120215916.3149345-2-briandaniels@google.com>
References: <20261120215916.3149345-1-briandaniels@google.com>
 <20261120215916.3149345-2-briandaniels@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 22:19:54 +0000
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
- [High] media: virtio: unsynchronized commandq access and stack UAF on
  cb_param
- [High] media: virtio: stack cb_param left queued if virtqueue_kick()
  fails
- [Medium] media: virtio: unsigned status negation in
  virtio_media_kick_command()
- [Low] media: virtio: MEDIA_VIRTIO misplaced in device types Kconfig
  menu
- [Low] media: virtio: malformed kernel-doc and missing include in
  headers
--

commit c335528a6819af8be1759670843febeb88a66360
Author: Alexandre Courbot <gnurou@gmail.com>

media: virtio: Add core driver and session management

This commit adds the initial virtio-media driver core, build system
integration, V4L2 device registration, and session open/close lifecycle
handling over the command virtqueue.

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
Should MEDIA_VIRTIO be placed under the "Media drivers" menu instead of
"Media device types"?  When MEDIA_SUPPORT_FILTER is enabled, VIDEO_DEV is
hidden and only defaults to y if one of the device-type filter options
(such as MEDIA_CAMERA_SUPPORT or MEDIA_PLATFORM_SUPPORT) is selected, so
MEDIA_VIRTIO cannot be seen or enabled on its own.

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
Can commandq_callback() race with virtio_media_kick_command() on both
cb_param and vv->commandq?

CPU0                                  CPU1 (<hardirq>)
virtio_media_kick_command()
  virtqueue_add_sgs(..., &cb_param)
  virtqueue_kick(vv->commandq)
                                      commandq_callback()
                                        param =3D virtqueue_get_buf(...)
                                        param->done =3D true;
  wait_event(vv->wq, cb_param.done)
  return 0;                           /* cb_param stack frame popped */
                                        wake_up(&param->vv->wq);
                                          <-- stack use-after-return
  mutex_unlock(&vv->vlock)
  /* next command on CPU0 */
  mutex_lock(&vv->vlock)
  virtqueue_add_sgs(vv->commandq, ...)
                                        virtqueue_enable_cb(queue)
                                          <-- concurrent vq access

Virtqueue operations are not internally locked, and vv->vlock only
serializes process-context callers.  Once param->done is set to true, the
waiter on CPU0 can return from virtio_media_kick_command() before
commandq_callback() reads param->vv, and a subsequent command can call
virtqueue_add_sgs() or virtqueue_kick() concurrently with
virtqueue_get_buf() and virtqueue_enable_cb() in the interrupt handler.

In addition, wait_event() waits in TASK_UNINTERRUPTIBLE with no timeout
while holding vv->vlock, so an unresponsive device will hang the calling
task indefinitely and block virtio_media_remove().

[Severity: High]
What happens to the queued &cb_param token if virtqueue_kick() fails in
virtio_media_kick_command()?

At that point virtqueue_add_sgs() and virtqueue_kick_prepare() have
already published the descriptor chain and the stack-allocated &cb_param
pointer into vv->commandq.  Returning -EINVAL immediately pops the stack
frame (and in virtio_media_device_close() also frees session->cmd.close)
while the buffer remains queued, so a later completion on vv->commandq
will write to the popped stack frame in commandq_callback().

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
> +			/* Host returns a positive error code. */\n> +			return -resp_header-=
>status;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Can negating resp_header->status return a positive int or an invalid
errno?

resp_header->status is an unsigned 32-bit __le32.  If the device writes a
value with bit 31 set (for example, a negative 32-bit errno such as
0xffffffea), -resp_header->status evaluates in unsigned arithmetic and
converts to a positive int, which virtio_media_send_command() treats as
success because it only checks for ret < 0.  If resp_header->status is
between MAX_ERRNO + 1 (4096) and 0x80000000, the negative return value
propagates out of virtio_media_device_open() to VFS open, where
ERR_PTR(ret) does not satisfy IS_ERR() and is treated as a valid file
pointer.

Also, protocol fields marked __le32 in resp_header, cmd_open, resp_open,
and cmd_close are accessed directly without cpu_to_le32() and
le32_to_cpu(), which will trigger Sparse endianness warnings.

[ ... ]

> +static int virtio_media_device_close(struct file *file)
> +{
> +	struct video_device *video_dev =3D video_devdata(file);
> +	struct virtio_media *vv =3D to_virtio_media(video_dev);
> +	struct virtio_media_session *session =3D
> +		fh_to_session(file->private_data);
> +
> +	int ret =3D virtio_media_session_close(vv, session);
> +
> +	virtio_media_session_remove(vv, session);
> +	virtio_media_session_free(session);
> +
> +	return ret;
> +}
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
What happens when an open V4L2 file descriptor is closed after
virtio_media_remove() runs?

CPU0                                  CPU1
virtio_media_remove()
  video_unregister_device()
  ...
  virtio_dev->config->del_vqs()
  list_for_each_safe(..., &vv->sessions)
    virtio_media_session_remove(vv, s)
    virtio_media_session_free(s)
      v4l2_fh_del(&s->fh, s->file)
        /* sets file->private_data =3D NULL */
      kfree(s)
                                      v4l2_release(file)
                                        virtio_media_device_close(file)
                                          session =3D fh_to_session(NULL)
                                          virtio_media_session_close(vv, NU=
LL)
                                            cmd_close->hdr.cmd =3D ...
                                              <-- NULL pointer dereference

video_unregister_device() prevents new opens, but existing open file
descriptors still invoke virtio_media_device_close() when closed.  Because
virtio_media_remove() already destroyed vv->commandq, cleared
file->private_data via v4l2_fh_del(), and freed each session (while
iterating vv->sessions without holding vv->sessions_lock), closing the fd
afterward dereferences a NULL or freed session and accesses the deleted
vv->commandq virtqueue.

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
[ ... ]
> +#endif // _UAPI__LINUX_VIRTIO_MEDIA_H

[Severity: Low]
The space in "@ device_type:" prevents kernel-doc from recognizing the
member description, and the trailing "//" comment on #endif violates C90
comment rules for exported UAPI headers.  In addition,
drivers/media/virtio/session.h and drivers/media/virtio/virtio_media.h use
__dma_from_device_group_begin() and __dma_from_device_group_end() without
including <linux/dma-mapping.h>, and kernel-doc warns on those macros
inside kernel-doc annotated structs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120215916.3149=
345-1-briandaniels@google.com?part=3D1
