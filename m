Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793288971;
	b=lSZkSSOqz4zoJLvl+mV3bJFGWpRNR8k3wenGjbzLGnPr39pp3AOmFtTPbK54swckWspN
	 kL8OQnSkGK4k7x5bWAwPqsUrSXfAZyLx3wmHIYLijg6CCUsJ+4U2n3+/N2DKCN4K3raHw
	 muDe2uaY1ApfzX5ouFUCW+tCOzBufI76hntdvOMjeyi1SmyHz4ANnUjdYvPLmV277Z/qQ
	 fbhqF9lAMvIl84DJsnlKEPA8XYLCShRON4sLfkwYvt40qQ1xaM/cUk76D4khFWzNB4v1m
	 w/vOzC6Ggbp/A/+fHIh1/kcxvJGrdyxKgtuD6BJGNpBz4YshMjJeTPVfwuVvz6EEI3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793288971;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1nVL3d37zvK2XgdkIdbwnoQOs8EzL//9FTodGmD0EqQ=;
	b=Xubk0ECjfihxmNPORedGP3IQ9esWJDDZWcBG/o29FZHejIznYy0lUAJTt30Bjq98UZ/H
	 yRkZOX+jKuqlQDuk8/liFKFq1+e86wanasiPxStqr2W5Ls9ytYVPpp7hf8NuvijtQcoMK
	 9qlekwlT95ENMeT3jN4Vlsx/0jDwOsFxL9h+z87pQOs3a3mGRnoxmPMvENmJ/bgkBtgJM
	 DHKwUVG4MHpTJzQP+Teahp1LpO54gXDGh7z35LJJVO+A7Jl0AGopVzeOOD3hqbNVqBnwT
	 TMAAEWOHsiK4N9cae8nEw6LqdmDEAg+t9wFRVV10nsMuMMjg5yAEP6pilsgoBl1XvLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k3EqLe5d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48777606A31A
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k3EqLe5d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967641F01824;
	Thu, 29 Oct 2026 15:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793288970;
	bh=1nVL3d37zvK2XgdkIdbwnoQOs8EzL//9FTodGmD0EqQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k3EqLe5dj/V4L063yAboPS0APm9gYX3VKpDypq549Yi1OLvQWogiI4VB5Ki1aoFpk
	 oYC1cnpHWviBMTH1BWwL+yOWhuN7vN5NX1I08HTJBcFs+C64jhNxwjGLF3BZCEoX6H
	 loL4pcDi4ASveTMz//R4uKkx0paQyjUgeqvlvuTlj5A4YS63lFGFlavbOr8G3J1fRG
	 76ccKFPJD22jHBEs3KXfu5XdqyWa9Pa9xMgVEJqelULUoPkISJXXXD0xqm3eBVxpwZ
	 jcMOFZZP3pkzinfhI0Vnk6PiB+aof5FIY+CJJd8cpJwZFW+GGDJouuoBDlV9pnCJ3L
	 Gw0pVjjwRmZqw==
Message-ID: <sashiko-outbox-189640@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/5] media: virtio: Add core driver and session
 management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brian Daniels" <briandaniels@google.com>
Cc: virtualization@lists.linux.dev, media-ci@linuxtv.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261029153038.3800747-2-briandaniels@google.com>
References: <20261029153038.3800747-1-briandaniels@google.com>
 <20261029153038.3800747-2-briandaniels@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 15:49:29 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] media: virtio: UAF, NULL deref, and deadlock in virtio_media_r=
emove()
- [Critical] media: virtio: stack UAF and vq race in commandq_callback()
- [Critical] media: virtio: dangling stack cb_param on virtqueue_kick() fai=
lure
- [Critical] media: virtio: unvalidated status negation in virtio_media_kic=
k_command()
- [High] media: virtio: missing reset and caps check in virtio_media_probe()
- [Low] media: virtio: missing le32 conversions on virtio_media protocol fi=
elds
--

commit a1ad1972645a51f0e49e27a507fa954d0bc8dd41
Author: Alexandre Courbot <gnurou@gmail.com>

media: virtio: Add core driver and session management

This commit adds the initial virtio-media driver core, build system
integration, and V4L2 session lifecycle management via VIRTIO_MEDIA_CMD_OPEN
and VIRTIO_MEDIA_CMD_CLOSE over the command virtqueue.

> diff --git a/drivers/media/virtio/virtio_media_driver.c b/drivers/media/v=
irtio/virtio_media_driver.c
> new file mode 100644
> index 0000000000000..10073d863b574
> --- /dev/null
> +++ b/drivers/media/virtio/virtio_media_driver.c
> @@ -0,0 +1,503 @@

[ ... ]

> +static int virtio_media_session_close(struct virtio_media *vv,
> +				      struct virtio_media_session *session)
> +{
> +	struct virtio_media_cmd_close *cmd_close =3D &session->cmd.close;
> +	struct scatterlist cmd_sg =3D {};
> +	struct scatterlist *sgs[1] =3D { &cmd_sg };
> +	int ret;
> +
> +	mutex_lock(&vv->vlock);
> +
> +	cmd_close->hdr.cmd =3D VIRTIO_MEDIA_CMD_CLOSE;
> +	cmd_close->hdr.__reserved =3D 0;
> +	cmd_close->session_id =3D session->id;
> +	cmd_close->__reserved =3D 0;

[Severity: Low]
In virtio_media_session_close(), virtio_media_device_open(), and
virtio_media_kick_command(), the protocol fields hdr.cmd, hdr.status, and
session_id are declared as __le32 in include/uapi/linux/virtio_media.h, but
they are read and written directly as host integers.

Should these accesses use cpu_to_le32() and le32_to_cpu() to avoid sparse
endianness warnings when building with C=3D1?

[ ... ]

> +struct virtio_media_cmd_callback_param {
> +	struct virtio_media *vv;
> +	bool done;
> +	size_t resp_len;
> +};
> +
> +/**
> + * commandq_callback() - Callback for the command queue.
> + * @queue: command virtqueue.
> + *
> + * This just wakes up the thread that was waiting on the command to comp=
lete.
> + */
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

[Severity: Critical]
If virtqueue_kick() returns false here in virtio_media_kick_command(), the
stack-allocated cb_param token and the DMA-mapped caller scatterlists have
already been added to vv->commandq by virtqueue_add_sgs().

When virtio_media_kick_command() returns -EINVAL without detaching the unus=
ed
buffer or resetting the device, cb_param goes out of scope while still queu=
ed
in vv->commandq, and in the close path:

  virtio_media_device_close()
    virtio_media_session_close() -> fails with -EINVAL
    virtio_media_session_remove()
    virtio_media_session_free() -> kfree(session)

session->cmd.close is freed while still queued in the virtqueue. Could a
subsequent completion in commandq_callback() dereference the dangling stack
pointer param and access freed session memory?

> +
> +	/* Wait for the response. */
> +	wait_event(vv->wq, cb_param.done);

[Severity: Critical]
Can commandq_callback() race with virtio_media_kick_command() and trigger a
stack use-after-return or vring state corruption?

In virtio_media_kick_command(), cb_param lives on the stack, and wait_event=
()
checks cb_param.done locklessly in its fast path before taking the waitqueue
lock. In commandq_callback():

  param->resp_len =3D len;
  param->done =3D true;
  wake_up(&param->vv->wq);

As soon as param->done =3D true becomes visible on another CPU,
virtio_media_kick_command() can finish wait_event() and return from the
function before commandq_callback() evaluates &param->vv->wq on the next
line, dereferencing the popped stack frame (for example, queue->vdev->priv
could be used to reach vv instead of param->vv, or a struct completion could
be used). In addition, param->resp_len and param->done are written and read
without memory barriers (such as smp_store_release() and smp_load_acquire())
when wait_event() takes its lockless fast path.

Furthermore, callers serialize access to vv->commandq only with the mutex
vv->vlock, whereas commandq_callback() runs in interrupt context without a
spinlock. Once a woken caller returns, releases vv->vlock, and issues a new
virtqueue_add_sgs() and virtqueue_kick() (or virtio_media_remove() detaches
buffers), can that run concurrently with commandq_callback() still executing
virtqueue_get_buf() and virtqueue_enable_cb() on vv->commandq?

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

[Severity: Critical]
What happens if the host writes an out-of-range value into
resp_header->status (which is a 32-bit unsigned __le32)?

If resp_header->status has bit 31 set (0x80000001..0xffffffff, such as a
negative errno cast to u32), negating it yields a positive int when returned
from virtio_media_kick_command(). Because virtio_media_send_command() only
checks:

  if (ret < 0)
          return ret;

it treats positive return values as success and returns 0, causing
virtio_media_device_open() to succeed using an uninitialized or stale
resp_open->session_id.

Conversely, if resp_header->status is in (MAX_ERRNO, 0x80000000],
virtio_media_kick_command() returns a negative value smaller than -MAX_ERRN=
O.
When propagated from virtio_media_device_open() through v4l2_open() and
do_dentry_open() to path_openat(), ERR_PTR(ret) will not satisfy IS_ERR(),
which can cause VFS open to install an invalid pointer into the process file
descriptor table. Should status values outside 1..MAX_ERRNO be mapped to a
fallback error such as -EINVAL or -EIO?

[ ... ]

> +static int virtio_media_probe(struct virtio_device *virtio_dev)
> +{

[ ... ]

> +	virtio_cread_le(virtio_dev, struct virtio_media_config, device_caps,
> +			&vd->device_caps);
> +	if (vd->device_caps & (V4L2_CAP_VIDEO_M2M | V4L2_CAP_VIDEO_M2M_MPLANE))
> +		vd->vfl_dir =3D VFL_DIR_M2M;
> +	else if (vd->device_caps &
> +		 (V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_VIDEO_OUTPUT_MPLANE))
> +		vd->vfl_dir =3D VFL_DIR_TX;
> +	else
> +		vd->vfl_dir =3D VFL_DIR_RX;
> +
> +	virtio_device_ready(virtio_dev);
> +
> +	__u32 device_type;
> +
> +	virtio_cread_le(virtio_dev, struct virtio_media_config, device_type,
> +			&device_type);
> +	if (device_type >=3D VFL_TYPE_MAX) {
> +		dev_err(&virtio_dev->dev, "Invalid device_type: %u",
> +			device_type);
> +		ret =3D -EINVAL;
> +		goto err_del_vqs;
> +	}
> +
> +	ret =3D video_register_device(vd, device_type, -1);
> +	if (ret)
> +		goto err_del_vqs;
> +
> +	return 0;
> +
> +err_del_vqs:
> +	virtio_dev->config->del_vqs(virtio_dev);
> +err_v4l2_device_unregister:
> +	v4l2_device_unregister(&vv->v4l2_dev);
> +err_free_virtio_media:
> +	kfree(vv);
> +	return ret;
> +}

[Severity: High]
In virtio_media_probe(), virtio_device_ready(virtio_dev) is called before
validating device_type and before video_register_device(). If either check
fails and jumps to err_del_vqs, virtio_dev->config->del_vqs(virtio_dev) and
kfree(vv) are called without calling virtio_reset_device(virtio_dev) first,
leaving VIRTIO_CONFIG_S_DRIVER_OK set while the virtqueues and driver state
are freed.

In addition, vd->device_caps is read from config space without checking that
it is non-zero; if device_type !=3D VFL_TYPE_SUBDEV and vd->device_caps =3D=
=3D 0,
__video_register_device() triggers a WARN_ON(!vdev->device_caps) and fails
into err_del_vqs.

Should vd->device_caps and device_type be validated before
virtio_device_ready(), and should err_del_vqs reset the virtio device before
deleting the virtqueues?

> +
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

[Severity: Critical]
What happens in virtio_media_remove() if the virtio device is unbound or
hot-unplugged while userspace still has an open file descriptor (or an
in-flight open/close)?

First, video_unregister_device() only clears V4L2_FL_REGISTERED and unlinks
the device node; it does not close open struct file instances or wait for
in-flight file operations. In virtio_media_remove(), the loop over
vv->sessions (which also iterates without holding vv->sessions_lock) frees
every active session via virtio_media_session_free(), which calls:

  virtio_media_session_fh_del(session)
    v4l2_fh_del(&session->fh, session->file)
      filp->private_data =3D NULL;
  kfree(session);

and virtio_dev->config->del_vqs(virtio_dev) frees vv->commandq. When
userspace later closes its open file descriptor, v4l2_release() still invok=
es
virtio_media_device_close():

  virtio_media_device_close(file)
    session =3D fh_to_session(file->private_data); -> NULL (or freed sessio=
n)
    virtio_media_session_close(vv, session)
      cmd_close->session_id =3D session->id; -> NULL dereference / UAF
      virtio_media_send_command(vv, ...) -> uses deleted vv->commandq (UAF)
    virtio_media_session_remove(vv, session);
    virtio_media_session_free(session); -> double free

Similarly, a concurrent virtio_media_device_open() or
virtio_media_device_close() waiting on mutex_lock(&vv->vlock) during
virtio_media_remove() will acquire vv->vlock after del_vqs() has already
destroyed vv->commandq and attempt to submit a command on the freed
virtqueue.

Second, if a command is in flight in virtio_media_kick_command() waiting in
uninterruptible wait_event(vv->wq, cb_param.done) while holding vv->vlock a=
nd
the device stops responding during hot-unplug, won't virtio_media_remove()
deadlock forever on mutex_lock(&vv->vlock) before it can reach
virtio_reset_device()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029153038.3800=
747-1-briandaniels@google.com?part=3D1
