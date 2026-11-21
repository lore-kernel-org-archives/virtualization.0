Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795230430;
	b=y5S0gOwLzNUZuFRjI3kcG8iPGMMp6RUUiHeq8rI1dSJKA0fe8CnJpUuPShL2ZQgNzF2F
	 rPMxn5c5dApDDORvGG4eIht20hMqQtaHsPMdTqWT+th4d6l5HzGHTZyNUHI9+rOwzTY6w
	 AGH77O8Ac1k9bUNLKW5FOYk7mqb0QoJjyHBN3tlrVFJE2UPaieLFWRWJzkk4HxFdeuRg2
	 43DcEegJ7KbEUmLHb5m2Lsl5ar48VparqQn9DBhOSFUr7hEILAJdmm5sI1LV9uHcErLX3
	 doR/BryPJBCgQ9IvjhjYnJAPqQS9T2xtRhGxlASMirzw4koCvWuUm/agM/0YId8X30Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795230430;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=t00QPQPHZGjKqFU4ALiHfVhOwawSrErkBBwDCpRq5BM=;
	b=LGAbYvBlVZpbqe34nFr+aOnY9N6mCWx8T897s4Cuyp88HSsYGCiCmFHjzTgOArKAEqnH
	 30uJKXWGlgrfxPA9331nitIOc7RleRvdKyycz1VSzQ8im2STjdu30LTs98SV1VDyS/uY9
	 hZPJV8Jr3+tQMGNb2clE951liphGQujSGSYtlDwgZvKCfR4HuZwq8WlV/Z6qrQBLX06Kx
	 9NDSXtguDMHRzTEnxfIpnCacIT5PPM2wNNDf6fYv/uEUDCR3Tbpf5C2uKDAr9Zye5tyJM
	 CJu4uLgQvS9zLIPmoBnIYqZtU7Ay2fwC0omCOOSRZOCQDY2QN0Dx0C19tcROtmThNPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EDkscXht;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F45E606A6B8
	for <virtualization@lists.linux.dev>; Sat, 21 Nov 2026 03:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EDkscXht
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8D91F000C4;
	Sat, 21 Nov 2026 03:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795230429;
	bh=t00QPQPHZGjKqFU4ALiHfVhOwawSrErkBBwDCpRq5BM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EDkscXhtZgDJV3iU6zpAv0Koei3kOKytaBq/1KoLkQrUZ5FQXfMNSvtAev93wN/0j
	 eTpIWyXSaMPJi+49DisMLa5EAcPm6V2RyiQmR0zKYXu6OX5Pm81bpRh9tPE9Xk6t/G
	 Q3dMG1GAC9Z1v/KkVDmXnnJ9IC043O2wEiFwYcAEbB/wCKWX2C/pL7XPUQAkoj48+Y
	 lphHzxnF/5xt0Ra80JOrd25vbsrEHU+gO8j1I9vGR/matzlwCCVbTq3xkWpaD0vCM/
	 Vi+Hac48LK3PkFj6cxjF0PQ7tf5VM3H+jQQcib2WUVCBsookrL+BRqMKo9RYzGHc3H
	 CaDPi6eBT93Bg==
Message-ID: <sashiko-outbox-226557@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 5/6] media: virtio: Add MMAP buffer mapping support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brian Daniels" <briandaniels@google.com>
Cc: virtualization@lists.linux.dev, media-ci@linuxtv.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261121025007.3445723-6-briandaniels@google.com>
References: <20261121025007.3445723-1-briandaniels@google.com>
 <20261121025007.3445723-6-briandaniels@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 03:07:08 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 8 potential
issues to consider:
- [High] media: virtio: missing vm_ops.open and pgoff bug in
  virtio_media_vma_close()
- [High] media: virtio: use-after-free of commandq in
  virtio_media_vma_close()
- [High] media: virtio: ABBA deadlock between mm->mmap_lock and
  vv->vlock in mmap/close/ioctl
- [High] media: virtio: use-after-free in virtio_media_vma_close() after
  remove
- [Medium] media: virtio: missing mmap_region bounds check in
  virtio_media_device_mmap()
- [Medium] media: virtio: offset truncation and VM_MAYWRITE in
  virtio_media_device_mmap()
- [Medium] media: virtio: missing VM_MAYWRITE clear on read-only mmap in
  virtio_media_device_mmap()
- [Medium] media: virtio: TOCTOU race on session->error in
  virtio_media_device_mmap()
--

commit 14004eedd96a0d60c179b127c333d6afc58f6ae1
Author: Alexandre Courbot <gnurou@gmail.com>

media: virtio: Add MMAP buffer mapping support

This commit adds V4L2_MEMORY_MMAP buffer mapping support to the virtio-media
driver by querying shared memory region 0 at probe time and implementing the
mmap file operation and VMA close callback with VIRTIO_MEDIA_CMD_MMAP and
VIRTIO_MEDIA_CMD_MUNMAP.

> diff --git a/drivers/media/virtio/virtio_media_driver.c b/drivers/media/v=
irtio/virtio_media_driver.c
> index 7483577256bd0..eb6b31d7e370c 100644
> --- a/drivers/media/virtio/virtio_media_driver.c
> +++ b/drivers/media/virtio/virtio_media_driver.c
[ ... ]
> @@ -697,12 +705,155 @@ static __poll_t virtio_media_device_poll(struct fi=
le *file, poll_table *wait)
>  	return rc;
>  }
> =20
> +static void virtio_media_vma_close_locked(struct vm_area_struct *vma)
> +{
> +	struct virtio_media *vv =3D vma->vm_private_data;
> +	struct virtio_media_cmd_munmap *cmd_munmap =3D &vv->cmd.munmap;
> +	struct virtio_media_resp_munmap *resp_munmap =3D &vv->resp.munmap;
> +	struct scatterlist cmd_sg =3D {}, resp_sg =3D {};
> +	struct scatterlist *sgs[2] =3D { &cmd_sg, &resp_sg };
> +	int ret;
> +
> +	sg_set_buf(&cmd_sg, cmd_munmap, sizeof(*cmd_munmap));
> +	sg_mark_end(&cmd_sg);
> +
> +	sg_set_buf(&resp_sg, resp_munmap, sizeof(*resp_munmap));
> +	sg_mark_end(&resp_sg);
> +
> +	cmd_munmap->hdr.cmd =3D VIRTIO_MEDIA_CMD_MUNMAP;
> +	cmd_munmap->hdr.__reserved =3D 0;
> +	cmd_munmap->driver_addr =3D
> +		(vma->vm_pgoff << PAGE_SHIFT) - vv->mmap_region.addr;
> +	ret =3D virtio_media_send_command(vv, sgs, 1, 1, sizeof(*resp_munmap),
> +					NULL);

[Severity: High]
Can virtio_media_vma_close_locked() dereference a freed vv->commandq if the
virtio device was removed while a buffer remained mapped in userspace?

An active VMA pins vma->vm_file, which keeps struct virtio_media allocated
until all mappings are unmapped.  If virtio_media_remove() runs first, it
calls virtio_dev->config->del_vqs(virtio_dev), freeing vv->commandq.  Unlike
the v4l2 file operation wrappers that check video_is_registered(),
vma->vm_ops->close is invoked directly by the MM subsystem on munmap() or
process exit and sends VIRTIO_MEDIA_CMD_MUNMAP on the freed virtqueue.

> +	if (ret < 0) {
> +		v4l2_err(&vv->v4l2_dev, "host failed to unmap buffer: %d\n",
> +			 ret);
> +	}
> +}
> +
> +/**
> + * virtio_media_vma_close() - Close a MMAP buffer mapping.
> + * @vma: VMA of the mapping to close.
> + *
> + * Inform the host that a previously created MMAP mapping is no longer n=
eeded
> + * and can be removed.
> + + */
> +static void virtio_media_vma_close(struct vm_area_struct *vma)
> +{
> +	struct virtio_media *vv =3D vma->vm_private_data;
> +
> +	mutex_lock(&vv->vlock);
> +	virtio_media_vma_close_locked(vma);
> +	mutex_unlock(&vv->vlock);
> +}

[Severity: High]
When a mapped VMA pins vma->vm_file across virtio_media_remove(), does
unmapping the VMA cause a use-after-free in virtio_media_vma_close() follow=
ed
by a use-after-free and double free of the session in
virtio_media_device_close()?

virtio_media_remove() deletes the virtqueues and frees every session in
vv->sessions while vma->vm_file is still open.  When the process later unma=
ps
the VMA or exits, remove_vma() calls virtio_media_vma_close() (which uses t=
he
freed vv->commandq) and then drops vma->vm_file, triggering v4l2_release() =
->
virtio_media_device_close(), which accesses and frees the already-freed
struct virtio_media_session a second time.

> +
> +static const struct vm_operations_struct virtio_media_vm_ops =3D {
> +	.close =3D virtio_media_vma_close,
> +};

[Severity: High]
What happens when a mapped VMA is duplicated by fork() or split by a partial
munmap(), mprotect(), or mremap()?

Because virtio_media_vm_ops has no .open callback and vma->vm_private_data
Does not track a reference-counted mapping object, closing the first VMA in=
 a
forked child or half of a split VMA sends VIRTIO_MEDIA_CMD_MUNMAP while the
remaining VMA still maps those guest physical pages, and closing the
remaining VMA sends an extra unmap command.

In addition, __split_vma() advances vma->vm_pgoff on the upper half of a
split VMA, so virtio_media_vma_close_locked() computes cmd_munmap->driver_a=
ddr
from the shifted vma->vm_pgoff instead of the buffer's base driver_addr and
fails to unmap the buffer on the host.

> +
> +/**
> + * virtio_media_device_mmap() - Perform a mmap request from userspace.
> + * @file: opened file of the session to map for.
> + * @vma: VM area struct describing the desired mapping.
> + *
> + * This requests the host to map a MMAP buffer for us, so we can then ma=
ke that
> + * mapping visible into user-space address space.
> + */
> +static int virtio_media_device_mmap(struct file *file,
> +				    struct vm_area_struct *vma)
> +{
> +	struct video_device *video_dev =3D video_devdata(file);
> +	struct virtio_media *vv =3D to_virtio_media(video_dev);
> +	struct virtio_media_session *session =3D
> +		fh_to_session(file->private_data);
> +	struct virtio_media_cmd_mmap *cmd_mmap =3D &session->cmd.mmap;
> +	struct virtio_media_resp_mmap *resp_mmap =3D &session->resp.mmap;
> +	struct scatterlist cmd_sg =3D {}, resp_sg =3D {};
> +	struct scatterlist *sgs[2] =3D { &cmd_sg, &resp_sg };
> +	int ret;
> +
> +	mutex_lock(&session->error_lock);
> +	bool session_error =3D session->error;
> +
> +	mutex_unlock(&session->error_lock);
> +
> +	if (session_error)
> +		return -EIO;

[Severity: Medium]
Can session->error become true after session->error_lock is dropped here and
before mutex_lock(&vv->vlock) is acquired below?

CPU0                              CPU1 (eventq_work)
virtio_media_device_mmap()
  lock(&session->error_lock)
  session_error =3D session->error
  unlock(&session->error_lock)
                                  virtio_media_process_events()
                                    lock(&session->error_lock)
                                    session->error =3D true
                                    unlock(&session->error_lock)
                                    virtio_media_session_close()
                                      lock(&vv->vlock)
                                      /* closes session->id on host */
                                      unlock(&vv->vlock)
  lock(&vv->vlock)
  /* sends VIRTIO_MEDIA_CMD_MMAP
     for closed session->id */

Checking session->error after acquiring vv->vlock (or holding vv->vlock acr=
oss
the check) would avoid sending VIRTIO_MEDIA_CMD_MMAP for a closed session.

> +	if (!(vma->vm_flags & VM_SHARED))
> +		return -EINVAL;
> +	if (!(vma->vm_flags & (VM_READ | VM_WRITE)))
> +		return -EINVAL;
> +
> +	mutex_lock(&vv->vlock);

[Severity: High]
Does acquiring vv->vlock inside virtio_media_device_mmap() and
virtio_media_vma_close() create an ABBA deadlock with current->mm->mmap_loc=
k?

CPU0                              CPU1
----                              ----
lock(&mm->mmap_lock)
                                  lock(&vv->vlock)
lock(&vv->vlock)
                                  lock(&mm->mmap_lock)

 *** DEADLOCK ***

CPU0: mmap_region() -> virtio_media_device_mmap() (or munmap() ->
      virtio_media_vma_close())
CPU1: virtio_media_device_ioctl() -> video_ioctl2() -> copy_from_user() (or
      __scatterlist_builder_add_userptr() -> vb2_create_framevec())

The MM core calls f_op->mmap and vm_ops->close with mm->mmap_lock held in
write mode, whereas virtio_media_device_ioctl() holds vv->vlock across user
copies and userptr page pinning that fault or take mm->mmap_lock.

> +
> +	cmd_mmap->hdr.cmd =3D VIRTIO_MEDIA_CMD_MMAP;
> +	cmd_mmap->hdr.__reserved =3D 0;
> +	cmd_mmap->session_id =3D session->id;
> +	cmd_mmap->flags =3D
> +		(vma->vm_flags & VM_WRITE) ? VIRTIO_MEDIA_MMAP_FLAG_RW_MASK : 0;

[Severity: Medium]
When a file opened O_RDWR is mapped with PROT_READ and MAP_SHARED, does
leaving VM_MAYWRITE set on the VMA allow userspace to bypass the read-only
host mapping via mprotect()?

Because VM_WRITE is clear, VIRTIO_MEDIA_MMAP_FLAG_RW_MASK is not sent to the
host, but VM_MAYWRITE remains set in vma->vm_flags, allowing a later
mprotect(..., PROT_READ | PROT_WRITE) to make the guest page tables writable
without host write permission.  Should this clear VM_MAYWRITE with
vm_flags_clear(vma, VM_MAYWRITE) when !(vma->vm_flags & VM_WRITE)?

> +	cmd_mmap->offset =3D vma->vm_pgoff << PAGE_SHIFT;

[Severity: Medium]
Can a 64-bit file offset >=3D 4 GiB silently truncate when assigned to the
32-bit cmd_mmap->offset field?

On 64-bit kernels vma->vm_pgoff is an unsigned long, so shifting it into
__le32 cmd_mmap->offset without checking vma->vm_pgoff > (U32_MAX >>
PAGE_SHIFT) discards the upper bits and aliases a valid 32-bit plane
mem_offset instead of returning -EINVAL.  Also, when mapping read-only
(!(vma->vm_flags & VM_WRITE)), VM_MAYWRITE is left set on the VMA, allowing
mprotect(PROT_WRITE) to upgrade guest PTE permissions afterward.

> +	cmd_mmap->__reserved =3D 0;
> +
> +	sg_set_buf(&cmd_sg, cmd_mmap, sizeof(*cmd_mmap));
> +	sg_mark_end(&cmd_sg);
> +
> +	sg_set_buf(&resp_sg, resp_mmap, sizeof(*resp_mmap));
> +	sg_mark_end(&resp_sg);
> +
> +	/*
> +	 * The host performs reference counting and is smart enough to return
> +	 * the same guest physical address if this is called several times on
> +	 * the same
> +	 * buffer.
> +	 */
> +	ret =3D virtio_media_send_command(vv, sgs, 1, 1, sizeof(*resp_mmap),
> +					NULL);
> +	if (ret < 0)
> +		goto end;
> +
> +	vma->vm_private_data =3D vv;
> +	/*
> +	 * Keep the guest address at which the buffer is mapped since we will
> +	 * use that to unmap.
> +	 */
> +	vma->vm_pgoff =3D (resp_mmap->driver_addr + vv->mmap_region.addr) >>
> +			PAGE_SHIFT;
> +
> +	/*
> +	 * We cannot let the mapping be larger than the buffer.
> +	 */
> +	if (vma->vm_end - vma->vm_start > PAGE_ALIGN(resp_mmap->len)) {
> +		dev_dbg(&video_dev->dev,
> +			"invalid MMAP, as it would overflow buffer length\n");
> +		ret =3D -EINVAL;
> +		goto cleanup;
> +	}
> +
> +	ret =3D io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> +				 vma->vm_end - vma->vm_start,
> +				 vma->vm_page_prot);

[Severity: Medium]
Should virtio_media_device_mmap() validate that resp_mmap->driver_addr is
page-aligned and that the mapped range fits within vv->mmap_region.len befo=
re
calling io_remap_pfn_range()?

vv->mmap_region.len is never checked, so an out-of-bounds or overflowing
resp_mmap->driver_addr or resp_mmap->len from the host would cause
io_remap_pfn_range() to remap guest physical memory outside the virtio shar=
ed
memory region into userspace, and an unaligned driver_addr would lose its
sub-page offset when shifted into vma->vm_pgoff.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121025007.3445=
723-1-briandaniels@google.com?part=3D5
