Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795231048;
	b=KthZPlb4T87XQAT6g/FRE4OG37Hi95qDY03cgHgHMNJfdxoNWsMwDJX0HgAEr1tGZrn5
	 8CdUnnQARr9RevO7QSw6c3qg4bLjW9QZkbqw/7dAYuywH72pxl+dvwvVrcSKfAqQGe7XS
	 MpZV2jBpUATWGdWf20cVarjot3fhujikYbvlquyeum/UQjUVwvP6dU9YUTnj4TTpCp1+c
	 ye8OjtxohKB1Dxbu3oxAzJCaETDxOqsvUQ/FQ3YyqTMA18UHWpq1T/n0o5z6e2JYJpxVc
	 A65rqnoxIj3XWfHIZ2WvHNx07Wv2N9a+0HjX3pGTjMLcWr6xsqWTDHxh2dyw7kP9x9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795231048;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UYJpHd6vVDZmCSu0Usn/p9sgJ/Chu9b33LraASXtD5Q=;
	b=kHyKN39DyffDyrqqIwf/faWYhuEgHsmRdf/OOaZP2GWW+3Q5zkVbhCJJtOlLIBYE/WZY
	 HmFDV5rJLd6CYizA3LIK0cVxu7tyOR/cjMh6eGZPjnMVDUxTvwyxRhvo3NFllO7TPccKd
	 g6wjNpzT9I+9WfVLcfL7zvvDzo7MusIM3H7yZMQpZoM6tepLEJvv5YG407kLKwMxL7TD4
	 21vDDWcd8n8VzpG7hqiXVGgowrGv1tP4qz41XF2v5JuwCkulGxjzoLMJFZ9c2EJLPkm1d
	 WlqdQII3TN3EVOE6IT3Kw8gVY2awObkCoadUbvgaxTEyPJOrL3FM+XqHXeaswVeMWaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nvcXz+4U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6584606A6B4
	for <virtualization@lists.linux.dev>; Sat, 21 Nov 2026 03:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nvcXz+4U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB9D1F000C0;
	Sat, 21 Nov 2026 03:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795231048;
	bh=UYJpHd6vVDZmCSu0Usn/p9sgJ/Chu9b33LraASXtD5Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nvcXz+4UHZfEBb/1CclRy5Dpu2p8DCBA3n2U/8Lt6DdQC6rD9kzxrtZMTw9o7DEiD
	 Of2kL+hiTUnTpvlkc1DK1neCtF+WGAYWrZQuZtKC2ZCs44EDGdkIYZ9T1//cldkKCT
	 aVgYxuXWBNv7V9unXzKyvqHnC3DrawXB1AeEUczYQ96BlpOGur2SfLcwSvzc/7kyqO
	 aenOE3YcFk/rRtsMD1So+6VLV3zuStioXNNkHo21nQ2IRbriPU05GvhcEXw3GqLzBI
	 iUdoWGFbDWfNv+4eYVgh7sRsRrTVNsBT1MVY3JxmM6jfYF5l1gOKS6BSBu6RTz8Vly
	 xXmfDxunSKg8w==
Message-ID: <sashiko-outbox-226567@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 6/6] media: virtio: clear the size of legacy
 controls built on the stack
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brian Daniels" <briandaniels@google.com>
Cc: virtualization@lists.linux.dev, media-ci@linuxtv.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261121025007.3445723-7-briandaniels@google.com>
References: <20261121025007.3445723-1-briandaniels@google.com>
 <20261121025007.3445723-7-briandaniels@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 03:17:28 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] media: virtio: framevecs array leak in
  scatterlist_builder_free_framevecs()
- [Medium] media: virtio: incomplete stack control init in
  virtio_media_legacy_ctrl()
- [Medium] media: virtio: framevec and pinned page leaks in
  virtio_media_send_ext_controls_ioctl()
--

commit 623bf5e3612ed0e69ea0cdb41218ea9e8d7b62ef
Author: Nick Rogers <nick@getfieldwork.ai>

media: virtio: clear the size of legacy controls built on the stack

This commit adds a helper that checks if the extended control array is on
the kernel stack and zeroes each control's size field before forwarding
extended control ioctls to the VirtIO host.

> diff --git a/drivers/media/virtio/virtio_media_ioctls.c b/drivers/media/v=
irtio/virtio_media_ioctls.c
> index aa56efe9a08c2..ad240073aec9f 100644
> --- a/drivers/media/virtio/virtio_media_ioctls.c
> +++ b/drivers/media/virtio/virtio_media_ioctls.c
[ ... ]
> @@ -593,11 +594,31 @@ static int virtio_media_querycap(struct file *file,=
 void *fh,
>   * Extended control ioctls are handled mostly identically.
>   */
> =20
> +/*
> + * VIDIOC_G_CTRL and VIDIOC_S_CTRL reach a driver without a control hand=
ler
> + * as one extended control the V4L2 core builds on its own stack, with i=
ts
> + * size left uninitialized. They carry a 32-bit value and never a payloa=
d,
> + * so a size there is stack garbage, which would be sent as a user point=
er
> + * to copy and fail the ioctl. An array from userspace is never on the
> + * stack: the core copies it into an allocation.
> + */
> +static void virtio_media_legacy_ctrl(struct v4l2_ext_controls *ctrls)
> +{
> +	u32 i;
> +
> +	if (!ctrls->count || !object_is_on_stack(ctrls->controls))
> +		return;
> +	for (i =3D 0; i < ctrls->count; i++)
> +		ctrls->controls[i].size =3D 0;
> +}

[Severity: Medium]
Does clearing only ctrls->controls[i].size still leave uninitialized
kernel stack fields that get sent across the virtqueue to the host?

When v4l_g_ctrl() and v4l_s_ctrl() build struct v4l2_ext_controls and
struct v4l2_ext_control on the stack without zero-initializing them,
ctrls->error_idx, ctrls->request_fd, struct alignment padding, and the
upper 32 bits of the 8-byte value64 union in ctrl remain uninitialized.
scatterlist_builder_add_ext_ctrls() transmits the entire sizeof(*ctrls)
and sizeof(ctrls->controls[0]) * ctrls->count buffers to the host,
leaking guest kernel stack bytes and passing stack garbage in request_fd,
error_idx, and the upper 32 bits of value64.

Also, detecting legacy controls in the driver with object_is_on_stack()
(including in virtio_media_try_ext_ctrls(), which VIDIOC_G_CTRL and
VIDIOC_S_CTRL never call) works around v4l_g_ctrl() and v4l_s_ctrl() in
drivers/media/v4l2-core/v4l2-ioctl.c rather than zero-initializing the
stack structures there.

> +
>  static int virtio_media_g_ext_ctrls(struct file *file, void *fh,
>  				    struct v4l2_ext_controls *ctrls)
>  {
>  	struct v4l2_fh *vfh =3D file_to_v4l2_fh(file);
> =20
> +	virtio_media_legacy_ctrl(ctrls);
> +
>  	return virtio_media_send_ext_controls_ioctl(vfh, VIDIOC_G_EXT_CTRLS,
>  						    ctrls);
>  }

[Severity: Medium]
In virtio_media_send_ext_controls_ioctl() (introduced earlier in this
series in commit "media: virtio: Add extended controls support"), do the
two post-command validation checks leak builder.framevecs and leave user
pages permanently pinned?

drivers/media/virtio/virtio_media_ioctls.c:virtio_media_send_ext_controls_i=
octl() {
    ...
	if (ctrls->count > num_ctrls)
		return -ENOSPC;
	if (ret < 0) {
    ...
		goto free_framevecs;
	}

	resp_len -=3D sizeof(struct virtio_media_resp_ioctl);

	/* Make sure that the reply's length covers our v4l2_ext_controls */
	if (resp_len < sizeof(*ctrls))
		return -EINVAL;
    ...
free_framevecs:
	scatterlist_builder_free_framevecs(&builder);
	return ret;
}

When a request includes controls with ctrl->size > 0, returning -ENOSPC
or -EINVAL directly after virtio_media_send_command() skips
free_framevecs, leaking builder.framevecs and never calling
vb2_destroy_framevec() on the pinned user buffers.

> =20
>  static int virtio_media_s_ext_ctrls(struct file *file, void *fh,
>  				    struct v4l2_ext_controls *ctrls)
>  {
>  	struct v4l2_fh *vfh =3D file_to_v4l2_fh(file);
> =20
> +	virtio_media_legacy_ctrl(ctrls);
> +
>  	return virtio_media_send_ext_controls_ioctl(vfh, VIDIOC_S_EXT_CTRLS,
>  						    ctrls);
>  }

[Severity: High]
Also in the free_framevecs path of virtio_media_send_ext_controls_ioctl()
(from commit "media: virtio: Add extended controls support"), does
scatterlist_builder_free_framevecs() leak builder->framevecs when an
error occurs before the first framevec is created?

drivers/media/virtio/scatterlist_builder.c:scatterlist_builder_free_frameve=
cs() {
	if (builder->cur_framevec && builder->framevecs) {
		struct frame_vector *vec;

		while (builder->cur_framevec--) {
			vec =3D builder->framevecs[builder->cur_framevec];
			vb2_destroy_framevec(vec, true);
		}

		kfree(builder->framevecs);
	}

	builder->framevecs =3D NULL;
    ...
}

scatterlist_builder_allocate_framevecs() allocates builder->framevecs
whenever any control has ctrl->size > 0, while builder->cur_framevec is
still 0.  If an unprivileged user passes an invalid ctrl->ptr on the
first payload control, vb2_create_framevec() fails with cur_framevec =3D=3D=
 0
and scatterlist_builder_free_framevecs() skips kfree(builder->framevecs)
before clearing the pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121025007.3445=
723-1-briandaniels@google.com?part=3D6
