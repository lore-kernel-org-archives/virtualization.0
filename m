Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015841;
	b=ZX4FqJr5U00Vv8j8AFnXn12B7+eKY1O7xn7Pc4bB/bzisDXTg/RWC8LyVnBLfEgd0hF1
	 LRjj54co1wDuEfpWvSCt49pljC2NAC0qECNS3yjae33DuEs671p1l6mpVTCBn8y4LUQiS
	 sA/L8PLSkjDFZDLFzML7wdxB3P2CUheivIsM2dn89/n0RSO1P/2LTsffNQSd2WTjXNky8
	 BXJku2nRyPTVS3YV8eEL5JLVxBWdwPxGlloD7w/xYlqUYpwzxIYS1D3MdCnQSxn9NAa4M
	 I/GB3JLiAMCEEPCrCU8nLa6ghKR2CAWIU2rFgnbc/DhtMXAtvw0hKjbnav8+RMayOgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015841;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cdFgpPQq2q01X9O1/Sn7pZDjJrderq47H7I+RTfbWis=;
	b=CAWWYZRxg7HDn/nwPx8CACabII/Rw45JqsKPa7GwHlRMDj8MCtBtgUr7HFCYIxBnxD7o
	 LhSXGPInuuqTzMrna8IQ+CPjAeMDolHc3gAgpZs+cwi0IM+vyKjYzAP5r/7o0hm9G8ng2
	 QK9gj0W04dwTBzzN2ynox79W6R6S0a+r5G2yMh8s7ADUhCEoLecDVeNF3s4/fFd/mVlIQ
	 sEVCUDNQoe1iMhc/LLD7VhTluFcM9AtVZdkRcGLzyLxt90j80ggZiYs2LhnJ+lvns1HrQ
	 zt1emKVuitMpC/WyLucl6AOAo/BBx7zhzqGRPqM4/EPOqF+yz/jN1oE6JNnH+4hPSuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fwCFlsSo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF183606A31B;
	Mon, 26 Oct 2026 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fwCFlsSo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112271F01828;
	Mon, 26 Oct 2026 11:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793015840;
	bh=cdFgpPQq2q01X9O1/Sn7pZDjJrderq47H7I+RTfbWis=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fwCFlsSomhT3W7cAQfgCvMR4uuDiYTCibiwFi6/mMuJgaJLbDKNbdMVohYhT40rMP
	 k4ILzMZaAMg4npyJymP3GsyVPRXG6ZTTY+DOtMJHg/i2v27Tix+0OuyUpiiegfTeNI
	 iZobx43G5SVnt87uAW6EW99DkxBx+Lel/+FZm1Ulq4VxCAeOL3afuuCXeBq7ARg5a8
	 2HrMA5x4tCZsnomzE+9MqWDMYCEAovTuDqokjgaUl2fd4uGETI+4jEWp7kfEa9K0fY
	 LxuTx2Xaa1H8zGlG7Y0O5Cj6VXD1OyatO1tBhzqLHOiMGHnZa1S/Vv2ItdEcbbopPz
	 4gBh1ML005V4g==
Message-ID: <sashiko-outbox-185141@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/23] drm/msm/dcp: Add DCP planes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-12-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-12-7cf014efdee1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 11:57:19 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [Critical] drm/msm/dcp: missing HFI pipe detach in dcp_plane_atomic_updat=
e()
- [Critical] drm/msm/dcp: unlocked plane->state access in dcp_plane_pipe_bu=
sy()
- [High] drm/msm/dcp: stale plane visibility used in dcp_plane_assign_pipe()
- [High] drm/msm/dcp: 90/270 rotation ignored in dcp_plane_atomic_check()
- [High] drm/msm/dcp: dcp_plane_atomic_create_state() returns NULL on OOM
- [High] drm/msm/dcp: broken IS_ERR() and NULL checks in dcp_plane_atomic_c=
heck()
- [High] drm/msm/dcp: divide-by-zero in dcp_plane_calc_bw() on zero vblank
- [Medium] drm/msm/dcp: chroma planes omitted in dcp_plane_calc_perf() bpp
- [Medium] drm/msm/dcp: non-alpha formats not forced to opaque blending in =
dcp_plane
- [Medium] drm/msm/dcp: missing minimum source size check for RGB formats i=
n dcp_plane_atomic_check()
--

commit 22e98b5154e2eb947949b5c49894d72a16ccd158
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

drm/msm/dcp: Add DCP planes

This commit adds DRM plane support for the DCP display driver, including
format and scaling validation, firmware pipe assignment, bandwidth and
clock calculation, and HFI property packet construction and submission.

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_plane.c b/drivers/gpu/drm/msm/dc=
p/dcp_plane.c
> new file mode 100644
> index 0000000000000..af8aa2162b03d
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_plane.c
[ ... ]
> +static bool dcp_plane_pipe_busy(struct drm_atomic_commit *state,
> +				struct drm_plane *self, u32 pipe_id)
> +{
> +	struct drm_plane *plane;
> +	struct drm_plane_state *plane_state;
> +	struct drm_plane *iter_plane;
> +	struct drm_plane_state *new_plane_state;
> +	int i;
> +
> +	drm_for_each_plane(plane, state->dev) {
> +		if (plane =3D=3D self)
> +			continue;
> +
> +		plane_state =3D plane->state;
> +		for_each_new_plane_in_state(state, iter_plane, new_plane_state, i) {
> +			if (iter_plane =3D=3D plane) {
> +				plane_state =3D new_plane_state;
> +				break;
> +			}
> +		}
> +
> +		if (plane_state && plane_state->crtc && plane_state->visible &&
> +		    to_dcp_plane_state(plane_state)->hfi_pipe_id =3D=3D pipe_id)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static u32 dcp_plane_assign_pipe(struct dcp_dpu_kms *dcp_kms,
> +				 struct drm_atomic_commit *state,
> +				 struct drm_plane *plane,
> +				 struct dcp_plane_state *pstate,
> +				 bool yuv, bool scaling)
> +{
> +	const struct dcp_caps *caps =3D dcp_kms->caps;
> +	u32 i, pipe_id;
> +
> +	/* YUV scanout requires a VIG pipe with the CSC path. */
> +	if (dcp_plane_hfi_pipe_valid(dcp_kms, pstate->hfi_pipe_id) &&
> +	    (!yuv || dcp_plane_pipe_is_vig(caps, pstate->hfi_pipe_id)) &&
> +	    (!scaling || dcp_plane_pipe_is_vig(caps, pstate->hfi_pipe_id)) &&
> +	    !dcp_plane_pipe_busy(state, plane, pstate->hfi_pipe_id))
> +		return pstate->hfi_pipe_id;
> +
> +	/*
> +	 * R1/virtual pipes are intentionally not allocated as independent
> +	 * planes yet. They require transactional physical-pipe/R1 ownership
> +	 * and multirect programming, which will be added with the resource
> +	 * manager.
> +	 */
> +	for (i =3D 0; i < caps->num_vig_pipes; i++) {
> +		pipe_id =3D caps->vig_pipe_ids[i];
> +		if (!dcp_plane_pipe_busy(state, plane, pipe_id))
> +			return pipe_id;
> +	}

[Severity: Critical]
Is it safe for dcp_plane_pipe_busy() to read plane->state for planes that
are not part of the current drm_atomic_commit without holding plane->mutex?

When dcp_plane_atomic_check() calls dcp_plane_assign_pipe() ->
dcp_plane_pipe_busy(), it iterates over all planes on the device via
drm_for_each_plane() and falls back to plane_state =3D plane->state for any
plane not present in state.

Because DCP supports multiple CRTCs and planes are shared across
possible_crtcs, a concurrent atomic commit on another CRTC holding that
other plane's mutex can swap plane->state in drm_atomic_helper_swap_state()
and free the old state via drm_atomic_commit_put() ->
dcp_plane_atomic_destroy_state() -> kfree() while dcp_plane_pipe_busy() is
dereferencing plane_state->crtc, plane_state->visible, and
to_dcp_plane_state(plane_state)->hfi_pipe_id.

In addition, without serializing pipe assignment through a shared
drm_private_obj state or lock, can two concurrent atomic checks on
different CRTCs both see the same pipe_id as free in dcp_plane_pipe_busy()
and assign the same hardware HFI pipe to two active planes?

[ ... ]
> +static u64 dcp_plane_calc_bw(u32 bpp,
> +			     const struct drm_display_mode *mode,
> +			     const struct drm_rect *src,
> +			     const struct drm_rect *dst)
> +{
> +	int src_w =3D drm_rect_width(src) >> 16;
> +	int src_h =3D drm_rect_height(src) >> 16;
> +	int dst_h =3D drm_rect_height(dst);
> +	int fps   =3D drm_mode_vrefresh(mode);
> +	int vbp   =3D mode->vtotal - mode->vsync_end;
> +	int vpw   =3D mode->vsync_end - mode->vsync_start;
> +	int vfp   =3D mode->vsync_start - mode->vdisplay;
> +	u32 hw_latency =3D 25;
> +	u64 scale_factor =3D (src_h > dst_h) ? mult_frac(src_h, 1, dst_h) : 1;
> +	u64 plane_bw, prefill_bw;
> +
> +	plane_bw =3D (u64)src_w * mode->vtotal * fps * bpp * scale_factor;
> +	prefill_bw =3D plane_bw * hw_latency;
> +
> +	if ((vbp + vpw) > hw_latency)
> +		do_div(prefill_bw, (vbp + vpw));
> +	else if ((vbp + vpw + vfp) < hw_latency)
> +		do_div(prefill_bw, (vbp + vpw + vfp));
> +	else
> +		do_div(prefill_bw, hw_latency);

[Severity: High]
Can dcp_plane_calc_bw() trigger a divide-by-zero when (vbp + vpw + vfp) is
zero?

Here, vbp + vpw + vfp equals mode->vtotal - mode->vdisplay. Neither
drm_mode_validate_basic() nor dcp_crtc_mode_valid() rejects a mode with
vdisplay =3D=3D vsync_start =3D=3D vsync_end =3D=3D vtotal.

If userspace submits an atomic commit or DRM_MODE_ATOMIC_TEST_ONLY check
with such a mode and a visible plane, (vbp + vpw) > hw_latency is false and
(vbp + vpw + vfp) < hw_latency is true (0 < 25), causing do_div(prefill_bw,
(vbp + vpw + vfp)) to divide by zero.

[ ... ]
> +void dcp_plane_calc_perf(const struct drm_plane_state *state,
> +			 const struct drm_display_mode *mode,
> +			 struct dcp_plane_perf *perf)
> +{
> +	struct drm_rect src, dst;
> +	u32 bpp;
> +
> +	memset(perf, 0, sizeof(*perf));
> +
> +	if (!state || !state->visible || !state->fb || !mode || !mode->clock ||
> +	    !drm_mode_vrefresh(mode))
> +		return;
> +
> +	src =3D drm_plane_state_src(state);
> +	dst =3D drm_plane_state_dest(state);
> +	bpp =3D drm_format_info_bpp(state->fb->format, 0);
> +
> +	perf->fetch_bw =3D dcp_plane_calc_bw(bpp, mode, &src, &dst);
> +	perf->clk =3D dcp_plane_calc_clk(mode, &src, &dst);
> +}

[Severity: Medium]
Does querying drm_format_info_bpp(state->fb->format, 0) in
dcp_plane_calc_perf() undercount the bandwidth for multi-planar YUV
formats?

For formats such as DRM_FORMAT_NV12, DRM_FORMAT_NV21, DRM_FORMAT_YUV420,
DRM_FORMAT_YVU420, and DRM_FORMAT_P010, plane 0 only accounts for the luma
plane (8 bpp for 8-bit 4:2:0 or 16 bpp for P010), omitting the chroma
planes (which add another 4 bpp or 8 bpp) from perf->fetch_bw.

[ ... ]
> +static int dcp_plane_build_one_hfi_props_packet(struct dcp_plane_state *=
pstate,
> +						const struct drm_plane_state *state,
> +						u32 session_id, u32 packet_id,
> +						u8 *packet)
> +{
[ ... ]
> +	hfi_rotation =3D dcp_drm_to_hfi_rotation(state->rotation);
> +	hfi_blend_op =3D dcp_drm_to_hfi_blend_op(state->pixel_blend_mode);
> +
> +	src_x =3D state->src_x >> 16;
> +	src_y =3D state->src_y >> 16;
> +	src_w =3D state->src_w >> 16;
> +	src_h =3D state->src_h >> 16;
> +	dst_x =3D state->crtc_x;
> +	dst_y =3D state->crtc_y;
> +	dst_w =3D state->crtc_w;
> +	dst_h =3D state->crtc_h;
> +
> +	hfi_alpha =3D dcp_hfi_scale_alpha(state, state->alpha);
> +	hfi_bg_alpha =3D dcp_hfi_scale_alpha(state,
> +					   dcp_compute_bg_alpha(state->pixel_blend_mode,
> +								state->alpha));

[Severity: Medium]
When !fb->format->has_alpha (for example with DRM_FORMAT_XRGB8888,
DRM_FORMAT_RGB565, or YUV formats), should dcp_plane_build_one_hfi_props_pa=
cket()
fall back to DRM_MODE_BLEND_PIXEL_NONE instead of using
state->pixel_blend_mode directly?

dcp_plane_init() attaches the pixel blend mode property with
DRM_MODE_BLEND_PREMULTI as the default. When a non-alpha framebuffer is
used, passing DRM_MODE_BLEND_PREMULTI or DRM_MODE_BLEND_COVERAGE to
dcp_drm_to_hfi_blend_op() and dcp_compute_bg_alpha() programs
HFI_BLEND_OP_PREMULTIPLIED or HFI_BLEND_OP_COVERAGE and sets bg_alpha to
fg_alpha (or 0 when opaque) rather than HFI_BLEND_OP_OPAQUE with
DRM_BLEND_ALPHA_OPAQUE - fg_alpha.

[ ... ]
> +static int dcp_plane_atomic_check(struct drm_plane *plane,
> +				  struct drm_atomic_commit *state)
> +{
[ ... ]
> +	if (!new_state->crtc)
> +		return 0;
> +
> +	crtc_state =3D drm_atomic_get_new_crtc_state(state, new_state->crtc);
> +	if (IS_ERR(crtc_state)) {
> +		ret =3D PTR_ERR(crtc_state);
> +		drm_err(plane->dev, "plane%u: failed to get CRTC state: %d\n",
> +			plane->base.id, ret);
> +		return ret;
> +	}

[Severity: High]
drm_atomic_get_new_crtc_state() returns NULL when the CRTC is not in state,
rather than an ERR_PTR(). Should this check for !crtc_state instead of
IS_ERR(crtc_state) so a NULL crtc_state is not passed to
drm_atomic_helper_check_plane_state()?

Similarly, in dcp_plane_assign_pipe(), dcp_plane_hfi_pipe_valid() checks
if (!dcp_kms->caps), but when it returns false, dcp_plane_assign_pipe()
immediately dereferences caps->num_vig_pipes and caps->num_dma_pipes
without checking if caps is NULL.

> +	if (!new_state->fb)
> +		return 0;
> +
> +	scaling =3D new_state->src_w !=3D ((u32)new_state->crtc_w << 16) ||
> +			  new_state->src_h !=3D ((u32)new_state->crtc_h << 16);
> +
> +	pstate->hfi_pipe_id =3D dcp_plane_assign_pipe(dcp_kms, state, plane,
> +						    pstate, new_state->fb->format->is_yuv,
> +						    scaling);
> +	if (pstate->hfi_pipe_id =3D=3D U32_MAX) {
> +		drm_err(plane->dev, "plane%u: no compatible HFI pipe available\n",
> +			plane->base.id);
> +		return -ENOSPC;
> +	}
> +
> +	if (dcp_plane_pipe_is_vig(dcp_kms->caps, pstate->hfi_pipe_id)) {
> +		min_scale =3D FRAC_16_16(1, DCP_MAX_UPSCALE_RATIO);
> +		max_scale =3D DCP_MAX_DOWNSCALE_RATIO << 16;
> +	}
> +
> +	ret =3D drm_atomic_helper_check_plane_state(new_state, crtc_state,
> +						  min_scale, max_scale,
> +						  true, true);

[Severity: High]
Because dcp_plane_assign_pipe() -> dcp_plane_pipe_busy() runs before
drm_atomic_helper_check_plane_state() computes new_state->visible, won't
dcp_plane_pipe_busy() inspect stale visibility flags?

Specifically:
1. When drm_atomic_helper_check_planes() checks planes in ascending index
   order, any higher-indexed plane in the same atomic commit has not run
   dcp_plane_atomic_check() yet, so its new_plane_state->visible still
   holds the old state's visibility. If that higher-indexed plane was
   previously disabled and is being enabled in this commit,
   dcp_plane_pipe_busy() sees new_plane_state->visible =3D=3D false and all=
ows
   an earlier plane to take its hfi_pipe_id.
2. If the current plane is clipped off-screen so
   drm_atomic_helper_check_plane_state() sets new_state->visible =3D false,
   it has already claimed a pipe in dcp_plane_assign_pipe().
3. When a previously visible plane is disabled (!new_state->crtc or
   !new_state->fb), dcp_plane_atomic_check() returns 0 early before calling
   drm_atomic_helper_check_plane_state(), leaving new_state->visible set to
   true on the disabled state.

> +	if (ret) {
> +		drm_err(plane->dev, "plane%u: plane state check failed: %d\n",
> +			plane->base.id, ret);
> +		return ret;
> +	}
> +
> +	if (!new_state->visible)
> +		return 0;
[ ... ]
> +	dcp_mode_limits(&crtc_state->adjusted_mode,
> +			dcp_kms->caps->max_width, dcp_kms->caps->max_height,
> +			&max_width, &max_height);
> +
> +	if (new_state->fb->width > max_width ||
> +	    new_state->fb->height > max_height) {
> +		drm_err(plane->dev,
> +			"plane%u: framebuffer %ux%u exceeds caps %ux%u\n",
> +			plane->base.id, new_state->fb->width, new_state->fb->height,
> +			dcp_kms->caps->max_width, dcp_kms->caps->max_height);
> +		return -E2BIG;
> +	}

[Severity: High]
How does dcp_plane_atomic_check() handle 90 and 270 degree rotations?

dcp_plane_init() advertises DRM_MODE_ROTATE_90 and DRM_MODE_ROTATE_270, and
drm_atomic_helper_check_plane_state() rotates the source rectangle via
drm_rect_rotate() before checking hscale and vscale. However:
1. The scaling check earlier in dcp_plane_atomic_check():
     scaling =3D new_state->src_w !=3D ((u32)new_state->crtc_w << 16) ||
               new_state->src_h !=3D ((u32)new_state->crtc_h << 16);
   compares unrotated source dimensions against crtc_w and crtc_h. For a
   non-square plane rotated 90 or 270 degrees, an unscaled plane (where
   src_w =3D=3D crtc_h << 16 and src_h =3D=3D crtc_w << 16) is treated as s=
caled
   and forced onto a VIG pipe, whereas a scaled plane with
   src_w =3D=3D crtc_w << 16 and src_h =3D=3D crtc_h << 16 is treated as un=
scaled,
   assigned a DMA pipe with DRM_PLANE_NO_SCALING, and rejected by
   drm_atomic_helper_check_plane_state() with -ERANGE.
2. The dcp_mode_limits() check compares unrotated new_state->fb->width and
   new_state->fb->height against mode-oriented max_width and max_height,
   rejecting a landscape framebuffer rotated 90/270 degrees onto a portrait
   mode with -E2BIG.
3. dcp_plane_calc_perf() passes unrotated drm_plane_state_src(state) to
   dcp_plane_calc_bw() and dcp_plane_calc_clk(), using unrotated src_w and
   src_h for bandwidth and clock scaling calculations.

> +	for (i =3D 0; i < new_state->fb->format->num_planes; i++) {
> +		if (new_state->fb->pitches[i] > DCP_SSPP_MAX_PITCH_SIZE) {
> +			drm_err(plane->dev,
> +				"plane%u: pitch[%d]=3D%u exceeds limit %u\n",
> +				plane->base.id, i, new_state->fb->pitches[i],
> +				DCP_SSPP_MAX_PITCH_SIZE);
> +			return -E2BIG;
> +		}
> +	}
> +
> +	src =3D drm_plane_state_src(new_state);
> +
> +	pstate->src_img_w =3D new_state->fb->width;
> +	pstate->src_img_h =3D new_state->fb->height;
> +
> +	if (new_state->fb->format->is_yuv) {
> +		u32 src_x =3D src.x1 >> 16;
> +		u32 src_y =3D src.y1 >> 16;
> +		u32 src_w =3D drm_rect_width(&src) >> 16;
> +		u32 src_h =3D drm_rect_height(&src) >> 16;
> +
> +		if (src_w < 2 || src_h < 2) {
> +			drm_err(plane->dev,
> +				"plane%u: YUV source too small: %ux%u\n",
> +				plane->base.id, src_w, src_h);
> +			return -EINVAL;
> +		}

[Severity: Medium]
Should non-YUV formats also enforce a minimum integer source size of
src_w >=3D 1 and src_h >=3D 1?

When an RGB plane is assigned to a VIG pipe, min_scale is
FRAC_16_16(1, DCP_MAX_UPSCALE_RATIO), which allows sub-pixel 16.16 source
dimensions (such as src_w or src_h in [3276, 65535] with crtc_w =3D 1 or
crtc_h =3D 1) to pass drm_atomic_helper_check_plane_state() with
new_state->visible =3D true.

Because minimum source dimensions are only checked inside the is_yuv block,
state->src_w >> 16 or state->src_h >> 16 then truncates to 0 in
dcp_plane_calc_bw() (resulting in a 0 bandwidth vote for a visible plane)
and in dcp_plane_build_one_hfi_props_packet() (sending a 0-width or
0-height HFI_PROPERTY_LAYER_SRC_ROI to the firmware).

[ ... ]
> +static void dcp_plane_atomic_update(struct drm_plane *plane,
> +				    struct drm_atomic_commit *state)
> +{
> +	struct drm_plane_state *new_state =3D
> +		drm_atomic_get_new_plane_state(state, plane);
> +	struct dcp_plane_state *pstate =3D to_dcp_plane_state(new_state);
> +	int ret;
> +
> +	drm_dbg_driver(plane->dev,
> +		       "plane%u: atomic_update visible=3D%d fb=3D%u pipe_id=3D%u\n",
> +		       plane->base.id, new_state->visible,
> +		       new_state->fb ? new_state->fb->base.id : 0,
> +		       pstate->hfi_pipe_id);
> +
> +	pstate->prop_pkt_size =3D 0;
> +
> +	if (!new_state->visible || !new_state->fb)
> +		return;
> +
> +	ret =3D dcp_plane_submit_update(plane, new_state);
> +	if (ret) {
> +		drm_err(plane->dev,
> +			"plane%u: HFI update failed: %d\n", plane->base.id, ret);
> +		dcp_plane_set_hfi_error(new_state, ret);
> +		return;
> +	}
> +}
> +
> +static void dcp_plane_atomic_disable(struct drm_plane *plane,
> +				     struct drm_atomic_commit *state)
> +{
> +	struct drm_plane_state *old_state =3D
> +		drm_atomic_get_old_plane_state(state, plane);
> +	struct dcp_plane_state *pstate =3D to_dcp_plane_state(old_state);
> +	int ret;
> +
> +	drm_dbg_driver(plane->dev,
> +		       "plane%u: atomic_disable pipe_id=3D%u\n",
> +		       plane->base.id, pstate->hfi_pipe_id);
> +
> +	ret =3D dcp_plane_submit_disable(plane, old_state);

[Severity: Critical]
Can HFI pipes remain attached to unmapped framebuffers or be erroneously
detached from another plane during atomic commits?

There appear to be three related issues in the update/disable paths:
1. When an active visible plane remains bound to a CRTC and framebuffer
   (new_state->crtc !=3D NULL and new_state->fb !=3D NULL) but is moved
   off-screen so new_state->visible becomes false,
   drm_atomic_plane_disabling() is false and
   drm_atomic_helper_commit_planes() calls dcp_plane_atomic_update() rather
   than dcp_plane_atomic_disable(). dcp_plane_atomic_update() returns early
   at if (!new_state->visible || !new_state->fb) without detaching
   old_state->hfi_pipe_id, leaving the DCP firmware scanning out from the
   old framebuffer IOVA after dcp_plane_cleanup_fb() ->
   msm_framebuffer_cleanup() unmaps it.
2. When an already-visible plane is reassigned to a different pipe by
   dcp_plane_assign_pipe() (for example, switching from an unscaled RGB
   buffer on a DMA pipe to a YUV or scaled buffer requiring a VIG pipe, so
   old_pstate->hfi_pipe_id !=3D pstate->hfi_pipe_id),
   dcp_plane_atomic_update() attaches the new pipe but never sends
   HFI_PROPERTY_DISPLAY_DETACH_LAYER for old_pstate->hfi_pipe_id.
3. Because dcp_plane_pipe_busy() treats an invisible or disabling plane's
   hfi_pipe_id as free, a lower-indexed plane can be assigned and attach
   that pipe in dcp_plane_atomic_update() before the higher-indexed plane
   runs dcp_plane_atomic_disable() (which executes in ascending plane index
   order and does not check old_state->visible), causing
   dcp_plane_atomic_disable() to detach the pipe that the lower-indexed
   plane just attached.

[ ... ]
> +static struct drm_plane_state *
> +dcp_plane_atomic_create_state(struct drm_plane *plane)
> +{
> +	struct dcp_plane_state *pstate;
> +	u32 hfi_pipe_id =3D to_dcp_plane(plane)->hfi_pipe_id;
> +
> +	pstate =3D kzalloc_obj(*pstate, GFP_KERNEL);
> +	if (!pstate)
> +		return NULL;

[Severity: High]
Should dcp_plane_atomic_create_state() return ERR_PTR(-ENOMEM) instead of
NULL on allocation failure?

Its caller drm_mode_config_plane_create_state() checks for errors using
IS_ERR(plane_state), so returning NULL bypasses error handling and leaves
plane->state as NULL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-jshekhar-d=
cp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com?part=3D12
