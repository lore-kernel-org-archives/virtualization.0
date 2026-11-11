Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794358197;
	b=tnbTqOYLHFCYisZTwB+pLLIYjLxZjbQGMer9pV4erbwxbZrDVmWg33DmC3VzgC4ZSG/N
	 BKxleAZy7yPUMu8uiKgl3NCC2LcPxz0sNgZug+hTWbDO8sQ5SwBylpbgWabQ+2ei2zmlu
	 XiA0Fh1z9E9j7XF1SvtiIOf1cR3QoTjtC+bbaJkAFut2t6gYtiZA0AmC/1idyFqlGnQTs
	 PQWh0nUzIbwsfyMdwUhZJWkDS8gRqTAqA+XkPLVVpYTv/pu+7g2/XpeSs5mL77wU9igF3
	 yKAIPo8AUfXLaAwgILhVjp2NE7kE2UoscfjgJD0j6sLO+enqiIlwwNTy/S3HTdhpbWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794358197;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0nb2GViFYwY0s7WAewP0A2PeULtnNs4wud7RgvtcIO0=;
	b=2tKkzNT4zUv1k0GtUo7MTSr7LxSAg4FZsw/2YDx41XO0yqyRZ++Z75QcYWGjgnH7Fadp
	 +EAXJOZGRC9mGUb/IiRmes3Jdq1X1wHGNKX4obhTL+iBnUCJ8AjdduHzohOfGSeDYrc4R
	 PNfgYBa9yD7R+MrS/wl/knIoFX9VZ3MiNPrxWf2nMqFe4awjRMoQ30fk6QO0hLuq8YAkl
	 UZc3Xqy85VpdgdVAhpuN3SpJUWRfF/NkdPAbi1ZGKuPc8WO3/JGobo5qHzhVtKIjBNgmd
	 e4s50Suaq6Gh4LwvX41ffCDVYRQg1T3pWRDoBGB6P/VEbk+8cVHnnN6hwPArNz5+2MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fRyL427w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EAC606A31C;
	Wed, 11 Nov 2026 00:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fRyL427w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F871F0089F;
	Wed, 11 Nov 2026 00:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794358196;
	bh=0nb2GViFYwY0s7WAewP0A2PeULtnNs4wud7RgvtcIO0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fRyL427weyUDBrGZSFbdO99jOi4GIU3Opa+qdgJA4U1vrWfAPEt1QHCm3n2cXz1E4
	 D/Z1L0R80t/lN+PcCOSy7NqKjaxOfFwXplwv0mZiN9ZRSneWRXCXK4kujK/axpZ7VP
	 534WHJoqpemeQWEOZoL50C7ivpXgIbqdwM/s/jBxj8g5pmMg5c2pLJoGI7cSptFNik
	 oN4zod+XP5Qq5TvVhJ5cMezO5xizLoi/Z0Gj6MFje5INur117tQc7leXkei57ADNK1
	 Rz7Nx4OyET0FjrWmN3s5AYL1lf9gLcdHb5O6caulMcOfQk2ZUtXuXzy34U46b4nztF
	 k3zASjZsvqDVQ==
Message-ID: <sashiko-outbox-208038@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v24 16/16] ALSA: virtio: preserve playback progress
 across pause
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111000543.28550-17-mynameisjune111@gmail.com>
References: <20261111000543.28550-1-mynameisjune111@gmail.com>
 <20261111000543.28550-17-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 00:49:55 +0000
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
- [High] ALSA: virtio: spurious playback wrap and XRUN in
  virtsnd_pcm_period_elapsed()
- [Medium] ALSA: virtio: stale runtime->delay after prepare and playback
  reset
--

commit 6d3754161befb6c587ef38462dc537d40330faae
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: preserve playback progress across pause

This commit preserves playback completion progress across pause, caches
device latency in the substream state, and limits queued playback data to
less than one buffer ring.

> diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
> index 5fdd22de61736..7721376f2ecde 100644
> --- a/sound/virtio/virtio_pcm_msg.c
> +++ b/sound/virtio/virtio_pcm_msg.c
> @@ -1002,12 +1002,10 @@ static void virtsnd_pcm_msg_complete(struct virti=
o_pcm_msg *msg,
>  	/* Keep latched errors until prepare establishes a fresh epoch. */
>  	vss->msg_count--;
> =20
> -	if (vss->xfer_enabled) {
> -		struct snd_pcm_runtime *runtime =3D vss->substream->runtime;
> -
> -		runtime->delay =3D bytes_to_frames(runtime, latency_bytes);
> +	/* A queued request can outlive the ALSA runtime after hw_free. */
> +	vss->playback_latency_bytes =3D latency_bytes;
> +	if (vss->prepared && !vss->preparing)
>  		virtsnd_pcm_schedule_period_elapsed(vss);
> -	}
>  	if (!vss->msg_count)
>  		wake_up_all(&vss->msg_empty);
>  }

[Severity: High]
Can a stale or duplicate vss->elapsed_period work item run after all
playback progress has already been consumed or reset, causing a false
XRUN?

virtsnd_pcm_msg_complete() now schedules vss->elapsed_period while paused,
and virtsnd_pcm_trigger_inner() schedules it again on resume when
virtsnd_pcm_playback_progress_pending() is true.  However,
virtsnd_pcm_playback_reset() does not cancel pending work when rebasing
vss->hw_ptr and vss->pcm_indirect.hw_io, and virtsnd_pcm_period_elapsed()
calls snd_pcm_period_elapsed_under_stream_lock() unconditionally for
playback:

sound/virtio/virtio_pcm.c:virtsnd_pcm_period_elapsed() {
    ...
	if (vss->direction !=3D SNDRV_PCM_STREAM_CAPTURE) {
		snd_pcm_period_elapsed_under_stream_lock(substream);
		return;
	}
}

For example, if a late TX completion arrives while paused and queues
vss->elapsed_period, and the application runs SNDRV_PCM_IOCTL_RESET
followed by SNDRV_PCM_TRIGGER_PAUSE_RELEASE before the worker executes:

CPU0 (vhost / irq)                CPU1 (ioctl / kworker)
virtsnd_pcm_msg_complete()
  msg_count-- (becomes 0)
  schedule_work(&elapsed_period)
                                  virtsnd_pcm_playback_reset()
                                    hw_ptr =3D 0;
                                    pcm_indirect.hw_io =3D 0;
                                  snd_pcm_do_pause(substream, 0)
                                    runtime->hw_ptr_jiffies =3D
                                      jiffies - HZ * 1000;
                                  virtsnd_pcm_period_elapsed()
                                    snd_pcm_period_elapsed_under_stream_loc=
k()
                                      snd_pcm_update_hw_ptr0(..., 1)
                                        <-- false wrap + XRUN

Because virtsnd_pcm_period_elapsed() runs with in_interrupt =3D 1 when
vss->hw_ptr =3D=3D vss->pcm_indirect.hw_io, new_hw_ptr equals
runtime->hw_ptr_interrupt while runtime->hw_ptr_jiffies is backdated
from pause, so snd_pcm_update_hw_ptr0() treats the unchanged pointer as a
full-buffer interrupt wrap, adds runtime->buffer_size to hw_base, and
stops the stream with an XRUN.  The same happens if the worker dequeues
elapsed_period and blocks on the stream lock while PAUSE_RELEASE holds it
and queues a second run.

Should virtsnd_pcm_period_elapsed() check
virtsnd_pcm_playback_progress_pending(vss) before calling
snd_pcm_period_elapsed_under_stream_lock()?

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index da4e98836721d..7fbbce1dcbb73 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c
> @@ -770,6 +770,12 @@ static int virtsnd_pcm_prepare_locked(struct snd_pcm=
_substream *substream)
>  		memset(&vss->pcm_indirect, 0, sizeof(vss->pcm_indirect));
>  		vss->pcm_indirect.sw_buffer_size =3D vss->buffer_bytes;
>  		vss->pcm_indirect.hw_buffer_size =3D vss->buffer_bytes;
> +		if (vss->direction =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
> +			/* Keep unobserved completions below one physical ring. */
> +			vss->pcm_indirect.hw_queue_size =3D vss->buffer_bytes -
> +				snd_pcm_lib_period_bytes(substream);
> +			vss->playback_latency_bytes =3D 0;
> +		}

[ ... ]

> @@ -1610,6 +1627,7 @@ virtsnd_pcm_pb_pointer(struct snd_pcm_substream *su=
bstream)
>  		}
>  		if (!paused_pointer)
>  			hw_ptr =3D vss->hw_ptr;
> +		runtime->delay =3D bytes_to_frames(runtime, vss->playback_latency_byte=
s);
>  	}
>  	if (paused_pointer) {
>  		if (defer_work)
> @@ -2226,6 +2244,7 @@ static int virtsnd_pcm_playback_reset(struct snd_pc=
m_substream *substream)
>  	vss->pcm_indirect.hw_data =3D position;
>  	vss->pcm_indirect.sw_io =3D position;
>  	vss->pcm_indirect.sw_data =3D position;
> +	vss->playback_latency_bytes =3D 0;
>  	vss->pcm_indirect.hw_ready =3D 0;
>  	vss->pcm_indirect.sw_ready =3D 0;
>  	vss->pcm_indirect.appl_ptr =3D runtime->status->hw_ptr;

[Severity: Medium]
Does clearing vss->playback_latency_bytes in virtsnd_pcm_prepare_locked()
and virtsnd_pcm_playback_reset() leave a stale runtime->delay behind?

runtime->delay is now updated only when virtsnd_pcm_pb_pointer() runs.
During prepare, or during SNDRV_PCM_IOCTL_RESET inPREPARED or PAUSED
state, snd_pcm_lib_reset() does not call virtsnd_pcm_pb_pointer().  When
SNDRV_PCM_IOCTL_RESET is called in RUNNING state,
virtsnd_pcm_playback_reset() calls snd_pcm_lib_reset() before zeroing
vss->playback_latency_bytes, so virtsnd_pcm_pb_pointer() reloads the old
vss->playback_latency_bytes into runtime->delay during the reset.  In both
cases runtime->delay keeps the previous playback latency until the next
pointer update, and SNDRV_PCM_IOCTL_DELAY or SNDRV_PCM_IOCTL_STATUS
reports stale delay.

Clearing vss->playback_latency_bytes and runtime->delay before
snd_pcm_lib_reset(), and zeroing runtime->delay in
virtsnd_pcm_prepare_locked(), would keep both in sync.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111000543.2855=
0-1-mynameisjune111@gmail.com?part=3D16
