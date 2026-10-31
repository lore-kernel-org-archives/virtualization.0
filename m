Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793414427;
	b=mhfBddcogeB2NCyzk+D4LjyatScnlxCTNwE39XHV4iDYR01JCCNK8GoCx+cqJLG8k2YV
	 khCyoYQbJyvQbJfjVRPtNM+ssyExys1VHrELJn4hHaElVAQ56cFwAUifl1gKqfGfi2J8i
	 HABglLvV2hRVUKUj9b/MixLX2vVcoNZHJ8Un9rHlC7GZXxpeUgEAn6jhqHI7ec4yph8hF
	 UvCH4/ZzSv2n4NYZpANCACqwfBezmPJT0JpY3gSVrdUfvQfCAU1e4EbTgq3RNjq8ClmZe
	 CPkBzJwGTVftxFeYF8zz2v3DP4zNOEVj0xp0kzqdw32bFvZDgFVPm0uVIeARyR/38BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793414427;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bXehV2Le+7bNAwDhSSVOo7FVY6vJukWMJ2YirnPbG8s=;
	b=4S2gKs/zBTe0bUQfiW5nq6zdhQ6tfGYQBPMPaRV8+PaeUukARaLvJdmQDjUY0F9vl68g
	 BabfpzhZFxLLm/lbGlAeg82IHhhg0DTEjvbtFtaTOylzCp1YYu2juKKfaRJgnHd59S2Rl
	 1NmpHBZGTIO9O/+0AgU6nlqIFXQig9xh2gA43XipINv33z1IVuJA+Mnf7H9/JM1xpQjXh
	 2JKdgRPQJbNqVSryPyk9Qz5e9TRos97H9sUgSuEAMAJHI0M/spGPG3Jno2niT4mdkz1Ox
	 lc1JZm7j78S4efBr4kkQiSj7g9muHZKAN/0JyrHpa5vg7FUahH6V17TK2HTkGS50I7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cmp1Tzm0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4293A606A31A;
	Sat, 31 Oct 2026 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cmp1Tzm0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940B01F000C1;
	Sat, 31 Oct 2026 02:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793414426;
	bh=bXehV2Le+7bNAwDhSSVOo7FVY6vJukWMJ2YirnPbG8s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cmp1Tzm0hif86sUXUz1eMmHoKOcINxLf8lie5hgI6dwD0oub+e9XsEgqteMXCRgRh
	 tconvsQ1FvHWhdJIHwUR4/RP6+ZP6squYIvxqL+xxg4rRuGxI2R2cNSZHcepeQ94Gg
	 4iDK6k6h+FD6iVSIuixtxVHuP2LnvU61uWxkl/dEOK8bOXeFkXOxES1DioYSe636Bz
	 27uANcCs+zC25tSUZMRbNmkICtkk5KwlRRU7viTaN9Eppn/iQy4K/qR9VXlLxGQ7ne
	 RAw93NeLYubyC0CQNOi1L6FAPD3ZWvRv1XypLgX44hKj2NOalMmxxSk2HugTFQmXoJ
	 8KAJ/nLDVdkAw==
Message-ID: <sashiko-outbox-191715@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 14/14] ALSA: virtio: rebase ordinary capture
 accounting on RESET
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261031020855.2402-15-mynameisjune111@gmail.com>
References: <20261031020855.2402-1-mynameisjune111@gmail.com>
 <20261031020855.2402-15-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 02:40:26 +0000
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
- [Medium] ALSA: virtio: stale pcm_indirect state after RESET in PREPARED s=
tate
--

commit c77024b62d8010ad66e1fdcc36816a226c5bcfcc
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: rebase ordinary capture accounting on RESET

This commit introduces virtsnd_pcm_indirect_reset() and
virtsnd_pcm_capture_indirect_ops to rebase ordinary capture indirect
positions and return discarded RX space when SNDRV_PCM_IOCTL_RESET is
called. It also suppresses nested ACK refills during the RESET pointer
observation and updates the period notification floor.

Link: https://sashiko.dev/#/patchset/20261030052629.27742-1-mynameisjune111=
%40gmail.com?part=3D14

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index f350d0c753763..9af0813acd77a 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c

[ ... ]

> @@ -1761,6 +1769,89 @@ static int virtsnd_pcm_sync_stop(struct snd_pcm_su=
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
> +	snd_pcm_uframes_t paused_ptr =3D 0;
> +	bool paused =3D runtime->state =3D=3D SNDRV_PCM_STATE_PAUSED;
> +	int rc;
> +
> +	/* Only PCM-locked callbacks access this observation flag. */
> +	vss->indirect_reset_observing =3D true;
> +	rc =3D snd_pcm_lib_reset(substream);
> +	vss->indirect_reset_observing =3D false;
> +	if (rc)
> +		return rc;
> +	guard(spinlock_irqsave)(&queue->lock);
> +	guard(spinlock)(&vss->lock);
> +	if (vss->resetting)
> +		return 0;
> +	if (vss->xfer_xrun) {
> +		virtsnd_pcm_transfer_failed(vss);
> +		virtsnd_pcm_schedule_period_elapsed(vss);
> +		return 0;
> +	}
> +	if (!snd_pcm_running(substream) && !paused)
> +		return 0;

[Severity: Medium]
Can returning early here when the substream is in SNDRV_PCM_STATE_PREPARED
leave vss->pcm_indirect.appl_ptr and vss->pcm_indirect.sw_ready out of sync
with runtime->control->appl_ptr?

While in SNDRV_PCM_STATE_PREPARED (where vss->prepared is true and
vss->stopped is false), userspace can invoke SNDRV_PCM_IOCTL_SYNC_PTR
without SNDRV_PCM_SYNC_PTR_APPL to advance appl_ptr to N:

  snd_pcm_sync_ptr()
    pcm_lib_apply_appl_ptr()
      virtsnd_pcm_cp_ack()
        virtsnd_pcm_cp_ack_locked()
          snd_pcm_indirect_capture_transfer()

which sets vss->pcm_indirect.appl_ptr =3D N and
vss->pcm_indirect.sw_ready =3D -frames_to_bytes(runtime, N).

If userspace then calls SNDRV_PCM_IOCTL_RESET in SNDRV_PCM_STATE_PREPARED,
snd_pcm_lib_reset() sets runtime->status->hw_ptr =3D 0,
virtsnd_pcm_indirect_reset() returns 0 early without updating
vss->pcm_indirect, and snd_pcm_reset_substream() resets
runtime->control->appl_ptr =3D runtime->status->hw_ptr (0).

When the stream is subsequently started and virtsnd_pcm_cp_pointer() or
virtsnd_pcm_cp_ack() runs before appl_ptr reaches N,
snd_pcm_indirect_capture_transfer() sees diff =3D appl_ptr - rec->appl_ptr =
< 0:

  if (diff) {
          if (diff < -(snd_pcm_sframes_t) (runtime->boundary / 2))
                  diff +=3D runtime->boundary;
          if (diff < 0)
                  return -EPIPE;

causing a false -EPIPE XRUN and a dev_err() message in
virtsnd_pcm_cp_ack_locked().

Should virtsnd_pcm_indirect_reset() also reset vss->pcm_indirect.sw_ready =
=3D 0
and vss->pcm_indirect.appl_ptr =3D runtime->status->hw_ptr when not running=
 or
paused, similar to how virtsnd_pcm_reset() updates
vss->pcm_indirect.appl_ptr =3D runtime->status->hw_ptr?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031020855.2402=
-1-mynameisjune111@gmail.com?part=3D14
