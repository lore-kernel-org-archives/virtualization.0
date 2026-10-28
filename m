Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793182898;
	b=YhY8smeGwGUKKLEex2+mukQZ/8e/w+i5ZZQiQv1yugKhZ59OLPqX9dwkI9ukiEBHWre0
	 otXqrvCycMMvBqez4zhCq59uxoGO/WNCH5dMkHm9LKlhI9hAVa3WWfJ//fQfKbMMDRo0L
	 XrwrmZlIQu56p0nTB40d8me8H1scxrJ6tS8lGjHW4PMlsnIlTW9pVQ8BpVTTfmE/KIZlo
	 ZuTO057gXuYOdBn29n4K2/1qfmsr/foLXNr47Lzqtpy/ye6MWELIctZVwPBcHX4z5I5PG
	 iDE+OQWTlGHmGUx41IYHKchiGTYwWTtCYbGyN75Xo3DGMFJH2X0M/6PUqQsWJqlaM4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793182898;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eMYY0/lTp2QfLKaXNI6GjMDFV0yPr4bSE4JUzow55gQ=;
	b=aowu3M3tMV68h7zH0azE3/ToWx2OT9/Sn8dxXS0ea7FCjB/kko+U8enyQd/TfMU1eXCV
	 vzguhrND9Nhal8C0EYmKvwytMNYgO9eYXgKe4gJ9kuBkYifmeZM2YuI68FWHFr/dMqTpV
	 oMKzKQ+VfFvtV7xN4w+L9wtaPMq6UZwt3nkTORKFdVz6etBXD+tWkXJJ+h2aEjacFGK/e
	 1r43+/Jmkn/JEKUBE3u6MrS/50LXQ1fx0+GmK92Vydx+fl909d85iIGq3ENu5cEqPKpC+
	 +bsAhknDW0vYbHU5c98ztXdEVqrDnlJ5x9KW1uWh1UYrHRUhGKdWarFdI9E93GawXaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UujCdSin;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C37606A31A;
	Wed, 28 Oct 2026 10:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UujCdSin
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622AD1F01825;
	Wed, 28 Oct 2026 10:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793182897;
	bh=eMYY0/lTp2QfLKaXNI6GjMDFV0yPr4bSE4JUzow55gQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UujCdSinUS8wmWLGTfRwnBhOSMK71PVxhc9uZbw09xapvYSn/7Ya40vEzQ38NGDEe
	 gzZAouFJJ5RYrvtVETlYQaJuEd8T5yO3U3eMMSjlkRyXm9EoI0Gwt1yKvQxAZG3PJl
	 nCtwAkmQ0ffDzbtJqcDC4jZQDLWkwxokYtryNArEmspgMY7Jyi4vLdATG7bDWBKKqP
	 b4FYc2PliDSN06Juj/fz7O0qKkrBlR5yCGS1dyT74BFHNxfsAwH8T3MRL5V5t0JfiZ
	 xX0iZi5Qk/OLXOYfJTwyFxNljvlq17cJHODOD1jUm74HgQTmAA9xhgj/6rzb4tGR25
	 +N5zElwJd64aA==
Message-ID: <sashiko-outbox-187743@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 15/16] ALSA: pcm: synchronize stopped paused streams
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028094132.20364-16-mynameisjune111@gmail.com>
References: <20261028094132.20364-1-mynameisjune111@gmail.com>
 <20261028094132.20364-16-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 10:21:37 +0000
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
- [High] ALSA: pcm: snd_pcm_do_stop() arms sync_stop on paused streams with=
out STOP trigger
--

commit 9cef4af5ba9c6105fe851ee2ad98ad262f35643e
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: pcm: synchronize stopped paused streams

This commit marks runtime->stop_operating =3D true in snd_pcm_do_stop() when
a PCM substream is in SNDRV_PCM_STATE_PAUSED so that subsequent prepare or
drop operations invoke sync_stop to drain outstanding DMA requests.

> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index a2ea44c3c1d29..ac2e5c2ee5065 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -1611,6 +1611,9 @@ static int snd_pcm_do_stop(struct snd_pcm_substream=
 *substream,
>  		substream->ops->trigger(substream, SNDRV_PCM_TRIGGER_STOP);
>  		substream->runtime->stop_operating =3D true;
>  	}
> +	/* Paused DMA can still own requests which sync_stop must drain. */
> +	if (substream->runtime->state =3D=3D SNDRV_PCM_STATE_PAUSED)
> +		substream->runtime->stop_operating =3D true;

[Severity: High]
Does setting substream->runtime->stop_operating =3D true here without issui=
ng
SNDRV_PCM_TRIGGER_STOP leave drivers in a paused state when transitioning to
SNDRV_PCM_STATE_XRUN or SNDRV_PCM_STATE_SETUP?

Normally, when stopping a paused stream via snd_pcm_prepare() or
snd_pcm_drop(), ALSA unpauses the stream first before calling snd_pcm_stop(=
):

sound/core/pcm_native.c:snd_pcm_prepare() {
	scoped_guard(pcm_stream_lock_irq, substream) {
		switch (substream->runtime->state) {
		case SNDRV_PCM_STATE_PAUSED:
			snd_pcm_pause(substream, false);
			fallthrough;
		case SNDRV_PCM_STATE_SUSPENDED:
			snd_pcm_stop(substream, SNDRV_PCM_STATE_SETUP);
			break;
		}
	}
}

Because snd_pcm_pause(substream, false) sets runtime->state to
SNDRV_PCM_STATE_RUNNING, snd_pcm_do_stop() sees snd_pcm_running(substream) =
=3D=3D
true and invokes substream->ops->trigger(substream, SNDRV_PCM_TRIGGER_STOP).

However, when snd_pcm_stop() -> snd_pcm_do_stop() is called directly on a
stream in SNDRV_PCM_STATE_PAUSED (for example, when __snd_pcm_lib_xfer() ->
snd_pcm_update_state() -> __snd_pcm_xrun() triggers an XRUN after a partial
read/write while paused leaves avail >=3D runtime->stop_threshold, when
pcm_lib_apply_appl_ptr() -> ops->ack() returns -EPIPE, or if
snd_pcm_pause(substream, false) fails), snd_pcm_running(substream) is false.

With this change, snd_pcm_do_stop() sets runtime->stop_operating =3D true
without calling ops->trigger(SNDRV_PCM_TRIGGER_STOP), and snd_pcm_post_stop=
()
then overwrites runtime->state to SNDRV_PCM_STATE_XRUN (or
SNDRV_PCM_STATE_SETUP). A subsequent snd_pcm_prepare() or snd_pcm_drop() no
longer sees SNDRV_PCM_STATE_PAUSED, skips snd_pcm_pause() and snd_pcm_stop(=
),
and calls snd_pcm_sync_stop() -> ops->sync_stop() on a stream that only ever
received SNDRV_PCM_TRIGGER_PAUSE_PUSH and never received
SNDRV_PCM_TRIGGER_STOP:

1. In sound/virtio/virtio_pcm_ops.c, virtsnd_pcm_trigger() does not set
vss->stopped =3D true on SNDRV_PCM_TRIGGER_PAUSE_PUSH:

	case SNDRV_PCM_TRIGGER_STOP:
	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
		scoped_guard(spinlock_irqsave, &vss->lock) {
			if (command !=3D SNDRV_PCM_TRIGGER_PAUSE_PUSH)
				vss->stopped =3D true;
			vss->xfer_enabled =3D false;
		}

At this commit, virtsnd_pcm_sync_stop() checks:

	scoped_guard(spinlock_irqsave, &vss->lock) {
		vss->xfer_enabled =3D false;
		need_release =3D vss->stopped || vss->msg_count;
		if (need_release)
			vss->stopped =3D true;
	}
	cancel_work_sync(&vss->elapsed_period);
	if (!need_release)
		return 0;

If vss->msg_count is 0 when the paused stream enters XRUN, vss->stopped is
false and virtsnd_pcm_sync_stop() skips sending VIRTIO_SND_R_PCM_RELEASE.
Furthermore, once the follow-up commit ("ALSA: virtio: serialize capture
lifecycle and reset state") removes the paused-ACK stop_threshold check from
virtsnd_pcm_cp_ack(), a paused partial read/write that triggers XRUN in
snd_pcm_update_state() leaves both vss->stopped and vss->xfer_xrun false wh=
ile
runtime->state is SNDRV_PCM_STATE_XRUN. A subsequent SNDRV_PCM_IOCTL_SYNC_P=
TR
ioctl (via snd_pcm_sync_ptr() -> pcm_lib_apply_appl_ptr()) can then invoke
virtsnd_pcm_pb_ack() or virtsnd_pcm_cp_ack(), bypass the vss->stopped and
vss->xfer_xrun guards, and queue new virtqueue DMA requests or advance stag=
ed
capture counters while in XRUN.

2. In sound/core/pcm_dmaengine.c, SNDRV_PCM_TRIGGER_PAUSE_PUSH calls
dmaengine_pause() while dmaengine_terminate_async() is only called on
SNDRV_PCM_TRIGGER_STOP. In snd_dmaengine_pcm_sync_stop():

	status =3D dmaengine_tx_status(prtd->dma_chan, prtd->cookie, &state);
	if (status !=3D DMA_PAUSED)
		dmaengine_synchronize(prtd->dma_chan);

Because the channel remains in DMA_PAUSED and was never terminated,
snd_dmaengine_pcm_sync_stop() skips synchronization and leaves the paused
DMA transfer active across prepare.

3. In sound/usb/pcm.c and sound/usb/endpoint.c, SNDRV_PCM_TRIGGER_PAUSE_PUSH
only clears the URB data callback whereas stop_endpoints() is only called on
SNDRV_PCM_TRIGGER_STOP. When snd_usb_pcm_sync_stop() calls wait_clear_urbs(=
):

	if (atomic_read(&ep->state) !=3D EP_STATE_STOPPING)
		return 0;

It returns immediately without stopping or draining the USB endpoints.

Should snd_pcm_do_stop() also ensure the stream is triggered to stop (or
Only treat SNDRV_PCM_STATE_PAUSED as running for the stop trigger when
substream->runtime->trigger_master =3D=3D substream) rather than only setti=
ng
stop_operating =3D true?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028094132.2036=
4-1-mynameisjune111@gmail.com?part=3D15
