Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792909476;
	b=L9+oQohHKp3kwh8UErJyupPzXvALsDsMwNQJd1US/xne/XaGbfureXV/eWEzIm53KHqD
	 lTYnbq6qYcedMlpFP1fZ3bUbQv12AJXJVbd8hPXDqxxeFZQ/FZrf65OWCREZjg8JtWbmZ
	 lTvgy3+6jSja1agqFtAdL4qpQ0QkOj0lv1RMF5X64I7tGllXxs9vcVW8W1g8b9XaCjw81
	 3Z/gzz4m9klFdNbj7NSUnsLWWrbVBOb0SLVbRevS5kRx8zkvhe73SfdTx7eS3wGKCIRe6
	 XSv1g6kAhNL4bWhmYwSWbFt+F+h+D1HCXU1LGJnc3KynJTOFjZxOWUxRpXa0g+K31gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792909476;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uNOWxIeZhKbX6LHAaBJWt2AHKbdLthP5EO4Y47msDYY=;
	b=ZQe4jkvtfsfilSrQdvIEnXKLWXn8kNLO7amfPZNlXdDSacSwUQyJYDq/cLivgKOh6yrf
	 lqR0ZA0+FZYQ2Ue97V75yVd5x/+vEPDtoafOeg4XvVSo3v5DSOpCAiZ2YbShGM/OdFokn
	 jityY6XcmXYy8nfpUizAvlLqrtAPzP2o8w1n2yQNlD9GxppHjU66d+yYR6VBbaQfA9Xsw
	 H6mWt8WzKqWQmCUe9KQalcv6e4m6nPyWI44H6hGnlzcSaX24Wbkj61qYzRSZJCbOooP9Y
	 hVbil1oC6QluZtS6lwrfXGSiL5GOHT1qw27BvB4atKaPiNWZnDEWC3awioe1DN+/mOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PAeBNeTx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47854606A31A;
	Sun, 25 Oct 2026 06:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PAeBNeTx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881571F01825;
	Sun, 25 Oct 2026 06:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792909475;
	bh=uNOWxIeZhKbX6LHAaBJWt2AHKbdLthP5EO4Y47msDYY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PAeBNeTxZ5pmimhlPzHR+S6SqHFU4kVY0h0dnUZdoa7Xwn8xBfQGCIICbrk4S9plI
	 Cfw7C4jpsCLXNtLju7bGCf6qsG/PFn2D4oJf0WfgDD2WZLLUiGN1eUTqCMgNsQ86uf
	 HZ1SHofto2+r0Lyeye8WH5t1fkhtcQ5mP4PsgykXFcOupqsA4yCSA/gW6UOuM+TDdd
	 Vmwpgk/bkFcIDjIPGPXxp7B2HIs4X7udsbYYUYCOvO0f/MVt+RJcIbYf74wKfHdXf+
	 p/3LD0PISG6IvxLRSL67XvjUWKHkKcRYHLeOg+j0n+7cII6r3RyiPIdsGEaYHb0Cqh
	 N2yMIDGdP2KMA==
Message-ID: <sashiko-outbox-184095@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] ALSA: virtio-snd: fix dsnoop capture with staged
 buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261025055702.69259-3-mynameisjune111@gmail.com>
References: <20261025055702.69259-1-mynameisjune111@gmail.com>
 <20261025055702.69259-3-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 06:24:34 +0000
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
- [High] ALSA: virtio-snd: missing stop_operating when paused capture hits =
XRUN
--

commit 6569a6d061b2d8bd7d031671c88c23ff7eb99711
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio-snd: fix dsnoop capture with staged buffers

This commit updates virtio-snd staged capture to detect free-running mode
when stop_threshold equals boundary, allowing dsnoop clients to consume
the capture ring without advancing appl_ptr. It also validates unread
ring occupancy when transitioning back to bounded capture and triggers an
XRUN if outstanding data fills the ring.

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index d50924b792f65..622a5d7706b44 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c
[ ... ]
> @@ -893,6 +905,13 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substr=
eam *substream, int command)
>  			if (rc) {
>  				vss->stopped =3D true;
>  				substream->runtime->stop_operating =3D true;
> +				if (vss->capture_staging &&
> +				    vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE &&
> +				    command =3D=3D SNDRV_PCM_TRIGGER_PAUSE_RELEASE) {
> +					/* Pause undo leaves ALSA paused; wake its readers. */
> +					vss->xfer_xrun =3D true;
> +					virtsnd_pcm_schedule_period_elapsed(vss);
> +				}
>  				return rc;
>  			}
>  			vss->xfer_enabled =3D true;
[ ... ]
> @@ -1244,14 +1269,18 @@ static int virtsnd_pcm_capture_staged_ack(struct =
virtio_pcm_substream *vss,
>  		snd_pcm_uframes_t appl_ptr;
>  		snd_pcm_sframes_t diff;
>  		size_t bytes;
> +		u64 outstanding;
>  		u64 next_acked_total;
> +		bool free_running;
> =20
>  		if (!vss->runtime_active || !runtime || !runtime->control ||
>  		    !runtime->dma_area)
>  			return -EBADFD;
>  		if (vss->xfer_xrun)
>  			return -EPIPE;
> -		if (!virtsnd_pcm_capture_counters_valid(vss)) {
> +		rc =3D virtsnd_pcm_capture_refresh_mode_locked(vss,
> +							     &free_running);
> +		if (rc || !virtsnd_pcm_capture_counters_valid(vss)) {
>  			vss->xfer_xrun =3D true;
>  			virtsnd_pcm_schedule_period_elapsed(vss);
>  			return -EPIPE;

[Severity: High]
What happens if virtsnd_pcm_capture_staged_ack() in
sound/virtio/virtio_pcm_ops.c detects an overflow or validation failure whi=
le
the substream is in SNDRV_PCM_STATE_PAUSED?

Suppose a staged capture stream runs in free-running mode until
outstanding >=3D vss->buffer_bytes, and userspace pauses the stream via
SNDRV_PCM_IOCTL_PAUSE. While paused, userspace lowers stop_threshold via
SNDRV_PCM_IOCTL_SW_PARAMS (which does not call snd_pcm_update_state() becau=
se
snd_pcm_running() is false) and advances appl_ptr via read(),
snd_pcm_forward(), or snd_pcm_sync_ptr().

This invokes pcm_lib_apply_appl_ptr() -> virtsnd_pcm_cp_ack() ->
virtsnd_pcm_capture_staged_ack(), where virtsnd_pcm_capture_refresh_mode_lo=
cked()
sees outstanding >=3D vss->buffer_bytes and returns -EPIPE. Unlike the
SNDRV_PCM_TRIGGER_PAUSE_RELEASE error path in virtsnd_pcm_trigger(),
virtsnd_pcm_capture_staged_ack() sets vss->xfer_xrun =3D true and schedules
vss->elapsed_period without setting vss->stopped =3D true or
substream->runtime->stop_operating =3D true:

sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_capture_staged_ack() {
	...
	rc =3D virtsnd_pcm_capture_refresh_mode_locked(vss,
						     &free_running);
	if (rc || !virtsnd_pcm_capture_counters_valid(vss)) {
		vss->xfer_xrun =3D true;
		virtsnd_pcm_schedule_period_elapsed(vss);
		return -EPIPE;
	}
	...
}

When pcm_lib_apply_appl_ptr() receives -EPIPE, it calls __snd_pcm_xrun() ->
snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN) (which is also what
virtsnd_pcm_period_elapsed() in sound/virtio/virtio_pcm.c calls on its
paused_xrun path). Because snd_pcm_running(substream) is false when
runtime->state is SNDRV_PCM_STATE_PAUSED, snd_pcm_stop() transitions
runtime->state to SNDRV_PCM_STATE_XRUN without calling
ops->trigger(SNDRV_PCM_TRIGGER_STOP) or setting runtime->stop_operating =3D=
 true.

When userspace then calls snd_pcm_prepare() to recover from XRUN, ALSA skips
both the SNDRV_PCM_STATE_PAUSED cleanup block and virtsnd_pcm_sync_stop():

sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_prepare() {
	...
	scoped_guard(spinlock_irqsave, &vss->lock)
		stopped =3D vss->stopped;
	if (stopped) {
		dev_err(&vdev->dev, "SID %u: stream release failed\n",
			vss->sid);
		substream->runtime->stop_operating =3D true;
		return -EBADFD;
	}

	if (!vss->suspended) {
		if (virtsnd_pcm_msg_pending_num(vss)) {
			dev_err(&vdev->dev, "SID %u: invalid I/O queue state\n",
				vss->sid);
			return -EBADFD;
		}
	...
}

In default native pause mode, virtsnd_pcm_msg_pending_num(vss) is still
non-zero, so virtsnd_pcm_prepare() fails with -EBADFD without setting
runtime->stop_operating, leaving RX buffers queued in the virtqueue across
subsequent prepare(), hw_params(), hw_free(), and close() calls. In
capture_pause_restart mode, vss->stopped is true, so the first
virtsnd_pcm_prepare() call also fails with -EBADFD.

Should virtsnd_pcm_capture_staged_ack() (or virtsnd_pcm_period_elapsed() wh=
en
handling paused_xrun) also mark vss->stopped =3D true and
runtime->stop_operating =3D true when transitioning a paused stream to XRUN=
, or
should virtsnd_pcm_prepare() arm runtime->stop_operating when
virtsnd_pcm_msg_pending_num(vss) is non-zero?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025055702.6925=
9-1-mynameisjune111@gmail.com?part=3D2
