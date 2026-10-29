Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793253975;
	b=jXR50ETEwmg8UL7wvD2YSZdktt9lB8ijGq7NMMFR3ourXoO9SRkPJvYcl9O0mo4t6q1d
	 rxumM0d96wh8tylTJBnBFZ+jjl6z/1fNJsAUOWKALlz4HYhRhci+CFSe+htbnZZQbiSyP
	 XtLhpX+QT7H4fIIzUe5KnIXVIVrNlDh61NbUnrb/hJLEAvtAG+jXbo1T3bRuprAuUigwo
	 VhGrvC41DtIeAV8TEz0bD5k8gwEk3M1C2HUgyZFc0oyuMlRPPvjL154VGkVRnvcEVoBSP
	 R524hPNDZ6LmBcO8WtND+Zr/PqdPB8Uyye5OBcx2vSVFoLcN/if7JrEpPG6DSIqmiYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793253975;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=X4arySgtTykmIq2fyaSsaIL6BJtHG3IjGv9r0enslb8=;
	b=jQG200Z22LVF4arv454hKoEWgedgP9G84ZUhtoVUFRpPJ9JAwQqQbkdnP0XR7V0DlvGJ
	 d31+Oc3oDbLvdy2g+bXZmXpPB6YGU6u7EIqZa/SH0iWu8n+neAlKYWW0/OzkK+LiKh5aO
	 OIUgR81TLDA+lP/QMCgcZ0cqbQHten3s3rRdLQTppy0+Vvzn839upNf+PwpCZJbfZhvmq
	 GrA3f8+loCsXiBH7q5C6fOv2x8NjOklStW4vibkLOvVPBkV+PU/hqUv31x4Hd5XeGKbFf
	 yfaESQ1IPyR68oDw9FMjSGDu0eNfe++zndMBUfGJUmsrw3vA0bMNiuHgowmaFtGFdEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SwMRNGrD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1196C606A31A;
	Thu, 29 Oct 2026 06:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SwMRNGrD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A071F01825;
	Thu, 29 Oct 2026 06:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793253974;
	bh=X4arySgtTykmIq2fyaSsaIL6BJtHG3IjGv9r0enslb8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SwMRNGrD7BDbjp/Nd1wC8NWTGEDom9yWZcmcoEHowJa96ADp1KE1gPLOvc8Ot6KBf
	 EVAU7oqex0qyLCduawh7lnX9MAK8zvM6NmPyCiKz/opUxo7rvWtdCkdIU+78c1omVE
	 UHoaf8NqICeYCGQpckGuaLNhT6+QaxItaAm+lu8CfurnUR6DibRIcyRcp7gAvYM7nC
	 9BUJaIZX6fC8w4dRu+iu7f0aD7nICQWCplWQXPCeWLMSrba/ypANqMwrmRxDox2Vpk
	 e8ejOqegFyHbB2X5qVJced+U9K+jq1ATOEJdB+J+TpNGwkJNfpzBhKiuGN4fu1Uqa5
	 KUaG+j0fLDflQ==
Message-ID: <sashiko-outbox-188792@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 14/14] ALSA: virtio: synchronize indirect capture
 positions on reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029054354.2931-15-mynameisjune111@gmail.com>
References: <20261029054354.2931-1-mynameisjune111@gmail.com>
 <20261029054354.2931-15-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 06:06:14 +0000
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
- [High] ALSA: virtio: uncompleted hw_ptr rebase on virtsnd_pcm_indirect_re=
set() error
--

commit 0cc03a4b001753550dc69b32471d30cec1719208
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: synchronize indirect capture positions on reset

This commit adds a dedicated reset operation for indirect capture streams
to synchronize private indirect capture accounting with the core PCM
pointer rebase on reset. It discards unread data, returns the freed RX
buffer space to the virtqueue, and updates the indirect application
pointer to match the rebased hardware pointer.

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index ba14f395eef8a..e4a7a4da4d3a8 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c

[ ... ]

> @@ -1598,6 +1602,54 @@ static int virtsnd_pcm_sync_stop(struct snd_pcm_su=
bstream *substream)
>  	return virtsnd_pcm_sync_stop_locked(substream);
>  }
> =20
> +/* The PCM lock covers both indirect accounting and core completion. */
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
> +
> +	guard(spinlock_irqsave)(&queue->lock);
> +	guard(spinlock)(&vss->lock);
> +	if (vss->resetting)
> +		return -ECANCELED;
> +	if (!vss->prepared || vss->stopped)
> +		return -EBADFD;
> +
> +	/* Pausing does not move the device's fixed DMA buffer positions. */
> +	if (runtime->state =3D=3D SNDRV_PCM_STATE_PAUSED)
> +		runtime->status->hw_ptr =3D
> +			bytes_to_frames(runtime, vss->pcm_indirect.sw_io);
> +
> +	transfer.indirect =3D vss->pcm_indirect;
> +	transfer.indirect.sw_ready =3D 0;
> +	/* Consume no application delta while returning discarded RX space. */
> +	transfer.indirect.appl_ptr =3D runtime->control->appl_ptr;
> +	rc =3D snd_pcm_indirect_capture_transfer(substream, &transfer.indirect,
> +					       virtsnd_pcm_trans_copy);
> +	if (!rc)
> +		rc =3D transfer.error;
> +	if (rc) {
> +		virtsnd_pcm_transfer_failed(vss);
> +		return rc;
> +	}

[Severity: High]
What happens to the PCM ring buffer accounting if virtsnd_pcm_indirect_rese=
t()
returns an error after snd_pcm_lib_reset() has already rebased
runtime->status->hw_ptr?

On an indirect capture substream in SNDRV_PCM_STATE_RUNNING or
SNDRV_PCM_STATE_PAUSED that has wrapped past runtime->buffer_size (so
runtime->hw_ptr_base >=3D runtime->buffer_size and runtime->control->appl_p=
tr >=3D
runtime->buffer_size), virtsnd_pcm_indirect_reset() first calls
snd_pcm_lib_reset() (and in the paused state sets runtime->status->hw_ptr f=
rom
vss->pcm_indirect.sw_io), which rebases runtime->status->hw_ptr into
[0, runtime->buffer_size).

If virtsnd_pcm_indirect_reset() then returns -ECANCELED, -EBADFD, or
transfer.error, snd_pcm_do_reset() in sound/core/pcm_native.c aborts early
without completing the rest of the rebase:

sound/core/pcm_native.c:snd_pcm_do_reset() {
	...
	err =3D substream->ops->reset(substream);
	if (err < 0)
		return err;
	runtime->hw_ptr_base =3D 0;
	runtime->hw_ptr_interrupt =3D runtime->status->hw_ptr -
		runtime->status->hw_ptr % runtime->period_size;
	runtime->silence_start =3D runtime->status->hw_ptr;
	runtime->silence_filled =3D 0;
	runtime->control->appl_ptr =3D runtime->status->hw_ptr;
	...
}

This leaves runtime->status->hw_ptr rebased below runtime->control->appl_ptr
while runtime->hw_ptr_base and runtime->control->appl_ptr remain at their
pre-reset values, and runtime->state stays in SNDRV_PCM_STATE_RUNNING or
SNDRV_PCM_STATE_PAUSED. Although virtsnd_pcm_transfer_failed() sets
runtime->stop_operating =3D true on transfer errors, stop_operating is only
acted on by snd_pcm_sync_stop() and is not checked by pcm_accessible_state()
or __snd_pcm_lib_xfer().

In include/sound/pcm.h:snd_pcm_capture_avail():

	snd_pcm_sframes_t avail =3D runtime->status->hw_ptr - runtime->control->ap=
pl_ptr;
	if (avail < 0)
		avail +=3D runtime->boundary;
	return avail;

avail underflows and wraps by runtime->boundary. Wouldn't a subsequent read
via sound/core/pcm_lib.c:__snd_pcm_lib_xfer() see this wrapped avail value =
and
copy stale DMA ring buffer frames to userspace via writer() before
pcm_accessible_state() or pcm_lib_apply_appl_ptr() stops the transfer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029054354.2931=
-1-mynameisjune111@gmail.com?part=3D14
