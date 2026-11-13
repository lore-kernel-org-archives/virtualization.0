Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794553844;
	b=0rz3apggqsZPC7DnGTUY5SpcVhRN7UiDcsUySCnnDhwzKRdwUZ1k86uE4Bt4iDBA0WRH
	 HZLCElCyptkmAjZaufMKwPZ8jnczNdJnwFpeTYj3yRANL4e8NbDd3hvrwbNtGRR3/Ex9L
	 /v7uYYU1mAghPmnlT7d4bW7iV2VErNo2DVHbER7c4+49j9W8Z6NPAlBk5nFzwwXxZ4X0Z
	 l4Cezk1HzPNcZKFPc2uPiRw8vPK0IzeJwtLNEUUeJEQq2L3F7sjg6L/L0/HvDbxoIyZmx
	 enFUY13X4jpD97F2BGIFJ86HlUMzlbTMuPPJg4rUIdV9qeUMt/Qm0vHQYhmZPQUmI5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794553844;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vqeQyaGd9xzwSm9PKCpt1vNaIQUQQtuZgmUR3yIDAmw=;
	b=kzkJVSuF/NINinf1bc8jFRp+MTlf/uKHp1LYiOltYu0qv/b+GXYkt60rKjRqMcT7mdti
	 Calob0Qsilq3bSnyTbd9TiNoWhXGPZchD2WDOCyJG2u24FKmWC1MGOyurGDrn3X9Eg9LS
	 hs2KPa4pT0b9E1uDgKt8qFMZDF2WHoWVvN36ZLEVBS6pmPx5482fD08RDBefhhuY6XFvo
	 JS7qq0hRNAwe3Opmy0/FzA0AVbOlJopyJF4YFo6pOLzG1o4Wpe2uDlKRDt15bbgO+r1pH
	 LSFpeXpQudFjYDOkFfPoFSPWCGVAbvvpCI753EWBTJhjdlgnsCI2Fowia97AoYOEJcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lWyePUXh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992CF606A321;
	Fri, 13 Nov 2026 07:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lWyePUXh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964D31F000C4;
	Fri, 13 Nov 2026 07:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794553843;
	bh=vqeQyaGd9xzwSm9PKCpt1vNaIQUQQtuZgmUR3yIDAmw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lWyePUXhwZdlMYJt8PjXfL6L68kRLZsAuStS0pXDUeVKDX0sKs4Yi2ugeJizSfrjq
	 4mKXL4S1F1mgr+8mPL5uTRTDDfj1KzByj6k3OXu5PjJPyCJy77mGPkHGZ8J/H7ADTm
	 BV0GrhN/3yOYP4Eo0x8bLu4kpx1FLUGzZSU4PoC3OhbbEw0Z5Z2uemHoDYYvMZcaiy
	 KdDeHypeYib2zI2ftccPmfaoqvxjJFZ3FBobm5Rq6cpTbEocwbsc4d7giZEHAi1Ni4
	 LzUXP8u1VsA1imsWeehfsm+A0A87Vzyhh6u3mjSsnow2OIR8hFClCx6UCtX/D+wNRB
	 lHaa/BLbTYMfg==
Message-ID: <sashiko-outbox-212324@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v32 12/20] ALSA: virtio: use request-owned capture and
 serialize recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v32-12-4e95979e312c@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v32-12-4e95979e312c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 07:10:43 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] ALSA: virtio: premature capture drain teardown in
  virtsnd_pcm_sync_stop()
--

commit 9ad9852068461024197debdd2bd36f84e60f028e
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: use request-owned capture and serialize recovery

This commit switches VirtIO ALSA capture to request-owned buffers with
in-order completion commits and serializes PCM control transitions, reset
handling, and error recovery across substream generations.

Link: https://lore.kernel.org/linux-sound/sashiko-outbox-210240@kernel.org/

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index a5a682534acf7..442169a516676 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c

[ ... ]

> +static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream)
> +{
> +	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
> +	bool teardown_pending;
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
> +		teardown_pending =3D vss->prepared || vss->release_required ||
> +			vss->msg_count || vss->device_running || vss->stopped;
> +		if (state =3D=3D SNDRV_PCM_STATE_RUNNING ||
> +		    state =3D=3D SNDRV_PCM_STATE_PAUSED ||
> +		    state =3D=3D SNDRV_PCM_STATE_PREPARED ||
> +		    (state =3D=3D SNDRV_PCM_STATE_DRAINING &&
> +		     substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)) {
> +			/* Core may consume this marker before a later inactive teardown. */
> +			if (teardown_pending)
> +				substream->runtime->stop_operating =3D true;
> +			return 0;
> +		}

[Severity: Medium]
Can a delayed virtsnd_pcm_sync_stop() tear down a replacement capture
generation while it is in SNDRV_PCM_STATE_DRAINING?

snd_pcm_drop() unlocks the PCM stream lock before calling
snd_pcm_sync_stop().  If another thread prepares, starts, and drains a
capture substream with unread frames before the first thread acquires
vss->lifecycle_lock, snd_pcm_drain() leaves the substream in
SNDRV_PCM_STATE_DRAINING with vss->prepared set so userspace can read the
remaining buffered frames and in-flight STOP tail completions:

CPU0                                  CPU1
snd_pcm_drop()
  runtime->stop_operating =3D true
  snd_pcm_stream_unlock_irq()
  snd_pcm_sync_stop()
    runtime->stop_operating =3D false
                                      snd_pcm_prepare()
                                        virtsnd_pcm_prepare_locked()
                                          virtsnd_pcm_sync_stop_locked()
                                          ...
                                          vss->prepared =3D true
                                      snd_pcm_start()
                                      snd_pcm_drain()
                                        /* state =3D SNDRV_PCM_STATE_DRAINI=
NG */
    virtsnd_pcm_sync_stop()
      /* DRAINING capture not skipped */
      virtsnd_pcm_sync_stop_locked()
        vss->prepared =3D false         <-- aborts active capture drain

Because the active-generation check only exempts SNDRV_PCM_STATE_DRAINING
for playback, virtsnd_pcm_sync_stop_locked() sends VIRTIO_SND_R_PCM_RELEASE,
disables vss->elapsed_period, and clears vss->prepared.  Subsequent reads
and pointer updates during capture drain then see !vss->prepared in
virtsnd_pcm_capture_ack() and virtsnd_pcm_cp_pointer(), failing with -EBADFD
or SNDRV_PCM_POS_XRUN and discarding the unread capture data.

Allowing SNDRV_PCM_STATE_DRAINING for capture in the active-generation check
as well would keep the draining generation intact until its final teardown.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v32-0-4e95979e312c@gmail.com?part=3D12
