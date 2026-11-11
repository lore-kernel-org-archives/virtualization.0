Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794357519;
	b=OAI8WKnlVAoJnNJaV5HhsZALAzu95SZ2tKfef+icKB20io6XbehICX+Bodfdod+Q/rvr
	 UX6iBysPplLQS8IMNcwAzfjyHKqtOckUI+8t4QXWg/4epIl9xHsowwszMs+/quSFjCHB/
	 EnoZRIAOQr6h+tbW3LtzKP+sFRhQTh1ScqowvSXnuEGcM6cofkMemTYfcdZA9K1mnSkVl
	 1v+lRofFX4oCZuqYhhbtlkWEQh2G1BcwC4HE0Ub35JccM4rG1vlFxPrOy2duumkIYYra9
	 ySBNRFFN/qaqXYtuK0Cb51XUCToc5AljH9LPaDj7j3+kEF7zF10aCUYEJX/3p53DvDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794357519;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KUGQasHc32I7j2nFx7BsnzN0b0hTIRDdi2RZSpsVO3k=;
	b=gE1YhnevcogL8UOJHXRmxGbBGx6+iDlUB6wrLCpUnzot2H2xKO4vqHRQbsC2IGOs9nzi
	 dcyC3Nx1dJqweaXZOKR8AyxFqbpyjYaLikQUJwmgTh1UDQ3ODsRZ2i0tFdWm3Sa47wZ/w
	 M8CQUHKtDEqJzDc6InlfWpTOjSWEmbnkcW60spuSSSoviDFVbs7TvcCCiAcY8iGl/C4FR
	 PAYXa1dqWV42LixY4tpcuZtiKqzABgwbI9IGsAbC1PaoBiCgRhqeZdZ1ZXCSLySH0V6z7
	 bnu+kDXqqIWNyFQFA3fMJq8Ux5EDhbyKRCbff61jHWXPLtLVjnaKnqLegMYaFhPijew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QjKk3dBW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78940606A31C;
	Wed, 11 Nov 2026 00:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QjKk3dBW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9271F0089F;
	Wed, 11 Nov 2026 00:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794357519;
	bh=KUGQasHc32I7j2nFx7BsnzN0b0hTIRDdi2RZSpsVO3k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QjKk3dBWmcft0VdgXjA71tY3a7/evwd9OWsaki3Bcyhq5W1WfYY7ypvvL8Vla0DxC
	 PTmrLr4Ofqzq8PxiiP8fBOGAKj8rKymXPuTbaDn2SCZbRg0ZUaLEw7Iex82kU75IrM
	 Q/CoMtigda1y/hCORwEUVp4/7Mc73LqRdMIzDZpe1fJYJQztzyjsL37xjHcN5gytG7
	 b/G8tri4hjYjefXBZbd11MTbr0J7rTBdln18QpZNiDi70QOG1UXPucnseYqvUvCKPg
	 kTRFO0apWCT+xl1ll0CNPYbOAF0xWSQ7UgvZsMknnto6m8gelhR0DcF+WogTZIm1cT
	 Tvp93FqAnYkSg==
Message-ID: <sashiko-outbox-208028@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v24 12/16] ALSA: virtio: use request-owned capture and
 serialize recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111000543.28550-13-mynameisjune111@gmail.com>
References: <20261111000543.28550-1-mynameisjune111@gmail.com>
 <20261111000543.28550-13-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 00:38:38 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] ALSA: virtio: virtsnd_pcm_ack_state() drops buffer_accessing
  gate check
- [Low] ALSA: virtio: commit message describes removal of non-existent
  module params
--

commit 3a8c0c09be55edc0cc56835782c41eed627f4c8b
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: use request-owned capture and serialize recovery

This commit switches capture substreams to request-owned buffers with
in-order completion commits and serializes PCM control state transitions,
recovery, and reset handling across epochs.

> Replace the direct/staged split with a common request-owned capture
> path. Remove capture_staging, capture_allow_short and
> capture_allow_empty. Packed status decoding and RELEASE/reprepare pause
> are still explicit, default-off compatibility options. This changes the
> default RX memory and copy cost.

[Severity: Low]
Is this paragraph left over from an earlier development branch?  Neither
the baseline nor earlier commits in the series define capture_staging,
capture_allow_short, capture_allow_empty, or a direct/staged split, while
capture_packed_status and capture_pause_restart are newly added by this
patch rather than retained.

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index a5a682534acf7..da4e98836721d 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c

[ ... ]

> @@ -733,116 +1840,397 @@ static void virtsnd_pcm_transfer_failed(struct v=
irtio_pcm_substream *vss)
>  	vss->substream->runtime->stop_operating =3D true;
>  }
> =20
> -/* The caller holds the PCM lock, also used by DROP and state transition=
s. */
> -static int virtsnd_pcm_ack_state(struct snd_pcm_substream *substream)
> +/* Caller holds vss->lock; a paused ACK must not trigger linked XRUN. */

[ ... ]

> +/* The caller holds the PCM lock, also used by DROP and state transition=
s. */
> +static int virtsnd_pcm_ack_state(struct snd_pcm_substream *substream)
> +{
> +	switch (substream->runtime->state) {
> +	case SNDRV_PCM_STATE_XRUN:
> +		/*
> +		 * pcm_lib_apply_appl_ptr() interprets -EPIPE as a new XRUN
> +		 * and calls __snd_pcm_xrun(), which stops the whole linked
> +		 * group. The stream is already XRUN; do not repeat that action.
> +		 */
> +		return -EBADFD;
> +	case SNDRV_PCM_STATE_PREPARED:
> +	case SNDRV_PCM_STATE_RUNNING:
> +	case SNDRV_PCM_STATE_PAUSED:
> +	case SNDRV_PCM_STATE_DRAINING:
> +		return 0;
> +	default:
> +		return -EBADFD;
> +	}
> +}

[Severity: Medium]
Can dropping the atomic_read(&substream->runtime->buffer_accessing) < 0
check here let a concurrent SNDRV_PCM_IOCTL_SYNC_PTR admit an ACK while a
non-atomic operation holds the buffer access lock?

snd_pcm_sync_ptr() does not check runtime->buffer_accessing before calling
pcm_lib_apply_appl_ptr() -> substream->ops->ack().  Relying only on
vss->preparing and vss->indirect_reset_observing leaves unguarded windows
where buffer_accessing is negative but those flags are not set on the
substream yet:

CPU0                                  CPU1
snd_pcm_prepare(s0) [linked s0, s1]
  snd_pcm_group_buffer_access_lock()
    s1->runtime->buffer_accessing =3D -1
  snd_pcm_do_prepare(s0)
    virtsnd_pcm_prepare(s0) [sleeps]
                                      snd_pcm_sync_ptr(s1)
                                        pcm_lib_apply_appl_ptr(s1)
                                          virtsnd_pcm_pb_ack(s1)
                                            /* s1->preparing is false */
                                            virtsnd_pcm_msg_send(vss1)
  snd_pcm_do_prepare(s1)
    virtsnd_pcm_prepare(s1)

Here s1 is already in SNDRV_PCM_STATE_PREPARED when the linked prepare
starts, so CPU1 queues new TX descriptors on s1 after the group buffer
access gate was closed.  Similar windows exist across linked
snd_pcm_reset() before or after a member's snd_pcm_lib_reset() call, and
in snd_pcm_hw_params() or snd_pcm_hw_free() on a PREPARED substream before
virtsnd_pcm_sync_stop_locked() sets vss->preparing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111000543.2855=
0-1-mynameisjune111@gmail.com?part=3D12
