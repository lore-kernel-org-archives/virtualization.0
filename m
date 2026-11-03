Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694796;
	b=SoW7ie0mKOTq2vcsuz2RPiDlhlqo12fDZd17eUdgpHzHfTFYNxk/SW35alSKP5EjZdaW
	 rL6GHZXeNS3hYs5hfXX2Neh9D1DLAi30uUK2mrVeTF6YcF6HfHTDHA2sg4gg9CZaRzv0l
	 dhXOXSiZ221EliaMXE7LN/ky7cfdQEbTILk9YkT6JYqVD2An4iN6WsvyXfoy7NqdzWuI/
	 Fhz9L2y/XjbkKprC4ARqFiig6nSPSgQM9QgusR2dPztupgdqkmICmTAs1aVGPRHoioaD4
	 zzhUYYHRyi3g0YhTiJ4As2/qRhXCtBOa4nS0VkJ7hoeT2Y+EikjirrzG5A1UadKhiow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694796;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=d8XvZ731/nH3uz6YjucyhxkBQmpTLgZPZ5QlBs2V3eA=;
	b=P9wrSNDKr0G8P0j1wBkuV0Ia3PacjogXN9AOxFFADxqptUtLHOxC4bONCQqTibtySoji
	 fiu1ke+KhDPBfOdSN6u82r8hE+UpDT5mKkraEW6hm5u5j+e2RBXg/3VOCuQvkw+eHK2Yv
	 qUb7cPLHQOxjxx+RqcLWMHIj1wXKv8Y0YuwMY+jAA8pJ7BPTfoc/ijSQMtp6EhgCPQWHB
	 BQPIENez+JmOxr8BBAYPz7RZBvS+2/gF+XowTQ6ZClkdPpG+gXlZ9wArD1K5GtopIourg
	 GVUZeeRStoMwIMdfuikyAw8kBeUW8KOVgmGEp/4uNtk8lNPpYB2X/yPeDuh/EQMZ7fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vdi1+Azj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24E5606A334;
	Tue,  3 Nov 2026 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vdi1+Azj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7061C1F00919;
	Tue,  3 Nov 2026 08:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793694795;
	bh=d8XvZ731/nH3uz6YjucyhxkBQmpTLgZPZ5QlBs2V3eA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vdi1+Azj3K2gZsCYPnJbHvEtsrnsDn35vlur1tnr05DH/iIB+N7O2FB9Wxx71GhHB
	 jn52bWG8/IdFPh6/+hNXxdhOxfW5u/QZXuvl42Jgk4N5Z7R2SmX7bNvSqVTMYDAnF1
	 0FI+0EsKGoFJ3MFnQFt9V69f01h/muKjQm3ORPjg3dsnYmzUczPRL+Z0vd3xZdqqgT
	 DcgdYw+d2ISx0dSxjHmUS0QxOA1FZ6lk3a5+yFEEFp225vZ9uq1I58+xs+X5XSEuDe
	 UcGJ+fEQZN9864+eUrXA/9/JMb375Ov02s/+VFD9UA6Lubzr955r9E2sg/vTt4ObNo
	 1MIcYc0N5qTRQ==
Message-ID: <sashiko-outbox-194832@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 01/12] ALSA: virtio: Propagate PCM send failures
 through ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103080821.16983-2-mynameisjune111@gmail.com>
References: <20261103080821.16983-1-mynameisjune111@gmail.com>
 <20261103080821.16983-2-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 08:33:14 +0000
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
- [Medium] ALSA: virtio: race with sync_stop in virtsnd_pcm_pb_ack()
--

commit 75f714a08c45af9f82b5baffff5589166c1182bf
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: Propagate PCM send failures through ACK

This commit restores message length and notifies the virtqueue on partial
send failures in virtsnd_pcm_msg_send(), and propagates those errors through
the PCM ACK callbacks as XRUNs while rejecting ACK calls from invalid PCM
states.

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index 1091100a4c982..67460bd2a61ca 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c
> @@ -466,36 +466,124 @@ virtsnd_pcm_cp_pointer(struct snd_pcm_substream *s=
ubstream)
[ ... ]
> +/* Caller holds vss->lock. */
> +static void virtsnd_pcm_transfer_failed(struct virtio_pcm_substream *vss)
> +{
> +	vss->xfer_enabled =3D false;
> +	vss->stopped =3D true;
> +	vss->substream->runtime->stop_operating =3D true;
> +}
> =20
> -	virtsnd_pcm_msg_send(vss, rec->sw_data, bytes);
> +/* The caller holds the PCM lock, also used by DROP and state transition=
s. */
> +static int virtsnd_pcm_ack_state(struct snd_pcm_substream *substream)
> +{
> +	switch (substream->runtime->state) {
> +	case SNDRV_PCM_STATE_XRUN:
> +		return -EPIPE;
> +	case SNDRV_PCM_STATE_PREPARED:
> +	case SNDRV_PCM_STATE_RUNNING:
> +	case SNDRV_PCM_STATE_PAUSED:
> +	case SNDRV_PCM_STATE_DRAINING:
> +		return 0;
> +	default:
> +		return -EBADFD;
> +	}
>  }
> =20
>  static int virtsnd_pcm_pb_ack(struct snd_pcm_substream *substream)
>  {
>  	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
>  	struct virtio_snd_queue *queue =3D virtsnd_pcm_queue(vss);
> +	struct virtsnd_pcm_transfer transfer =3D {};
> +	int rc;
> =20
> -	guard(spinlock_irqsave)(&queue->lock);
> -	guard(spinlock)(&vss->lock);
> +	rc =3D virtsnd_pcm_ack_state(substream);
> +	if (rc)
> +		return rc;
> =20
> -	return snd_pcm_indirect_playback_transfer(substream, &vss->pcm_indirect,
> -						  virtsnd_pcm_trans_copy);
> +	scoped_guard(spinlock_irqsave, &queue->lock) {
> +		guard(spinlock)(&vss->lock);
> +		transfer.indirect =3D vss->pcm_indirect;
> +		if (vss->stopped) {
> +			rc =3D -EPIPE;
> +		} else {
> +			rc =3D snd_pcm_indirect_playback_transfer(substream,
> +								&transfer.indirect,
> +								virtsnd_pcm_trans_copy);
> +		}
> +		if (!rc)
> +			rc =3D transfer.error;
> +		if (rc)
> +			virtsnd_pcm_transfer_failed(vss);

[Severity: Medium]
As reported by Sashiko on v12 [1], can virtsnd_pcm_pb_ack() and
virtsnd_pcm_cp_ack() still race with snd_pcm_sync_stop() ->
virtsnd_pcm_sync_stop() on vss->stopped and substream->runtime->stop_operat=
ing
when a stream is in SNDRV_PCM_STATE_PREPARED or SNDRV_PCM_STATE_DRAINING?

Because virtio-snd sets vpcm->pcm->nonatomic =3D true, snd_pcm_prepare() and
snd_pcm_hw_params() hold runtime->buffer_mutex rather than the PCM stream
lock across snd_pcm_sync_stop() and substream->ops->prepare() /
substream->ops->hw_params(). Meanwhile, a concurrent SNDRV_PCM_IOCTL_SYNC_P=
TR
in snd_pcm_sync_ptr() only acquires the PCM stream lock and calls
pcm_lib_apply_appl_ptr() -> virtsnd_pcm_pb_ack() / virtsnd_pcm_cp_ack().

In virtsnd_pcm_ack_state(), SNDRV_PCM_STATE_SETUP is rejected, which covers
snd_pcm_drop(), but SNDRV_PCM_STATE_PREPARED and SNDRV_PCM_STATE_DRAINING a=
re
allowed:

1. When a capture stream with available frames is drained via
   snd_pcm_drain(), snd_pcm_do_drain_init() stops the stream and places it =
in
   SNDRV_PCM_STATE_DRAINING with vss->stopped =3D true and
   runtime->stop_operating =3D true. Similarly, if snd_pcm_start() fails on=
 a
   later linked stream, snd_pcm_undo_start() stops the earlier stream while
   leaving it in SNDRV_PCM_STATE_PREPARED with vss->stopped =3D true and
   runtime->stop_operating =3D true. On a draining capture stream, any read=
 or
   SNDRV_PCM_IOCTL_SYNC_PTR will also see vss->stopped =3D=3D true in
   virtsnd_pcm_cp_ack() and fail with -EPIPE.

2. When snd_pcm_prepare() or snd_pcm_hw_params() is called from
   SNDRV_PCM_STATE_PREPARED (or snd_pcm_prepare() from
   SNDRV_PCM_STATE_DRAINING on capture), runtime->state is unchanged while
   snd_pcm_sync_stop() clears runtime->stop_operating =3D false and calls
   virtsnd_pcm_sync_stop():

   sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_sync_stop() {
       if (!vss->stopped)
           return 0;
       ...
       vss->stopped =3D false;
   }

   While virtsnd_pcm_sync_stop() is sleeping in cancel_work_sync(),
   VIRTIO_SND_R_PCM_RELEASE, or wait_event_interruptible_timeout(), a
   concurrent SNDRV_PCM_IOCTL_SYNC_PTR passes virtsnd_pcm_ack_state(), sees
   vss->stopped =3D=3D true, calls virtsnd_pcm_transfer_failed(vss) to re-a=
rm
   vss->stopped =3D true and runtime->stop_operating =3D true, and returns =
-EPIPE
   so pcm_lib_apply_appl_ptr() triggers __snd_pcm_xrun(). Conversely, if
   SNDRV_PCM_IOCTL_SYNC_PTR runs right after virtsnd_pcm_sync_stop() clears
   vss->stopped =3D false and before prepare finishes, ACK sees
   vss->stopped =3D=3D false and enqueues I/O messages on the released stre=
am.

3. Later commits in this series ("ALSA: virtio: Recover PCM state after a
   failed start" and "ALSA: virtio: add staged capture and serialize PCM
   lifecycle accounting") add vss->lock around vss->stopped and gate ACK on
   vss->prepared and vss->preparing, but virtsnd_pcm_prepare_locked() and
   virtsnd_pcm_hw_params() still call virtsnd_pcm_sync_stop_locked() before
   setting vss->preparing =3D true or clearing vss->prepared =3D false. Whi=
le
   virtsnd_pcm_sync_stop_locked() or virtsnd_pcm_pause_restart_sync_stop()
   sleeps in disable_work_sync(), cancel_work_sync(),
   virtsnd_pcm_stop_device(), or virtsnd_pcm_send_sync() for
   VIRTIO_SND_R_PCM_RELEASE, runtime->state remains SNDRV_PCM_STATE_PREPARE=
D,
   vss->preparing is false, and vss->prepared remains true. A concurrent
   SNDRV_PCM_IOCTL_SYNC_PTR can still enqueue messages during
   disable_work_sync() or observe vss->stopped =3D=3D true during STOP/RELE=
ASE,
   re-arm runtime->stop_operating =3D true via virtsnd_pcm_transfer_failed(=
),
   and return -EPIPE to trigger __snd_pcm_xrun().

[1] https://lore.kernel.org/r/20261103000403.67106-2-mynameisjune111@gmail.=
com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103080821.1698=
3-1-mynameisjune111@gmail.com?part=3D1
