Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793146059;
	b=fbZnn/GF2uxFq3YJkX/Unw4CNw4X1lOZUUrgIgU4T6Lx98OVRecwiureuCFwitJt3a/h
	 8lae7daKquuqjUwFWkmWBc1IH1FvUsIxk0H5tjtITV1RI8huBsfkBvNindZcDBdSXPerm
	 k0UXfFaIDizgNnf4xnV01ThKjLWpaqMzt0ykuKVf3Ud8wJd3n/cojgtr7irhT7dTwKmSG
	 hVJpV3FLzhJRCHBvLR6BDxeCd3nCZjhC/WwhDLjioiFm/5fYEJhInOKQqvCKT6IpTdufp
	 WL6paxjBhMUcwiFh3XIL0XotvpSO6erk4jy5pc1iZ+mcwCUVF2zierNBaxAceWdOs6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793146059;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5+0z7+tuLGNS1NNGBwekclS0kOveSVj017dZVpDyfho=;
	b=mrV35RTh5PeqVUWjmt0PxZknyj1EcKpqiJGFwCQTDbxgQ8ltptN/gURxgqFcivtpwdjf
	 RV5oXEA4zqOzWgXhqGAGZbjM7d08FfOfWBeW2A7xEhdUwb4+UABwc7yXrUWNyGOzszPgB
	 h4xLtrNkTWtaZZbOMXs+lAsmr962Kyx9ehO1JD60UCh16pNGVCEs/R/Qpj7b6MwWwOsaj
	 +KM8KTeGXwragPXe3EeqPTOQwTpeog99KZ8XpPLce65Lm8GJ0RnlX90a8ff2PJu2Ofkxz
	 QaliFxMiZFLJXgHqC9rvCZaTdBAQcxx026M+Vm8zdm23IRlRwoU9uIVRfF5o/MGr6aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZP1W1c2a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007AA606A31A;
	Wed, 28 Oct 2026 00:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZP1W1c2a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291631F01825;
	Wed, 28 Oct 2026 00:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793146058;
	bh=5+0z7+tuLGNS1NNGBwekclS0kOveSVj017dZVpDyfho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZP1W1c2aAXbqw9e++/RNBsEaSooDKI++0OHOOoAP1GZd1DVc7d5j+4kOzVc4nMY3n
	 emlqdv5O2Wi/8TbzZsPZCWVs6Mtv56Bm+VUjeIi9aa2V0wgOW0DZ++NG6jRYwylbya
	 YSwqoI+u2NRty1kvdB02+Oo12aZXFm32/N6gfRPgQY6OY8AswPEBGqyyI1klYxogNg
	 Jik1jwIYPAh/qtZFQNhg/Ioe6xrB7uETAliUzCSQlZCNdwbU9+e+26LTtMKWyIgi5g
	 SSwZBoEWcgPslVzm5OK7IfEVhWyxVgH1iMH+fzYgyRBcHFzmxZ/MbnZ43xag86fedD
	 JRVPmtg560/7w==
Message-ID: <sashiko-outbox-187254@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/11] ALSA: virtio: wait through signals for PCM
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261027234334.32551-7-mynameisjune111@gmail.com>
References: <20261027234334.32551-1-mynameisjune111@gmail.com>
 <20261027234334.32551-7-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 00:07:37 +0000
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
- [High] ALSA: virtio: interruptible I/O flush wait in virtsnd_pcm_sync_sto=
p()
- [Medium] ALSA: virtio: interrupted PCM_START in virtsnd_ctl_msg_send() br=
eaks teardown
--

commit cb2fb94625971d45e77abbb9e6f9bcb8abb321ee
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: wait through signals for PCM teardown

This commit changes virtsnd_ctl_msg_send() to use an uninterruptible timeout
wait for VIRTIO_SND_R_PCM_STOP and VIRTIO_SND_R_PCM_RELEASE control request=
s so
that pending signals do not abort PCM teardown before completion.

> diff --git a/sound/virtio/virtio_ctl_msg.c b/sound/virtio/virtio_ctl_msg.c
> index 2e0ff15e729da..e50e6c7f3b8d1 100644
> --- a/sound/virtio/virtio_ctl_msg.c
> +++ b/sound/virtio/virtio_ctl_msg.c
> @@ -314,7 +314,20 @@ int virtsnd_ctl_msg_send(struct virtio_snd *snd, str=
uct virtio_snd_msg *msg,
>  		 */
>  		virtsnd_ctl_msg_unref(msg);
>  	} else if (!nowait) {
> -		rc =3D wait_for_completion_interruptible_timeout(&msg->notify, js);
> +		/*
> +		 * Teardown must observe completion even with a pending signal.
> +		 * Otherwise a subsequent open can retry RELEASE while the device
> +		 * is still processing the previous teardown request.
> +		 */
> +		switch (le32_to_cpu(request->code)) {
> +		case VIRTIO_SND_R_PCM_STOP:
> +		case VIRTIO_SND_R_PCM_RELEASE:
> +			rc =3D wait_for_completion_timeout(&msg->notify, js);
> +			break;

[Severity: High]
When a signal is pending during PCM teardown, virtsnd_ctl_msg_send() now
waits uninterruptibly for VIRTIO_SND_R_PCM_RELEASE to complete on the contr=
ol
virtqueue and returns 0 to virtsnd_pcm_sync_stop() with the signal still
pending on current.

However, right after virtsnd_ctl_msg_send_sync() returns in
sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_sync_stop(), the wait for pending
TX/RX I/O buffers to drain is still interruptible:

	rc =3D virtsnd_ctl_msg_send_sync(snd, msg);
	if (rc) {
		substream->runtime->stop_operating =3D true;
		return rc;
	}

	rc =3D wait_event_interruptible_timeout(vss->msg_empty,
					      !virtsnd_pcm_msg_pending_num(vss),
					      js);
	if (rc <=3D 0) {
		dev_warn(&snd->vdev->dev, "SID %u: failed to flush I/O queue\n",
			 vss->sid);
		substream->runtime->stop_operating =3D true;

		return !rc ? -ETIMEDOUT : rc;
	}

	scoped_guard(spinlock_irqsave, &vss->lock)
		vss->stopped =3D false;

Because TX/RX buffer completions arrive asynchronously on separate virtqueu=
es
(VIRTIO_SND_VQ_TX / VIRTIO_SND_VQ_RX), vss->msg_count can still be non-zero
when the control message completes. With the signal still pending on curren=
t,
wait_event_interruptible_timeout() immediately returns -ERESTARTSYS, leaving
vss->stopped =3D true and setting substream->runtime->stop_operating =3D tr=
ue.

In snd_pcm_release_substream(), do_hw_free() runs after snd_pcm_drop(), sees
runtime->stop_operating =3D=3D true, and calls virtsnd_pcm_sync_stop() a se=
cond
time (or a subsequent virtsnd_pcm_open() preserves vss->stopped via
vss->stopped |=3D !!vss->msg_count and calls virtsnd_pcm_sync_stop()). Both
paths see need_release =3D vss->stopped || vss->msg_count as true and send a
duplicate VIRTIO_SND_R_PCM_RELEASE while the first RELEASE is still flushing
I/O or after the stream is already released. In addition,
virtsnd_pcm_hw_free() skips virtsnd_pcm_msg_free(vss) while
virtsnd_pcm_msg_pending_num(vss) is non-zero, leaving vss->msgs and retained
vss->dma_pages (or vss->owned_dma_area on !CONFIG_MMU) allocated after clos=
e.

Should the vss->msg_empty wait in virtsnd_pcm_sync_stop() also use
wait_event_timeout() so that the entire RELEASE teardown completes through
pending signals?

> +		default:
> +			rc =3D wait_for_completion_interruptible_timeout(&msg->notify, js);
> +			break;
> +		}

[Severity: Medium]
What happens if a signal interrupts VIRTIO_SND_R_PCM_START in this default
branch after the request has already been queued to the control virtqueue?

In sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_trigger(), both
SNDRV_PCM_TRIGGER_START and SNDRV_PCM_TRIGGER_PAUSE_RELEASE send
VIRTIO_SND_R_PCM_START synchronously:

		rc =3D virtsnd_ctl_msg_send_sync(snd, msg);
		if (rc)
			virtsnd_pcm_start_failed(vss);

		return rc;

Notice that snd_pcm_drop() also triggers SNDRV_PCM_TRIGGER_PAUSE_RELEASE via
snd_pcm_pause(substream, false) during teardown when runtime->state is
SNDRV_PCM_STATE_PAUSED.

If a signal is pending or arrives while waiting for VIRTIO_SND_R_PCM_START,
virtsnd_ctl_msg_send_sync() returns -ERESTARTSYS while the device still
processes the queued VIRTIO_SND_R_PCM_START and transitions the stream to
STARTED. Meanwhile, virtsnd_pcm_start_failed() sets vss->stopped =3D true a=
nd
substream->runtime->stop_operating =3D true, and ALSA keeps runtime->state =
in
SNDRV_PCM_STATE_PREPARED or SNDRV_PCM_STATE_PAUSED:

1. For linked streams in snd_pcm_action_group(), ops->undo_action is only
   called on streams iterated before the failing stream, so
   SNDRV_PCM_TRIGGER_STOP is not sent for the interrupted stream. Subsequent
   snd_pcm_stop() sees snd_pcm_running(substream) =3D=3D false and skips
   SNDRV_PCM_TRIGGER_STOP, after which virtsnd_pcm_sync_stop() sees
   vss->stopped =3D=3D true and sends VIRTIO_SND_R_PCM_RELEASE while the de=
vice
   stream is still STARTED.

2. For unlinked streams where snd_pcm_undo_start() or snd_pcm_undo_pause()
   sends VIRTIO_SND_R_PCM_STOP, vss->stopped remains true while
   runtime->state stays PREPARED or PAUSED without snd_pcm_sync_stop()
   running, so a syscall restart or retry of START/PAUSE_RELEASE fails with
   -EBADFD in virtsnd_pcm_trigger(). In addition, when pause-restart mode is
   active (from commit "ALSA: virtio: stage VZ capture and restart paused
   streams"), an interrupted PAUSE_RELEASE during snd_pcm_drop() transitions
   vss->pause_restart_state to VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED,
   skipping STOP and RELEASE and wedging the substream.

Should VIRTIO_SND_R_PCM_START also wait uninterruptibly once queued so the
driver and device stream states stay synchronized?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027234334.3255=
1-1-mynameisjune111@gmail.com?part=3D6
