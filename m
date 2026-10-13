Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DA346D09D
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 06:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874179; cv=none; b=KLOrZDSBFrQzusJDkwMr5oc8odn05klffKVqhaYZ/89PjmRHv6+49XRMLxrgHX+PEQSCeH3ORTRxiWvzy0n5uf0+Bh0sxYb+xDanbcCKz1nRaBsmwBQ4DslUiD1ZGm9WRR/gn2X9Avu83pwourNJheHQcIooKx6T4tk0WPxLisY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874179; c=relaxed/simple;
	bh=qkyxzjyXbjFc7VV7mZbV6Wi2RpljaGQESegIH1u8dT0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=VdNL5cJMnqUdAq5eDwDEmJRUzCDgGUYMXqWdwMihU1KEGiC/61BBOrnS7dBSFuen2IODPsTpA1ZgIEuumO2+Q58TR2YLrzJLfI8oDLEx0CpwKKp+Gr4AWyHz+uOvWuLt836dbod9bm7hMCq3xx5Xap+6WSo27Zknt6JilrL1KyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1dH0Njp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1dH0Njp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716F41F00893;
	Tue, 13 Oct 2026 06:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791874178;
	bh=qkyxzjyXbjFc7VV7mZbV6Wi2RpljaGQESegIH1u8dT0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j1dH0NjpwLITpenWJwtEUUIZXor52MvopTdK1MIoLrxy5fDYffY8K7MeEWBn4Bl9R
	 5QrxvEYJZLlwVcisIGCo0qWiHbLiiXpua/uDjXxS6J7k7fvH55UosHLTSfn+cMi2i7
	 C4cc/An8c+1DhIqYT3vyuPlcwrQtqLIusZsast1jyKnzvNdUk6uG8WfImwG4cLyqfa
	 sf4vDzPoNtb80lUY4t1NJcXdXL+dtW3sCtff4/1IugDQeal1gMXQUvlJgAXO9mzjKr
	 fmuI4l6p60DRJaONfnpFMeG8OP5vdM1o/jQRv7nUb7x480m3bB7M5qt/OY+2ceoscy
	 clOLcqVQEPv+w==
Message-ID: <sashiko-outbox-169137@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 4/4] vsock/virtio: defer RX readable
 notifications until batch unlock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261013063112.168321-5-physicalmtea@gmail.com>
References: <20261013063112.168321-1-physicalmtea@gmail.com>
 <20261013063112.168321-5-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 06:49:38 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> An RX batch can make a socket readable while the worker still owns its
> socket lock. Waking a reader at that point can make it immediately wait
> for the same lock.
>=20
> For the callback installed by sock_init_data(), record when the existing
> low-watermark condition is met and issue one notification after the batch
> releases the lock. Save the initial sock_def_readable() callback when the
> AF_VSOCK socket is created because virtio_transport_common can be built as
> a module and cannot refer to that unexported symbol directly.
>=20
> Require the original protocol and both saved callbacks for batching.
> Sockets with callbacks installed by sockmap or another user retain their
> existing per-packet behavior.
>=20
> A psock is published before sockmap replaces the callbacks and is excluded
> by the batch admission checks. If an attach races an active native batch,
> only a packet admitted before that publication can complete on the native
> path; the next packet ends the batch. No queued skb handoff is needed.
>=20
> Keep the socket reference until the deferred callback completes. Control
> packets, state transitions, transport changes and non-batched sockets keep
> their existing behavior.
>=20
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013063112.1683=
21-1-physicalmtea@gmail.com?part=3D4

