Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119923A7F6B
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 05:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791870032; cv=none; b=RHtF/veAs8Q1eOdWC6EmvxSAaWL10XY8jTiFCB6w0m8I/KrKhgU1aBlX5GeBepaEneu1unpQWV+3TlDpwsTIqv2xH6Qdy5apvebpZw6iK2Cip6CQC0+e1skgu6Z6mrdeW9PwaR30VSMaxUnQuRvkyRiGBNYssPuMiH1rWBHvjbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791870032; c=relaxed/simple;
	bh=t+rk7iidj/uqxq0Z8qxPX+xx4Fn5XoWQbNyR03M21dc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=NPt6wtdOuLsbgmnXkP84gG3WXeQIA/apKGFTdilL7T3XbQfOZ0mKOhDXv0bbpbvjasGU6m3N/H7RJUCIlomn23A0g/Ll0/9mHhRSaZDQcAZ/ip64Eoo0bD/FYGH5wqX8G5/9j1QkirH/nipe/ZNi4y21QWkdjJ48z2BmL3kRtEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIuhHVq8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIuhHVq8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0721F00893;
	Tue, 13 Oct 2026 05:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791870030;
	bh=rMv+9XjKXoWaIJo/T5pCI4pv9UeinS9Hqap/HtVo570=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cIuhHVq8yRkkMcRIONaN2gH9Ml3HMuWl54InzWFU0egw/MR2pXMSekYcJWthzTKGT
	 pJgJBf9OxKi1x16rlhS4bP7DI5SrHP6WZyes2sikzXGNJS4owInWP7y4YdFNYtGrdN
	 uKivaowgSCesW+Xui3xotd9U6PGpEoNeLpaoUK9TUZcTPEo19eFv85lLGfa2HtcP4L
	 WVS0Uh6hhU8kQ2IJDmrZYmpRw19ijcO5a2249DB57k1weHmpWPcqZkgj+FZTNZSy2i
	 QbRyDXxq/NfxZrZVSbV3Eqn0yMgFz0tvwjcLOCexSr9H91NLeLe2dsTFHnuLWLKsMH
	 kco8lzQqC/QOw==
Message-ID: <sashiko-outbox-169002@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/5] ALSA: virtio: Notify queued PCM messages after
 send errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <01fd635f9ccd48594864e6e3858389060cdf2aa2.1791867377.git.mynameisjune111@gmail.com>
References: <cover.1791867377.git.mynameisjune111@gmail.com>
 <01fd635f9ccd48594864e6e3858389060cdf2aa2.1791867377.git.mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 05:40:29 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] alsa: virtio: state desync on msg send failure
--

commit e0fc1ff7e6c503fbe54480dc784a6aac80eec85b
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: Notify queued PCM messages after send errors

virtsnd_pcm_msg_send() advances a message length before adding it to
the virtqueue. If a later add fails, the error path returns without
restoring that length or notifying the device about earlier messages
added by the same call. The device can therefore leave successfully
queued messages unprocessed, while the failed message appears
already submitted.

> diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
> index 72103f6067169..5371f4985fd06 100644
> --- a/sound/virtio/virtio_pcm_msg.c
> +++ b/sound/virtio/virtio_pcm_msg.c
> @@ -260,6 +260,18 @@ int virtsnd_pcm_msg_send(struct virtio_pcm_substream=
 *vss, unsigned long offset,
>  				dev_err(&vdev->dev,
>  					"SID %u: failed to send I/O message\n",
>  					vss->sid);
> +				msg->length -=3D n;

[Severity: High]
Does this length rollback desynchronize the virtio message state from the A=
LSA
indirect layer?

When virtsnd_pcm_msg_send() fails and returns an error, its caller,
virtsnd_pcm_trans_copy(), ignores the return value:

sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_trans_copy() {
	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);

	virtsnd_pcm_msg_send(vss, rec->sw_data, bytes);
}

Because virtsnd_pcm_trans_copy() returns void, the ALSA indirect layer=20
(snd_pcm_indirect_playback_transfer()) assumes success and unconditionally=
=20
advances its software offset pointers.=20

Since the ALSA pointer advanced but the virtio message length rolled back, =
the
two states become out of sync. On the next wrap-around, will the skipped
message artificially reach period_bytes with old/new mixed data and be
submitted to the virtqueue out of order?

Should the driver set substream->runtime->stop_operating =3D true inside
virtsnd_pcm_msg_send() to properly abort the stream when an I/O message
fails?

> +
> +				/*
> +				 * Do not leave earlier messages queued without notifying
> +				 * the device when a later message could not be added.
> +				 */
> +				if (msg_count !=3D vss->msg_count &&
> +				    !(vss->features &
> +				      (1U << VIRTIO_SND_PCM_F_MSG_POLLING)) &&
> +				    virtqueue_kick_prepare(vqueue))
> +					virtqueue_notify(vqueue);
> +
>  				return rc;
>  			}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791867377.gi=
t.mynameisjune111@gmail.com?part=3D1
