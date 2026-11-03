Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793665915;
	b=mQJ5TQZHqI6M5C4tHDGXM9FKdVzv7VscwHsCx6E9QJwG7ckJ4X5TPzUU3PU4XMKvHfuc
	 QsdV6cxn3MJxWfzTC/IGxgj9Te/xkb1/oMxZdIoXbNVriOrAsFMGNUzTmmGhjWg3iMlzz
	 Af6HAP0bsdeWxnx4zNKzgedRKTSDQQAh4VOqQUL5VE9Rkl/NVgO5AMILNkJRChavSmh1j
	 xD4JGTEE3sfDo8SSP9vbjuS3KeNywo92twilqWn8tc7cIHmm6qMbMbVQG5iiWMefBZhWn
	 nSAy40jfMuCO36SFV7sd0MvpOEAFH/UPkqUg9Q3mLqU50HLnWwUzaIPpWc39x2iLkow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793665915;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0Kl5K3IBXk5NVpPtyg6eDuDuePr76FDEI1WnVIinEkA=;
	b=jajqqtTXSKY7VSA541/g41lNzqUJ89u/2hbLY87mhuKQXDTwkUdVPKgh4JNviDASpNBq
	 7cYD0vLF7BG3uFvDu7i/xcUmCmatRTKUW3/EjI5u+C6bqM+2FPwBOWBjmKBuonBz5KTbg
	 ++X0uDWLPdC8sUgMZWDtII5mvNUmR3E37vZmFf3ImaFh11nWf1+1KhtDgu6eHt4ggBFQy
	 PbJzFO2dmH+4Kj6tS0P0TMzR/S9FrMlHXlRbzUosgxw41achec/XZojjKR8VhBbM5DPkq
	 9myU3yP87B2HKpxb3X5VwcckPIb4jeuLRMPFmWCROvbhLmtDBIwQb16P85Zeq4Bz+9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jL7MWNSc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D26606A324;
	Tue,  3 Nov 2026 00:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jL7MWNSc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BBA1F000C1;
	Tue,  3 Nov 2026 00:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793665914;
	bh=0Kl5K3IBXk5NVpPtyg6eDuDuePr76FDEI1WnVIinEkA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jL7MWNScXPLTvzqhnMX6EnOjGuLybrhBkVAKY5LykBy8GXJKfnG1e6G30NebudPzw
	 GyNVJxjI9TFvvpvyErL2304RsN4f263KEqdBsnej1jQ57HTekVOGDyRT2Ndg9JrTyX
	 HY2Bas7uDEhJ8rdgsAyZLygz5NRAQTzbvcNpG00yywLZ9pJJYTvg33c9wp7xkBd+HT
	 ys2r7QXGp7v+otA5LKy0R4KRLELa3mD8UooG/m38Lyr/4u8WxTubG8XdW6Udf3yvFz
	 ylVqjMdZp6R3v8JspR8Yzpn8md5i5hA1oIY93nqqYzcPntHrWffg3ZBZdjQo9pSiYd
	 DwQC8i3cAwKbA==
Message-ID: <sashiko-outbox-194382@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 01/12] ALSA: virtio: Propagate PCM send failures
 through ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103000403.67106-2-mynameisjune111@gmail.com>
References: <20261103000403.67106-1-mynameisjune111@gmail.com>
 <20261103000403.67106-2-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 00:31:54 +0000
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
- [Medium] ALSA: virtio: race on stopped and stop_operating in virtsnd_pcm_=
pb_ack()
--

commit adfc01993325cef03121710f81f719a0dc208b01
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: Propagate PCM send failures through ACK

This commit updates virtsnd_pcm_msg_send() to roll back the message length
and notify the virtqueue for previously queued messages when adding a messa=
ge
fails. It also propagates transfer errors through virtsnd_pcm_pb_ack() and
virtsnd_pcm_cp_ack() so ALSA can handle them as XRUNs.

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index 1091100a4c982..a40ea394bf174 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c
> @@ -466,36 +466,100 @@ virtsnd_pcm_cp_pointer(struct snd_pcm_substream *s=
ubstream)
>  		vss->hw_ptr);
>  }
> =20
> +struct virtsnd_pcm_transfer {
> +	struct snd_pcm_indirect indirect;
> +	int error;
> +};
> +
>  static void virtsnd_pcm_trans_copy(struct snd_pcm_substream *substream,
>  				   struct snd_pcm_indirect *rec, size_t bytes)
>  {
>  	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
> +	struct virtsnd_pcm_transfer *transfer =3D
> +		container_of(rec, struct virtsnd_pcm_transfer, indirect);
> +
> +	if (transfer->error)
> +		return;
> =20
> -	virtsnd_pcm_msg_send(vss, rec->sw_data, bytes);
> +	transfer->error =3D virtsnd_pcm_msg_send(vss, rec->sw_data, bytes);
> +}
> +
> +/* Caller holds vss->lock. */
> +static void virtsnd_pcm_transfer_failed(struct virtio_pcm_substream *vss)
> +{
> +	vss->xfer_enabled =3D false;
> +	vss->stopped =3D true;
> +	vss->substream->runtime->stop_operating =3D true;
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
> +		else
> +			vss->pcm_indirect =3D transfer.indirect;
> +	}

[Severity: Medium]
Can virtsnd_pcm_pb_ack() and virtsnd_pcm_cp_ack() race with
snd_pcm_sync_stop() and virtsnd_pcm_sync_stop() on vss->stopped and
substream->runtime->stop_operating?

Because virtio-snd PCM devices are nonatomic (vpcm->pcm->nonatomic =3D true=
),
snd_pcm_sync_stop() is invoked without holding the PCM stream lock
(substream->self_group.mutex), such as from snd_pcm_drop() after dropping
pcm_stream_lock_irq() or from snd_pcm_do_prepare() under
runtime->buffer_mutex. Meanwhile, a concurrent SNDRV_PCM_IOCTL_SYNC_PTR ioc=
tl
in snd_pcm_sync_ptr() acquires only pcm_stream_lock_irq() and calls:

snd_pcm_sync_ptr()
  pcm_lib_apply_appl_ptr()
    virtsnd_pcm_pb_ack() / virtsnd_pcm_cp_ack()

In sound/virtio/virtio_pcm_ops.c, virtsnd_pcm_sync_stop() reads and clears
vss->stopped without holding vss->lock or the PCM stream lock, after
snd_pcm_sync_stop() clears substream->runtime->stop_operating:

static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream)
{
	...
	cancel_work_sync(&vss->elapsed_period);

	if (!vss->stopped)
		return 0;
	...
	vss->stopped =3D false;

	return 0;
}

If a concurrent ACK runs while vss->stopped is true, virtsnd_pcm_pb_ack() or
virtsnd_pcm_cp_ack() sets rc =3D -EPIPE and calls virtsnd_pcm_transfer_fail=
ed(),
which writes vss->stopped =3D true and substream->runtime->stop_operating =
=3D true.
That races with virtsnd_pcm_sync_stop() and re-arms stop_operating after
snd_pcm_sync_stop() cleared it, while returning -EPIPE so
pcm_lib_apply_appl_ptr() invokes __snd_pcm_xrun() even when snd_pcm_drop() =
had
placed the stream in SNDRV_PCM_STATE_SETUP.

Conversely, virtsnd_pcm_pb_ack() and virtsnd_pcm_cp_ack() only check
vss->stopped before transferring data. Once virtsnd_pcm_sync_stop() clears
vss->stopped =3D false after releasing the stream in SNDRV_PCM_STATE_SETUP,=
 a
subsequent SNDRV_PCM_IOCTL_SYNC_PTR ioctl sees vss->stopped =3D=3D false and
enqueues virtio I/O messages on a released stream.

Later commits in this series ("ALSA: virtio: Recover PCM state after a fail=
ed
start" and "ALSA: virtio: add staged capture and serialize PCM lifecycle
accounting") partially address this by guarding vss->stopped with vss->lock
and gating ACK on vss->prepared and vss->preparing, but do not completely
resolve the race. In virtsnd_pcm_sync_stop_locked() (and
virtsnd_pcm_pause_restart_sync_stop()) as well as virtsnd_pcm_prepare_locke=
d(),
vss->prepared remains true while vss->stopped is true across sleeping teard=
own
calls (cancel_work_sync(), virtsnd_pcm_stop_device(), and
virtsnd_pcm_send_sync() for VIRTIO_SND_R_PCM_RELEASE), and
virtsnd_pcm_pb_ack() does not check runtime->state. A concurrent
SNDRV_PCM_IOCTL_SYNC_PTR during that window still sees vss->prepared =3D=3D=
 true
and vss->stopped =3D=3D true, calls virtsnd_pcm_transfer_failed() to set
runtime->stop_operating =3D true after snd_pcm_sync_stop() cleared it, and
returns -EPIPE to trigger __snd_pcm_xrun().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103000403.6710=
6-1-mynameisjune111@gmail.com?part=3D1
