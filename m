Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793014431;
	b=uzOSpiZKNxEJhiD9AXptZVQtni5fTQjVF06I2rEOMM1bUtSUoimScQp0qDIhYEMp53Ei
	 0fhKHxnEcHfiBS4vH62hNuAKI/1ibHjUYMBeFVQddYnBlrZLokoLFbKrAPI0fr5lwC381
	 mMTk+bSHsI5B2xR/G7Oj/qWbXvneeedxZp6MoPTCOSDDk1sWnq3OcAdRzwWPs3pb/RAby
	 NXV5d32777H+u+CNcQO0hcggClR/cVOZoH9vaTzJ3qAHrwHG3MsYISZ1iTeezvqpUShnW
	 bfX29L+iE5iykkDcWMVal3mkkxbLi2CzzCj6sZ+FAhfOJjJxOJcS38Av5BlOqNwI/xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014431;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wuODrShRFRKxE4qRcJuOdvbwKSKRK7himmv01HDbqgY=;
	b=H7XbYXWjio7cvmklk7Jdceg88Jtz48coaYT8AGRObmsDXRcykR4itMyc+qf262ej6i3O
	 2xzNj8bA2vaEiv9A3gtvgMAJkaAXpxz5XE5XREWaXjLRieBxGMzG9FVWEnG4XR3kI14tH
	 /BTWuAcoIKlWK4conUsSmg1ayRmyABSbBDylMdVMEGsTcyR1NWCNKFMFXp6NuwyJ1h0vZ
	 gG/Ko8yXRUxSHU4lSyYnoQGgJGyTyWLQGL703ObZxDQhjpLl+K7FcHS0SiJq6jN6Fi1HU
	 FhPV1TGiSJ3h1bZz3HGamuZd4JcnbKAOBGkuRgcWx6IBCNHcyYGyfyRotC3CfJIC1VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kvuTIgER;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A14606A31B;
	Mon, 26 Oct 2026 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kvuTIgER
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146BB1F01825;
	Mon, 26 Oct 2026 11:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793014430;
	bh=wuODrShRFRKxE4qRcJuOdvbwKSKRK7himmv01HDbqgY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kvuTIgERYRQJuGm1VdNWnqef7hhs6koa/Yqoy4qnXq3Lz+gM2wWovCJgdCJAHu70E
	 nK0wPjF7qGOw0sFsPDC6t9xN0D8S4FlHly3PgANikYcQYgF/YdLhEoOrNoxwW8wK+0
	 uSUR5OxJ3i/x21NDR6wkIm79JJm3/fg5e2N2hWt28r4ZbR20sK7rnBPjI1relgY0B6
	 k3LaO4uQkoAzvG4lXoEQ4+QLeA3hvIO5aB6rTx7jK/Ybc4kATXZgywkE3ghPXS1knK
	 gvaLgvCXoomc8jGd9KReWEku0PeQVdds0B/g6TNpiAFRx3/d8zFz+EgxSymNlga7ZI
	 flQAO0SGS4c8g==
Message-ID: <sashiko-outbox-185108@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/23] drm/msm/dcp: Add DCP CRTCs and shared plane
 state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-11-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-11-7cf014efdee1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 11:33:49 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] drm/msm/dcp: unconsumed crtc event on disable in dcp_crtc_atomic_f=
lush()
- [High] drm/msm/dcp: software vblank count returned in dcp_crtc_get_vblank=
_counter()
- [Medium] drm/msm/dcp: signed crtc_x promotion in dcp_crtc_setup_mixer_roi=
s()
- [Medium] drm/msm/dcp: pending_kickoff_cnt underflow in dcp_crtc_commit_ki=
ckoff()
- [Medium] drm/msm/dcp: skipped drm_crtc_vblank_on() in dcp_crtc_atomic_ena=
ble()
- [Medium] drm/msm/dcp: stale bandwidth vote when planes hide in dcp_crtc_a=
tomic_begin()
- [Medium] drm/msm/dcp: vblank_enabled race and stale state in dcp_crtc_vbl=
ank()
--

commit 5e8f3961384fe1603b59d4d7ed8e2050307e4116
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

drm/msm/dcp: Add DCP CRTCs and shared plane state

This commit adds DRM CRTC objects, session tracking, bandwidth aggregation,
and shared plane state definitions for the firmware-owned DCP display
pipeline in MSM DRM.

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_crtc.c b/drivers/gpu/drm/msm/dcp=
/dcp_crtc.c
> new file mode 100644
> index 0000000000000..ec4f74c2920f8
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_crtc.c
[ ... ]
> +static void dcp_crtc_atomic_begin(struct drm_crtc *crtc,
> +				  struct drm_atomic_commit *state)
> +{
> +	struct dcp_crtc *dcp_crtc =3D to_dcp_crtc(crtc);
> +	struct dcp_crtc_state *cstate =3D to_dcp_crtc_state(crtc->state);
> +	struct dcp_dpu_kms *dcp_kms =3D dcp_crtc_get_kms(crtc);
> +	u32 mixer_count;
> +	u32 session_id;
> +	u32 i;
> +	int ret;
> +
> +	if (!crtc->state->active)
> +		return;
> +	if (!dcp_kms->commit_pm_active) {
> +		cstate->hfi_error =3D -EIO;
> +		return;
> +	}
> +
> +	if (!dcp_crtc_get_session(crtc, &session_id)) {
> +		cstate->hfi_error =3D -ENODEV;
> +		return;
> +	}
> +
> +	if (cstate->core_clk > 0 || cstate->dram_ib > 0) {
> +		ret =3D dcp_hfi_crtc_set_bw(dcp_kms->hfi, session_id,
> +					  cstate->dram_ib,  cstate->dram_ab,
> +					  cstate->llcc_ib,  cstate->llcc_ab,
> +					  cstate->core_clk);
> +		if (ret) {
> +			cstate->hfi_error =3D ret;
> +			return;
> +		}
> +	}

[Severity: Medium]
What happens in dcp_crtc_atomic_begin() when an active CRTC that previously
had visible planes is updated so that all planes are disabled or clipped
off-screen while the CRTC remains active?

In dcp_crtc_atomic_check(), dcp_crtc_aggregate_bw() resets dram_ib, dram_ab,
llcc_ib, llcc_ab, and core_clk to 0. Because dcp_crtc_atomic_begin() guards
the call to dcp_hfi_crtc_set_bw() with (cstate->core_clk > 0 ||
cstate->dram_ib > 0), the zeroed bandwidth values are skipped and the
previous non-zero DRAM/LLCC bandwidth and core clock votes remain pinned in
firmware.

Should dcp_hfi_crtc_set_bw() also be called when the aggregated bandwidth
drops to zero on an active CRTC?

[ ... ]
> +static void dcp_crtc_atomic_flush(struct drm_crtc *crtc,
> +				  struct drm_atomic_commit *state)
> +{
> +	struct dcp_crtc *dcp_crtc =3D to_dcp_crtc(crtc);
> +	struct dcp_crtc_state *cstate =3D to_dcp_crtc_state(crtc->state);
> +	struct dcp_dpu_kms *dcp_kms =3D dcp_crtc_get_kms(crtc);
> +	unsigned long flags;
> +	u32 session_id;
> +	int ret;
> +
> +	if (!crtc->state->enable)
> +		return;
[ ... ]
> +flush_done:
> +	spin_lock_irqsave(&crtc->dev->event_lock, flags);
> +	dcp_crtc->event =3D crtc->state->event;
> +	crtc->state->event =3D NULL;
> +	spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
> +}

[Severity: High]
Does disabling an active CRTC leave crtc->state->event unconsumed?

In drm_atomic_helper_setup_commit(), whenever old_crtc_state->active is true
(including when disabling an active CRTC with new_crtc_state->enable =3D=3D=
 false
and new_crtc_state->active =3D=3D false), DRM core populates new_crtc_state=
->event
to signal commit->flip_done and takes a commit reference via
drm_crtc_commit_get().

During msm_atomic_commit_tail():

  drm_atomic_helper_commit_modeset_disables()
    -> dcp_crtc_atomic_disable()
  drm_atomic_helper_commit_planes()
    -> dcp_crtc_atomic_flush()
  dcp_dpu_kms_complete_commit()
    -> dcp_crtc_complete_commit()
  drm_atomic_helper_commit_hw_done()

Unlike dpu_crtc_disable(), mdp5_crtc_atomic_disable(), and
mdp4_crtc_atomic_disable(), dcp_crtc_atomic_disable() does not send and cle=
ar
crtc->state->event. Then dcp_crtc_atomic_flush() returns early when
!crtc->state->enable before transferring crtc->state->event to
dcp_crtc->event, so dcp_crtc_complete_commit() sees dcp_crtc->event =3D=3D =
NULL.

Wouldn't this trigger WARN_ON(new_crtc_state->event) in
drm_atomic_helper_commit_hw_done(), leave commit->flip_done unsignaled (sta=
lling
subsequent commits in drm_atomic_helper_wait_for_dependencies()), and leak =
the
drm_pending_vblank_event and drm_crtc_commit reference? Also, if an earlier
event was still in dcp_crtc->event during dcp_crtc_atomic_flush(), could
unconditionally assigning dcp_crtc->event =3D crtc->state->event overwrite =
it?

[ ... ]
> +void dcp_crtc_commit_kickoff(struct drm_crtc *crtc)
> +{
> +	struct dcp_crtc *dcp_crtc =3D to_dcp_crtc(crtc);
> +	struct dcp_dpu_kms *dcp_kms =3D dcp_crtc_get_kms(crtc);
> +	struct dcp_crtc_state *cstate =3D to_dcp_crtc_state(crtc->state);
> +	u32 session_id;
> +	int ret;
> +
[ ... ]
> +	/* MSM serializes commits, so only one frame completion may be pending.=
 */
> +	if (atomic_cmpxchg(&dcp_crtc->pending_kickoff_cnt, 0, 1)) {
> +		drm_err(crtc->dev,
> +			"CRTC%u: frame completion already pending\n",
> +			dcp_crtc->display_id);
> +		cstate->hfi_error =3D -EBUSY;
> +		return;
> +	}
> +	dcp_crtc->pending_seq_id =3D dcp_crtc->commit_seq_id;
> +
> +	ret =3D dcp_hfi_display_commit(dcp_kms->hfi, session_id);
> +	if (ret) {
> +		drm_err(crtc->dev,
> +			"HFI commit failed for CRTC%u (session=3D%u): %d\n",
> +			dcp_crtc->display_id, session_id, ret);
> +		atomic_dec(&dcp_crtc->pending_kickoff_cnt);
> +		wake_up(&dcp_crtc->frame_done_wq);
> +	}
> +}

[Severity: Medium]
Can dcp_crtc->pending_kickoff_cnt underflow to -1 if
dcp_crtc_hfi_frame_done_cb() races with dcp_crtc_commit_kickoff()?

In dcp_crtc_commit_kickoff(), pending_kickoff_cnt is set to 1 via
atomic_cmpxchg() before dcp_crtc->pending_seq_id is updated, and then
dcp_hfi_display_commit() waits synchronously for the HFI response.

If a late HFI_COMMAND_DISPLAY_EVENT_FRAME_SCAN_COMPLETE from a prior timed-=
out
commit arrives before pending_seq_id is written, or if the frame scan
complete event for the current commit arrives and runs
dcp_crtc_frame_done_callback() (decrementing pending_kickoff_cnt from 1 to 0
via atomic_add_unless(&dcp_crtc->pending_kickoff_cnt, -1, 0)) before
dcp_hfi_display_commit() returns an error, the error path executes
atomic_dec(&dcp_crtc->pending_kickoff_cnt) and drives pending_kickoff_cnt to
-1.

Once pending_kickoff_cnt is -1, dcp_crtc_wait_for_commit_done() will wait f=
or
pending_kickoff_cnt =3D=3D 0 until the 500ms timeout expires, and any furth=
er
dcp_crtc_frame_done_callback() calls will continue decrementing the negative
counter because atomic_add_unless(..., -1, 0) only stops at 0.

Should dcp_crtc->pending_seq_id be written before setting
pending_kickoff_cnt, and should the error path use atomic_set(..., 0) or
atomic_add_unless(..., -1, 0) instead of atomic_dec()?

[ ... ]
> +int dcp_crtc_vblank(struct drm_crtc *crtc, bool enable)
> +{
> +	struct dcp_crtc *dcp_crtc =3D to_dcp_crtc(crtc);
> +	struct dcp_dpu_kms *dcp_kms =3D dcp_crtc_get_kms(crtc);
> +	u32 session_id;
> +	int ret;
> +
> +	if (!dcp_kms->hfi || !dcp_crtc_get_session(crtc, &session_id))
> +		return -ENODEV;
> +
> +	if (enable)
> +		ret =3D dcp_hfi_display_event_register_async(dcp_kms->hfi,
> +							   session_id, HFI_EVENT_VSYNC);
> +	else
> +		ret =3D dcp_hfi_display_event_deregister_async(dcp_kms->hfi,
> +							     session_id, HFI_EVENT_VSYNC);
> +	if (ret)
> +		return ret;
> +
> +	WRITE_ONCE(dcp_crtc->vblank_enabled, enable);
> +	return 0;
> +}
> +
> +void dcp_crtc_vblank_callback(struct drm_crtc *crtc)
> +{
> +	struct dcp_crtc *dcp_crtc =3D to_dcp_crtc(crtc);
> +
> +	if (!READ_ONCE(dcp_crtc->vblank_enabled))
> +		return;

[Severity: Medium]
Could updating dcp_crtc->vblank_enabled at the end of dcp_crtc_vblank() drop
initial VSYNC events or leave vblank_enabled stuck at true after disable?

When enable is true, dcp_hfi_display_event_register_async() queues and kicks
the HFI command before WRITE_ONCE(dcp_crtc->vblank_enabled, true) runs. If a
VSYNC event arrives on the response virtqueue before WRITE_ONCE() executes,
dcp_crtc_vblank_callback() sees vblank_enabled =3D=3D false and drops it.

Conversely, when enable is false, msm_crtc_disable_vblank() runs
vblank_ctrl_worker asynchronously. If the CRTC session has already been
cleared via dcp_crtc_clear_session() by the time dcp_crtc_vblank(crtc, fals=
e)
runs (or if dcp_hfi_display_event_deregister_async() fails), dcp_crtc_vblan=
k()
returns early without clearing dcp_crtc->vblank_enabled.

[ ... ]
> +static int dcp_crtc_setup_mixer_rois(struct drm_crtc *crtc,
> +				     struct drm_crtc_state *crtc_state,
> +				     struct dcp_crtc_state *cstate)
> +{
[ ... ]
> +	drm_atomic_crtc_state_for_each_plane_state(plane, pstate, crtc_state) {
> +		bool fullscreen;
> +		bool assigned =3D false;
> +		u32 mixer_idx;
> +
> +		if (!pstate || !pstate->visible || !pstate->fb)
> +			continue;
> +
> +		for (mixer_idx =3D 0; mixer_idx < mixer_count; mixer_idx++) {
> +			struct dcp_mixer_roi *mixer =3D &cstate->mixer_roi[mixer_idx];
> +
> +			if (pstate->crtc_x >=3D mixer->x &&
> +			    pstate->crtc_x + pstate->crtc_w <=3D mixer->x + mixer->w) {
> +				assigned =3D true;
> +				break;
> +			}
> +		}

[Severity: Medium]
In dcp_crtc_setup_mixer_rois(), pstate->crtc_x is a signed int32_t while
mixer->x, mixer->w, and pstate->crtc_w are unsigned u32. What happens when a
visible plane has a negative crtc_x?

Because C integer promotion converts pstate->crtc_x to u32 in both
comparisons:

  pstate->crtc_x >=3D mixer->x
  pstate->crtc_x + pstate->crtc_w <=3D mixer->x + mixer->w

a negative pstate->crtc_x becomes a large unsigned value (>=3D 0x80000000) =
that
is always >=3D mixer->x, while (u32)pstate->crtc_x + pstate->crtc_w wraps
around to the plane's positive right edge. On a multi-mixer topology
(mixer_count > 1), a plane starting at crtc_x < 0 and extending across the
mixer boundary into mixer 1 will satisfy both checks for mixer 1 and set
assigned =3D true instead of returning -EOPNOTSUPP.

In addition, should this check use the clipped destination rectangle
(pstate->dst.x1 and pstate->dst.x2) rather than unclipped pstate->crtc_x and
pstate->crtc_w so that planes partially clipped at the display edges are
validated against the active mixer ROIs?

[ ... ]
> +static u32 dcp_crtc_get_vblank_counter(struct drm_crtc *crtc)
> +{
> +	return drm_crtc_vblank_count(crtc);
> +}

[Severity: High]
Is it valid for dcp_crtc_get_vblank_counter() to return
drm_crtc_vblank_count(crtc) as the drm_crtc_funcs.get_vblank_counter callba=
ck?

drm_crtc_funcs.get_vblank_counter is called by __get_vblank_counter() in
drivers/gpu/drm/drm_vblank.c to read a raw hardware frame counter, whereas
drm_crtc_vblank_count() returns DRM core's own cooked software counter
(vblank->count).

During drm_crtc_vblank_on() -> drm_reset_vblank_timestamp() (and during
drm_crtc_handle_vblank()), store_vblank() sets vblank->last to cur_vblank (=
N)
and increments vblank->count to N + 1. On the next non-IRQ call to
drm_update_vblank_count(dev, pipe, false) (such as drm_vblank_enable() in
drm_crtc_vblank_get() or drm_vblank_disable_and_save() in
drm_crtc_vblank_off()), __get_vblank_counter() returns N + 1 while
vblank->last is N:

  if (max_vblank_count =3D=3D 0)
      drm_WARN_ON_ONCE(dev, cur_vblank !=3D vblank->last);

When max_vblank_count is 0, this immediately triggers drm_WARN_ON_ONCE();
when max_vblank_count is non-zero, it spuriously increments the software
vblank counter on every vblank enable and disable.

If DCP does not expose a hardware frame counter register, shouldn't
get_vblank_counter be omitted (left NULL in dcp_crtc_funcs)?

> +
> +static void dcp_crtc_atomic_enable(struct drm_crtc *crtc,
> +				   struct drm_atomic_commit *state)
> +{
> +	struct dcp_dpu_kms *dcp_kms =3D dcp_crtc_get_kms(crtc);
> +	struct dcp_crtc_state *cstate =3D to_dcp_crtc_state(crtc->state);
> +	u32 session_id;
> +	int ret;
> +
> +	if (!dcp_crtc_get_session(crtc, &session_id))
> +		return;
> +
> +	ret =3D dcp_hfi_crtc_set_power_mode(dcp_kms->hfi, session_id,
> +					  HFI_MODE_DPMS_ON);
> +	if (ret) {
> +		drm_err(crtc->dev, "CRTC%u: DPMS ON failed: %d\n",
> +			to_dcp_crtc(crtc)->display_id, ret);
> +		cstate->hfi_error =3D ret;
> +	}
> +
> +	drm_crtc_vblank_on(crtc);
> +}

[Severity: Medium]
If dcp_crtc_get_session() returns false in dcp_crtc_atomic_enable(), does
returning early before drm_crtc_vblank_on(crtc) unbalance the vblank refcou=
nt?

When a CRTC is initialized or disabled via drm_crtc_vblank_off(),
vblank->inmodeset is 1 and vblank->refcount is 1. Later in
msm_atomic_commit_tail(), vblank_get() checks crtc->state->active (which is
true) and calls drm_crtc_vblank_get(crtc); because drm_crtc_vblank_on() was
skipped, vblank->inmodeset is still 1, so drm_crtc_vblank_get() fails with
-EINVAL without incrementing refcount, and then vblank_put() unconditionally
calls drm_crtc_vblank_put(crtc), decrementing vblank->refcount from 1 to 0.
In addition, dcp_crtc_atomic_disable() unconditionally calls
drm_crtc_vblank_off(crtc) regardless of whether a session is present.

Should drm_crtc_vblank_on(crtc) always be called in dcp_crtc_atomic_enable()
even if dcp_crtc_get_session() fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-jshekhar-d=
cp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com?part=3D11
