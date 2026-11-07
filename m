Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794064016;
	b=X3rAAmj/tW9rqR0WXYJnaqeHEgFF6DFaIjotoVj85lnufrTG6LRDwTYZdNQ7Lr/7/lXX
	 B5fBmhMKlx+CVRQmmko8Vr2PXIIxwdC3FeL7M+quZcDQpWEusUgjchD4gDWxvzCbyYbz9
	 xI1pJaWC7xwsFXqnk8kAG6ScVYWYqVW/XdbtNkPkws3cJzYO1VpD9n8t4hCWYxoZEgjZj
	 nncZtpEST4i95eEMuyws7KSSEQnIrbhQVtttM1DyeViM8sizsFDSJ+9hUGGaGOPU4zVrc
	 zYmO86+icUnvArq5pE68k7VifYLLE/5at+iotQAelohvTedziTMwkBG5xE/fq3SUIjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794064016;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LTWwDK2LasgvhbV1wRe/mLbex3G7WhPtXDFqv7AiTcU=;
	b=lz4ZlDBNKyek96Ox6wJAWUz0tWUMfcKGk9xm/2v61qqit6zj4FxB2dGikKtx4u7pUfIl
	 Jjg5EY9NHPu5GXshvYpu0o46ZyLxLyeacH3ISt8LBVfjE5gZSMX8yVwXGJ3S0OP2OAD0n
	 4BsXfT3LrIe7/PKXhc5ZkzyAfyDXa2hwL5NvLuEkBCZFFV6lLq5UoofkkSdQcWP9j3Cxa
	 Etfjesy4f5BTEucQineIozic24cLNSdMr2+S+Nrntz1zrpErEkCwsN8gLuRwBOXneA8iB
	 SChXjNbnxAHs/2pYA7k5k6gxis+hSxhenA+CUhmblOifJW5pEpyeDID+qR/Ix//wjLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RVOBIgmh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ECE6082BED;
	Sat,  7 Nov 2026 15:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RVOBIgmh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B06B1F0089F;
	Sat,  7 Nov 2026 15:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794064016;
	bh=LTWwDK2LasgvhbV1wRe/mLbex3G7WhPtXDFqv7AiTcU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RVOBIgmh1tB3g0X0+LbJ4w1/EQdfDA0GXJ+Hcl0H4rhMaiVStIxTbIPAyMNRibXnM
	 W+A/KGWGZK4eilqlb1Dr2k9p/CkiGfGMeCk68Mi757xNrxn4eVYvXuGKCqGXiBWkXd
	 DenZ9AZU+oQke1ghJNSYQcS8zEQ6HAYCOfBBas6D0O1mN2mQ9T3u65gZbDFJTULbH4
	 VDalpOdHdxXFnQtNoDnR+fHJRRK/DLD3x+ZlAxwWVCFocXDO0MTvaBEeshONbLcy2m
	 IRwIJPNKSq3lS6QXbVSJ46zFjIwW0QJ0/94VNzCv19eDAoXS0zsBPFRcSyvtf2YsIw
	 VdGj5yoBk8zMQ==
Message-ID: <sashiko-outbox-202983@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 10/12] ALSA: virtio: serialize staged capture
 lifecycle and defer paused XRUNs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261107143422.29319-11-mynameisjune111@gmail.com>
References: <20261107143422.29319-1-mynameisjune111@gmail.com>
 <20261107143422.29319-11-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 15:06:55 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] ALSA: virtio: start race in virtsnd_pcm_start_queue() while
  preparing is set
- [Medium] ALSA: virtio: virtsnd_pcm_sync_stop() drops stop_operating
  when paused
--

commit 55539e87ca936ab2bb90a3215a575e0a0a27b88c
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: serialize staged capture lifecycle and defer paused XRUNs

This commit adds staged capture support using request-owned RX buffers,
serializes PCM lifecycle operations with lifecycle_lock, and defers
paused XRUN notifications until stream resume.

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index 8fe6974130270..c7125074f6425 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c

[ ... ]

> @@ -323,182 +645,779 @@ static int virtsnd_pcm_hw_params(struct snd_pcm_s=
ubstream *substream,

[ ... ]

> +static int virtsnd_pcm_prepare_locked(struct snd_pcm_substream *substrea=
m)
>  {

[ ... ]

> +	scoped_guard(pcm_stream_lock_irqsave, substream) {
> +		guard(spinlock_irqsave)(&vss->lock);
> +		if (epoch !=3D vss->reset_epoch || vss->resetting)
> +			return -ECANCELED;
>  		vss->release_required =3D true;
> +		vss->buffer_bytes =3D snd_pcm_lib_buffer_bytes(substream);
> +		vss->hw_ptr =3D 0;
> +		vss->suspended =3D false;
> +		vss->msg_count =3D 0;
> +		virtsnd_pcm_msg_reset(vss);
> +		memset(&vss->pcm_indirect, 0, sizeof(vss->pcm_indirect));
> +		vss->pcm_indirect.sw_buffer_size =3D vss->buffer_bytes;
> +		vss->pcm_indirect.hw_buffer_size =3D vss->buffer_bytes;
> +		if (vss->capture_staging) {
> +			vss->capture_boundary =3D substream->runtime->boundary;
> +			rc =3D virtsnd_pcm_capture_refresh_mode_locked(vss,
> +							     &free_running);
> +			if (rc) {
> +				vss->xfer_xrun =3D true;
> +				vss->stopped =3D true;
> +				return rc;
> +			}
> +		}
> +		vss->prepared =3D true;
> +		vss->stopped =3D false;
> +		vss->xfer_xrun =3D false;
>  	}
> +
> +	return rc;
>  }

[ ... ]

> +static int virtsnd_pcm_start_queue(struct virtio_pcm_substream *vss, u64=
 epoch)
> +{
> +	struct virtio_snd_queue *queue =3D virtsnd_pcm_queue(vss);
> +	int rc =3D 0;
> +
> +	guard(spinlock_irqsave)(&queue->lock);
> +	guard(spinlock)(&vss->lock);
> +	if (vss->resetting || vss->reset_epoch !=3D epoch)
> +		return -ECANCELED;
> +	if (vss->stopped || !vss->prepared || vss->xfer_xrun)
> +		return vss->xfer_xrun ? -EPIPE : -EBADFD;

[Severity: Medium]
Can SNDRV_PCM_TRIGGER_START succeed while virtsnd_pcm_prepare() is still
in progress?

Previously, virtsnd_pcm_prepare_device() kept vss->prepared false until
virtsnd_pcm_reset() ran, and virtsnd_pcm_trigger() rejected start when
vss->preparing was set.  Now virtsnd_pcm_prepare_locked() sets
vss->prepared =3D true before snd_pcm_do_prepare() calls
snd_pcm_reset_substream(), and neither virtsnd_pcm_start_queue() nor
virtsnd_pcm_pause_restart_start() checks vss->preparing.

Unlike snd_pcm_pre_start(), snd_pcm_drain() does not take
runtime->buffer_mutex or check runtime->buffer_accessing.  When a
prepared playback substream with queued frames (appl_ptr > hw_ptr) is
re-prepared, a concurrent drain ioctl can start the device before the
pointer reset finishes:

CPU0                                  CPU1
snd_pcm_do_prepare()
  virtsnd_pcm_prepare()
    vss->preparing =3D true
    vss->prepared =3D true
                                      snd_pcm_drain()
                                        snd_pcm_do_drain_init()
                                          snd_pcm_do_start()
                                            virtsnd_pcm_trigger(START)
                                              vss->device_running =3D true
                                              vss->xfer_enabled =3D true
  snd_pcm_reset_substream()
    virtsnd_pcm_playback_reset()
      vss->preparing =3D false
  snd_pcm_post_prepare()
    state =3D SNDRV_PCM_STATE_PREPARED  <-- device left running in PREPARED

Should virtsnd_pcm_start_queue() and virtsnd_pcm_pause_restart_start()
also reject start while vss->preparing is true?

[ ... ]

> @@ -808,42 +2060,275 @@ static int virtsnd_pcm_cp_ack(struct snd_pcm_subs=
tream *substream)

[ ... ]

> +static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream)
> +{
> +	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
> +	bool owned;
> +
> +	guard(mutex)(&vss->lifecycle_lock);
> +	scoped_guard(pcm_stream_lock_irqsave, substream) {
> +		snd_pcm_state_t state =3D substream->runtime->state;
> +
> +		/*
> +		 * Trigger holds the PCM lock through its control requests. Wait
> +		 * for it, then leave a replacement active generation alone.
> +		 * lifecycle_lock keeps prepare from replacing an inactive one
> +		 * until sync_stop_locked has finished its teardown.
> +		 */
> +		guard(spinlock_irqsave)(&vss->lock);
> +		owned =3D vss->prepared || vss->release_required || vss->msg_count ||
> +			vss->device_running;
> +		if (state =3D=3D SNDRV_PCM_STATE_RUNNING ||
> +		    state =3D=3D SNDRV_PCM_STATE_PAUSED ||
> +		    state =3D=3D SNDRV_PCM_STATE_PREPARED ||
> +		    (state =3D=3D SNDRV_PCM_STATE_DRAINING &&
> +		     substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)) {
> +			/* Core may consume this marker before a later inactive teardown. */
> +			if (owned)
> +				substream->runtime->stop_operating =3D true;
> +			return 0;
> +		}

[Severity: Medium]
Does virtsnd_pcm_sync_stop() drop runtime->stop_operating when a staged
capture stream with capture_pause_restart enabled is paused?

When SNDRV_PCM_TRIGGER_PAUSE_PUSH runs with capture_pause_restart
enabled, virtsnd_pcm_pause_restart_pause() sets vss->stopped =3D true and
calls virtsnd_pcm_release_wait(), which waits for vss->msg_count to reach
0 and clears vss->prepared and vss->release_required while transitioning
to VIRTSND_PCM_PAUSE_RESTART_RELEASED (with vss->device_running already
false).  virtsnd_pcm_trigger() then sets runtime->stop_operating =3D true so
that a later teardown from SNDRV_PCM_STATE_PAUSED will invoke
ops->sync_stop.

If snd_pcm_sync_stop() runs while the stream is still in
SNDRV_PCM_STATE_PAUSED, it clears runtime->stop_operating before calling
virtsnd_pcm_sync_stop().  Because owned does not include vss->stopped, it
evaluates to false and runtime->stop_operating stays false.  If the
paused stream is then torn down without resuming to RUNNING (for example
via snd_pcm_drop()), snd_pcm_running() is false so ALSA skips
virtsnd_pcm_sync_stop(), leaving vss->stopped set and vss->elapsed_period
unquiesced.  Should owned include vss->stopped?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107143422.2931=
9-1-mynameisjune111@gmail.com?part=3D10
