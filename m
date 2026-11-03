Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705236;
	b=me1EpcsW+CKT9C2xquBUyn7hVqkBsOnk3nuSTQDlLCHANvBCHMgpsQU4dQhRVfk4Dpdf
	 rOe4K/HjeZqBoU5Bx5u8atd5y/B4w0RnqDG7JEe2mHHMpHEB+17IdyrNQWD6K1aglLgcZ
	 cdru/NHhbxFazTS7BRIyJlBltatgISEHtwz+uSLiYTM8VGh4h673Dct3xGS+GGAzlEEFU
	 PvcbFmpwKRXGltMORr8YtVwtS5kbXYGHfB95+G12bfFs7eDQY3KRV+kFHwpNqLdMfjI2C
	 /xZDgiB/p0Uctj0FbvXRrSc7U5pExM26/caeIfr5JSf9+QsGQBPRn/b6TZ1eL+sBsQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705236;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CRrLZLcVyc36aDQFrWVQs6dHBrvuyiS9kzIqr1ICWvA=;
	b=kwgywu2WKYvs+FEA3sVZHGPkq7xR25HZjdRamFKbtvvHS6fLnp/F0EHDuEhh/L41xPE+
	 SMPlLgUBCDYgoyEsM2JeDzZI18j1CvO5gwvETPBMIRbISU88O8ZCDdnP8euDbGA393m90
	 rrnyGgZ4hcgLqrfLSDi4M+sBpEKua2wjOsQIeWv191eLCUg3dakhxY8DnAKgkpItzenvC
	 ZOiZyBGqRaXuHB0Iia4KuLAsasb3WuB1Q1n1CrkhvW5EjFTOzcjwdNLeU8m+L8z5c+hju
	 1RKrBEtW7S/F3RfSbh7KwvBdHqB6OWxie8JS3xJ+TkoucoNoYbo8E5gK823TGy/rKiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MhyoqwTI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7422606C565;
	Tue,  3 Nov 2026 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MhyoqwTI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082621F0093A;
	Tue,  3 Nov 2026 11:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793705235;
	bh=CRrLZLcVyc36aDQFrWVQs6dHBrvuyiS9kzIqr1ICWvA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MhyoqwTIE5YoyxAJFrpQ5cTiLk273anNKWWdM2Q3sIV3sgwGwinB1Ah2VGmQbgL/Y
	 /z3+lL2dxZPycAgNn5q4zl11HPfROnatdxCQa7KXKVo/HVxSD1cAFAG/4jFFa6nYP9
	 RWeZGpTHrZEtGCJvS9cTEqQ8R9opSCvcej0PX4+czhHpj0PXwUIGv9fW/NQSU5NkhO
	 mITZ8YjKeYBA3RSxIeiIJPykuW69B3moO4U6+08/bZEHqIAPIoELFxg+++bf4w5Jp9
	 96/RcWx7IsK+VU2K/Zn9xgGW8DPYZZ+8EFpYJxmmT+uo5x3yGmee6qxHmYGgbnvk9w
	 FctcRA0m8DUTw==
Message-ID: <sashiko-outbox-195148@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 12/12] docs: describe virtio-sound capture options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103080821.16983-13-mynameisjune111@gmail.com>
References: <20261103080821.16983-1-mynameisjune111@gmail.com>
 <20261103080821.16983-13-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 11:27:14 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Medium] ALSA: virtio: missing NOMMU copy when stopped in virtsnd_pcm_msg=
_complete()
- [Medium] ALSA: virtio: reject short non-staged replies in virtsnd_pcm_msg=
_complete()
- [Low] docs: kernel-parameters: document capture_staging dependency for vi=
rtio_snd
- [Low] docs: kernel-parameters: use [HW,ALSA] instead of undefined [HW,SOU=
ND] tag
- [Low] docs: virtio-sound: remove prompt instructions from commit descript=
ion
--

commit 0d2f51e1deefbf07b12391911246c9ce81e71037
Author: Joonho Lee <mynameisjune111@gmail.com>

docs: describe virtio-sound capture options

This commit documents the five opt-in capture module parameters for
virtio_snd in Documentation/admin-guide/kernel-parameters.txt.

>     docs: describe virtio-sound capture options
>    =20
>     Document the five opt-in capture module parameters introduced by this
>     series. All default to false. Describe the startup-empty, short-paylo=
ad,
>     packed-status and pause-restart compatibility behavior alongside stag=
ing,
>     and require validation with the target device.
>    =20
>     Keep the virtio_snd entries after virtio_mmio in alphabetical order.
>     Include a diffstat in every mail patch.
>    =20
>     Assisted-by: LLM
>     Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

[Severity: Low]
This isn't a bug, but "Include a diffstat in every mail patch." in the
commit description looks like a leftover patch-submission or prompt
instruction. Should that sentence be removed from the changelog?

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index e75344f4e0cde..de47885cd54b3 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -8344,6 +8344,36 @@ Kernel parameters
> =20
>  			Can be used multiple times for multiple devices.
> =20
> +	virtio_snd.capture_allow_empty=3D [HW,SOUND]

[Severity: Low]
This isn't a bug, but the parameter restriction list at the top of
Documentation/admin-guide/kernel-parameters.txt defines ALSA:

	ALSA	ALSA sound support is enabled.

and does not define SOUND. Should these five virtio_snd.capture_* entries
use [HW,ALSA] instead of [HW,SOUND]?

> +			Retry a bounded number of empty startup capture replies.
> +			Format: <bool>
> +			Default: false. Compatibility option for devices that
> +			require staged capture; validate with the target device.
> +
> +	virtio_snd.capture_allow_short=3D [HW,SOUND]
> +			Accept non-empty, frame-aligned short capture replies.
> +			Format: <bool>
> +			Default: false. Compatibility option for devices that
> +			require staged capture; validate with the target device.
> +
> +	virtio_snd.capture_packed_status=3D [HW,SOUND]
> +			Read status immediately after the returned capture data.
> +			Format: <bool>
> +			Default: false. Compatibility option for devices that
> +			require staged capture; validate with the target device.
> +
> +	virtio_snd.capture_pause_restart=3D [HW,SOUND]
> +			Release and reprepare capture streams across pause.
> +			Format: <bool>
> +			Default: false. Compatibility option for devices that
> +			require staged capture; validate with the target device.

[Severity: Low]
In sound/virtio/virtio_pcm_msg.c and sound/virtio/virtio_pcm_ops.c, all
four of these compatibility parameters only take effect when
vss->capture_staging is enabled:

sound/virtio/virtio_pcm_msg.c:virtsnd_pcm_msg_complete() {
	if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE &&
	    vss->capture_staging) {
		virtsnd_pcm_capture_complete(msg, written_bytes);
		return;
	}
}

sound/virtio/virtio_pcm_msg.c:virtsnd_pcm_capture_status() {
	if (msg->substream->capture_staging && virtsnd_capture_packed_status) {
		...
	}
}

sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_pause_restart_enabled() {
	return virtsnd_capture_pause_restart && vss->capture_staging &&
	       vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE;
}

If a user enables virtio_snd.capture_allow_empty,
virtio_snd.capture_allow_short, virtio_snd.capture_packed_status, or
virtio_snd.capture_pause_restart while leaving virtio_snd.capture_staging
at its default value of false, the options silently have no effect.

Should the documentation for these four parameters explicitly state that
they require virtio_snd.capture_staging to be enabled?

[Severity: Medium]
Also looking at the underlying capture completion handling in
sound/virtio/virtio_pcm_msg.c:virtsnd_pcm_msg_complete(), can non-staged
capture on CONFIG_MMU=3Dn builds advance vss->hw_ptr without copying the
captured audio payload when vss->stopped is true (such as during
SNDRV_PCM_STATE_DRAINING)?

In virtsnd_pcm_msg_complete(), post-STOP capture completions are only
discarded when written_bytes <=3D sizeof(*msg->status):

	if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE &&
	    (!vss->prepared ||
	     (vss->stopped && written_bytes <=3D sizeof(*msg->status)))) {
		msg->length =3D 0;
		vss->msg_count--;
		if (!vss->msg_count)
			wake_up_all(&vss->msg_empty);
		return;
	}

When a draining stream stops via snd_pcm_drain() -> snd_pcm_do_drain_init()
-> snd_pcm_do_stop() -> virtsnd_pcm_trigger(..., SNDRV_PCM_TRIGGER_STOP),
vss->stopped is set to true while vss->prepared remains true. If an
in-flight RX request then completes with written_bytes >
sizeof(*msg->status), the #ifndef CONFIG_MMU bounce-buffer copy is skipped
because of the !vss->stopped check:

#ifndef CONFIG_MMU
	if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE &&
	    vss->prepared && !vss->stopped &&
	    written_bytes > sizeof(*msg->status)) {
		...
			memcpy(runtime->dma_area + msg->data_offset,
			       vss->owned_dma_area + msg->data_offset, data_bytes);
	}
#endif
	vss->hw_ptr +=3D completed_bytes;

Since virtsnd_pcm_cp_pointer() and virtsnd_pcm_cp_ack_locked() allow reads
while in SNDRV_PCM_STATE_DRAINING, doesn't advancing vss->hw_ptr and
vss->capture_copied_total without copying from vss->owned_dma_area expose
stale or zeroed bytes in runtime->dma_area to userspace?

[Severity: Medium]
In the same non-staged capture path in
sound/virtio/virtio_pcm_msg.c:virtsnd_pcm_msg_complete(), what happens if
a device returns a non-empty, frame-aligned short capture reply (0 <
completed_bytes < msg->length) when virtio_snd.capture_staging is false?

In staged mode, virtsnd_pcm_capture_complete() explicitly rejects short
replies unless virtsnd_capture_allow_short is set:

		} else if (audio_bytes < msg->length &&
			   !virtsnd_capture_allow_short) {
			virtsnd_pcm_capture_xrun_locked(vss);

However, in non-staged mode, virtsnd_pcm_msg_complete() only checks
!completed_bytes after virtsnd_pcm_capture_status():

		if (virtsnd_pcm_capture_status(msg, written_bytes, frame_bytes,
					       &completed_bytes, &latency_bytes) ||
		    !completed_bytes) {
			vss->xfer_xrun =3D true;
			...
			return;
		}

Because virtsnd_pcm_msg_alloc() permanently binds each non-staged
vss->msgs[i] to a fixed slice at runtime->dma_area + i * period_bytes,
accepting completed_bytes < msg->length advances vss->hw_ptr by
completed_bytes and resets vss->msgs[i]->length =3D 0 while the next
descriptor vss->msgs[i + 1] writes at (i + 1) * period_bytes. Doesn't this
desynchronize vss->hw_ptr from the fixed descriptor slices (exposing the
unwritten tail of vss->msgs[i] to userspace on subsequent completions) and
leave later descriptors with msg->length < period_bytes in
virtsnd_pcm_msg_send() so they are not re-queued?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103080821.1698=
3-1-mynameisjune111@gmail.com?part=3D12
