Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793291880;
	b=RF5d7MVFCeccxh8A2QlGYdXheNLEw3C5/6G5uKMbiSDBxMd6EDNBEjKzfm6umgMxXEDR
	 vTe3cMFMUqr4m5TjY80hf2FHCx6C+90UXkeLKWggvNBvop9R6QIi6/JzoB1+W7GqkW8mq
	 eeYM8g5JVDP0koWBDieE973/bkS37Js1eUiMzEdmtChARjTW//3eueT8sIflGSsW2O2zR
	 WJnGTo3Qh2vsQWnWZaoyb++Ix5Y9taDQN7S0iPu5sYm4yn7oMVmNsZM7nz/hJJbA5NDXC
	 77ogl/DjGJ/MMq/O8fkgmqNCqNpaiFN2zqEWjrDXYGqxqOAqmf2uUetzECZwekL1DwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291880;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2DDEdQH/QTqv5e3oFB/pJTqX4NnbROdAIi4Uwebm4XM=;
	b=rLEwnW7eQbXbeefBkM6WI5Wt19dvkn/big+lR0Z6eov+G3Cglql7Kr9Pjyc6eYMipFfB
	 ykY11hNBAFCe1v2+oYDJDlYquHrVDQ1ybhp3NBi/OLmdM8qsEaGanpQOlrzVdQ4UTwymi
	 Z7/U0FpMIlfc2kXW7OeWQMfsY38P10U22xNpq34eClYDUAjWY86nHv9JtEuLHSYJf8tm7
	 BXQgz8Sh/cED4ELrQl6MTgi1/3lLYOeyTLQMbVyh9MIMVW2eE+HC104cY1cmkR86BBnBN
	 QrpQtUKb2DtdcaPCKfyAn7oTYREeL3kEvuvJH+SZUeEm7mhzB0dcXzFSpoAXURdwByg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXV2mfzM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D692E606A32D
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXV2mfzM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CC81F01829;
	Thu, 29 Oct 2026 16:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793291879;
	bh=2DDEdQH/QTqv5e3oFB/pJTqX4NnbROdAIi4Uwebm4XM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WXV2mfzMINmQX/nalSEngV08Aluaomf3e62xWimlB814ayx1osU1BcJzv9uXLN0p1
	 DZPhAo18zR3can1yFhpgmSaF95qHlMmXIFIFcfu9RkGA/KroU1buW1EYSIeRbDZ9CD
	 oclH9+7EEYRxzCcOWWZEezJczWVj5z4j+OIrmMOFlF1xXXFHcCZuuLJhLfMMZYzppk
	 Itr0LCtQljdtaSD/mbO4LZb6hQ+jdLGoEe0Ug8LRr1k6Y8n092fzKDYGaCSs2OAq/x
	 jxdIkaUPG4nvV8rJy38Btcoar4pQ+2IAUyUyLI4f6YsGJqu9MSRYZlPwqJOPtZPkTQ
	 Ea9EDEcUC0BnA==
Message-ID: <sashiko-outbox-189667@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/5] media: virtio: Add extended controls support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brian Daniels" <briandaniels@google.com>
Cc: virtualization@lists.linux.dev, media-ci@linuxtv.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261029153038.3800747-4-briandaniels@google.com>
References: <20261029153038.3800747-1-briandaniels@google.com>
 <20261029153038.3800747-4-briandaniels@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 16:37:58 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] media: virtio: premature page unpinning in __scatterlist_build=
er_add_userptr()
- [High] media: virtio: framevec and page pin leak on ext_ctrls ioctl error=
 paths
- [High] media: virtio: unvalidated ctrls->count after shadow buffer retrie=
val
- [High] media: virtio: sg vs desc index mismatch in ext_controls response =
chain
- [High] media: virtio: uninitialized stack ctrl.size used on VIDIOC_G/S_CT=
RL path
- [Medium] media: virtio: invalid gfp_mask 0 in __scatterlist_builder_add_u=
serptr()
- [Medium] media: virtio: __scatterlist_builder_add_userptr() turns -EFAULT=
 into -EINVAL
- [Medium] media: virtio: missing set_page_dirty_lock() before vb2_destroy_=
framevec()
--

commit d6379be31216df27a0facbc6a952d125cbfef732
Author: Alexandre Courbot <gnurou@gmail.com>

media: virtio: Add extended controls support

This commit adds support for VIDIOC_G_EXT_CTRLS, VIDIOC_S_EXT_CTRLS, and
VIDIOC_TRY_EXT_CTRLS to the virtio-media driver. It pins userspace control
payloads using vb2_create_framevec() and passes their physical memory segme=
nts
to the host as an array of struct virtio_media_sg_entry descriptors in the
session shadow buffer.

> diff --git a/drivers/media/virtio/scatterlist_builder.c b/drivers/media/v=
irtio/scatterlist_builder.c
> index ae8ffee82fa6e..3615f45e15cfb 100644
> --- a/drivers/media/virtio/scatterlist_builder.c
> +++ b/drivers/media/virtio/scatterlist_builder.c
> @@ -220,3 +220,247 @@ int scatterlist_builder_add_ioctl_resp(struct scatt=
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
> +	int i;
> +	int ret;
> +
> +	if (builder->framevec) {
> +		pr_warn("previous framevec found!");
> +		vb2_destroy_framevec(builder->framevec);
> +		builder->framevec =3D NULL;
> +	}

[Severity: Critical]
When an extended controls ioctl contains two or more controls with
ctrl->size > 0, doesn't this unpin the earlier control's user pages before =
the
virtio command is even sent to the host?

In struct scatterlist_builder, there is only a single framevec pointer, whi=
le
scatterlist_builder_add_ext_ctrls_userptrs() loops over all ctrls->count
entries and calls scatterlist_builder_add_userptr() ->
__scatterlist_builder_add_userptr() for each control with ctrl->size > 0:

virtio_media_send_ext_controls_ioctl()
  scatterlist_builder_add_ext_ctrls_userptrs()
    for (i =3D 0; i < ctrls->count; i++)
      scatterlist_builder_add_userptr()
        __scatterlist_builder_add_userptr()

When the second control with ctrl->size > 0 is processed, builder->framevec=
 is
already set from the first control. Calling vb2_destroy_framevec() here unp=
ins
the first control's pages while their physical addresses in builder->sgs are
still queued and subsequently passed to virtio_media_send_command(), allowi=
ng
the host device to DMA to or from unpinned physical pages that may be freed=
 and
reallocated.

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
Should __scatterlist_builder_add_userptr() preserve -EFAULT here instead of
converting it to -EINVAL?

The kernel-doc comment above states that __scatterlist_builder_add_userptr()
returns -EFAULT if userptr is not a valid user address, and V4L2 extended
control ioctls (VIDIOC_G_EXT_CTRLS, VIDIOC_S_EXT_CTRLS, VIDIOC_TRY_EXT_CTRL=
S)
are expected to return -EFAULT when a control's user payload pointer is
invalid.

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
rather than 0?

__scatterlist_builder_add_userptr() runs in sleepable ioctl process context
right after vb2_create_framevec() (which allocates with GFP_KERNEL). Passin=
g 0
clears __GFP_DIRECT_RECLAIM, __GFP_KSWAPD_RECLAIM, __GFP_IO, and __GFP_FS,
preventing memory reclaim under pressure and skipping SLUB kmemleak
registration.

[ ... ]

> +static int scatterlist_builder_add_userptr(struct scatterlist_builder *b=
uilder,
> +					   unsigned long userptr,
> +					   unsigned long length)
> +{
> +	int ret;
> +	int nents;
> +	struct virtio_media_sg_entry *sg_list;
> +
> +	ret =3D __scatterlist_builder_add_userptr(builder, userptr, length,
> +						&sg_list, &nents);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D scatterlist_builder_add_data(builder, sg_list,
> +					   sizeof(*sg_list) * nents);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

[ ... ]

> +int scatterlist_builder_retrieve_ext_ctrls(struct scatterlist_builder *b=
uilder,
> +					   size_t sg_index,
> +					   struct v4l2_ext_controls *ctrls)
> +{
> +	struct v4l2_ext_control *controls_backup =3D ctrls->controls;
> +	int ret;
> +
> +	ret =3D scatterlist_builder_retrieve_data(builder, sg_index++, ctrls);
> +
> +	if (ret)
> +		goto cleanup;
> +
> +	ctrls->controls =3D controls_backup;
> +
> +	if (ctrls->count > 0 && ctrls->controls) {
> +		ret =3D scatterlist_builder_retrieve_data(builder, sg_index++,
> +							ctrls->controls);
> +		if (ret)
> +			goto cleanup;
> +	}
> +
> +cleanup:
> +	// Clean up the framevec created in __scatterlist_builder_add_userptr()
> +	if (builder->framevec) {
> +		vb2_destroy_framevec(builder->framevec);
> +		builder->framevec =3D NULL;
> +	}
> +
> +	return ret;
> +}

[Severity: Medium]
Should the pages in builder->framevec be marked dirty with
set_page_dirty_lock() before calling vb2_destroy_framevec()?

__scatterlist_builder_add_userptr() pins the user pages with write =3D true=
 via
vb2_create_framevec(userptr, length, true) and passes their physical addres=
ses
to the host device. Because host writes to those physical addresses bypass =
the
guest CPU MMU, the guest PTE dirty bits are not updated, so unpinning the p=
ages
without calling set_page_dirty_lock() (as done in vb2_dma_sg_put_userptr() =
and
vb2_vmalloc_put_userptr()) can allow modified pages to be treated as clean =
and
discarded under memory pressure.

> diff --git a/drivers/media/virtio/virtio_media_ioctls.c b/drivers/media/v=
irtio/virtio_media_ioctls.c
> index 656ecea8a44cc..51f46b334800c 100644
> --- a/drivers/media/virtio/virtio_media_ioctls.c
> +++ b/drivers/media/virtio/virtio_media_ioctls.c

[ ... ]

> @@ -215,6 +218,124 @@ static int virtio_media_send_wr_ioctl(struct v4l2_f=
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
> +		.framevec =3D NULL,
> +	};
> +	size_t resp_len =3D 0;
> +	int i;
> +
> +	/* Command descriptor */
> +	int ret =3D scatterlist_builder_add_ioctl_cmd(&builder, session, ioctl);
> +
> +	if (ret)
> +		return ret;
> +
> +	/* v4l2_controls */
> +	ret =3D scatterlist_builder_add_ext_ctrls(&builder, ctrls);
> +	if (ret)
> +		return ret;
> +
> +	end_ctrls_sg =3D builder.cur_sg;
> +
> +	ret =3D scatterlist_builder_add_ext_ctrls_userptrs(&builder, ctrls);
> +	if (ret)
> +		return ret;
> +
> +	num_cmd_sgs =3D builder.cur_sg;
> +
> +	/* Response descriptor */
> +	ret =3D scatterlist_builder_add_ioctl_resp(&builder, session);
> +	if (ret)
> +		return ret;
> +
> +	/* Response payload (same as input but without userptrs) */
> +	for (i =3D 1; i < end_ctrls_sg; i++) {
> +		ret =3D scatterlist_builder_add_descriptor(&builder, i);
> +		if (ret < 0)
> +			return ret;
> +	}

[Severity: High]
Isn't passing i (which ranges up to end_ctrls_sg =3D builder.cur_sg) to
scatterlist_builder_add_descriptor() indexing builder.descs[] using a
builder.sgs[] index?

In scatterlist_builder_add_descriptor():

	builder->sgs[builder->cur_sg++] =3D &builder->descs[desc_index];

When ctrls or ctrls->controls is a vmalloc address (for instance, video_use=
rcopy()
places ctrls in stack buffer sbuf when CONFIG_VMAP_STACK=3Dy) and crosses a
non-contiguous page boundary, scatterlist_builder_add_data() advances
builder->cur_desc for each non-contiguous page while only adding one entry =
to
builder->sgs[]. If ctrls spans descs[1] and descs[2] (with sgs[1] =3D &desc=
s[1])
and ctrls->controls is at descs[3] (with sgs[2] =3D &descs[3] and
end_ctrls_sg =3D 3), this loop adds &descs[1] and &descs[2] to the response=
 sgs,
mapping the second page of ctrls twice and omitting ctrls->controls from the
writable response chain.

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
> +		return ret;
> +	}
> +
> +	resp_len -=3D sizeof(struct virtio_media_resp_ioctl);
> +
> +	/* Make sure that the reply's length covers our v4l2_ext_controls */
> +	if (resp_len < sizeof(*ctrls))
> +		return -EINVAL;
> +
> +	ret =3D scatterlist_builder_retrieve_ext_ctrls(&builder, num_cmd_sgs + =
1,
> +						     ctrls);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

[Severity: High]
Does virtio_media_send_ext_controls_ioctl() leak builder.framevec and its
FOLL_LONGTERM | FOLL_WRITE page pins when an error occurs before
scatterlist_builder_retrieve_ext_ctrls() is reached?

__scatterlist_builder_add_userptr() saves the pinned frame_vector in
builder->framevec, and it is only freed in the cleanup label of
scatterlist_builder_retrieve_ext_ctrls(). If scatterlist_builder_add_data()
fails in scatterlist_builder_add_userptr(), if
scatterlist_builder_add_ioctl_resp() or scatterlist_builder_add_descriptor()
fails, if ctrls->count > num_ctrls, if virtio_media_send_command() fails wi=
th
resp_len < sizeof(struct virtio_media_resp_ioctl) + sizeof(*ctrls), or if
resp_len < sizeof(*ctrls), the function returns without calling
vb2_destroy_framevec(builder.framevec), leaving the user pages permanently
pinned.

[Severity: High]
Also, shouldn't the ctrls->count validation happen after
scatterlist_builder_retrieve_ext_ctrls(), and restore ctrls->count =3D num_=
ctrls
when ctrls->count > num_ctrls?

First, when ctrls is staged in builder.shadow_buffer (such as when
always_use_shadow_buffer is set), ctrls->count still holds the original
num_ctrls value before scatterlist_builder_retrieve_ext_ctrls() copies the
shadow buffer back into *ctrls. Inside scatterlist_builder_retrieve_ext_ctr=
ls(),
scatterlist_builder_retrieve_data() overwrites ctrls->count from the shadow
buffer and immediately tests:

	if (ctrls->count > 0 && ctrls->controls) {
		ret =3D scatterlist_builder_retrieve_data(builder, sg_index++,
							ctrls->controls);

If num_ctrls was 0 on entry, check_array_args() in v4l2-ioctl.c left
ctrls->controls (and controls_backup) as the raw untrusted userspace pointer
and no descriptor was added for ctrls->controls, so a non-zero ctrls->count=
 in
the shadow buffer causes scatterlist_builder_retrieve_data() to read the wr=
ong
sg_index or copy directly to an unvalidated userspace pointer.

Second, because VIDIOC_G_EXT_CTRLS, VIDIOC_S_EXT_CTRLS, and
VIDIOC_TRY_EXT_CTRLS have INFO_FL_ALWAYS_COPY set in v4l2_ioctls[], leaving
ctrls->count > num_ctrls on return causes v4l2_compat_put_array_args() in
v4l2-compat-ioctl32.c to loop ecs64->count times over a kernel buffer
allocated for only num_ctrls elements, reading past the end of the buffer a=
nd
copying out-of-bounds heap memory to userspace.

[ ... ]

> @@ -472,6 +624,9 @@ const struct v4l2_ioctl_ops virtio_media_ioctl_ops =
=3D {
> =20
>  	/* Control handling */
>  	.vidioc_query_ext_ctrl =3D virtio_media_query_ext_ctrl,
> +	.vidioc_g_ext_ctrls =3D virtio_media_g_ext_ctrls,
> +	.vidioc_s_ext_ctrls =3D virtio_media_s_ext_ctrls,
> +	.vidioc_try_ext_ctrls =3D virtio_media_try_ext_ctrls,
>  	.vidioc_querymenu =3D virtio_media_querymenu,
> =20
>  	/* Audio ioctls */

[Severity: High]
When userspace invokes VIDIOC_G_CTRL or VIDIOC_S_CTRL, doesn't
scatterlist_builder_add_ext_ctrls_userptrs() read an uninitialized ctrl->si=
ze
from the stack?

Registering .vidioc_g_ext_ctrls and .vidioc_s_ext_ctrls in
virtio_media_ioctl_ops without a v4l2_ctrl_handler or .vidioc_g_ctrl /
.vidioc_s_ctrl callbacks enables the fallback paths in v4l_g_ctrl() and
v4l_s_ctrl() in drivers/media/v4l2-core/v4l2-ioctl.c:

v4l_g_ctrl() / v4l_s_ctrl()
  struct v4l2_ext_controls ctrls;
  struct v4l2_ext_control ctrl;
  ...
  ctrls.which =3D V4L2_CTRL_ID2WHICH(p->id);
  ctrls.count =3D 1;
  ctrls.controls =3D &ctrl;
  ctrl.id =3D p->id;
  ctrl.value =3D p->value;
  ops->vidioc_g_ext_ctrls(file, NULL, &ctrls);

Neither v4l_g_ctrl() nor v4l_s_ctrl() initializes ctrl.size (or ctrls.error=
_idx,
ctrls.request_fd, and the upper 32 bits of the union containing ctrl.ptr).
When virtio_media_send_ext_controls_ioctl() calls
scatterlist_builder_add_ext_ctrls_userptrs(), it checks if (ctrl->size > 0)=
 on
uninitialized stack memory, causing it to treat ctrl->ptr (containing p->va=
lue
and stack garbage) as a user pointer and pass uninitialized stack fields to
vb2_create_framevec() and the host device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029153038.3800=
747-1-briandaniels@google.com?part=3D3
