Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794712873;
	b=308LI6lCJIpGnKQ3CXsgVHTfEHZ+hGu2Icg6m1gOgJrlVQnA7najsRVq9LoxMdIk7U6C
	 Xhy1A4DTWKt2qWXGPVG1sp7Zw85noYcYA162IShszfOlH4P4P6qcstp30GWuZQxdqyAnT
	 +8lwX99j2MfTMvdlxCMGWQFBcMuKYGz8ATUxaT4W7ID3DAIzyrLyX9MUsHmuGYZpGQADy
	 yrBU6Jl4f07nFwToxBda+B5GUgBIg3oGn6LjwTxfUeA2rIFozmvNlTMj1p2rGgPFO+5/b
	 APTYRBWyEc4DRoxXGLScTYvJGI3EDGl5OgUo27gYdmJomSTQgUmkuDOt3YuaIrxFmKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794712873;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pvjBBwIilcygQN/NuSnDyqf/B3bMEMRfzr1ku62r22o=;
	b=s3y8Het1i0JczGpxVlj0uQsXFMD4XKBBldFpPQLTYrclsoskgTAW5VJU3tRPFgK8hzdP
	 +mt8PNaRJ500y84B5yovexjx2uQF58GBiHZMzjixSRgsUeiaTCbZyNxCCIFUJJSxZpkfb
	 gzxNU6TJy1WRAASSH5f2x7tqdGrQYODDEvNw1ikaOlL/npXhqKYRXKddIAHE4dzuoJis4
	 CKpk+qxTPxPtQXTmGAnhk/qNh68KbQ0+SdoyHL3q9TAgxY7qzOzVOJ9kkKOJhvlTOunEQ
	 OZ2BZrbmNcwzve9EP+qceSZWNoS9A8oJEUdZSQRHe8cL9IpEYUxlCUUEiybwuipVv7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MKzNfrrn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8761606A337
	for <virtualization@lists.linux.dev>; Sun, 15 Nov 2026 03:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MKzNfrrn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8468F1F000CB;
	Sun, 15 Nov 2026 03:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794712873;
	bh=pvjBBwIilcygQN/NuSnDyqf/B3bMEMRfzr1ku62r22o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MKzNfrrnPa0lywNebmq2QYQ37wo5K9lqhdxX09nHolZ2v4D7RKzyYjfurzDw3V3ch
	 TKwff19nUk8aBG6U771XNdBz3df4LLmjZXX4egzZdeIaoJ/WeF0kCNqQnJufomST86
	 LhvfXdJUBO+ZWctChMVmY/+FL0SiixclNqlxyeZ9wBNYnwXFiHzBjrn1QC4ccO0O3E
	 spwmNifJ51BkZBZkFqDNPl1z0I/ixIep4hB7FndyNkhXshFgHAidH8n7tkVxMJImRr
	 ltL9/4nafLxOtxwXibJc1kjV8kp9E/QzMIscQcUKr1jXQY1mqTrEGiNwIZBy15Mh7q
	 i+HC1jWsE6Q4g==
Message-ID: <sashiko-outbox-215198@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v6 5/8] vsock: add a netlink command to assign
 the g2h device to a netns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-vsock-guest-ns-v6-5-3737ce4673c0@meta.com>
References: <20261113-vsock-guest-ns-v6-0-3737ce4673c0@meta.com>
 <20261113-vsock-guest-ns-v6-5-3737ce4673c0@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 03:21:13 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Namespaces let a host isolate a VM's vsock traffic to a specific
> namespace, but in a guest vsock traffic cannot be isolated to a
> namespace. The vsock device is hardcoded to global mode and can't be
> moved into a local-mode namespace.
>=20
> Introduce a vsock generic netlink family with VSOCK_CMD_DEV_NETNS_SET,
> which moves the device to the namespace given by the netns-fd or
> netns-pid attribute, as rtnetlink and devlink do, or to the namespace
> the request was sent from if neither is given.
>=20
> VSOCK_CMD_DEV_NETNS_GET reads the assignment back, reporting the
> namespace as an nsid relative to the caller. VSOCK_CMD_DEV_NETNS_SET
> only returns the netlink ack.
>=20
> The command requires CAP_NET_ADMIN in the initial user namespace. A
> [ ... ]
> user namespace is required for the assignment.
>=20
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredh=
at/
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-vsock-gues=
t-ns-v6-0-3737ce4673c0@meta.com?part=3D5

