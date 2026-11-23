Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795424044;
	b=rBpLwOHLF0Ig8UUgNDPXtrIoqzN0hT20qb3s8TP0eCqXwwvLB9Ba2NiLR8xyL3LQq36F
	 bCnKFdnbcQuu3ORe1m8C7We5n/Qzh4yDOwrXCaV06D1NgJQztyFJwCwq1+6mw/vOKDRAu
	 ShFShiZZbWQk9qYKzCN2iYBnQ0yc0EVOFhlPW/yI/F55Xh7riyfB5rQBh5JWu/p4zPL0k
	 yIAN2R7oQx6cYXyTATNlA6o8o5OAjAQogHXmZMfoiPhOA2T+qT07ILDkS/dDjL1GmlUh5
	 Oeo02lPljUeaKMVxZqkUE3FU2DeaajjT5nUnOx4r9uYZKaII16AlTEvb62jSRVEAQwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424044;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6pZ96YYIjwJCEowY/XBwxC+NfnZ2HIIoKJA8KnON9l8=;
	b=IRfHTG2q/toiUiwcforJrqOd5DTXOTJZJpaBr8IwcjS52TdohLPsNSZJkHaXG8RQCONf
	 ohl/GTg6rFQw42o5r175rpWrQpd50qOv59HSNvSVxcLBI2oVd3uOiwljqACTmqsklCvqz
	 Bfh80KrmS86G2J3h0q8wCVZ7FT5qXFYemsBnHMjNuNu+49QDWjofJTaFZqiMvXWqDNhZb
	 lAtuVnaefBSWHGqLPP5Ld25ALUwh/IKi0AUfailiS42lpam6gINGJ3t9f0al40DaODvZ7
	 9reuT7Bt9ReCwWBMMn53GHxp7Tm1RJj6IKJ/bVpb/+jxyyUMEfW3GjcVxoe5ZC7xxSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QzANQObX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DF5606A31A
	for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QzANQObX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D331F000D1;
	Mon, 23 Nov 2026 08:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795424043;
	bh=6pZ96YYIjwJCEowY/XBwxC+NfnZ2HIIoKJA8KnON9l8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QzANQObX2gwYbCN6iSnMj/HtDr3o9ofV2tPjjBJRodjlOhJIimsxRcEuXeuD5iFui
	 HKu9zCMX3RC0guvA2qGe6G199VbmWgqBK/uilTJVvKCe86gVcTMqc7SUZdzQDV0iHH
	 Z51dD6wkomOE8PO3l8mMdkxgNBdgWspIBdRfnCddCQaUjYa1cwFMc8u5kXDZQtkXju
	 7X2+v+l1PpSWtR2voXxJBrteAAS/hOq3Ve719kgxTjJawne2nU1eY3bFNMXHCgmrcp
	 lcYkmbLiYJWY+Qaw3h3Kiyo10JSceNoBg1jEHueoSmTK9P2pXx1Jgy4IdZYpVqOc8P
	 Sdd7pUquGuO8Q==
Message-ID: <sashiko-outbox-228917@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] virtio_blk: validate zone append sector from device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Annie Kim" <pulpannie@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261123084701.2616027-1-pulpannie@gmail.com>
References: <20261123084701.2616027-1-pulpannie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 08:54:02 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Hyokyung Kim <pulpannie@gmail.com>
>=20
> The device reports the starting sector for REQ_OP_ZONE_APPEND completions,
> and virtio_blk copies it into req->__sector without checking that it
> still refers to the requested zone. A buggy or malicious device can
> therefore make upper layers believe the append landed at an arbitrary
> location.
>=20
> Validate successful zone append completions before updating
> req->__sector. The returned sector must not precede the request start
> and the entire request must fit within the zone writable capacity.
> Reject invalid completions with BLK_STS_IOERR.
>=20
> The polling path may batch successful completions, and a batch can only
> be completed as successful. Perform the same validation in
> virtblk_poll() before admitting a request to the batch, so that invalid
> zone append completions are not batched and are completed with an error
> instead. Move the request completion into __virtblk_request_done(),
> which takes the status from its caller, so that a polled completion that
> is not batched is not validated a second time.
>=20
> Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
> Signed-off-by: Hyokyung Kim <pulpannie@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123084701.2616=
027-1-pulpannie@gmail.com?part=3D1
