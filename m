Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C79F3EB105
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 06:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874181; cv=none; b=gWMKGNFKb3pcAXVE+g7/YZfWtzha/0m+6kXYDKpMr4HCXktTjsu4CIg0Gl/FgR50Vv9svdtvGIrNdY3ZHUV5hJ4A0CMT+SXRHqhV8wUvQmPUIokR2xNDI7/usiVF2m/90/o93TatUqv/Ci40v+M6/HqRiZ84Zws6I+GV7bpgJ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874181; c=relaxed/simple;
	bh=CpOrb2143lAmgDLX4ApbN/b4QT4tBuXc843vGcoO+v0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=KuxiGNOEjrV0Cu0MTa52lcuKvmH6W9SsXsnGHjwE87Jwx7sbDqEBDhe5PREyg0Y4clxmzQ4TCqhPTauzkaI/z7yvHNOPToomnYMK+DGOTKS35u/v50mmS9z1jLRF+Bl+YJEnOCG/GgoP4g9CU+fpVaTXKBRZlq2tyZbyIzgg+zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBkMLNh2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBkMLNh2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030C91F00893;
	Tue, 13 Oct 2026 06:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791874180;
	bh=CpOrb2143lAmgDLX4ApbN/b4QT4tBuXc843vGcoO+v0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UBkMLNh2qVaAHw0awBm+DTNPWJi5KU37PdMtI9O0vdr52DAkDpewEZib110S+anR1
	 LTlf0b5Pw/zZ9B+y8bQ0UNZAyjhAELk+s14aPWWCQfro/FehRUM58lS7D5K9UxTQJt
	 hjW1FeYMil5ONqHWrSVVpk+w6Bin8Uu2qoN1DSOyFX1MK2im+fjN6u35KVy8MG+kVc
	 KSJlssIwATRjQu3dWk70lp4xWIHKBD00C8/6jXz9SvxIsjjQO2O7Ye0IjNz921TOeM
	 jk2UqPdk7tlOPI3Pk4YPVsXX5qKySHlq/RnT5jMe5HeRnw4LO+kLJzJHMX0OT9OpCm
	 Fs1B9xTyqBuUw==
Message-ID: <sashiko-outbox-169139@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 2/4] vsock/virtio: amortize RX socket
 locking for stream packets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261013063112.168321-3-physicalmtea@gmail.com>
References: <20261013063112.168321-1-physicalmtea@gmail.com>
 <20261013063112.168321-3-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 06:49:39 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> The virtio-vsock RX worker currently acquires and releases the socket lock
> and looks up the socket for every received packet. Keep the lock and look=
up
> reference across a bounded run of packets that belongs to the same socket.
>=20
> Only ordinary RW packets for an established STREAM socket whose transport
> and protocol remain unchanged are eligible. Control packets, SEQPACKET
> traffic, state or transport changes, malformed packets, and sockets whose
> protocol has been replaced end the active batch and retain their existing
> handling.
>=20
> A psock is published in sk_user_data before sockmap replaces the protocol
> or callbacks. Exclude sockets carrying that marker from batching, and che=
ck
> it again at every packet boundary. Thus an attach racing an active native
> batch makes the next packet end the batch without changing the sockmap
> update result.
> [ ... ]
>=20
> Introduce virtio_transport_rx_batch_finish() to tear down the batch and
> release the socket lock and lookup reference.
>=20
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013063112.1683=
21-1-physicalmtea@gmail.com?part=3D2

