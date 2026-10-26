Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019834;
	b=qWjnKCTeXUvuvnnXru69g5btaibxLSQotdIdLhjhqDfVhc5mLHIbtebobufDZBXq7bdt
	 4UuWzup3VOknaOTNchkW77KNpiZDM9CihN87Lz0epoFYtDxkMrVKY1oS7/3uwq4kuU2nP
	 DVXCOw6ItH/sCLgCZfe3hWam2zuR0q51Ct52l3VcgjUy88okQ3UgrNFdjB6FzNQswq3ME
	 fcbreQRjrYB2RvurboITlcm9s7M1vMrYYEsyQGlFgLZydTQKmZi3ru7318F1hQFycfDlX
	 QNYQDSKcwDMOYMhfpjXTZUP6r103dlI09R2hVUF0OXVVey6bj/iqJPqkZdPB4cpkDbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019834;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lYt8YO9R9qyG4BHbIQPcnr1gb3/8o9Djwz8MYYMVR2E=;
	b=vWKDHEsh5o9NfKd80H0rI3zhFBfV/7oTqy1CRZAj+05AIF5Fm2ToIZiZFA9BDE2ea1/A
	 san4XK3toG61jhdYrhN8DA6DUm94/ZPBs5ieAczv29XzZnpeg1dcPcYYy0/wIbQJ+ahtC
	 mAFdDAkjyMHWzdKD+iXkRVI3vsXRdqssJ60lxHnuvREnSE5G7dHXzA9E8ImdNMIu2+ccv
	 hugdMWudZ6Z5LQt5A0Gx8sCXFMQhnIpYNv1jrx7+X7zPJA7EbHnCvXPbEJnW4hE6gifmv
	 492hI3IZYexrXXTgUDoW1U6TUkbzC2uuZtDPd2nf19C6XMSMHciHZiU8Mt5n5Ztms3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JDdxVZBD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E85A606A325;
	Mon, 26 Oct 2026 13:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JDdxVZBD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53AEA1F01825;
	Mon, 26 Oct 2026 13:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793019833;
	bh=lYt8YO9R9qyG4BHbIQPcnr1gb3/8o9Djwz8MYYMVR2E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JDdxVZBDWd6h7+MEBXEaGAiVrWVMpAvvRYvhMcPRS8RR2DX3BhsedGOuCnlddT6aV
	 erSqrjmGDkwsDrz+WyW1WAuUKlB4cJivsJmpIa9Eo4RVPVe1q1QySdYTSfeD8a1eRp
	 H2ajCA5+Tktuz7ZK7ON7hKkTUv6IiNKz+9nXhALh6Hcx5WKK4t0k1nwpEkmw5nrqPB
	 ctOwPOglDeVgsF65SZtQvo4LQWekNPU3UT+iMJqSCIq/w7sxJtGw67Zmad7tCFYpBA
	 VEd4LKeB6Ps2rrek5ecrWlO3NJIIFGi+4XfPzpba+PGdHfgkH6fFKY8OaeGAS3A8UW
	 8I+P9N7Oq2Axw==
Message-ID: <sashiko-outbox-185263@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 16/23] drm/msm/dcp: Integrate the DSI bridge with KMS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-16-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-16-7cf014efdee1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 13:03:52 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/msm/dcp: dcp_crtc_atomic_begin() opens session on non-modese=
t commits
--

commit 9b8003ef1934260f1a1ec514fc980b7068b0a204
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

drm/msm/dcp: Integrate the DSI bridge with KMS

This commit connects the DCP DSI bridge to the DCP KMS pipeline by adding
helpers to prepare the CRTC display session during atomic_begin and check
whether planes require dirtyfb updates during atomic_check.

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_crtc.c b/drivers/gpu/drm/msm/dcp=
/dcp_crtc.c
> index ec4f74c2920f8..173a07df71c5f 100644
> --- a/drivers/gpu/drm/msm/dcp/dcp_crtc.c
> +++ b/drivers/gpu/drm/msm/dcp/dcp_crtc.c
> @@ -147,6 +147,12 @@ static void dcp_crtc_atomic_begin(struct drm_crtc *c=
rtc,
>  		return;
>  	}
> =20
> +	ret =3D dcp_dpu_kms_prepare_crtc_session(dcp_kms, crtc);
> +	if (ret) {
> +		cstate->hfi_error =3D ret;
> +		return;
> +	}

[Severity: Medium]
Should dcp_dpu_kms_prepare_crtc_session() only open a new session when
drm_atomic_crtc_needs_modeset(crtc->state) is true, or can calling it
unconditionally in dcp_crtc_atomic_begin() leave the session partially
initialized on non-modeset commits?

In msm_atomic_commit_tail(), drm_atomic_helper_commit_planes() (which calls
dcp_crtc_atomic_begin()) runs before drm_atomic_helper_commit_modeset_enabl=
es()
(which calls dcp_crtc_atomic_enable(), dcp_dsi_bridge_atomic_pre_enable(), =
and
dcp_dsi_bridge_atomic_enable(), and only runs when
drm_atomic_crtc_needs_modeset(crtc->state) is true).

If an initial modeset commit fails in dcp_dsi_bridge_prepare_session() or in
dcp_dsi_bridge_atomic_enable():

drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.c:dcp_dsi_bridge_atomic_enable() {
	...
	ret =3D dcp_hfi_display_post_enable(kms->hfi, dsi_bridge->session_id);
	if (ret) {
		drm_err(bridge->dev,
			"DSI%u: HFI DISPLAY_POST_ENABLE failed: %d\n",
			dsi_bridge->intf_idx, ret);
		goto err_close;
	}
	...
err_close:
	dcp_hfi_clear_power_control_cb(kms->hfi, kms);
	dcp_hfi_display_close(kms->hfi, dsi_bridge->session_id);
	dsi_bridge->session_id   =3D 0;
	dsi_bridge->session_open =3D false;
	dcp_dsi_bridge_clear_session(dsi_bridge);
}

the session is closed and dsi_bridge->session_open is reset to false, while
crtc->state->active remains true.

On the next non-modeset plane update or pageflip where
drm_atomic_crtc_needs_modeset(crtc->state) is false,
dcp_crtc_atomic_begin() -> dcp_dpu_kms_prepare_crtc_session() ->
dcp_dsi_bridge_prepare_session() sees !dsi_bridge->session_open, opens a new
HFI session, sets dsi_bridge->session_open =3D true, and publishes session_=
id to
the CRTC:

drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.c:dcp_dsi_bridge_prepare_session() {
	...
	dsi_bridge->session_id   =3D opened_session_id;
	dsi_bridge->session_open =3D true;
	dcp_dsi_bridge_publish_session(dsi_bridge);
	...
}

Because drm_atomic_helper_commit_modeset_enables() skips the CRTC and bridge
enable callbacks on a non-modeset commit, dcp_crtc_atomic_enable() and
dcp_dsi_bridge_atomic_enable() never run, skipping HFI_MODE_DPMS_ON,
drm_crtc_vblank_on(), panel bridge enable, HFI_COMMAND_DISPLAY_POST_ENABLE,
and HFI_EVENT_FRAME_SCAN_COMPLETE registration.

When dcp_crtc_commit_kickoff() then submits frame triggers for that session,
dcp_crtc_wait_for_commit_done() will wait on frame_done_wq for an event that
was never registered and time out after 500ms on every subsequent commit:

drivers/gpu/drm/msm/dcp/dcp_crtc.c:dcp_crtc_wait_for_commit_done() {
	...
	if (!wait_event_timeout(dcp_crtc->frame_done_wq,
				atomic_read(&dcp_crtc->pending_kickoff_cnt) =3D=3D 0,
				timeout)) {
		drm_err(crtc->dev,
			"frame done timeout for CRTC%u\n",
			dcp_crtc->display_id);
		atomic_set(&dcp_crtc->pending_kickoff_cnt, 0);
	}
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-jshekhar-d=
cp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com?part=3D16
