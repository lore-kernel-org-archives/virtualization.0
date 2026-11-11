Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794356710;
	b=Cr6TeSBfA/aPy1iH25V/9eXPiTAFh72Li5JksxnGlu/YF6QZxUE+USl0MvbSro90pGVf
	 /pMbjbiy3YMDqgjPk02rfm7SresRwmRobYsZdF/yaR7VabnnlrCDuzSAHsNlyfT7Nh+GM
	 u+2ZOLqqX4TPLhdjazjPBTglKhcSYmRRcvgqT1LupXoupk4Nnlb8VwfCpbeYvCUoipjYB
	 uXimWw446NM3B17WeFo/x+1FtTzM4aj6bGp0KDTpDNJImEUv+v1VRlN+u0Oddq7rpXdot
	 uLSRsP9rzLvTYWeAuikZ2lMJ1iVKUa0RIMPO64ik3gQXXTfXk7WbeTUzAAo5ztUQLoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794356710;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hY3G4rqZxw1Ffeo470oFjQR46jceljq58OMbZiW+9O4=;
	b=c5UasNKeVGKZ3Tx6JgnKQDyVATbdIG8FWrKXjyRbckAXW42L4SxB7LLynj+S45kmrTl9
	 0fK3RjYsiqFDiFiFyTkTSXRsomTgrf75y0qMTyDtPM+pgu+WrrjWjXazT0V5i4CmvCAAf
	 a1yeoYhqyuAoyuHdQXwv1s6Lsq3Qz225hlCl7rw7TXoTONcBlc5Is/ywNg0ihPIPHUYPj
	 ZwNFRQKZQ6Jz0MzTGOXwgtabfH1Aq/Cj8+XOPmqssBjp+9P/zx227mACsK9GZSKCdLyeX
	 xk/YQTFtjyzWU4z+Nt59v1MhJ7I8ECecSst5+NxekBnVjom43sbM3ZBBr9uEMdE+9NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I6NAmQBN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF3C606A33D;
	Wed, 11 Nov 2026 00:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I6NAmQBN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330341F00A0C;
	Wed, 11 Nov 2026 00:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794356710;
	bh=hY3G4rqZxw1Ffeo470oFjQR46jceljq58OMbZiW+9O4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I6NAmQBN8PX170lTAHdCwecE9nmhn8zoF8rmRQ3OJvwiBi1h7g8mFXCQByRl9XCvC
	 C2ygz2+Um7WiNc9z4HVqZT858S25m/Y04t2vmfGUtOADIJTosEOEh3IIaBGQbWNFEP
	 w0Em3XzshsBmwCw09klU8xYfN/WK3/++utyWDqxMibsTXNq8RmFdWGVaVUBRLcmkhN
	 ZtBeED61yBx49pQ+KnGwjH0PdAJj/dWUxrw+UqNhQMgYlJjHQhzkrXJ+BqZ9vjiNwq
	 tXgJUkz2lEoF8XlQexscui80c7vvxsSzvJsp6qIVtcJc1BHZBWnr6B55LTj9bCtB1S
	 83IzSOw5TL3jw==
Message-ID: <sashiko-outbox-208016@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v24 02/16] ALSA: pcm: report partial progress under the
 stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111000543.28550-3-mynameisjune111@gmail.com>
References: <20261111000543.28550-1-mynameisjune111@gmail.com>
 <20261111000543.28550-3-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 00:25:09 +0000
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
- [High] ALSA: pcm: premature drain done on capture in
  snd_pcm_update_state()
- [Medium] ALSA: pcm: stale avail in __snd_pcm_lib_xfer() drops capture
  drain tail
--

commit 729bfce97b1180fb1f0b36f0f5fb43c69406d7d3
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: pcm: report partial progress under the stream lock

This commit introduces snd_pcm_progress_under_stream_lock() so drivers can
publish partial-period progress and final capture drain tails under the PCM
stream lock without ticking the PCM period timer.

> diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
> index bb16738bb5919..a5665bb2b0705 100644
> --- a/sound/core/pcm_lib.c
> +++ b/sound/core/pcm_lib.c
> @@ -1918,6 +1918,30 @@ void snd_pcm_period_elapsed_under_stream_lock(stru=
ct snd_pcm_substream *substrea
>  }
>  EXPORT_SYMBOL(snd_pcm_period_elapsed_under_stream_lock);
> =20
> +/**
> + * snd_pcm_progress_under_stream_lock - Report progress without a period=
 IRQ
> + * @substream: PCM substream
> + *
> + * Context: PCM stream lock held, with no driver pointer or trigger lock=
s held.
> + * Updates the pointer and wakes readers for partial-period transfers. C=
apture
> + * streams may report their final tail while DRAINING. Unlike a period
> + * notification, this does not imply an elapsed period or tick the PCM t=
imer.
> + * The same pointer, trigger and timestamp callbacks may be invoked.
> + */
> +void snd_pcm_progress_under_stream_lock(struct snd_pcm_substream *substr=
eam)
> +{
> +	if (PCM_RUNTIME_CHECK(substream))
> +		return;
> +	if (!snd_pcm_running(substream) &&
> +	    !(substream->stream =3D=3D SNDRV_PCM_STREAM_CAPTURE &&
> +	      substream->runtime->state =3D=3D SNDRV_PCM_STATE_DRAINING))
> +		return;
> +	snd_pcm_update_hw_ptr(substream);

[Severity: High]
Does calling snd_pcm_update_hw_ptr() on a capture substream in
SNDRV_PCM_STATE_DRAINING cause snd_pcm_update_state() to prematurely finish
draining when the capture buffer fills up?

Previously, snd_pcm_update_hw_ptr() was only called when snd_pcm_running()
was true, which includes SNDRV_PCM_STATE_DRAINING only for playback.  In
snd_pcm_update_state(), the draining check assumes playback semantics where
avail >=3D runtime->buffer_size means the playback buffer has emptied:

sound/core/pcm_lib.c:snd_pcm_update_state() {
	avail =3D snd_pcm_avail(substream);
	if (avail > runtime->avail_max)
		runtime->avail_max =3D avail;
	if (runtime->state =3D=3D SNDRV_PCM_STATE_DRAINING) {
		if (avail >=3D runtime->buffer_size) {
			snd_pcm_drain_done(substream);
			return -EPIPE;
		}
	} else {
		if (avail >=3D runtime->stop_threshold) {
			__snd_pcm_xrun(substream);
			return -EPIPE;
		}
	}

For capture, avail is the number of unread frames in the buffer.  If a
capture stream in SNDRV_PCM_STATE_DRAINING reaches a full buffer (avail >=3D
runtime->buffer_size) when snd_pcm_progress_under_stream_lock() updates
hw_ptr, snd_pcm_update_state() calls snd_pcm_drain_done() and moves the
stream to SNDRV_PCM_STATE_SETUP, causing subsequent reads to fail with
-EBADFD and losing the buffered capture audio (as well as bypassing the
stop_threshold overrun check).

[Severity: Medium]
Can a capture tail published via snd_pcm_progress_under_stream_lock() be
discarded if it arrives while __snd_pcm_lib_xfer() is copying frames to
userspace?

CPU0                                    CPU1
__snd_pcm_lib_xfer()
  snd_pcm_stream_lock_irq()
  avail =3D snd_pcm_avail(substream)
  /* size > avail */
  frames =3D avail
  snd_pcm_stream_unlock_irq()
  writer(...)
                                        snd_pcm_stream_lock_irq()
                                        snd_pcm_progress_under_stream_lock()
                                          snd_pcm_update_hw_ptr()
                                        snd_pcm_stream_unlock_irq()
  snd_pcm_stream_lock_irq()
  ...
  avail -=3D frames; /* avail =3D=3D 0 */
  /* next loop iteration */
  if (!avail)
    snd_pcm_drain_done(substream)  <-- drops newly published tail

Previously, hw_ptr did not advance once a capture stream entered
SNDRV_PCM_STATE_DRAINING, so tracking avail locally across the unlocked
writer() call via avail -=3D frames was exact.  When
snd_pcm_progress_under_stream_lock() advances hw_ptr during that window,
the cached avail reaches 0 on the next iteration and __snd_pcm_lib_xfer()
calls snd_pcm_drain_done() without re-checking snd_pcm_avail(substream),
transitioning the stream to SNDRV_PCM_STATE_SETUP and dropping the final
tail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111000543.2855=
0-1-mynameisjune111@gmail.com?part=3D2
