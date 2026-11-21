Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795231206;
	b=KW32UVTFO/C1ihyfnp5n6yFQMsB7yMEHM21FOaBf+5gjfsYKQqO92hcWeWKr1dbtEzoI
	 ugHxJzqZY20tAOg7Jw4KEodndfpdLxoWVnl/vB7rgEHl8nyhtI9VXa3yNmFi/cY2tptCG
	 U8U3QxiQLW8vhbwhHFgqS0z7KGeZf7VzyCMcmQzP9mCSjWeEN3lgKp/POLoUxpDHIb5s+
	 Lpi1DwvHDfCpmIVLnD5xMsKUoq5Jb0VFmV6GcYa2GvMWV3oWEvtJi+d73IUw/swUbGX3J
	 WG4kurfFWcT8qrkAqz07TMbGVtrdjWUeW5yobynHHRfsQ297ukMYT7tTZVxigdqJ4Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795231206;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=98ATWkn0YWRw+IRriM4MfxP4X0xANgfCmSzR6S8uKEI=;
	b=eDLfZzXxCVi02Y+tb8q1X18oFqCyv36VgEA4ETWTF60904MyjgOMW0okpyuvuWMwSBIM
	 tjDTtngFAdbJydaPgzsfx3sGnnBAGmj/kvlrekF/gVsDtMkYp84BiVBUeBItoyrP8aH9F
	 AQvY8goLKmGWNXH9B4oAminYBYroncgZSZJYc77nnmEb8qsDS/oz/UG1AFmCXlLZTTDq2
	 JK2CYdyURb/ChnEoMxty52xIZXP8ZpX97YarnVX3csvReFm4G+p954yPo+++7j8Y+5/DR
	 2LdUL/u5dAUQdP2wAuqBcICWhAVJxRQPna68UMzNn1jXxtQE5Gb6elYcyanAW0aozMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lfl4E2j3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EE3606A6A3
	for <virtualization@lists.linux.dev>; Sat, 21 Nov 2026 03:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lfl4E2j3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A283E1F000C0;
	Sat, 21 Nov 2026 03:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795231205;
	bh=98ATWkn0YWRw+IRriM4MfxP4X0xANgfCmSzR6S8uKEI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lfl4E2j3tc6XemdPiW1V0UEicVVPIwRaiBaf/kGlM8vOTTL7LMU+fKByz4b/CekP6
	 STwvTC8ls/JF8W82jszMIerZde1czGFqm0DekbJsRGqCaS3SM9H+eBoJ8nnqwEKJ+w
	 vrwXn8Xq/XMax857rdbygD8dotxgWKs0aWIzLqj7P7hi24qmhAALyxFod4hjodicMg
	 Qx3shBIPZsn2as8rSAgRs6SUDrG3FskYmgNjrjWGcPhARZX8a0tSRvZMoSkzzakT7x
	 95hBgE56MgdBQxFXLLQMMasoj9NpO9ImcQnXiDcJlxsI9bxVghTaaKRkQTqutFuaOH
	 9EgAcQxVNg9aQ==
Message-ID: <sashiko-outbox-226569@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 4/6] media: virtio: Add buffer streaming, event
 handling, and poll
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brian Daniels" <briandaniels@google.com>
Cc: virtualization@lists.linux.dev, media-ci@linuxtv.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261121025007.3445723-5-briandaniels@google.com>
References: <20261121025007.3445723-1-briandaniels@google.com>
 <20261121025007.3445723-5-briandaniels@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 03:20:05 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 19 potential
issues to consider:
- [High] media: virtio: use-after-free races in
  virtio_media_process_events()
- [High] media: virtio: deadlock between vlock and events_lock in event
  handling
- [High] media: virtio: use-after-free of pending_dqbufs in create_bufs
  and reqbufs
- [High] media: virtio: missing queues_lock and state check on queue and
  dqbuf state
- [High] media: virtio: cancel_work_sync() before virtio_reset_device()
  on teardown
- [High] media: virtio: OOB access and leak in reqbufs and create_bufs
- [High] media: virtio: hang on streamoff and O_NONBLOCK bugs in
  virtio_media_dqbuf()
- [High] media: virtio: device-wide vlock deadlock on blocking
  VIDIOC_DQEVENT
- [High] media: virtio: missing multiplanar planes validation in buffer
  ioctls
- [High] media: virtio: wrong response SG index in
  virtio_media_send_buffer_ioctl()
- [High] media: virtio: stack memory mapped for DMA in
  scatterlist_builder_add_data()
- [High] media: virtio: broken poll state checks in
  virtio_media_device_poll()
- [High] media: virtio: infinite wait in virtio_media_dqbuf() on
  streamoff
- [Medium] media: virtio: premature video_register_device() and
  incomplete probe unwind
- [Medium] media: virtio: missing mplane and cap handling in
  virtio_media_create_bufs()
- [Medium] media: virtio: MMAP buffer offsets overwritten on
  VIDIOC_DQBUF
- [Low] media: virtio: missing kernel-doc for error_lock in
  virtio_media_session
- [Low] media: virtio: uninitialized resp_len in
  virtio_media_send_buffer_ioctl()
- [Low] media: virtio: missing virtqueue_disable_cb() and unbatched
  kicks on eventq
--

commit e79e0e915b239b29517f1a3fac8fe93a0a091be8
Author: Alexandre Courbot <gnurou@gmail.com>

media: virtio: Add buffer streaming, event handling, and poll

This commit adds V4L2 buffer and streaming ioctls, asynchronous event
virtqueue handling, V4L2 event subscription, and poll support to the
virtio-media driver.

> diff --git a/drivers/media/virtio/scatterlist_builder.c b/drivers/media/v=
irtio/scatterlist_builder.c
> index 631c7b13c438c..f01df04cdbad9 100644
> --- a/drivers/media/virtio/scatterlist_builder.c
> +++ b/drivers/media/virtio/scatterlist_builder.c
> @@ -356,6 +356,78 @@ static int scatterlist_builder_add_userptr(struct sc=
atterlist_builder *builder,
>  	return 0;
>  }
> =20
> +/**
> + * scatterlist_builder_add_buffer() - Add a &struct v4l2_buffer and its =
planes
> + *                                    to the descriptor chain.
> + * @builder: builder to use.
> + * @b: &struct v4l2_buffer to add.
> + */
> +int scatterlist_builder_add_buffer(struct scatterlist_builder *builder,
> +				   struct v4l2_buffer *b)
> +{
> +	int ret;
> +
> +	/* v4l2_buffer */
> +	ret =3D scatterlist_builder_add_data(builder, b, sizeof(*b));

[Severity: High]
Does passing b to scatterlist_builder_add_data() DMA-map kernel stack
memory?

video_usercopy() allocates ioctl payloads up to 128 bytes in char
sbuf[128] on the kernel stack, which includes struct v4l2_buffer (88
bytes), struct v4l2_requestbuffers, struct v4l2_event_subscription, and
struct v4l2_decoder_cmd, while virtio_media_streamon() and
virtio_media_streamoff() pass &i from their own stack frames.  Because
scatterlist_builder_add_data() checks virt_addr_valid() and
is_vmalloc_addr() without checking !object_is_on_stack(data), both
non-VMAP_STACK and CONFIG_VMAP_STACK=3Dy kernels map stack pages directly
into virtqueue scatterlists instead of copying through
builder->shadow_buffer, violating the DMA API rules and risking stack
corruption on non-coherent architectures.

> +	if (ret)
> +		return ret;
> +
> +	if (V4L2_TYPE_IS_MULTIPLANAR(b->type) && b->length > 0) {
> +		/* Array of v4l2_planes */
> +		ret =3D scatterlist_builder_add_data(builder, b->m.planes,
> +						   sizeof(struct v4l2_plane) *
> +							   b->length);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

> diff --git a/drivers/media/virtio/session.h b/drivers/media/virtio/sessio=
n.h
> index 6fe7ff5ae02c5..16bb86bf480de 100644
> --- a/drivers/media/virtio/session.h
> +++ b/drivers/media/virtio/session.h

[ ... ]

> @@ -35,12 +73,19 @@
>   *              be staged before being sent to the device.
>   * @command_sgs: SG table gathering descriptors for a given command and =
its
>   *               response.
> + * @queues: state of all the queues for this session.
> + * @queues_lock: protects all members for the queues for this session.
> + * @dqbuf_wait: waitqueue for dequeued buffers, if ``VIDIOC_DQBUF`` need=
s to
> + *              block or when polling.
> + * @error: true if the session has encountered an unrecoverable session =
error.
>   * @list: link into the list of sessions for the device.
>   */
>  struct virtio_media_session {

[ ... ]

> +	struct virtio_media_queue_state queues[VIRTIO_MEDIA_LAST_QUEUE + 1];
> +	struct mutex queues_lock; /* protects queues array and states */
> +	wait_queue_head_t dqbuf_wait;
> +	bool error;
> +	struct mutex error_lock; /* protects error */
> +
>  	struct list_head list;
>  };

[Severity: Low]
The kernel-doc comment for struct virtio_media_session is missing an
@error_lock entry, which will trigger a kernel-doc warning under W=3D1.

> diff --git a/drivers/media/virtio/virtio_media_driver.c b/drivers/media/v=
irtio/virtio_media_driver.c
> index 0fe20cf508212..7483577256bd0 100644
> --- a/drivers/media/virtio/virtio_media_driver.c
> +++ b/drivers/media/virtio/virtio_media_driver.c

[ ... ]

> @@ -152,6 +174,31 @@ static int virtio_media_session_close(struct virtio_=
media *vv,
>  	return 0;
>  }
> =20
> +/**
> + * virtio_media_find_session() - Look up a session with a given ID.
> + * @vv: virtio-media device to lookup the session from.
> + * @id: ID of the session to lookup.
> + */
> +static struct virtio_media_session *
> +virtio_media_find_session(struct virtio_media *vv, u32 id)
> +{
> +	struct list_head *p;
> +	struct virtio_media_session *session =3D NULL;
> +
> +	mutex_lock(&vv->sessions_lock);
> +	list_for_each(p, &vv->sessions) {
> +		struct virtio_media_session *s =3D
> +			list_entry(p, struct virtio_media_session, list);
> +		if (s->id =3D=3D id) {
> +			session =3D s;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&vv->sessions_lock);
> +
> +	return session;
> +}

[ ... ]

> @@ -290,6 +337,234 @@ int virtio_media_send_command(struct virtio_media *=
vv, struct scatterlist **sgs,
>  	return 0;
>  }
> =20
> +/**
> + * virtio_media_send_event_buffer() - Sends an event buffer to the host =
so it
> + * can return it with an event.
> + * @vv: virtio-media device in use.
> + * @event_buffer: pointer to the event buffer to send to the device.
> + */
> +static int virtio_media_send_event_buffer(struct virtio_media *vv,
> +					  void *event_buffer)
> +{
> +	struct scatterlist *sgs[1], vresp;
> +	int ret;
> +
> +	sg_init_one(&vresp, event_buffer, VIRTIO_MEDIA_EVENT_MAX_SIZE);
> +	sgs[0] =3D &vresp;
> +
> +	ret =3D virtqueue_add_sgs(vv->eventq, sgs, 0, 1, event_buffer,
> +				GFP_ATOMIC);
> +	if (ret) {
> +		v4l2_err(&vv->v4l2_dev,
> +			 "failed to add sgs to event virtqueue\n");
> +		return ret;
> +	}
> +
> +	if (!virtqueue_kick(vv->eventq)) {
> +		v4l2_err(&vv->v4l2_dev, "failed to kick event virtqueue\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * eventq_callback() - Callback for the event queue.
> + * @queue: event virtqueue.
> + *
> + * This just schedules for event work to be run.
> + */
> +static void eventq_callback(struct virtqueue *queue)
> +{
> +	struct virtio_media *vv =3D queue->vdev->priv;
> +
> +	schedule_work(&vv->eventq_work);
> +}
> +
> +/**
> + * virtio_media_process_dqbuf_event() - Process a dequeued event for a s=
ession.
> + * @vv: virtio-media device in use.
> + * @session: session the event is addressed to.
> + * @dqbuf_evt: the dequeued event to process.
> + *
> + * Invalid events are ignored with an error log.
> + */
> +static void
> +virtio_media_process_dqbuf_event(struct virtio_media *vv,
> +				 struct virtio_media_session *session,
> +				 struct virtio_media_event_dqbuf *dqbuf_evt)
> +{
> +	struct virtio_media_buffer *dqbuf;
> +	const enum v4l2_buf_type queue_type =3D dqbuf_evt->buffer.type;
> +	struct virtio_media_queue_state *queue;
> +	typeof(dqbuf->buffer.m) buffer_m;
> +	typeof(dqbuf->buffer.m.planes[0].m) plane_m;
> +	int i;
> +
> +	if (queue_type >=3D ARRAY_SIZE(session->queues)) {
> +		v4l2_err(&vv->v4l2_dev,
> +			 "unmanaged queue %d passed to dqbuf event",
> +			 dqbuf_evt->buffer.type);
> +		return;
> +	}
> +	queue =3D &session->queues[queue_type];
> +
> +	if (dqbuf_evt->buffer.index >=3D queue->allocated_bufs) {
> +		v4l2_err(&vv->v4l2_dev,
> +			 "invalid buffer ID %d for queue %d in dqbuf event",
> +			 dqbuf_evt->buffer.index, dqbuf_evt->buffer.type);
> +		return;
> +	}
> +
> +	dqbuf =3D &queue->buffers[dqbuf_evt->buffer.index];
> +
> +	/*
> +	 * Preserve the 'm' union that was passed to us during QBUF so userspace
> +	 * gets back the information it submitted.
> +	 */
> +	buffer_m =3D dqbuf->buffer.m;
> +	memcpy(&dqbuf->buffer, &dqbuf_evt->buffer, sizeof(dqbuf->buffer));
> +	dqbuf->buffer.m =3D buffer_m;
> +	if (V4L2_TYPE_IS_MULTIPLANAR(dqbuf->buffer.type)) {
> +		if (dqbuf->buffer.length > VIDEO_MAX_PLANES) {
> +			v4l2_err(&vv->v4l2_dev,
> +				 "invalid number of planes received from host for a multiplanar buff=
er\n");
> +			return;
> +		}
> +		for (i =3D 0; i < dqbuf->buffer.length; i++) {
> +			plane_m =3D dqbuf->planes[i].m;
> +			memcpy(&dqbuf->planes[i], &dqbuf_evt->planes[i],
> +			       sizeof(struct v4l2_plane));
> +			dqbuf->planes[i].m =3D plane_m;
> +		}
> +	}

[Severity: Medium]
Does preserving dqbuf->buffer.m and dqbuf->planes[i].m across QBUF and
DQBUF clobber the MMAP offsets returned by the host?

For V4L2_MEMORY_MMAP buffers, m.offset and planes[i].m.mem_offset are
output fields returned by the driver, and userspace typically leaves them
zeroed when calling VIDIOC_PREPARE_BUF or VIDIOC_QBUF.  Restoring the
pre-QBUF m union here overwrites the host's MMAP offsets on VIDIOC_DQBUF.

> +
> +	/* Set the DONE flag as the buffer is waiting to be dequeued. */
> +	dqbuf->buffer.flags |=3D V4L2_BUF_FLAG_DONE;
> +
> +	mutex_lock(&session->queues_lock);
> +	list_add_tail(&dqbuf->list, &queue->pending_dqbufs);
> +	queue->queued_bufs -=3D 1;
> +	mutex_unlock(&session->queues_lock);

[Severity: High]
Can virtio_media_process_dqbuf_event() race with queue state changes and
corrupt queue->buffers, queue->pending_dqbufs, or queue->queued_bufs?

CPU0 (kworker)                        CPU1 (ioctl)
virtio_media_process_dqbuf_event()
  if (idx >=3D queue->allocated_bufs)
  dqbuf =3D &queue->buffers[idx];
                                      virtio_media_reqbufs()
                                        vfree(queue->buffers);
  memcpy(&dqbuf->buffer, ...);
    <-- use-after-free

queue->allocated_bufs and queue->buffers are accessed here before
acquiring session->queues_lock, while virtio_media_reqbufs(),
virtio_media_create_bufs(), virtio_media_qbuf(), virtio_media_querybuf(),
virtio_media_prepare_buf(), virtio_media_dqbuf(), virtio_media_streamon(),
and virtio_media_decoder_cmd() read and mutate queue fields and
queue->queued_bufs under vv->vlock without holding session->queues_lock.

In addition, list_add_tail() and queue->queued_bufs -=3D 1 run without
checking under session->queues_lock that the buffer still has
V4L2_BUF_FLAG_QUEUED set (for example, if an in-flight DQBUF event arrives
just after VIDIOC_STREAMOFF called virtio_media_clear_queue(), or if a
duplicate event arrives), which corrupts queue->pending_dqbufs and
underflows queue->queued_bufs to SIZE_MAX.

> +
> +	wake_up(&session->dqbuf_wait);
> +}
> +
> +/**
> + * virtio_media_process_events() - Process all pending events on a devic=
e.
> + * @vv: device whose pending events we want to process.
> + *
> + * Retrieves all pending events on @vv's event queue and dispatches them=
 to
> + * their corresponding session.
> + *
> + * Invalid events are ignored with an error log.
> + */
> +void virtio_media_process_events(struct virtio_media *vv)
> +{
> +	struct virtio_media_event_error *error_evt;
> +	struct virtio_media_event_dqbuf *dqbuf_evt;
> +	struct virtio_media_event_event *event_evt;
> +	struct virtio_media_session *session;
> +	struct virtio_media_event_header *evt;
> +	unsigned int len;
> +
> +	mutex_lock(&vv->events_lock);
> +
> +process_bufs:
> +	while ((evt =3D virtqueue_get_buf(vv->eventq, &len))) {
> +		/* Make sure we received enough data */
> +		if (len < sizeof(*evt)) {
> +			v4l2_err(&vv->v4l2_dev,
> +				 "event is too short: got %u, expected at least %zu\n",
> +				 len, sizeof(*evt));
> +			goto end_of_event;
> +		}
> +
> +		session =3D virtio_media_find_session(vv, evt->session_id);
> +		if (!session) {
> +			v4l2_err(&vv->v4l2_dev, "cannot find session %d\n",
> +				 evt->session_id);
> +			goto end_of_event;
> +		}
> +
> +		switch (evt->event) {
> +		case VIRTIO_MEDIA_EVT_ERROR:
> +			if (len < sizeof(*error_evt)) {
> +				v4l2_err(&vv->v4l2_dev,
> +					 "error event is too short: got %u, expected %zu\n",
> +					 len, sizeof(*error_evt));
> +				break;
> +			}
> +			error_evt =3D (struct virtio_media_event_error *)evt;
> +			v4l2_err(&vv->v4l2_dev,
> +				 "received error %d for session %d",
> +				 error_evt->error, error_evt->hdr.session_id);
> +
> +			mutex_lock(&session->error_lock);
> +			session->error =3D true;
> +			mutex_unlock(&session->error_lock);
> +
> +			virtio_media_session_close(vv, session);

[Severity: High]
Does calling virtio_media_session_close() while holding vv->events_lock
cause an ABBA deadlock (and a recursive lock deadlock) with vv->vlock?

CPU0                              CPU1
----                              ----
mutex_lock(&vv->vlock)
                                  mutex_lock(&vv->events_lock)
mutex_lock(&vv->events_lock)
                                  mutex_lock(&vv->vlock)

 *** DEADLOCK ***

CPU0: virtio_media_device_ioctl() -> ... -> virtio_media_subscribe_event()
        -> virtio_media_process_events()
CPU1: virtio_media_event_work() -> virtio_media_process_events()
        -> virtio_media_session_close()

Furthermore, if a VIRTIO_MEDIA_EVT_ERROR event is processed during the
direct call to virtio_media_process_events() from
virtio_media_subscribe_event(), the current thread already holds vv->vlock
from virtio_media_device_ioctl() and immediately self-deadlocks when
virtio_media_session_close() tries to take vv->vlock again.

> +
> +			/* Wake up any waiting dqbuf requests */
> +			wake_up(&session->dqbuf_wait);
> +
> +			break;

[ ... ]

> +end_of_event:
> +		virtio_media_send_event_buffer(vv, evt);
> +	}
> +
> +	if (!virtqueue_enable_cb(vv->eventq)) {
> +		virtqueue_disable_cb(vv->eventq);
> +		goto process_bufs;
> +	}
> +
> +	mutex_unlock(&vv->events_lock);
> +}

[Severity: Low]
Neither eventq_callback() nor the entry to virtio_media_process_events()
calls virtqueue_disable_cb(vv->eventq) before the initial loop, so the
first pass drains vv->eventq with callbacks still enabled in the shared
ring (incurring a memory barrier per buffer and allowing redundant
interrupts while work is already running).  Also,
virtio_media_send_event_buffer() calls virtqueue_kick() on every buffer
instead of batching the kick after the loops in
virtio_media_process_events() and virtio_media_probe().

[ ... ]

> @@ -350,7 +625,16 @@ static int virtio_media_device_close(struct file *fi=
le)
>  	struct virtio_media_session *session =3D
>  		fh_to_session(file->private_data);
> =20
> -	int ret =3D virtio_media_session_close(vv, session);
> +	mutex_lock(&session->error_lock);
> +	bool session_error =3D session->error;
> +
> +	mutex_unlock(&session->error_lock);
> +
> +	int ret =3D 0;
> +
> +	/* If session is in an error state, then it has already been closed */
> +	if (!session_error)
> +		ret =3D virtio_media_session_close(vv, session);
> =20
>  	virtio_media_session_remove(vv, session);
>  	virtio_media_session_free(session);

[Severity: High]
Can virtio_media_device_close() free session while
virtio_media_process_events() is still using it?

CPU0 (kworker)                        CPU1 (close)
virtio_media_process_events()
  session =3D virtio_media_find_session()
                                      virtio_media_device_close()
                                        virtio_media_session_close()
                                        virtio_media_session_remove()
                                        virtio_media_session_free(session)
  virtio_media_process_dqbuf_event()
    queue =3D &session->queues[...];
      <-- use-after-free

virtio_media_find_session() drops vv->sessions_lock before returning the
raw session pointer, and virtio_media_device_close() does not synchronize
with vv->events_lock before freeing session.

Even on VIRTIO_MEDIA_EVT_ERROR, virtio_media_process_events() sets
session->error =3D true and drops session->error_lock before calling
virtio_media_session_close() and wake_up(&session->dqbuf_wait).  A
concurrent virtio_media_device_close() seeing session_error =3D=3D true ski=
ps
virtio_media_session_close() and immediately frees session while
virtio_media_process_events() is still closing and waking it; conversely,
if virtio_media_device_close() checks session->error just before
VIRTIO_MEDIA_EVT_ERROR sets it, both paths call
virtio_media_session_close().  And because virtio_media_device_ioctl()
checks session->error only before acquiring vv->vlock, an ioctl blocked on
vv->vlock while VIRTIO_MEDIA_EVT_ERROR closes the session will proceed and
send a command for a closed host session.

> =20
>  	return ret;
>  }
> =20
> +/**
> + * virtio_media_device_poll() - Poll logic for a virtio-media device.
> + * @file: file of the session to poll.
> + * @wait: poll table to wait on.
> + */
> +static __poll_t virtio_media_device_poll(struct file *file, poll_table *=
wait)
> +{
> +	struct virtio_media_session *session =3D
> +		fh_to_session(file->private_data);
> +	enum v4l2_buf_type capture_type =3D
> +		session->uses_mplane ? V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE :
> +				       V4L2_BUF_TYPE_VIDEO_CAPTURE;
> +	enum v4l2_buf_type output_type =3D
> +		session->uses_mplane ? V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE :
> +				       V4L2_BUF_TYPE_VIDEO_OUTPUT;
> +	struct virtio_media_queue_state *capture_queue =3D
> +		&session->queues[capture_type];
> +	struct virtio_media_queue_state *output_queue =3D
> +		&session->queues[output_type];
> +	__poll_t req_events =3D poll_requested_events(wait);
> +	__poll_t rc =3D 0;
> +
> +	poll_wait(file, &session->dqbuf_wait, wait);
> +	poll_wait(file, &session->fh.wait, wait);
> +
> +	mutex_lock(&session->error_lock);
> +	if (session->error)
> +		rc |=3D EPOLLERR;
> +	mutex_unlock(&session->error_lock);
> +
> +	mutex_lock(&session->queues_lock);
> +	if (req_events & (EPOLLIN | EPOLLRDNORM)) {
> +		if (!capture_queue->streaming ||
> +		    (capture_queue->queued_bufs =3D=3D 0 &&
> +		     list_empty(&capture_queue->pending_dqbufs)))
> +			rc |=3D EPOLLERR;
> +		else if (!list_empty(&capture_queue->pending_dqbufs) ||
> +			 capture_queue->is_capture_last)
> +			rc |=3D EPOLLIN | EPOLLRDNORM;
> +	}
> +	if (req_events & (EPOLLOUT | EPOLLWRNORM)) {
> +		if (!output_queue->streaming)
> +			rc |=3D EPOLLERR;
> +		else if (output_queue->queued_bufs <
> +			 output_queue->allocated_bufs)
> +			rc |=3D EPOLLOUT | EPOLLWRNORM;
> +	}
> +	mutex_unlock(&session->queues_lock);

[Severity: High]
Does virtio_media_device_poll() return premature EPOLLERR and EPOLLOUT
events?

First, when the last capture buffer (with V4L2_BUF_FLAG_LAST) has been
dequeued, capture_queue->is_capture_last is true, queued_bufs is 0, and
pending_dqbufs is empty; because the first if condition does not check
!capture_queue->is_capture_last, it takes the EPOLLERR branch instead of
reaching the else-if branch that returns EPOLLIN | EPOLLRDNORM for the
subsequent -EPIPE dequeue.

Second, for EPOLLOUT | EPOLLWRNORM, checking output_queue->queued_bufs <
output_queue->allocated_bufs signals writability whenever any allocated
output buffer is not currently queued on the host (for example right after
VIDIOC_REQBUFS/STREAMON or after a buffer was already dequeued), even when
output_queue->pending_dqbufs is empty and VIDIOC_DQBUF would return
-EAGAIN.

Third, when userspace polls with both EPOLLIN and EPOLLOUT while only one
queue is streaming (such as during M2M header parsing or resolution
change), the non-streaming queue unconditionally sets EPOLLERR.

[ ... ]

> @@ -449,13 +809,34 @@ static int virtio_media_probe(struct virtio_device =
*virtio_dev)
>  	if (ret)
>  		goto err_del_vqs;
> =20
> +	mutex_lock(&vv->events_lock);
> +
> +	for (i =3D 0; i < VIRTIO_MEDIA_NUM_EVENT_BUFS; i++) {
> +		void *ebuf =3D vv->event_buffer +
> +			     virtio_media_event_aligned_size * i;
> +
> +		ret =3D virtio_media_send_event_buffer(vv, ebuf);
> +		if (ret)
> +			break;
> +	}
> +
> +	mutex_unlock(&vv->events_lock);
> +
> +	if (ret)
> +		goto err_video_unregister_device;
> +
>  	return 0;
> =20
> +err_video_unregister_device:
> +	video_unregister_device(&vv->video_dev);
>  err_del_vqs:
> +	cancel_work_sync(&vv->eventq_work);
>  	virtio_reset_device(virtio_dev);
>  	virtio_dev->config->del_vqs(virtio_dev);
>  err_v4l2_device_unregister:
>  	v4l2_device_unregister(&vv->v4l2_dev);
> +err_free_event_buffer:
> +	kfree(vv->event_buffer);
>  err_free_virtio_media:
>  	kfree(vv);
>  	return ret;
> @@ -469,6 +850,9 @@ static void virtio_media_remove(struct virtio_device =
*virtio_dev)
>  	/* Remove the video device to stop accessing the commandq virtqueue */
>  	video_unregister_device(&vv->video_dev);
> =20
> +	/* Stop event handling work queue from accessing eventq virtqueue */
> +	cancel_work_sync(&vv->eventq_work);
> +
>  	/*
>  	 * Acquire vlock to ensure no concurrent accesses to the commandq
>  	 * virtqueue
>  	 */
>  	mutex_lock(&vv->vlock);
> =20
>  	/* Stop all virtqueue callbacks */
>  	virtio_reset_device(virtio_dev);

[Severity: High]
Can eventq_callback() re-schedule vv->eventq_work after cancel_work_sync()
because virtio_reset_device() has not run yet?

CPU0                              CPU1 (<hardirq>)
virtio_media_remove()
  cancel_work_sync(&vv->eventq_work)
                                  eventq_callback()
                                    schedule_work(&vv->eventq_work)
  virtio_reset_device(virtio_dev)
  del_vqs(virtio_dev)
  v4l2_device_put(&vv->v4l2_dev)
    kfree(vv)
                                  virtio_media_event_work()
                                    virtio_media_process_events(vv)
                                      <-- use-after-free

The same ordering issue exists in the err_del_vqs error path of
virtio_media_probe().  virtio_reset_device() needs to stop virtqueue
callbacks before cancel_work_sync(&vv->eventq_work) drains the work item.

[Severity: Medium]
Also in virtio_media_probe(), shouldn't the event buffers be queued on
vv->eventq before video_register_device() exposes the device node to
userspace?

If virtio_media_send_event_buffer() fails partway through the loop after
video_register_device() has already succeeded, err_del_vqs calls
virtio_dev->config->del_vqs() without detaching the already-queued eventq
buffers via virtqueue_detach_unused_buf(vv->eventq), and if userspace has
already opened the video device, jumping to err_free_event_buffer and
err_free_virtio_media directly frees vv->event_buffer and vv instead of
waiting for virtio_media_release() via v4l2_device_put().

> diff --git a/drivers/media/virtio/virtio_media_ioctls.c b/drivers/media/v=
irtio/virtio_media_ioctls.c
> index d0ea743e793bd..aa56efe9a08c2 100644
> --- a/drivers/media/virtio/virtio_media_ioctls.c
> +++ b/drivers/media/virtio/virtio_media_ioctls.c

[ ... ]

> @@ -221,6 +223,101 @@ static int virtio_media_send_wr_ioctl(struct v4l2_f=
h *fh, u32 ioctl,
>  	return 0;
>  }
> =20
> +/**
> + * virtio_media_send_buffer_ioctl() - Send an ioctl taking a buffer as
> + * parameter to the device.
> + * @fh: file handler of the session doing the ioctl.
> + * @ioctl: ``VIDIOC_*`` ioctl code.
> + * @b: &struct v4l2_buffer to be sent as the ioctl payload.
> + *
> + * Buffers can require an additional descriptor to send their planes arr=
ay, and
> + * can have pointers to userspace memory hence this dedicated function.
> + */
> +static int virtio_media_send_buffer_ioctl(struct v4l2_fh *fh, u32 ioctl,
> +					  struct v4l2_buffer *b)
> +{

[ ... ]

> +	size_t resp_len;

[Severity: Low]
Is resp_len left uninitialized before being passed to
virtio_media_send_command()?  virtio_media_send_command() reads *resp_len
on entry (size_t local_resp_len =3D resp_len ? *resp_len : 0;), which reads
an uninitialized stack value.

> +	int ret;
> +	int i;
> +
> +	if (b->type > VIRTIO_MEDIA_LAST_QUEUE)
> +		return -EINVAL;
> +
> +	if (V4L2_TYPE_IS_MULTIPLANAR(b->type))
> +		orig_planes =3D b->m.planes;
> +
> +	/* Command descriptor */
> +	ret =3D scatterlist_builder_add_ioctl_cmd(&builder, session, ioctl);
> +	if (ret)
> +		return ret;
> +
> +	/* Command payload (struct v4l2_buffer) */
> +	ret =3D scatterlist_builder_add_buffer(&builder, b);
> +	if (ret < 0)
> +		return ret;
> +
> +	end_buf_sg =3D builder.cur_sg;
> +	num_cmd_sgs =3D builder.cur_sg;
> +
> +	/* Response descriptor */
> +	ret =3D scatterlist_builder_add_ioctl_resp(&builder, session);
> +	if (ret)
> +		return ret;
> +
> +	/* Response payload (same as input, but no userptr mapping) */
> +	for (i =3D 1; i < end_buf_sg; i++) {
> +		ret =3D scatterlist_builder_add_descriptor(&builder, i);
> +		if (ret < 0)
> +			return ret;
> +	}

[Severity: High]
Does passing i (an index up to builder.cur_sg) as desc_index to
scatterlist_builder_add_descriptor() attach the wrong descriptors when a
vmalloc buffer spans non-contiguous pages?

In scatterlist_builder_add_data(), a vmalloc buffer crossing a boundary
between two non-contiguous pages consumes two entries in builder.descs[]
(say descs[1] and descs[2]) while adding only one entry to builder.sgs[]
(sgs[1] =3D &descs[1]), so builder.cur_desc and builder.cur_sg diverge.
For a multiplanar buffer whose planes array is then placed at descs[3]
(with end_buf_sg =3D builder.cur_sg =3D 3), this loop adds &descs[1] and
&descs[2] as the writable response descriptors, mapping the second page of
b twice and omitting descs[3] (b->m.planes).

[ ... ]

> @@ -488,6 +620,431 @@ static int virtio_media_try_ext_ctrls(struct file *=
file, void *fh,

[ ... ]

> +static int virtio_media_reqbufs(struct file *file, void *fh,
> +				struct v4l2_requestbuffers *b)
> +{
> +	struct v4l2_fh *vfh =3D file_to_v4l2_fh(file);
> +	struct virtio_media_session *session =3D fh_to_session(vfh);
> +	struct virtio_media_buffer *buffers =3D NULL;
> +	struct virtio_media_queue_state *queue;
> +	int ret;
> +
> +	if (b->type > VIRTIO_MEDIA_LAST_QUEUE)
> +		return -EINVAL;
> +
> +	if (b->memory =3D=3D V4L2_MEMORY_USERPTR)
> +		return -EINVAL;
> +
> +	if (b->count > 0) {
> +		buffers =3D
> +			vcalloc(b->count, sizeof(struct virtio_media_buffer));
> +		if (!buffers)
> +			return -ENOMEM;
> +	}
> +
> +	ret =3D virtio_media_send_wr_ioctl(vfh, VIDIOC_REQBUFS, b, sizeof(*b),
> +					 sizeof(*b));
> +	if (ret) {
> +		vfree(buffers);
> +		return ret;
> +	}
> +
> +	queue =3D &session->queues[b->type];
> +
> +	/* REQBUFS(0) is an implicit STREAMOFF. */
> +	if (b->count =3D=3D 0)
> +		virtio_media_clear_queue(session, queue);
> +
> +	vfree(queue->buffers);
> +	queue->buffers =3D buffers;
> +
> +	queue->allocated_bufs =3D b->count;

[Severity: High]
Can queue->allocated_bufs exceed the size of the vcalloc()-allocated
queue->buffers array when the host increases b->count?

V4L2 drivers commonly clamp b->count up to a queue's minimum buffer
requirement in VIDIOC_REQBUFS.  Because buffers is allocated using the
caller's initial b->count before virtio_media_send_wr_ioctl(), but
queue->allocated_bufs is set to the host-returned b->count, any buffer
index between the requested count and the returned count will index
queue->buffers out of bounds.

The same issue occurs in virtio_media_create_bufs() below if the host
returns b->index + b->count larger than the pre-allocated
queue->allocated_bufs + initial b->count, or if b->count was > 0 on entry
and the host returns b->count =3D=3D 0, where virtio_media_create_bufs()
returns early without calling vfree(buffers) and leaks the allocation.

[ ... ]

> +static int virtio_media_create_bufs(struct file *file, void *fh,
> +				    struct v4l2_create_buffers *b)
> +{
> +	struct v4l2_fh *vfh =3D file_to_v4l2_fh(file);
> +	struct virtio_media_session *session =3D fh_to_session(vfh);
> +	struct virtio_media_queue_state *queue;
> +	struct virtio_media_buffer *buffers =3D NULL;
> +	u32 type =3D b->format.type;
> +	int ret;
> +
> +	if (type > VIRTIO_MEDIA_LAST_QUEUE)
> +		return -EINVAL;
> +
> +	queue =3D &session->queues[type];
> +
> +	if (b->count > 0) {
> +		/*
> +		 * This allocates a new buffer large enough for the existing
> +		 * buffers (``queue->allocated_bufs``) as well as the newly
> +		 * requested buffers (``b->count``). The host may allocate
> +		 * fewer buffers than requested, as indicated by the final
> +		 * value of ``b->count``. In this case, we do not re-allocate
> +		 * to avoid the case where this new allocation fails and the
> +		 * host buffers need to be freed. Instead we simply use the
> +		 * larger buffer.
> +		 */
> +		buffers =3D vcalloc(queue->allocated_bufs + b->count,
> +				  sizeof(*queue->buffers));
> +		if (!buffers)
> +			return -ENOMEM;
> +	}
> +
> +	ret =3D virtio_media_send_wr_ioctl(vfh, VIDIOC_CREATE_BUFS, b, sizeof(*=
b),
> +					 sizeof(*b));
> +	if (ret) {
> +		if (buffers)
> +			vfree(buffers);
> +
> +		return ret;
> +	}
> +
> +	/* If count is zero, we were just checking for format. */
> +	if (b->count =3D=3D 0)
> +		return 0;
> +
> +	memcpy(buffers, queue->buffers,
> +	       sizeof(*queue->buffers) * queue->allocated_bufs);
> +	vfree(queue->buffers);
> +	queue->buffers =3D buffers;
> +
> +	queue->allocated_bufs =3D b->index + b->count;
> +
> +	return 0;
> +}

[Severity: High]
Does copying queue->buffers with memcpy() and freeing the old array leave
dangling list_head pointers in queue->pending_dqbufs?

Each struct virtio_media_buffer embeds a struct list_head list node that
is linked into queue->pending_dqbufs when a buffer is awaiting dequeue.
Reallocating queue->buffers via memcpy() and vfree(queue->buffers) without
fixing up linked list nodes (or clearing queue->pending_dqbufs when
virtio_media_reqbufs() is called with b->count > 0) leaves
queue->pending_dqbufs pointing into freed vmalloc memory, causing a
use-after-free on the next VIDIOC_DQBUF or VIDIOC_STREAMOFF.

[Severity: Medium]
Unlike virtio_media_reqbufs(), virtio_media_create_bufs() also does not
reject b->memory =3D=3D V4L2_MEMORY_USERPTR, does not clear
V4L2_BUF_CAP_SUPPORTS_USERPTR and V4L2_BUF_CAP_SUPPORTS_DMABUF from
b->capabilities, and does not set session->uses_mplane =3D true when
V4L2_TYPE_IS_MULTIPLANAR(type) is true (which causes
virtio_media_device_poll() to poll the inactive single-planar queues and
return EPOLLERR when buffers were allocated with VIDIOC_CREATE_BUFS).

[ ... ]

> +static int virtio_media_dqbuf(struct file *file, void *fh,
> +			      struct v4l2_buffer *b)
> +{
> +	struct video_device *video_dev =3D video_devdata(file);
> +	struct virtio_media *vv =3D to_virtio_media(video_dev);
> +	struct virtio_media_session *session =3D
> +		fh_to_session(file_to_v4l2_fh(file));
> +	struct virtio_media_buffer *dqbuf;
> +	struct virtio_media_queue_state *queue;
> +	struct list_head *buffer_queue;
> +	struct v4l2_plane *planes_backup =3D NULL;
> +	const bool is_multiplanar =3D V4L2_TYPE_IS_MULTIPLANAR(b->type);
> +	int ret;
> +	bool error;
> +
> +	if (b->type > VIRTIO_MEDIA_LAST_QUEUE)
> +		return -EINVAL;
> +
> +	queue =3D &session->queues[b->type];
> +
> +	/*
> +	 * If a buffer with the LAST flag has been returned, subsequent
> +	 * calls to DQBUF must return -EPIPE until the queue is cleared.
> +	 */
> +	if (queue->is_capture_last)
> +		return -EPIPE;
> +
> +	buffer_queue =3D &queue->pending_dqbufs;
> +
> +	if (session->nonblocking_dequeue) {
> +		if (list_empty(buffer_queue))
> +			return -EAGAIN;
> +	} else if (queue->allocated_bufs =3D=3D 0) {
> +		return -EINVAL;
> +	} else if (!queue->streaming) {
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * vv->lock has been acquired by virtio_media_device_ioctl. Release it
> +	 * while we wait so that other ioctls for this session can be processed
> +	 * and potentially trigger dqbuf_wait.
> +	 */
> +	mutex_unlock(&vv->vlock);
> +
> +	/*
> +	 * It's not possible to acquire ``session->error_lock`` during the
> +	 * check, however this shouldn't cause issues because:
> +	 *     - The lock is acquired when actually checking the value
> +	 *     - The ``session->error`` flag is never reset once set
> +	 */
> +	ret =3D wait_event_interruptible(session->dqbuf_wait,
> +				       !list_empty(buffer_queue) ||
> +				       session->error);
> +	mutex_lock(&vv->vlock);

[Severity: High]
Will a thread blocked in wait_event_interruptible() here hang forever if
another thread calls VIDIOC_STREAMOFF or VIDIOC_REQBUFS(0)?

virtio_media_clear_queue() clears queue->pending_dqbufs and sets
queue->streaming =3D false, but never calls wake_up(&session->dqbuf_wait),
and !queue->streaming is not part of the wait condition here.

In addition:
- While vv->vlock is dropped across wait_event_interruptible(),
  virtio_media_remove() can acquire and release vv->vlock and then free
  all sessions in vv->sessions while virtio_media_dqbuf() is still
  sleeping on session->dqbuf_wait, causing a use-after-free when
  virtio_media_dqbuf() wakes.
- Caching session->nonblocking_dequeue at open() time ignores O_NONBLOCK
  changes made later via fcntl(F_SETFL).
- Putting queue->allocated_bufs =3D=3D 0 and !queue->streaming in else-if
  branches after if (session->nonblocking_dequeue) makes non-blocking
  calls on unallocated or stopped queues return -EAGAIN instead of
  -EINVAL, and when buffer_queue is non-empty on a non-blocking call,
  execution still drops vv->vlock and enters wait_event_interruptible().

> +	if (ret)
> +		return -EINTR;
> +
> +	mutex_lock(&session->error_lock);
> +	error =3D session->error;
> +	mutex_unlock(&session->error_lock);
> +
> +	if (error)
> +		return -EIO;
> +
> +	mutex_lock(&session->queues_lock);
> +	dqbuf =3D list_first_entry_or_null(buffer_queue,
> +					 struct virtio_media_buffer, list);
> +
> +	if (dqbuf)
> +		list_del(&dqbuf->list);
> +
> +	mutex_unlock(&session->queues_lock);
> +
> +	if (!dqbuf) {
> +		v4l2_err(&vv->v4l2_dev, "No buffer found when dqbuf event triggered\n"=
);
> +		return -EIO;
> +	}
> +
> +	/* Clear the DONE flag as the buffer is now being dequeued. */
> +	dqbuf->buffer.flags &=3D ~V4L2_BUF_FLAG_DONE;
> +
> +	if (is_multiplanar) {
> +		size_t nb_planes =3D min_t(u32, b->length, VIDEO_MAX_PLANES);
> +
> +		memcpy(b->m.planes, dqbuf->planes,
> +		       nb_planes * sizeof(struct v4l2_plane));
> +		planes_backup =3D b->m.planes;
> +	}
> +
> +	memcpy(b, &dqbuf->buffer, sizeof(*b));
> +
> +	if (is_multiplanar)
> +		b->m.planes =3D planes_backup;

[Severity: High]
Can a multiplanar buffer ioctl with a small or zero b->length cause an
out-of-bounds kernel heap read or dereference an untranslated user
pointer?

In drivers/media/v4l2-core/v4l2-ioctl.c, check_array_args() and
video_usercopy() only allocate a kernel array_buf for b->m.planes when
b->length > 0, and size it to b->length elements:

drivers/media/v4l2-core/v4l2-ioctl.c:check_array_args() {
    ...
	if (V4L2_TYPE_IS_MULTIPLANAR(buf->type) && buf->length > 0) {
		if (buf->length > VIDEO_MAX_PLANES) {
			ret =3D -EINVAL;
			break;
		}
		*user_ptr =3D (void __user *)buf->m.planes;
		*kernel_ptr =3D (void **)&buf->m.planes;
		ret =3D sizeof(struct v4l2_plane) * buf->length;
	}
    ...
}

If a 32-bit compat caller passes 0 < b->length < dqbuf->buffer.length to
VIDIOC_DQBUF (or if the host returns an increased b->length in
virtio_media_send_buffer_ioctl()), overwriting *b sets b->length to the
larger plane count while b->m.planes still points to the smaller
array_buf, causing v4l2_compat_put_array_args() (and v4l_print_buffer())
to read past the end of array_buf and copy out-of-bounds kernel heap
memory to userspace.

If b->length =3D=3D 0 and b->m.planes !=3D NULL, video_usercopy() leaves
b->m.planes as the raw userspace pointer: virtio_media_dqbuf() consumes
the buffer and sets b->length =3D dqbuf->buffer.length > 0 with an
untranslated user pointer in b->m.planes, while
virtio_media_send_buffer_ioctl() passes a non-NULL orig_planes to
scatterlist_builder_retrieve_buffer() even though
scatterlist_builder_add_buffer() skipped adding a planes SG descriptor.

[ ... ]

> @@ -701,6 +1304,9 @@ const struct v4l2_ioctl_ops virtio_media_ioctl_ops =
=3D {
>  	.vidioc_g_edid =3D NULL,
>  	.vidioc_s_edid =3D NULL,
> =20
> +	.vidioc_subscribe_event =3D virtio_media_subscribe_event,
> +	.vidioc_unsubscribe_event =3D virtio_media_unsubscribe_event,
> +
>  	/* For other private ioctls */
>  	.vidioc_default =3D NULL,
>  };
> @@ -714,9 +1320,19 @@ long virtio_media_device_ioctl(struct file *file, u=
nsigned int cmd,
>  	struct v4l2_standard standard;
>  	v4l2_std_id std_id =3D 0;
>  	int ret;
> +	bool error;
> =20
> -	if (test_bit(V4L2_FL_USES_V4L2_FH, &video_dev->flags))
> +	if (test_bit(V4L2_FL_USES_V4L2_FH, &video_dev->flags)) {
>  		vfh =3D file_to_v4l2_fh(file);
> +		struct virtio_media_session *session =3D fh_to_session(vfh);
> +
> +		mutex_lock(&session->error_lock);
> +		error =3D session->error;
> +		mutex_unlock(&session->error_lock);
> +
> +		if (error)
> +			return -EIO;
> +	}
> =20
>  	mutex_lock(&vv->vlock);

[Severity: High]
Does enabling event subscription here cause a blocking VIDIOC_DQEVENT call
to sleep with vv->vlock held?

In drivers/media/v4l2-core/v4l2-event.c, v4l2_event_dequeue() only unlocks
fh->vdev->lock while waiting on fh->wait.  Because vv->video_dev.lock is
NULL and virtio_media_device_ioctl() acquires vv->vlock manually before
calling video_ioctl2(), a blocking VIDIOC_DQEVENT call when no event is
queued will sleep holding vv->vlock and block all other ioctls, opens, and
closes across the entire virtio-media device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121025007.3445=
723-1-briandaniels@google.com?part=3D4
