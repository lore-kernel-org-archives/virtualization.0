Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794063991;
	b=rqG4z7WxYC6+u63r8X8wRjSHngIw2bzdV9vOaRqReA/tQNjIETXwztKoBPcW5oH8WLrw
	 uqWv/LCymckvRITukkrDYq0dM2OcaMgPCpxtkZn9GnSoeP59/RJHeQELWF4M+Kd/y1+HE
	 suzJyGbNtQjintBWEVB+ylHxxY5/tpAHrLTyRrXqaNhKUQZza7cbM9VvvyGhSkoWYVc2a
	 B+OHbAI3kXdvUCVmS7aTIyFp4RuxLtKNqLGODSUykR+b0GtNCFYF4iGAw2LkvGn3BlzsW
	 G8BUzAqk9Oaaur2hNec5pQEyamLVRmGtx9C1GrBdDRb/u4lOj0EMyJ1+V7ovWpFRL2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794063991;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=S6rgvauFLgJBzSdV2YJnEPa/AayMQKK/oQ9Lr7nShFs=;
	b=HLBjC0wQBgdXhjQR+w2NxOMj/RuZFZKT8udz/hdev8ZaHXCD3heympnRFYQf0AUm25P0
	 EoqRLu6rFao7PNSAqB6ZrUbZK8RvPMRZnniOFCxOZK7TOGDC3L6NcHSgI32TLiujLtbEl
	 i8DcczovZmUSD3+O02AOvQG9BYaHwa18erPo47BHVQ0XJFWH1Rbfg2T8u4cysZMWVDmDD
	 7/J+cBagDWb+/gCSl4rjjqmPQNobKPoo3++1xXjbir2EDTPHEHomsKVza5obpU3q0t8mL
	 2MqExzCJG/7LASnk3OANNZEGACjuLmelLVjJ4ZLmkM49kCzvV4B8vE9KL4h7YPoNPhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="g5/FQMfh";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C782B60A2610
	for <virtualization@lists.linux.dev>; Sat,  7 Nov 2026 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g5/FQMfh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E621F008A5;
	Sat,  7 Nov 2026 15:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794063990;
	bh=S6rgvauFLgJBzSdV2YJnEPa/AayMQKK/oQ9Lr7nShFs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g5/FQMfhN7K/O405eWPdxy5wssSs06ab2MDaga4T7qhcxbHr3ew3pwCUvYpkfscSi
	 fHx1fl31jbCSVt19O66MjKuNq61zJO2i2GLfawLsDSUj6qs6Gc8+vmqyolEwiHJjCn
	 ne89xYt94tN8k7id5eTszHq9Z00ofz2htzgNqFep2awybT0PNPKeyCWo5shNLchXvg
	 SHYqIvgp+mrirvrwN/Zq7o2x+yxV8+z0Ht3dgq6euClDr+eb5KmhfLMILv19/bwZJe
	 g8IqDkFS6wndsVE7Yt6k2Vk32LrEFk2XKQRcdwW/ix06lz0DVcfNc+wg7XyYYygmbr
	 QVezmo4MrUlDQ==
Message-ID: <sashiko-outbox-202982@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 04/12] ALSA: virtio: Propagate PCM send failures
 through ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261107143422.29319-5-mynameisjune111@gmail.com>
References: <20261107143422.29319-1-mynameisjune111@gmail.com>
 <20261107143422.29319-5-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 15:06:29 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> virtsnd_pcm_msg_send() can fail while queueing a transfer. Restore the
> failed message's length and notify the device about earlier messages
> queued by the same call, so they do not remain stranded.
>=20
> Propagate errors through the indirect transfer callback and commit its
> private cursor only after successful submission. Genuine transfer errors
> arm stop_operating and return -EPIPE so ALSA can retire the stream.
>=20
> Close ACK admission under the PCM stream lock before sleeping teardown.
> Keep the prepared state protected by the substream lock and reject ACK
> through prepare and parameter changes. Reopen admission in the reset
> callback while the core holds the PCM lock for its pointer rebase. An
> ACK racing with teardown returns -EBADFD and preserves stop state.
>=20
> Keep the polling feature path unchanged.
>=20
> Fixes: fe981e67568c ("ALSA: virtio: use ack callback")
>=20
> Reject a stopped playback ACK before the XRUN path can rearm
> stop_operating. For capture, allow the ordinary stopped tail only during
> DRAINING and only while no transfer XRUN is latched.
>=20
> Latch a transfer failure before stopping PCM work. Once core reports the =
member XRUN, ACK returns -EBADFD to avoid another linked XRUN. ACK during p=
repare remains rejected until the core state reaches PREPARED.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107143422.2931=
9-1-mynameisjune111@gmail.com?part=3D4

