Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793864254;
	b=fVKCrdPQcaZ2X732kqw5b5+zY1eB7hmt4/viKkZPWmVLXSrNHZnC0LO+p7ZJjCVeyLW1
	 3FVGmkdBf/TUYXLo/GL/chCjl7Ly4SdxE/W6Bx21NzVNMmaI8aZkQLi8PYT+ri2Bvv7fb
	 nx2rWumw+NwldpR4KQG3ThbgcEE4bSphvgkvLZNXXHEmDCrKQHfYuIkmNEqHi4XCKz7n7
	 LG4RNiFdGrEdhPhZH+gFmQ/7XPkBFaHX5S5OHv9XbgBZjRsjnuSyXmK9b4W+7sXOZUVZL
	 ped83W7OT5bxOt8aiSwAU7K1/0uMsKhEMRYcg4OmxyLSVSOXK1GCP/T3PUSPDAO3YtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793864254;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WNSsssoQFEmsu4/0NtVgLy+eZqns9NoCCQFOOdBfcDY=;
	b=dlq95rrS7peN/aNyVDUft79A05wD67RtZXa9eU3uDTb8UEmou/VLEuY8J84zpU1CfSLg
	 MUU4qx8EXfQQHyBU/pt1A1vKyUR2egJGakNAk/rF4/gvwywAWcUc/lPljZhE+HVTr635w
	 SAgqn/T32NUjLf127vhkxXJLr+5v59Dy7jEV91lk/CsMd77BHrzw4YUeBrO/GTNGXXb2y
	 vtFL11Qq5d56DY+IIwKVxmEvpESgmZyPxfkuazZ1dA/p0PQ+PtMyypo4SIrbcqH+dTwuZ
	 cZtDSluq3/6fSUc0S6ftzmWYYtWIdsZuo6N8aqJRU5XWjOi7DUzXUn+fUj7AkI3s5ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o3ri+14u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9F3606A326
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 07:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o3ri+14u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF901F00919;
	Thu,  5 Nov 2026 07:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793864253;
	bh=WNSsssoQFEmsu4/0NtVgLy+eZqns9NoCCQFOOdBfcDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=o3ri+14utwTenNNMlwjHiujeGKhCGBGNoSe5Lv/jGM5SK2l/tmpq6SKHGNLUj2Ist
	 KWP7Yw+BQwmuFuewx1oj5SZft3rSfi/F9YHcKjkcCkoru1pppkVK0ZDxC9gw6DR3S9
	 isIXqu67eT2WNoC9+KwAreniKpE1MiudYe1B3+M2KKkKRhQqZLXaPtQTmfrlsAfvhX
	 ORQv6Ax3YzbE6ETWvN758rMv1Z42fXPwVCVB63ScBIsD/ZsPGOcQYCm7ppeEPlWxG8
	 vkU7vTo6ic0V/HAJXr8qHJ9BjE0bT7sWrp4hfnBoXR1NmUSeZtpN9WTVxBuSt79ryx
	 ZjhOIS2vdW80g==
Message-ID: <sashiko-outbox-198685@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 04/12] ALSA: virtio: Propagate PCM send failures
 through ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105070845.6449-5-mynameisjune111@gmail.com>
References: <20261105070845.6449-1-mynameisjune111@gmail.com>
 <20261105070845.6449-5-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 07:37:33 +0000
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
> Keep ACK failures associated with the transfer that failed, and preserve =
ownership of requests already submitted by that ACK.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105070845.6449=
-1-mynameisjune111@gmail.com?part=3D4

