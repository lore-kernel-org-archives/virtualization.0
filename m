Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795230850;
	b=VvjqqoafB81pPk39StCOGVojvdnZhHHhsozXskPbHcVXkRPr+23k98woi1Fj9WMJZDh0
	 3Nwa7O/Iuq91PKKlTjnlEdfDy9kAQbAZ36kmQ6+tGzaHPHsfk4XTgcKn40Y1yf1C7VLar
	 KnLssqA8OOrvVA2bT0kiljA0z7xDTrPUAuQ/dTtViZ5PY2pdZEsokAOOmRTiyk/sFjUP5
	 AURnuWgQCfiq/uniodRxXCfmTXtEYU69LCZgp7dmWVuUpn+sL6GUltUqGqNwDKIfizeyn
	 dt/wPc10j4SFjGhNAPIF8peBp+3JPnkqXPwvGocSEocmse+Zv58cWZKMND7trqnrOyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795230850;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bGuoSobjJJHhadNnOeAyU8G32ROMq2iT1dSMwS406Cg=;
	b=f1lJbVdrkfp+NVkmMzPPC+zg9F8cRlKULRSTda7fO60ue7xaNj4EgdkjorbtPsm4wRd2
	 pVfM/atdmfSrKnCwql+5616c9xIu9zuSjBGWjaSXkHTu1dzWBiIkYOxUsigcpQEO16ISe
	 ceHzz+tEA861pSNYIxkOXXbJzFrl4s1WTROldKwf+nMZAsGygDgRISVBCfEUWegWJG3UG
	 VXiP0pG26UlCVEdLzHNHTXMRd8uf9NfCazxoy3d30j0SSyi4Uf3j7lsvqvU/LAehhLsUw
	 74EzAUM2DBU76oecmEM1aMnqLdo0asEq5V5+rsi4cQwPMMJ2m9N0meiMXLGjHakv8ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y+EX8KNK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3704C606A33F
	for <virtualization@lists.linux.dev>; Sat, 21 Nov 2026 03:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y+EX8KNK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BCB1F000C4;
	Sat, 21 Nov 2026 03:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795230850;
	bh=bGuoSobjJJHhadNnOeAyU8G32ROMq2iT1dSMwS406Cg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y+EX8KNKlLAn8emaPM+LxPH8Aw5MtRfSDXOZC0jMEGJGztgWE1NOlX3izSImUnjYh
	 shdwf96AoBMtwJG8X0hBfFqusvBsAXg5cePh2aer+LaK+nzpiPSx/AHXvP3Eu93ZA8
	 2YHqnKQQ1prKMZ9FqUZyJHOKJeWZqvSvBVnk1biHTK5JArVuMR/ShT+AGP+0a8B/z9
	 leJdh4linDHeK9sbvgVuf1J+xV0/WtJBVzaHtQVbJQT6DZdI8HAdtCB20RTroqoLNz
	 6hNoxDb5QCUMsPFj7YYfD+O26y3X7yH1ckFeEwgc6xiyf5wV0TnovIID7NrIGfwX8Z
	 HJmZt73zKuHFg==
Message-ID: <sashiko-outbox-226563@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 3/6] media: virtio: Add extended controls support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brian Daniels" <briandaniels@google.com>
Cc: virtualization@lists.linux.dev, media-ci@linuxtv.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261121025007.3445723-4-briandaniels@google.com>
References: <20261121025007.3445723-1-briandaniels@google.com>
 <20261121025007.3445723-4-briandaniels@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 03:14:09 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 10 potential
issues to consider:
- [High] media: virtio: two-argument calls to vb2_destroy_framevec()
  break build
- [High] media: virtio: framevecs array leak in
  scatterlist_builder_free_framevecs()
- [High] media: virtio: framevec and pinned page leaks on ext_ctrls
  error paths
- [High] media: virtio: stack buffers mapped for DMA in
  scatterlist_builder_add_data()
- [Medium] media: virtio: gfp_mask =3D 0 passed to
  sg_alloc_table_from_pages()
- [Medium] media: virtio: ctrls->count checked before shadow copy and
  not restored
- [Medium] media: virtio: sgs index passed as desc_index in ext_ctrls
  response
- [Medium] media: virtio: wrong errno in
  __scatterlist_builder_add_userptr()
- [Low] media: virtio: missing @num_framevecs kernel-doc in
  scatterlist_builder
- [Low] media: virtio: missing endian conversions for
  virtio_media_sg_entry
--

commit 27e06a79a3e678981f79713cac25fd1f43109084
Author: Alexandre Courbot <gnurou@gmail.com>

media: virtio: Add extended controls support

This commit adds support for the VIDIOC_G_EXT_CTRLS, VIDIOC_S_EXT_CTRLS,
and VIDIOC_TRY_EXT_CTRLS ioctls by pinning userspace control payloads with
frame vectors and passing their physical segments to the host via the
session shadow buffer.

> diff --git a/drivers/media/virtio/scatterlist_builder.c b/drivers/media/v=
irtio/scatterlist_builder.c
> index ae8ffee82fa6e..631c7b13c438c 100644
> --- a/drivers/media/virtio/scatterlist_builder.c
> +++ b/drivers/media/virtio/scatterlist_builder.c
> @@ -220,3 +220,305 @@ int scatterlist_builder_add_ioctl_resp(struct scatt=
erlist_builder *builder,
>  	return scatterlist_builder_add_data(builder, resp_ioctl,
>  					    sizeof(*resp_ioctl));
>  }
> +
> +/**
> + * __scatterlist_builder_add_userptr() - Add user pages to @builder.
> + * @builder: builder to use.
> + * @userptr: pointer to userspace memory that we want to add.
> + * @length: length of the data to add.
> + * @sg_list: output parameter. Upon success, points to the area of the s=
hadow
> + *           buffer containing the array of SG entries to be added to the
> + *           descriptor chain.
> + * @nents: output parameter. Upon success, contains the number of entries
> + *         pointed to by @sg_list.
> + *
> + * Data referenced by userspace pointers can be potentially large and ve=
ry
> + * scattered, which could overwhelm the descriptor chain if added as-is.=
 For
> + * these, we instead build an array of &struct virtio_media_sg_entry in =
the
> + * shadow buffer and reference it using a single descriptor.
> + *
> + * This function is a helper to perform that. Callers should then add the
> + * descriptor to the chain properly.
> + *
> + * Returns %-EFAULT if @userptr is not a valid user address, which is a =
case the
> + * driver should consider as "normal" operation. All other failures sign=
al a
> + * problem with the driver.
> + */
> +static int
> +__scatterlist_builder_add_userptr(struct scatterlist_builder *builder,
> +				  unsigned long userptr, unsigned long length,
> +				  struct virtio_media_sg_entry **sg_list,
> +				  int *nents)
> +{
> +	struct sg_table sg_table =3D {};
> +	struct frame_vector *framevec;
> +	struct scatterlist *sg_iter;
> +	struct page **pages;
> +	const unsigned int offset =3D userptr & ~PAGE_MASK;
> +	unsigned int pages_count;
> +	size_t entries_size;
> +	size_t initial_cur_framevec =3D builder->cur_framevec;
> +	int i;
> +	int ret;
> +
> +	if (builder->cur_framevec >=3D builder->num_framevecs) {
> +		pr_err("Ran out of framevecs (%zu/%zu)", builder->cur_framevec,
> +		       builder->num_framevecs);
> +		ret =3D -ENOMEM;
> +	}
> +
> +	framevec =3D vb2_create_framevec(userptr, length, true);
> +	if (IS_ERR(framevec)) {
> +		if (PTR_ERR(framevec) !=3D -EFAULT) {
> +			pr_warn("error %ld creating frame vector for userptr 0x%lx, length 0x=
%lx\n",
> +				PTR_ERR(framevec), userptr, length);
> +		} else {
> +			/* -EINVAL is expected in case of invalid userptr. */
> +			framevec =3D ERR_PTR(-EINVAL);
> +		}
> +		return PTR_ERR(framevec);
> +	}

[Severity: Medium]
Should this preserve -EFAULT instead of converting it to -EINVAL?

For extended controls with userspace payload pointers ( unlike
V4L2_MEMORY_USERPTR buffer queueing), the V4L2 UAPI and the kernel-doc
above both specify -EFAULT when a control's userspace address is invalid.

> +
> +	pages =3D frame_vector_pages(framevec);
> +	if (IS_ERR(pages)) {
> +		pr_warn("error getting vector pages\n");
> +		ret =3D PTR_ERR(pages);
> +		goto free_framevec;
> +	}
> +	pages_count =3D frame_vector_count(framevec);
> +	ret =3D sg_alloc_table_from_pages(&sg_table, pages, pages_count, offset,
> +					length, 0);

[Severity: Medium]
Should the gfp_mask argument to sg_alloc_table_from_pages() be GFP_KERNEL
instead of 0?  Passing 0 clears all reclaim flags, so scatterlist
allocation in sleepable ioctl context cannot reclaim memory under pressure.

> +	if (ret) {
> +		pr_warn("error creating sg table\n");
> +		goto free_framevec;
> +	}
> +
> +	/* Allocate our actual SG in the shadow buffer. */
> +	*nents =3D sg_nents(sg_table.sgl);
> +	entries_size =3D sizeof(**sg_list) * *nents;
> +	if (builder->shadow_buffer_pos + entries_size >
> +	    builder->shadow_buffer_size) {
> +		ret =3D -ENOMEM;
> +		goto free_sg;
> +	}
> +
> +	*sg_list =3D builder->shadow_buffer + builder->shadow_buffer_pos;
> +	builder->shadow_buffer_pos +=3D entries_size;
> +
> +	for_each_sgtable_sg(&sg_table, sg_iter, i) {
> +		struct virtio_media_sg_entry *sg_entry =3D &(*sg_list)[i];
> +
> +		sg_entry->start =3D sg_phys(sg_iter);
> +		sg_entry->len =3D sg_iter->length;
> +		sg_entry->__reserved =3D 0;
> +	}

[Severity: Low]
struct virtio_media_sg_entry declares start as __le64 and len as __le32.
Should these assignments use cpu_to_le64() and cpu_to_le32() to avoid
Sparse endianness warnings?

> +
> +	builder->framevecs[builder->cur_framevec++] =3D framevec;
> +
> +free_sg:
> +	sg_free_table(&sg_table);
> +free_framevec:
> +	// Only destroy the framevec if we didn't save it
> +	if (builder->cur_framevec =3D=3D initial_cur_framevec && framevec)
> +		vb2_destroy_framevec(framevec, false);
> +	return ret;
> +}

[Severity: High]
Does calling vb2_destroy_framevec() with two arguments break the build?

In include/media/videobuf2-memops.h, vb2_destroy_framevec() takes only a
single struct frame_vector * argument:

  void vb2_destroy_framevec(struct frame_vector *vec);

Because vb2_destroy_framevec() does not mark pages dirty,
scatterlist_builder_free_framevecs() also leaves device-modified user pages
clean when unpinning them unless it iterates over frame_vector_pages(vec)
and calls set_page_dirty_lock() before destroying the frame vector.

[ ... ]

> +int scatterlist_builder_add_ext_ctrls(struct scatterlist_builder *builde=
r,
> +				      struct v4l2_ext_controls *ctrls)
> +{
> +	int ret;
> +
> +	/* v4l2_ext_controls */
> +	ret =3D scatterlist_builder_add_data(builder, ctrls, sizeof(*ctrls));
> +	if (ret)
> +		return ret;
> +
> +	if (ctrls->count > 0) {
> +		/* array of v4l2_controls */
> +		ret =3D scatterlist_builder_add_data(builder, ctrls->controls,
> +						   sizeof(ctrls->controls[0]) *
> +							   ctrls->count);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

[Severity: High]
Does passing ctrls to scatterlist_builder_add_data() map kernel stack
memory directly for DMA?

video_usercopy() places struct v4l2_ext_controls in its stack buffer sbuf
(and v4l_g_ctrl() / v4l_s_ctrl() allocate both struct v4l2_ext_controls and
struct v4l2_ext_control on the stack).  When always_use_shadow_buffer is
false, scatterlist_builder_add_data() checks virt_addr_valid() or
is_vmalloc_addr() without checking !object_is_on_stack(data), mapping stack
pages directly into the request and device-writable response scatterlists
instead of copying through the shadow buffer.

[ ... ]

> +void
> +scatterlist_builder_free_framevecs(struct scatterlist_builder *builder)
> +{
> +	if (builder->cur_framevec && builder->framevecs) {
> +		struct frame_vector *vec;
> +
> +		while (builder->cur_framevec--) {
> +			vec =3D builder->framevecs[builder->cur_framevec];
> +			vb2_destroy_framevec(vec, true);
> +		}
> +
> +		kfree(builder->framevecs);
> +	}
> +
> +	builder->framevecs =3D NULL;
> +	builder->num_framevecs =3D 0;
> +	builder->cur_framevec =3D 0;
> +}

[Severity: High]
Does scatterlist_builder_free_framevecs() leak builder->framevecs when
builder->cur_framevec is 0?

scatterlist_builder_allocate_framevecs() allocates builder->framevecs
whenever any control has ctrl->size > 0.  If an error occurs before the
first framevec is pinned (for example, vb2_create_framevec() fails on the
first control's userptr), builder->cur_framevec is still 0, so
kfree(builder->framevecs) is skipped before builder->framevecs is set to
NULL.

> diff --git a/drivers/media/virtio/scatterlist_builder.h b/drivers/media/v=
irtio/scatterlist_builder.h
> index 044ea409acdb1..bced1e0301402 100644
> --- a/drivers/media/virtio/scatterlist_builder.h
> +++ b/drivers/media/virtio/scatterlist_builder.h
> @@ -25,6 +25,11 @@
>   * @sgs: descriptor chain to eventually pass to virtio functions.
>   * @num_sgs: total number of entries in @sgs.
>   * @cur_sg: next entry in @sgs to be used.
> + * @framevecs: Array of *struct frame_vector that is allocated to keep u=
ser
> + *             pages pinned until after a response is received. It is al=
located
> + *             in scatterlist_builder_add_ext_ctrls_userptrs() and freed=
 in
> + *             scatterlist_builder_retrieve_ext_ctrls().
> + * @cur_framevec: next entry in @framevecs to be used.

[Severity: Low]
This kernel-doc comment is missing an entry for @num_framevecs (which
triggers a W=3D1 kernel-doc warning), and @framevecs is allocated in
scatterlist_builder_allocate_framevecs() and freed in
scatterlist_builder_free_framevecs().

> diff --git a/drivers/media/virtio/virtio_media_ioctls.c b/drivers/media/v=
irtio/virtio_media_ioctls.c
> index e92032bce7dbe..d0ea743e793bd 100644
> --- a/drivers/media/virtio/virtio_media_ioctls.c
> +++ b/drivers/media/virtio/virtio_media_ioctls.c
> @@ -215,6 +221,130 @@ static int virtio_media_send_wr_ioctl(struct v4l2_f=
h *fh, u32 ioctl,
>  	return 0;
>  }
> =20
> +/**
> + * virtio_media_send_ext_controls_ioctl() - Send an ioctl taking extended
> + * controls as parameters to the device.
> + * @fh: file handler of the session doing the ioctl.
> + * @ioctl: ``VIDIOC_*`` ioctl code.
> + * @ctrls: &struct v4l2_ext_controls to be sent as the ioctl payload.
> + *
> + * Queues an ioctl that sends a &struct v4l2_ext_controls to the host and
> + * receives an updated version.
> + *
> + * &struct v4l2_ext_controls has a pointer to an array of
> + * &struct v4l2_ext_control, and also potentially pointers to user-space=
 memory
> + * that we need to map properly, hence the dedicated function.
> + */
> +static int virtio_media_send_ext_controls_ioctl(struct v4l2_fh *fh, u32 =
ioctl,
> +						struct v4l2_ext_controls *ctrls)
> +{
> +	struct video_device *video_dev =3D fh->vdev;
> +	struct virtio_media *vv =3D to_virtio_media(video_dev);
> +	struct virtio_media_session *session =3D fh_to_session(fh);
> +	size_t num_cmd_sgs;
> +	size_t end_ctrls_sg;
> +	struct v4l2_ext_control *controls_backup =3D ctrls->controls;
> +	const u32 num_ctrls =3D ctrls->count;
> +	struct scatterlist *sgs[64];
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
> +		.framevecs =3D NULL,
> +		.cur_framevec =3D 0,
> +	};
> +	size_t resp_len =3D 0;
> +	int i;
> +
> +	int ret =3D scatterlist_builder_allocate_framevecs(&builder, ctrls);
> +
> +	if (ret)
> +		return ret;
> +
> +	/* Command descriptor */
> +	ret =3D scatterlist_builder_add_ioctl_cmd(&builder, session, ioctl);
> +
> +	if (ret)
> +		goto free_framevecs;
> +
> +	/* v4l2_controls */
> +	ret =3D scatterlist_builder_add_ext_ctrls(&builder, ctrls);
> +	if (ret)
> +		goto free_framevecs;
> +
> +	end_ctrls_sg =3D builder.cur_sg;
> +
> +	ret =3D scatterlist_builder_add_ext_ctrls_userptrs(&builder, ctrls);
> +	if (ret)
> +		goto free_framevecs;
> +
> +	num_cmd_sgs =3D builder.cur_sg;
> +
> +	/* Response descriptor */
> +	ret =3D scatterlist_builder_add_ioctl_resp(&builder, session);
> +	if (ret)
> +		goto free_framevecs;
> +
> +	/* Response payload (same as input but without userptrs) */
> +	for (i =3D 1; i < end_ctrls_sg; i++) {
> +		ret =3D scatterlist_builder_add_descriptor(&builder, i);
> +		if (ret < 0)
> +			goto free_framevecs;
> +	}

[Severity: Medium]
Can passing the builder.sgs[] index i as desc_index to
scatterlist_builder_add_descriptor() point the response chain at the wrong
descriptors?

When a vmalloc-backed payload (such as a large ctrls->controls array
allocated via kvmalloc() in video_usercopy()) spans non-contiguous pages,
scatterlist_builder_add_data() advances builder->cur_desc for each page seg=
ment
while adding only one entry to builder->sgs[].  Because end_ctrls_sg is
taken from builder.cur_sg, indexing builder->descs[i] does not match
builder->sgs[i] once any earlier entry uses more than one descriptor.

> +
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
> +	if (ret < 0) {
> +		/*
> +		 * Even if we have received an error, we may need to read our
> +		 * payloadback.
> +		 */
> +		if (resp_len >=3D sizeof(struct virtio_media_resp_ioctl) +
> +		    sizeof(*ctrls)) {
> +			/*
> +			 * Deliberately ignore the error here as we want to
> +			 * return the previous one.
> +			 */
> +			scatterlist_builder_retrieve_ext_ctrls(&builder,
> +							       num_cmd_sgs + 1,
> +							       ctrls);
> +		}
> +
> +		goto free_framevecs;
> +	}
> +
> +	resp_len -=3D sizeof(struct virtio_media_resp_ioctl);
> +
> +	/* Make sure that the reply's length covers our v4l2_ext_controls */
> +	if (resp_len < sizeof(*ctrls))
> +		return -EINVAL;

[Severity: High]
Do the early returns on ctrls->count > num_ctrls and
resp_len < sizeof(*ctrls) leak builder.framevecs and leave userspace pages
permanently pinned?

Both paths return directly instead of jumping to free_framevecs.  In
addition, in __scatterlist_builder_add_userptr(), the bounds check
if (builder->cur_framevec >=3D builder->num_framevecs) sets ret =3D -ENOMEM
without returning, falling through to pin the pages and write past the end
of builder->framevecs.

> +
> +	ret =3D scatterlist_builder_retrieve_ext_ctrls(&builder, num_cmd_sgs + =
1,
> +						     ctrls);

[Severity: Medium]
Isn't ctrls->count validated before scatterlist_builder_retrieve_ext_ctrls()
copies the shadow buffer back into *ctrls, and left un-restored if the host
increases it?

When ctrls goes through the shadow buffer, ctrls->count still holds the
pre-command value during the check above and is only overwritten by the
device response here (and on the error path above).  Furthermore, if the
device sets ctrls->count > num_ctrls and it is not clamped back to
num_ctrls, V4L2 core post-processing (which runs even on error because
VIDIOC_G/S/TRY_EXT_CTRLS have INFO_FL_ALWAYS_COPY) will read past the end
of the num_ctrls-sized ctrls->controls buffer in
v4l2_compat_put_array_args() and v4l_print_ext_controls().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121025007.3445=
723-1-briandaniels@google.com?part=3D3
