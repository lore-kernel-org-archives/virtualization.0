Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794574769;
	b=PyGj4k2+p4TfWqHoLi8fC0jQrbe9B6cvMluApLTv2R3fKKj8V/VUHScRJrSI2Fj5wTBn
	 MXfBeY/bxD5axGhHu5kMNzSFuBnrOdPLQKZBEx6zofx7A56+LN+gGCGU2SEvVKhQ8ssD3
	 61km8Pl/s/p0MEwZNLygh9p6ZT5ROJnbDPfIEozyn0dR5NI/KM/TZJqPpILUlS+X6Nk3p
	 kRwEVQZQeVM0oJDkjt564EiYwz1OEn29g+P0qX/HvB5FXOjgB7uFvNk3dlUexRypgi5cG
	 AwjLW//oZ14rLLaR9HLARPiblo/E2CqEIWlv/PYvmWDuWV9Zt+8MAiQm5T1htVFdDhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794574769;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1r/5bEKlW7VRCqanJ/yJ7gNnTepCMecM3+HcF2IrMGU=;
	b=4mMRWFI2mTAXUYldn6ZcxfwOTm1Gl35ZZX3zRDToPymsgHLjB9LoL0sc2LBV9D6unHOj
	 hvKUPa3tFp2qXMDqsBiGnOhpDjv28MhWlF39zIs4de5m5yNITleJlCog9AEYSCN5lRoi2
	 cPKjajqCwQ3/X0p12xRWI1qJfOkh5ZWr+KnjJcG/y2uP0tRjumevUsUjLk4jN5/jtcKiO
	 TWVYGA7DEKlkz9JVPMFi0DPp8BtJpyT4xYiKyck/KfewLbCgmsnB4d40Fvo5L6699Pz0b
	 cRUgqtrCBskv1p94pQlRzWy/zj3eQTrf9KLRM1qMrChHS1jsiJDimO6/fPS9TGU/5IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DCmHMf6O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DE2606A32D
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 12:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DCmHMf6O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48EDB1F000C4;
	Fri, 13 Nov 2026 12:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794574769;
	bh=1r/5bEKlW7VRCqanJ/yJ7gNnTepCMecM3+HcF2IrMGU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DCmHMf6Oxv3ASEjZ1Orh3uRgCKy6iUo4udPxTzUDao2yhR8CLJeDvfhTpdm3UoK+t
	 cR83avoeaox/BglooZAr27fSHTi3E3gqv6bUtzNyP3ut9VkT5wKMfplbOJ+K7qVv+n
	 4MdrwUsaGn00uk4P4ia13+AbDBkKVFCRms3VXhrFvxaMc3G0WHZ7z6BQjxf+40oZHX
	 KDweWamoX8Ih1BGQIdykUQldc+DS6U6FbA9LJpHjt7SzzLjp+XDLq0soCPc9zZS7Bg
	 XHA5fqCIkFvNbIOq+rUBauTySH6YuGLbI2v4kXTQweWBsDN3hKmMRVU7jT9Eddx1U8
	 NaDxnA/kXnd2Q==
Message-ID: <sashiko-outbox-212801@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 2/8] vsock: report datagram receive and send
 queue state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-vsock-dgram-support-v2-2-bacfc85b71ce@redhat.com>
References: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com>
 <20261113-vsock-dgram-support-v2-2-bacfc85b71ce@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 12:59:28 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Datagram receive queues hold whole messages, and transports may charge
> queued datagrams to the socket send buffer. Report the size of the
> next datagram payload for SIOCINQ under the receive-queue lock, so
> concurrent recvmsg() cannot free the skb during the query. Let
> transports override the length calculation to exclude headers such as
> VMCI's.
>=20
> Report datagram write readiness only while the send buffer has space.
> Set the asynchronous no-space flag when it is full so freeing pending
> send buffers can wake poll waiters.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-vsock-dgra=
m-support-v2-0-bacfc85b71ce@redhat.com?part=3D2

