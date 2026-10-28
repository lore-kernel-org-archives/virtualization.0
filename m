Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793182852;
	b=Z96J42Ck1b3/+hj+2QsuD0mK8X3C2hsDlFuykWhOpgbw8wOBaTDMjiGLzWiy4Sbe1PKu
	 3eg6dSD2b7n+eMsQkH1l8kDBHiTnL2pzSEm/8iFy22gVMYxp2Gn17YDvNnEQsNTXegES5
	 ceAwwc3jLFNVw9y6KWGspbUhbgpitxNHMm/oSrBYx0rrhH1M+AzJRvb4J2pUIva2y04NJ
	 kZoTetOPyPrNV3XLLufo4ac+DXTca4ktl8pp1C8AIx+9ncDBCzDAmvBJnX3OoHPwf8m28
	 y2zTnu+Szwc/A5F2H1Mfy/JICFEKVWp+X9UgU+25iPUlv6C7v3Qel9Zh+u1fV6jiomw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793182852;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KWHlXyNznmRYxeQqRYQEvoRSplax05puUR1ke56I9gY=;
	b=dznH3OfckbdzH5TyO73GG98Wg96y2IQlLQXuxbMf+4c0ysDvLJnaf3Yd4yZPm7jjCf+J
	 8gRSr1eYnb97tkcUvvA4eOCrWIBJjXXVn+hQ43b4YX1ABfSZ92SJtaDEQDDUDnnGbMixZ
	 7BKvJt3Upj3XDjA6ejxNVmscMd3/6KYkIMh8HxEeJBXtPUuuYDcNpqluuN3kkyGBpvDoq
	 dgtd0FgGOQi2gB3N7sJ+TVil86jiLGuEPvBhV/ZtyL1RI0xjm9bBEjYhMgC4/0JwavaGm
	 hY9Y4hQ+ZcizlyCjt9dM3brS8aDc2KPHlv4JWxlAfsra6Wvt6Fk1V3mT3fDYTIkmvzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nn/2by/L";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B4A606A31D;
	Wed, 28 Oct 2026 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nn/2by/L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CEEE1F01825;
	Wed, 28 Oct 2026 10:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793182851;
	bh=KWHlXyNznmRYxeQqRYQEvoRSplax05puUR1ke56I9gY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nn/2by/LVrkA2yvLqK/ubJIKvMMR3pQ8cs+RFAhAnxmv1fbq4tXwwxQy6eS0CJ/z4
	 imBcejQZl8oVMmOscH1DWYaux1htrCKsxLmCoyNuHKZU+Bf2dcUHkLydGSC6NeY22A
	 +1rLezXE00l7AajNYtG7TM4GUaFnhPTtwDGXhgz5f15eIoWDZXl5yA5fhZ4xxZf+OI
	 EuaGVDHGIkJkqiUeOvlBdeNnk26QLgsaDEgv7muamasB5HqMRzIBXhlZ5wOjJPVbpb
	 MWbBkApy9TkdVM3RIO0pbLEwFUdKz8cOyeSzAbjqg0fAP0IuyV5xe0n75ODDe8nd/e
	 v5wlENOHyfkLw==
Message-ID: <sashiko-outbox-187742@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/16] ALSA: virtio-snd: fix dsnoop capture with
 staged buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028094132.20364-12-mynameisjune111@gmail.com>
References: <20261028094132.20364-1-mynameisjune111@gmail.com>
 <20261028094132.20364-12-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 10:20:51 +0000
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
- [Medium] ALSA: virtio-snd: incomplete XRUN handling in virtsnd_pcm_trigge=
r()
--

commit aaa1fb5901e460bfc006edef14710cb64e262e44
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio-snd: fix dsnoop capture with staged buffers

This commit adds free-running staged capture policy support when
stop_threshold equals the prepared boundary so dsnoop capture streams do not
fail capacity checks. It also reconstructs unread occupancy when returning =
to
bounded capture and handles XRUN state transitions across paused streams.

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index d50924b792f65..cbf4e479d295f 100644
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

[Severity: Medium]
What happens in virtsnd_pcm_trigger() if a staged capture stream using nati=
ve
pause (with virtsnd_capture_pause_restart disabled) hits another failure or
prior XRUN during SNDRV_PCM_TRIGGER_PAUSE_RELEASE?

Unlike virtsnd_pcm_pause_restart_start(), the native trigger path in
virtsnd_pcm_trigger() does not check vss->xfer_xrun under vss->lock before
queueing requests:

sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_trigger() {
	case SNDRV_PCM_TRIGGER_START:
	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
		queue =3D virtsnd_pcm_queue(vss);

		scoped_guard(spinlock_irqsave, &queue->lock) {
			guard(spinlock)(&vss->lock);
			if (vss->stopped) {
				substream->runtime->stop_operating =3D true;
				return -EBADFD;
			}
			if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE) {
				if (vss->capture_staging) {
					if (!vss->runtime_active)
						rc =3D -EBADFD;
					else
						rc =3D virtsnd_pcm_capture_send(vss);

If vss->xfer_xrun was already latched before SNDRV_PCM_TRIGGER_PAUSE_PUSH
while virtsnd_pcm_period_elapsed() was waiting on the PCM stream lock, won't
SNDRV_PCM_TRIGGER_PAUSE_RELEASE succeed, set vss->xfer_enabled =3D true, and
send VIRTIO_SND_R_PCM_START on a stream that is already in XRUN (causing
subsequent completions in virtsnd_pcm_capture_complete() to be dropped)?

Additionally, if virtsnd_pcm_capture_send() succeeds during
SNDRV_PCM_TRIGGER_PAUSE_RELEASE, but virtsnd_pcm_ctl_msg_alloc() or
virtsnd_ctl_msg_send_sync() fails afterwards, virtsnd_pcm_trigger() calls
virtsnd_pcm_start_failed(vss, false):

sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_start_failed() {
	scoped_guard(spinlock_irqsave, &vss->lock) {
		vss->xfer_enabled =3D false;
		vss->stopped =3D true;
		if (pause_restart)
			vss->xfer_xrun =3D true;
	}
	vss->substream->runtime->stop_operating =3D true;
}

Because pause_restart is false here (and the early vss->stopped check also
returns -EBADFD directly), neither path sets vss->xfer_xrun =3D true or cal=
ls
virtsnd_pcm_schedule_period_elapsed(vss). When ALSA undoes the failed pause
release and leaves runtime->state in SNDRV_PCM_STATE_PAUSED with
vss->stopped =3D=3D true, could readers blocked in wait_for_avail() or
snd_pcm_poll() be left sleeping without virtsnd_pcm_period_elapsed() ever
moving the stream to SNDRV_PCM_STATE_XRUN?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028094132.2036=
4-1-mynameisjune111@gmail.com?part=3D11
