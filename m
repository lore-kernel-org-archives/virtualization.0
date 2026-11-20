Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213512;
	b=HoOnxtW17Cu4zNCwQBMu0wU2EXM3CCf/GtmxEMhFpdXdt4diZPNAFm1XHUJjx+zJ13L1
	 neasrN6x4z5pZadTTQtX6afypzcLapY6jIuy6vWjJObAOXEbH+Da8ejpekyf659HJ0P1K
	 jPSy4t1sqMyACqTzxF9v7kmP89XWLoRAvFqouO/D9VdwrNlWdb0l8A+1KwM6kXy9pfjZm
	 g0WKh6WhHE37XuhqcVR8OgOlv6pRT9yJG7m3+B9qJH63/naLdwbSurD+BgZhmNjbibPAO
	 wCGZK7nYuUc4YxgxjJRP2SdVSAioEXUpSi4775kybLJYc27r4bQiCFM2FHyv9M+UOIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213512;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kfAESY0EUwhLoFocPu1ITpN5rm/Rbc/WILA7vhRO2nU=;
	b=sNPcqTjCVrFdk/VU4FarVGLwhk6hIUQVWYehaDQMw6sIo9gGkgmoIWTca+bYeqwM+BCX
	 A9Blt2RBOBmyE4LBsu1IpDctOoQh2aLW+NdHvwdPVW1gChY6+aK8Jh8CqWl/4ztn3vAso
	 +uHeyrBSzgB9ArAdOR1mMrRbehOMBnt0kDr5uBOZSkieu+Oett1fJ7dwKKfxmrpeXOTRy
	 CI7BZbhw2+xMYegpr/axRjtACVfmexswdt7CFmNzouz9EtREnyiwFCfbgTLajHO8iUC0F
	 daikviReU10QNTAANDsZlj3qDBWajihBM5ByAyUEEZqdN8TTZH+nU81R2mo36M633xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GEP/bgV+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40CB606A69A
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 22:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GEP/bgV+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D341F000C0;
	Fri, 20 Nov 2026 22:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795213511;
	bh=kfAESY0EUwhLoFocPu1ITpN5rm/Rbc/WILA7vhRO2nU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GEP/bgV+HkMdwuqxZwAtKN2GPuIB09TCxGIFo7cfcJXpja9nI8PZRRmIA4ZrFTmM1
	 z6l2nh+6EoLbnC+FUZ/BlMyKQKASM5q3cZXNGMrDlzlCOBWM/Xxj0b95N9BRLzVtgB
	 cmeXwIUy8XSkVYUCVBJwYkvkncciLTMlm85SP7m4DVFCzwl4EjayryqPmbwOB2PEm5
	 l/PINrsoOekru9fYlMwLyxrQkDre3fg0kQcsDn3DboWloMuFlXpLJg3pADvp02ETZO
	 JcCaTxcT9fBrI+CPQ8RBh+roip1fx/MgGRMA2pSpSEd9bo/s8i1Y0z3SdRgNUNE+6z
	 OGphZBFlCcrzA==
Message-ID: <sashiko-outbox-226259@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 6/6] media: virtio: clear the size of legacy
 controls built on the stack
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brian Daniels" <briandaniels@google.com>
Cc: virtualization@lists.linux.dev, media-ci@linuxtv.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261120215916.3149345-7-briandaniels@google.com>
References: <20261120215916.3149345-1-briandaniels@google.com>
 <20261120215916.3149345-7-briandaniels@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 22:25:08 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] media: virtio: incomplete stack initialization in
  virtio_media_legacy_ctrl()
--

commit d098c9e95ded482f86a03623164a3f51eaba79ca
Author: Nick Rogers <nick@getfieldwork.ai>

media: virtio: clear the size of legacy controls built on the stack

This commit adds virtio_media_legacy_ctrl() to zero out the size field of
stack-allocated v4l2_ext_control entries before forwarding extended control
ioctls to the virtio host.

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
> @@ -607,6 +628,8 @@ static int virtio_media_s_ext_ctrls(struct file *file=
, void *fh,
>  {
>  	struct v4l2_fh *vfh =3D file_to_v4l2_fh(file);
> =20
> +	virtio_media_legacy_ctrl(ctrls);
> +
>  	return virtio_media_send_ext_controls_ioctl(vfh, VIDIOC_S_EXT_CTRLS,
>  						    ctrls);
>  }
> @@ -616,6 +639,8 @@ static int virtio_media_try_ext_ctrls(struct file *fi=
le, void *fh,
>  {
>  	struct v4l2_fh *vfh =3D file_to_v4l2_fh(file);
> =20
> +	virtio_media_legacy_ctrl(ctrls);
> +
>  	return virtio_media_send_ext_controls_ioctl(vfh, VIDIOC_TRY_EXT_CTRLS,
>  						    ctrls);
>  }

[Severity: Medium]
Does clearing only controls[i].size in virtio_media_legacy_ctrl() still lea=
ve
other fields of ctrls and ctrls->controls[i] uninitialized on the stack?

In v4l_g_ctrl() and v4l_s_ctrl(), both struct v4l2_ext_controls ctrls and
struct v4l2_ext_control ctrl are declared on the stack without
zero-initialization, and only ctrls.which, ctrls.count, ctrls.controls,
ctrl.id, and the 32-bit ctrl.value member are assigned (with check_ext_ctrl=
s()
clearing ctrls.reserved[0] and ctrl.reserved2[0]).  That leaves
ctrls->error_idx, ctrls->request_fd, struct padding, and the upper 32 bits =
of
the 64-bit union in ctrl.value64 holding stack garbage when
scatterlist_builder_add_ext_ctrls() sends both full structures to the host.
In addition to leaking 16 bytes of guest kernel stack to the host on every
VIDIOC_G_CTRL and VIDIOC_S_CTRL call, a VIDIOC_S_CTRL targeting a 64-bit ho=
st
control will pass stack garbage in the upper 32 bits of ctrl.value64.

Also, VIDIOC_G_CTRL and VIDIOC_S_CTRL never call vidioc_try_ext_ctrls, so
virtio_media_try_ext_ctrls() has no legacy stack-allocated caller.  Rather
than detecting stack pointers with object_is_on_stack() in the driver, could
v4l_g_ctrl() and v4l_s_ctrl() in drivers/media/v4l2-core/v4l2-ioctl.c
zero-initialize ctrls and ctrl directly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120215916.3149=
345-1-briandaniels@google.com?part=3D6
