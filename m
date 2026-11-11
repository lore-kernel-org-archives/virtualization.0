Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380773;
	b=kohTwKIEi42FGawCalmCXqlVGcYxBnkHaLzBf4b/fe6mCUYIblDYeN91ZNCP8l48OL9b
	 gRolTcuyncQJIhG8CLdAw/CGFKwkwJWwyQz0rXmddMe/S2DKoQcEqg4PFP4VETdIw9EVK
	 8z9/9h2puhQmkne1xVTzjdZfKur9aekFwh8QOJOHAcPNJUxQcZ9ns5N55WDlvlHLdMoKn
	 HtRXAev9f7nJI+4ydCciLCpDiCSha8lErzY/fRVPOISw9g9HNJFOwNV882WQ9O1xDWNdU
	 oDQadHU11mWjx2wJvTGGSgQ+Q0JBs8lizbAt8rnEsSpAaNtkuSe0drPXjVeKmaqSszw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380773;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kiC1dk/D3WfChojwkHq8tdUVwnIH9qRQ/lLSe/RcCk4=;
	b=YBJSqimXntZfF6QtKfM6WFAns7vIfgw5BTHppsWSXozBNb57K+jAbu4K4p4rhzFZ39xC
	 T0jGmC9Rm6OEyAzTdoJUwlNQRCbmJehOHxsXbcJO9fuLcLzhYxf0XT8lOFdZqkzoITuXh
	 pOUvnJ/63Np01YXyZpnUNVa2SHFGsRzEqI7X0De1Satd/7xtCgs2mnFs+kXETheL/0boJ
	 YMGZOnBf54+aXXcpNugJ7VjiwQ4GJ/ho8ETLW+SOqEXjGoqwY2RV1UApq+DJ6lZEC6gRW
	 rKyZqLW3VXuAugVWk99N6A8mdBsALG4pXFpUTFjAGEF8UyCgCYyUI0PtL0KEObPT3lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TUPfq37n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E92C606A31C;
	Wed, 11 Nov 2026 07:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TUPfq37n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74EAE1F00A05;
	Wed, 11 Nov 2026 07:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794380772;
	bh=kiC1dk/D3WfChojwkHq8tdUVwnIH9qRQ/lLSe/RcCk4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TUPfq37nOGSH0WrkfwX0hZlfesdyIVMJDbo+n7B3VjIdWhPNqWJfznrg/r/+o/V7m
	 oXALyqKHtdbsvrRA0XstbJLKpmWoKPzDQWrxgsOS5xmJUq2xZACxK3Kx6RfaZG1St8
	 aN+d2JB7u3sQmnaHBKbPpnbtKofpWHY0W9nbFeu6rbuyFnoQggNkOSgU+JkVxmIrvB
	 +7UMTVcfzYRJzCgdzbOtW0Uz+cl4DtTW2lg35XqgA0l1/KQtTo6RNBGaNNxHeLTnsO
	 TFOjG3Q1NSj1w4hTNQqlocD54uJXOtZU8jAGOp/Pr3c/3subLbVP1ywqxnJgGt8t6l
	 4LltVja4Y4QMA==
Message-ID: <sashiko-outbox-208492@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v25 16/16] ALSA: virtio: preserve playback progress
 across pause
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111025655.63951-17-mynameisjune111@gmail.com>
References: <20261111025655.63951-1-mynameisjune111@gmail.com>
 <20261111025655.63951-17-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 07:06:12 +0000
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
- [Medium] ALSA: virtio: dropped refill in virtsnd_pcm_pb_pointer()
  stalls playback
--

commit 4311dfc7324b8614c483b2c630bddb6a93007fbd
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: preserve playback progress across pause

This commit preserves playback completion progress across pause, caches
device latency in substream state, caps indirect hw_queue_size to one period
below the buffer size, and skips period notifications when no playback
progress is pending.

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index 6d6c1bcd8601b..6c11885c55104 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c
> @@ -770,6 +770,13 @@ static int virtsnd_pcm_prepare_locked(struct snd_pcm=
_substream *substream)
>  		memset(&vss->pcm_indirect, 0, sizeof(vss->pcm_indirect));
>  		vss->pcm_indirect.sw_buffer_size =3D vss->buffer_bytes;
>  		vss->pcm_indirect.hw_buffer_size =3D vss->buffer_bytes;
> +		if (vss->direction =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
> +			/* Keep unobserved completions below one physical ring. */
> +			vss->pcm_indirect.hw_queue_size =3D vss->buffer_bytes -
> +				snd_pcm_lib_period_bytes(substream);
> +			vss->playback_latency_bytes =3D 0;
> +			substream->runtime->delay =3D 0;
> +		}

[Severity: Medium]
Can capping vss->pcm_indirect.hw_queue_size leave the held-back period in
vss->pcm_indirect.sw_ready unsubmitted if virtsnd_pcm_pb_pointer() runs whi=
le
runtime->buffer_accessing is temporarily negative?

With hw_queue_size capped at buffer_bytes - period_bytes, filling the buffer
holds the final period in vss->pcm_indirect.sw_ready until
virtsnd_pcm_pb_pointer() calls snd_pcm_indirect_playback_pointer(), which
updates hw_io and hw_ready before invoking substream->ops->ack()
(virtsnd_pcm_pb_ack()).

If a concurrent non-atomic ioctl such as SNDRV_PCM_IOCTL_RESET or
SNDRV_PCM_IOCTL_PREPARE on a running stream calls
snd_pcm_buffer_access_lock() before acquiring the PCM stream lock and being
rejected with -EBUSY, runtime->buffer_accessing is transiently -1:

sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_ack_state() {
    ...
	case SNDRV_PCM_STATE_RUNNING:
	case SNDRV_PCM_STATE_PAUSED:
	case SNDRV_PCM_STATE_DRAINING:
		if (atomic_read(&substream->runtime->buffer_accessing) < 0)
			return -EBADFD;
		return 0;
    ...
}

snd_pcm_indirect_playback_pointer() only checks for -EPIPE and ignores
-EBADFD, so vss->pcm_indirect.hw_io advances to vss->hw_ptr without queuing
vss->pcm_indirect.sw_ready.  With a two-period buffer or during
SNDRV_PCM_STATE_DRAINING, vss->msg_count reaches 0 with vss->hw_ptr equal to
vss->pcm_indirect.hw_io, virtsnd_pcm_playback_progress_pending() returns
false, and playback or drain stalls.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111025655.6395=
1-1-mynameisjune111@gmail.com?part=3D16
