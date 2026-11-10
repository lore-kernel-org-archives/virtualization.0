Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794269493;
	b=vrez2r/2wrawJI/EhGFGhhuy0OoAF8c79Qf1ZaHpr3wvx87LobT2pqo7/Eb9X2b3SPUr
	 sxv47uGmpxOXE8o+uQoQ4Ch/jQ7wo7kSRGG+7ZApHjzHMrKYnR6C+GAHRL3H36m+xoEeO
	 JqJ2JEA0UjdWNLmunZABmQWwuIflpANkzWkV89RQJ2exVLn0YlIR44a/CryhlIbs22/MV
	 7EqbyDldTrM5H77j4QN5m2l1WX30Pv5En/oIpCCMhhqySWrVz/dc77v5uM6ig/cNPjNbH
	 wQ8pv2fnfkJoE3hu0F4BJTmvUsg0phTIjt90m23zZJMqDdoX7s9mBijoKLc46c62IKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794269493;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TCdr4hlJnzQuqmM6Lm1scksoXtvVtawwytFrgIkB/oo=;
	b=QZOFO/z2cGW1feeDPIpiIplcup8MebbxreH4SB28dBakgTnMCZBuwh3dWG0k2YTI6bvr
	 CYlI7c2W5+Oe8vos71qRz4FnZlfMd7KGTSV/Plxl2+t4HHiGPeKAGRO5RRZD3AocnhPLq
	 yxVJ5iWrR2bqSEwijsd21EA5OMbITW6ozINuk66ajchXQawdHSaV8sIkKGMBrQ7jnedmp
	 e2DKThN6z6XkqiyxNXzKrCOBB/x5TEcCSyv5xHsGUaRdVFSs+Uw7LtuKpcz++yG0QTVuR
	 nFmvvC/jZweEzL1noJhMR83LfVcuOeBAArupItDcu5lmPo1EeVbcHWs29GxQQO7AURw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k22x6+nD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73507606A321;
	Tue, 10 Nov 2026 00:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k22x6+nD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D1A1F008A1;
	Tue, 10 Nov 2026 00:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794269493;
	bh=TCdr4hlJnzQuqmM6Lm1scksoXtvVtawwytFrgIkB/oo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k22x6+nDzNfVlJrEHkDSpAwMOdrCO4LtM0Xq1tfcgKdFqSjxlJ7yTkmIN03Ok4iQt
	 BIfnb8eGVOBWt/6mfweKSegBlth9pB92O2HaIlSOiXmutVQvxfAGmsp1dxwpIEEMxO
	 V/Y9xTn1ZH1v7tZBOCLUpN7Td5eQXXEc6VLeIWVuN88vQjxuoi/DXDHH6gaXu/D0d6
	 SLhj7nf6HXtaF/L2lrekWaevutCzNMx4tduY8JLktaJrjXsqxuTIjnX8S3qCNKLVsG
	 JnPU5jLSF/2A/g1m8msL4VVLMjMigDA7MlycodZVSmG7dhjcIPoMocW1aRz9RJioWd
	 I7IZJ+/FHHTFg==
Message-ID: <sashiko-outbox-205824@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v23 12/14] ALSA: virtio: add opt-in staged capture and
 recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109234049.79534-13-mynameisjune111@gmail.com>
References: <20261109234049.79534-1-mynameisjune111@gmail.com>
 <20261109234049.79534-13-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 00:11:32 +0000
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
- [Medium] ALSA: virtio: missed playback wakeup and wrap in
  virtsnd_pcm_trigger_inner()
--

commit 1965297bcd244a03fcb4a5994d8a256a3575a92b
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: add opt-in staged capture and recovery

This commit adds an opt-in request-owned staged capture path with compatibi=
lity
options and updates PCM control serialization, pause/resume handling, and
reset callbacks.

> diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
> index 0c56f7f4af0f6..4528259597a36 100644
> --- a/sound/virtio/virtio_pcm_msg.c
> +++ b/sound/virtio/virtio_pcm_msg.c
[ ... ]
> @@ -536,78 +876,103 @@ static void virtsnd_pcm_msg_complete(struct virtio=
_pcm_msg *msg,
[ ... ]
> +	vss->hw_ptr +=3D completed_bytes;
> +	if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE) {
> +		/* A full unseen ring cannot be represented by the modulo pointer. */
> +		if (check_add_overflow(vss->capture_copied_total,
> +				       (u64)completed_bytes,
> +				       &vss->capture_copied_total) ||
> +		    vss->capture_copied_total < vss->capture_pointer_seen_total ||
> +		    vss->capture_copied_total - vss->capture_pointer_seen_total >=3D
> +			vss->buffer_bytes)
> +			vss->xfer_xrun =3D true;
> +	}
> =20
> +	if (vss->hw_ptr >=3D vss->buffer_bytes)
> +		vss->hw_ptr -=3D vss->buffer_bytes;
> +
>  	msg->length =3D 0;
> +
> +	/* Keep latched errors until prepare establishes a fresh epoch. */
>  	vss->msg_count--;
> =20
> -	if (vss->xfer_enabled) {
> -		if (!capture_invalid) {
> -			struct snd_pcm_runtime *runtime =3D vss->substream->runtime;
> +	if (vss->xfer_enabled ||
> +	    (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE && vss->xfer_xrun))=
 {
> +		struct snd_pcm_runtime *runtime =3D vss->substream->runtime;
> =20
> -			runtime->delay =3D
> -				bytes_to_frames(runtime,
> -						le32_to_cpu(msg->status.latency_bytes));
> -		}
> -		schedule_work(&vss->elapsed_period);
> +		runtime->delay =3D bytes_to_frames(runtime, latency_bytes);
> +		virtsnd_pcm_schedule_period_elapsed(vss);
>  	}
>  	if (!vss->msg_count)
>  		wake_up_all(&vss->msg_empty);
>  }
[ ... ]
> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index 1496725cba005..d953cd4babf6b 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c
[ ... ]
> +	switch (command) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		scoped_guard(spinlock_irqsave, &vss->lock)
> +			running =3D vss->device_running;
> +		/* Preserve queued requests and unread RX data across native pause. */
> +		rc =3D virtsnd_pcm_start_queue(vss, epoch);
> +		if (rc) {
> +			virtsnd_pcm_trigger_failed(vss, epoch);
> +			return rc;
>  		}
> +
> +		if (running) {
> +			if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE)
> +				virtsnd_pcm_schedule_period_elapsed(vss);
> +			return 0;
> +		}
> +
> +		msg =3D virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_START,
> +						GFP_KERNEL, epoch);
>  		if (!msg) {
> -			virtsnd_pcm_start_failed(vss);
> +			virtsnd_pcm_trigger_failed(vss, epoch);
>  			return -ENOMEM;
>  		}
> =20
> -		rc =3D virtsnd_ctl_msg_send_sync(snd, msg);
> -		if (rc)
> -			virtsnd_pcm_start_failed(vss);
> +		rc =3D virtsnd_pcm_send_sync(vss, msg);
> +		if (rc && rc !=3D -ECANCELED)
> +			virtsnd_pcm_trigger_failed(vss, epoch);
> =20
> +		if (!rc) {
> +			guard(spinlock_irqsave)(&vss->lock);
> +			if (vss->resetting || vss->reset_epoch !=3D epoch)
> +				return -ECANCELED;
> +			vss->device_running =3D true;
> +		}
> +		if (!rc && vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE)
> +			virtsnd_pcm_schedule_period_elapsed(vss);
>  		return rc;
>  	case SNDRV_PCM_TRIGGER_SUSPEND:
> -		vss->suspended =3D true;
> +		scoped_guard(spinlock_irqsave, &vss->lock)
> +			vss->suspended =3D true;
>  		fallthrough;
>  	case SNDRV_PCM_TRIGGER_STOP:
>  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>  		scoped_guard(spinlock_irqsave, &vss->lock) {
> +			if (!vss->prepared)
> +				return 0;
>  			if (command !=3D SNDRV_PCM_TRIGGER_PAUSE_PUSH)
>  				vss->stopped =3D true;
>  			vss->xfer_enabled =3D false;
> +			if (!vss->device_running)
> +				return 0;
>  		}
> =20
> -		msg =3D virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_STOP,
> -						GFP_KERNEL);
> -		if (!msg)
> -			return -ENOMEM;
> +		rc =3D virtsnd_pcm_stop_device(vss, epoch);
> +		if (rc && command !=3D SNDRV_PCM_PAUSE_PUSH) {
> +			guard(spinlock_irqsave)(&vss->lock);
> =20
> -		return virtsnd_ctl_msg_send_sync(snd, msg);
> +			if (vss->reset_epoch =3D=3D epoch && !vss->resetting) {
> +				vss->xfer_xrun =3D true;
> +				substream->runtime->stop_operating =3D true;
> +				if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE)
> +					virtsnd_pcm_schedule_period_elapsed(vss);
> +			}
> +		}
> +		if (rc && command =3D=3D SNDRV_PCM_TRIGGER_PAUSE_PUSH) {
> +			if (substream->runtime->state !=3D SNDRV_PCM_STATE_RUNNING) {
> +				/* Failed resume rollback must leave a paused queue closed. */
> +				virtsnd_pcm_trigger_failed(vss, epoch);
> +			} else if (virtsnd_pcm_start_queue(vss, epoch)) {
> +				virtsnd_pcm_trigger_failed(vss, epoch);
> +			} else if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE) {
> +				virtsnd_pcm_schedule_period_elapsed(vss);
> +			}
> +		}
> +		return rc;

[Severity: Medium]
Can pausing a playback stream stall playback when in-flight TX descriptors
complete while vss->xfer_enabled is false?

SNDRV_PCM_TRIGGER_PAUSE_PUSH clears vss->xfer_enabled before
virtsnd_pcm_stop_device() sends VIRTIO_SND_R_PCM_STOP.  Any TX descriptors
that complete in virtsnd_pcm_msg_complete() while vss->xfer_enabled is false
advance vss->hw_ptr and decrement vss->msg_count without scheduling
vss->elapsed_period, and any work already queued returns early in
virtsnd_pcm_period_elapsed() while the substream is paused.

When playback resumes via SNDRV_PCM_TRIGGER_PAUSE_RELEASE (or recovers from=
 a
failed pause push while still running), virtsnd_pcm_trigger_inner() only
schedules vss->elapsed_period for capture.  If all queued TX descriptors
completed while paused (vss->msg_count =3D=3D 0), no further TX interrupt w=
ill
arrive to run virtsnd_pcm_pb_pointer(), reclaim vss->pcm_indirect.hw_ready,=
 or
submit pending vss->pcm_indirect.sw_ready bytes.

In addition, virtsnd_pcm_msg_complete() only checks for a full-buffer unseen
completion wrap on capture.  Because virtsnd_pcm_playback_ack_validate()
allows queuing a full buffer of TX descriptors, completing all of them befo=
re
virtsnd_pcm_pb_pointer() runs wraps vss->hw_ptr modulo vss->buffer_bytes ba=
ck
to vss->pcm_indirect.hw_io, so snd_pcm_indirect_playback_pointer() observes
zero progress and leaves vss->pcm_indirect.hw_ready stuck at
vss->buffer_bytes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109234049.7953=
4-1-mynameisjune111@gmail.com?part=3D12
