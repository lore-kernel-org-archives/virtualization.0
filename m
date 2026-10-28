Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793146737;
	b=4Py0l1y5mTTcQqQCyOT4EAGvfEzAdN/SSl46yec/t57c83wnxszPu6TMf543EJGGer5q
	 39YQXnH7Tb/CNP4pmqaV/Z+UB7YIqd7qfJR4/u2t7/TA4qS6vahWMFGJB6xVd4SYejeXV
	 R6blNy/Q9yCxtrLGxqTH5S/qqpFvXu1Xu+MfAv0/VYm9VXEIgAOHhdaXQ7Elfks3QkH/J
	 j6/HKCSiph01XgoYfKhY9N60I/RC6a+R70oJuc8YCQJaR3ge524T5nW9VKAug3yipMetR
	 PajlFNIk7BP4QRzM3+6SngsuZ9yMyJ07hliiuYRLokdvKmV8ylbudIJB/rL+24Nmvvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793146737;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gRDXKUR7RYJdyrY6zTfqQofnSGgsZJItZHXFUbSI4iU=;
	b=r6SFRoSAHDotjdWZQxwUcfTDiGv+fI3dEwjBAHBCsv4cOiwSJ0DbuAyMz7Uuh5K+po+Z
	 qpG38PdgSlV89TmSav9n9aoozCONMrCo0PcwaPlsGQY3FbTwTq08N1YEYf5O+kTEGGh7/
	 ik7mBF+8WvP4b643vtcSLrGkzQT7SIwPlYrfBcg4oshGfT1NLye2eRjRAHh91mDWO6VW4
	 KdooEYPnHv0sVq5oAU+8x6c4lKU6WLAY0v5IiVudk62s1HZnJJb0ddhO/bbuDy3HJyxT6
	 IbmCmDopKDIYkTBuW6a/iwbNa950TrlbDe9O0GngtpHlm0amlKSPZvrQKJiwHFMSl6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NebReR5A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3B7606A31A;
	Wed, 28 Oct 2026 00:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NebReR5A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20691F01825;
	Wed, 28 Oct 2026 00:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793146737;
	bh=gRDXKUR7RYJdyrY6zTfqQofnSGgsZJItZHXFUbSI4iU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NebReR5AlngZni6kpKup1Go8LGRe2r//REosjWRuPnGRSk+X/a4P19K+67KSIRtDr
	 tBHaUhFLTlqPRHHHxnZ+h2+UvBtKLO3eOwVlqq+sqvkG0MOa/ZdUDlTgcz08v+PPQB
	 KYO+ckuFzMVUMwuwBu3sER7+CLN3Ra/cx8Ad3kX002x2Xs9qVgB2Fx2IOksNf21gj/
	 ZMY/vtUP8DcvUhkF5XqDHXIQtZwNuMSMkVfmFaiftj6sZyoxxTCd2WlEeaAzFartjF
	 prh1SybSMzpiXwHrFl3K9uaK/5t+haSKgjwOtULOe0gg1k/dFn6VhntQe01s8OY95R
	 qaTi7pia84lyA==
Message-ID: <sashiko-outbox-187268@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/11] ALSA: virtio: Recover PCM state after a failed
 start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261027234334.32551-3-mynameisjune111@gmail.com>
References: <20261027234334.32551-1-mynameisjune111@gmail.com>
 <20261027234334.32551-3-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 00:18:56 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] ALSA: virtio: unrecoverable stream state after failed suspend sync=
_stop()
- [Medium] ALSA: virtio: unprepared stream left startable if virtsnd_pcm_pr=
epare() fails
--

commit ff74351afcffdc15b798435ae2935317313176c5
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: Recover PCM state after a failed start

This commit recovers virtio PCM substream state when a start trigger fails =
by
disabling transfers, marking the stream as stopped under vss->lock, and
arming runtime->stop_operating so virtsnd_pcm_sync_stop() releases pending
I/O before subsequent prepare, hw_params, or start operations.

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index a40ea394bf174..970499fe419b4 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c

[ ... ]

> @@ -115,7 +124,8 @@ static int virtsnd_pcm_open(struct snd_pcm_substream =
*substream)
>  	snd_pcm_hw_constraint_integer(substream->runtime,
>  				      SNDRV_PCM_HW_PARAM_PERIODS);
> =20
> -	vss->stopped =3D !!virtsnd_pcm_msg_pending_num(vss);
> +	scoped_guard(spinlock_irqsave, &vss->lock)
> +		vss->stopped |=3D !!vss->msg_count;
>  	vss->suspended =3D false;
> =20
>  	/*

[ ... ]

> @@ -273,6 +295,16 @@ static int virtsnd_pcm_prepare(struct snd_pcm_substr=
eam *substream)
>  	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
>  	struct virtio_device *vdev =3D vss->snd->vdev;
>  	struct virtio_snd_msg *msg;
> +	bool stopped;
> +
> +	scoped_guard(spinlock_irqsave, &vss->lock)
> +		stopped =3D vss->stopped;
> +	if (stopped) {
> +		dev_err(&vdev->dev, "SID %u: stream release failed\n",
> +			vss->sid);
> +		substream->runtime->stop_operating =3D true;
> +		return -EBADFD;
> +	}
> =20
>  	if (!vss->suspended) {
>  		if (virtsnd_pcm_msg_pending_num(vss)) {

[Severity: High]
Can a failed virtsnd_pcm_sync_stop() during system suspend leave the PCM
substream in a permanently unrecoverable state after resume?

During system suspend, do_pcm_suspend() -> snd_pcm_suspend_all() runs:

  snd_pcm_do_suspend()
    virtsnd_pcm_trigger(substream, SNDRV_PCM_TRIGGER_SUSPEND)
      vss->suspended =3D true;
      vss->stopped =3D true;
  snd_pcm_sync_stop(substream, false)
    virtsnd_pcm_sync_stop(substream)

and ignores the return value of snd_pcm_sync_stop(). In
virtsnd_pcm_sync_stop(), allocating or sending VIRTIO_SND_R_PCM_RELEASE or
waiting in wait_event_interruptible_timeout() for vss->msg_empty can fail or
be interrupted (for example, returning -ERESTARTSYS when a signal or the
freezer is pending, or -ETIMEDOUT while vss->msg_count > 0). With this
change, virtsnd_pcm_sync_stop() leaves vss->stopped =3D true and re-arms
substream->runtime->stop_operating =3D true.

Subsequently, virtsnd_freeze() resets the device and deletes the virtqueues
without clearing vss->stopped or vss->msg_count:

  virtsnd_freeze()
    virtio_reset_device(vdev);
    vdev->config->del_vqs(vdev);

which returns all device-side streams to their initial unconfigured state.

Previously, post-resume snd_pcm_prepare() could recover because
runtime->stop_operating had been cleared by snd_pcm_sync_stop(),
virtsnd_pcm_prepare() did not check vss->stopped, and the vss->suspended
branch skipped the pending-message check, re-sent
VIRTIO_SND_R_PCM_SET_PARAMS to the reset device, and reset
vss->msg_count =3D 0.

With this patch, when userspace calls snd_pcm_prepare() after resume:

1. Because runtime->stop_operating was re-armed, snd_pcm_do_prepare() calls
   virtsnd_pcm_sync_stop() first. Seeing vss->stopped =3D=3D true,
   virtsnd_pcm_sync_stop() sends VIRTIO_SND_R_PCM_RELEASE to a freshly rese=
t,
   unconfigured stream before VIRTIO_SND_R_PCM_SET_PARAMS has been sent, and
   waits on vss->msg_empty for a stale vss->msg_count on the recreated empty
   virtqueue, timing out with -ETIMEDOUT.
2. Even if virtsnd_pcm_prepare() is reached, checking if (stopped) before
   if (!vss->suspended) returns -EBADFD immediately and makes the
   vss->suspended recovery path unreachable.
3. Reconfiguring via virtsnd_pcm_hw_params() is also rejected by the new
   stopped and msg_count checks, and closing and reopening the substream via
   virtsnd_pcm_open() preserves the stale vss->stopped =3D true (due to
   vss->stopped |=3D !!vss->msg_count), clears vss->suspended =3D false, and
   calls virtsnd_pcm_sync_stop() again.

Later commits in this series ("ALSA: virtio: Retain queued messages through
device reset" and "ALSA: virtio: wait through signals for PCM teardown")
detach unused buffers in virtsnd_freeze() and make the control message wait
non-interruptible, but wait_event_interruptible_timeout() in
virtsnd_pcm_sync_stop() remains interruptible and virtsnd_freeze() still do=
es
not clear vss->stopped when virtio_reset_device() resets the device-side
stream state. If virtsnd_pcm_sync_stop() fails during suspend, post-resume
sync_stop() will still send VIRTIO_SND_R_PCM_RELEASE to an unconfigured
stream before SET_PARAMS and block prepare(), hw_params(), and open() if the
reset device rejects RELEASE in its initial state.

[ ... ]

> @@ -393,21 +434,31 @@ static int virtsnd_pcm_sync_stop(struct snd_pcm_sub=
stream *substream)
>  	struct virtio_snd *snd =3D vss->snd;
>  	struct virtio_snd_msg *msg;
>  	unsigned int js =3D msecs_to_jiffies(virtsnd_msg_timeout_ms);
> +	bool need_release;
>  	int rc;
> =20
> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		vss->xfer_enabled =3D false;
> +		need_release =3D vss->stopped || vss->msg_count;
> +		if (need_release)
> +			vss->stopped =3D true;
> +	}
>  	cancel_work_sync(&vss->elapsed_period);
> -
> -	if (!vss->stopped)
> +	if (!need_release)
>  		return 0;
> =20
>  	msg =3D virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_RELEASE,
>  					GFP_KERNEL);
> -	if (!msg)
> +	if (!msg) {
> +		substream->runtime->stop_operating =3D true;
>  		return -ENOMEM;
> +	}
> =20
>  	rc =3D virtsnd_ctl_msg_send_sync(snd, msg);
> -	if (rc)
> +	if (rc) {
> +		substream->runtime->stop_operating =3D true;
>  		return rc;
> +	}
> =20
>  	/*
>  	 * The spec states that upon receipt of the RELEASE command "the device
> @@ -421,11 +472,13 @@ static int virtsnd_pcm_sync_stop(struct snd_pcm_sub=
stream *substream)
>  	if (rc <=3D 0) {
>  		dev_warn(&snd->vdev->dev, "SID %u: failed to flush I/O queue\n",
>  			 vss->sid);
> +		substream->runtime->stop_operating =3D true;
> =20
>  		return !rc ? -ETIMEDOUT : rc;
>  	}
> =20
> -	vss->stopped =3D false;
> +	scoped_guard(spinlock_irqsave, &vss->lock)
> +		vss->stopped =3D false;
> =20
>  	return 0;
>  }

[Severity: Medium]
What happens if virtsnd_pcm_sync_stop() succeeds after a failed start, but
the subsequent VIRTIO_SND_R_PCM_PREPARE command in virtsnd_pcm_prepare()
fails?

In sound/core/pcm_native.c:snd_pcm_do_start():

	err =3D substream->ops->trigger(substream, SNDRV_PCM_TRIGGER_START);
	/* XRUN happened during the start */
	if (err =3D=3D -EPIPE)
		__snd_pcm_set_state(substream->runtime, SNDRV_PCM_STATE_XRUN);
	return err;

When virtsnd_pcm_trigger(SNDRV_PCM_TRIGGER_START) fails with an error other
than -EPIPE (such as -ENOMEM from virtsnd_pcm_ctl_msg_alloc(), or an error
from virtsnd_pcm_msg_send() or virtsnd_ctl_msg_send_sync()),
substream->runtime->state remains SNDRV_PCM_STATE_PREPARED while
virtsnd_pcm_start_failed() sets vss->stopped =3D true and
runtime->stop_operating =3D true.

When userspace then calls snd_pcm_prepare() to recover:

1. snd_pcm_do_prepare() calls snd_pcm_sync_stop(substream, true), which
   clears runtime->stop_operating =3D false and runs virtsnd_pcm_sync_stop(=
).
2. virtsnd_pcm_sync_stop() sends VIRTIO_SND_R_PCM_RELEASE to the device
   (moving the device stream out of the prepared state into the released
   state), waits for queued messages to drain, and clears
   vss->stopped =3D false.
3. snd_pcm_do_prepare() then calls virtsnd_pcm_prepare(), which allocates a=
nd
   sends VIRTIO_SND_R_PCM_PREPARE:

	msg =3D virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_PREPARE,
					GFP_KERNEL);
	if (!msg)
		return -ENOMEM;

	return virtsnd_ctl_msg_send_sync(vss->snd, msg);

If allocating or sending VIRTIO_SND_R_PCM_PREPARE fails here,
snd_pcm_do_prepare() returns the error without changing
substream->runtime->state. At that point, the device stream is in the
released (unprepared) state, but substream->runtime->state is still
SNDRV_PCM_STATE_PREPARED, runtime->stop_operating is false, and vss->stopped
is false.

Wouldn't a subsequent SNDRV_PCM_IOCTL_START, write(), or
SNDRV_PCM_IOCTL_SYNC_PTR bypass both ALSA's state check and the vss->stopped
check in virtsnd_pcm_trigger(), queueing I/O messages and sending
VIRTIO_SND_R_PCM_START to an unprepared device stream?

Note that a later commit in this series ("ALSA: virtio: stage VZ capture and
restart paused streams") handles virtsnd_pcm_dev_prepare() failure when
pause_restart is true, but leaves the standard (!pause_restart) path
unhandled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027234334.3255=
1-1-mynameisjune111@gmail.com?part=3D2
