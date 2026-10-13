Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A0C378823
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791878688; cv=none; b=pvFshbSGWoANkgsB3vuDlZBa7mhZm6tSAFWKGO+0H7wSosLr9iLWn+yxnrcK8mW7vR8JzVplXd9V3pZZ9UJJVNJk9cTHvGmp+JZ2HL3r9jGhj4LejHQfOM9j7RK2Oqwt8bvqjDyOs/johF/e0B268rYkFzasSGBqaaIFxRO4Jb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791878688; c=relaxed/simple;
	bh=8alo1z2WqxXoprEqmgM7n8kTavZAoljzKQpk3YwunMI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=m3uGsueuFF7T+4rHNpVd/m41MC2L0oUU+f44FfVbmj1/xPTT1RFj+FpmVVydT46ssoErEVoIbd4bYb0TygpaQZXtzZM69aBoj0PSflf2ipNOrNXyqL5F0JaTxkW8pX01qE8J3Jlwhid0OpbfEeC+WWb8mE/2FPEWq/5/PJLDofE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NG8C7qt2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NG8C7qt2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42AB51F00893;
	Tue, 13 Oct 2026 08:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791878687;
	bh=iisMLJZwD7/8JsYSzX7UYkhZQo+eTXtRrUlZCSX37g8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NG8C7qt2aMxyYnK9hH1h+Cf5G52W7Fhva7GHr9wrl/a920x3eV2oDF34wO8zxB883
	 49HZ18rQ3/8vIzcMatbRgQNP9Z+dd0JZU7soPjW55pOIJ0Gsz+euN0XDcss2dp3gOi
	 vSKoX1PCyqagQ/O4N47ExUBLKy6x70aNZiPUIgnkJgLl7xnecLiQYD9mUnZoFy8XL6
	 Ma6eXGJG1hdYsrK4QxZCgQ7vCpLF1wwds5DYQi4wvbko3AULrvt87k/olhZxbsJiQ+
	 Z0O9IdtE6wDMccz6llB/Et5smIxqFjj/vemly5JuhOnPM8iLK0BuJZk4ejemVVhdTV
	 k1b3TDIi28fMw==
Message-ID: <sashiko-outbox-169220@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] ALSA: virtio: Recover PCM state after a failed
 start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <9b9b0698d28e1d2b6d3a94f62cfbd97a7e308854.1791877396.git.mynameisjune111@gmail.com>
References: <cover.1791877396.git.mynameisjune111@gmail.com>
 <9b9b0698d28e1d2b6d3a94f62cfbd97a7e308854.1791877396.git.mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 08:04:46 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] sound: virtio: Data race on vss->stopped due to missing ALSA str=
eam lock in prepare/hw_params
--

commit cf7b0007082a8c0e3a16320e4229781856250174
Author: Joonho Lee <mynameisjune111@gmail.com>
ALSA: virtio: Recover PCM state after a failed start

This commit modifies the capture trigger to disable transfers, mark the str=
eam
as stopped, and arm the stop operating flag if a PCM START fails. It also a=
dds
checks in the hw_params and prepare callbacks to reject retries if the stre=
am
is stopped, until a subsequent sync_stop resolves the state.

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index a40ea394bf174..fe8e0dc3eafca 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c
[ ... ]
> @@ -224,6 +233,12 @@ static int virtsnd_pcm_hw_params(struct snd_pcm_subs=
tream *substream,
>  			vss->sid);
>  		return -EBADFD;
>  	}
> +	if (vss->stopped) {

[Severity: Medium]
Is it safe to read vss->stopped locklessly here?

ALSA explicitly drops the stream lock (group->mutex) before invoking
virtsnd_pcm_hw_params(), virtsnd_pcm_prepare(), and hw_free() (which calls
virtsnd_pcm_sync_stop()).

Concurrently, ioctls like SNDRV_PCM_IOCTL_FORWARD (which invoke the ack
callback) acquire group->mutex but not buffer_mutex.

This means virtsnd_pcm_pb_ack() can execute concurrently with
virtsnd_pcm_hw_params() or virtsnd_pcm_prepare() on the same substream.

Since the ack path writes to vss->stopped under vss->lock, reading it here
without vss->lock could result in a data race. A torn read or compiler
reordering could result in an incorrect stream state being observed.

> +		dev_err(&vdev->dev, "SID %u: stream release failed\n",
> +			vss->sid);
> +		substream->runtime->stop_operating =3D true;
> +		return -EBADFD;
> +	}
> =20
>  	rc =3D virtsnd_pcm_dev_set_params(vss, params_buffer_bytes(hw_params),
[ ... ]
> @@ -274,6 +289,13 @@ static int virtsnd_pcm_prepare(struct snd_pcm_substr=
eam *substream)
>  	struct virtio_device *vdev =3D vss->snd->vdev;
>  	struct virtio_snd_msg *msg;
> =20
> +	if (vss->stopped) {

[Severity: Medium]
Similarly, vss->stopped is read locklessly here in virtsnd_pcm_prepare().
Could this also race with concurrent ack callbacks for the same reason?

This problem wasn't introduced by this patch, but vss->stopped is also
written locklessly at the end of virtsnd_pcm_sync_stop().

Since virtsnd_pcm_sync_stop() is called from hw_free where ALSA also drops
group->mutex, could that lockless write also race with concurrent ack
callbacks?

> +		dev_err(&vdev->dev, "SID %u: stream release failed\n",
> +			vss->sid);
> +		substream->runtime->stop_operating =3D true;
> +		return -EBADFD;
> +	}
> +
>  	if (!vss->suspended) {
>  		if (virtsnd_pcm_msg_pending_num(vss)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791877396.gi=
t.mynameisjune111@gmail.com?part=3D2
