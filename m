Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793847545;
	b=tnGrdcGkZFbArL8caLLfOyPgjGnbrMK+I7E+9GbNiz5mQKF+7ck5XkjvimqgqI1dhEGS
	 JqbD8A/ur16nO2hVCBrI3t6lMWf3PgYFrodyNH+dsR2AKXH0/FEWC1PvltSFONH+PK9E0
	 XgJg7qurMWBbM5ohByk1/HmivGJfRqsRQRQDbIw+neafjByhENdyOevO+wdMGrNzycuqE
	 KTfECKw38bVmh/LngANUbjshjRTZIpdFQIH2OQXM79LTpjjHH9JH9R/nnK8FMBLUNdK4v
	 wxT92ZW1/IJBFkDDSXaQv0g8oy1f0njXvGMYKGUCDYDi9yjSW+JeWE7Jqftlv8lLhQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793847545;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HkkHKPhfaM2A4qlGiSslXaZbsWoV2oYt+yic7jYpVjw=;
	b=LOxifZ9yLR7QxbtWANZSQkhca8FHOPgxkxt+QnwB5AO9Zzjt7Ir9v+gzxqAJ0rBnYVaR
	 GzMV4EL06dj5T6R7s4CKwFBPskWMjC1QDRGNz0i+cUe04f5JDY75amGDmael7vQLjQCrF
	 xpPIi20R12ulG+GaflXCUWWkUGeJr1J1AXaQCWahqJT0KvSxShHZS5wET2t+Oipf4IcbL
	 yLeRDBxI2swe9IUgEInqkyoqM2caTPEeEwLdr9WmCsoYQfw8OdiohxWRgbKiON8gVyeYe
	 GLcFHZrpewm61+upuf1BClXKvFPloQr4Llc8r9o7nlHrlgSLzWfsfQ2r85nyI+oLCeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gUhnMK6V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B96606A326;
	Thu,  5 Nov 2026 02:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gUhnMK6V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69A11F00919;
	Thu,  5 Nov 2026 02:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793847544;
	bh=HkkHKPhfaM2A4qlGiSslXaZbsWoV2oYt+yic7jYpVjw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gUhnMK6VsoxJH3lcKLMMishMQ3FwlsO0fnPivjTJAbltEOu8MEZPtKqHm51PfszAA
	 RhOOpFPECNBgRQyIdbqtFZj5OXlsvIqI2jIRe9xsUx7Rzxc9COpG1vzS+sIqMraANQ
	 1T6xFKWmESmkuVuMiupckSE8VdupPW1UO3wAEDZzK0qLh11kDgBAwbVuuDZhiYNYMx
	 EV+ps8ZLIzmAp0rrjshNY3uzb6PCXtib/EFYFAw6jshw1nfAG5dapoztnufkVB5doF
	 R8jEzy/oECaff7rU7BmKOV8XDKnh5oirkxbDXIINCfhUtMgwEuOwtcQtidNJ2faQ/g
	 mY8vkw/QOZBzQ==
Message-ID: <sashiko-outbox-198493@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 10/12] ALSA: virtio: add staged capture and
 serialize PCM lifecycle accounting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105023140.18373-11-mynameisjune111@gmail.com>
References: <20261105023140.18373-1-mynameisjune111@gmail.com>
 <20261105023140.18373-11-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 02:59:04 +0000
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
- [High] ALSA: virtio: virtsnd_pcm_period_elapsed() corrupts linked paused =
streams
--

commit d8e5fc87d68c2238eeb8bbf2e3deb7ce9fbe8f3e
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: add staged capture and serialize PCM lifecycle accounting

This commit adds staged capture using request-owned RX storage and
separates produced, observed, and consumed positions for shared capture
clients. It also serializes PCM lifecycle operations with lifecycle_lock
and ACK accounting with the PCM stream lock.

> diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
> index be3893de40a55..f9b301e4a70ae 100644
> --- a/sound/virtio/virtio_pcm.c
> +++ b/sound/virtio/virtio_pcm.c
> @@ -310,8 +310,119 @@ static void virtsnd_pcm_period_elapsed(struct work_=
struct *work)
>  {
>  	struct virtio_pcm_substream *vss =3D
>  		container_of(work, struct virtio_pcm_substream, elapsed_period);
> +	struct snd_pcm_substream *substream =3D vss->substream;
> +	struct snd_pcm_runtime *runtime;
> +	size_t period_bytes;
> +	u64 period_floor;
> +	u64 snapshot;
> +	bool staged_capture;
> +	bool paused_xrun =3D false;
> +	bool notify =3D false;
> +	bool partial =3D false;
> +	bool requeue =3D false;
> +
> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		staged_capture =3D vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE &&
> +				 vss->capture_staging;
> +	}
> +
> +	/* Serialize the pointer snapshot with ALSA's pointer and ACK callbacks=
. */
> +	guard(pcm_stream_lock_irqsave)(substream);
> +	if (!substream->runtime)
> +		return;
> +	if (!snd_pcm_running(substream)) {
> +		scoped_guard(spinlock_irqsave, &vss->lock) {
> +			runtime =3D substream->runtime;
> +			paused_xrun =3D runtime &&
> +				      runtime->state =3D=3D SNDRV_PCM_STATE_PAUSED &&
> +				      vss->xfer_xrun;
> +			if (paused_xrun)
> +				virtsnd_pcm_capture_arm_paused_stop(vss);
> +		}
> +		if (paused_xrun) {
> +			/* Stop paused transfers and wake blocked readers. */
> +			snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
> +		}
> +		return;
> +	}

[Severity: High]
How does virtsnd_pcm_period_elapsed() handle paused substreams that are
linked to sibling substreams via SNDRV_PCM_IOCTL_LINK?

When runtime->state is SNDRV_PCM_STATE_PAUSED and vss->xfer_xrun is set,
virtsnd_pcm_period_elapsed() calls virtsnd_pcm_capture_arm_paused_stop(vss)
on only that single substream (setting vss->xfer_enabled =3D false,
vss->stopped =3D true, and runtime->stop_operating =3D true), and then calls
snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN).

Because snd_pcm_stop() runs snd_pcm_action(&snd_pcm_action_stop, ...)
across all substreams in substream->group, and snd_pcm_do_stop() only
invokes ops->trigger(s, SNDRV_PCM_TRIGGER_STOP) and sets
s->runtime->stop_operating =3D true when snd_pcm_running(s) is true (which =
is
false for SNDRV_PCM_STATE_PAUSED), snd_pcm_post_stop() transitions any
paused sibling substream to SNDRV_PCM_STATE_XRUN without
virtsnd_pcm_capture_arm_paused_stop() ever running on it.

When userspace subsequently calls SNDRV_PCM_IOCTL_DROP, snd_pcm_drop() sees
the sibling substream already in SNDRV_PCM_STATE_XRUN rather than
SNDRV_PCM_STATE_PAUSED, so snd_pcm_pause(s, false) and snd_pcm_do_stop()
are skipped, and snd_pcm_sync_stop() is also skipped because
s->runtime->stop_operating is false. Does this leave the sibling substream
in SNDRV_PCM_STATE_SETUP while its VirtIO stream remains prepared on the
device with active virtqueue buffers?

In addition, if substream is linked and snd_pcm_stream_group_ref() inside
snd_pcm_stop() contends on group->mutex, it temporarily drops substream's
PCM stream lock to acquire group->mutex in lock order. Can a concurrent
snd_pcm_drop() or snd_pcm_prepare() complete during that window and place
the substreams into SNDRV_PCM_STATE_SETUP or a new SNDRV_PCM_STATE_PREPARED
epoch before snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN) finishes locking
and overwrites runtime->state with SNDRV_PCM_STATE_XRUN?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105023140.1837=
3-1-mynameisjune111@gmail.com?part=3D10
