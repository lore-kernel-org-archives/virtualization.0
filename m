Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794202211;
	b=FCTJu0gyLpQ2gAbV5KCEHP235U/8RoYyTgwulyKIdm60a5ivD7b+TzADQEMRSlqLRPcc
	 9djN9/34KAnENJuzQx7hmCThzFOdVxnDJ5L2EZnsJfK3/gktbsdWZ4nV/XQgOde89H1hw
	 9DgpZ2OXpldCr4W4KEK28+cNvuKB0JbAs81Ujwlvy2mpGZCG4h4aT7ob8At7BQgn0/gmz
	 9uT7yFmO3RDCOXa5IyRnr6xhqnGp/aFOlE6c6V1zGC1enwi0lBojUScFYEYU80+jq8pw5
	 5pdt3dpcjcp2zqK03WlcNEPoiHnT1G+wkrU1hmO6ljIz9jhno/PLRRA11SAHHkDphjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202211;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+Bw3PuzllwZTI7Oe7Fg4GN3GOklle7Ccocgz2fgi9zs=;
	b=PTWv3AnaVeYGX2u6zq0Z5TEwjd7nm0usxlP41l8E7nIhOOTViNkZKf+cXMa2RSCM2tOc
	 EcoJicbkTwAYLfnPyrDJvx+6Wt7yait5KpFG4CNW9Tk1QBBvQrVq+I0lKJZ0DFVYpXV/X
	 6vKmfqZ6mil4MbT59wwhW5zsSAjAqJ/aJuk3e05fZc3dZxy7smTnDMfs8y2+zGzOK7Ehg
	 +QFtoTRegmIos8mONJiFN9ybpe94NXPsTkV/aDkKl5mf+J3nb1Br0OdnJONDL2zwjczgA
	 AtqAzMRVwQfjrkcpd2eciv/uKXGQiuim7/6sF+G02MSNamdVeKTSPsTVw7UN7ZXG/vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SiOTN/FK";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DB8606A31C;
	Mon,  9 Nov 2026 05:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SiOTN/FK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5121F0089F;
	Mon,  9 Nov 2026 05:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794202210;
	bh=+Bw3PuzllwZTI7Oe7Fg4GN3GOklle7Ccocgz2fgi9zs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SiOTN/FKAlFCjgPCmryUTqkalSgVH7CtnBeaUJbK0Q/0upG7muCJ+E6YK2KCku67R
	 mEMHeYEkuMMnLlH6ntOTsXb0HSpzT/Yfpyrk9rye5eqwqPGiYLXzt8Y4QV/ktiSOnD
	 MiM4tE+VO8dU4e9af3Qf3bnVkg0Vw4RtlXJfdI4YIXBywc3S+vIxHm91W5iZgStTJK
	 ZIWuuiAOgFi1qdl2WqLCZ3ANm6L72tbjB7aBlpvK/jlG0hXpwzGtxWOhUiE/wf1GiO
	 6Zygd7Fa0ROtFbiLqOyoIPPjDBCEW17llmJuK3FAMZx7yqJYLVwG5qziq7D40Pd6/e
	 cgt2aNfoqvPCg==
Message-ID: <sashiko-outbox-204440@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v22 04/13] ALSA: pcm: notify drivers after linked
 prepare completes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109051618.22506-5-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261109051618.22506-1-mynameisjune111@gmail.com>
 <20261109051618.22506-5-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 05:30:09 +0000
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
- [Medium] ALSA: pcm: spurious MSTOP timer notification in
  snd_pcm_complete_prepare()
- [Medium] ALSA: pcm: race window between snd_pcm_post_prepare() and
  prepare_complete()
--

commit 8b0a0bce1c3b8b4ee1000c353fc111291e35293e
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: pcm: notify drivers after linked prepare completes

This commit adds an optional prepare_complete callback to struct
snd_pcm_ops and invokes it under the PCM stream lock after single or
linked prepare actions complete or fail.

> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index e4c2fe70fa705..40ac7fb614567 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c

[ ... ]

> @@ -1350,6 +1352,13 @@ static int snd_pcm_action_group(const struct actio=
n_ops *ops,
>  					ops->undo_action(s1, state);
>  				}
>  			}
> +			if (ops->complete_action) {
> +				snd_pcm_group_for_each_entry(s1, substream) {
> +					ops->complete_action(s1, state, false);
> +					if (s1 =3D=3D s)
> +						break;
> +				}
> +			}
>  			s =3D NULL; /* unlock all */
>  			goto _unlock;
>  		}
> @@ -1357,6 +1366,10 @@ static int snd_pcm_action_group(const struct actio=
n_ops *ops,
>  	snd_pcm_group_for_each_entry(s, substream) {
>  		ops->post_action(s, state);
>  	}
> +	if (ops->complete_action) {
> +		snd_pcm_group_for_each_entry(s, substream)
> +			ops->complete_action(s, state, true);
> +	}

[Severity: Medium]
Can another caller observe SNDRV_PCM_STATE_PREPARED and invoke ops->ack()
or ops->trigger() in the unlocked window between snd_pcm_post_prepare()
and snd_pcm_complete_prepare()?

snd_pcm_post_prepare() calls snd_pcm_set_state(), which acquires
pcm_stream_lock_irq(substream), publishes SNDRV_PCM_STATE_PREPARED, and
unlocks before snd_pcm_complete_prepare() re-acquires the stream lock to
call ops->prepare_complete().

CPU0                              CPU1
snd_pcm_prepare()
  ...
  snd_pcm_post_prepare(s)
    snd_pcm_set_state(s, PREPARED)
      lock(s)
      __snd_pcm_set_state(s, PREPARED)
      unlock(s)
                                  snd_pcm_common_ioctl()
                                    snd_pcm_sync_ptr(s)
                                      lock(s)
                                      pcm_lib_apply_appl_ptr(s)
                                        s->ops->ack(s)  <-- rejected
  snd_pcm_complete_prepare(s, true)
    lock(s)
    s->ops->prepare_complete(s, true)
    unlock(s)

Because the driver still has admission closed until prepare_complete()
runs, concurrent SNDRV_PCM_IOCTL_SYNC_PTR or SNDRV_PCM_IOCTL_START calls
seeing SNDRV_PCM_STATE_PREPARED can fail with -EBADFD.  In addition, if a
concurrent snd_pcm_drop(), snd_pcm_drain(), or snd_pcm_suspend_all()
changes runtime->state during the unlocked window,
snd_pcm_complete_prepare() still calls prepare_complete(substream, true)
on success, or overwrites SNDRV_PCM_STATE_SUSPENDED with
SNDRV_PCM_STATE_SETUP on failure.

[ ... ]

> @@ -2099,10 +2118,29 @@ static void snd_pcm_post_prepare(struct snd_pcm_s=
ubstream *substream,
>  	snd_pcm_set_state(substream, SNDRV_PCM_STATE_PREPARED);
>  }
> =20
> +static void snd_pcm_complete_prepare(struct snd_pcm_substream *substream,
> +				     snd_pcm_state_t state, bool success)
> +{
> +	if (!substream->ops->prepare_complete)
> +		return;
> +
> +	guard(pcm_stream_lock_irq)(substream);
> +	if (!success && substream->runtime->state !=3D SNDRV_PCM_STATE_DISCONNE=
CTED) {
> +		if (substream->runtime->state !=3D SNDRV_PCM_STATE_SETUP) {
> +			__snd_pcm_set_state(substream->runtime, SNDRV_PCM_STATE_SETUP);
> +			snd_pcm_timer_notify(substream, SNDRV_TIMER_EVENT_MSTOP);
> +		}

[Severity: Medium]
Does snd_pcm_complete_prepare() emit a spurious SNDRV_TIMER_EVENT_MSTOP
notification when prepare fails?

In snd_pcm_prepare(), PAUSED and SUSPENDED streams are already stopped
via snd_pcm_stop() before snd_pcm_action_prepare runs, and
snd_pcm_pre_prepare() rejects RUNNING and playback DRAINING streams with
-EBUSY.  Any substream reaching this path with runtime->state !=3D
SNDRV_PCM_STATE_SETUP (such as a re-prepare from PREPARED, XRUN, or
capture DRAINING) does not have an active master timer, so calling
snd_pcm_timer_notify(substream, SNDRV_TIMER_EVENT_MSTOP) delivers a
master-stop event with a zero or stale runtime->trigger_tstamp to attached
slave timers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109051618.2250=
6-1-mynameisjune111@gmail.com?part=3D4
