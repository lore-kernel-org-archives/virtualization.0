Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793339684;
	b=fRW4GQdjNHGLR4vS5byZwCQzyU+Jbwx9dYZ3xNnFyHwuf3SzSjEmOhRx/3oK0x3ny6Ov
	 0Jl0QAoQY2NymagBB9WzaSSgpmYnwj1v8ggXzzpiK7l6do8l3kbxqFGgG1Xxg4pAFG1Gn
	 qqAFgIZTFH3YxLiUSHshIPI23659b4FKyei1nQAqgsT8u4t28WvbTxK760tQHCtVfmpWB
	 WJyuoxo+N2cskszh7yb6EI5e/l3odEItWLfnvXQJj+hV52rsOivpzxNI2V6hWXuzdTJjd
	 mjt3kk61u9R/lPEL14JD5YlM6w2TYcF4oiqb+biSI4V4rvkdAgJddAq+6dHVl50nUxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793339684;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=utFRielSE6lIiokKz5yj8gwGY1Gv8FkBQHyYPLg2eUQ=;
	b=3e9BjXivR5b9KGtpevEhuBmAg8P9/svQaNaJTnzJzGTJtttXzwcbcSeu8kXa19oxTHeT
	 h2EveHzPO1XFMlhEuB7pqq+fmS5tsY88Qt7R40v+1IbD859qJWPZrMA7YvzM7m5On6MXn
	 vK2bDDuN0I3yEfxWX3ddr7nA9Be56PmjnXurl/t8MV7jMinI+4SrVdfmYCCuQfgbhNNJp
	 im+PFGaDx0KTgC/obWCU8frytw1wlDefOnDHQ3+iupYz5khGpFD6lFPhbwbYztsy7LiZV
	 rtwUzg7KZSkSmVTFSvxuetbE8uNWmgeUhI7osnDmyOlcE53XHNh16AfyqDMSKooyyrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hXlkI4vZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B9B606A332;
	Fri, 30 Oct 2026 05:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hXlkI4vZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7581F000C1;
	Fri, 30 Oct 2026 05:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793339683;
	bh=utFRielSE6lIiokKz5yj8gwGY1Gv8FkBQHyYPLg2eUQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hXlkI4vZP739YSfoc3nezq0PC4U+5MEEdsqATISN0ODzLiubo9SvO4bb5M35jM58f
	 haO16vaAcacnAOYxorDgCSZFgWGZmTZhg8PZhgDODTY4A+QbwJsnU/fgcyNHEiFTZL
	 9iBTRCVrkqif8V+z+NG/qurJh+dcYH7HMsZ+bFRqUMqxAJtwQkKsHlqkSa0IwzpGy3
	 LKZorcw/cQ7cjWpJGLofb2/3l+//QNxxn1zr+kQY5p68zZpqzaK6r7jWwvpzYLj2fJ
	 OGpKiWZfJM+tL6ihle3blaK4oHMc4gzHM4Sw0HJrarcyVLciNRSQ1GE9Va4fseVDcV
	 VklWQCQ0et9Tw==
Message-ID: <sashiko-outbox-190579@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 12/14] ALSA: pcm: add an optional reset operation
 under the stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261030052629.27742-13-mynameisjune111@gmail.com>
References: <20261030052629.27742-1-mynameisjune111@gmail.com>
 <20261030052629.27742-13-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 05:54:43 +0000
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
- [Medium] ALSA: pcm: unlocked appl_ptr overwrite in snd_pcm_post_prepare()=
 with reset op
--

commit 963c7726f3bbfa33b12ff37026f791cf2e45509e
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: pcm: add an optional reset operation under the stream lock

This commit adds an optional reset callback to struct snd_pcm_ops that runs
under the substream's PCM stream lock, and exposes snd_pcm_lib_reset() for
drivers to retain the common pointer update logic.

> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index a2ea44c3c1d29..41c691512f54c 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -1988,7 +1988,31 @@ static int snd_pcm_do_reset(struct snd_pcm_substre=
am *substream,
>  			    snd_pcm_state_t state)
>  {
>  	struct snd_pcm_runtime *runtime =3D substream->runtime;
> -	int err =3D snd_pcm_ops_ioctl(substream, SNDRV_PCM_IOCTL1_RESET, NULL);
> +	int err;
> +
> +	if (substream->ops->reset) {
> +		/*
> +		 * Complete this member before releasing its PCM lock. A later
> +		 * linked member may fail; RESET has no group rollback operation.
> +		 */
> +		guard(pcm_stream_lock_irq)(substream);
> +
> +		err =3D substream->ops->reset(substream);
> +		if (err < 0)
> +			return err;
> +		runtime->hw_ptr_base =3D 0;
> +		runtime->hw_ptr_interrupt =3D runtime->status->hw_ptr -
> +			runtime->status->hw_ptr % runtime->period_size;
> +		runtime->silence_start =3D runtime->status->hw_ptr;
> +		runtime->silence_filled =3D 0;
> +		runtime->control->appl_ptr =3D runtime->status->hw_ptr;
> +		if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK &&
> +		    runtime->silence_size > 0)
> +			snd_pcm_playback_silence(substream, ULONG_MAX);
> +		return 0;
> +	}
> +
> +	err =3D snd_pcm_ops_ioctl(substream, SNDRV_PCM_IOCTL1_RESET, NULL);
>  	if (err < 0)
>  		return err;
>  	guard(pcm_stream_lock_irq)(substream);
> @@ -2004,6 +2028,9 @@ static void snd_pcm_post_reset(struct snd_pcm_subst=
ream *substream,
>  			       snd_pcm_state_t state)
>  {
>  	struct snd_pcm_runtime *runtime =3D substream->runtime;
> +
> +	if (substream->ops->reset)
> +		return;

[Severity: Medium]
Does snd_pcm_post_prepare() also need to account for substream->ops->reset?

In sound/core/pcm_native.c, the prepare path runs:

  snd_pcm_prepare()
    -> snd_pcm_action_nonatomic(&snd_pcm_action_prepare, ...)
      -> snd_pcm_do_prepare()
        -> snd_pcm_do_reset()
      -> snd_pcm_post_prepare()

When substream->ops->reset is implemented, snd_pcm_do_reset() rebases
runtime->control->appl_ptr =3D runtime->status->hw_ptr under
guard(pcm_stream_lock_irq)(substream) and then releases the lock. While
snd_pcm_post_reset() skips the redundant assignment when substream->ops->re=
set
is set, snd_pcm_post_prepare() was not updated:

  static void snd_pcm_post_prepare(struct snd_pcm_substream *substream,
                                   snd_pcm_state_t state)
  {
          struct snd_pcm_runtime *runtime =3D substream->runtime;
          runtime->control->appl_ptr =3D runtime->status->hw_ptr;
          snd_pcm_set_state(substream, SNDRV_PCM_STATE_PREPARED);
  }

Between snd_pcm_do_reset() releasing pcm_stream_lock_irq and
snd_pcm_post_prepare() running (for example, while subsequent linked group
members execute snd_pcm_do_prepare()), a concurrent SNDRV_PCM_IOCTL_SYNC_PT=
R in
snd_pcm_sync_ptr() or a transfer/rewind/forward on another linked member th=
at
was already in SNDRV_PCM_STATE_PREPARED can take pcm_stream_lock_irq and up=
date
runtime->control->appl_ptr via pcm_lib_apply_appl_ptr(). Afterward,
snd_pcm_post_prepare() overwrites runtime->control->appl_ptr without holding
pcm_stream_lock_irq, which can desynchronize runtime->control->appl_ptr from
driver state.

In addition, because snd_pcm_do_prepare() calls snd_pcm_do_reset(), calling
snd_pcm_playback_silence(substream, ULONG_MAX) inside snd_pcm_do_reset() wh=
en
substream->ops->reset is set causes prepare on a playback stream with
runtime->silence_size > 0 to fill silence during do_prepare before the stre=
am
transitions to SNDRV_PCM_STATE_PREPARED, whereas the legacy path only runs
snd_pcm_playback_silence() in snd_pcm_post_reset() and snd_pcm_post_start().

Should snd_pcm_post_prepare() skip the appl_ptr assignment when
substream->ops->reset is set, and should snd_pcm_do_reset() avoid calling
snd_pcm_playback_silence() when invoked from snd_pcm_do_prepare()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030052629.2774=
2-1-mynameisjune111@gmail.com?part=3D12
