Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE6537FF6F
	for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789669076; cv=none; b=KdFB5cuzA3L0OpSbN0Eu3p0cADe8E92v954hnVTyUpQj2t1RoC+TjfGvvbptTQxu+fpyWvD1fzxz0UTyM6PdYp3KqHeMTIBd2iC2bVAoHW9mY/Eaz88aNImScFOHzVGS5XhZirsdhm/pRx2RfXaK6nVtPq9yDFifOW470JxYLlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789669076; c=relaxed/simple;
	bh=hJBuer0rF2jYUYWIKtiazYXmvii4wqVQZtBrrZWVO2c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ud8sw2beZc0lLz80T/Twaa+zmYqIIKnmN0CTruekCI+TE5SlNEcZ4D2dLQoiHWHK3VkOlwXjGik0KRq7Ors2U7FOBFXPjOjRp6WHcgBDzftx6yi9ZedPxZpWka9ZYuin6aq8wQ3wjGxq3GKs6wEeUo8E1bb0S+bPYC6N7pcmRzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UB1oaFKw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UB1oaFKw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846A31F00893;
	Thu, 17 Sep 2026 18:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789669074;
	bh=M6y/XqqCwDACZoA5I8dTn8dDZ0A6f7/+KGCmuRx9+HI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UB1oaFKwgiNx7jpaHdYls1tcrqG0+yYA/NMyyKNG7WALM7PFIbf1n2Szo7MT4IIYv
	 DTMAomGfflv3xgSVJN9o9i5AftPdXXiJZS4kj/3E6ZVvDuMjxiFE4ALaZLYUt3pusq
	 CR7jrCctD4YUjOifaxI3QDqmWyNgX+7D73FtJQGRVK/Z7aLBsAd9mSmK1rC95fIBw3
	 Out/HCHSEk9ORoA+p0EDM7r6RHIrIbsToQxxAjkNDrg8RhyGGPi9MHp3Q3W/Sw7sDH
	 ZNkJs0fZ4vxE1FesHLjKQ9IJ4Czzs/hm63OOJ12cLXdbusLQeR3A+SR8WjVUm48ch8
	 AzkZqyERulezA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/4] media: virtio: Add ioctl operations and driver
 logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brian Daniels" <briandaniels@google.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, media-ci@linuxtv.org
In-Reply-To: <20260917171921.2810550-5-briandaniels@google.com>
References: <20260917171921.2810550-1-briandaniels@google.com>
 <20260917171921.2810550-5-briandaniels@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 18:17:54 +0000
Message-Id: <20260917181754.846A31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 18 potential issue=
(s) to consider:
- [High] media: virtio: missing bounds check on host-provided MMAP offset
- [High] media: virtio: unhandled vzalloc failure leaves queue->buffers NULL
- [High] media: virtio: missing wakeup in clear_queue causes DQBUF hang
- [High] media: virtio: TOCTOU race in dqbuf leads to list corruption
- [High] media: virtio: vma->vm_pgoff overwritten with physical PFN corrupt=
s interval tree
- [High] media: virtio: un-decremented queued_bufs permanently blocks EPOLL=
OUT
- [High] media: virtio: integer overflow in create_bufs leads to OOB write
- [High] media: virtio: multiplication overflow in reqbufs results in OOB h=
eap access
- [High] media: virtio: list corruption via memcpy in array reallocation
- [High] media: virtio: UAF due to devm_kzalloc of structure embedding vide=
o_device
- [High] media: virtio: asynchronous session free leads to UAF on close
- [High] media: virtio: premature unpinning of user pages allows physical m=
emory corruption
- [High] media: virtio: malicious host length overwrite leaks kernel memory
- [High] media: virtio: TOCTOU in ext_controls check allows host to trigger=
 OOB read
- [Medium] media: virtio: host-side MMAP mapping leaked on io_remap_pfn_ran=
ge failure
- [Medium] media: virtio: missing bounds check underflows resp_len and mask=
s device error
- [Medium] media: virtio: leaked session resources when host close command =
fails
- [Low] media: virtio: incorrect -EINVAL returned for copy_from_user failure
--

commit 4f0fbb5128d42f2c68d224b7a3a87ede11d32bde
Author: Alexandre Courbot <gnurou@gmail.com>

    media: virtio: Add ioctl operations and driver logic
   =20
    This patch adds the ioctl operations and the remaining driver logic
    for polling and mmapping. It adds drivers/media/virtio/virtio_media_ioc=
tls.c
    and updates virtio_media_driver.c to support poll, mmap, and ioctls.

> diff --git a/drivers/media/virtio/virtio_media_driver.c b/drivers/media/v=
irtio/virtio_media_driver.c
> index ef8065e344929..5840bb34972f6 100644
> --- a/drivers/media/virtio/virtio_media_driver.c
> +++ b/drivers/media/virtio/virtio_media_driver.c
> @@ -593,10 +602,191 @@ static int virtio_media_device_close(struct file *=
file)
>  {
>  	struct video_device *video_dev =3D video_devdata(file);
>  	struct virtio_media *vv =3D to_virtio_media(video_dev);
>  	struct virtio_media_session *session =3D
>  		fh_to_session(file->private_data);
> =20
>  	return virtio_media_session_close(vv, session);
>  }

[Severity: High]
Does this code introduce a Use-After-Free on close?

If the host sends a VIRTIO_MEDIA_EVT_ERROR event, the driver asynchronously
destroys and frees the session structure. When the file descriptor is
subsequently closed, virtio_media_device_close() is invoked and dereferences
the already freed session pointer.

[Severity: Medium]
Can this leak session resources when the host close command fails?

If virtio_media_send_command() inside virtio_media_session_close() fails, t=
he
function returns early. The VFS will still tear down the file struct,
permanently leaving the session in vv->sessions and leaking all associated
memory allocations, shadow buffers, and queue buffers.

[ ... ]

> +static __poll_t virtio_media_device_poll(struct file *file, poll_table *=
wait)
> +{
[ ... ]
> +	if (req_events & (EPOLLOUT | EPOLLWRNORM)) {
> +		if (!output_queue->streaming)
> +			rc |=3D EPOLLERR;
> +		else if (output_queue->queued_bufs <
> +			 output_queue->allocated_bufs)
> +			rc |=3D EPOLLOUT | EPOLLWRNORM;
> +	}

[Severity: High]
Does a broken counter permanently block EPOLLOUT?

Because virtio_media_qbuf() increments queue->queued_bufs but
virtio_media_dqbuf() never decrements it when returning the buffer to
userspace, the counter will quickly reach queue->allocated_bufs. This causes
virtio_media_device_poll() to permanently fail the queued_bufs <
allocated_bufs condition.

[ ... ]

> +static void virtio_media_vma_close_locked(struct vm_area_struct *vma)
> +{
[ ... ]
> +	cmd_munmap->hdr.cmd =3D VIRTIO_MEDIA_CMD_MUNMAP;
> +	cmd_munmap->driver_addr =3D
> +		(vma->vm_pgoff << PAGE_SHIFT) - vv->mmap_region.addr;
> +	ret =3D virtio_media_send_command(vv, sgs, 1, 1, sizeof(*resp_munmap),
> +					NULL);

[Severity: High]
Does overwriting vma->vm_pgoff with a physical PFN corrupt the core MM inte=
rval
tree?

Because this is a VM_SHARED file mapping, the core MM uses vm_pgoff as the
index coordinate to insert the VMA into mapping->i_mmap. Clobbering it with=
 a
raw physical PFN breaks memory unmapping and forking.

[ ... ]

> +static int virtio_media_device_mmap(struct file *file,
> +				    struct vm_area_struct *vma)
> +{
[ ... ]
> +	vma->vm_private_data =3D vv;
> +	/*
> +	 * Keep the guest address at which the buffer is mapped since we will
> +	 * use that to unmap.
> +	 */
> +	vma->vm_pgoff =3D (resp_mmap->driver_addr + vv->mmap_region.addr) >>
> +			PAGE_SHIFT;

[Severity: High]
Does this missing bounds check on the host-provided MMAP offset allow mappi=
ng
arbitrary physical memory into guest userspace?

The host provides a potentially malicious driver_addr offset during the MMAP
command, which is added to mmap_region.addr and used for the page frame
number mapping without bounds checking against mmap_region.len.

[ ... ]

> +	ret =3D io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> +				 vma->vm_end - vma->vm_start,
> +				 vma->vm_page_prot);
> +	if (ret)
> +		goto end;
> +
> +	vma->vm_ops =3D &virtio_media_vm_ops;
> +
> +end:
> +	mutex_unlock(&vv->vlock);
> +	return ret;
> +}

[Severity: Medium]
Does the error path leak the host-side MMAP mapping?

If io_remap_pfn_range() fails, the function exits early without installing
virtio_media_vm_ops. The VMA is torn down by the core mm, but because vm_ops
is missing, the .close callback is never executed and VIRTIO_MEDIA_CMD_MUNM=
AP
is never sent to the host.

[ ... ]

> @@ -654,9 +844,14 @@ static int virtio_media_probe(struct virtio_device *=
virtio_dev)
>  	vv->eventq =3D vqs[1];
>  	INIT_WORK(&vv->eventq_work, virtio_media_event_work);
> =20
> +	/* Get MMAP buffer mapping SHM region */
> +	virtio_get_shm_region(virtio_dev, &vv->mmap_region,
> +			      VIRTIO_MEDIA_SHM_MMAP);
> +
>  	vd =3D &vv->video_dev;
>  	vd->v4l2_dev =3D &vv->v4l2_dev;
>  	vd->vfl_type =3D VFL_TYPE_VIDEO;
> +	vd->ioctl_ops =3D &virtio_media_ioctl_ops;
>  	vd->fops =3D &virtio_media_fops;
>  	vd->release =3D video_device_release_empty;
>  	strscpy(vd->name, "virtio-media", sizeof(vd->name));

[Severity: High]
Does this code introduce a Use-After-Free on unbind?

The structure containing video_device (virtio_media) is allocated via
devm_kzalloc(). The release callback does not free the enclosing structure,
deferring to devres which disregards file descriptor lifetimes.

When the virtio device is unbound, devres frees the structure. If userspace
still has an open file descriptor, subsequent operations will dereference t=
he
freed memory.

> diff --git a/drivers/media/virtio/virtio_media_ioctls.c b/drivers/media/v=
irtio/virtio_media_ioctls.c
> new file mode 100644
> index 0000000000000..f0b82b5ec7b4a
> --- /dev/null
> +++ b/drivers/media/virtio/virtio_media_ioctls.c

[ ... ]

> +static int virtio_media_send_ext_controls_ioctl(struct v4l2_fh *fh, u32 =
ioctl,
> +						struct v4l2_ext_controls *ctrls)
> +{
[ ... ]
> +	ret =3D virtio_media_send_command(vv, builder.sgs, num_cmd_sgs,
> +					builder.cur_sg - num_cmd_sgs,
> +					sizeof(struct virtio_media_resp_ioctl) +
> +					sizeof(*ctrls),
> +					&resp_len);
> +
> +	/* Just in case the host touched these. */
> +	ctrls->controls =3D controls_backup;
> +	if (ctrls->count !=3D num_ctrls) {
> +		v4l2_err(&vv->v4l2_dev,
> +			 "device returned a number of controls different than the one submitt=
ed\n");
> +	}
> +	if (ctrls->count > num_ctrls)
> +		return -ENOSPC;

[Severity: High]
Can an untrusted host exploit this Time-of-Check to Time-of-Use race to
trigger an out-of-bounds read?

The security check if (ctrls->count > num_ctrls) is executed before
scatterlist_builder_retrieve_ext_ctrls() runs. The check passes on unmodifi=
ed
userspace input, but then data retrieval populates ctrls with the host's
response, allowing the host to inject a huge count which the V4L2 core uses
for an out-of-bounds copy.

> +
> +	/*
> +	 * Even if we have received an error, we may need to read our payload
> +	 * back.
> +	 */
> +	if (ret < 0 && resp_len >=3D sizeof(struct virtio_media_resp_ioctl) +
> +					   sizeof(*ctrls)) {
> +		/*
> +		 * Deliberately ignore the error here as we want to return the
> +		 * previous one.
> +		 */
> +		scatterlist_builder_retrieve_ext_ctrls(&builder,
> +						       num_cmd_sgs + 1, ctrls);
> +		return ret;
> +	}
> +
> +	resp_len -=3D sizeof(struct virtio_media_resp_ioctl);
> +
> +	/* Make sure that the reply's length covers our v4l2_ext_controls */
> +	if (resp_len < sizeof(*ctrls))
> +		return -EINVAL;

[Severity: Medium]
Does this code silently mask device errors and return garbage data as succe=
ss?

If ret < 0 and resp_len is smaller than expected, the first size check is
bypassed. The driver then executes resp_len -=3D sizeof(struct
virtio_media_resp_ioctl), which underflows to a huge positive integer,
defeating the subsequent < sizeof(*ctrls) check and falsely returning 0.

[ ... ]

> +static void virtio_media_clear_queue(struct virtio_media_session *sessio=
n,
> +				     struct virtio_media_queue_state *queue)
> +{
[ ... ]
> +	queue->queued_bufs =3D 0;
> +	queue->streaming =3D false;
> +	queue->is_capture_last =3D false;
> +
> +	mutex_unlock(&session->queues_lock);
> +}

[Severity: High]
Does this missing wakeup cause a thread to hang indefinitely in VIDIOC_DQBU=
F?

A userspace thread blocks in VIDIOC_DQBUF on wait_event_interruptible(). If
a concurrent thread calls VIDIOC_STREAMOFF which triggers
virtio_media_clear_queue(), the queue is cleared and streaming =3D false is
set, but wake_up_all(&session->dqbuf_wait) is never called. The waiting
thread will sleep forever.

[ ... ]

> +static int virtio_media_reqbufs(struct file *file, void *fh,
> +				struct v4l2_requestbuffers *b)
> +{
[ ... ]
> +	/* REQBUFS(0) is an implicit STREAMOFF. */
> +	if (b->count =3D=3D 0)
> +		virtio_media_clear_queue(session, queue);
> +
> +	vfree(queue->buffers);
> +	queue->buffers =3D NULL;

[Severity: High]
Can this reallocation cause a Use-After-Free or list corruption?

The old array is freed without unlinking any currently pending buffers. If =
any
of the buffers are currently queued in the queue->pending_dqbufs list, free=
ing
the array leaves the active list pointing to freed memory.

> +
> +	if (b->count > 0) {
> +		queue->buffers =3D
> +			vzalloc(sizeof(struct virtio_media_buffer) * b->count);
> +		if (!queue->buffers)
> +			return -ENOMEM;
> +	}
> +
> +	queue->allocated_bufs =3D b->count;

[Severity: High]
Can a large b->count cause an integer multiplication overflow on 32-bit pla=
tforms?

The driver allocates an array using vzalloc(sizeof(struct virtio_media_buff=
er)
* b->count). If this overflows the 32-bit size_t, an undersized array is
allocated. queue->allocated_bufs is set to the large b->count, allowing fut=
ure
userspace calls to bypass index bounds checks and access out-of-bounds heap=
 memory.

[Severity: High]
Does an unhandled vzalloc() failure leave the queue in an inconsistent stat=
e?

If vzalloc() fails, it returns -ENOMEM but leaves queue->allocated_bufs at =
its
previous non-zero value. A subsequent VIDIOC_QBUF or VIDIOC_QUERYBUF call f=
rom
userspace will pass the index check and dereference the NULL queue->buffers
array, causing a kernel panic.

[ ... ]

> +static int virtio_media_create_bufs(struct file *file, void *fh,
> +				    struct v4l2_create_buffers *b)
> +{
[ ... ]
> +	queue->buffers =3D
> +		vzalloc(sizeof(*queue->buffers) * (b->index + b->count));
> +	if (!queue->buffers) {
> +		queue->buffers =3D buffers;
> +		return -ENOMEM;
> +	}
> +
> +	memcpy(queue->buffers, buffers,
> +	       sizeof(*buffers) * queue->allocated_bufs);
> +	vfree(buffers);
> +
> +	queue->allocated_bufs =3D b->index + b->count;

[Severity: High]
Can an untrusted host trigger a heap overflow here?

The allocation size is computed using sizeof(*queue->buffers) * (b->index +
b->count). Since index and count are 32-bit integers controlled by the virt=
io
host, their sum can overflow, leading to an undersized allocation. The
subsequent memcpy() copies queue->allocated_bufs items, causing a massive
out-of-bounds write on the vmalloc heap.

[Severity: High]
Does the memcpy() and vfree() cause a Use-After-Free and list corruption?

If any of the buffers are currently queued in the queue->pending_dqbufs lis=
t,
memcpy() shallow-copies the list.next and list.prev pointers. When the old
array is freed, the active list still points to the freed memory.

[ ... ]

> +static int virtio_media_qbuf(struct file *file, void *fh, struct v4l2_bu=
ffer *b)
> +{
[ ... ]
> +	ret =3D virtio_media_send_buffer_ioctl(vfh, VIDIOC_QBUF, b);
> +	if (ret) {
> +		/* Rollback the previous flags as the buffer is not queued. */
> +		buffer->buffer.flags =3D old_flags;
> +		return ret;
> +	}
> +
> +	queue->queued_bufs +=3D 1;
> +
> +	return 0;
> +}

[Severity: High]
Does failing to decrement queue->queued_bufs permanently block EPOLLOUT?

virtio_media_qbuf() increments queue->queued_bufs +=3D 1 when queuing a buf=
fer.
virtio_media_dqbuf() never decrements it when returning the buffer to
userspace. During normal device operation, the counter will quickly reach
queue->allocated_bufs, causing virtio_media_device_poll() to permanently fa=
il
the queued_bufs < allocated_bufs condition.

[ ... ]

> +static int virtio_media_dqbuf(struct file *file, void *fh,
> +			      struct v4l2_buffer *b)
> +{
[ ... ]
> +	mutex_unlock(&vv->vlock);
> +	ret =3D wait_event_interruptible(session->dqbuf_wait,
> +				       !list_empty(buffer_queue));
> +	mutex_lock(&vv->vlock);
> +	if (ret)
> +		return -EINTR;
> +
> +	mutex_lock(&session->queues_lock);
> +	dqbuf =3D list_first_entry(buffer_queue, struct virtio_media_buffer,
> +				 list);
> +	list_del(&dqbuf->list);
> +	mutex_unlock(&session->queues_lock);

[Severity: High]
Does this logic contain a Time-of-Check to Time-of-Use race that leads to l=
ist
corruption?

wait_event_interruptible() verifies !list_empty(), but drops locks. When the
thread resumes, it acquires the locks and unconditionally calls
list_first_entry() and list_del(). If multiple threads are waiting in DQBUF,
they can all wake up. The first thread empties the list, and subsequent
threads corrupt the list by operating on an empty head.

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
Can a malicious host length overwrite leak kernel memory to userspace?

The driver blindly executes memcpy(b, &dqbuf->buffer, sizeof(*b)), copying =
the
host-provided buffer structure. If the untrusted host returns a larger
b->length field, the V4L2 core video_usercopy() will use this modified leng=
th
to copy planes to userspace, reading beyond the bounds of the original
kernel-allocated plane array.

[ ... ]

> +long virtio_media_device_ioctl(struct file *file, unsigned int cmd,
> +			       unsigned long arg)
> +{
[ ... ]
> +	switch (cmd) {
> +	case VIDIOC_S_STD:
> +		ret =3D copy_from_user(&std_id, (void __user *)arg,
> +				     sizeof(std_id));
> +		if (ret) {
> +			ret =3D -EINVAL;
> +			break;
> +		}

[Severity: Low]
Should this return -EFAULT instead of -EINVAL for a failed copy_from_user()?

Userspace expects -EFAULT when passing an invalid pointer to these ioctls.

> diff --git a/drivers/media/virtio/scatterlist_builder.c b/drivers/media/v=
irtio/scatterlist_builder.c
> --- a/drivers/media/virtio/scatterlist_builder.c
> +++ b/drivers/media/virtio/scatterlist_builder.c

[ ... ]

> @@ -424,9 +424,6 @@ __scatterlist_builder_add_userptr(struct scatterlist_=
builder *builder,
>  free_sg:
>  	sg_free_table(&sg_table);
> =20
>  done:
>  	vb2_destroy_framevec(framevec);
>  	return ret;
>  }

[Severity: High]
Does this prematurely unpin user pages while their physical addresses are s=
till
being used by the host?

In __scatterlist_builder_add_userptr(), user memory is pinned to get physic=
al
addresses for the scatterlist. Before the function returns,
vb2_destroy_framevec() unpins the pages unconditionally, even though the ho=
st
device might still be actively performing DMA to those physical addresses
asynchronously, allowing arbitrary physical memory corruption.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917171921.2810=
550-1-briandaniels@google.com?part=3D4
