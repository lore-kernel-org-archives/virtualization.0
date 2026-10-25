Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792906599;
	b=UfDTIP8phUnP9YkMy5ZcYqGhYJO3n5BplnnsjMNIVH2VPXZ1zZ09k+wFOp8IQ5eaYvfQ
	 cnM4QkeIzki1asxi4v0qLUHitg2kkKIEcX9NG7aonOlkrJiIJs8IGCT+w2Uidz8yHXjI1
	 Al9K4PUKeVD4dW/OEiOxtz2/wKoBdg6XjjEQ8g3/KlxXPIBcPd7dH8wxZzcT9LW71lGOd
	 IxuH85Yc/MmMnbE1uhum6kTA4qZUU4tm7UbrSrpUxpAQjDzhSIKZul4+tyVS6QAxBbzvG
	 PCjr+T6aRuJM53gfZVs8ft4phoAKjam9HOCDYH2p0/LLJuUy56En10npHnugaIiN4aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792906599;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xTW4JsqMxkxXc0tB744MRHFxl8mYQHmNE/6sY+rLBm8=;
	b=cXaVDzPkdRaGeHN6CJf5n376oa1j7u1J/aOmZgjAvfjTtU2rpD5ORoPsbbhJUFX9fTRu
	 ZxK5beukoK8HW0/DKYlWwFFN4EC4aNuFKn9QuRfQzdckNGvAe5TmAsXsUcyp4ER+13gY9
	 R+mOKkhH99MpsvJG5kNSBjhGB4BCWoAjX9r7yXKYdle+2oZvYT6Bo2RWstsybgNDZWLyG
	 ehPH/hP9MiKrQ5d+xpeEU8Ke5f2eOslxnih4EOWJtd9zA9Uajp7Jsd5kgXawWW39yqFU3
	 6+WC5LE2qugVxXjldpWDQ6x5vrTZXq2UtxbbslDqonDQZBaOxE8wHJG4YOyctikLxXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fA07ppIg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D29606A31B;
	Sun, 25 Oct 2026 05:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fA07ppIg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2561F01825;
	Sun, 25 Oct 2026 05:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792906598;
	bh=xTW4JsqMxkxXc0tB744MRHFxl8mYQHmNE/6sY+rLBm8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fA07ppIg/UpteAdwXfppq/UacM+/w6rOtzssmf9mtY/yL6WrABSW6IoCIQPcTyNiM
	 EUNRJEss+ABFdS3HhL6W3+RJsY+4QYoUA55SsAFlkbBxcbVAbWJqUnKulL4QerRvI/
	 41IGBeu2myiFpP9RqyMURJ3K6sGpOKO/dukiv4QOZcctlysTm/8SXSKHT9f66jevY7
	 39eBTGgXQt5qnSU+GbWASbVAdMB/GtvIHyx/2LP/0oq7WyBFJplsBSk1OTfKVYiVMR
	 612kov0WMASTVU2FF8C/ujsxue49m/B2tTqFr1/Axfs9xVned4x6TE6TqH2X/uxlZT
	 5uY/TzTxbadMQ==
Message-ID: <sashiko-outbox-184086@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] ALSA: virtio-snd: fix dsnoop capture with staged
 buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261025051301.54640-3-mynameisjune111@gmail.com>
References: <20261025051301.54640-1-mynameisjune111@gmail.com>
 <20261025051301.54640-3-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 05:36:37 +0000
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
- [Medium] ALSA: virtio-snd: unlatched XRUN in virtsnd_pcm_trigger() on pau=
se release
--

commit 84dba89c8170c6b6702f2442748d799772bffa04
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio-snd: fix dsnoop capture with staged buffers

This commit adds free-running staged-capture policy handling when
stop_threshold equals boundary so dsnoop capture streams do not fail with
ring_capacity rejections. It also reconstructs unread ring occupancy when
returning from free-running to bounded capture mode and returns -EPIPE if
outstanding unacknowledged data already fills the ring.

> diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
> index 663f7695b5be8..e7258bce2e6f0 100644
> --- a/sound/virtio/virtio_pcm_msg.c
> +++ b/sound/virtio/virtio_pcm_msg.c
[ ... ]
> +/* Caller holds vss->lock. */
> +int virtsnd_pcm_capture_refresh_mode_locked(struct virtio_pcm_substream =
*vss,
> +					    bool *free_running)
> +{
> +	struct snd_pcm_runtime *runtime;
> +	snd_pcm_uframes_t stop_threshold;
> +	u64 outstanding;
> +	bool new_free_running;
> +
> +	if (!vss->capture_staging || !vss->runtime_active || !vss->substream)
> +		return -EBADFD;
> +
> +	runtime =3D vss->substream->runtime;
> +	if (!runtime || !vss->buffer_bytes || !vss->capture_boundary)
> +		return -EBADFD;
> +
> +	/* Validate the currently committed policy before observing a transitio=
n. */
> +	if (!virtsnd_pcm_capture_counters_valid(vss))
> +		return -EIO;
> +
> +	stop_threshold =3D READ_ONCE(runtime->stop_threshold);
> +	new_free_running =3D stop_threshold =3D=3D vss->capture_boundary;
> +	if (new_free_running !=3D vss->capture_free_running) {
> +		outstanding =3D vss->capture_copied_total -
> +			      vss->capture_acked_total;
> +		if (new_free_running) {
> +			vss->capture_ready =3D 0;
> +		} else {
> +			if (outstanding >=3D vss->buffer_bytes)
> +				return -EPIPE;
> +			vss->capture_ready =3D outstanding;
> +		}
> +		vss->capture_free_running =3D new_free_running;
> +	}
> +
> +	*free_running =3D new_free_running;
> +	return 0;
> +}
[ ... ]
> +int virtsnd_pcm_capture_send(struct virtio_pcm_substream *vss)
> +{
> +	bool free_running;
> +	int rc;
> +
> +	rc =3D virtsnd_pcm_capture_refresh_mode_locked(vss, &free_running);
> +	if (rc)
> +		return rc;
> +
> +	return virtsnd_pcm_capture_enqueue(vss, free_running);
> +}

[Severity: Medium]
Can a staged capture substream get stuck in SNDRV_PCM_STATE_PAUSED with
vss->stopped =3D true and vss->xfer_xrun =3D false when
virtsnd_pcm_capture_refresh_mode_locked() returns -EPIPE during pause
release?

Suppose a staged capture stream (with virtsnd_capture_pause_restart=3Dfalse)
runs in free-running mode until capture_copied_total - capture_acked_total =
>=3D
vss->buffer_bytes, is paused via SNDRV_PCM_IOCTL_PAUSE(1), and then has
stop_threshold updated below boundary via snd_pcm_sw_params(). Because the
substream is in SNDRV_PCM_STATE_PAUSED, snd_pcm_running(substream) is false
and snd_pcm_sw_params() skips snd_pcm_update_state().

When the stream is subsequently resumed via SNDRV_PCM_IOCTL_PAUSE(0),
snd_pcm_do_pause() calls virtsnd_pcm_trigger(substream,
SNDRV_PCM_TRIGGER_PAUSE_RELEASE), which calls virtsnd_pcm_capture_send() ->
virtsnd_pcm_capture_refresh_mode_locked() and receives -EPIPE:

sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_trigger() {
	...
	case SNDRV_PCM_TRIGGER_START:
	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
		...
			if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE) {
				if (vss->capture_staging) {
					if (!vss->runtime_active)
						rc =3D -EBADFD;
					else
						rc =3D virtsnd_pcm_capture_send(vss);
				} else {
					rc =3D virtsnd_pcm_msg_send(vss, 0,
								  vss->buffer_bytes);
				}
			}
			if (rc) {
				vss->stopped =3D true;
				substream->runtime->stop_operating =3D true;
				return rc;
			}
}

Unlike snd_pcm_do_start(), snd_pcm_do_pause() does not transition
runtime->state to SNDRV_PCM_STATE_XRUN on -EPIPE; snd_pcm_action_single()
invokes snd_pcm_undo_pause() and leaves runtime->state in
SNDRV_PCM_STATE_PAUSED.

In sound/virtio/virtio_pcm.c:virtsnd_pcm_period_elapsed(), transitioning a
paused staged-capture stream to SNDRV_PCM_STATE_XRUN relies on vss->xfer_xr=
un
being latched and vss->elapsed_period being scheduled:

sound/virtio/virtio_pcm.c:virtsnd_pcm_period_elapsed() {
	...
	if (!snd_pcm_running(substream)) {
		scoped_guard(spinlock_irqsave, &vss->lock) {
			runtime =3D substream->runtime;
			paused_xrun =3D runtime &&
				      runtime->state =3D=3D SNDRV_PCM_STATE_PAUSED &&
				      vss->runtime_active && vss->xfer_xrun;
		}
		if (paused_xrun) {
			/* Wake readers without sending STOP for a paused stream. */
			snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
		}
		return;
	}
}

Because virtsnd_pcm_trigger() sets vss->stopped =3D true without setting
vss->xfer_xrun =3D true or scheduling vss->elapsed_period (unlike the
virtsnd_pcm_pause_restart_start() -> virtsnd_pcm_pause_restart_fail() path),
won't any reader blocked in wait_for_avail() remain asleep in
SNDRV_PCM_STATE_PAUSED while subsequent pause-release attempts fail with
-EBADFD?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025051301.5464=
0-1-mynameisjune111@gmail.com?part=3D2
