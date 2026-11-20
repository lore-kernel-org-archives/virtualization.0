Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213306;
	b=BuhUJWgDuL5lWc54gWtxavkpO9OEtuAuw7NRXemsitTdT8z6AbeRQ7LFwpTfwUbfioCH
	 8/iorxKDFkPqcCZS8c9yu0NvDeKANdAi2Rolnsep8sn5lttac4oPJMXaRJltLFaX5+URz
	 DxCINy4P0zmY+E5PT/K2OFLWw84VjD6l/FxKOa+nkY5V+1RaVw935uirGQIVr3apfUAgI
	 +mpveS9R2N5QKD2tQhjRN/Ou3HnhPGpbPrJe8gIzAulXkN5cTyfM3CwjzlVZWo+5fhmUW
	 mAOAWF90AxBg8jDDxoEMRsh6Yw7Qbc7GPFY1iae7RRZJWEZrA258XZf9ZqiiRZgB8mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213306;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=T2TGPvsX1Q5F7kSk5VN7Hug18DzsM5dIYPuUftPobZU=;
	b=Y2PZzbaQ2A2fUCCorNH8kFCgYWUEcmqoILNaUJnSZZVc16HQAS0sx8w1nJDueCuJUtI/
	 p+u+MsknSR3Rb4Jsx8+6P+YMZm6XX0x7tFn6Z+jZ2DHFkm6ffvxNCfKVhf9TwRwd5bBBB
	 DYkeOz/92K/QV5p83tGby4PjIE4CjBzX7xzh3J+sCi6fnlDPylobBEWuy4uK+DjCbS0HB
	 2fm6iqCKX+kCQjiJbbhLbe8Ljm5ipeLNkAaeqZNsBisxvoZOZDB38R1SCa0l0/9FwzV4h
	 WK+Cm/YdNyYULwv0M3jMK8/RV0L4IPvsE3WByL5RNp1Y2El6TgXgZgX/tnaVdMCmtAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DDTppTNI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE49606A6B2
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 22:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DDTppTNI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B891F000C4;
	Fri, 20 Nov 2026 22:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795213305;
	bh=T2TGPvsX1Q5F7kSk5VN7Hug18DzsM5dIYPuUftPobZU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DDTppTNIQPLncdMakgJNl9hISvjHCB4/+dsk+dLmNjRIN/Xxabhjo5h89vpj9qM8k
	 /cKYsmkR9YtFCysZ148yeFGcWgx3vAaTVT8vwcCTzVawJezYZkngcHM6CW50cEwoS2
	 R5/GLsYDhKuk4zy3Joij4OLzt34TMtEjC6lP4742DFCx1hzmqEXul59A+u77KVEL4a
	 EY0Zksjza1Aoa3z70aIw4/9Et9LEYLmhdeFuLDDW7hcETzi5OWWRVYRQYyoCLceI+B
	 rqxgbLfTb1CHAyPiXE+CZse9325MRHtvAj0jIC+UGDo4nheftuHTXh6leNS1p/Nd4v
	 AmnKFSMx+4WYg==
Message-ID: <sashiko-outbox-226251@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 4/6] media: virtio: Add buffer streaming, event
 handling, and poll
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brian Daniels" <briandaniels@google.com>
Cc: virtualization@lists.linux.dev, media-ci@linuxtv.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261120215916.3149345-5-briandaniels@google.com>
References: <20261120215916.3149345-1-briandaniels@google.com>
 <20261120215916.3149345-5-briandaniels@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 22:21:44 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 17 potential
issues to consider:
- [High] media: virtio: avoid DMA mapping kernel stack buffers in
  add_data()
- [High] media: virtio: deadlock between vlock and events_lock in event
  processing
- [High] media: virtio: session use-after-free in
  virtio_media_process_events()
- [High] media: virtio: use-after-free and OOB in reqbufs and
  create_bufs
- [High] media: virtio: unsynchronized queue state in
  virtio_media_process_dqbuf_event()
- [High] media: virtio: broken EPOLLIN EOS and EPOLLOUT checks in poll()
- [High] media: virtio: cancel_work_sync() before reset in remove and
  probe
- [High] media: virtio: OOB queue->buffers and leak in
  reqbufs()/create_bufs()
- [High] media: virtio: O_NONBLOCK bugs and STREAMOFF hang in
  virtio_media_dqbuf()
- [High] media: virtio: session UAF in virtio_media_dqbuf() on
  virtio_media_remove()
- [High] media: virtio: unchecked multiplanar b->length in dqbuf and
  buffer ioctls
- [Medium] media: virtio: skip plane retrieval when b->length is 0 in
  buffer ioctls
- [Medium] media: virtio: video_register_device() called before
  populating eventq
- [Medium] media: virtio: SG index used as descriptor index in
  send_buffer_ioctl()
- [Medium] media: virtio: missing uses_mplane and cap checks in
  create_bufs()
- [Low] media: virtio: missing @error_lock kernel-doc in
  virtio_media_session
- [Low] media: virtio: uninitialized resp_len read in
  virtio_media_send_command()
--

commit befde615c261fefaf68e4ecec85b8fcfd0ccacb0
Author: Alexandre Courbot <gnurou@gmail.com>

media: virtio: Add buffer streaming, event handling, and poll

This commit adds V4L2 buffer queue state tracking, streaming and event
subscription ioctls, asynchronous event virtqueue processing, and poll
support to the virtio-media driver.

[Severity: High]
In drivers/media/virtio/scatterlist_builder.c (scatterlist_builder_add_data=
(),
lines 67 and 81; scatterlist_builder_add_buffer(), line 371) and
drivers/media/virtio/virtio_media_ioctls.c (virtio_media_streamon(), line 6=
96),
does scatterlist_builder_add_data() map kernel stack buffers directly into
virtqueue scatterlists for DMA instead of staging them through the shadow
buffer?

video_usercopy() places ioctl arguments up to 128 bytes (such as struct
v4l2_buffer, struct v4l2_requestbuffers, struct v4l2_decoder_cmd, and struct
v4l2_event_subscription) into its stack buffer sbuf[128], and
virtio_media_streamon() and virtio_media_streamoff() pass the address of th=
eir
stack parameter i. When always_use_shadow_buffer is false,
scatterlist_builder_add_data() checks virt_addr_valid(data) and
is_vmalloc_addr(data) without checking !object_is_on_stack(data), mapping s=
tack
pages directly via sg_set_page(). DMA-mapping the kernel stack violates the
DMA API, triggers CONFIG_DMA_API_DEBUG warnings, and risks stack corruption=
 on
non-coherent architectures or with VIRTIO_F_ACCESS_PLATFORM.

[Severity: Medium]
In drivers/media/virtio/scatterlist_builder.c (scatterlist_builder_add_buff=
er(),
line 375; scatterlist_builder_retrieve_buffer(), line 416) and
drivers/media/virtio/virtio_media_ioctls.c (virtio_media_send_buffer_ioctl(=
),
line 269), can scatterlist_builder_retrieve_buffer() fail with -ERANGE when
b->length is 0 on a multiplanar buffer?

In drivers/media/v4l2-core/v4l2-ioctl.c, check_array_args() only replaces
b->m.planes with a kernel buffer when b->length > 0, leaving the raw usersp=
ace
pointer in b->m.planes when b->length is 0. scatterlist_builder_add_buffer()
only adds a plane descriptor when b->length > 0, whereas
virtio_media_send_buffer_ioctl() saves orig_planes =3D b->m.planes uncondit=
ionally
for multiplanar types and scatterlist_builder_retrieve_buffer() calls
scatterlist_builder_retrieve_data() whenever orig_planes is non-NULL. Calli=
ng
VIDIOC_QBUF with b->length =3D=3D 0 and a non-NULL b->m.planes pointer ther=
efore
fails with -ERANGE after the host has already executed the ioctl, leaving t=
he
guest and host queue states out of sync.

[Severity: Low]
In drivers/media/virtio/session.h (struct virtio_media_session, line 109), =
this
isn't a bug, but struct virtio_media_session adds the error_lock member wit=
hout
a corresponding @error_lock entry in its kernel-doc comment block, which
triggers a scripts/kernel-doc warning under W=3D1 builds.

[Severity: High]
In drivers/media/virtio/virtio_media_driver.c (virtio_media_process_dqbuf_e=
vent(),
lines 412 and 445) and drivers/media/virtio/virtio_media_ioctls.c
(virtio_media_qbuf(), line 935), is queue state accessed without consistent
synchronization between virtio_media_process_dqbuf_event() and the buffer
ioctls?

virtio_media_process_dqbuf_event() runs on vv->eventq_work holding
vv->events_lock (not vv->vlock) and reads queue->allocated_bufs and writes =
into
queue->buffers[dqbuf_evt->buffer.index] before acquiring session->queues_lo=
ck,
while virtio_media_reqbufs() and virtio_media_create_bufs() free and replace
queue->buffers under vv->vlock without holding session->queues_lock, allowi=
ng a
concurrent DQBUF event to write into freed memory.

In addition, virtio_media_qbuf() increments queue->queued_bufs without hold=
ing
session->queues_lock after virtio_media_send_buffer_ioctl() has already
submitted the buffer to the host, while virtio_media_process_dqbuf_event()
decrements queue->queued_bufs under session->queues_lock without holding
vv->vlock; if the host signals VIRTIO_MEDIA_EVT_DQBUF before virtio_media_q=
buf()
increments queue->queued_bufs, queue->queued_bufs underflows to SIZE_MAX.
Finally, virtio_media_process_dqbuf_event() does not check under
session->queues_lock that the buffer is currently queued before calling
list_add_tail(&dqbuf->list, &queue->pending_dqbufs), so a duplicate or stale
DQBUF event corrupts the pending_dqbufs list.

[Severity: High]
In drivers/media/virtio/virtio_media_driver.c (virtio_media_session_close(),
line 159; virtio_media_process_events(), line 471) and
drivers/media/virtio/virtio_media_ioctls.c (virtio_media_subscribe_event(),
line 660; virtio_media_device_ioctl(), line 1337), can
virtio_media_process_events() deadlock on vv->vlock and vv->events_lock when
handling VIRTIO_MEDIA_EVT_ERROR?

virtio_media_device_ioctl() holds vv->vlock across video_ioctl2(). When
virtio_media_subscribe_event() is called with V4L2_EVENT_SUB_FL_SEND_INITIA=
L,
it calls virtio_media_process_events(), which acquires vv->events_lock (lock
order vv->vlock -> vv->events_lock). If a VIRTIO_MEDIA_EVT_ERROR event is
processed, virtio_media_process_events() calls virtio_media_session_close(),
which tries to acquire vv->vlock (lock order vv->events_lock -> vv->vlock):

CPU0                              CPU1
----                              ----
lock(&vv->vlock)
                                  lock(&vv->events_lock)
lock(&vv->events_lock)
                                  lock(&vv->vlock)

 *** DEADLOCK ***

CPU0: virtio_media_device_ioctl() -> ... -> virtio_media_subscribe_event() =
->
      virtio_media_process_events()
CPU1: virtio_media_event_work() -> virtio_media_process_events() ->
      virtio_media_session_close()

If VIRTIO_MEDIA_EVT_ERROR is processed directly inside the
virtio_media_subscribe_event() call, the same thread attempts to lock vv->v=
lock
a second time and self-deadlocks immediately.

[Severity: High]
In drivers/media/virtio/virtio_media_driver.c (virtio_media_find_session(),
line 188; virtio_media_process_events(), line 483; virtio_media_device_clos=
e(),
line 628), can virtio_media_process_events() access a freed session when ra=
cing
with virtio_media_device_close()?

virtio_media_find_session() drops vv->sessions_lock before returning the se=
ssion
pointer, and virtio_media_device_close() removes and frees the session with=
out
acquiring vv->events_lock. In the VIRTIO_MEDIA_EVT_ERROR case,
virtio_media_process_events() also sets session->error =3D true before call=
ing
virtio_media_session_close(), causing a racing virtio_media_device_close() =
to
skip virtio_media_session_close() (and its vv->vlock serialization) and fre=
e the
session immediately:

CPU0 (eventq_work)                CPU1 (close)
virtio_media_process_events()
  virtio_media_find_session()
  session->error =3D true
                                  virtio_media_device_close()
                                    if (!session_error) // false
                                    virtio_media_session_remove()
                                    virtio_media_session_free(session)
  virtio_media_session_close()
    ...                           <-- use-after-free
  wake_up(&session->dqbuf_wait)   <-- use-after-free

The same race applies to VIRTIO_MEDIA_EVT_DQBUF and VIRTIO_MEDIA_EVT_EVENT =
if
virtio_media_device_close() finishes between virtio_media_find_session() an=
d the
event handler body.

[Severity: High]
In drivers/media/virtio/virtio_media_driver.c (virtio_media_device_poll(),
line 676), do the EPOLLIN and EPOLLOUT checks in virtio_media_device_poll()
mishandle end-of-stream, output buffer readiness, and single-direction
streaming?

For EPOLLIN, once the last capture buffer (V4L2_BUF_FLAG_LAST) is dequeued,
capture_queue->is_capture_last is true while queued_bufs is 0 and
pending_dqbufs is empty. Because the first branch checks
(capture_queue->queued_bufs =3D=3D 0 && list_empty(&capture_queue->pending_=
dqbufs))
without checking !capture_queue->is_capture_last, poll() returns EPOLLERR at
EOS instead of reaching the else-if branch to return EPOLLIN | EPOLLRDNORM.

For EPOLLOUT, checking output_queue->queued_bufs < output_queue->allocated_=
bufs
instead of !list_empty(&output_queue->pending_dqbufs) causes poll() to repo=
rt
EPOLLOUT | EPOLLWRNORM whenever not all allocated output buffers are queued,
even when no completed output buffer is available in pending_dqbufs for
VIDIOC_DQBUF, causing non-blocking callers to spin in a busy loop receiving
-EAGAIN.

Furthermore, when an application polls for both events (or when wait is NUL=
L on
a re-poll pass where poll_requested_events() has all bits set) while only o=
ne
queue is streaming, the non-streaming queue unconditionally sets EPOLLERR.

[Severity: Medium]
In drivers/media/virtio/virtio_media_driver.c (virtio_media_probe(), line 8=
08),
should the event buffers be queued on vv->eventq before calling
video_register_device()?

video_register_device() exposes the character device node to userspace
immediately, creating a window where userspace can open the device and trig=
ger
host events before the virtio_media_send_event_buffer() loop has populated
vv->eventq.

[Severity: High]
In drivers/media/virtio/virtio_media_driver.c (virtio_media_probe(), line 8=
30;
virtio_media_remove(), line 854), can eventq_callback() re-schedule
vv->eventq_work after cancel_work_sync() in virtio_media_remove() and
virtio_media_probe()?

Both teardown paths call cancel_work_sync(&vv->eventq_work) before calling
virtio_reset_device(virtio_dev):

CPU0                              CPU1 (<hardirq>)
virtio_media_remove()
  cancel_work_sync(&vv->eventq_work)
                                  eventq_callback()
                                    schedule_work(&vv->eventq_work)
  mutex_lock(&vv->vlock)
  virtio_reset_device()
  del_vqs()
  v4l2_device_put() -> kfree(vv)
                                  virtio_media_event_work()
                                    ... <-- use-after-free

In addition, if virtio_media_send_event_buffer() fails partway through the =
loop
in virtio_media_probe(), the error path calls del_vqs() without draining the
already-queued event buffers via virtqueue_detach_unused_buf(vv->eventq).

[Severity: High]
In drivers/media/virtio/virtio_media_driver.c (virtio_media_remove(), line =
879)
and drivers/media/virtio/virtio_media_ioctls.c (virtio_media_dqbuf(), line =
989),
can virtio_media_remove() free an active session while virtio_media_dqbuf()=
 is
sleeping on session->dqbuf_wait?

virtio_media_dqbuf() unlocks vv->vlock before sleeping in
wait_event_interruptible(session->dqbuf_wait, ...). Because
video_unregister_device() does not wait for in-flight ioctls on open file
descriptors to complete, virtio_media_remove() can acquire and release
vv->vlock, iterate over vv->sessions, and call virtio_media_session_free(s)
while a thread is still blocked in wait_event_interruptible() on
session->dqbuf_wait, causing a use-after-free when that thread wakes or is
interrupted.

[Severity: Low]
In drivers/media/virtio/virtio_media_ioctls.c (virtio_media_send_buffer_ioc=
tl(),
line 262) and drivers/media/virtio/virtio_media_driver.c
(virtio_media_send_command(), line 316), is resp_len read uninitialized when
virtio_media_send_buffer_ioctl() calls virtio_media_send_command()?

virtio_media_send_buffer_ioctl() declares size_t resp_len without initializ=
ing
it (unlike virtio_media_send_ext_controls_ioctl(), which initializes
resp_len =3D 0), and virtio_media_send_command() evaluates
size_t local_resp_len =3D resp_len ? *resp_len : 0 before writing to *resp_=
len.

[Severity: Medium]
In drivers/media/virtio/virtio_media_ioctls.c (virtio_media_send_buffer_ioc=
tl(),
line 282), does the response loop in virtio_media_send_buffer_ioctl() pass =
an
SG pointer index to scatterlist_builder_add_descriptor() where a descriptor
table index is expected?

end_buf_sg is initialized from builder.cur_sg (an index into builder.sgs), =
but
scatterlist_builder_add_descriptor(&builder, i) indexes builder->descs[i]. =
If a
vmalloc-backed buffer added by scatterlist_builder_add_data() spans two
non-contiguous physical pages, it consumes two entries in builder->descs wh=
ile
advancing builder->cur_sg by one, so passing i to
scatterlist_builder_add_descriptor() attaches the wrong descriptor to the
device-writable response chain.

[Severity: High]
In drivers/media/virtio/virtio_media_ioctls.c (virtio_media_reqbufs(), line=
 743;
virtio_media_create_bufs(), line 839), can virtio_media_create_bufs() and
virtio_media_reqbufs() leave dangling list pointers in queue->pending_dqbuf=
s?

Each struct virtio_media_buffer in queue->buffers has a list_head linked in=
to
queue->pending_dqbufs while waiting to be dequeued. virtio_media_create_buf=
s()
shallow-copies queue->buffers into a newly allocated buffers array via memc=
py()
and calls vfree(queue->buffers) without updating the list pointers in
queue->pending_dqbufs. Similarly, virtio_media_reqbufs() only calls
virtio_media_clear_queue() when b->count =3D=3D 0, so calling VIDIOC_REQBUF=
S with
b->count > 0 while completed buffers are pending frees queue->buffers while
leaving them linked in queue->pending_dqbufs. Any subsequent VIDIOC_DQBUF,
VIDIOC_STREAMOFF, or VIRTIO_MEDIA_EVT_DQBUF will dereference the freed
queue->buffers allocation.

[Severity: High]
In drivers/media/virtio/virtio_media_ioctls.c (virtio_media_reqbufs(), line=
 743;
virtio_media_create_bufs(), line 839), can queue->allocated_bufs exceed the=
 size
of the queue->buffers allocation in virtio_media_reqbufs() and
virtio_media_create_bufs()?

Both functions allocate buffers with vcalloc() using the caller's requested
b->count before sending the ioctl to the host, and afterwards set
queue->allocated_bufs =3D b->count (in virtio_media_reqbufs()) or
queue->allocated_bufs =3D b->index + b->count (in virtio_media_create_bufs(=
)). In
V4L2, drivers and devices may increase count to meet minimum buffer require=
ments;
if the host returns a larger b->count (or a larger b->index + b->count),
queue->allocated_bufs will be larger than the allocated array, leading to
out-of-bounds accesses on queue->buffers.

Also, in virtio_media_create_bufs(), if b->count > 0 on entry and the host
returns b->count =3D=3D 0 with status 0, the early return on b->count =3D=
=3D 0 leaks
the pre-allocated buffers array.

[Severity: Medium]
In drivers/media/virtio/virtio_media_ioctls.c (virtio_media_create_bufs(),
line 813) and drivers/media/virtio/virtio_media_driver.c
(virtio_media_device_poll(), line 654), should virtio_media_create_bufs() u=
pdate
session->uses_mplane, reject V4L2_MEMORY_USERPTR, and mask unsupported
b->capabilities flags like virtio_media_reqbufs() does?

When a multiplanar session allocates buffers via VIDIOC_CREATE_BUFS instead=
 of
VIDIOC_REQBUFS, session->uses_mplane remains false, causing
virtio_media_device_poll() to check the unallocated single-planar queues and
return EPOLLERR.

[Severity: High]
In drivers/media/virtio/virtio_media_ioctls.c (virtio_media_clear_queue(),
line 473; virtio_media_dqbuf(), line 976) and
drivers/media/virtio/virtio_media_driver.c (virtio_media_session_alloc(),
line 65), can a thread blocked in virtio_media_dqbuf() hang indefinitely wh=
en
streaming is stopped, or block unexpectedly in non-blocking mode?

When virtio_media_clear_queue() stops streaming on VIDIOC_STREAMOFF or
VIDIOC_REQBUFS(0), it sets queue->streaming =3D false and clears pending_dq=
bufs,
but it does not call wake_up(&session->dqbuf_wait), and wait_event_interrup=
tible()
in virtio_media_dqbuf() only checks !list_empty(buffer_queue) || session->e=
rror
(not !queue->streaming), leaving blocked VIDIOC_DQBUF callers asleep foreve=
r.

In addition, when session->nonblocking_dequeue is true in virtio_media_dqbu=
f():
- the else-if chain skips the queue->allocated_bufs =3D=3D 0 and !queue->st=
reaming
  checks, returning -EAGAIN instead of -EINVAL;
- if buffer_queue is non-empty, virtio_media_dqbuf() still drops vv->vlock =
and
  enters wait_event_interruptible(), where a racing consumer can empty the
  queue and cause a non-blocking call to sleep (or return -EIO if another t=
hread
  dequeues the buffer before vv->vlock is re-acquired);
- session->nonblocking_dequeue is only snapshotted at open() time in
  virtio_media_session_alloc(), ignoring later fcntl(F_SETFL, O_NONBLOCK)
  changes to file->f_flags.

[Severity: High]
In drivers/media/virtio/virtio_media_ioctls.c (virtio_media_send_buffer_ioc=
tl(),
line 269; virtio_media_dqbuf(), line 1029) and
drivers/media/virtio/scatterlist_builder.c (scatterlist_builder_retrieve_bu=
ffer(),
line 416), can overwriting b->length in virtio_media_dqbuf() and
virtio_media_send_buffer_ioctl() trigger an out-of-bounds kernel read when
copying planes back to userspace?

In drivers/media/v4l2-core/v4l2-ioctl.c, check_array_args() allocates the k=
ernel
plane array b->m.planes (array_buf) sized to the caller's input b->length.
virtio_media_dqbuf() copies min_t(u32, b->length, VIDEO_MAX_PLANES) planes =
into
b->m.planes, and then memcpy(b, &dqbuf->buffer, sizeof(*b)) overwrites b->l=
ength
with dqbuf->buffer.length (and virtio_media_send_buffer_ioctl() similarly l=
ets
the host response overwrite b->length). If the caller passed a smaller
b->length (for example, 1 plane on a 2-plane format) via a 32-bit compat io=
ctl,
v4l2_compat_put_array_args() in drivers/media/v4l2-core/v4l2-compat-ioctl32=
.c
iterates over the overwritten b->length and reads past the end of array_buf,
leaking adjacent kernel heap memory to userspace.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120215916.3149=
345-1-briandaniels@google.com?part=3D4
