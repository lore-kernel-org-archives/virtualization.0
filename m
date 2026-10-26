Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018245;
	b=OjpDhRQhlcWLNXpMsFSELKwP1quFWSnVLrAoFl8fFAjjfckjtaTexnPUgzVMN2ngghyl
	 9cn5SGV7bJ2o7aqSipLhIEJntjT4ZFiR3Mywk5OHPnTE2InQW9g64GN4X1QZvwS4mimBU
	 Y4aDunXGs2JDFb3nUAX2b80FFPgSgriQrsEEDPOLpBC6KpqNvbB31M5UL5zl3ardSIj8B
	 Is8x0ISt0kHg0Zpk28KXItlo6lBjjLlbUZT0f4AHlFxA0wrR6OhjOG8bzVea1m5MnaOOw
	 etmZU9dwXfmOgg0j6SYwDcuriqSnFO387X47lFMPexqVzdpbqLaF3JFBm8uz6v6dmsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018245;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xNgq6Dsm4/lWXxJQ7Wxik0MGI5HVe28AGH30Wx2BvvE=;
	b=LS9RUzsBJ5VFg3bpFF8PF8pIltXhAwdp1vzzpOfUb5ZdNgVOPYD92qmrz2xhrhlYDzj5
	 ejDl7T13sFEgLcmKmsv9ZMnBeJ/W+0II6mhytMiJKxpzSjIHhwQYY7ri+4bsYNj4MDbqu
	 C0C8be1OuoyXQeYTD2tSEOEESTZcTeRD/WU+xD3+PEkM6mip8c884VEi08EkxMYkWWKeu
	 VpTkotrlgyoDQ0XUaRGFj9HS0s8CMD+aDT0te2LqIPO97zrkte79Qw10xJeLJDnZ6GFft
	 ByYrWSHs2Uj5TUkzC2nUfL1JjI3APVquJRPEYVFjaa2U3DzXucXTa7UNGFsTbcvy2Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YKgdbjy+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49267606A324;
	Mon, 26 Oct 2026 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YKgdbjy+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867041F01828;
	Mon, 26 Oct 2026 12:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793018245;
	bh=xNgq6Dsm4/lWXxJQ7Wxik0MGI5HVe28AGH30Wx2BvvE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YKgdbjy+CLs84ZuMiSmqalfmf9GZtJS6lAXprGDOiWRLU7+jqmvvFk3VKBlJaAKvi
	 u0aUpHz4H4SxIbo73uyblvAkBIzYsC/83YFbgetCZLxOQU2VBdxFi+MFEGPevkgJKE
	 v6pWMYopSCJxJg4pezmhrLwrefDivU+QNrc64tp+ojr/QMa7FLOYo3FgkWyIf/ww51
	 qoBEAbmz2iCWMRiW6H4M5oasrosGnh9qELxX5sS1TgG0x52MzZtJHxIcFqymC5ykGa
	 OWVQ6zW9yPRZFEovAEWlAxWDdIN6T20x6ia4mdNubWrn49bTLzdpsS8AkhDl04UlAZ
	 EMz7dINzHfENw==
Message-ID: <sashiko-outbox-185222@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/23] drm/msm/dcp: Add DCP DSI host and panel
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-15-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-15-7cf014efdee1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 12:37:24 +0000
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
- [High] drm/msm/dcp: off-by-one DSC chroma and color space enums in dcp_ds=
i_host_attach()
- [High] drm/msm/dcp: deadlock and unsafe teardown in dcp_dsi_bridge_cleanu=
p()
- [Medium] drm/msm/dcp: OF node leak of dcp_np on error in dcp_dsi_bridge_i=
nit()
- [Medium] drm/msm/dcp: dcp_dsi_bridge_setup_dsc() never sets dsc_rc_overri=
de
- [Medium] drm/msm/dcp: duplicate dsi_host_dev name in dcp_dsi_bridge_init()
- [Medium] drm/msm/dcp: invalid session close and goto mixing in dcp_dsi_br=
idge_prepare_session()
- [Medium] drm/msm/dcp: missing session_lock in dcp_dsi_bridge_atomic_enabl=
e()
- [Medium] drm/msm/dcp: unsynchronized session_id and packet_id in power co=
ntrol
- [Medium] drm/msm/dcp: firmware session leak on dcp_hfi_display_close() ea=
rly return
- [Medium] drm/msm/dcp: wrong byte count returned for DSI reads in dcp_dsi_=
host_transfer()
--

commit 7535bc53c50473e4189f52c83b74358ab514c8d0
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

drm/msm/dcp: Add DCP DSI host and panel support

This commit implements the MIPI DSI host, panel-device support, bridge
state, DSC configuration, DCS transfers, and DSI buffer management for the
DCP display path.

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.c b/drivers/gpu/drm/m=
sm/dcp/dcp_dsi_bridge.c
> new file mode 100644
> index 0000000000000..b3e782b8f0470
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.c
> @@ -0,0 +1,1110 @@

[ ... ]

> +static void dcp_dsi_power_control_work(struct work_struct *work)
> +{
> +	struct dcp_dsi_bridge *dsi_bridge =3D
> +		container_of(work, struct dcp_dsi_bridge, power_control_work);
> +	struct dcp_dpu_kms *kms =3D dsi_bridge->kms;
> +
> +	dcp_hfi_display_power_control_ack(kms->hfi,
> +					  dsi_bridge->session_id,
> +					  dsi_bridge->power_packet_id);
> +
> +	complete(&dsi_bridge->power_done);
> +}
> +
> +static void dcp_dsi_power_control_cb(void *priv, u32 display_id,
> +				     u32 power_mask, bool enable,
> +				     u32 packet_id)
> +{
> +	struct dcp_dpu_kms *kms =3D priv;
> +	struct dcp_dsi_bridge *dsi_bridge =3D NULL;
> +	int idx;
> +
> +	for (idx =3D 0; idx < ARRAY_SIZE(kms->dsi_bridge); idx++) {
> +		struct dcp_dsi_bridge *b =3D kms->dsi_bridge[idx];
> +
> +		if (b && b->session_id =3D=3D display_id) {
> +			dsi_bridge =3D b;
> +			break;
> +		}
> +	}
> +
> +	if (!dsi_bridge) {
> +		dev_warn(kms->pm_dev,
> +			 "DSI: power_control for unknown display_id=3D%u\n", display_id);
> +		return;
> +	}
> +
> +	dsi_bridge->power_packet_id =3D packet_id;
> +	schedule_work(&dsi_bridge->power_control_work);
> +}

[Severity: Medium]
Are dsi_bridge->session_id and dsi_bridge->power_packet_id synchronized and
matched safely between dcp_dsi_power_control_cb() and
dcp_dsi_power_control_work()?

When dcp_hfi_dispatch_event() drops resp_drain_lock and invokes
dcp_dsi_power_control_cb(), the loop checks b->session_id =3D=3D display_id
without checking b->session_open or holding session_lock. Since closed
bridges have session_id =3D=3D 0, an unopened bridge matches when
display_id =3D=3D 0, whereas a temporary session opened in
dcp_dsi_host_transfer() stores its session ID in a local variable and
leaves dsi_bridge->session_id =3D=3D 0, failing to match a non-zero
display_id.

Furthermore, dcp_dsi_power_control_work() reads dsi_bridge->session_id and
dsi_bridge->power_packet_id without locking while
dcp_dsi_bridge_atomic_post_disable(), dcp_dsi_bridge_atomic_enable(), and
dcp_dsi_bridge_prepare_session() reset dsi_bridge->session_id =3D 0 without
flushing power_control_work. And in dcp_dsi_bridge_cleanup(),
dcp_hfi_clear_power_control_cb() does not wait for an in-flight callback
that already dropped resp_drain_lock, allowing
schedule_work(&dsi_bridge->power_control_work) to run after
cancel_work_sync().

[ ... ]

> +static int dcp_dsi_host_attach(struct mipi_dsi_host *host,
> +			       struct mipi_dsi_device *dsi)
> +{
> +	struct dcp_dsi_bridge *dsi_bridge =3D to_dcp_dsi_host(host);
> +	struct dcp_dsi_hfi_panel_config *cfg =3D &dsi_bridge->hfi_panel_config;
> +	int ret;

[ ... ]

> +	if (dsi->dsc) {
> +		struct drm_dsc_config *dsc =3D dsi->dsc;
> +		u32 chroma_format =3D 0;
> +		u32 color_space =3D 0;
> +
> +		if (dsc->native_422)
> +			chroma_format =3D 1;
> +		else if (dsc->native_420)
> +			chroma_format =3D 2;
> +		if (dsc->native_422 || dsc->native_420)
> +			color_space =3D 1;
> +
> +		cfg->dsc_enabled                 =3D true;
> +		cfg->dsc_version_major           =3D dsc->dsc_version_major;
> +		cfg->dsc_version_minor           =3D dsc->dsc_version_minor;
> +		cfg->dsc_scr_version              =3D 0;
> +		cfg->dsc_slice_height             =3D dsc->slice_height;
> +		cfg->dsc_slice_width              =3D dsc->slice_width;
> +		cfg->dsc_slices_per_pkt           =3D 1;
> +		cfg->dsc_bits_per_component       =3D dsc->bits_per_component;
> +		cfg->dsc_pps_delay_ms             =3D 0;
> +		cfg->dsc_bits_per_pixel           =3D dsc->bits_per_pixel;
> +		cfg->dsc_chroma_format            =3D chroma_format;
> +		cfg->dsc_color_space              =3D color_space;

[Severity: High]
Are chroma_format and color_space off by one here?

In drivers/gpu/drm/msm/dcp/hfi/hfi_defs_panel.h, the HFI protocol enums
packed into HFI_PROPERTY_PANEL_COMPRESSION_DATA by dcp_hfi_panel_init() are
1-based:

enum hfi_panel_chroma_format_type {
	HFI_PANEL_CHROMA_FORMAT_444     =3D 1,
	HFI_PANEL_CHROMA_FORMAT_422     =3D 2,
	HFI_PANEL_CHROMA_FORMAT_420     =3D 3,
};

enum hfi_panel_color_space_type {
	HFI_PANEL_COLOR_SPACE_RGB     =3D 1,
	HFI_PANEL_COLOR_SPACE_YUV     =3D 2,
};

Should dcp_dsi_host_attach() use the HFI_PANEL_CHROMA_FORMAT_* and
HFI_PANEL_COLOR_SPACE_* constants instead of 0-based values?

[ ... ]

> +static ssize_t dcp_dsi_host_transfer(struct mipi_dsi_host *host,
> +				     const struct mipi_dsi_msg *msg)
> +{
> +	struct dcp_dsi_bridge *dsi_bridge =3D to_dcp_dsi_host(host);
> +	struct dcp_dpu_kms *kms =3D dsi_bridge->kms;
> +	u32 session_id;
> +	bool temporary_session =3D false;
> +	ssize_t ret;
> +
> +	guard(mutex)(&dsi_bridge->session_lock);
> +	if (!dsi_bridge->dcs_tx_buf)
> +		return -ENODEV;
> +
> +	/* Serialize DCS transfers */
> +	guard(mutex)(&dsi_bridge->dcs_lock);
> +
> +	if (dsi_bridge->session_open) {
> +		session_id =3D dsi_bridge->session_id;
> +	} else {
> +		/*
> +		 * mipi_dsi_host_ops::transfer() may be called while the host is
> +		 * disabled. Open a transaction-only DCP session in that case;
> +		 * atomic_pre_enable() will create the full display session later.
> +		 */
> +		ret =3D dcp_hfi_display_enable(kms->hfi, dsi_bridge->intf_idx,
> +					     dsi_bridge->fw_display_id,
> +					     &session_id);
> +		if (ret)
> +			return ret;
> +
> +		temporary_session =3D true;
> +	}
> +
> +	ret =3D dcp_hfi_dcs_transfer(kms->hfi, session_id, msg,
> +				   dsi_bridge->dcs_tx_buf, dsi_bridge->dcs_tx_iova,
> +				   dsi_bridge->dcs_rx_buf, dsi_bridge->dcs_rx_iova, 0,
> +				   dsi_bridge->hfi_panel_config.ctrl_indices[0]);

[Severity: Medium]
Does dcp_dsi_host_transfer() return the wrong byte count for DSI read
transfers and reject 0-parameter generic transfers?

In drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_panel.c, dcp_hfi_dcs_transfer() ends
with:

	if (msg->rx_len > 0)
		memcpy(msg->rx_buf, rx_buf, msg->rx_len);

	return msg->tx_len;

and rejects msg->tx_len =3D=3D 0 at entry with -EINVAL.

For mipi_dsi_host_ops::transfer(), callers such as mipi_dsi_dcs_read() and
mipi_dsi_generic_read() expect the number of received bytes (msg->rx_len)
on read transfers, and 0-parameter generic transfers
(MIPI_DSI_GENERIC_SHORT_WRITE_0_PARAM and
MIPI_DSI_GENERIC_READ_REQUEST_0_PARAM) have msg->tx_len =3D=3D 0.

> +	if (temporary_session) {
> +		int close_ret =3D dcp_hfi_display_close(kms->hfi, session_id);
> +
> +		if (ret >=3D 0 && close_ret)
> +			ret =3D close_ret;
> +	}

[Severity: Medium]
Can calling dcp_hfi_display_close() here (and on the err_close path in
dcp_dsi_bridge_atomic_enable()) leak the firmware display session if
DISPLAY_DISABLE or DISPLAY_POST_DISABLE fails?

In drivers/gpu/drm/msm/dcp/dcp_hfi_dsi.c, dcp_hfi_display_close() returns
early before sending HFI_COMMAND_DISPLAY_CLOSE if either
dcp_hfi_display_disable() or dcp_hfi_display_post_disable() returns an
error:

int dcp_hfi_display_close(struct dcp_hfi *hfi, u32 session_id)
{
	int ret;

	ret =3D dcp_hfi_display_disable(hfi, session_id);
	if (ret) {
		dev_warn(hfi->dev, "HFI DISPLAY_DISABLE failed: %d\n", ret);
		return ret;
	}

	ret =3D dcp_hfi_display_post_disable(hfi, session_id);
	if (ret) {
		dev_warn(hfi->dev, "HFI DISPLAY_POST_DISABLE failed: %d\n", ret);
		return ret;
	}

When closing a temporary session in dcp_dsi_host_transfer() (which only
called dcp_hfi_display_enable() and never called
dcp_hfi_display_post_enable()) or rolling back a partially enabled session
in dcp_dsi_bridge_atomic_enable(), an error from DISPLAY_DISABLE or
DISPLAY_POST_DISABLE skips HFI_COMMAND_DISPLAY_CLOSE while the driver drops
session_id and marks session_open =3D false. In contrast,
dcp_dsi_bridge_atomic_disable() and dcp_dsi_bridge_atomic_post_disable()
still send HFI_COMMAND_DISPLAY_CLOSE even if the preceding disable commands
warn.

[ ... ]

> +static int dcp_dsi_bridge_setup_dsc(struct dcp_dsi_bridge *dsi_bridge,
> +				    struct dcp_dsi_hfi_panel_config *cfg,
> +				    const struct drm_display_mode *mode)
> +{

[ ... ]

> +	for (i =3D 0; i < ARRAY_SIZE(cfg->dsc_rc_min_qp); i++) {
> +		cfg->dsc_rc_min_qp[i] =3D dsc->rc_range_params[i].range_min_qp;
> +		cfg->dsc_rc_max_qp[i] =3D dsc->rc_range_params[i].range_max_qp;
> +		cfg->dsc_rc_bpg_offsets[i] =3D dsc->rc_range_params[i].range_bpg_offse=
t;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Should dcp_dsi_bridge_setup_dsc() also set cfg->dsc_rc_override =3D true?

dcp_dsi_host_attach() initializes cfg->dsc_rc_override =3D false, and
dcp_dsi_bridge_prepare_session() passes a stack-local copy of cfg to
dcp_dsi_bridge_setup_dsc() and then to dcp_hfi_panel_init(). In
drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_panel.c, dcp_hfi_panel_init() only packs
HFI_PROPERTY_PANEL_COMPRESSION_RC_OVERRIDE when
(cfg->dsc_enabled && cfg->dsc_rc_override) is true, so the rate-control
parameters populated in cfg->dsc_rc_min_qp, cfg->dsc_rc_max_qp, and
cfg->dsc_rc_bpg_offsets are never sent to the firmware.

> +
> +int dcp_dsi_bridge_prepare_session(struct dcp_dsi_bridge *dsi_bridge,
> +				   const struct drm_display_mode *mode)
> +{
> +	struct dcp_dpu_kms *kms =3D dsi_bridge->kms;
> +	struct dcp_dsi_bridge_state *state =3D dcp_dsi_bridge_get_state(dsi_bri=
dge);
> +	struct dcp_dsi_hfi_panel_config cfg;
> +	int ret;
> +	u32 opened_session_id;
> +
> +	if (!mode)
> +		return -ENODEV;
> +
> +	guard(mutex)(&dsi_bridge->session_lock);
> +	if (dsi_bridge->session_open)
> +		return 0;
> +
> +	dsi_bridge->session_id =3D dsi_bridge->fw_display_id;
> +
> +	if (!dsi_bridge->dsi_device)
> +		return -ENODEV;

[ ... ]

> +	ret =3D dcp_hfi_display_enable(kms->hfi,
> +				     dsi_bridge->intf_idx,
> +				     dsi_bridge->fw_display_id,
> +				     &opened_session_id);
> +	if (ret) {
> +		drm_err(kms->dev, "DSI%u: HFI DISPLAY_ENABLE failed: %d\n",
> +			dsi_bridge->intf_idx, ret);
> +		goto err_close;
> +	}
> +	dsi_bridge->session_id   =3D opened_session_id;
> +	dsi_bridge->session_open =3D true;
> +	dcp_dsi_bridge_publish_session(dsi_bridge);
> +
> +	drm_dbg_driver(kms->dev, "DSI%u: session prepared (session_id=3D%u)\n",
> +		       dsi_bridge->intf_idx, dsi_bridge->session_id);
> +	return 0;
> +
> +err_close:
> +	dcp_hfi_clear_power_control_cb(kms->hfi, kms);
> +	dcp_hfi_display_close(kms->hfi, dsi_bridge->session_id);
> +	dsi_bridge->session_id   =3D 0;
> +	dsi_bridge->session_open =3D false;
> +	dcp_dsi_bridge_clear_session(dsi_bridge);
> +
> +	return ret;
> +}

[Severity: Medium]
There appear to be several issues with error handling and cleanup in
dcp_dsi_bridge_prepare_session():

1. It mixes guard(mutex)(&dsi_bridge->session_lock) with goto err_close,
   contrary to the cleanup.h guideline not to mix goto error paths and
   scope-based cleanup helpers in the same function.

2. If !dsi_bridge->dsi_device is true, returning -ENODEV early leaves
   dsi_bridge->session_id set to dsi_bridge->fw_display_id while
   session_open is false.

3. Every goto err_close path triggers before dcp_hfi_display_enable() has
   succeeded (even if dcp_dsi_bridge_setup_dsc() fails in software before
   any HFI command is sent), yet err_close calls dcp_hfi_display_close() to
   send DISPLAY_DISABLE, DISPLAY_POST_DISABLE, and DISPLAY_CLOSE for a
   session that was never enabled.

4. Calling dcp_hfi_clear_power_control_cb(kms->hfi, kms) in err_close clears
   the single shared power control callback on kms->hfi for all DSI bridges
   in kms->dsi_bridge[].

> +
> +static void dcp_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
> +					     struct drm_atomic_commit *state)
> +{
> +	struct dcp_dsi_bridge *dsi_bridge =3D to_dcp_dsi_bridge(bridge);
> +	int ret;
> +
> +	ret =3D dsi_bridge->session_open ? 0 : -ENODEV;
> +	dcp_dsi_bridge_get_state(dsi_bridge)->prepare_error =3D ret;
> +	if (ret)
> +		drm_err(bridge->dev, "DSI%u: session prepare failed: %d\n",
> +			dsi_bridge->intf_idx, ret);
> +}
> +
> +static void dcp_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
> +					 struct drm_atomic_commit *state)
> +{
> +	struct dcp_dsi_bridge *dsi_bridge =3D to_dcp_dsi_bridge(bridge);
> +	struct dcp_dpu_kms *kms =3D dsi_bridge->kms;
> +	bool scan_start_registered =3D false;
> +	bool scan_complete_registered =3D false;
> +	bool autorefresh_enabled =3D false;
> +	int ret;
> +
> +	drm_dbg_driver(kms->dev,
> +		       "DSI%u: bridge atomic_enable (session_id=3D%u)\n",
> +		       dsi_bridge->intf_idx, dsi_bridge->session_id);
> +
> +	if (dcp_dsi_bridge_get_state(dsi_bridge)->prepare_error)
> +		return;
> +	if (!dsi_bridge->session_open)
> +		return;
> +
> +	ret =3D dcp_hfi_display_post_enable(kms->hfi, dsi_bridge->session_id);

[ ... ]

> +err_close:
> +	if (autorefresh_enabled)
> +		dcp_hfi_crtc_set_autorefresh(kms->hfi, dsi_bridge->session_id,
> +					     false, 0);
> +	if (scan_complete_registered)
> +		dcp_hfi_display_event_deregister(kms->hfi, dsi_bridge->session_id,
> +						 HFI_EVENT_FRAME_SCAN_COMPLETE);
> +	if (scan_start_registered)
> +		dcp_hfi_display_event_deregister(kms->hfi, dsi_bridge->session_id,
> +						 HFI_EVENT_FRAME_SCAN_START);
> +	drm_err(bridge->dev,
> +		"DSI%u: bridge enable failed; session closed\n",
> +		dsi_bridge->intf_idx);
> +	dcp_hfi_display_close(kms->hfi, dsi_bridge->session_id);
> +	{
> +		guard(mutex)(&dsi_bridge->session_lock);
> +		dsi_bridge->session_id   =3D 0;
> +		dsi_bridge->session_open =3D false;
> +	}
> +	dcp_dsi_bridge_clear_session(dsi_bridge);
> +}

[Severity: Medium]
Should dcp_dsi_bridge_atomic_enable() (and dcp_dsi_bridge_atomic_pre_enable=
())
hold dsi_bridge->session_lock across the session operations rather than only
around clearing session_id and session_open at the end of err_close?

In addition to mixing goto err_close with guard(mutex), reading
dsi_bridge->session_open and dsi_bridge->session_id and calling
dcp_hfi_display_close() without holding session_lock allows a concurrent
dcp_dsi_host_transfer() call to observe session_open =3D=3D true and send D=
CS
commands on a session ID that is actively being closed or has already been
closed in firmware.

[ ... ]

> +struct drm_bridge *dcp_dsi_bridge_init(struct dcp_dpu_kms *kms,
> +				       struct device_node *np,
> +				       struct device_node *dcp_np,
> +				       u32 dcp_port, u32 intf_idx,
> +				       u32 fw_display_id)
> +{
> +	struct dcp_dsi_bridge *dsi_bridge;
> +	struct dcp_dsi_hfi_panel_config *cfg;
> +	struct device *dev =3D kms->pm_dev;
> +	struct device *dma_dev =3D kms->hfi->dma_dev;
> +	int ret;
> +
> +	dsi_bridge =3D devm_drm_bridge_alloc(dev, struct dcp_dsi_bridge,
> +					   bridge, &dcp_dsi_bridge_funcs);
> +	if (IS_ERR(dsi_bridge))
> +		return ERR_CAST(dsi_bridge);
> +
> +	dsi_bridge->dcp_np        =3D of_node_get(dcp_np);

[ ... ]

> +	device_initialize(&dsi_bridge->dsi_host_dev);
> +	dsi_bridge->dsi_host_dev.release =3D dcp_dsi_host_dev_release;
> +	dsi_bridge->dsi_host_dev.parent  =3D dev;
> +	dsi_bridge->dsi_host_dev.of_node =3D of_node_get(np);
> +	dev_set_name(&dsi_bridge->dsi_host_dev, "%pOFn", np);
> +	dsi_bridge->dsi_host.ops =3D &dcp_dsi_host_ops;
> +	dsi_bridge->dsi_host.dev =3D &dsi_bridge->dsi_host_dev;
> +
> +	ret =3D device_add(&dsi_bridge->dsi_host_dev);

[Severity: Medium]
Won't dev_set_name(&dsi_bridge->dsi_host_dev, "%pOFn", np) cause a device
name collision in device_add() when two DSI bridges are present?

The %pOFn specifier strips the @unit-address suffix from the node name, so
both dsi@0 and dsi@1 receive the name "dsi" under the same parent device
(kms->pm_dev), causing the second device_add() to fail with -EEXIST.

[ ... ]

> +err_unwind_dma:
> +	if (dsi_bridge->dcs_rx_buf) {
> +		dma_free_coherent(dma_dev, DCP_DSI_DCS_RX_BUF_SIZE,
> +				  dsi_bridge->dcs_rx_buf,
> +				  dsi_bridge->dcs_rx_iova);
> +	}
> +	if (dsi_bridge->dcs_tx_buf) {
> +		dma_free_coherent(dma_dev, DCP_DSI_DCS_TX_BUF_SIZE,
> +				  dsi_bridge->dcs_tx_buf,
> +				  dsi_bridge->dcs_tx_iova);
> +	}
> +	cancel_work_sync(&dsi_bridge->power_control_work);
> +	mutex_destroy(&dsi_bridge->session_lock);
> +	mutex_destroy(&dsi_bridge->dcs_lock);
> +	return ERR_PTR(ret);
> +}

[Severity: Medium]
Does the err_unwind_dma path in dcp_dsi_bridge_init() leak the
dsi_bridge->dcp_np device_node reference acquired via of_node_get(dcp_np) if
dma_alloc_coherent(), device_add(), or mipi_dsi_host_register() fails?

[ ... ]

> +void dcp_dsi_bridge_cleanup(struct dcp_dsi_bridge *dsi_bridge)
> +{
> +	struct device *dma_dev =3D dsi_bridge->kms->hfi->dma_dev;
> +
> +	dcp_hfi_clear_power_control_cb(dsi_bridge->kms->hfi, dsi_bridge->kms);
> +	cancel_work_sync(&dsi_bridge->power_control_work);
> +
> +	drm_bridge_remove(&dsi_bridge->bridge);
> +	of_node_put(dsi_bridge->bridge.of_node);
> +	of_node_put(dsi_bridge->dcp_np);
> +
> +	mipi_dsi_host_unregister(&dsi_bridge->dsi_host);
> +	device_del(&dsi_bridge->dsi_host_dev);
> +	put_device(&dsi_bridge->dsi_host_dev);
> +
> +	dcp_dsi_bridge_unmap_buffers(dsi_bridge);
> +	dma_free_coherent(dma_dev, DCP_DSI_DCS_TX_BUF_SIZE,
> +			  dsi_bridge->dcs_tx_buf, dsi_bridge->dcs_tx_iova);
> +
> +	dma_free_coherent(dma_dev, DCP_DSI_DCS_RX_BUF_SIZE,
> +			  dsi_bridge->dcs_rx_buf, dsi_bridge->dcs_rx_iova);
> +
> +	mutex_destroy(&dsi_bridge->session_lock);
> +	mutex_destroy(&dsi_bridge->dcs_lock);
> +}

[Severity: High]
Can calling mipi_dsi_host_unregister() from dcp_dsi_bridge_cleanup()
deadlock on component_mutex and trigger use-after-free during teardown?

1. When a DSI device is attached, mipi_dsi_host_unregister() removes the
   child device and invokes:

   mipi_dsi_remove_device_fn()
     -> mipi_dsi_detach()
       -> dcp_dsi_host_detach()
         -> component_del(&dsi_bridge->dsi_host_dev, &dcp_dsi_component_ops)

   component_del() acquires the global component_mutex. When
   dcp_dsi_bridge_cleanup() is called from aggregate device bringup failure
   or aggregate device takedown (for example via component_master_del() /
   take_down_aggregate_device() -> msm_drm_unbind() -> msm_drm_uninit() ->
   dcp_dpu_kms_destroy()), component_mutex is already held by the caller,
   causing a recursive deadlock.

2. struct dcp_dsi_bridge is allocated with devm_drm_bridge_alloc() on
   kms->pm_dev and embeds struct device dsi_host_dev, which is refcounted
   independently. Calling device_del() and put_device() on dsi_host_dev
   during kms->destroy() happens before component_unbind_all() finishes
   using component->dev (&dsi_bridge->dsi_host_dev). In addition,
   dcs_tx_buf and dcs_rx_buf are freed without holding session_lock/dcs_lock
   or clearing dsi_bridge->dcs_tx_buf to NULL, and session_lock and dcs_lock
   are destroyed while the bridge object is still alive.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-jshekhar-d=
cp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com?part=3D15
