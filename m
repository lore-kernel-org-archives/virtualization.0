Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793254233;
	b=cYcMN0MxQcoUUzMmmASNycJuHO/InPOe/GNvTsji4WhOMn9QxyK+SKOF95O6OFU6zNmb
	 kQseRg6TRYD3xbMizSrwHi+wsl8ZLC5kcCLuOvKt4VsY4Ig1DkQRX+H/x/MCplH1MfKqX
	 WpmUMhrPEmnr3/1zUu/2s41P6lq0dePT/Fsvh3QRZmEFholSCM0NNrFcUhvB2V++AD5zP
	 +ltmoaN7gT8LvuVne0H4vlJuP07Z1QmzLvKGH7RkYGJIl+gcYmMZlzqUxcxDBufP8SQpD
	 uQEgaMDg/oYfdqt0XGK6c46F0NTSlIbXLG5QM3inx6JxJZ9CKWz84TJUDBKbDBKBStg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254233;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=L/X5IEYHAt13vls0V/Tm8764OpoEKdj/tCgZCNr8eaM=;
	b=INoo6bnKstjyzMRMv/WjTyAbfrXZ9h8DoiSHidOJj8FbcdaeFwoO0CInaapj2L4txnmg
	 Aqq3oPIfpyr5D9Bw52g8JQOXjy/mLJOb7Ymv7ZsEELe2P4Ch1DlQZry0ZA46d+ypAxTck
	 x4wZuUrWp5jSJ3dkPLogOzg2QENcJ9HpY9ma8f8KrHE1WRPgvIL9Lw36J1SGqgdEYFb/P
	 YvZFNUpfzLoV2UyKEmXVbJu20CkUOZjytVirz51/1NfxWPQSVGqO3xw8zN0AkWecAEXxl
	 6QZpnXX2OQ13VvuubKPLbz7lMnveNcOT6HqwlBTubW0J/OLgVvw3pCaK0pSR75aR6pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XfWPE0ZG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FB8606A31A;
	Thu, 29 Oct 2026 06:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XfWPE0ZG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845971F01825;
	Thu, 29 Oct 2026 06:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793254232;
	bh=L/X5IEYHAt13vls0V/Tm8764OpoEKdj/tCgZCNr8eaM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XfWPE0ZGOQJ5I37oLvbTOQVs/4OlfA48joYOHaiA+BSrYKPtEo6ytjbXwdfV77IH1
	 EHHTPtVkP1MF3T02nu9AVobYVZuQN6ZJfv97nurlCkneXlwoAqvXf84fDf4qBDXctb
	 PG//btKZEVL3EhqH6lFhRG+CoGt4nhi1dCF1Ll6jPQ6O1dxD0m54XguKrmnlPPV1l4
	 M/lSWcbJj6ScUVu/YNae4m5FLg9IGEulylLC9zRlwqtQPmQVINcZ8KlBZK3ojD+KiD
	 9ixrDjw3T8d6hNTcCAbvGVEnEVkQuaXAJIXrQv2MqjF82j6jjDQGlkRqtLQS5ATPta
	 4EjIQydda34Sw==
Message-ID: <sashiko-outbox-188795@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 02/14] ALSA: virtio: Recover PCM state after a failed
 start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029054354.2931-3-mynameisjune111@gmail.com>
References: <20261029054354.2931-1-mynameisjune111@gmail.com>
 <20261029054354.2931-3-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 06:10:32 +0000
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
- [Medium] ALSA: virtio: virtsnd_pcm_sync_stop() resends PCM_RELEASE after =
drain failure
--

commit 8526e884d4c74a3678dceb6e148567c0ca936c95
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: Recover PCM state after a failed start

This patch recovers PCM substream state when a start trigger fails by marki=
ng
the stream stopped, disabling transfers, arming stop_operating, and protect=
ing
accesses to the stopped flag with vss->lock.

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index a40ea394bf174..970499fe419b4 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c
[ ... ]
> @@ -115,7 +124,8 @@ static int virtsnd_pcm_open(struct snd_pcm_substream =
*substream)
>  	snd_pcm_hw_constraint_integer(substream->runtime,
>  				      SNDRV_PCM_HW_PARAM_PERIODS);
> =20
> -	vss->stopped =3D !!virtsnd_pcm_msg_pending_num(vss);
> +	scoped_guard(spinlock_irqsave, &vss->lock)
> +		vss->stopped |=3D !!vss->msg_count;
>  	vss->suspended =3D false;
[ ... ]
> @@ -393,21 +434,31 @@ static int virtsnd_pcm_sync_stop(struct snd_pcm_sub=
stream *substream)
>  	struct virtio_snd *snd =3D vss->snd;
>  	struct virtio_snd_msg *msg;
>  	unsigned int js =3D msecs_to_jiffies(virtsnd_msg_timeout_ms);
> +	bool need_release;
>  	int rc;
> =20
> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		vss->xfer_enabled =3D false;
> +		need_release =3D vss->stopped || vss->msg_count;
> +		if (need_release)
> +			vss->stopped =3D true;
> +	}
>  	cancel_work_sync(&vss->elapsed_period);
> -
> -	if (!vss->stopped)
> +	if (!need_release)
>  		return 0;
> =20
>  	msg =3D virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_RELEASE,
>  					GFP_KERNEL);
> -	if (!msg)
> +	if (!msg) {
> +		substream->runtime->stop_operating =3D true;
>  		return -ENOMEM;
> +	}
> =20
>  	rc =3D virtsnd_ctl_msg_send_sync(snd, msg);
> -	if (rc)
> +	if (rc) {
> +		substream->runtime->stop_operating =3D true;
>  		return rc;
> +	}
> =20
>  	/*
>  	 * The spec states that upon receipt of the RELEASE command "the device
> @@ -421,11 +472,13 @@ static int virtsnd_pcm_sync_stop(struct snd_pcm_sub=
stream *substream)
>  	if (rc <=3D 0) {
>  		dev_warn(&snd->vdev->dev, "SID %u: failed to flush I/O queue\n",
>  			 vss->sid);
> +		substream->runtime->stop_operating =3D true;
> =20
>  		return !rc ? -ETIMEDOUT : rc;
>  	}
> =20
> -	vss->stopped =3D false;
> +	scoped_guard(spinlock_irqsave, &vss->lock)
> +		vss->stopped =3D false;
> =20
>  	return 0;
>  }

[Severity: Medium]
Can virtsnd_pcm_sync_stop() send a duplicate VIRTIO_SND_R_PCM_RELEASE comma=
nd
if the post-release queue drain wait is interrupted or times out?

In virtsnd_pcm_sync_stop(), after virtsnd_ctl_msg_send_sync() succeeds for
VIRTIO_SND_R_PCM_RELEASE, wait_event_interruptible_timeout() waits for
in-flight I/O messages to drain. If a signal is pending or the wait times o=
ut
before the last message completes, virtsnd_pcm_sync_stop() sets
substream->runtime->stop_operating =3D true and returns an error while leav=
ing
vss->stopped =3D true.

Once the device finishes returning the remaining I/O messages and
vss->msg_count reaches 0, vss->stopped remains true because a single boolean
tracks both whether VIRTIO_SND_R_PCM_RELEASE still needs to be sent and
whether pending I/O messages have finished draining.

Because virtsnd_pcm_open() now uses vss->stopped |=3D !!vss->msg_count, and
virtsnd_pcm_hw_params() and virtsnd_pcm_prepare() reject the substream with
-EBADFD while vss->stopped is true, the next virtsnd_pcm_sync_stop() call
(during close, hw_free, prepare, hw_params, or reopen via virtsnd_pcm_open(=
))
sees need_release =3D vss->stopped || vss->msg_count as true and sends a se=
cond
VIRTIO_SND_R_PCM_RELEASE command for a stream that was already released. If
the device rejects the duplicate release command, virtsnd_pcm_sync_stop()
fails again and leaves vss->stopped =3D true, wedging the substream.

Note that a later commit in the series ("ALSA: virtio: add staged capture
accounting and lifecycle recovery") changes the drain wait in
virtsnd_pcm_sync_stop_locked() to wait_event_timeout() and tracks
VIRTSND_PCM_PAUSE_RESTART_RELEASE_SENT in the opt-in pause-restart state
machine, but the default virtsnd_pcm_sync_stop_locked() path still leaves
vss->stopped =3D true (and vss->prepared =3D true) if the drain wait times =
out
after VIRTIO_SND_R_PCM_RELEASE succeeded.

Should the driver track whether VIRTIO_SND_R_PCM_RELEASE has already succee=
ded
separately from whether vss->msg_count has drained to 0, so a subsequent
virtsnd_pcm_sync_stop() only waits for remaining messages to drain instead =
of
resending VIRTIO_SND_R_PCM_RELEASE?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029054354.2931=
-1-mynameisjune111@gmail.com?part=3D2
