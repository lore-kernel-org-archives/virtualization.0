Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CAA282F18
	for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790441129; cv=none; b=uGfCTaVuWD6w9Sm/YQ0xIXIlaPLxJsBTRFTFWuZvtBOUR0etg2DQD1q4gzLQBDSB1oaQtcx4UAhKQpxHhx7yod8S9E5qsktzK8vxbTvjqozsTW1DEieyfxIbHKx6XGL005JISqXbjLVfNStGMHSTMn8bbpjlBoYxhA9yiv4NinM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790441129; c=relaxed/simple;
	bh=znTIs4tveTIYhRUfknUllR3xi0OwTF+GDg84Z6ATVlg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AhTiHklznIpic/IOn6GNNAi4j95iS4OCndnOxEHNUyink0Izjya7L8kW3uF6LQgWwpdvy175yySLDLmPwDCxX8HOCkZej6mMUYXI04jd3dbdfweHW78KQR77waVG2W6LWIkJQSNTcQUkBre4aHBC9mXRbgkJLldZN9pz9cTUaSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b433+7lJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b433+7lJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A6B1F000FF;
	Sat, 26 Sep 2026 16:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790441128;
	bh=eBSqfbhjWjoAiDL2kXMoCacLfdApMR9UMjr3lvXXzXk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b433+7lJr/DukG+SPD97RxcKCQhmgRHpGxcps+ev5c25a57smgxooyWyIcOeaWNvC
	 NsYn7Y/OvABKNGzPBoYS8kn2PRUywuzQbhP9O/YbfPxoQXhTkSf898E38/Ixo+70af
	 D3qZavkfX6dutGGojVrwx6J57B3toUC8fYnACv/bZABfIxH/r9wJJ3RPXCrHTMJxAB
	 hzZt1Jgq+R2505P9oXxw+p2j9oEiP3w2XItw8s+DiRrSx/Yg4OXx238AHcGcijDRIr
	 sOVNVY0paoy6+Y6Q5/lrN75Lu/Mm8dy+rPLi6u07Nhs9K3DX3HwE07M6rUEqcMzg20
	 dc8j2CLoQoQHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] drm/qxl: pack dumb heads from their plane source
 rectangles
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dillon Amburgey" <dillona@gmail.com>
Cc: dri-devel@lists.freedesktop.org, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260926163123.39217-6-dillona@gmail.com>
References: <20260926163123.39217-1-dillona@gmail.com>
 <20260926163123.39217-6-dillona@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 16:45:27 +0000
Message-Id: <20260926164528.10A6B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/qxl: hardcoded horizontal monitors_config breaks vertical mult=
i-monitor layouts
--

commit 8c2ba11a8cac6cfc531b9cc6ef9a78703db0c342
Author: Dillon Amburgey <dillona@gmail.com>

drm/qxl: pack dumb heads from their plane source rectangles

This commit sizes packed heads from their plane source rectangles and
copies only those rectangles to their packed origins. It intercepts DirtyFB
clips with every matching plane source and applies horizontal and vertical
offsets to map modesets and dirty updates identically.

> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_=
display.c
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -369,8 +369,10 @@ static void qxl_crtc_update_monitors_config(struct d=
rm_crtc *crtc,
>  		head.y =3D crtc->y;
>  		if (qdev->monitors_config->count < i + 1)
>  			qdev->monitors_config->count =3D i + 1;
> -		if (to_qxl_plane_state(crtc->primary->state)->shadow)
> -			head.x +=3D to_qxl_plane_state(crtc->primary->state)->x;
> +		if (to_qxl_plane_state(crtc->primary->state)->shadow) {
> +			head.x =3D to_qxl_plane_state(crtc->primary->state)->x;
> +			head.y =3D 0;
> +		}

[Severity: High]
Does overwriting head.x with the shadow buffer's horizontal offset and
explicitly zeroing head.y here discard the guest's actual vertical layout
information?

If a user configures a multi-monitor layout in the guest that is not purely
side-by-side (like a vertical or custom arrangement), it appears
qxl_crtc_update_monitors_config() will override the layout data sent to the
SPICE client. Could this break the SPICE client's window placement and
destroy absolute mouse input mapping on secondary monitors, since the
client's coordinate space would no longer match the guest's?

[ ... ]

> @@ -847,9 +877,8 @@ static int qxl_prepare_shadow(struct drm_plane *plane,
>  		other =3D to_qxl_plane_state(ps);
>  		if (ps =3D=3D new_state)
>  			qps->x =3D surf.width;
> -		bo =3D gem_to_qxl_bo(ps->fb->obj[0]);
> -		surf.width +=3D bo->surf.width;
> -		surf.height =3D max_t(u32, surf.height, bo->surf.height);
> +		surf.width +=3D ps->src_w >> 16;
> +		surf.height =3D max_t(u32, surf.height, ps->src_h >> 16);

[Severity: High]
Does accumulating surf.width here in qxl_prepare_shadow() force all CRTCs
to be packed horizontally in the shadow buffer?

It seems this horizontal packing might be what necessitates overriding the
layout coordinates in qxl_crtc_update_monitors_config() above.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926163123.3921=
7-1-dillona@gmail.com?part=3D5
