Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452798;
	b=Skl/bYFAi67Mqm4qnM7jmV5F2pqlLJSmIvh3JKxCE6h6gCojEnbbmclK0zXjDq0wnj2u
	 pv3/+esUh6W779OPDTFbREG1gz0MsaBXDe2BAzqVsxDPXmToMfscCqDiE2L6Vx6SgrvPr
	 swE1MkRQdzrvB3H1q9XMNE8lSIGxBLqnX4CzKNwK45r42GVp/RhywFprWgwfg1trTORQq
	 mldCq10XqTSWhL1Vh5/qqgStOQNzTw1bSfniDtWsEZQZLNkvqqw6wAB2FDDBuKZCl/oOq
	 lEMXZlMayaOusxw/icSoB64HI+je1/Av9Y/Nyy4t5thhN4SCJW8qTtgXloX63XMxLUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452798;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7+snW9NxcFR8P3AytUk0UnbXWDoC/YHet90hY4qk0/o=;
	b=SNmZVWVlG/QREdt8alsDVMZTgKRpoSoW8ZTOwD5sX8WCM4mBxpiLB6NhteKLFQjzycPC
	 ktbD9DXxGnEm2NjmBcq31FEc2w9m6F6Lhvsx2q/7FuxGfp+ASs1SAi1zlXTKXSSNxqP6g
	 gzXA47VRTRJciSyIOMsLdB7B/l+tr5B/Xd2q527MFvi07Rk/99JvaRJzM5ol6sdAao3RB
	 lnoaShy3I2HytNsMEdSunFXWmwikriAUlPPr0hOzvMSsI7GtHAyqiUJmSrhKVZHHEerI/
	 r7mZVlGFmnz/T8I1pOTWIW9K3b0dbTT8RFuuuqj3VO/0GTyvUCC85JT6o64gZgyIhWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OTnSw0zm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A72606A31C;
	Thu, 12 Nov 2026 03:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OTnSw0zm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED301F00A05;
	Thu, 12 Nov 2026 03:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794452798;
	bh=7+snW9NxcFR8P3AytUk0UnbXWDoC/YHet90hY4qk0/o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OTnSw0zmjUqqCI37a/fT2F8fuMWXeWS9uWZVjVr+gMX2oKK9TTU3PC42QYDmwJuNP
	 1Xk1Sc1NT+MdkpxGlzC4hppKCJdRRgVJlLwzihjUFszxnwIPVM98s01DAE/+XBgxY5
	 4xjEeNeIK37XQqraq8uc7Jk92u9ZBbJDmqCxII2D7gsBAcLRf2KeHAB0uammmpvlaU
	 GP8j/ADj0xVEIaEAY8BIPF0opwJcB1ED6nCqUbBmM1ov86EKdBnS970SFPxi8bY/6h
	 eT0VUC0phKUsrnfB+lge1sFoh0Qw1jOl1KNfyOOXBlBWcCRwmEMyxvqfOaBf9iNjGD
	 +zKS3yw4mm26Q==
Message-ID: <sashiko-outbox-210240@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v27 12/17] ALSA: virtio: use request-owned capture and
 serialize recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112004704.49758-13-mynameisjune111@gmail.com>
References: <20261112004704.49758-1-mynameisjune111@gmail.com>
 <20261112004704.49758-13-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 03:06:37 +0000
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
- [Medium] ALSA: virtio: stale out-of-order capture msgs on reset and
  xrun
- [Medium] ALSA: virtio: unrestored capture state in
  virtsnd_pcm_trigger_inner()
--

commit ad4ce44873820d014515d7d58c0d615ba2bfd397
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: use request-owned capture and serialize recovery

This commit switches VirtIO sound capture to request-owned buffers that are
committed in submission order, and serializes PCM control state transitions,
preparation, and reset recovery.

> diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
> index a3e23fdbea149..f04e25c4cde77 100644
> --- a/sound/virtio/virtio_pcm_msg.c
> +++ b/sound/virtio/virtio_pcm_msg.c
[ ... ]
> @@ -473,6 +549,365 @@ int virtsnd_pcm_msg_send(struct virtio_pcm_substrea=
m *vss, unsigned long offset,
[ ... ]
> +static void virtsnd_pcm_capture_complete(struct virtio_pcm_msg *msg,
> +					 size_t written_bytes)
> +{
> +	struct virtio_pcm_substream *vss =3D msg->substream;
> +	struct snd_pcm_runtime *runtime;
> +	size_t audio_bytes =3D 0;
> +	u32 latency_bytes =3D 0;
> +	size_t frame_bytes;
> +	bool got_audio =3D false;
> +	bool accept_completion;
> +
> +	guard(spinlock)(&vss->lock);
> +	vss->msg_count--;
> +	accept_completion =3D vss->runtime_active && vss->prepared &&
> +		(!vss->stopped || vss->capture_stopping) && !vss->xfer_xrun;
> +	if (accept_completion) {
> +		runtime =3D vss->substream->runtime;
> +		if (runtime && runtime->dma_area) {
> +			frame_bytes =3D runtime->frame_bits /
> +				gcd(runtime->frame_bits, 8);
> +			msg->capture_valid =3D !virtsnd_pcm_capture_status(
> +				msg, written_bytes, frame_bytes, &audio_bytes,
> +				&latency_bytes);
> +			msg->capture_audio_bytes =3D audio_bytes;
> +			msg->capture_latency_bytes =3D latency_bytes;
> +			msg->capture_complete =3D true;
> +			got_audio =3D virtsnd_pcm_capture_commit_ready_locked(vss);
> +		} else {
> +			msg->length =3D 0;
> +			msg->capture_complete =3D false;
> +		}
> +	} else {
> +		msg->length =3D 0;
> +		msg->capture_complete =3D false;
> +	}

[Severity: Medium]
Can out-of-order RX completions leave stale buffered messages behind when
accept_completion is false or across virtsnd_pcm_reset()?

If request N+1 completes before request N, it is held in vss->msgs with
capture_complete set to true while waiting for capture_commit_sequence to
reach N+1.  If vss->xfer_xrun is then set (for example via
virtsnd_pcm_event() or virtsnd_pcm_cp_pointer()) before request N completes,
request N takes this else branch, which clears only request N without
advancing capture_commit_sequence or clearing request N+1.  Likewise,
virtsnd_pcm_reset() does not clear buffered capture_complete entries or
resynchronize capture_commit_sequence, so a reset while request N+1 is buff=
ered
will either commit pre-reset audio once request N completes or leave
capture_commit_sequence wedged at N.

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index a5a682534acf7..6d6c1bcd8601b 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c
[ ... ]
> @@ -325,182 +622,834 @@ static int virtsnd_pcm_hw_params(struct snd_pcm_s=
ubstream *substream,
[ ... ]
>  	case SNDRV_PCM_TRIGGER_STOP:
>  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>  		scoped_guard(spinlock_irqsave, &vss->lock) {
> +			if (!vss->prepared)
> +				return 0;
>  			if (command !=3D SNDRV_PCM_TRIGGER_PAUSE_PUSH)
>  				vss->stopped =3D true;
> +			if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE) {
> +				vss->capture_stopping =3D true;
> +				vss->capture_quiet_sequence =3D
> +					vss->capture_submit_sequence;
> +			}
>  			vss->xfer_enabled =3D false;
> +			if (!vss->device_running)
> +				return 0;
>  		}
> =20
> -		msg =3D virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_STOP,
> -						GFP_KERNEL);
> -		if (!msg)
> -			return -ENOMEM;
> +		rc =3D virtsnd_pcm_stop_device(vss, epoch);
> +		if (rc && command !=3D SNDRV_PCM_TRIGGER_PAUSE_PUSH) {
> +			guard(spinlock_irqsave)(&vss->lock);
> =20
> -		return virtsnd_ctl_msg_send_sync(snd, msg);
> +			if (vss->reset_epoch =3D=3D epoch && !vss->resetting) {
> +				vss->xfer_xrun =3D true;
> +				substream->runtime->stop_operating =3D true;
> +				if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE)
> +					virtsnd_pcm_schedule_period_elapsed(vss);
> +			}
> +		}
> +		if (rc && command =3D=3D SNDRV_PCM_TRIGGER_PAUSE_PUSH) {
> +			if (substream->runtime->state !=3D SNDRV_PCM_STATE_RUNNING) {
> +				/* Failed resume rollback must leave a paused queue closed. */
> +				virtsnd_pcm_trigger_failed(vss, epoch);
> +			} else if (virtsnd_pcm_start_queue(vss, epoch)) {
> +				virtsnd_pcm_trigger_failed(vss, epoch);
> +			} else if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE) {
> +				virtsnd_pcm_schedule_period_elapsed(vss);
> +			}
> +		}
> +		return rc;

[Severity: Medium]
Does a failed SNDRV_PCM_TRIGGER_PAUSE_PUSH leave vss->capture_stopping set
and vss->capture_quiet_sequence advanced when rolling back a running capture
stream?

When virtsnd_pcm_stop_device() fails on a running capture substream, the
rollback path reopens the queue via virtsnd_pcm_start_queue(), but neither
that helper nor this branch restores capture_stopping or
capture_quiet_sequence.  All in-flight RX requests queued before the failed
pause then have capture_sequence < capture_quiet_sequence and bypass the
empty-completion XRUN checks in virtsnd_pcm_capture_commit_one_locked() even
though the stream is still running.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112004704.4975=
8-1-mynameisjune111@gmail.com?part=3D12
