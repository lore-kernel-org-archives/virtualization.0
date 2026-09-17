Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4A13D75AA
	for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667550; cv=none; b=l9Sc9uWn1gh5oIKoIQvSq4l8jTQsgV04kztbQnmmd9ILl0+3ONZGcjvsL21Iz/ct8apt5Qe7n8z0sdWU7+r9wiFzAjfLMP5CPdbbzFNR7E+uo8N1I3/FpaqO8k6BXb+ylBQqwuUnspTZodxJfQEmPKFow/KucjmkRXG1Kr74I0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667550; c=relaxed/simple;
	bh=aYWtCBZNmZnY6crBo1K1Qjqqf/JxikwpJ14Z//x4aMc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XS0/ln6kBPR1y+1W/eNhgTLzua9ZQ1EFB3UE3NYLYVRMHc0ZpqWLXthj7L/enYsUreO3xlSPvRUZOMsBXEiut7bsoRzThSQwoBmvDE7ttoKqC+aQ7RxvBYAKoRAtZDeCwDJDpJhCn62nAeCVWIPerYh6Go+wIkwBjmfKKdGoxhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nwy8txj9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nwy8txj9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AAB1F00893;
	Thu, 17 Sep 2026 17:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789667549;
	bh=HUo/Bsk1NCZIgY4Kk5ADNTyemG0dm5i7uaGY8/I+D70=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nwy8txj9b0dAvT0liCrxOeYxLTWf2hTn0IgwwiSO5OAfSd0D+jDDuAs/+dez0zxmA
	 2aFnuhpWcaeMXKYv3LUFacMaeyNAaWoMUx1x4UlHxL8Bs/Uxx8wWyeHspyhA8C+xNp
	 IRHhunLeuv/FJOHG+9ruxy23UbhKVF1xS4lh9J/HtZks4umljcf5kMIFxWRP349lkC
	 ti6qDSH162j/OKqtv9gcV0yjgwGFm6sX6PBt5YAzMYsC4EDgi1QBxZGmIzB2dFKqNX
	 BKKmAznltFEZnTN+xBTW40kH8/mmqmhPhAlMUJDIgFWlnIqLWcB7+qrKB1omSuOlHI
	 sbC1ERTk9Uq6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/4] media: virtio: Add session management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brian Daniels" <briandaniels@google.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, media-ci@linuxtv.org
In-Reply-To: <20260917171921.2810550-3-briandaniels@google.com>
References: <20260917171921.2810550-1-briandaniels@google.com>
 <20260917171921.2810550-3-briandaniels@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 17:52:28 +0000
Message-Id: <20260917175228.D2AAB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 12 potential issue=
(s) to consider:
- [Critical] virtio: stack use-after-free in virtio_media_kick_command() on=
 timeout
- [High] virtio: use-after-free of video_device on file operations after un=
bind
- [High] virtio: null pointer dereference in virtio_media_device_close() af=
ter error event
- [High] virtio: memory leak and UAF on session close failure
- [High] virtio: workqueue use-after-free due to wrong teardown order
- [High] virtio: data race and DMA corruption on command timeout
- [High] virtio: virtqueue use-after-free from concurrent file operations d=
uring remove
- [High] virtio: ABI mismatch due to architecture-dependent v4l2_buffer in =
virtio payload
- [Medium] virtio: kick and device registration before DRIVER_OK
- [Medium] virtio: host session resource leak on local allocation failure
- [Medium] virtio: list corruption via duplicate DQBUF events
- [Medium] virtio: DMA mapping leak from pending eventq buffers
--

commit 14a36656b931432d8f2ab367b1f02ad0cec5fe5f
Author: Alexandre Courbot <gnurou@gmail.com>

media: virtio: Add session management
   =20
This patch adds session management to the virtio-media driver.
A session is created when the /dev/videoX device is opened, and destroyed w=
hen it is closed.

> diff --git a/drivers/media/virtio/virtio_media_driver.c b/drivers/media/v=
irtio/virtio_media_driver.c
> index 25f2ceaa6c480..ef8065e344929 100644
> --- a/drivers/media/virtio/virtio_media_driver.c
> +++ b/drivers/media/virtio/virtio_media_driver.c

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

[Severity: High]
When virtio_media_process_events() receives VIRTIO_MEDIA_EVT_ERROR, it calls
virtio_media_session_close() which frees the session and sets the file's
private_data to NULL. If userspace later closes the file,
virtio_media_device_close() will pass the resulting NULL session pointer he=
re.

Could this dereference a null pointer if the session was already closed due=
 to
an error event?

> +	cmd_close->session_id =3D session->id;
> +
> +	sg_set_buf(&cmd_sg, cmd_close, sizeof(*cmd_close));
> +	sg_mark_end(&cmd_sg);
> +
> +	ret =3D virtio_media_send_command(vv, sgs, 1, 0, 0, NULL);
> +	mutex_unlock(&vv->vlock);
> +	if (ret < 0)
> +		return ret;

[Severity: High]
If virtio_media_send_command() fails (for example due to a timeout), this e=
rror
path returns early without calling virtio_media_session_free(). The VFS will
still destroy the file structure, leaving a dangling pointer in the un-freed
session object that will be accessed during driver removal when it iterates
over vv->sessions.

Does this leak the session memory and cause a use-after-free later?

> +
> +	virtio_media_session_free(vv, session);
> +
> +	return 0;
> +}

[ ... ]

> +static void commandq_callback(struct virtqueue *queue)
> +{
> +	unsigned int len;
> +	struct virtio_media_cmd_callback_param *param;
> +
> +process_bufs:
> +	while ((param =3D virtqueue_get_buf(queue, &len))) {
> +		param->done =3D true;
> +		param->resp_len =3D len;

[Severity: Critical]
If wait_event_timeout() in virtio_media_kick_command() expires, the function
returns and the stack frame containing cb_param is popped. When the host
eventually completes the command, the callback will overwrite whatever is n=
ow
at that stack location.

Can this write to stale stack memory?

> +		wake_up(&param->vv->wq);
> +	}

[ ... ]

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

[ ... ]

> +	/* Wait for the response. */
> +	ret =3D wait_event_timeout(vv->wq, cb_param.done, 5 * HZ);
> +	if (ret =3D=3D 0) {
> +		v4l2_err(&vv->v4l2_dev,
> +			 "timed out waiting for response to command\n");
> +		return -ETIMEDOUT;

[Severity: Critical]
Because cb_param is allocated on the stack, returning here destroys the sta=
ck
frame. If the host completes the command later, commandq_callback() will wr=
ite
to the param->done and param->resp_len fields, which now point to popped
stack memory.

Is it safe to return here without aborting the command on the host?

> +	}

[ ... ]

> +static void
> +virtio_media_process_dqbuf_event(struct virtio_media *vv,
> +				 struct virtio_media_session *session,
> +				 struct virtio_media_event_dqbuf *dqbuf_evt)

[Severity: High]
The virtio-media protocol uses struct v4l2_buffer within its event payloads.
This structure contains a struct timeval, whose size varies between 32-bit =
and
64-bit architectures. A 32-bit guest running on a 64-bit host will encounter
misaligned fields following the timestamp, breaking the virtio ABI.

Does casting the event payload to struct v4l2_buffer create an ABI mismatch?

> +{
> +	struct virtio_media_buffer *dqbuf;
> +	const enum v4l2_buf_type queue_type =3D dqbuf_evt->buffer.type;

[ ... ]

> +	/* Set the DONE flag as the buffer is waiting to be dequeued. */
> +	dqbuf->buffer.flags |=3D V4L2_BUF_FLAG_DONE;
> +
> +	mutex_lock(&session->queues_lock);
> +	list_add_tail(&dqbuf->list, &queue->pending_dqbufs);

[Severity: Medium]
Since the list_add_tail() is unconditional, receiving a duplicate event will
link the node while it is already linked.

What happens if the host sends duplicate DQBUF events for the same buffer i=
ndex?

> +	queue->queued_bufs -=3D 1;
> +	mutex_unlock(&session->queues_lock);

[ ... ]

> +static int virtio_media_device_open(struct file *file)
> +{
> +	struct video_device *video_dev =3D video_devdata(file);
> +	struct virtio_media *vv =3D to_virtio_media(video_dev);
> +	struct virtio_media_cmd_open *cmd_open =3D &vv->cmd.open;
> +	struct virtio_media_resp_open *resp_open =3D &vv->resp.open;

[Severity: High]
The command and response buffers are shared in the virtio_media structure. =
If a
command times out, virtio_media_send_command() drops the lock and returns. A
subsequent open() will acquire the lock and overwrite these buffers while t=
he
host might concurrently read or write them for the timed-out command, corru=
pting
DMA memory.

Are these shared device-level buffers protected from concurrent modificatio=
n on
timeout?

> +	struct scatterlist cmd_sg =3D {}, resp_sg =3D {};

[ ... ]

> +	ret =3D virtio_media_send_command(vv, sgs, 1, 1, sizeof(*resp_open),
> +					NULL);
> +	session_id =3D resp_open->session_id;
> +	mutex_unlock(&vv->vlock);
> +	if (ret < 0)
> +		return ret;
> +
> +	session =3D virtio_media_session_alloc(vv, session_id, file);
> +	if (IS_ERR(session))
> +		return PTR_ERR(session);

[Severity: Medium]
If virtio_media_session_alloc() fails, the driver returns an error to VFS, =
but
the VIRTIO_MEDIA_CMD_OPEN command has already been successfully executed on=
 the
host. Because no CLOSE command is sent in the error path, this leaks the se=
ssion
resources on the virtio host device.

Will this leave a dangling session on the host on allocation failure?

> +
> +	file->private_data =3D &session->fh;
> +
> +	return 0;
> +}

[ ... ]

> +static int virtio_media_probe(struct virtio_device *virtio_dev)
> +{
> +	struct device *dev =3D &virtio_dev->dev;
> +	struct virtqueue *vqs[2];
> +	static struct virtqueue_info vq_info[2] =3D {
> +		{
> +			.name =3D "command",
> +			.callback =3D commandq_callback,
> +		},
> +		{
> +			.name =3D "event",
> +			.callback =3D eventq_callback,
> +		},
> +	};
> +	struct virtio_media *vv;
> +	struct video_device *vd;
> +	int i;
> +	int ret;
> +
> +	vv =3D devm_kzalloc(dev, sizeof(*vv), GFP_KERNEL);

[Severity: High]
By allocating vv with devres and using video_device_release_empty, the memo=
ry is
freed immediately upon device unbind. If userspace has an open file descrip=
tor,
later file operations or closing the file will trigger VFS callbacks that a=
ccess
the freed video_device embedded in vv.

Does this break the expected V4L2 refcounting mechanism?

> +	if (!vv)
> +		return -ENOMEM;

[ ... ]

> +	vd =3D &vv->video_dev;
> +	vd->v4l2_dev =3D &vv->v4l2_dev;
> +	vd->vfl_type =3D VFL_TYPE_VIDEO;
> +	vd->fops =3D &virtio_media_fops;
> +	vd->release =3D video_device_release_empty;

[ ... ]

> +	ret =3D video_register_device(vd, virtio_cread32(virtio_dev, 4), 0);
> +	if (ret)
> +		goto err_register_device;
> +
> +	for (i =3D 0; i < VIRTIO_MEDIA_NUM_EVENT_BUFS; i++) {
> +		void *ebuf =3D vv->event_buffer +
> +			     virtio_media_event_aligned_size * i;
> +
> +		ret =3D virtio_media_send_event_buffer(vv, ebuf);
> +		if (ret)
> +			goto err_send_event_buffer;
> +	}
> +
> +	virtio_device_ready(virtio_dev);

[Severity: Medium]
virtio_media_send_event_buffer() kicks the event virtqueue, and
video_register_device() makes the device visible to userspace, both before
virtio_device_ready() sets DRIVER_OK. The Virtio specification forbids send=
ing
buffer available notifications before DRIVER_OK.

Is it permitted to expose the device to userspace and kick virtqueues before
setting DRIVER_OK?

> +
> +	return 0;

[ ... ]

> +static void virtio_media_remove(struct virtio_device *virtio_dev)
> +{
> +	struct virtio_media *vv =3D virtio_dev->priv;
> +	struct list_head *p, *n;
> +
> +	cancel_work_sync(&vv->eventq_work);
> +	virtio_reset_device(virtio_dev);

[Severity: High]
Because cancel_work_sync() is called before virtio_reset_device(), the devi=
ce
is still active and can generate event interrupts. If an interrupt fires,
eventq_callback() will schedule the work again. When the driver subsequently
frees vv, the pending work will execute and access freed memory.

Can the workqueue be rescheduled after cancellation?

> +	v4l2_device_unregister(&vv->v4l2_dev);
> +	virtio_dev->config->del_vqs(virtio_dev);

[Severity: High]
del_vqs() is called here without acquiring vv->vlock or waiting for concurr=
ent
file operations to finish. A concurrent ioctl or close operation could exec=
ute
virtio_media_send_command() and attempt to add descriptors to the deleted
vv->commandq.

Can concurrent file operations access the virtqueues after they are deleted?

[Severity: Medium]
During probe, buffers are mapped and added to the event queue. Calling del_=
vqs()
without first calling virtqueue_detach_unused_buf() leaves these pending bu=
ffers
unretrieved, leaking the DMA mappings and consuming IOMMU space.

Does deleting the virtqueues here leak DMA mappings?

> +	video_unregister_device(&vv->video_dev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917171921.2810=
550-1-briandaniels@google.com?part=3D2
