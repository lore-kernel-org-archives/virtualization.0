Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265439;
	b=UyP56/7LbWLtvTusrz7QnDzSvOJPPXvvZIO/VaneLdTZSHm96bvSN/GK02KRbVFhJ9et
	 l1dbqjIuTjpGUHht/mrc4N8MFr86jNqWRyu86e3OVESaIssJvMsgKy+1bmnp1LidxU2iq
	 tDbZvh5NOeIR1AbFIt2fMLdgUnVe4cbMQGHRu83OU+i7zsKP4P3VAL41mJ0Ht7nywBkrz
	 n/uJKSJZFHnMhFwasN0t61T1pW8FpPXlwor/hGJ3pQWk4piGeQML/EUwVced+mW9/DYfA
	 +LubusWh5O7xRI2eW0Ab4gzYZQ+CsnPgsETroHZRnPfTv2ts/HNTHmu4M7jp4/I3GgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265439;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CRn5+Qp7Q1Emw6hcpsEarrAwu2dn49sklve80N1O+TA=;
	b=SQ9MASL7QnqN1t80BNJRn5SE3rqDUyqUSC2ClsQg9xyVp2W1VM6A1xOO3JwXgNnTfucE
	 WINxMvtFftvKqbgPH/egd8aazKoLAdw7RzDl009VQfdNzKxjtszYqbh5wd01TbP4DyNo8
	 Je0nxyWUeF9Yr0DMjFLI116SNWSlqby7na8guYh342qLMhdPLFZVI5QfZIYYBhup90Z3u
	 ka99NtPfoGBRdb3yOrSdl2rjffkv0nHgO4VDa8I4QGanQ/mYkW8rz+2RY50W3cRZYwl1a
	 mBa4Gwqix34CfRJVDrJ42uKNPw/JfUuL+IpeD5LJLrG9E7Xd2Qs4FRLWNFpewizxg+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=idQjVNPF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF67F606A325;
	Thu, 29 Oct 2026 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=idQjVNPF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC5E1F01828;
	Thu, 29 Oct 2026 09:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793265438;
	bh=CRn5+Qp7Q1Emw6hcpsEarrAwu2dn49sklve80N1O+TA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=idQjVNPF9Z3MWuo9VNSNHj2ku/zTRvQvo8553OvktmM0T7DChdS/nsoU7bGWBsZKg
	 SFqiHAZ7xzC7SZhMmMD+tGj18yWyFIpKCWchQBO4EW+BVmSh+ykiqW9hU1fqn/JlrG
	 iredkZXVzM2/nQYLKjDHGfNz3o1hIACFPzmqVWLDnamF/3vQDHxXSYbepqwAgAT863
	 F4AkGZEcVqLVuKgxC5WWkbSBmGmD8TG4jFYmTECUq40DWCOXiAFCWD+scUDFowdi15
	 z/1hYapjgwJCk9osakaQFbUsQwtZzNCxPd1TjsyilAVR53eMpvuBfPXzHJcgq2UqIG
	 9CPg8Zp9G1+nQ==
Message-ID: <sashiko-outbox-189016@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 14/14] ALSA: virtio: rebase ordinary capture
 accounting on RESET
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029085032.70689-15-mynameisjune111@gmail.com>
References: <20261029085032.70689-1-mynameisjune111@gmail.com>
 <20261029085032.70689-15-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:17:17 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] ALSA: virtio: virtsnd_pcm_indirect_reset() schedules work duri=
ng device reset
- [High] ALSA: virtio: paused virtsnd_pcm_indirect_reset() ignores unconsum=
ed hw_ptr
- [High] ALSA: virtio: virtsnd_pcm_msg_complete() clears XRUN latched by in=
direct reset
- [Medium] ALSA: virtio: snd_pcm_lib_reset() ACK refill failure bypasses in=
direct reset
--

commit 8b5c75eb2645291e7d9290840b04f0f9a62b651f
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: rebase ordinary capture accounting on RESET

This patch adds virtsnd_pcm_indirect_reset() and selects
virtsnd_pcm_capture_indirect_ops for non-staged capture streams to keep
indirect capture accounting synchronized with the ALSA core during
SNDRV_PCM_IOCTL_RESET. When refilling RX buffers fails after
snd_pcm_lib_reset() mutates hw_ptr, it latches XRUN and schedules
elapsed_period so the core can finish rebasing appl_ptr before reporting
the error.

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index c3d272163907d..ba255803c6577 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c

[ ... ]

> @@ -1693,6 +1697,62 @@ static int virtsnd_pcm_sync_stop(struct snd_pcm_su=
bstream *substream)
>  	return virtsnd_pcm_sync_stop_locked(substream);
>  }
> =20
> +/*
> + * The PCM lock covers indirect accounting and core completion. Once lib=
_reset
> + * changes hw_ptr, complete the core rebase even if refilling fails. The=
 latched
> + * XRUN rejects subsequent pointer/ACK operations; the worker publishes =
XRUN to
> + * paused streams too. RESET success therefore does not imply stream rec=
overy.
> + */
> +static int virtsnd_pcm_indirect_reset(struct snd_pcm_substream *substrea=
m)
> +{
> +	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
> +	struct snd_pcm_runtime *runtime =3D substream->runtime;
> +	struct virtio_snd_queue *queue =3D virtsnd_pcm_queue(vss);
> +	struct virtsnd_pcm_transfer transfer =3D {};
> +	int rc;
> +
> +	rc =3D snd_pcm_lib_reset(substream);
> +	if (rc)
> +		return rc;
> +	if (!snd_pcm_running(substream) &&
> +	    runtime->state !=3D SNDRV_PCM_STATE_PAUSED)
> +		return 0;

[Severity: Medium]
What happens if RX virtqueue refilling fails inside virtsnd_pcm_cp_ack()
while snd_pcm_lib_reset() is updating the pointer on a running stream?

When snd_pcm_running(substream) is true, the call chain is:

  virtsnd_pcm_indirect_reset()
    -> snd_pcm_lib_reset()
      -> snd_pcm_update_hw_ptr()
        -> virtsnd_pcm_cp_pointer()
          -> snd_pcm_indirect_capture_pointer()
            -> virtsnd_pcm_cp_ack()

In include/sound/pcm-indirect.h:snd_pcm_indirect_capture_pointer(), rec
fields are mutated before invoking substream->ops->ack():

	rec->hw_io =3D ptr;
	rec->hw_ready +=3D bytes;
	qsize =3D rec->hw_queue_size ? rec->hw_queue_size : rec->hw_buffer_size;
	if (rec->hw_ready > qsize)
		return SNDRV_PCM_POS_XRUN;
	rec->sw_io +=3D bytes;
	if (rec->sw_io >=3D rec->sw_buffer_size)
		rec->sw_io -=3D rec->sw_buffer_size;
	if (substream->ops->ack) {
		err =3D substream->ops->ack(substream);
		if (err =3D=3D -EPIPE)
			return SNDRV_PCM_POS_XRUN;
	}

Whenever rec->hw_ready > 0 and rec->sw_ready < rec->sw_buffer_size,
virtsnd_pcm_cp_ack() runs snd_pcm_indirect_capture_transfer() and attempts
to refill the RX virtqueue before snd_pcm_lib_reset() returns.

If virtsnd_pcm_msg_send() fails during that ack callback,
snd_pcm_indirect_capture_pointer() returns SNDRV_PCM_POS_XRUN,
snd_pcm_update_hw_ptr0() transitions runtime->state to
SNDRV_PCM_STATE_XRUN and returns -EPIPE, and snd_pcm_lib_reset() executes:

	if (snd_pcm_running(substream) && snd_pcm_update_hw_ptr(substream) >=3D 0)
		runtime->status->hw_ptr %=3D runtime->buffer_size;
	else {
		runtime->status->hw_ptr =3D 0;
		runtime->hw_ptr_wrap =3D 0;
	}

virtsnd_pcm_indirect_reset() then sees !snd_pcm_running(substream) and
runtime->state !=3D SNDRV_PCM_STATE_PAUSED and returns 0 early, so
snd_pcm_do_reset() sets runtime->control->appl_ptr =3D 0 while
vss->pcm_indirect retains its partially updated hw_io, hw_ready, and sw_io
values.

Should virtsnd_pcm_cp_ack() be suppressed during snd_pcm_lib_reset() (as
staged capture does with vss->capture_reset_observing) so that refilling
only happens once in virtsnd_pcm_indirect_reset() after hw_ptr is rebased?

> +
> +	guard(spinlock_irqsave)(&queue->lock);
> +	guard(spinlock)(&vss->lock);
> +	if (vss->resetting || !vss->prepared || vss->stopped) {
> +		vss->xfer_xrun =3D true;
> +		virtsnd_pcm_schedule_period_elapsed(vss);
> +		return 0;
> +	}

[Severity: Critical]
Can scheduling vss->elapsed_period here when vss->resetting is true cause
a use-after-free on substream->runtime during substream close?

Unlike virtsnd_pcm_reset(), which returns 0 immediately when
vss->resetting is true:

	if (vss->resetting)
		return 0;

virtsnd_pcm_indirect_reset() calls virtsnd_pcm_schedule_period_elapsed(vss)
when vss->resetting is true (which can happen after virtsnd_freeze() /
virtsnd_reset_vqs() has already set vss->resetting =3D true and finished its
own cancel_work_sync(&vss->elapsed_period)).

If userspace then closes the substream while vss->resetting is still true,
virtsnd_pcm_sync_stop_locked() returns -ECANCELED before reaching
cancel_work_sync(&vss->elapsed_period):

	scoped_guard(spinlock_irqsave, &vss->lock) {
		if (vss->resetting)
			return -ECANCELED;
		...
	}
	cancel_work_sync(&vss->elapsed_period);

In addition, both virtsnd_pcm_hw_free() and virtsnd_pcm_close() only call
cancel_work_sync(&vss->elapsed_period) when vss->capture_staging is true:

	if (vss->capture_staging) {
		scoped_guard(spinlock_irqsave, &vss->lock) {
			vss->runtime_active =3D false;
			vss->xfer_enabled =3D false;
		}
		cancel_work_sync(&vss->elapsed_period);
	}

When snd_pcm_release_substream() subsequently calls
snd_pcm_detach_substream(), runtime is freed without holding
pcm_stream_lock, while virtsnd_pcm_period_elapsed() may still be queued or
running and dereferencing substream->runtime in
sound/virtio/virtio_pcm.c:virtsnd_pcm_period_elapsed().

Also, if this branch is taken when vss->resetting is false and
!vss->prepared && !vss->stopped, virtsnd_pcm_transfer_failed(vss) is not
called, leaving vss->stopped false so a subsequent virtsnd_pcm_prepare()
skips virtsnd_pcm_sync_stop_locked() without canceling the scheduled work.

> +
> +	/* Pausing does not move the device's fixed DMA buffer positions. */
> +	if (runtime->state =3D=3D SNDRV_PCM_STATE_PAUSED)
> +		runtime->status->hw_ptr =3D
> +			bytes_to_frames(runtime, vss->pcm_indirect.sw_io);
> +
> +	transfer.indirect =3D vss->pcm_indirect;
> +	transfer.indirect.sw_ready =3D 0;

[Severity: High]
When runtime->state =3D=3D SNDRV_PCM_STATE_PAUSED, does using
vss->pcm_indirect.sw_io and vss->pcm_indirect.hw_ready directly miss RX
completions that already advanced vss->hw_ptr?

For ordinary capture (!vss->capture_staging), RX completions in
sound/virtio/virtio_pcm_msg.c:virtsnd_pcm_msg_complete() advance
vss->hw_ptr and clear msg->length =3D 0 under vss->lock without updating
vss->pcm_indirect:

		vss->hw_ptr +=3D data_bytes;
	}

	if (vss->hw_ptr >=3D vss->buffer_bytes)
		vss->hw_ptr -=3D vss->buffer_bytes;

	msg->length =3D 0;

vss->pcm_indirect (hw_io, sw_io, and hw_ready) is only updated from
vss->hw_ptr when virtsnd_pcm_cp_pointer() calls
snd_pcm_indirect_capture_pointer().

When a stream is paused via snd_pcm_pause(), the core does not call
snd_pcm_update_hw_ptr(). Any RX completion whose elapsed_period work runs
after runtime->state becomes SNDRV_PCM_STATE_PAUSED exits early in
sound/virtio/virtio_pcm.c:virtsnd_pcm_period_elapsed():

	if (!snd_pcm_running(substream)) {
		...
		return;
	}

And any RX completion arriving during SNDRV_PCM_TRIGGER_PAUSE_PUSH while
virtsnd_pcm_stop_device() waits for VIRTIO_SND_R_PCM_STOP also advances
vss->hw_ptr without updating vss->pcm_indirect.

When virtsnd_pcm_indirect_reset() then runs in SNDRV_PCM_STATE_PAUSED:
1. snd_pcm_lib_reset() skips snd_pcm_update_hw_ptr() because
   snd_pcm_running(substream) is false, and sets runtime->status->hw_ptr =
=3D 0.
2. virtsnd_pcm_indirect_reset() sets runtime->status->hw_ptr from the stale
   vss->pcm_indirect.sw_io and runs snd_pcm_indirect_capture_transfer()
   without folding the unconsumed delta (vss->hw_ptr - vss->pcm_indirect.hw=
_io)
   into hw_io, sw_io, and hw_ready.

As a result, completed RX messages between hw_io and vss->hw_ptr are not
counted in hw_ready and are not re-submitted to the RX virtqueue,
hw_ptr/appl_ptr are rebased to the stale sw_io instead of vss->hw_ptr, and
after resume the next virtsnd_pcm_cp_pointer() call sees those pre-RESET
bytes as newly captured data. (Note also that if the earlier
vss->resetting || !vss->prepared || vss->stopped check returns 0 while
paused, runtime->status->hw_ptr is left at 0 from snd_pcm_lib_reset()
rather than restored from sw_io.)

> +	/* Consume no application delta while returning discarded RX space. */
> +	transfer.indirect.appl_ptr =3D runtime->control->appl_ptr;
> +	rc =3D snd_pcm_indirect_capture_transfer(substream, &transfer.indirect,
> +					       virtsnd_pcm_trans_copy);
> +	if (!rc)
> +		rc =3D transfer.error;
> +	if (rc) {
> +		virtsnd_pcm_transfer_failed(vss);
> +		vss->xfer_xrun =3D true;
> +		virtsnd_pcm_schedule_period_elapsed(vss);
> +		return 0;
> +	}

[Severity: High]
Can an in-flight RX completion in virtsnd_pcm_msg_complete() clear
vss->xfer_xrun before virtsnd_pcm_period_elapsed() or subsequent pointer
checks observe the latched XRUN?

When snd_pcm_indirect_capture_transfer() fails here (or on the earlier
error path), virtsnd_pcm_transfer_failed(vss) sets vss->xfer_enabled =3D fa=
lse
and vss->stopped =3D true, but it does not stop the VirtIO device or flush =
RX
buffers already queued in the virtqueue (including any messages queued and
kicked by earlier iterations of virtsnd_pcm_trans_copy() before a later
period failed).

In sound/virtio/virtio_pcm_msg.c:virtsnd_pcm_msg_complete(), any completing
non-staged message unconditionally clears vss->xfer_xrun under vss->lock:

	msg->length =3D 0;

	vss->xfer_xrun =3D false;
	vss->msg_count--;

If an in-flight RX message completes before the scheduled
virtsnd_pcm_period_elapsed() worker runs, vss->xfer_xrun is reset to false.
In sound/virtio/virtio_pcm.c:virtsnd_pcm_period_elapsed():

		scoped_guard(spinlock_irqsave, &vss->lock) {
			runtime =3D substream->runtime;
			paused_xrun =3D runtime &&
				      runtime->state =3D=3D SNDRV_PCM_STATE_PAUSED &&
				      vss->xfer_xrun;
			if (paused_xrun)
				virtsnd_pcm_capture_arm_paused_stop(vss);
		}

paused_xrun then evaluates to false, so a paused stream never transitions
to SNDRV_PCM_STATE_XRUN. Because RESET rebased appl_ptr =3D hw_ptr
(avail =3D=3D 0), subsequent reads on the paused stream never invoke pointe=
r()
or ack(), leaving nonblocking reads returning -EAGAIN indefinitely and
blocking reads hanging instead of returning -EPIPE. Furthermore, because
this error return skips updating vss->pcm_indirect, vss->pcm_indirect is
left out of sync with the rebased runtime->control->appl_ptr.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029085032.7068=
9-1-mynameisjune111@gmail.com?part=3D14
