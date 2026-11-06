Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984468;
	b=Z61vpiO8mHWdRMn/6bBCOjNMsE441d4ZKMg0PqkT7CfJSxpvVCBUGxh0MS0funvcgGeC
	 wjymBdLjXmIeAQW/l7NirvqlWOgsZoe/V3OXpxTeIEFIU2iCd983dsD5AdUVEPGBtQs4i
	 Vfq0hxXOTL7EfO4TnbocNa8eQtwenEiSE+RPRDAvqa/7UJj/OeNb/3v0PZ4wshMsbls20
	 ysgsiQwY4qcrzV6IUiuAppufcbgkaK0oqNlVUUvoskk+hTsB/2Z363vEriLZwk89ODLdn
	 d2g9QBtwB5GVanOJ2sQRu/TbgkkrS3qrXr3SSzcmHPnGqFFdVOLA1GBNMczz3rleQ9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984468;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1QvmJl3qPTfDCpPRjHcaoobK3nhw7xqn7zSkkRVilTk=;
	b=W0bJTGe9L6IG4r3p2f55jIyRQquJkdoOAqEbfmlX6monWmezFTyu35PVbsV/gCFoFZWp
	 TBcRzAxmF9W75Y6MOV6VL5x/2LIjj7rhL/K7g41BVu8DyGniIriEN+ti0do5+D/e1oNNA
	 /8VmoU3X/2PLJSuYCrpVhQmCZAscjvuqC+94FH67rCFDgPGBDBmHcGaNNCpoffJArCLGZ
	 Swp1S2lQpih4X8dN2DUrL4OanH/YTdd/hkBkM8Hcis8PRW6d9FvuefN+z6pQvR15O+r8M
	 9FulT9xSnQwPNX+sV1dCbnRNuZMh/BiR1jzsS9dOGFRpFSDhxA+NAQ98a6K3WhwKCPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="b/CMSDD3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF487606A32D
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b/CMSDD3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF951F0089F;
	Fri,  6 Nov 2026 17:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793984467;
	bh=1QvmJl3qPTfDCpPRjHcaoobK3nhw7xqn7zSkkRVilTk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b/CMSDD3C55x7jfYxVYbFwWMiNG6MOa+OWnDGqSKKDMhZy8TIbthmj6ds47/FFt3E
	 qm21WdoPfO9SXw3YVvgLMvluLz8OtiKua6f++xp6VByyLx7+vJzx3M/LjoU9yUJs5V
	 rUf/K90Ft5y1Y5r0CRHdgm5FNyB+oeBMagJycJ6AB6+YHLCyiLtukGRoRSjmXopEh+
	 2VQcfgeqnTm6PBDc1NtJNcHeYSx23BJG8fo8uFXKvYiDC90VK3/gJtQ1zNpHFxAbO8
	 UQVDvWgNiQ8y4rEtv1ITL2UtS4nNeGt926ta+d+DUdTOBDrQr9UK0cygrd2WIM4Q1W
	 X7qAPmtGjrJRw==
Message-ID: <sashiko-outbox-201887@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 04/12] ALSA: virtio: Propagate PCM send failures
 through ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106161838.94308-5-mynameisjune111@gmail.com>
References: <20261106161838.94308-1-mynameisjune111@gmail.com>
 <20261106161838.94308-5-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:01:06 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106161838.9430=
8-1-mynameisjune111@gmail.com?part=3D4

