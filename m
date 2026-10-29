Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293223;
	b=GFqAdwh5mhbctsODXDTicJtdbHOK6GMf+AI5o2eSqGKAmBG1NTrHQGl6ta+0OPIJQwdE
	 a26Wpu2jm3tMdUx+lqgoMsCtl2sw0iFUi1KAlAZan6A1vB2gHqnWjGaVgIvtp4vVONEBe
	 U198BiODOsspJ9U7oYSjJPGr1h7vUKY0+Yfa6oZ7QNaYlhNMYFz5a2/3BgjBv/OyjgpQD
	 bQyUlhXPJBPzkE5KXLlPQjR60o8TJdUvIe4j3OvNuiOFUYoHvuwtp6AqQXcAtE1F8VfSB
	 5k1OdAZ8mC7t4e7cZiFXqe18U1y2RVGHi5bk0HY+lHOItf+6XyyeXhg4tn+lHX5rwjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293223;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KZBsMp4Ugh8+EoP8y053VEalnoLgHAo3t7uQq3fCYHA=;
	b=PF8UgODvkuPz2R4+LgRzGI3fT07oyghkaoJ87M+q1xdbtmtJ0q3ufg3WC3L2Taef3Qp9
	 2vJIa/tybPGBU4I7Iwnd+82FXoCbZJ46YnLhrfHDsSyX694icPB+aUPuZ7ZmPqHv/8kTZ
	 5t5YmbQ3ltQcOEjaRtOOarrlPyKXSuNIyTqpHeeBBgW7FgvOvmyneav5QHlAyt0aZzZ5w
	 1lOfJHWwQUYTpZsR0CVUsK1fr4Vb6t5nTv2EjhXoRmq2dsSQ/OgEyaN+ficT37Ifbii55
	 gTTouP200UcATvXFBWsVHLYOsPofIH8ZfulPs/R6okC/8+n+QMpkYyXsJflgeGL9f2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XLGSj5hR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5777E606A338
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XLGSj5hR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735BB1F01816;
	Thu, 29 Oct 2026 17:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793293221;
	bh=KZBsMp4Ugh8+EoP8y053VEalnoLgHAo3t7uQq3fCYHA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XLGSj5hRxVkZheHp7joQcmAFsvOnDUcE9HgjpnTNo4BZMDKni6vKN0DGetXCDcZHI
	 gM//10IgKqzD62qloaj4rPycu/iFV43Q5tN3TmHR4KBVU4tfD+GpTeoubpYg17NwNp
	 sf5j6pjwv1z+gS0A0owLcDndp2uL50tuiUuPJqsd3wB32dBAp0m7AE5c6dWVu5EHI7
	 zkoX0fgFDc+FVRRvqIIXOBpR7EUunXfZd021/UCgS+BUoyAcGKh+xUK7P8bgu7YP7H
	 xgJ7G/Fj5oYz+WPJAwRVBimtsiuqJc78biJuEsJa3qokLYRxJW0EP+jbYfJse9h6Ld
	 RVp0clG2WgxDw==
Message-ID: <sashiko-outbox-189701@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 4/5] media: virtio: Add buffer streaming, event
 handling, and poll
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brian Daniels" <briandaniels@google.com>
Cc: virtualization@lists.linux.dev, media-ci@linuxtv.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261029153038.3800747-5-briandaniels@google.com>
References: <20261029153038.3800747-1-briandaniels@google.com>
 <20261029153038.3800747-5-briandaniels@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 17:00:20 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 15 potential issue=
(s) to consider:
- [Critical] media: virtio: session use-after-free in virtio_media_process_=
events()
- [Critical] media: virtio: session use-after-free in virtio_media_remove()
- [Critical] media: virtio: pending_dqbufs use-after-free on buffer realloc=
ation
- [Critical] media: virtio: out-of-bounds buffer array access when host inc=
reases count
- [Critical] media: virtio: missing queues_lock synchronization on queue st=
ate and buffers
- [Critical] media: virtio: compat heap out-of-bounds read on multiplanar b=
uffer ioctls
- [High] media: virtio: deadlock between vlock and events_lock in event pro=
cessing
- [High] media: virtio: duplicate session close after VIRTIO_MEDIA_EVT_ERROR
- [High] media: virtio: pending_dqbufs list corruption on duplicate QBUF or=
 DQBUF
- [High] media: virtio: broken EPOLLOUT, EPOLLERR, and mplane handling in p=
oll()
- [High] media: virtio: missing streamoff wakeup and broken O_NONBLOCK in d=
qbuf()
- [High] media: virtio: unlocked eventq setup and missing cleanup in probe()
- [High] media: virtio: eventq_work cancelled before device reset in remove=
()
- [Medium] media: virtio: memory leak in virtio_media_create_bufs() when co=
unt is 0
- [Medium] media: virtio: SG index mismatch when length is 0 and uninitiali=
zed resp_len
--

commit ce9e8e91b26679cbd71baf6f6009e5e696c3100b
Author: Alexandre Courbot <gnurou@gmail.com>

media: virtio: Add buffer streaming, event handling, and poll

This commit adds V4L2 buffer queue state tracking, streaming ioctls,
asynchronous event virtqueue processing, V4L2 event subscription, and
poll support to the virtio-media driver.

> diff --git a/drivers/media/virtio/virtio_media_driver.c b/drivers/media/v=
irtio/virtio_media_driver.c
> index 2f2e95077b556..877ac154b3221 100644
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

[Severity: Critical]
Can this lead to a use-after-free on struct virtio_media_session in
virtio_media_process_events()?

virtio_media_find_session() drops vv->sessions_lock and returns an
unreferenced session pointer. virtio_media_process_events() then uses that
session pointer under vv->events_lock to process VIRTIO_MEDIA_EVT_ERROR,
VIRTIO_MEDIA_EVT_DQBUF, and VIRTIO_MEDIA_EVT_EVENT.

Concurrently, when the file descriptor is closed, virtio_media_device_close=
()
does not acquire vv->events_lock:

virtio_media_device_close()
  virtio_media_session_close(vv, session)
  virtio_media_session_remove(vv, session)
  virtio_media_session_free(session)

If virtio_media_device_close() removes and frees the session after
virtio_media_find_session() returns it, won't virtio_media_process_events()
read and write freed session and queue->buffers memory?

[ ... ]
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

[Severity: Critical]
Is session->queues_lock needed before reading queue->allocated_bufs and
accessing queue->buffers[] here, as well as in the ioctl handlers?

virtio_media_process_dqbuf_event() runs on vv->eventq_work without holding
vv->vlock. It reads queue->allocated_bufs, indexes queue->buffers[], and
writes to dqbuf->buffer and dqbuf->planes before acquiring
session->queues_lock.

Meanwhile, virtio_media_reqbufs() and virtio_media_create_bufs() free and
replace queue->buffers and update queue->allocated_bufs without holding
session->queues_lock, and virtio_media_qbuf(), virtio_media_prepare_buf(),
virtio_media_querybuf(), virtio_media_streamon(), and
virtio_media_decoder_cmd() also modify queue state unlocked.

Could virtio_media_process_dqbuf_event() dereference queue->buffers while
virtio_media_reqbufs() or virtio_media_create_bufs() frees it via vfree(), =
or
race on queue->queued_bufs with virtio_media_qbuf()?

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
> +
> +	/* Set the DONE flag as the buffer is waiting to be dequeued. */
> +	dqbuf->buffer.flags |=3D V4L2_BUF_FLAG_DONE;
> +
> +	mutex_lock(&session->queues_lock);
> +	list_add_tail(&dqbuf->list, &queue->pending_dqbufs);
> +	queue->queued_bufs -=3D 1;
> +	mutex_unlock(&session->queues_lock);

[Severity: High]
What happens if userspace calls VIDIOC_QBUF on a buffer that is already in
queue->pending_dqbufs (with V4L2_BUF_FLAG_DONE set) before dequeuing it with
VIDIOC_DQBUF, or if a duplicate VIRTIO_MEDIA_EVT_DQBUF arrives?

In virtio_media_qbuf(), buffer->buffer.flags is overwritten with
V4L2_BUF_FLAG_QUEUED without checking if the buffer is already queued or
waiting in queue->pending_dqbufs. Since the host already considers the buff=
er
dequeued after sending the first VIRTIO_MEDIA_EVT_DQBUF, it can accept the
VIDIOC_QBUF command and emit another VIRTIO_MEDIA_EVT_DQBUF, causing
virtio_media_process_dqbuf_event() to call list_add_tail(&dqbuf->list,
&queue->pending_dqbufs) on an already-linked list_head and corrupt
queue->pending_dqbufs.

> +
> +	wake_up(&session->dqbuf_wait);
> +}
> +
> +/**
> + * virtio_media_process_events() - Process all pending events on a devic=
e.
[ ... ]
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
Can calling virtio_media_session_close() here deadlock on vv->vlock and
vv->events_lock?

When userspace calls VIDIOC_SUBSCRIBE_EVENT with V4L2_EVENT_SUB_FL_SEND_INI=
TIAL,
the call chain is:

virtio_media_device_ioctl()
  mutex_lock(&vv->vlock)
  video_ioctl2()
    ...
      virtio_media_subscribe_event()
        virtio_media_process_events()
          mutex_lock(&vv->events_lock)
          virtio_media_session_close()
            mutex_lock(&vv->vlock)

If a VIRTIO_MEDIA_EVT_ERROR event is processed during
virtio_media_subscribe_event(), this attempts to acquire vv->vlock while
already holding vv->vlock on the same thread, and also inverts the lock ord=
er
(vv->events_lock -> vv->vlock) relative to virtio_media_subscribe_event()
(vv->vlock -> vv->events_lock) when virtio_media_event_work() runs on the
workqueue.

[Severity: High]
Also, should VIRTIO_MEDIA_EVT_ERROR call virtio_media_session_close() if
virtio_media_device_close() will also call it when the file is later closed?

The comment on struct virtio_media_event_error in
include/uapi/linux/virtio_media.h states:

 * Upon receiving this event, the session mentioned in the header is consid=
ered
 * corrupted and closed.

Calling virtio_media_session_close() here and then again unconditionally in
virtio_media_device_close() sends VIRTIO_MEDIA_CMD_CLOSE twice for the same
session->id, which could close a newly opened session if the host reuses the
session ID.

[ ... ]
> @@ -358,10 +633,65 @@ static int virtio_media_device_close(struct file *f=
ile)
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
> +		else if (!list_empty(&capture_queue->pending_dqbufs))
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
Are the poll conditions for EPOLLOUT, EPOLLIN, and EPOLLERR here matching V=
4L2
semantics?

1. For EPOLLOUT | EPOLLWRNORM, checking output_queue->queued_bufs <
output_queue->allocated_bufs causes poll() to return immediately whenever a=
ny
allocated output buffer is not currently queued on the host, even when
output_queue->pending_dqbufs is empty and VIDIOC_DQBUF would return -EAGAIN
or block. Shouldn't this check !list_empty(&output_queue->pending_dqbufs)
instead?

2. When the last capture buffer (with V4L2_BUF_FLAG_LAST) has been dequeued,
capture_queue->is_capture_last is true, capture_queue->queued_bufs is 0, and
capture_queue->pending_dqbufs is empty. Doesn't this branch return EPOLLERR
instead of EPOLLIN | EPOLLRDNORM so userspace can call VIDIOC_DQBUF and
receive -EPIPE?

3. If an application polls for both directions (for example select() or
poll(POLLIN | POLLOUT) on an M2M device when only one queue is streaming),
won't checking !capture_queue->streaming and !output_queue->streaming
independently set EPOLLERR even though the other queue is validly streaming?

4. capture_type and output_type rely on session->uses_mplane, which is set =
in
virtio_media_reqbufs() but is never set in virtio_media_create_bufs(). If
multiplanar buffers are allocated via VIDIOC_CREATE_BUFS, won't
virtio_media_device_poll() inspect the non-MPLANE queues and always return
EPOLLERR?

[ ... ]
> @@ -449,12 +799,25 @@ static int virtio_media_probe(struct virtio_device =
*virtio_dev)
>  	if (ret)
>  		goto err_del_vqs;
> =20
> +	for (i =3D 0; i < VIRTIO_MEDIA_NUM_EVENT_BUFS; i++) {
> +		void *ebuf =3D vv->event_buffer +
> +			     virtio_media_event_aligned_size * i;
> +
> +		ret =3D virtio_media_send_event_buffer(vv, ebuf);
> +		if (ret)
> +			goto err_video_unregister_device;
> +	}
> +
>  	return 0;
> =20
> +err_video_unregister_device:
> +	video_unregister_device(&vv->video_dev);
>  err_del_vqs:
>  	virtio_dev->config->del_vqs(virtio_dev);
>  err_v4l2_device_unregister:
>  	v4l2_device_unregister(&vv->v4l2_dev);
> +err_free_event_buffer:
> +	kfree(vv->event_buffer);
>  err_free_virtio_media:
>  	kfree(vv);
>  	return ret;

[Severity: High]
In virtio_media_probe(), virtio_media_send_event_buffer() is called in a lo=
op
after virtio_device_ready() and video_register_device() without holding
vv->events_lock.

If an event callback fires (scheduling vv->eventq_work) or userspace calls
VIDIOC_SUBSCRIBE_EVENT while this loop is still running, can
virtio_media_process_events() access vv->eventq concurrently with
virtio_media_send_event_buffer()?

Also, if virtio_media_send_event_buffer() fails partway through the loop and
jumps to err_video_unregister_device, the error path deletes the virtqueues
and frees vv->event_buffer and vv without calling virtio_reset_device() or
cancel_work_sync(&vv->eventq_work). Can the host or a pending eventq_work
access freed memory on this failure path?

>  }
> =20
>  static void virtio_media_remove(struct virtio_device *virtio_dev)
> @@ -468,6 +831,9 @@ static void virtio_media_remove(struct virtio_device =
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
> @@ -483,6 +849,8 @@ static void virtio_media_remove(struct virtio_device =
*virtio_dev)
>  	 */
>  	while (virtqueue_detach_unused_buf(vv->commandq))
>  		;
> +	while (virtqueue_detach_unused_buf(vv->eventq))
> +		;
> =20
>  	/* Delete the virtqueues */
>  	virtio_dev->config->del_vqs(virtio_dev);

[Severity: High]
In virtio_media_remove(), cancel_work_sync(&vv->eventq_work) is called befo=
re
virtio_reset_device(virtio_dev):

virtio_media_remove()
  video_unregister_device(&vv->video_dev)
  cancel_work_sync(&vv->eventq_work)
  mutex_lock(&vv->vlock)
  virtio_reset_device(virtio_dev)

If an eventq interrupt arrives between cancel_work_sync() and
virtio_reset_device(), won't eventq_callback() call
schedule_work(&vv->eventq_work) again, allowing virtio_media_event_work() to
run while the virtqueues and struct virtio_media are being torn down?

[Severity: Critical]
Additionally, right after unlocking vv->vlock in virtio_media_remove(), the
driver frees all sessions in vv->sessions:

	list_for_each_safe(p, n, &vv->sessions) {
		struct virtio_media_session *s =3D
			list_entry(p, struct virtio_media_session, list);

		virtio_media_session_remove(vv, s);
		virtio_media_session_free(s);
	}

Since virtio_media_dqbuf() drops vv->vlock while sleeping in
wait_event_interruptible(session->dqbuf_wait, ...), and
video_unregister_device() does not wait for open file descriptors or in-fli=
ght
ioctls to complete, won't freeing the sessions here cause a use-after-free =
in
any thread sleeping in virtio_media_dqbuf() as well as when open file
descriptors are subsequently closed in virtio_media_device_close()?

> diff --git a/drivers/media/virtio/virtio_media_ioctls.c b/drivers/media/v=
irtio/virtio_media_ioctls.c
> index 51f46b334800c..9bf2834691fd0 100644
> --- a/drivers/media/virtio/virtio_media_ioctls.c
> +++ b/drivers/media/virtio/virtio_media_ioctls.c
[ ... ]
> +static int virtio_media_send_buffer_ioctl(struct v4l2_fh *fh, u32 ioctl,
> +					  struct v4l2_buffer *b)
> +{
> +	struct video_device *video_dev =3D fh->vdev;
> +	struct virtio_media *vv =3D to_virtio_media(video_dev);
> +	struct virtio_media_session *session =3D fh_to_session(fh);
> +	struct v4l2_plane *orig_planes =3D NULL;
> +	struct scatterlist *sgs[64];
> +	/*
> +	 * End of the device-readable buffer SGs, to reuse in device-writable
> +	 * section.
> +	 */
> +	size_t num_cmd_sgs;
> +	size_t end_buf_sg;
> +	struct scatterlist_builder builder =3D {
> +		.descs =3D session->command_sgs.sgl,
> +		.num_descs =3D DESC_CHAIN_MAX_LEN,
> +		.cur_desc =3D 0,
> +		.shadow_buffer =3D session->shadow_buf,
> +		.shadow_buffer_size =3D VIRTIO_SHADOW_BUF_SIZE,
> +		.shadow_buffer_pos =3D 0,
> +		.sgs =3D sgs,
> +		.num_sgs =3D ARRAY_SIZE(sgs),
> +		.cur_sg =3D 0,
> +		.framevec =3D NULL,
> +	};
> +	size_t resp_len;
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
> +
> +	ret =3D virtio_media_send_command(vv, builder.sgs, num_cmd_sgs,
> +					builder.cur_sg - num_cmd_sgs,
> +					sizeof(struct virtio_media_resp_ioctl) +
> +					sizeof(*b), &resp_len);
> +	if (ret < 0)
> +		return ret;
> +
> +	resp_len -=3D sizeof(struct virtio_media_resp_ioctl);
> +
> +	/* Make sure that the reply length covers our v4l2_buffer */
> +	if (resp_len < sizeof(*b))
> +		return -EINVAL;
> +
> +	ret =3D scatterlist_builder_retrieve_buffer(&builder, num_cmd_sgs + 1, =
b,
> +						  orig_planes);

[Severity: Medium]
What happens here when V4L2_TYPE_IS_MULTIPLANAR(b->type) is true, b->length=
 is
0, and b->m.planes is non-NULL?

In v4l2-ioctl.c:check_array_args(), b->m.planes is only replaced with a ker=
nel
buffer when b->length > 0. Likewise, scatterlist_builder_add_buffer() only
adds an SG descriptor for b->m.planes when b->length > 0.

However, virtio_media_send_buffer_ioctl() sets orig_planes =3D b->m.planes
without checking b->length > 0, and scatterlist_builder_retrieve_buffer()
calls scatterlist_builder_retrieve_data(builder, sg_index++, b->m.planes)
whenever orig_planes is non-NULL, which will attempt to retrieve a
non-existent SG entry into an unvalidated user pointer and fail with -ERANG=
E.

Also, resp_len is uninitialized in virtio_media_send_buffer_ioctl() before
being passed to virtio_media_send_command(), which reads *resp_len on entry:

	size_t local_resp_len =3D resp_len ? *resp_len : 0;

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

[Severity: Critical]
Can this overflow queue->buffers[] if the host increases b->count?

In V4L2, a driver or host handling VIDIOC_REQBUFS or VIDIOC_CREATE_BUFS may
round b->count upward to satisfy minimum buffer requirements. Here in
virtio_media_reqbufs(), buffers is allocated using the pre-ioctl b->count, =
and
then queue->allocated_bufs is set to the host-updated b->count. Similarly, =
in
virtio_media_create_bufs(), buffers is allocated with queue->allocated_bufs=
 +
b->count elements before the ioctl, and queue->allocated_bufs is set to
b->index + b->count after the ioctl without checking that it fits within the
allocated array.

If the host returns a larger count than requested, won't subsequent indexin=
g of
queue->buffers[] up to queue->allocated_bufs read and write out of bounds?

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

[Severity: Medium]
Does this leak buffers if b->count was non-zero on input and the host
overwrites b->count with 0 in the VIDIOC_CREATE_BUFS response?

> +
> +	memcpy(buffers, queue->buffers,
> +	       sizeof(*queue->buffers) * queue->allocated_bufs);
> +	vfree(queue->buffers);
> +	queue->buffers =3D buffers;

[Severity: Critical]
Can reallocating queue->buffers here (or in virtio_media_reqbufs() when
b->count > 0) corrupt queue->pending_dqbufs and cause a use-after-free?

Each struct virtio_media_buffer in queue->buffers contains an embedded
struct list_head list node that is linked into queue->pending_dqbufs when a
buffer is ready to be dequeued.

In virtio_media_create_bufs(), memcpy() shallow-copies queue->buffers into =
the
newly allocated buffers array and then calls vfree(queue->buffers), leaving
queue->pending_dqbufs and any linked list_head pointers pointing into the
freed queue->buffers array.

Similarly, in virtio_media_reqbufs(), virtio_media_clear_queue() is only
called when b->count =3D=3D 0; if VIDIOC_REQBUFS is called with b->count > =
0 while
queue->pending_dqbufs is non-empty, vfree(queue->buffers) frees the active
list nodes while they remain linked in queue->pending_dqbufs.

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

[Severity: High]
What happens if VIDIOC_STREAMOFF or VIDIOC_REQBUFS(0) is called while a thr=
ead
is blocked in wait_event_interruptible() here?

virtio_media_clear_queue() sets queue->streaming =3D false and empties
queue->pending_dqbufs without calling wake_up(&session->dqbuf_wait), and the
wait condition only checks !list_empty(buffer_queue) || session->error. Won=
't
the blocked VIDIOC_DQBUF thread sleep indefinitely when the queue is stream=
ed
off?

Also, because the checks above use else if:

	if (session->nonblocking_dequeue) {
		if (list_empty(buffer_queue))
			return -EAGAIN;
	} else if (queue->allocated_bufs =3D=3D 0) {
		return -EINVAL;
	} else if (!queue->streaming) {
		return -EINVAL;
	}

when nonblocking_dequeue is true, calling VIDIOC_DQBUF on a queue with
allocated_bufs =3D=3D 0 or !queue->streaming skips the -EINVAL checks and r=
eturns
-EAGAIN. And since session->nonblocking_dequeue is only initialized once in
virtio_media_session_alloc() from file->f_flags & O_NONBLOCK, toggling
O_NONBLOCK later via fcntl(F_SETFL) will not be reflected here.

> +	mutex_lock(&vv->vlock);
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

[Severity: Critical]
Can overwriting b->length here (and in scatterlist_builder_retrieve_buffer()
for VIDIOC_QUERYBUF, VIDIOC_PREPARE_BUF, and VIDIOC_QBUF) cause a kernel he=
ap
out-of-bounds read in 32-bit compat mode?

In v4l2-ioctl.c:check_array_args() and video_usercopy(), the kernel allocat=
es
array_buf (passed as b->m.planes) sized to the user-supplied input b->lengt=
h.

Here in virtio_media_dqbuf(), if a 32-bit compat caller passes a smaller
b->length (for example b->length =3D 1 when dqbuf->buffer.length is 2),
memcpy(b, &dqbuf->buffer, sizeof(*b)) overwrites b->length with
dqbuf->buffer.length (and if b->length was 0, b->m.planes is not even a ker=
nel
pointer). Similarly, scatterlist_builder_retrieve_buffer() overwrites b->le=
ngth
from the host response without clamping it to the input b->length.

When video_usercopy() finishes a 32-bit compat ioctl,
v4l2_compat_put_array_args() iterates b64->length times copying elements fr=
om
array_buf to userspace, reading past the end of the allocated array_buf heap
buffer. Shouldn't multiplanar buffer ioctls validate that b->m.planes is
non-NULL and that the caller's b->length is sufficient before dequeuing or
updating b->length?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029153038.3800=
747-1-briandaniels@google.com?part=3D4
