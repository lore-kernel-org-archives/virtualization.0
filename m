Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793253959;
	b=v9RIJnP0PxvRiP5MWArkvPbqKhptf8P81BwNgSH6WzhKAqIJL08/UodoR9y13IPrfZVX
	 e+/l0H4/FH0myUOEpbqoDxlX3DqVRK0NPFsbNcpv9i0WprLme5uys5zQMv/uNzEScHN6L
	 hn80tm8c7hmCNsoeV25bRNUeEV2Bny+TU6svjaH0hbYnY6dF3dDrUWSP6BvV31YTZKaQq
	 nlDpWYydUli8HRSytWFZdg+7lQocY6RVWniLLKUCHb4zev8nWyk8mH5Ynf+ogsFiNZNQ3
	 +b6UdSBhSOUotHdzeHk4q2X+Z+HosUZd3ZvObLwJG9oOCIg7mKnRpB+5UZDQ7OHnQ1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793253959;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0aby2d7GlFvbGVIUxtV1nVFkKWBr40fem1ZfezOpfeE=;
	b=jdJH+nX/vn+eXyTWVGTmzLKiwL7I/ayLRxlwfz1B1M3NPC0hw0URXOSLfEuLrKOw2Mkm
	 UysTLg0VIuIZrzb172ve9PJrzlSo036WGl3VxJHkWecxcZ2MtWAXh9jZec+53oGWObzj0
	 H4E4IJS9QV/1ao0tApS0/CS5Em43UaV9DgyAdiyiXujjCl4A3jwhVAnSazs6jqt9ikdLk
	 hDX+RVw/j1nkdPV3YRhGQWyxMbvH+MfliKvRsBNB4O0ssH0XW8D/kmct9BmcXw9508hyw
	 6vxcUeojzVakUavfWXeFA1GC4Wx3vWUHkgtyshRjIxsBdr6SWpjxRqDXx6gHqVFwaMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b6rERSas;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C073606A31C;
	Thu, 29 Oct 2026 06:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b6rERSas
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00A21F01825;
	Thu, 29 Oct 2026 06:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793253958;
	bh=0aby2d7GlFvbGVIUxtV1nVFkKWBr40fem1ZfezOpfeE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b6rERSasvJfPt8pKcAT+uxus1Lhg77/jQZpOzYNFF9pmSu7gP49qaHO81zU8+wuuP
	 RU6JyhxNGSSY6FHraEjggc2D7EYcBKA9IcLxcmISF7XaluPGrG1IVvo2ZYAqXkCLKg
	 q7rIBJbHQiBH2Z9aveLxXx2EikBxmd7dRpKa2/sj4XUUqXsRRraRy93ghQRrouFFdg
	 MmDaNJBTTQ0hVCVhDS/I/vooL8rnSzwavDcOkolVHu3LP9dDVEy+ww9OSz0X2mVOi7
	 neiQjGjA+UtGX0C5HT8FxLjsm5NA+JktyW1+qPk4+BuHwL9VklDGoC/sHD9kL74ZEm
	 /YpXekFqf0TGw==
Message-ID: <sashiko-outbox-188791@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 13/14] ALSA: virtio: synchronize staged capture reset
 with PCM positions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029054354.2931-14-mynameisjune111@gmail.com>
References: <20261029054354.2931-1-mynameisjune111@gmail.com>
 <20261029054354.2931-14-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 06:05:58 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] ALSA: virtio: unupdated capture_notified_periods in virtsnd_pcm_re=
set()
- [High] ALSA: virtio: false XRUN and skipped rebase in virtsnd_pcm_reset()=
 race
--

commit 4e51f7611d17678ff733d2492023b2e0abcb06d3
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: synchronize staged capture reset with PCM positions

This commit introduces a custom PCM reset operation for staged capture
streams to synchronize private copied and acknowledged byte counters with
ALSA core pointer resets. When resetting a running stream, it calls
snd_pcm_lib_reset(), advances capture_acked_total to
capture_pointer_seen_total, and attempts to refill the RX queue.

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index 66560d82b7f8e..ba14f395eef8a 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c

[ ... ]

> @@ -1591,6 +1598,58 @@ static int virtsnd_pcm_sync_stop(struct snd_pcm_su=
bstream *substream)
>  	return virtsnd_pcm_sync_stop_locked(substream);
>  }
> =20
> +/* The core holds the stream lock through the matching appl_ptr reset. */
> +static int virtsnd_pcm_reset(struct snd_pcm_substream *substream)
> +{
> +	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
> +	struct snd_pcm_runtime *runtime =3D substream->runtime;
> +	struct virtio_snd_queue *queue =3D virtsnd_pcm_queue(vss);
> +	size_t position;
> +	size_t period;
> +	int rc;
> +
> +	/* Keep ALSA's pointer validation, time accounting and XRUN processing.=
 */
> +	rc =3D snd_pcm_lib_reset(substream);
> +	if (rc || !vss->capture_staging)
> +		return rc;
> +
> +	guard(spinlock_irqsave)(&queue->lock);
> +	guard(spinlock)(&vss->lock);
> +	if (vss->resetting)
> +		return -ECANCELED;
> +	/* The common reset has already handled a pointer-reported XRUN. */
> +	if (vss->xfer_xrun)
> +		return 0;

[Severity: High]
Can an RX completion arriving between snd_pcm_lib_reset() and acquiring
vss->lock trigger a false XRUN and skip the private counter rebase?

During snd_pcm_do_reset() -> virtsnd_pcm_reset(), snd_pcm_lib_reset() calls
virtsnd_pcm_cp_pointer(), which records vss->capture_pointer_seen_total and
releases vss->lock while vss->capture_ready still holds the pre-reset
unacknowledged byte count:

sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_cp_pointer() {
    ...
				} else {
					vss->capture_pointer_seen_total =3D total;
					hw_ptr =3D virtsnd_pcm_ring_offset(total, vss->buffer_bytes);
				}
    ...
}

In managed mode (!vss->capture_free_running), if an in-flight RX completion
arrives before virtsnd_pcm_reset() acquires queue->lock and vss->lock,
virtsnd_pcm_capture_complete() checks the incoming bytes against the stale
pre-reset vss->capture_ready:

sound/virtio/virtio_pcm_msg.c:virtsnd_pcm_capture_complete() {
    ...
		else if (!free_running &&
			 audio_bytes >=3D vss->buffer_bytes - vss->capture_ready)
			invalid_reason =3D "ring_capacity";
		else if (!free_running &&
			 check_add_overflow(vss->capture_ready, audio_bytes,
					    &next_ready))
			invalid_reason =3D "ready_overflow";
		else if (!free_running && next_ready >=3D vss->buffer_bytes)
			invalid_reason =3D "ring_full";
    ...
}

When the pre-reset unacknowledged bytes plus audio_bytes reach
vss->buffer_bytes, virtsnd_pcm_capture_complete() rejects the completion,
drops the captured audio, and sets vss->xfer_xrun =3D true.

When virtsnd_pcm_reset() then acquires the locks, it sees vss->xfer_xrun and
returns 0 without updating vss->capture_acked_total, vss->capture_ready, or
vss->pcm_indirect.appl_ptr, even though snd_pcm_lib_reset() did not observe
the XRUN and snd_pcm_do_reset() proceeds to rebase runtime->status->hw_ptr
and runtime->control->appl_ptr.

> +	if (snd_pcm_running(substream)) {
> +		/* Keep completions arriving after the core's pointer observation. */
> +		vss->capture_acked_total =3D vss->capture_pointer_seen_total;
> +		vss->capture_ready =3D vss->capture_free_running ? 0 :
> +			vss->capture_copied_total - vss->capture_acked_total;
> +	} else {
> +		position =3D frames_to_bytes(runtime, runtime->status->hw_ptr);
> +		vss->hw_ptr =3D position;
> +		period =3D snd_pcm_lib_period_bytes(substream);
> +		vss->capture_copied_total =3D position;
> +		vss->capture_acked_total =3D position;
> +		vss->capture_pointer_seen_total =3D position;
> +		vss->capture_ready =3D 0;
> +		vss->capture_notified_periods =3D period ? position / period : 0;
> +	}

[Severity: High]
Should the running-stream branch in virtsnd_pcm_reset() also advance
vss->capture_notified_periods to match vss->capture_pointer_seen_total?

If a completion in virtsnd_pcm_capture_complete() crosses a period boundary
and schedules vss->elapsed_period, and userspace invokes
SNDRV_PCM_IOCTL_RESET before virtsnd_pcm_period_elapsed() acquires the PCM
stream lock, snd_pcm_lib_reset() -> snd_pcm_update_hw_ptr() ->
virtsnd_pcm_cp_pointer() observes the new vss->capture_copied_total and
updates vss->capture_pointer_seen_total.

In snd_pcm_do_reset(), the core then folds that position into
runtime->hw_ptr_interrupt:

sound/core/pcm_native.c:snd_pcm_do_reset() {
    ...
		runtime->hw_ptr_base =3D 0;
		runtime->hw_ptr_interrupt =3D runtime->status->hw_ptr -
			runtime->status->hw_ptr % runtime->period_size;
		runtime->silence_start =3D runtime->status->hw_ptr;
		runtime->silence_filled =3D 0;
		runtime->control->appl_ptr =3D runtime->status->hw_ptr;
    ...
}

Because the running branch in virtsnd_pcm_reset() leaves
vss->capture_notified_periods at its pre-reset value, the pending
virtsnd_pcm_period_elapsed() worker later sees period_floor >
vss->capture_notified_periods for a period boundary already accounted for in
runtime->hw_ptr_interrupt:

sound/virtio/virtio_pcm.c:virtsnd_pcm_period_elapsed() {
    ...
			period_floor =3D div64_ul(vss->capture_copied_total, period_bytes);
			if (period_floor > vss->capture_notified_periods) {
				/* Reserve crossed boundaries before the callback. */
				vss->capture_notified_periods =3D period_floor;
				notify =3D true;
			}
    ...
}

This triggers a duplicate snd_pcm_period_elapsed_under_stream_lock() ->
snd_pcm_update_hw_ptr0(substream, 1) call where delta > new_hw_ptr:

sound/core/pcm_lib.c:snd_pcm_update_hw_ptr0() {
    ...
	if (in_interrupt) {
		/* we know that one period was processed */
		/* delta =3D "expected next hw_ptr" for in_interrupt !=3D 0 */
		delta =3D runtime->hw_ptr_interrupt + runtime->period_size;
		if (delta > new_hw_ptr) {
			/* check for double acknowledged interrupts */
			hdelta =3D curr_jiffies - runtime->hw_ptr_jiffies;
			if (hdelta > runtime->hw_ptr_buffer_jiffies/2 + 1) {
				hw_base +=3D runtime->buffer_size;
    ...
}

If the jiffies delta exceeds half the buffer duration, snd_pcm_update_hw_pt=
r0()
treats the duplicate notification as a missed full-buffer wrap-around and
advances runtime->status->hw_ptr by a full buffer_size of uncaptured frames.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029054354.2931=
-1-mynameisjune111@gmail.com?part=3D13
