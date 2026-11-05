Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793839471;
	b=ii+6B/9peUasUNpc1UrAVr6Z38SR3p6GMStmzlk4jwr8CnYjbCrCjWh8vnfoToKMQ594
	 q2yVcirLUoTBR8iv+uGJolJFVW35ene1kQ1oqrCizv9lV/iCTWYEELjCUWOBoY6WsYCsO
	 o3+/cJS1EwYS0tycC5evirGFyfqaRaEA8s7wBeE/IHRFvbO/ORfiAgHcVBWeoCTS1s+jP
	 8v5NRRq4FtV1Rg/r6UEF6rxOJXct4XSbK/CVD1et6I/FYRlOBoqwZnGJGIfHdTFcKSujE
	 SAhseeSIhHAGDCoqc6MLJmK3Cz4PKJ5UJmW328tC2LHdWzwn/bGdMhyuJ7sl+z+iiEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793839471;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bJGd8mlTjpQ0FfgBLfZzt394CDwVDTgiO6kKFxC3j64=;
	b=B1XO18biB0LLqln0jwslHYwr5xVt803aleUyGk/j8GcT2z42rm5kiOuy/ljymqfzOa5T
	 2H3mES15kcVSA9xGTIVK/dIdJGmpGtWEPfMQ7yuHW0Q797B550BqCW21e9l9XNU5OX+Mc
	 yZhAFHw2TGybET1IiQm8P53jX37YIITkeZBjMQ4/0mX2FbxWiYgUR4MCCb/uVPweoD7Sw
	 kuw6IVP5ZS45W6axznuT/mxr5RUVUqs97ob2/E0TY80wL8kfWOj5okdc0oxwtufggB4M3
	 fd4hBL3KBCZXfld8j8ilFytEgadkJdFqB4hA8K+UGV+dMrGWI3qa1WuxiK+m0JOCboQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KI/vqXco";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF2A606A31B;
	Thu,  5 Nov 2026 00:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KI/vqXco
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0631F000C1;
	Thu,  5 Nov 2026 00:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793839471;
	bh=bJGd8mlTjpQ0FfgBLfZzt394CDwVDTgiO6kKFxC3j64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KI/vqXcoPhP4IBiGQd4ZbJrCWOrorVGSZxHmxlKxCJzHYSf2rVDRd1mPtb/F2BOnD
	 jRaUHA5eh71tkSUofnBe2nyXN2TrFOEnrqmx/0HgSD3uOQtqjq//v2tU47voXa/oQS
	 XoTvvI7lXs853pPOq8ANdFX8higykK5wfxvxFcrAODv7WV36vGcTpAgGNiwdTDJjhN
	 gSvynHXWUG+MYCGM47XKkZTDF6OD/b+QJD6WPz79n8f/InprzPEzsiNptW+Yf8QNVj
	 rP42HLIzpC0732MpDQHELvgbMM0+XMnOeHrAioOFeJedceB32nx76GArKYAwFB/3hy
	 N2CS32k7X5G9g==
Message-ID: <sashiko-outbox-198370@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 10/12] ALSA: virtio: add staged capture and
 serialize PCM lifecycle accounting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105000915.15177-11-mynameisjune111@gmail.com>
References: <20261105000915.15177-1-mynameisjune111@gmail.com>
 <20261105000915.15177-11-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 00:44:30 +0000
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
- [Medium] ALSA: virtio: staged capture ACK and pointer bypass prepared che=
ck in DRAINING
--

commit 50d3f0b4df898e1d66fc877101e4baac71884d78
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: add staged capture and serialize PCM lifecycle accounting

This commit adds an opt-in staged capture mode using request-owned RX
buffers with monotonic byte accounting for shared capture clients. It also
serializes PCM lifecycle transitions with lifecycle_lock and coordinates
pointer, reset, and ACK admission under the PCM stream lock.

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index 706d59d8c7201..a60f960287e2e 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c

[ ... ]

> @@ -601,14 +1513,69 @@ static snd_pcm_uframes_t
>  virtsnd_pcm_cp_pointer(struct snd_pcm_substream *substream)
>  {
>  	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
> +	struct snd_pcm_runtime *runtime =3D substream->runtime;
> +	size_t hw_ptr =3D 0;
> +	u64 total;
> +	bool free_running;
> +	bool xrun;
> =20
> -	scoped_guard(spinlock_irqsave, &vss->lock)
> -		if (vss->xfer_xrun)
> +	if (vss->capture_staging) {
> +		scoped_guard(spinlock_irqsave, &vss->lock) {
> +			if (!vss->runtime_active || vss->preparing || vss->suspended ||
> +			    (!vss->prepared && runtime->state !=3D SNDRV_PCM_STATE_DRAINING &&
> +			     !(runtime->state =3D=3D SNDRV_PCM_STATE_PAUSED &&
> +			       virtsnd_pcm_pause_restart_enabled(vss) &&
> +			       vss->pause_restart_state =3D=3D VIRTSND_PCM_PAUSE_RESTART_RELE=
ASED)))
> +				return SNDRV_PCM_POS_XRUN;

[ ... ]

> @@ -647,86 +1658,176 @@ static int virtsnd_pcm_ack_state(struct snd_pcm_s=
ubstream *substream)

[ ... ]

> +static int virtsnd_pcm_capture_staged_ack(struct virtio_pcm_substream *v=
ss,
> +					  struct snd_pcm_runtime *runtime)
> +{
> +	struct virtio_snd_queue *queue =3D virtsnd_pcm_queue(vss);
> +	int rc =3D 0;
> +
> +	/*
> +	 * The RX callback holds the queue lock while draining completions.
> +	 * Account ALSA's read under the substream lock alone so completions la=
ter
> +	 * in that drain observe the newly released ring space.
> +	 */
> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		snd_pcm_uframes_t appl_ptr;
> +		snd_pcm_uframes_t appl_diff;
> +		snd_pcm_uframes_t ack_frames;
> +		snd_pcm_sframes_t diff;
> +		size_t bytes;
> +		u64 outstanding;
> +		u64 next_acked_total;
> +		bool free_running;
> +
> +		if (!vss->runtime_active || vss->preparing || !runtime || !runtime->co=
ntrol ||
> +		    !runtime->dma_area || vss->suspended)
>  			return -EBADFD;
> -		if (vss->stopped)
> +		/* Preserve DRAINING tails only when no transfer XRUN is latched. */
> +		if (vss->stopped && vss->xfer_xrun)
>  			return -EBADFD;
> -		if (vss->xfer_xrun) {
> -			rc =3D -EPIPE;
> -		} else {
> -			transfer.indirect =3D vss->pcm_indirect;
> -			rc =3D snd_pcm_indirect_playback_transfer(substream,
> -							       &transfer.indirect,
> -							       virtsnd_pcm_trans_copy);
> -			if (!rc)
> -				rc =3D transfer.error;
> +		if (vss->xfer_xrun)
> +			return -EPIPE;
> +		if (!vss->prepared && runtime->state !=3D SNDRV_PCM_STATE_DRAINING &&
> +		    !(runtime->state =3D=3D SNDRV_PCM_STATE_PAUSED &&
> +		      virtsnd_pcm_pause_restart_enabled(vss) &&
> +		      vss->pause_restart_state =3D=3D VIRTSND_PCM_PAUSE_RESTART_RELEAS=
ED))
> +			return -EBADFD;
> +		if (vss->stopped && runtime->state !=3D SNDRV_PCM_STATE_DRAINING &&
> +		    !(runtime->state =3D=3D SNDRV_PCM_STATE_PAUSED &&
> +		      virtsnd_pcm_pause_restart_enabled(vss) &&
> +		      vss->pause_restart_state =3D=3D VIRTSND_PCM_PAUSE_RESTART_RELEAS=
ED))
> +			return -EBADFD;

[Severity: Medium]
Should virtsnd_pcm_cp_pointer() and virtsnd_pcm_capture_staged_ack()
exempt SNDRV_PCM_STATE_DRAINING from the !vss->prepared check?

When a capture stream enters SNDRV_PCM_STATE_DRAINING via
snd_pcm_drain() -> snd_pcm_do_drain_init() -> snd_pcm_do_stop() ->
virtsnd_pcm_trigger(SNDRV_PCM_TRIGGER_STOP), the driver sets
vss->stopped =3D true and vss->xfer_enabled =3D false while keeping
vss->prepared =3D true. Unlike SNDRV_PCM_STATE_PAUSED under
capture_pause_restart (which sends VIRTIO_SND_R_PCM_RELEASE and sets
vss->prepared =3D false), an active draining capture epoch always keeps
vss->prepared =3D true until teardown retires it.

If userspace subsequently calls snd_pcm_prepare() on a draining staged
capture stream, snd_pcm_do_prepare() leaves runtime->state as
SNDRV_PCM_STATE_DRAINING while invoking snd_pcm_sync_stop() ->
virtsnd_pcm_sync_stop() -> virtsnd_pcm_sync_stop_locked():

sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_sync_stop_locked() {
	scoped_guard(pcm_stream_lock_irqsave, substream) {
		guard(spinlock_irqsave)(&vss->lock);
		preparing =3D vss->preparing;
		vss->preparing =3D true;
		vss->prepared =3D false;
		vss->xfer_enabled =3D false;
	}
	rc =3D virtsnd_pcm_release_locked(substream);
	scoped_guard(pcm_stream_lock_irqsave, substream) {
		guard(spinlock_irqsave)(&vss->lock);
		vss->preparing =3D preparing;
	}
	return rc;
}

Once virtsnd_pcm_sync_stop_locked() returns, vss->prepared and
vss->stopped are both false and vss->preparing is restored to false,
while runtime->state is still SNDRV_PCM_STATE_DRAINING. In the window
before virtsnd_pcm_prepare_locked() takes the PCM stream lock (or
permanently if virtsnd_pcm_prepare_locked() fails before
virtsnd_pcm_dev_prepare(), such as on -ECANCELED or a
virtsnd_pcm_dev_set_params() error, where virtsnd_pcm_prepare() resets
vss->preparing =3D false), concurrent SNDRV_PCM_IOCTL_SYNC_PTR or
SNDRV_PCM_IOCTL_HWSYNC calls bypass the !vss->prepared check and proceed
on the released, unprepared epoch.

By comparison, the non-staged path in virtsnd_pcm_cp_ack_locked() only
exempts SNDRV_PCM_STATE_DRAINING from vss->stopped and unconditionally
rejects !vss->prepared:

	if (!vss->prepared ||
	    (vss->stopped &&
	     runtime->state !=3D SNDRV_PCM_STATE_DRAINING))
		return -EBADFD;

Should virtsnd_pcm_cp_pointer() and virtsnd_pcm_capture_staged_ack()
likewise require vss->prepared to be true unless the stream is in the
pause-restart released state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105000915.1517=
7-1-mynameisjune111@gmail.com?part=3D10
