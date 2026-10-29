Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793294385;
	b=dPwV2daoiO+OKQOsICftWarHSIoiGPhsfq/z46KOGlt0p5vqdvTDK/RGC53ABRfPDOCj
	 7EAf7D8Ivghe4PG7scrpcwZz0qHMBo8+n4jWWxw55Ce2w/OldYspOdO0QZBORJ4cq+wtx
	 ex8azlyAvWpo9DUxKvuNlbS5aSCaAIdjfwRqjvglsO8WFEUsq52XJ68m9ejknogxrpvBX
	 2NQx/NIj52cboiV43Tefqx/EUeWeQQoUEVaSDZESxwSpYo4ifmHxVV0brcudrTgmrdwpR
	 br4nhxr+NJtKohxlJXgdhoWKyNy46wEHBeN2SUcWj7SMtMWbmfp7KnQOGr8BEkc0E8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793294385;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BUF/JRE+zD2Dc10ykyVrR8juXEcI8VXawWubWGXldD8=;
	b=j/aqctJ1H1bzfC0BJUfKjmwuNNI/VNYVpHXyz1Oq21yCAn12XsSzbQ9bx13mKKx2Fx8H
	 JNxxMFxMy0Vuu5/yTCFdjrUluARybhS0vB76oU6ccg26/Hp3fVfrswgL+0NPV4RG3ph91
	 8vzS82Y41IUEe98BH+IxjoRTjIm/NyEVM5XaAnZ2ahKdFwPv5xk5qE5lPmxrAncmUm53M
	 hnEDW5FowGk2YKCXc4mecbJw/gcLwbN/oO1DmE7fBoXgB4vyCxMy+87JdFdthRGCfgkoy
	 7F+S7ZjgtZJ1bnxZkHX20JbFCHYDlWb3ViJLTr5Fo/fa1K9r4I179buuPW7pOrXMK9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e4nsB09+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9961606A31A
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e4nsB09+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC341F01816;
	Thu, 29 Oct 2026 17:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793294384;
	bh=BUF/JRE+zD2Dc10ykyVrR8juXEcI8VXawWubWGXldD8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e4nsB09+C5ljRVfEIf9O7iS+372NLerN69T7ZQrKWMWkN+U3ZSn2b9t3LrCsjVLop
	 3dwuzgj1Nu7WbaIJhhIAXVKKsKBMVIgAJOMCILoFKQhpQL4eV4RpAFDWYzi2lXSHy2
	 FOGrHx+BL4QkUiMQlH82WgcbcAHYTFwBYXGgO9Z88LgGRVqXYkXbZIqItiLw1OVd20
	 Bnk/J95skVHcxKcA9/ug4IktEEY2uvJG1Gv0Sq7SnQ8rqoQY9z9lRoBONPYSo6kMdL
	 JkHOdQW5mCek0ZqbEDN880vKcWa8ut6qiJPpubjRh+yDXEgVxk8WpmP/jwDejOfBYu
	 zsTUFe+r4GWvA==
Message-ID: <sashiko-outbox-189728@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 5/5] media: virtio: Add MMAP buffer mapping support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brian Daniels" <briandaniels@google.com>
Cc: virtualization@lists.linux.dev, media-ci@linuxtv.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261029153038.3800747-6-briandaniels@google.com>
References: <20261029153038.3800747-1-briandaniels@google.com>
 <20261029153038.3800747-6-briandaniels@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 17:19:44 +0000
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
- [High] media: virtio: missing VMA open callback and broken munmap offset =
on VMA split
- [High] media: virtio: missing SHM bounds and offset checks in virtio_medi=
a_device_mmap()
- [High] media: virtio: read-only mmap leaves VM_MAYWRITE set in virtio_med=
ia_device_mmap()
- [High] media: virtio: access to freed commandq in virtio_media_vma_close()
- [High] media: virtio: ABBA deadlock between vv->vlock and mm->mmap_lock
- [Medium] media: virtio: missing session->error check in virtio_media_devi=
ce_mmap()
--

commit f2fa31d4e435156536271ee6a79a737826897ef4
Author: Alexandre Courbot <gnurou@gmail.com>

media: virtio: Add MMAP buffer mapping support

This commit adds support for mapping V4L2_MEMORY_MMAP buffers into guest
userspace via virtio shared memory region 0 using VIRTIO_MEDIA_CMD_MMAP and
VIRTIO_MEDIA_CMD_MUNMAP.

> diff --git a/drivers/media/virtio/virtio_media_driver.c b/drivers/media/v=
irtio/virtio_media_driver.c
> index 877ac154b3221..865b6dfad7fb6 100644
> --- a/drivers/media/virtio/virtio_media_driver.c
> +++ b/drivers/media/virtio/virtio_media_driver.c
[ ... ]
> @@ -687,12 +695,148 @@ static __poll_t virtio_media_device_poll(struct fi=
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
Can virtio_media_vma_close() dereference a freed vv->commandq if the virtio
device is removed while a buffer remains mapped in userspace?

When a process maps a buffer via virtio_media_device_mmap(), vma->vm_file
keeps the struct file and vv->video_dev alive across virtio_media_remove().
However, virtio_media_remove() calls virtio_dev->config->del_vqs(virtio_dev=
),
which frees vv->commandq, and frees all sessions in vv->sessions:

drivers/media/virtio/virtio_media_driver.c:virtio_media_remove() {
    ...
    video_unregister_device(&vv->video_dev);
    virtio_media_device_reset(virtio_dev);
    virtio_dev->config->del_vqs(virtio_dev);
    ...
}

When the process later calls munmap() or exits, remove_vma() -> vma_close()
invokes virtio_media_vma_close() -> virtio_media_vma_close_locked() ->
virtio_media_send_command() -> virtio_media_kick_command(), which accesses
vv->commandq without checking if the device was unregistered.

Similarly, in v4l2_mmap() -> virtio_media_device_mmap(), video_is_registere=
d()
is checked before acquiring vv->vlock. If virtio_media_remove() runs before
virtio_media_device_mmap() acquires vv->vlock, won't virtio_media_device_mm=
ap()
write to the freed session->cmd.mmap and dereference the freed vv->commandq?

> +
> +static const struct vm_operations_struct virtio_media_vm_ops =3D {
> +	.close =3D virtio_media_vma_close,
> +};

[Severity: High]
What happens when a mapped VMA is duplicated or split via fork(), mremap(),=
 or
partial munmap()/mprotect()?

Because virtio_media_vm_ops only defines .close and omits .open (and
vma->vm_private_data stores vv directly rather than a reference-counted
mapping structure like vb2_common_vm_ops), dup_mmap(), copy_vma(), and
__split_vma() create additional vm_area_struct instances without incrementi=
ng
any reference count. When the first VMA closes, virtio_media_vma_close() wi=
ll
send VIRTIO_MEDIA_CMD_MUNMAP to the host while the remaining VMA(s) are sti=
ll
mapped in guest userspace, and closing the remaining VMA(s) later will send
unbalanced VIRTIO_MEDIA_CMD_MUNMAP commands.

Furthermore, when __split_vma() splits a VMA at addr, it advances
vma->vm_pgoff on the upper VMA by linear_page_delta(vma, addr). When that
upper VMA is closed, virtio_media_vma_close_locked() computes:

	cmd_munmap->driver_addr =3D
		(vma->vm_pgoff << PAGE_SHIFT) - vv->mmap_region.addr;

which sends a shifted interior offset instead of the base driver_addr retur=
ned
by VIRTIO_MEDIA_CMD_MMAP, leaking the host mapping.

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
> +	if (!(vma->vm_flags & VM_SHARED))
> +		return -EINVAL;
> +	if (!(vma->vm_flags & (VM_READ | VM_WRITE)))
> +		return -EINVAL;
> +
> +	mutex_lock(&vv->vlock);

[Severity: High]
Could acquiring vv->vlock in virtio_media_device_mmap() and
virtio_media_vma_close() cause an ABBA deadlock with mm->mmap_lock?

Both virtio_media_device_mmap() and virtio_media_vma_close() are called by =
the
MM core while holding current->mm->mmap_lock, establishing the lock order
mm->mmap_lock -> vv->vlock.

However, in drivers/media/virtio/virtio_media_ioctls.c,
virtio_media_device_ioctl() acquires vv->vlock and holds it across
copy_from_user(), copy_to_user(), and video_ioctl2() (which calls
video_usercopy(), and for VIDIOC_G/S/TRY_EXT_CTRLS calls
virtio_media_send_ext_controls_ioctl() ->
scatterlist_builder_add_ext_ctrls_userptrs() ->
__scatterlist_builder_add_userptr() -> vb2_create_framevec() ->
get_vaddr_frames() -> pin_user_pages_fast()). Those usercopy faults and GUP
paths acquire current->mm->mmap_lock while holding vv->vlock, establishing =
the
reverse order vv->vlock -> mm->mmap_lock.

> +
> +	cmd_mmap->hdr.cmd =3D VIRTIO_MEDIA_CMD_MMAP;
> +	cmd_mmap->hdr.__reserved =3D 0;
> +	cmd_mmap->session_id =3D session->id;

[Severity: Medium]
Should virtio_media_device_mmap() check session->error before sending
VIRTIO_MEDIA_CMD_MMAP?

When VIRTIO_MEDIA_EVT_ERROR is processed in virtio_media_process_events(), =
the
driver sets session->error =3D true and calls virtio_media_session_close(vv,
session) to close session->id on the host while the guest file descriptor is
still open. Unlike virtio_media_device_ioctl(), which checks session->error
and returns -EIO, virtio_media_device_mmap() does not check session->error =
and
will send VIRTIO_MEDIA_CMD_MMAP with a session_id that has already been clo=
sed
on the host.

> +	cmd_mmap->flags =3D
> +		(vma->vm_flags & VM_WRITE) ? VIRTIO_MEDIA_MMAP_FLAG_RW_MASK : 0;

[Severity: High]
When a user opens the video device with O_RDWR and calls mmap() with PROT_R=
EAD
and MAP_SHARED, the MM core sets VM_MAYWRITE on vma->vm_flags while leaving
VM_WRITE clear. Here, virtio_media_device_mmap() requests a read-only mappi=
ng
from the host (cmd_mmap->flags =3D 0), but leaves VM_MAYWRITE set on the VM=
A.

Can userspace subsequently call mprotect(addr, len, PROT_READ | PROT_WRITE)=
 to
make the guest PTEs writable for a buffer that was mapped read-only on the
host? Should vm_flags_clear(vma, VM_MAYWRITE) be called when VM_WRITE is not
set?

> +	cmd_mmap->offset =3D vma->vm_pgoff << PAGE_SHIFT;
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

[Severity: High]
Does virtio_media_device_mmap() need to validate cmd_mmap->offset and the
returned resp_mmap->driver_addr and resp_mmap->len against vv->mmap_region?

First, cmd_mmap->offset is a 32-bit __le32, so if userspace passes a page
offset where vma->vm_pgoff << PAGE_SHIFT >=3D 4 GiB, the upper bits are sil=
ently
truncated instead of returning -EINVAL.

Second, resp_mmap->driver_addr and resp_mmap->len are used to compute
vma->vm_pgoff and remap the range via io_remap_pfn_range() without checking
that resp_mmap->driver_addr is page-aligned, that the additions do not
overflow, or that the mapped range [driver_addr, driver_addr + size) actual=
ly
lies within vv->mmap_region.len. If the host returns an out-of-bounds
driver_addr or len, could io_remap_pfn_range() map arbitrary guest physical
memory outside the virtio shared memory region into userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029153038.3800=
747-1-briandaniels@google.com?part=3D5
