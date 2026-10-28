Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793146200;
	b=TeVYBqwWdW+zSqjO+HtMeyLdai3rGm8r6L6LBU8zmmlo0gTg6ILfkcKqRfK8NDpXWBL3
	 HVMbOwo7Hk4cy+JEaGhrVytJxSvlSIVFTLNjOj3bRZe9yr4kzSmALzLJnIHvHI7eHRRbT
	 Bbvoa7/3dGerUOVmyjQNZwFjXF1HcIOvyrmbRJ2QfwDzhM5vcz4/w4CvShfsL7FWUT8st
	 KaS9YrrDFVrYOXhwKnRdWL1uSx7e7xwuNXOTlji8We9ZyKTMRyd6OuK58Nb6D5SXCUrpz
	 AUW0JFH07HAj8Kc/l9oUeaep6oIYIHFeibS9MMbnb663tqeBZciToO/aObo5jkyYQjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793146200;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qNuLg4JO8zPZRfc9tHra3qyiBVrJiE+hOkqkbJCBA0o=;
	b=swGA8vdHPxjGxIhm+6BdgZkdYSG6i7KzLEJ0OMA2vxp9mpQ3XSFgC0u2UXIbcRqinmQ2
	 DM+iTTcPXHO9zfJEruCwNGA+AsW9/ks7KCz9E/YSMPhdSGTXOPfUMdXbcy4wILLvNW/vz
	 hX98sBGFM+TwgyimhH5nNlDMCA/JXNSZVi+yexvtJFtcSZ4027TlqAUK44baX2kfPgvKd
	 VGj740VwwVK0gtn7GDQlpOcR9TO4RZRsgs5b6sCwgDzVaM5RoOYhEYoBRxV5mMcLecINu
	 m6HdgUT7M0yWWVFDsx6WUvAcR8MQ7kJrjauqAEwp06jst8o2NfW+MLk+h7+vjo3XtNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QLw1dXYD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718F7606A31A;
	Wed, 28 Oct 2026 00:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QLw1dXYD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B2E1F01825;
	Wed, 28 Oct 2026 00:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793146200;
	bh=qNuLg4JO8zPZRfc9tHra3qyiBVrJiE+hOkqkbJCBA0o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QLw1dXYDgOgQA0vpa13o1Kh4MpfpWNK/XkIob5glwhn++9giuXFWJrBGG6YUqy+jN
	 DoH3uOYvvtw6Qk6YtBJOriggfyr1i5E9TyzuC8g0iMa41HZfbv3pl3sszPPKjK/JRY
	 TPnTheH74/nmLOBRgas/T7IuxdzmPeJNpW3bK5y1Sl5jtDqTyqd8K5IqCi31DPoO/O
	 A90niNcMbSwwpMyAFCybIJYspFPQQU9MtOOT1WgXoKZ5AEPlgAXfcMkKnykjLCRrK6
	 l9UUqp/1wVZ7C+4FS9WF7sJ2gOdzYr02EbeCDr4H+kDRVQp6szR/OZaRAFOHCbhXoS
	 v8F0ekjCtmH4Q==
Message-ID: <sashiko-outbox-187258@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/11] ALSA: virtio: Propagate PCM send failures
 through ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261027234334.32551-2-mynameisjune111@gmail.com>
References: <20261027234334.32551-1-mynameisjune111@gmail.com>
 <20261027234334.32551-2-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 00:09:59 +0000
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
- [High] ALSA: virtio: virtsnd_pcm_cp_ack() fails with -EPIPE during captur=
e drain
--

commit 7b35fc6d816e5d3f7f39daa43f235ee425fb93dd
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: Propagate PCM send failures through ACK

This commit updates virtsnd_pcm_msg_send() to roll back the message length
and notify the virtqueue for previously queued messages if adding a scatter=
list
fails. It also propagates transfer errors through the playback and capture
ack callbacks, marking the stream stopped and returning an xrun error on
failure.

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index 1091100a4c982..a40ea394bf174 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c

[ ... ]

> @@ -466,36 +466,100 @@ virtsnd_pcm_cp_pointer(struct snd_pcm_substream *s=
ubstream)
>  static int virtsnd_pcm_cp_ack(struct snd_pcm_substream *substream)
>  {
>  	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
>  	struct virtio_snd_queue *queue =3D virtsnd_pcm_queue(vss);
> +	struct virtsnd_pcm_transfer transfer =3D {};
> +	int rc;
> =20
> -	guard(spinlock_irqsave)(&queue->lock);
> -	guard(spinlock)(&vss->lock);
> +	scoped_guard(spinlock_irqsave, &queue->lock) {
> +		guard(spinlock)(&vss->lock);
> +		transfer.indirect =3D vss->pcm_indirect;
> +		if (vss->stopped) {
> +			rc =3D -EPIPE;
> +		} else {
> +			rc =3D snd_pcm_indirect_capture_transfer(substream,
> +							       &transfer.indirect,
> +							       virtsnd_pcm_trans_copy);
> +		}

[Severity: High]
Does checking vss->stopped here break capture stream draining?

When userspace drains a running capture substream that still has unread
frames in the ring buffer, snd_pcm_do_drain_init() stops the hardware stream
and places the substream into the draining state so userspace can read the
remaining captured data:

sound/core/pcm_native.c:snd_pcm_do_drain_init() {
	...
		if (runtime->state =3D=3D SNDRV_PCM_STATE_RUNNING) {
			snd_pcm_state_t new_state;

			new_state =3D snd_pcm_capture_avail(runtime) > 0 ?
				SNDRV_PCM_STATE_DRAINING : SNDRV_PCM_STATE_SETUP;
			snd_pcm_do_stop(substream, new_state);
			snd_pcm_post_stop(substream, new_state);
		}
}

snd_pcm_do_stop() invokes virtsnd_pcm_trigger(), which sets vss->stopped:

sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_trigger() {
	...
	case SNDRV_PCM_TRIGGER_STOP:
		vss->stopped =3D true;
		fallthrough;
}

When userspace subsequently reads those remaining buffered frames via
__snd_pcm_lib_xfer(), advances appl_ptr via snd_pcm_forward(), or synchroni=
zes
via snd_pcm_sync_ptr(), pcm_lib_apply_appl_ptr() invokes substream->ops->ac=
k():

sound/core/pcm_lib.c:pcm_lib_apply_appl_ptr() {
	...
	runtime->control->appl_ptr =3D appl_ptr;
	if (substream->ops->ack) {
		ret =3D substream->ops->ack(substream);
		if (ret < 0) {
			runtime->control->appl_ptr =3D old_appl_ptr;
			if (ret =3D=3D -EPIPE)
				__snd_pcm_xrun(substream);
			return ret;
		}
	}
}

Because vss->stopped is already true during capture drain, virtsnd_pcm_cp_a=
ck()
will unconditionally fail and return -EPIPE, causing pcm_lib_apply_appl_ptr=
()
to revert appl_ptr, trigger __snd_pcm_xrun(), and prevent userspace from
reading the remaining captured frames.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027234334.3255=
1-1-mynameisjune111@gmail.com?part=3D1
