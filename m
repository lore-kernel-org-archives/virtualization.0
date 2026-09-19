Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177BF1FC0
	for <virtualization@lists.linux.dev>; Sat, 19 Sep 2026 22:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789855486; cv=none; b=nkjabpDiOBgvLSNo7CbNUSNHaZ5CwgHdiSYcsHb0DN5io4kPrPWxO5rVRjA00Td8w3X+4XQCxHasjkj6K06b6kfDc3wUFXPZY1fE33Bvm33+Qcl67mdyc7HonfChKpqigxAXJ0dvmimCYELFihLyTs2QYilpMm799c82c1DxCUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789855486; c=relaxed/simple;
	bh=WB9uPzdvfgHzORD1E1kvKtwc1AvscY7nX9iLfY2znwY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XRHLLnCthwa+ONlfzWOZv95Q8R2I+caHeoww+sRVPt6YfFvYfVEubFUd9GSRU6xUU9TmitwJIrg6J4CQOoDgSdakiT75obK+bFiaPQlzGcAhyMphISOYuQMqPVgTvj080O5vHaHPkiH+g7mfH5fkLEn4Iu1/CViDTUA+RFkVWnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0ZZlz6d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0ZZlz6d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7712B1F000FF;
	Sat, 19 Sep 2026 22:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789855484;
	bh=i0Ci9e6/zH1hprYr8tXdNt/Xr9WaX+YFs4mjCv5TbVk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c0ZZlz6dAPfocwwUc+xFHCF7zctqla/4IX7LIbTTK8sXLcaAX+j3MHLw68atmokm1
	 fz6j0zGY4jmVVinr0uHGs+XSjXnFBLP5x2//C0ptHVF5KXZ9AWkcTLCI4wF2rD7nUu
	 QL+XLlPGoHVEVw+MDpB3/UyRtZNcht1hDUn3oH7PG4l7ifLVRttEdSISo566KH2kBA
	 lj4k5cMp1/k0Gul6vP05qzPYbVHg8QtSwVV+oWV+MHgxjQKIyULFs8L7Gp921AAtsm
	 DRrnjk4Ld9RgSFCnrtmnAbgc8+KJpjZ4ZgU0C1wDSqLaCefdFPwGGPw+eYH1t2jApY
	 GGO76uEz7STOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/qxl: fix cursor OOB read, dirty-rect bounds, and
 monitors double-fetch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Peng" <benquike@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260919215230.3469792-1-benquike@gmail.com>
References: <20260919215230.3469792-1-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 22:04:44 +0000
Message-Id: <20260919220444.7712B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/qxl: missing offset in clipping rectangles breaks rendering
- [Low] drm/qxl: dead code in dumb_shadow_offset bounds check
--

commit dbbac4275ce84b9a554a655eca70f851083fc445
Author: Hui Peng <benquike@gmail.com>
drm/qxl: fix cursor OOB read, dirty-rect bounds, and monitors double-fetch

This commit fixes out-of-bounds accesses and missing bounds checks in the
QXL display and dirty-framebuffer drawing paths.

> diff --git a/drivers/gpu/drm/qxl/qxl_draw.c b/drivers/gpu/drm/qxl/qxl_dra=
w.c
> --- a/drivers/gpu/drm/qxl/qxl_draw.c
> +++ b/drivers/gpu/drm/qxl/qxl_draw.c
> @@ -154,27 +154,40 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
>  	struct qxl_drm_image *dimage;
>  	int ret;
> =20
> -	ret =3D alloc_drawable(qdev, &release);
> -	if (ret)
> -		return;
> -
> -	clips->x1 +=3D dumb_shadow_offset;
> -	clips->x2 +=3D dumb_shadow_offset;
> -
> -	left =3D clips->x1;
> -	right =3D clips->x2;
> +	left =3D clips->x1 + dumb_shadow_offset;
> +	right =3D clips->x2 + dumb_shadow_offset;

[Severity: High]
Will this change break rendering on secondary monitors by omitting the offs=
et
from the hardware clipping rectangles?

The original code modified clips->x1 and clips->x2 in place, which meant
dumb_shadow_offset was automatically included when setting up the rects arr=
ay
later in the function.

Now that clips is not mutated, rects gets the original un-offset coordinate=
s:

drivers/gpu/drm/qxl/qxl_draw.c:qxl_draw_dirty_fb() {
        ...
        clips_ptr =3D clips;
        for (i =3D 0; i < num_clips; i++, clips_ptr +=3D inc) {
                rects[i].left   =3D clips_ptr->x1;
                rects[i].right  =3D clips_ptr->x2;
        ...
}

The hardware expects clip rectangles to match the shadow surface coordinates
of the drawable. Because skipping this offset clips out the valid rendering
area entirely, should dumb_shadow_offset be explicitly added to rects[i].le=
ft
and rects[i].right?

>  	top =3D clips->y1;
>  	bottom =3D clips->y2;
> =20
>  	/* skip the first clip rect */
>  	for (i =3D 1, clips_ptr =3D clips + inc;
>  	     i < num_clips; i++, clips_ptr +=3D inc) {
> -		left =3D min_t(int, left, (int)clips_ptr->x1);
> -		right =3D max_t(int, right, (int)clips_ptr->x2);
> +		left =3D min_t(int, left, (int)clips_ptr->x1 + dumb_shadow_offset);
> +		right =3D max_t(int, right, (int)clips_ptr->x2 + dumb_shadow_offset);
>  		top =3D min_t(int, top, (int)clips_ptr->y1);
>  		bottom =3D max_t(int, bottom, (int)clips_ptr->y2);
>  	}
> =20
> +	if (dumb_shadow_offset < 0 || dumb_shadow_offset > INT_MAX - fb->width)
> +		return;

[Severity: Low]
Is this bounds check operating as intended?

Because dumb_shadow_offset is a uint32_t, the < 0 check is unconditionally
false.

Additionally, fb->width is unsigned, so does INT_MAX - fb->width result
in an implicit unsigned calculation? While this may functionally protect
against overflow due to core DRM limits on fb->width, it leaves the validat=
ion
logic brittle.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919215230.3469=
792-1-benquike@gmail.com?part=3D1
