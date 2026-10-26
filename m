Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016534;
	b=DG3uqZOJIt4uR4qAFqG4qgl9VieRhZ+GkYkH2Loboz8A3Aa7XNZs0GEYT3jlVpxVijXK
	 GfeCBCnXT4aGI9rgAdQx3DAppYqRHrsExuQgbzudO4T52TAxERLJnelIBlHcK4HMVLnXO
	 3hM9SBPQDRI4FFOHoE8V+yaFgiCwuGz+hnseEejBTx/+jA2/xdqNtSqY3OwJ+6HYrLa93
	 kbm1L2kQqXzOTlAax7SmIAJ758VvNw1V7Xr3FcvaQFOOMNMpOg9fOTlHzOjaPVkb9BDzP
	 M+1XKDTZGCHKcDt+OuSyrFLL8w1da136X8D7OYkFU63ptHyq633+woD3mSrMJOZlZiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016534;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PVrArIqPHEcxOvnEp/glTCqEMsmJUryy06DXyxH7+N8=;
	b=NdJgY5HpCvEWGPCEFRF8Ca/srSajPnYGCo8A6mWRpa1fViTs+uSlYdJCCP7velRApG68
	 UsTK4kajDizvgpyXTFb4n0EjXu+zsuuaYJJguc65KW0zArMdm8Ta+sFoBo1B+foLuxHMz
	 qswQj9dwqVtZ/5dtV6M38kR9wkLzNpwzLBffB1jqpv9DT11rDNz+JesdO5bONCiNoL3RR
	 TFEFgrkIS1qFPTw1HQWhLlRPB8OOv7e+JwPCeDyqTkzW8sCs7+2dJWV/HBA5h6j2a9zHV
	 dJAxzIZGpVdDMo/FOFpMRJHqllP8uEzHEggSqzS4S8M3YX+biEcevmklzr/Q87OCDhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JEwtPF3y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F96606A31A;
	Mon, 26 Oct 2026 12:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JEwtPF3y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5791F01825;
	Mon, 26 Oct 2026 12:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793016533;
	bh=PVrArIqPHEcxOvnEp/glTCqEMsmJUryy06DXyxH7+N8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JEwtPF3yXEQHvNrvwyAgfSqt85qlH91/noZCtusd7scOJ4Al5tylcfh7oxGO0hBrK
	 uz0zWrSsVITUPkQi1VEekAyH8qn/LevUfwDFrUM/nT7bq64rqIpF3J5c8UExHenWKn
	 8dMJj4+SNqI2M8fo+yQpa5HJhC88tcxz7uVCIyFi9v6Wpw1BiMu5E3j7MtuGQu9/5K
	 14FHCreEExk1rQFU2bGkl5+R+K4JNKFL823dlZ3yq/e5gdSUOyswjPmIlxSWVjZThD
	 I9WQ+AvyikucIv7VJXntCGBCbTc19K1fsZ49yFMnpCMVXE8aqSy9+rVy2wmwEZICT1
	 tA9ItSAotjG3g==
Message-ID: <sashiko-outbox-185169@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/23] drm/msm/dcp: Route HFI display events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-13-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-13-7cf014efdee1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 12:08:52 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/msm/dcp: unsynchronized frame done state in dcp_crtc_hfi_frame=
_done_cb()
- [Medium] drm/msm/dcp: missing payload validation in dcp_hfi_dispatch_fram=
e_done()
--

commit 7606ba3e12102c6ab2bc26f57c18f121dc3e91f7
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

drm/msm/dcp: Route HFI display events

This commit routes asynchronous HFI VSYNC and frame-scan completion display
events from DCP firmware to the corresponding DRM CRTC callbacks, and adds a
NULL check for dma_dev in dcp_hfi_init().

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c b/drivers/gpu/drm/msm=
/dcp/dcp_hfi_core.c
> index 774a5afac0f0a..e54ccfafdae0f 100644
> --- a/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c
> +++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c
> @@ -19,6 +19,7 @@
>  #include "dcp_hfi.h"
>  #include "dcp_hfi_priv.h"
>  #include "dcp_drv.h"
> +#include "dcp_crtc.h"
>  #include "hfi/hfi_packet.h"
>  #include "hfi/hfi_packer.h"
>  #include "hfi/hfi_unpacker.h"
> @@ -260,18 +261,35 @@ static void dcp_hfi_store_caps_payload(struct dcp_h=
fi *hfi,
>  	dev_dbg(hfi->dev, "%s: stored %u bytes\n", name, n);
>  }
> =20
> +static void dcp_hfi_dispatch_frame_done(struct dcp_hfi *hfi,
> +					const struct hfi_packet_info *pkt_info)
> +{
> +	const struct hfi_display_frame_event_data *frame =3D NULL;
> +	u32 sequence_id =3D 0;
> +
> +	if (pkt_info->payload_ptr &&
> +	    pkt_info->payload_size >=3D sizeof(*frame)) {
> +		frame =3D pkt_info->payload_ptr;
> +		sequence_id =3D frame->bufferflip_index;
> +	}
> +	dcp_crtc_hfi_frame_done_cb(hfi->drv, pkt_info->id & 0xFFFF,
> +				   sequence_id);
> +}

[Severity: Medium]
Should dcp_hfi_dispatch_frame_done() drop the packet and return early when
pkt_info->payload_ptr is NULL or pkt_info->payload_size is smaller than
sizeof(*frame)?

As written, a truncated or empty HFI_COMMAND_DISPLAY_EVENT_FRAME_SCAN_COMPL=
ETE
packet falls through and invokes dcp_crtc_hfi_frame_done_cb() with a
fabricated sequence_id of 0:

drivers/gpu/drm/msm/dcp/dcp_crtc.c:dcp_crtc_hfi_frame_done_cb() {
	...
	if (crtc) {
		struct dcp_crtc *dcp_crtc =3D to_dcp_crtc(crtc);

		/* A single pending commit makes equality valid across sequence wrap. */
		if (sequence_id !=3D dcp_crtc->pending_seq_id) {
			drm_warn(crtc->dev,
				 "CRTC%u: ignoring stale FRAME_SCAN_COMPLETE seq=3D%u expected=3D%u\n",
				 dcp_crtc->display_id, sequence_id,
				 dcp_crtc->pending_seq_id);
			return;
		}
		dcp_crtc_frame_done_callback(crtc);
	}
	...
}

If dcp_crtc->pending_seq_id happens to be 0 (such as before the first commit
sequence is latched or when the 32-bit commit_seq_id counter wraps around to
0), this will falsely match pending_seq_id and prematurely complete the fra=
me.
When pending_seq_id is non-zero, it logs an unratelimited warning for a bog=
us
sequence 0 event.

> +
>  /* Route asynchronous events and capability packets before flag handling=
. */
>  static bool dcp_hfi_dispatch_event(struct dcp_hfi *hfi,
>  				   const struct hfi_packet_info *pkt_info)
>  {
>  	switch (pkt_info->cmd) {
>  	case HFI_COMMAND_DISPLAY_EVENT_VSYNC:
> +		dcp_crtc_hfi_vblank_cb(hfi->drv, pkt_info->id & 0xFFFF);
>  		return true;
> =20
>  	case HFI_COMMAND_DISPLAY_EVENT_FRAME_SCAN_START:
>  		return true;
> =20
>  	case HFI_COMMAND_DISPLAY_EVENT_FRAME_SCAN_COMPLETE:
> +		dcp_hfi_dispatch_frame_done(hfi, pkt_info);
>  		return true;

[Severity: High]
With HFI_COMMAND_DISPLAY_EVENT_FRAME_SCAN_COMPLETE now routed from the
asynchronous VirtIO response callback (dcp_hfi_resp_callback() ->
dcp_hfi_dispatch_event() -> dcp_hfi_dispatch_frame_done()) into
dcp_crtc_hfi_frame_done_cb(), can concurrent access to dcp_crtc->pending_se=
q_id
and dcp_crtc->pending_kickoff_cnt race with the commit path?

In drivers/gpu/drm/msm/dcp/dcp_crtc.c, dcp_crtc_commit_kickoff() updates
pending_kickoff_cnt and pending_seq_id without lock synchronization against
dcp_crtc_hfi_frame_done_cb():

	if (atomic_cmpxchg(&dcp_crtc->pending_kickoff_cnt, 0, 1)) {
		drm_err(crtc->dev,
			"CRTC%u: frame completion already pending\n",
			dcp_crtc->display_id);
		cstate->hfi_error =3D -EBUSY;
		return;
	}
	dcp_crtc->pending_seq_id =3D dcp_crtc->commit_seq_id;

	ret =3D dcp_hfi_display_commit(dcp_kms->hfi, session_id);
	if (ret) {
		drm_err(crtc->dev,
			"HFI commit failed for CRTC%u (session=3D%u): %d\n",
			dcp_crtc->display_id, session_id, ret);
		atomic_dec(&dcp_crtc->pending_kickoff_cnt);
		wake_up(&dcp_crtc->frame_done_wq);
	}

This appears to allow several races when asynchronous frame-done events arr=
ive:

1. pending_kickoff_cnt is set to 1 before dcp_crtc->pending_seq_id is updat=
ed
to dcp_crtc->commit_seq_id. If a FRAME_SCAN_COMPLETE event carrying the
previous sequence ID arrives in that window (for example after a prior comm=
it
timeout in dcp_crtc_wait_for_commit_done() reset pending_kickoff_cnt to 0 w=
hile
leaving pending_seq_id at the old value, or from periodic scanout),
dcp_crtc_hfi_frame_done_cb() sees sequence_id =3D=3D dcp_crtc->pending_seq_=
id and
calls dcp_crtc_frame_done_callback(), decrementing pending_kickoff_cnt back=
 to
0 before dcp_hfi_display_commit() even runs.

2. If dcp_crtc_frame_done_callback() decrements pending_kickoff_cnt from 1 =
to
0 (either via the window above or because firmware sent FRAME_SCAN_COMPLETE
while dcp_hfi_display_commit() timed out waiting for the command response) =
and
dcp_hfi_display_commit() returns an error, the error path unconditionally r=
uns
atomic_dec(&dcp_crtc->pending_kickoff_cnt), underflowing pending_kickoff_cn=
t to
-1. Because dcp_crtc_frame_done_callback() uses
atomic_add_unless(&dcp_crtc->pending_kickoff_cnt, -1, 0), subsequent frame-=
done
events will decrement it further (-2, -3, ...) and cause future commits to
stall until DCP_FRAME_DONE_TIMEOUT_MS expires.

3. In dcp_crtc_atomic_flush(), ++dcp_crtc->commit_seq_id is sent to firmware
via dcp_hfi_crtc_set_scan_sequence_id() and autorefresh is enabled via
dcp_hfi_crtc_set_autorefresh() before dcp_crtc_commit_kickoff() sets
pending_seq_id and pending_kickoff_cnt. If firmware emits a FRAME_SCAN_COMP=
LETE
event for the new sequence ID before dcp_crtc_commit_kickoff() updates
pending_seq_id, dcp_crtc_hfi_frame_done_cb() will drop it as a stale sequen=
ce
mismatch.

Should pending_seq_id and pending_kickoff_cnt updates and checks be
synchronized under a spinlock across the flush, kickoff, and HFI callback
paths?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-jshekhar-d=
cp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com?part=3D13
