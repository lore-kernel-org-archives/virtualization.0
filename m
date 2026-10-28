Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793145812;
	b=GzfrP4HfgdjPacp+woxflHRkjsiXgswp9l2vzaTDL63xJWHUUbvp4A9bWQJF7vhZcO20
	 qj3Zrb9cNVXfemeZx3IxOsdRWC4R0OEN8iHXHnAFbBHuoHKpFDLtcxfFH37VTQaPqAziT
	 oYHVbVxbEyVwO2V5oOdke+sS2Ngekqcp1Wfhwt4+QVHVzIAF/TSaArkSlOZAfRCUL4H3K
	 uhrfbossyvwOsffZDAsN/CZt0vFcbVme5prVpjUzS5lS+vL7Pq7nsYStqoBGFXZnY7gEc
	 OvOhACzXvbNg7+8DU9BafyUj77jh2vBqCcrsZGYYdqy6fSVD+W7oJ0DWTsFr/weWomw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793145812;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fbmyje0gCr0JzuNhWM/gWfQFiyzwo7sYkneioMy3vFk=;
	b=YwuOUdzLYOOe0hxUtbcSRHUU0seA0d7R3TPQGFPDKnE+v/1fL/y9ffOPxZK3SW847gcv
	 XwO2efP7LCTnXPQU+4fx9qVQJA0bp/Xlip4VjSZnAL+tIUr/+yTPqzoCSikk1lYjFmNi0
	 TtcuwgH4IJGpPj6lrdVzsgVG/dp7wp972yUvocEruwg+3kdKMJxySjorQYG2QOBNPFILr
	 gFCoN9LLU1JP8CBEhKJNj3D0f9Tijqwrd7+iwxa1hsihWY94/pYjPKzHIhupU5d+AGkVG
	 O3dvsFkSd6krobYr9mwv31wjwFywNfso4Mz1zDm17Q5k7REEqiUBelandxr+H8deOmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hHY4XHak;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C9C606A31A;
	Wed, 28 Oct 2026 00:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hHY4XHak
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28981F01825;
	Wed, 28 Oct 2026 00:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793145812;
	bh=fbmyje0gCr0JzuNhWM/gWfQFiyzwo7sYkneioMy3vFk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hHY4XHakjgBllN68fl83FYHq3+PFSHtnUK3Rz8pQsME/+aB80mpIobfPTMoGDLNwp
	 lPW6NSPtaBdBm8CUOUp7a9EbtxcwoxEHXKDSzw5bKrdGNexSTZDIoS3dNpC8AVmW0Y
	 Ha3xvIV18NX/G7LokRQlfuhA2V31yHhnWwO+ABb9JstsQvjmMo2F9QowcgQ7fkvpFv
	 kVQuJuI9qiEtw3IoRn/0xBFeMZfHjk14HdyQjIVLoWjq8bYt3+HsqEW1Mcy+byltT5
	 S+yVMlxd7wtOUTS2eblGyiD9nIPIpDlDLeVljMzzmtDdmrNCUEPlmwjO4tPmWHTJnE
	 NEFpu0b+mAvYg==
Message-ID: <sashiko-outbox-187248@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/11] ALSA: virtio: prioritize staged capture period
 work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261027234334.32551-10-mynameisjune111@gmail.com>
References: <20261027234334.32551-1-mynameisjune111@gmail.com>
 <20261027234334.32551-10-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 00:03:31 +0000
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
- [High] ALSA: virtio: UAF/NULL deref in virtsnd_pcm_period_elapsed() after=
 open fail
--

commit fc06cf9505ce3c738b1bc2bf02c081ba34868b30
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: prioritize staged capture period work

This commit introduces virtsnd_pcm_schedule_period_elapsed() to queue
elapsed_period work onto system_highpri_wq for staged capture streams while
keeping playback and non-staged streams on the normal workqueue. All ten
producers of elapsed_period work are updated to use this helper.

Link: https://lore.kernel.org/all/rfc-v2-vz-capture-compat-1.b9ab4c1540dc46=
91@gmail.com/

[ ... ]

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index 85e7576903d56..d50924b792f65 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c
> @@ -232,7 +232,7 @@ virtsnd_pcm_pause_restart_fail(struct virtio_pcm_subs=
tream *vss,
>  				VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED;
>  	}
>  	if (notify_xrun)
> -		schedule_work(&vss->elapsed_period);
> +		virtsnd_pcm_schedule_period_elapsed(vss);
>  	vss->substream->runtime->stop_operating =3D true;
>  }

[Severity: High]
Can queuing vss->elapsed_period onto system_highpri_wq from
virtsnd_pcm_pause_restart_fail() cause a NULL pointer dereference or
use-after-free of substream->runtime if virtsnd_pcm_open() fails?

During virtsnd_pcm_open(), the driver calls virtsnd_pcm_sync_stop(), which
dispatches to virtsnd_pcm_pause_restart_sync_stop() when pause-restart is
enabled:

sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_pause_restart_sync_stop() {
	scoped_guard(spinlock_irqsave, &vss->lock) {
		vss->xfer_enabled =3D false;
		vss->stopped =3D true;
		state =3D vss->pause_restart_state;
	}
	cancel_work_sync(&vss->elapsed_period);

	if (state =3D=3D VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED ||
	    virtsnd_pcm_pause_restart_transitioning(state)) {
		virtsnd_pcm_pause_restart_fail(vss, true);
		...
		return -EIO;
	}
	...
}

Although virtsnd_pcm_pause_restart_sync_stop() cancels vss->elapsed_period
at the beginning, all of its error paths call
virtsnd_pcm_pause_restart_fail(). Whenever vss->xfer_xrun was false (for
example, after a prior session failed in virtsnd_pcm_dev_set_params() ->
virtsnd_pcm_pause_restart_send() or left the stream in
VIRTSND_PCM_PAUSE_RESTART_PREPARED without starting), notify_xrun is true
and virtsnd_pcm_pause_restart_fail() re-queues vss->elapsed_period onto
system_highpri_wq after cancel_work_sync() has already completed.

When virtsnd_pcm_open() returns this error to snd_pcm_open_substream(),
substream->hw_opened is still 0, so snd_pcm_release_substream() skips
virtsnd_pcm_close() and immediately calls snd_pcm_detach_substream(),
freeing substream->runtime and setting substream->runtime =3D NULL without
holding pcm_stream_lock.

When virtsnd_pcm_period_elapsed() then runs on system_highpri_wq for a
staged capture stream, it calls snd_pcm_running(substream) before checking
whether substream->runtime is NULL:

sound/virtio/virtio_pcm.c:virtsnd_pcm_period_elapsed() {
	...
	guard(pcm_stream_lock_irqsave)(substream);
	if (!snd_pcm_running(substream)) {
		scoped_guard(spinlock_irqsave, &vss->lock) {
			runtime =3D substream->runtime;
			paused_xrun =3D runtime &&
	...
}

Since snd_pcm_running(substream) unconditionally reads
substream->runtime->state, can this dereference a freed or NULL
substream->runtime, or leave vss->elapsed_period pending after
virtsnd_pcm_sync_stop() returns?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027234334.3255=
1-1-mynameisjune111@gmail.com?part=3D9
