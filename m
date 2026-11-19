Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795053336;
	b=fsDb0atEw8pXZMS9BQUCIE3LmFw1ddSU9gsYMZ6TppimKQRLYYXtInFWlrwzc4AOUKC9
	 e+d5Txg6B7IJNz/Zr8ziZgBZLZMIekbcw+I3+VsR6OgPqGL9vP65wWTY6FGRG+ssp40fw
	 hTLDrNUnVoOd7uE+ZsTXO/oGSXSXIog+fjowfMqE4oJ6+YG+LiVSU3hr1ZD51mfwvkEC9
	 q2/f27nzVsn23xMrM1DclZZ9/yYLQZWyGvSRoGiUaHM/U6yNFnNDZKsxyXvw2Ve6U8GO0
	 90fxag7qNxA7CDAJK8V/d3Q1tMDH7LthbmaeH7Plv9dCn3Z+hhlaXxH6iA2dKDkyYBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795053336;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tluN4V50OAkpjguVUeFxTLxWhQKi7susriV2PMN5r5E=;
	b=i6IF2CM+z6o+kXyxYQEFjngyM7fQ/GqUj9TDOblJHRjZSXVzeAYJGjvtdCkg4Ohr4jX9
	 n5FAj+Rvp8tgAARduK1y0McxMNGbn41In5UjTFIBl/oJrunIr3pxHg7aVSvDVXSojp9Ul
	 JlHFYyrqvGN9ySDNKhTqncde6vGE+MTJEbt0/u4GRS3xdP8+jth0nFRO0yGdkPYZ7gyXg
	 MVUDyJ4ZVTIe2iqII9f487r3aq2Dwv+gQNbVFATHasUCdEu0pRe80jsmH4Tze4PaLV8EM
	 GW5NpJPMj4JOiE6awuX64ykDiWklenrQ9koockEyELN+cafwXMfEA/Q7TB9/VSLRsdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLjA0afA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E929560A2615
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 01:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLjA0afA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2EA1F000C6;
	Thu, 19 Nov 2026 01:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795053335;
	bh=tluN4V50OAkpjguVUeFxTLxWhQKi7susriV2PMN5r5E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MLjA0afAVh++EkQuafWYthAHEohGMmnKo9b7WBHEenCUTdVstSMuJzG9vcj1ZxfoB
	 gcP94LvhCk8cHMCQ4e/DKoKl6coGfOddbEG7xlKH7nSTh0ldBpPu6rkeD/PICrcbEp
	 o1bmY6O91f+wkPT+tg5ki9/hXpQNZXU5nWPzEEsrOOmMDoGZYPLmGbMn2ZUSwjVGbR
	 7V5rmGWrTeEuHu6oD5NS5ISMs5MPfdPT3reGY4Me+ZuJ3G5+7bmdyt7Ua3XN1Tb2lo
	 WB6QF2u9EaJ2wPCGprmtm+ZbtDzRJ7U2DWPdPoJTO4Vd+Mfk0H3MCFmMZ9gXcQ1+bU
	 0NXe0Xof1s8tA==
Message-ID: <sashiko-outbox-222309@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v7 3/7] vsock: pass the netns to
 ->has_remote_cid()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261117-vsock-guest-ns-v7-3-7e522ea9dd9b@meta.com>
References: <20261117-vsock-guest-ns-v7-0-7e522ea9dd9b@meta.com>
 <20261117-vsock-guest-ns-v7-3-7e522ea9dd9b@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 01:55:35 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The transports only use the socket to find its network namespace. Pass
> the namespace instead, so that a later patch can ask whether a CID is
> taken in a namespace without necessarily having a socket on hand. This
> will help with avoiding CID collisions when devices move between
> namespaces.
>=20
> No functional change.
>=20
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-vsock-gues=
t-ns-v7-0-7e522ea9dd9b@meta.com?part=3D3

