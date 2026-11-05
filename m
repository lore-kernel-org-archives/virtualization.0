Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793838928;
	b=tvYK+gnMvA9iZgI6RJy1ge8FJgyXuFrLVtZjl5tjGwuftSi14WGNuiCvhUl2CvC4fdKc
	 8NhoGAxgQCLKLVUoX121+mxi8N//3Xo4CjYwnEyAHUBoiM+dyRJxEOCQgIm5k+qIrXnbG
	 dZ/AAgDd9igrFUYu44jE6POjbup/ryiSziD3Y9PtJ+H0SUty0Niwpl0vMZuU/D0CE44qq
	 H3zc6zukpKES3uVDbXgi7PW3ZN+iuY7hSLE1lYlC2fVcwiJ7vvyyXC23S1YdoZhbCB/QG
	 HC3EJH+N92ZVVoazTFGCdiH0KQZv+AuBQlt+7OnGGuKU9ciMttNqZTYIrAM7rGyS8WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793838928;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zsriMxYndk5UfxbHU5CEW7ZaLpU/YHHaQZPXCC22sKg=;
	b=j5nRvY94DtUJ5yJd2acPRuF8JKf+PNRLwyjfffETRNGo/vQZ2G+VeqcXSpn1KIC/izMy
	 5lGs64+RrDV1EJDjXvDxP0g9iAz6Qnni8TGnhBPe696FSViwzxkd1UuInLSo+j2OZj3pg
	 BgFq/SqaPGDgVhRZpP1ojlWeTLbtd7USe16PzMZUpEt8xVn2wLTZ/2TCDv5n4YgHyJ9No
	 iryddPJGQeZgVMsoDtkZaHdxGJuWwsU6XO/Xpf+vQY9fMkDnpMcMVUIX9yA5Lc44uZY/X
	 0IDNd3SJBeDLNhPXh1Uq4gcx05LlRGpLYf9fcDyzX6mHXH/CqoqLzU7S+DnoCCKXkAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bcx6T6VU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1D4606A31B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 00:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bcx6T6VU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5E91F000C1;
	Thu,  5 Nov 2026 00:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793838928;
	bh=zsriMxYndk5UfxbHU5CEW7ZaLpU/YHHaQZPXCC22sKg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bcx6T6VU3nI4vVMfQlBonPA4nUGzXxKs3Ki78640GWWhmWCK/3CG9ms487N2J5j0V
	 lxkFIE0hvxpFUXR513RoaB3zOkUdoCYZeKSOxwSX/TEtZDdCJS3+9UDpml+f8xwhLk
	 WsKfDROWevcGQxIOHP/CSxf/c37vZCcIxEeC4QEvFRXimRU+24lE76/DieYN67P6CE
	 wS6md2SDG5Lmz8yCTzGpXqjggJXoeYT4IkcYBWGGQFVADjfv2BCOgPp3CQMtTBupoP
	 6cnY73ZWoe2kSpKpQcWd6Ci7wLBSHUreo/heaJOtceEhfq0/VVFXvfd4/GLfxrhHqj
	 xN1inNQWInKzA==
Message-ID: <sashiko-outbox-198364@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 04/12] ALSA: virtio: Propagate PCM send failures
 through ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105000915.15177-5-mynameisjune111@gmail.com>
References: <20261105000915.15177-1-mynameisjune111@gmail.com>
 <20261105000915.15177-5-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 00:35:27 +0000
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
> callback while the core holds the PCM lock for its pointer rebase.
> An ACK racing with teardown returns -EBADFD and preserves stop state.
>=20
> Keep the polling feature path unchanged.
>=20
> Fixes: fe981e67568c ("ALSA: virtio: use ack callback")
> Assisted-by: LLM
>=20
> Reject a stopped playback ACK before the XRUN path can rearm stop_operati=
ng.
> For capture, allow the ordinary stopped tail only during DRAINING and only
> while no transfer XRUN is latched.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105000915.1517=
7-1-mynameisjune111@gmail.com?part=3D4

