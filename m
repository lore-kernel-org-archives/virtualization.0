Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761365;
	b=LmyWYqdVHl/QZoz/R6Tw0eUgEF6fCDUNV3l1J5uVINfSvMISalJKY7DGx5oPJSjKwVGJ
	 4xDP2rk5PGOOAIoJL9o8v5NnoNaP5DaoOI2GVBwTFf0O5bFwOgK0LpNHvaX/SuhSE+TgX
	 9rPoIzBswwerqmmeMb6Xuup0ccEOwaTfm9y1hxj26suZk3UMyOW7isc9NGRMJb/kNTX0+
	 HsSHX0jZNKyuvlo/hpEBLqn8CMtsTI4kVg6LESBvhg3XV5nSWU2PXjRkk+BVhO19cn9pk
	 WFXQ0+rhIHRMHzFLTNBmyefW4eCWRObV5lYu8mUHV4SZq0Db+lOw3woq/NKr8l2RlqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761365;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=baBPTypfugjpVlZZl/LtcQv/PgTJB07UM+tPSjEY5bs=;
	b=brPhEZ9unLMDX8mA+JdBzxeq7/12R8yHKk2WmYXkwg06tbB+fCX1hL0PCWZ6YK1cEaaL
	 RSoIOnCJ2Dnqmva0ANyJ/AoOTxq/vEUWnVGyqMWh3pWHi5WQLZohu9vLqoPAk9T/+KpsN
	 SpK3PdOfatT+ddsBE8Y+8YHG1QeUsNV8A7bBDAVm9qQwXZj4J+xJ1uvSSOS8hOgb0rULj
	 iB8FndC1pmu3CLY9+XjnjZ7MGJbnIcDM1P53h4MJvM3SsctMWeprgNI88DOuEMBT3CGqv
	 DAfFJAV4jhKQOFiZms057WefwUCV25YxPLzyDE7zpCrlzAjPf1sfMAR9SfEAUYNbpKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QA6WUIS4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA77D606A31B;
	Wed,  4 Nov 2026 03:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QA6WUIS4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7381F000C1;
	Wed,  4 Nov 2026 03:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761364;
	bh=baBPTypfugjpVlZZl/LtcQv/PgTJB07UM+tPSjEY5bs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QA6WUIS4SjiQ7k6kP56Br49WGZd3huQYCgJwjXNVd91ZdC0hMwwZ3zmTCXbe4luPA
	 newn+VIeB4d2yFu8FPtIj9qOHjcWD/h6i9AnyiZZ/h6DeNGruBFOHxYJvfKSg08zKe
	 5KuxJQMMdlC8WcDlbbG+Fr9wIV/vCcupRVDOLyMHq07ERlNvLflvlJRt7lWuE2t8Bd
	 tUjxpXBIT7hDdaONLgizgubU5dUy8F+3iBsjj+/KfxXFjoEpHHoPO4rzk4W78I7GCD
	 rzPFHekSdKCj6VddrF6D5v/oNUbgdFZnikP3c7T7MAEjlnwqgo2c4TC/wdl6FUBPtM
	 XUklzz2E/uL7w==
Message-ID: <sashiko-outbox-196563@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 04/12] ALSA: virtio: Propagate PCM send failures
 through ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261104021745.57733-5-mynameisjune111@gmail.com>
References: <20261104021745.57733-1-mynameisjune111@gmail.com>
 <20261104021745.57733-5-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:02:43 +0000
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
- [Medium] ALSA: virtio: ack callbacks re-arm stop_operating when stopped w=
ith xfer_xrun
--

commit 12cb7ffb0e372c1cab8202a28baa127421f8e529
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: Propagate PCM send failures through ACK

This commit propagates message submission errors from virtsnd_pcm_msg_send()
through the indirect PCM transfer and ACK callbacks, arming stop_operating =
and
returning -EPIPE on transfer failure. It also adds prepared and preparing s=
tate
tracking to gate ACK callbacks across substream teardown, prepare, and rese=
t.

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index 1091100a4c982..629c738873c9e 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c
[ ... ]
> @@ -461,41 +530,165 @@ virtsnd_pcm_cp_pointer(struct snd_pcm_substream *s=
ubstream)
[ ... ]
> +/* Caller holds vss->lock. */
> +static void virtsnd_pcm_transfer_failed(struct virtio_pcm_substream *vss)
> +{
> +	vss->xfer_enabled =3D false;
> +	vss->stopped =3D true;
> +	vss->substream->runtime->stop_operating =3D true;
> +}
[ ... ]
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
> +		if (vss->stopped && !vss->xfer_xrun)
> +			return -EBADFD;
> +		if (vss->xfer_xrun) {
> +			rc =3D -EPIPE;
> +		} else {
> +			transfer.indirect =3D vss->pcm_indirect;
> +			rc =3D snd_pcm_indirect_playback_transfer(substream,
> +							       &transfer.indirect,
> +							       virtsnd_pcm_trans_copy);
> +			if (!rc)
> +				rc =3D transfer.error;
> +		}
> +		if (rc)
> +			virtsnd_pcm_transfer_failed(vss);
> +		else
> +			vss->pcm_indirect =3D transfer.indirect;
> +	}
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
> +		if (vss->stopped && !vss->xfer_xrun &&
> +		    substream->runtime->state !=3D SNDRV_PCM_STATE_DRAINING)
> +			return -EBADFD;
> +		if (vss->xfer_xrun) {
> +			rc =3D -EPIPE;
> +		} else {
> +			transfer.indirect =3D vss->pcm_indirect;
> +			rc =3D snd_pcm_indirect_capture_transfer(substream,
> +							       &transfer.indirect,
> +							       virtsnd_pcm_trans_copy);
> +			if (!rc)
> +				rc =3D transfer.error;
> +		}
> +		if (rc)
> +			virtsnd_pcm_transfer_failed(vss);

[Severity: Medium]
As reported by Sashiko on v13 [1], in virtsnd_pcm_pb_ack() and
virtsnd_pcm_cp_ack(), can a substream with both vss->stopped and
vss->xfer_xrun set bypass the stopped check during teardown or prepare,
re-arm runtime->stop_operating, and trigger a spurious transition to
SNDRV_PCM_STATE_XRUN?

Both virtsnd_pcm_pb_ack() and virtsnd_pcm_cp_ack() gate the vss->stopped
check on !vss->xfer_xrun:

	if (vss->stopped && !vss->xfer_xrun)
		return -EBADFD;
	if (vss->xfer_xrun) {
		rc =3D -EPIPE;
	}

When the device reports VIRTIO_SND_EVT_PCM_XRUN, virtsnd_pcm_event() sets
vss->xfer_xrun =3D true, and neither virtsnd_pcm_trigger(SNDRV_PCM_TRIGGER_=
STOP)
nor virtsnd_pcm_sync_stop() clears vss->xfer_xrun.

If a linked substream is in SNDRV_PCM_STATE_PREPARED (for example, after
snd_pcm_undo_start() stopped it following an XRUN event) or
SNDRV_PCM_STATE_DRAINING (for a capture stream stopped by snd_pcm_drain()),
and snd_pcm_prepare() runs:

snd_pcm_do_prepare(s)
  snd_pcm_sync_stop(s, true)
    s->runtime->stop_operating =3D false;
    virtsnd_pcm_sync_stop(s)
      virtsnd_pcm_block_ack(s)

Before virtsnd_pcm_block_ack() acquires the PCM stream lock, a concurrent
SNDRV_PCM_IOCTL_SYNC_PTR on s can run pcm_lib_apply_appl_ptr() and invoke
virtsnd_pcm_pb_ack() or virtsnd_pcm_cp_ack(). Because vss->stopped and
vss->xfer_xrun are both true, the ACK callback skips the -EBADFD return,
calls virtsnd_pcm_transfer_failed() to set s->runtime->stop_operating =3D t=
rue
and vss->stopped =3D true again, and returns -EPIPE so pcm_lib_apply_appl_p=
tr()
calls __snd_pcm_xrun(s).

If a later linked substream in the group fails prepare, earlier substreams =
in
the group are left in SNDRV_PCM_STATE_XRUN. If prepare succeeds,
s->runtime->stop_operating remains true on the prepared stream, and a
subsequent snd_pcm_suspend_all() while s is still in SNDRV_PCM_STATE_PREPAR=
ED
will call virtsnd_pcm_sync_stop() -> virtsnd_pcm_block_ack() with
vss->stopped =3D=3D false, leaving vss->preparing =3D true.

In the later commit in this series ("ALSA: virtio: add staged capture and
serialize PCM lifecycle accounting"), snd_pcm_do_prepare() still calls
snd_pcm_sync_stop() before substream->ops->prepare(), virtsnd_pcm_sync_stop=
()
returns 0 for SNDRV_PCM_STATE_PREPARED (and virtsnd_pcm_sync_stop_locked()
restores vss->preparing =3D false before returning while leaving
vss->xfer_xrun =3D true), virtsnd_pcm_ack_state() drops the
buffer_accessing < 0 check, and virtsnd_pcm_pb_ack_locked() and
virtsnd_pcm_cp_ack_locked() check vss->xfer_xrun before
!vss->prepared || vss->stopped, so this race window remains.

Should virtsnd_pcm_pb_ack() and virtsnd_pcm_cp_ack() check vss->stopped and
return -EBADFD before checking vss->xfer_xrun, or avoid calling
virtsnd_pcm_transfer_failed() when vss->stopped is already set?

[1] https://lore.kernel.org/r/20261103080821.16983-2-mynameisjune111@gmail.=
com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104021745.5773=
3-1-mynameisjune111@gmail.com?part=3D4
