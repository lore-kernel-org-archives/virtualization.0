Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793848053;
	b=U/otp79ajofUC1eG5THBA1OOOHH3dAtEURN52XJzzoz+dzpMT0LxpgwseBYSNVxP3SDv
	 SidKnh+USgD4ED2QCA7XiyUCIySg5PYKv8xTeLxbwX1O/7nJiXFw3pxOnSojMuHHjI2eE
	 368ThNcz7qLPemmYXQdmsGAqiU0lgnl3aAq90/sgTNj/otp4ii9aPDg82RrdXZ7Swa4QB
	 0K9TbI68SY4TukSlgKHCIwCYaEFLkqjhm2UhxS7r5QmvrdRuVYOX3mQgIZFYqKXjcvAty
	 pe4CAXL0QCAUQBE87sK0RViuf+xGwqm0DUQReo30LZDcV6GmHlhEEOtv3j4L0TpXQnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793848053;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+l9X9JzpaphtIHszRsUDEXIuY5/t0JbWcMpgaMXx0aA=;
	b=JF0WRUeFCI+LbzoIXXaM7zayorCkWh3JiDa4KBsmZWN1UvZfhKKf77M6rGY3vinwOtPv
	 aQWf/7iKemHI4/O4M0gO91W7YxHonJpKgvR1ribYgCLcw1EpjNVWxhwS0bKFb6WI9HmDd
	 d1M8XHIHMGKWmEzHSNpNAc+CKZvaxcRA4v56p3vXpOhnOOxQ8oasPWgPdYjbFN8lWCi1r
	 pcKOrVst63ClpqdNvcfvevPybawCoEII0bW1+La/vntT+rzOviElNraSRatBoNWe2r+c8
	 VzDP8ogDxS64Dyu16mJYwLApWDdmPMUbLVzp3+w0uTgOdhTzp/JEYyX4mKIMiLdcEEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aivuhLe/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4C7606A32D;
	Thu,  5 Nov 2026 03:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aivuhLe/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953831F000C1;
	Thu,  5 Nov 2026 03:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793848052;
	bh=+l9X9JzpaphtIHszRsUDEXIuY5/t0JbWcMpgaMXx0aA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aivuhLe/AfIgqeMsn2bz/w5qncKtPHs7gEoeAz6kbodhDL34oypWI6UBiOKeZvkJP
	 FWxL99Xz1orfFcJRMPWyGDzJq7dSV9kNNtTiMga18CwFhKFuAPV+WLyacQsywyvm+D
	 j5K2twXWmwcRPUxntUT8N/XFaud6x24osCgtjLXrVb0YkY90daNY82G6bKIr61rLJ3
	 ABije3KsjDYgcyl7SKq2GWJmJvC51U/rBM7b/yXIZvnQNyKShRSilR+jnypfwthF3M
	 d8sZpWkKaH7uEk0ujF1+fdtNcpA8IprHGlwYCDog+Q8jZCfOXYAIDC2COrVsnUU5iJ
	 UiiSa+JzfylBg==
Message-ID: <sashiko-outbox-198503@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 04/12] ALSA: virtio: Propagate PCM send failures
 through ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105023140.18373-5-mynameisjune111@gmail.com>
References: <20261105023140.18373-1-mynameisjune111@gmail.com>
 <20261105023140.18373-5-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 03:07:31 +0000
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
- [Medium] ALSA: virtio: premature virtsnd_pcm_ack_state() check in ACK cal=
lbacks
--

commit b3ba01532fee86b2ac84f575484ddc4585f0147e
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: Propagate PCM send failures through ACK

This commit propagates message submission failures from virtsnd_pcm_msg_sen=
d()
through the indirect PCM transfer callback in the playback and capture ACK
handlers. It also introduces prepared and preparing state tracking to gate =
ACK
admission across teardown, prepare, and pointer reset operations.

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index 1091100a4c982..83199a94e2c5e 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c

[ ... ]

> @@ -461,41 +530,167 @@ virtsnd_pcm_cp_pointer(struct snd_pcm_substream *s=
ubstream)

[ ... ]

> +/* The caller holds the PCM lock, also used by DROP and state transition=
s. */
> +static int virtsnd_pcm_ack_state(struct snd_pcm_substream *substream)
> +{
> +	switch (substream->runtime->state) {
> +	case SNDRV_PCM_STATE_XRUN:
> +		return -EPIPE;
> +	case SNDRV_PCM_STATE_PREPARED:
> +	case SNDRV_PCM_STATE_RUNNING:
> +	case SNDRV_PCM_STATE_PAUSED:
> +	case SNDRV_PCM_STATE_DRAINING:
> +		if (atomic_read(&substream->runtime->buffer_accessing) < 0)
> +			return -EBADFD;
> +		return 0;
> +	default:
> +		return -EBADFD;
> +	}
> +}
> =20
>  static int virtsnd_pcm_pb_ack(struct snd_pcm_substream *substream)
>  {
>  	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
>  	struct virtio_snd_queue *queue =3D virtsnd_pcm_queue(vss);
> +	struct virtsnd_pcm_transfer transfer =3D {};
> +	int rc;
> +
> +	rc =3D virtsnd_pcm_ack_state(substream);
> +	if (rc)
> +		return rc;
> =20
> -	guard(spinlock_irqsave)(&queue->lock);
> -	guard(spinlock)(&vss->lock);
> +	scoped_guard(spinlock_irqsave, &queue->lock) {
> +		guard(spinlock)(&vss->lock);
> +		if (vss->preparing || !vss->prepared)
> +			return -EBADFD;

[ ... ]

>  static int virtsnd_pcm_cp_ack(struct snd_pcm_substream *substream)
>  {
>  	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
>  	struct virtio_snd_queue *queue =3D virtsnd_pcm_queue(vss);
> +	struct virtsnd_pcm_transfer transfer =3D {};
> +	int rc;
> +
> +	rc =3D virtsnd_pcm_ack_state(substream);
> +	if (rc)
> +		return rc;
> =20
> -	guard(spinlock_irqsave)(&queue->lock);
> -	guard(spinlock)(&vss->lock);
> +	scoped_guard(spinlock_irqsave, &queue->lock) {
> +		guard(spinlock)(&vss->lock);
> +		if (vss->preparing || !vss->prepared)
> +			return -EBADFD;

[Severity: Medium]
Should virtsnd_pcm_pb_ack() and virtsnd_pcm_cp_ack() check vss->preparing a=
nd
vss->prepared under vss->lock before evaluating virtsnd_pcm_ack_state()?

When snd_pcm_prepare() is invoked on a substream in SNDRV_PCM_STATE_XRUN, t=
he
ALSA core leaves runtime->state as SNDRV_PCM_STATE_XRUN throughout
snd_pcm_do_prepare() (across the sleeping virtsnd_pcm_sync_stop() and
virtsnd_pcm_prepare() calls) until snd_pcm_post_prepare() runs.

Because virtsnd_pcm_ack_state() checks SNDRV_PCM_STATE_XRUN before
vss->preparing and vss->prepared are checked, a concurrent
SNDRV_PCM_IOCTL_SYNC_PTR (or rewind/forward) updating appl_ptr via
pcm_lib_apply_appl_ptr() during XRUN recovery receives -EPIPE instead of
-EBADFD. That causes pcm_lib_apply_appl_ptr() to call __snd_pcm_xrun()
mid-prepare, forcing any linked substreams into SNDRV_PCM_STATE_XRUN and
recording a spurious XRUN.

Similarly, when linked substreams are prepared via snd_pcm_action_group(),
snd_pcm_do_prepare() (including virtsnd_pcm_reset(), which sets
vss->prepared =3D true and vss->preparing =3D false) completes on each memb=
er
before snd_pcm_post_prepare() updates runtime->state to
SNDRV_PCM_STATE_PREPARED, and while snd_pcm_buffer_access_lock() still holds
buffer_accessing < 0 on the primary substream. While a later linked member
sleeps in snd_pcm_do_prepare(), an earlier member that has already finished
virtsnd_pcm_reset() still has runtime->state set to SNDRV_PCM_STATE_SETUP or
SNDRV_PCM_STATE_XRUN (or buffer_accessing < 0 when re-prepared from
SNDRV_PCM_STATE_PREPARED), causing virtsnd_pcm_ack_state() to reject a
concurrent SNDRV_PCM_IOCTL_SYNC_PTR with -EBADFD or -EPIPE.

Although the later commit ("ALSA: virtio: add staged capture and serialize
PCM lifecycle accounting") removes the buffer_accessing check from
virtsnd_pcm_ack_state(), virtsnd_pcm_ack_state() is still evaluated before
vss->preparing and vss->prepared, leaving the SNDRV_PCM_STATE_XRUN and
SNDRV_PCM_STATE_SETUP ordering issues in place.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105023140.1837=
3-1-mynameisjune111@gmail.com?part=3D4
