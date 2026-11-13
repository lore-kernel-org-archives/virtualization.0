Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794554773;
	b=VAFBB+f6poXM+sckBq6mmKunwlZr+3o51LIsuz6n+2OPUtd8xkHRPRHmxKgJyJabkmSH
	 KZ7rX5iYlGpyc/aKbVJaKi+kX0wOoDwoPZeeKsIbRWMrGqN7D3XM3rbmrYbN4bbHHmuAr
	 sI26G7kQsQ+3idEy+NhFl4HOI6IdCcOYqj9N9U2NKK8q4Ay+68e/j7u3c3LUDqd5fpZkH
	 1j3qQvvu90M9yTT1dC01BSvFUR38SoPdpHctGbi8qBZSE1dEl/glJVJk1l9T/ErqxaK2G
	 BpjYiVStT+w+F/pYgFggxBiCC56Ry3D05GVJc/jp7kfwTHpcse/4d0wQ5eeYbv7hhvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794554773;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+mqEs1AIiTNdfOSnGwIn5cTuCo9qadPIWZT6yEn5fJY=;
	b=IBL+mLUMgZ6QSNXGT4pTZr37xgdI8aXSPOERE7emM3NolsGQ08OZvn6UwGWcjR9cQDS9
	 lKLJlRU/v/ntaOz54QomU+58cPNGoakUFC7/inPD9UTDKlwuFX4l28Dzb3WHuwbTotRpH
	 w516CpQgCyn/KWSLsFtxgtq2pcWYqurWTF5fjbKlkcwGAN2l735Y9iPV4O/pJ9xLut4w0
	 CAbGIg4S0mvoTEyHvjbVGJ1w8YhPbY565c7XOXpJm0EdYykBQwOr72Xln6nMYmkJZkab0
	 imLbxgI/LCQOe1KdmDjZwrYsgit8Rt7dnWJgMqaFPbgr/PF9t4RPADWC3uGJN61HSZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pe1L7O2c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1397606A31C;
	Fri, 13 Nov 2026 07:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pe1L7O2c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBDB1F000C4;
	Fri, 13 Nov 2026 07:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794554773;
	bh=+mqEs1AIiTNdfOSnGwIn5cTuCo9qadPIWZT6yEn5fJY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pe1L7O2cp6f+mUIYTaN6SpHzAnxlGZBOYOGty7+KR+PtlyqN0sNE3nYmpVcxNlIKz
	 rgLL4TZfD2DovJ+eFzmo78d3KvlxW5V1n78fuJXhuv1jM/WWGmuro47v6LDFVMOdZo
	 tkjGeuHfpNdlBuBQ6YIttd2SjJ5XVu8KfvOnFGzOBGpjY0Ed8JSNjLKMbg6Bhuutdi
	 XRiGJe650ABbfbzS1rkjdu8Ddq8jv4S3uq/zauVG2Bkua97r7IQ+0QXGchQleBnl3a
	 1I8JAdh9fKESgll7cH5NPMZDYpnnXz59TxfuUwbiNH12FREACA4iuatld1XDcuS/vp
	 Tts5UV4LPKsNQ==
Message-ID: <sashiko-outbox-212346@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v32 18/20] ALSA: virtio: settle PCM control state from
 late replies
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v32-18-4e95979e312c@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v32-18-4e95979e312c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 07:26:12 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] ALSA: virtio: premature settle wait in
  virtsnd_pcm_sync_stop_locked()
- [Medium] ALSA: virtio: late STOP race in virtsnd_pcm_trigger_inner()
  pause rollback
- [Medium] ALSA: virtio: repeated virtsnd_pcm_control_settle() waits in
  single PCM ops
--

commit dfc3a2dc4d2a8149c7f6f4fd9c5c643964f6b264
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: settle PCM control state from late replies

This commit tracks timed-out VirtIO PCM control requests and applies their
late replies to settle the substream's native device state so sleepable
PCM operations can wait for completion instead of requiring a device reset.

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index 4a10cd3cc57ce..15d4473f4c0a0 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c
> @@ -157,10 +157,79 @@ static bool virtsnd_pcm_pause_restart_transitioning=
(enum virtio_pcm_pause_restar
>  	}
>  }
> =20
> +/**
> + * virtsnd_pcm_ctl_defer_locked() - Record a native control request whose
> + *                                  sender timed out.
> + * @vss: VirtIO PCM substream.
> + * @epoch: Generation of the request.
> + *
> + * Context: Control queue lock held with interrupts disabled.
> + * Return: false if the generation was reset, true otherwise.
> + */
> +bool virtsnd_pcm_ctl_defer_locked(struct virtio_pcm_substream *vss, u64 =
epoch)
> +{
> +	guard(spinlock)(&vss->lock);
> +	if (vss->resetting || vss->reset_epoch !=3D epoch)
> +		return false;
> +	vss->control_late++;
> +	vss->control_uncertain =3D true;
> +	return true;
> +}
> +
> +/**
> + * virtsnd_pcm_ctl_settle_locked() - Apply a late native control reply.
> + * @vss: VirtIO PCM substream.
> + * @epoch: Generation of the request.
> + * @command: Control request code (VIRTIO_SND_R_PCM_XXX).
> + * @status: Reply status converted to an errno value.
> + *
> + * No other native control request is sent while one is outstanding, so =
the
> + * reply determines the device state. A failed request leaves it unchang=
ed.
> + *
> + * Context: Control queue lock held with interrupts disabled.
> + */
> +void virtsnd_pcm_ctl_settle_locked(struct virtio_pcm_substream *vss, u64=
 epoch,
> +				   u32 command, int status)
> +{
> +	scoped_guard(spinlock, &vss->lock) {
> +		if (vss->resetting || vss->reset_epoch !=3D epoch ||
> +		    !vss->control_late)
> +			return;
> +		if (!status) {
> +			switch (command) {
> +			case VIRTIO_SND_R_PCM_PREPARE:
> +				vss->release_required =3D true;
> +				break;
> +			case VIRTIO_SND_R_PCM_START:
> +				vss->device_running =3D true;
> +				break;
> +			case VIRTIO_SND_R_PCM_STOP:
> +				vss->device_running =3D false;
> +				break;
> +			case VIRTIO_SND_R_PCM_RELEASE:
> +				vss->release_required =3D false;
> +				vss->device_running =3D false;
> +				break;
> +			}
> +		}
> +		if (--vss->control_late)
> +			return;
> +		vss->control_uncertain =3D false;
> +		wake_up_all(&vss->control_wait);
> +	}

[Severity: Medium]
Can a late successful VIRTIO_SND_R_PCM_STOP reply race with the
SNDRV_PCM_TRIGGER_PAUSE_PUSH rollback in virtsnd_pcm_trigger_inner() and
re-enable vss->xfer_enabled while the device is stopped?

CPU0                                    CPU1 (<hardirq>)
virtsnd_pcm_trigger_inner(..., PAUSE_PUSH)
  virtsnd_pcm_stop_device()
    virtsnd_pcm_send_sync()
      virtsnd_ctl_msg_send_sync()
        -> -ETIMEDOUT
      virtsnd_ctl_msg_defer()
        vss->control_late =3D 1
        vss->control_uncertain =3D true
                                        virtsnd_ctl_notify_cb()
                                          virtsnd_ctl_msg_complete()
                                            virtsnd_pcm_ctl_settle_locked()
                                              vss->device_running =3D false
                                              vss->control_late =3D 0
                                              vss->control_uncertain =3D fa=
lse
  if (rc && command =3D=3D SNDRV_PCM_TRIGGER_PAUSE_PUSH)
    virtsnd_pcm_start_queue()
      vss->xfer_enabled =3D true  <-- queue reopened with device stopped

sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_start_queue() {
    ...
	if (vss->stopped || !vss->prepared || vss->xfer_xrun)
		return vss->xfer_xrun ? -EPIPE : -EBADFD;
	if (vss->control_uncertain)
		return -EIO;
	if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE) {
		rc =3D vss->runtime_active ? virtsnd_pcm_capture_send(vss) : -EBADFD;
	}
	if (!rc)
		vss->xfer_enabled =3D true;
    ...
}

virtsnd_pcm_start_queue() checks vss->control_uncertain, which CPU1 just
cleared, but does not check vss->device_running.  In a linked substream
group, ALSA only rolls back streams preceding the failed one, leaving this
substream in SNDRV_PCM_STATE_RUNNING with vss->xfer_enabled set while the
device is stopped; on an unlinked capture stream, rolling back
vss->capture_quiet_sequence before snd_pcm_undo_pause() resumes the stream
causes the zero-length RX buffers drained by STOP to trigger a false
capture XRUN.

> @@ -680,6 +808,10 @@ static int virtsnd_pcm_prepare_locked(struct snd_pcm=
_substream *substream)
>  	bool suspended;
>  	u64 epoch;
> =20
> +	/* Teardown decisions below depend on the settled device state. */
> +	rc =3D virtsnd_pcm_control_settle(vss);
> +	if (rc)
> +		return rc;
>  	scoped_guard(pcm_stream_lock_irqsave, substream) {
>  		guard(spinlock_irqsave)(&vss->lock);
>  		if (vss->resetting)

[Severity: Medium]
Does calling virtsnd_pcm_control_settle() in both
virtsnd_pcm_sync_stop_locked() and its callers make a single prepare,
hw_free, or hw_params operation wait 8 to 12 timeouts instead of the
documented 4?

When a prior control request times out and sets
substream->runtime->stop_operating, snd_pcm_do_prepare(), do_hw_free(), and
snd_pcm_hw_params() first call snd_pcm_sync_stop(), which invokes
virtsnd_pcm_sync_stop_locked() -> virtsnd_pcm_control_settle() (4 timeouts)
and ignores the -EIO return value.  ALSA core then immediately calls the
driver's prepare, hw_free, or hw_params callback, which calls
virtsnd_pcm_control_settle() a second time (8 timeouts total), and when
virtsnd_pcm_hw_params() fails, snd_pcm_hw_params() unwinds through
virtsnd_pcm_hw_free() -> virtsnd_pcm_sync_stop_locked() for a third wait
(12 timeouts total, or 5 timeouts when VIRTIO_SND_R_PCM_SET_PARAMS itself
times out).

> @@ -1579,6 +1711,9 @@ static int virtsnd_pcm_sync_stop_locked(struct snd_=
pcm_substream *substream)
>  	int rc;
> =20
>  	lockdep_assert_held(&vss->lifecycle_lock);
> +	rc =3D virtsnd_pcm_control_settle(vss);
> +	if (rc)
> +		return rc;
>  	scoped_guard(pcm_stream_lock_irqsave, substream) {
>  		guard(spinlock_irqsave)(&vss->lock);
>  		preparing =3D vss->preparing;

[Severity: Medium]
Does returning early when virtsnd_pcm_control_settle() fails here lose
substream->runtime->stop_operating and skip disabling vss->elapsed_period?

snd_pcm_sync_stop() clears substream->runtime->stop_operating before
calling ->sync_stop() and ignores the return value, relying on the driver
to re-arm stop_operating =3D true on failure as virtsnd_pcm_release_locked()
does.  If virtsnd_pcm_control_settle() returns -ERESTARTSYS or -EIO and the
late reply later settles, the stream stays in SNDRV_PCM_STATE_SETUP with
stop_operating =3D=3D false and vss->prepared =3D=3D true, so subsequent
snd_pcm_sync_stop() calls skip releasing the device stream; on the
virtsnd_pcm_hw_free() path, returning before virtsnd_pcm_release_locked()
also skips disable_work_sync(&vss->elapsed_period) before the DMA buffer is
freed.

Sleeping in virtsnd_pcm_control_settle() before the pcm_stream_lock_irqsave
block in both virtsnd_pcm_sync_stop_locked() and
virtsnd_pcm_prepare_locked() also leaves vss->preparing =3D=3D false and
vss->prepared =3D=3D true open to I/O completions, pointer/ACK callbacks, a=
nd
triggers during the wait.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v32-0-4e95979e312c@gmail.com?part=3D18
