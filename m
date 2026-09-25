Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B7E2DBF75
	for <virtualization@lists.linux.dev>; Fri, 25 Sep 2026 03:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790307730; cv=none; b=j/sr7sepzNMcGQ2wiKvkPPbjiBqTzy+qT72ynQmNDwQ5KQVVPhudWBdKifHhDGDxTLOnFnFNyYzkFbo6PptbbhuI+cmqYSp3FAspc/2Wsrkcl+wn5ZPf02LzJhmFXZFc/RVZ1Hb8gWX4ISdp+GX2L0ODeQfVtvnHpni2F4IHvhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790307730; c=relaxed/simple;
	bh=PpDgS6RXJCkh5304lwl0oSysWnvh3jVT+9oimePtrYo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I/bdOQWGndi21CJxcgnDYHaPEyh2kS4Pw3/wNXrpOanQ9h6D7l3OVP+oO5gWpklzWlRw2EK1Y0kUqvTeNrPlGA0Ywlph3h4eYMlnFX/Ul6ip+WbWVFNcFHftDm0AKCBWWptY8cjF3SyOi41wyrR5xaw5h7x24tQ1xIdyKoLm4AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUfmuqDA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUfmuqDA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9F61F000FF;
	Fri, 25 Sep 2026 03:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790307728;
	bh=hj6ivoMqNPyhHNi8qPEvm0e8qAiGdrg6j7UN2KF8pOY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JUfmuqDAwCJojtz88X1x9UA63zw0QBmf6AeowNALW+fU8xS7ialPXcIo/STvn60TN
	 p1tpk0sz0zVVy/oIqbkfXLaEqNFupeP3zd8DYHCWyT52FoqGPk+01o8rpEG5hv5pgC
	 oBH1BinU5mybH6Nv4E52WHI31SIY68X8A0sf02ObLaH69s5eywStIwAcXrhR4mw/V8
	 J8zH6TRtAZPVesXxaqnixrHj5KDmtvoIqGo5jjK5A2tFTXQDkOoYE3s2pynshOhC/b
	 EpFfJ51bc2tGrIiDkx7N4q+ib5Ij0fiv008i5FcRqN6kuvLeKFTrZoLlc3LC5XP9Em
	 2B14tgzfC0IuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/qxl: size packed dumb heads from the plane
 source
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dillon Amburgey" <dillona@gmail.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260925033011.12560-1-dillona@gmail.com>
References: <20260924025222.6077-1-dillona@gmail.com>
 <20260925033011.12560-1-dillona@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 03:42:08 +0000
Message-Id: <20260925034208.6B9F61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/qxl: UAF in qxl_redraw_other_dumb_heads via lockless state acc=
ess
- [Medium] drm/qxl: Data race on dumb_shadow_needs_redraw causes missed red=
raws
--

commit a0e42e8da93f570c9694adff24e9eb7f3e68dcda
Author: Dillon Amburgey <dillona@gmail.com>

drm/qxl: size packed dumb heads from the plane source

This commit updates QXL to size and position dumb shadow buffers based on
plane source rectangles instead of dumb BO allocations. It introduces a new
flag to track redraw requirements and a function to recopy active heads dur=
ing
shadow reallocation.

> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_=
display.c
> index 0719fc6a52d53..d01504332bc83 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
[ ... ]
> @@ -662,6 +703,37 @@ static void qxl_free_cursor(struct qxl_bo *cursor_bo)
>  	qxl_bo_unref(&cursor_bo);
>  }
> =20
> +static void qxl_redraw_other_dumb_heads(struct qxl_device *qdev, int ski=
p)
> +{
> +	struct drm_crtc *crtc;
> +
> +	drm_for_each_crtc(crtc, &qdev->ddev) {
> +		struct drm_plane_state *st;
> +		struct qxl_bo *other;
> +		struct drm_clip_rect clip;
> +		u32 sx, sy;
> +
> +		if (crtc->index =3D=3D skip ||
> +		    !qdev->dumb_heads[crtc->index].width)
> +			continue;
> +		st =3D crtc->primary->state;
> +		if (!st->fb)
> +			continue;
> +		other =3D gem_to_qxl_bo(st->fb->obj[0]);

[Severity: High]
Does this lockless state access risk a use-after-free?

When an atomic commit updates a dumb shadow buffer,
qxl_primary_atomic_update() calls this function to loop over all CRTCs. If a
concurrent atomic commit processes one of these other CRTCs, it could swap =
and
free the old plane state and its framebuffer while they are being accessed
here, because the iterating commit holds no modeset locks for these disjoint
CRTCs.

> +		if (!other->is_dumb)
> +			continue;
[ ... ]
> @@ -670,13 +742,18 @@ static void qxl_primary_atomic_update(struct drm_pl=
ane *plane,
>  	struct qxl_device *qdev =3D to_qxl(plane->dev);
>  	struct qxl_bo *bo =3D gem_to_qxl_bo(new_state->fb->obj[0]);
>  	struct qxl_bo *primary;
[ ... ]
>  	qxl_draw_dirty_fb(qdev, new_state->fb, bo, 0, 0, &norect, 1, 1,
> -			  dumb_shadow_offset);
> +			  dumb_shadow_offset, y_off);
> +	if (qdev->dumb_shadow_needs_redraw) {
> +		qdev->dumb_shadow_needs_redraw =3D false;
> +		qxl_redraw_other_dumb_heads(qdev, new_state->crtc->index);
> +	}

[Severity: Medium]
Can this shared flag cause missed screen redraws due to a data race?

The qdev->dumb_shadow_needs_redraw flag is shared globally across the devic=
e.
When two atomic commits run concurrently on different CRTCs, both may set
the flag to true during qxl_prepare_shadow(). The first commit to reach
this update phase will clear the flag. The second commit will then see
the flag as false and skip the required redraws for other heads.

>  }
> =20
>  static void qxl_primary_atomic_disable(struct drm_plane *plane,
[ ... ]
> @@ -839,6 +918,7 @@ static void qxl_prepare_shadow(struct qxl_device *qde=
v, struct qxl_bo *user_bo,
>  		qxl_bo_create(qdev, surf.height * surf.stride,
>  			      true, true, QXL_GEM_DOMAIN_SURFACE, 0,
>  			      &surf, &qdev->dumb_shadow_bo);
> +		qdev->dumb_shadow_needs_redraw =3D true;

[Severity: Medium]
This is where the shared flag is set locklessly by potentially concurrent
plane preparation steps.

>  	}
>  	if (user_bo->shadow !=3D qdev->dumb_shadow_bo) {
>  		if (user_bo->shadow) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925033011.1256=
0-1-dillona@gmail.com?part=3D1
