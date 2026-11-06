Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989194;
	b=DWqAOIe1SevqhwXJyMarqIdKGzzlD18AezU1toJbz0EmPqCH51TpwJYw9XTfEblxMutg
	 aW1rZeaIZksoQC4PJxhd5IehlE9xTHFbDjaBuuQGO47Yc3FeGtiwRG6RIqiINTJGvHuVz
	 I8nKlgRpQlfR5GVIGjd2tIkWpB4lNdjXZqZupyOPocPhOSZbbS//3zRkeB3EDcrp9mtWX
	 +XyUo3urMmuk4raguMOjTN9L5hzJqQao/FlP05cdAo+QPZYMHJq9QmEeuhjw0h7/ytpfq
	 GvtLEUVn26IU88OB9pRCYydMC7KS+wL5LYRcssFvhBTME48ver13yYfeZRAHKcz+dsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989194;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jgQYr1qO+YBZuGceCNEk1WU0AJEaTAb66XiA3OT4AfM=;
	b=kNjfo+vnjLiUYmY0cKrtbYbA/yHofBggvz4Bd485oze00+MZ8TgmklaKGiVAIbh+5OxE
	 q4lvk8hecDEsWdT4zlHKS4+ntLycJ5JSd7+SlV2wZ/LerCeMfkhFm6AKZHD0zDHpuPnMP
	 ukbMo/6J/3+rXLu+XYs+jppdFJNJbBFm06muhjJ1NBPsuLNHvDQPUKhEVgaB64cGklUhm
	 GKSmlAxmzORKA8av3EvNkBAJwsYB+M3FcmPtnOVtBSEYH/o0MyHsNF5g64xkrKSieqJ0O
	 zkdb+OxXVh0/lFYMHr+TbnaxKc5Q+PXPAITeQyfNxPgbGHA5/juMQ18Md96S44e/73Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yb3VQDIT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D68606A326;
	Fri,  6 Nov 2026 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yb3VQDIT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57591F0089F;
	Fri,  6 Nov 2026 18:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793989194;
	bh=jgQYr1qO+YBZuGceCNEk1WU0AJEaTAb66XiA3OT4AfM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yb3VQDITD0UHFPSAVg3UaIKKK9ZF+nRFXfvNMYmrRU2DP2FbkuEzuxmui5HbXygta
	 TM1dwSRngzZOYmYnUduWHIM/6dcWzzc5ORrFBH8UhZqCtH5u0+XeiLQQKTd8qG4Poh
	 VKbY5aM28oWQrDFlmtvKXnmBmM0Y0NjUyC1hJpk6NRLowC2Wfdwu4zDlt7YbKYd2j/
	 O490Hl3GfPx5bX1xxZXg+I/uJYA/PMqrU0m4EI3H//+XG8thUaUbaDblpsEaFLm+jY
	 7/1LPaAFW8852iUcPhVd/lGzTHildPU7DKLBUejBtwfx1JqRFMvNXwK5eNII0QgwWu
	 sXzqCGlCuMkcg==
Message-ID: <sashiko-outbox-202010@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 07/12] ALSA: virtio: validate indirect capture
 appl_ptr accounting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106161838.94308-8-mynameisjune111@gmail.com>
References: <20261106161838.94308-1-mynameisjune111@gmail.com>
 <20261106161838.94308-8-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 18:19:53 +0000
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
- [Medium] ALSA: virtio: sub-byte frame truncation in
  virtsnd_pcm_capture_ack_validate()
--

commit 6d8079ee9be8b0bc45d98d37834441cf9aa4b749
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: validate indirect capture appl_ptr accounting

This commit retains references to PCM DMA pages (or uses a driver-owned
buffer on NOMMU), validates full-period capture responses, seeds the RX
ring once per prepare, and validates capture appl_ptr accounting before
invoking the indirect transfer helper.

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index 343700ec50476..6a8752997d092 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c

[ ... ]

> @@ -599,6 +619,69 @@ struct virtsnd_pcm_transfer {
>  	int error;
>  };
> =20
> +/* Caller holds @vss->lock and the PCM stream lock. */
> +static int virtsnd_pcm_capture_ack_validate(struct virtio_pcm_substream =
*vss,
> +					    struct snd_pcm_runtime *runtime,
> +					    bool *skip_transfer)
> +{

[ ... ]

> +	/* The RX ring reserves its full size; only the excess is unread data. =
*/
> +	unread_bytes =3D (s64)rec->hw_ready + (s64)rec->sw_ready -
> +		       (s64)rec->sw_buffer_size;
> +	if (unread_bytes < 0 || unread_bytes > (s64)hw_queue_size)
> +		return -EPIPE;
> +
> +	appl_bytes =3D frames_to_bytes(runtime, (snd_pcm_uframes_t)appl_diff);
> +	if ((u64)appl_bytes > (u64)unread_bytes)
> +		return -EPIPE;
> +
> +	return 0;
> +}

[Severity: Medium]
Can frames_to_bytes() truncate sub-byte frame deltas here and let an
unaligned appl_ptr advance bypass validation?

virtsnd_pcm_hw_params() permits sub-byte frame formats such as 1-channel
SNDRV_PCM_FORMAT_IMA_ADPCM (4-bit frames, runtime->min_align =3D=3D 2) when
the period size is a whole number of bytes.  If userspace advances
appl_ptr by an odd number of frames via SNDRV_PCM_IOCTL_SYNC_PTR (for
example, 1 frame when unread_bytes is 0), frames_to_bytes() truncates
appl_bytes down, passing the unread_bytes check.
snd_pcm_indirect_capture_transfer() then sets rec->appl_ptr to the
unaligned appl_ptr while subtracting the truncated byte count from
rec->sw_ready, pushing appl_ptr past hw_ptr and permanently leaking
rec->sw_ready accounting so RX descriptors stop being requeued.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106161838.9430=
8-1-mynameisjune111@gmail.com?part=3D7
