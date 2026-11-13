Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575791;
	b=37GwNYZ5v2GOqlJT+pMNJ/RykBvAD+Vp9NwdLBcJeauNpqvr7YB4KrRTYfB3YPGZe5io
	 DeRsv1g2f6Ai088wkLeAyJ3nJLwahqC8NnZBes7te38ACs+8lsWS7LZomd0DmohOiXo8X
	 czM9H0Cg6cnHzH7/3yrtEl5I7vW8PsiM4UNP6Q2J0VoTDlGQwbWiUznwdaOldK5+n+wi+
	 oTqxw7b5eFPwdjnWUj/ZthZNY97OOcRl7VkHxUMtR1pFW1W7hkGoH3yGtPOmA47OpjxNr
	 e/y/apV9pjvnglCLuMQ3BQf3/og61B+vPAH5elhqT+L9EX/iLsJNc8AXdzSbK/Tgslw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575791;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7aZNxOxcQqrGgO5UAug7Qq7a1qj7S85UZdKHVvsNMco=;
	b=Bkngbr2LKluOrMbAssb8zjPcHaxnrGfJMJRVxQn2sFlvW7EYQN67DuUGi/v3tEd6XK+7
	 efThPgspY0PGpL7fB6iQ4tQYhQWVqF22KG6ojrWY0W0APtFdjMJB2XqeQKRviqpfr4Djp
	 vbKnc0FugykLYbdr9PCEDpwB7bizgx+XAop8pSGDNHElFe/q+g0Ouou9WevielnjVf/Xw
	 dLU8XOqLxA5hYFNRj2ESvXkXOkfuzzKiZ7CZS1NfHLFeWEATNndTVufQn5MYrljHORzmz
	 /YjzS5lokegB0Sn8nF12klfP1CfctFv25X+zw6NXKWJkilYs7XBZ2mhMF+fBpxzxgew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=itg7EXYI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CD8606A327
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=itg7EXYI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F001F000C4;
	Fri, 13 Nov 2026 13:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794575791;
	bh=7aZNxOxcQqrGgO5UAug7Qq7a1qj7S85UZdKHVvsNMco=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=itg7EXYIRF5GKXB4KLGyAPxAI4bVt+URPKtTclvPZkxuPMOcAB+DksPzWbK3s0l0g
	 LGUeIpJ0HptVNZnrcaXoVJofa2P53ghcDSWQpusyaiea7MPU5I7ExgxaZu9fHPlvwn
	 F0UDNpZbg8o4Q0WQsi5RnT2SKsVcE+NBP6Sc/xlC8YDDYFPoPs1M/n2z++SxGssj/x
	 bwbAdSQxuTGL8R4Wz3pr7RUKxQslhAi226jcPvpkSlPMXQyQAoOo9sepwl/IOA2jd0
	 g3uPI9PPhFyzcdrAu8j5MLjEceMDUo/7hpfjvWQb79+jY564ugzWvmwl5SJqxphlgy
	 TWwlyrohPVeeg==
Message-ID: <sashiko-outbox-212835@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 3/8] vsock/virtio: implement the datagram data
 path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-vsock-dgram-support-v2-3-bacfc85b71ce@redhat.com>
References: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com>
 <20261113-vsock-dgram-support-v2-3-bacfc85b71ce@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 13:16:30 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Add the datagram feature bit and packet type, and implement the common
> virtio transport operations needed to bind, send, and receive
> datagrams.
>=20
> Send each message as an OP_RW packet with a maximum 64 KiB payload,
> including support for empty messages. Bound pending sends by the
> socket send buffer instead of connection-oriented peer credits. Use
> the socket's skb memory charge for datagram SIOCOUTQ, including empty
> messages, and release it through the normal skb ownership lifetime on
> completion, rejection, or queued drops.
>=20
> Deliver incoming datagrams through the datagram bound-socket lookup
> without entering the connection state machine. Connection-oriented
> receive lookup excludes datagram sockets, so each class can use the
> same destination CID and port. Validate the transport and connected
> peer under the socket lock, including after shutdown, and silently
> discard undeliverable messages. Use the socket datagram queue for
> recvmsg(), including source addresses, peeking, and truncation
> reporting based on the payload length after socket filtering. Reject
> MSG_OOB and MSG_ERRQUEUE before accessing the receive queue. Reject
> datagram sockmap admission until its receive callbacks support it.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-vsock-dgra=
m-support-v2-0-bacfc85b71ce@redhat.com?part=3D3

