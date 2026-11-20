Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795212986;
	b=O05VIBwRfuzLu5kChM7cqBdxKyk4HigbWxOusbfOgtK/1gH3iyHIoiEssSgMwaRfppZQ
	 9JWw3axh4chaGo8w+xAd+dAQJsShJDEpfLFrNSBA3Xm1p5WiaD/OjuX3H2IdMLjbnJ5sA
	 kq5vKvUujZehN1xWsOw6TAW+3vsyxRTUsX+yT2/wsvRHeD/YR4pI0sTB/svS1Nipax7I2
	 Rg2QZ6r4mhwG8JMJJIXxpzyqpAcxROOK9o4+UqsiEGhNX+i86aE4UkCP1uBnXvDZEDKXt
	 Ylxc+r00a1tZsk9ssvI6/bHlGUuuCQq28Sc5L9JfXdeMCQTmfaN9Hcw0pY2CzQabzMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212986;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vB1sBwreVbQDLrpu/325EJLanQgfDsU9BeaXM1pInBk=;
	b=1s/L+EWal9NtjSq1s3jxfuE5WF+BYI02E5KfCIa62gK+rfaDjaquFWPlJdq0Jj+F0nLq
	 iUR1kX7kHQoN5lq34EOEb4GggNdZ/j4i0Sni00by8QYe0AQsipI7HW+F5xU7t3bBrjWXT
	 9GRvmCjLwr6dc5z2QKG6wPfKu9XCJs053DQZJGCLzTTfuGWxs8fnVlRE8RlVEW9UpeaHZ
	 7RSDTdQ96MLKnF/lIrnx6Yxr7G0vTIEWmDEs+QMbqFBb9N6meARsKmdwGxJQKDWZ2gDx9
	 L8cwkbWpTmnVoxcH6yrysc6zQLc/CL6L5ZgwERUzHtg9rsWwkRRwb8ZLLey3onC7ASw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WBHCvIw7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602EF606A6BF
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 22:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WBHCvIw7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C091F000D2;
	Fri, 20 Nov 2026 22:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795212985;
	bh=vB1sBwreVbQDLrpu/325EJLanQgfDsU9BeaXM1pInBk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WBHCvIw7YSO2q5nmtYMmEUpD76Rj6Zkwbv3Ee3wGMheVbTQOiq4/Vm2slMel7t3Og
	 cTT60WASA5cINJxDrE+Bmhg4EmwbPTK7R8X/xLOEMp42NhV0RiGMqKqsWxYKwlbjM0
	 pdMLMbtuBhah+FBmXTKm3zXkS64HC4hxOB+XH3A4YnKz5wgKlhCdEUObZYeCSdFcMz
	 cppMhLhgcflpp7FDI0LJBBQcj3PzBxmshcfmy2gWocflf09sPvUBR71qwMHueFSqJM
	 fbwdt9LftlBF7Sit+AQlAuE7chGdq9iZRFqMLWBd17+InK0uEFfTHnTvG4GKNdUTFe
	 e1OOCR04GGeRQ==
Message-ID: <sashiko-outbox-226238@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 5/6] media: virtio: Add MMAP buffer mapping support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brian Daniels" <briandaniels@google.com>
Cc: virtualization@lists.linux.dev, media-ci@linuxtv.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261120215916.3149345-6-briandaniels@google.com>
References: <20261120215916.3149345-1-briandaniels@google.com>
 <20261120215916.3149345-6-briandaniels@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 22:16:25 +0000
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
- [High] media: virtio: missing vm_ops->open() and pgoff corruption in
  vma close
- [High] media: virtio: use-after-free of commandq in
  virtio_media_vma_close()
- [High] media: virtio: mmap_lock and vlock inversion in
  virtio_media_device_mmap()
- [High] media: virtio: use-after-free in virtio_media_vma_close() after
  remove
- [Medium] media: virtio: missing SHM bounds check in
  virtio_media_device_mmap()
- [Medium] media: virtio: VM_MAYWRITE left set on RO mapping in
  virtio_media_device_mmap()
- [Medium] media: virtio: TOCTOU race on session->error in
  virtio_media_device_mmap()
- [Low] media: virtio: 32-bit offset truncation in
  virtio_media_device_mmap()
--

commit ca0abfda91649fedfc5e57137d16c8a739721fdb
Author: Alexandre Courbot <gnurou@gmail.com>

media: virtio: Add MMAP buffer mapping support

This commit adds V4L2_MEMORY_MMAP buffer mapping support to the virtio-media
driver by querying shared memory region 0 during probe and implementing mmap
and VMA close callbacks using VIRTIO_MEDIA_CMD_MMAP and
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
> +	if (ret < 0) {
> +		v4l2_err(&vv->v4l2_dev, "host failed to unmap buffer: %d\n",
> +			 ret);
> +	}
> +}

[Severity: High]
Can virtio_media_vma_close_locked() cause a use-after-free on vv->commandq =
if
a mapping is unmapped after virtio_media_remove()?

An active VMA holds a reference on vma->vm_file, which keeps vv alive until
all mappings are unmapped.  If the device is removed while a buffer is mapp=
ed,
virtio_media_remove() calls virtio_dev->config->del_vqs(virtio_dev), freeing
vv->commandq.  Unlike V4L2 file operations gated by video_is_registered(), =
the
MM subsystem invokes vma->vm_ops->close() directly on munmap() or process
exit, so virtio_media_send_command() dereferences the freed vv->commandq.

> +
> +/**
> + * virtio_media_vma_close() - Close a MMAP buffer mapping.
> + * @vma: VMA of the mapping to close.
> + *
> + * Inform the host that a previously created MMAP mapping is no longer n=
eeded
> + * and can be removed.
> + */
> +static void virtio_media_vma_close(struct vm_area_struct *vma)
> +{
> +	struct virtio_media *vv =3D vma->vm_private_data;
> +
> +	mutex_lock(&vv->vlock);
> +	virtio_media_vma_close_locked(vma);
> +	mutex_unlock(&vv->vlock);
> +}

[Severity: High]
When a mapped VMA outlives virtio_media_remove(), can closing that VMA trig=
ger
both a use-after-free on vv->commandq and a use-after-free and double free =
of
the session?

drivers/media/virtio/virtio_media_driver.c:virtio_media_remove() {
	...
	/* Delete the virtqueues */
	virtio_dev->config->del_vqs(virtio_dev);

	mutex_unlock(&vv->vlock);

	list_for_each_safe(p, n, &vv->sessions) {
		struct virtio_media_session *s =3D
			list_entry(p, struct virtio_media_session, list);

		virtio_media_session_remove(vv, s);
		virtio_media_session_free(s);
	}
}

Because vma->vm_file pins the open struct file while the VMA exists, unmapp=
ing
the VMA after virtio_media_remove() first calls virtio_media_vma_close(),
which accesses the deleted vv->commandq, and then drops the final file
reference via fput(vma->vm_file).  That invokes v4l2_release() ->
virtio_media_device_close(), which dereferences and frees the session in
file->private_data that virtio_media_remove() already freed.

> +
> +static const struct vm_operations_struct virtio_media_vm_ops =3D {
> +	.close =3D virtio_media_vma_close,
> +};

[Severity: High]
Does omitting .open in virtio_media_vm_ops cause premature host unmapping a=
nd
corrupted VIRTIO_MEDIA_CMD_MUNMAP offsets when a VMA is duplicated or split?

When a process with a mapped buffer calls fork(), moves the mapping with
mremap(), or splits the VMA via partial munmap() or mprotect(), the kernel
duplicates the VMA and calls vm_ops->open() without calling
virtio_media_device_mmap().  With no .open callback or reference-counted
mapping state in vma->vm_private_data (such as struct vb2_vmarea_handler),
closing one VMA sends VIRTIO_MEDIA_CMD_MUNMAP to the host while the remaini=
ng
VMA still maps those shared memory pages in guest userspace.

In addition, __split_vma() advances the upper VMA's vm_pgoff by the split
offset, so when the upper half is later closed,
(vma->vm_pgoff << PAGE_SHIFT) - vv->mmap_region.addr computes an offset ins=
ide
the buffer rather than the base driver_addr returned by VIRTIO_MEDIA_CMD_MM=
AP.

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
Can a VIRTIO_MEDIA_EVT_ERROR event arriving before mutex_lock(&vv->vlock)
cause virtio_media_device_mmap() to send VIRTIO_MEDIA_CMD_MMAP for an alrea=
dy
closed session?

CPU0 (virtio_media_device_mmap)   CPU1 (virtio_media_process_events)
mutex_lock(&session->error_lock)
session_error =3D session->error
mutex_unlock(&session->error_lock)
                                  mutex_lock(&session->error_lock)
                                  session->error =3D true
                                  mutex_unlock(&session->error_lock)
                                  virtio_media_session_close(vv, session)
                                    mutex_lock(&vv->vlock)
                                    /* sends VIRTIO_MEDIA_CMD_CLOSE */
                                    mutex_unlock(&vv->vlock)
mutex_lock(&vv->vlock)
/* sends VIRTIO_MEDIA_CMD_MMAP
   on closed session->id */

Re-checking session->error after acquiring vv->vlock (or holding vv->vlock
across the check) would prevent using session->id after
VIRTIO_MEDIA_CMD_CLOSE.

> +	if (!(vma->vm_flags & VM_SHARED))
> +		return -EINVAL;
> +	if (!(vma->vm_flags & (VM_READ | VM_WRITE)))
> +		return -EINVAL;
> +
> +	mutex_lock(&vv->vlock);

[Severity: High]
Does acquiring vv->vlock inside virtio_media_device_mmap() and
virtio_media_vma_close() create an ABBA deadlock with mm->mmap_lock?

CPU0                              CPU1
----                              ----
lock(&mm->mmap_lock)
                                  lock(&vv->vlock)
lock(&vv->vlock)
                                  lock(&mm->mmap_lock)

 *** DEADLOCK ***

CPU0: mmap_region() -> v4l2_mmap() -> virtio_media_device_mmap()
      (or remove_vma() -> virtio_media_vma_close())
CPU1: virtio_media_device_ioctl() -> copy_from_user() / video_ioctl2() /
      pin_user_pages_fast()

virtio_media_device_ioctl() holds vv->vlock across user memory copies and
pin_user_pages_fast(), which acquire mm->mmap_lock on page faults or the GUP
slowpath, while mmap() and munmap() invoke virtio_media_device_mmap() and
virtio_media_vma_close() with mm->mmap_lock already write-locked.

> +
> +	cmd_mmap->hdr.cmd =3D VIRTIO_MEDIA_CMD_MMAP;
> +	cmd_mmap->hdr.__reserved =3D 0;
> +	cmd_mmap->session_id =3D session->id;
> +	cmd_mmap->flags =3D
> +		(vma->vm_flags & VM_WRITE) ? VIRTIO_MEDIA_MMAP_FLAG_RW_MASK : 0;

[Severity: Medium]
When a buffer is mapped read-only on an O_RDWR file descriptor, can userspa=
ce
later gain write access via mprotect() despite the host mapping being creat=
ed
without VIRTIO_MEDIA_MMAP_FLAG_RW_MASK?

For a shared mapping on an O_RDWR file, do_mmap() sets VM_MAYWRITE in
vma->vm_flags even when PROT_WRITE was not requested.  Because VM_MAYWRITE =
is
left set when VM_WRITE is clear, a subsequent mprotect(..., PROT_READ |
PROT_WRITE) installs writable guest PTEs backed by a read-only host shared
memory mapping.  Clearing VM_MAYWRITE via vm_flags_clear(vma, VM_MAYWRITE) =
on
read-only mappings (or checking VM_MAYWRITE when setting cmd_mmap->flags)
would prevent this mismatch.

> +	cmd_mmap->offset =3D vma->vm_pgoff << PAGE_SHIFT;

[Severity: Low]
Can a 64-bit file offset >=3D 4 GiB be silently truncated when assigned to =
the
32-bit cmd_mmap->offset?

On 64-bit kernels, vma->vm_pgoff << PAGE_SHIFT is 64 bits wide while
cmd_mmap->offset is __le32, so an out-of-range mmap() offset wraps modulo 4
GiB and can alias a valid 32-bit plane mem_offset instead of failing with
-EINVAL.

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
Can an invalid or out-of-bounds resp_mmap->driver_addr cause
io_remap_pfn_range() to remap guest physical memory outside vv->mmap_region?

virtio_media_device_mmap() does not check that resp_mmap->driver_addr and t=
he
mapped range fit within vv->mmap_region.len (without overflow), nor that
resp_mmap->driver_addr is page-aligned before shifting it into vma->vm_pgof=
f.
If the host returns an unaligned or out-of-range offset, io_remap_pfn_range=
()
can map arbitrary guest physical addresses outside the shared memory region=
 or
lose the sub-page bits needed to pass the matching driver_addr back in
VIRTIO_MEDIA_CMD_MUNMAP.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120215916.3149=
345-1-briandaniels@google.com?part=3D5
