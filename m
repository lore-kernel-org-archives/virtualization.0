Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794574656;
	b=fJDObONWlIDFY6b9SqxB08HetTGtajyaKwt85cel8zTFdK76ILU1ApB2cyt9CCa2UdAy
	 TGfJ/sRAhsm7PPA4qeZFZ+FRF6jmHSu6Uwki2x2LFoNL9RGRh6tQ7HHZWpnCHJwfuHJpn
	 JkuB3K+AphhXuULPQEVr47iWTIJCpvsm7rurFmLAilK1/OlqiBndeIK7vRbatvUXKXWq2
	 wpi5iWK2AyZyAnzEmty7EJUAzpz1wkHyxQ0x/tSTXX7lpWvYY9e83Awx2or76jIHy65T/
	 mhWpTRH2nvUNx7cjyn7S3EeNk58zZQG1NzpNxIEhXcA7Hv/LrGB8N9LFm2RIRNnPW1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794574656;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=47t4t5v6LZeQEUaKFdtzwB4tEFdD03yZpULiok0HfkY=;
	b=XUlyEO/K7nGZ+966jKbUdEzgPmwxOit6cqPu466qYqBOAbe4f3pLz1mJLCN94bJD8Xdn
	 jGry9+cPB751SEFigEHfYBhDoYtxofJVUDzucglrOc/tD2HLKIj30bvjSLXSJ9GfSgfcr
	 bdx1enkyJqqLNmB+ZzItptHpu7PpL1FRFlS8FzzO8cq6Q5Ea2zVhEusKoqxytSllkXqWw
	 WXZPyDBjlNV1bYxsuyuIf8Xkis2SNrgs0sPAP2QE+AGB+kSqBQYCqrIseLdP+ZsOurqBH
	 Hn95HA9zgqPCsYpZd4CwmcXqVLWDKEtKBTU2x+wfep1uGi1r23LGQomEebaO0XPHDbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lhko6R62;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC68606A327
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lhko6R62
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007321F000C4;
	Fri, 13 Nov 2026 12:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794574656;
	bh=47t4t5v6LZeQEUaKFdtzwB4tEFdD03yZpULiok0HfkY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lhko6R62m9P3/zhQm1ExuBrKl1S8HB++r1CHiPUB9MJRKngLWLEVcdl0rh2AH7qfk
	 XSr/+mGkk+HbDVtPQC7NeT5yp3hO53fEZHakz77UWhfJRx9UrlYOtKbqI2v0SglV0R
	 ux9NnPhOFMiqskA/Ybn3HV3C4cqThoovXw+hC3DFjQIWBi3p6RUqAgGPxX63LEg4tP
	 D0cQFVoOyeccrSa/scsF5i5OGMxvmB7w3ba64SgxVeU03YvO0xOHy2XoAV/m97ENJQ
	 L8XDkbC4hnw551tOfID5wjwpVX/crFCSuHjv4S4TZ2vHbqczEj0hK4KXOw8lvQcr6u
	 Hk92+DzKATY4A==
Message-ID: <sashiko-outbox-212799@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 1/8] vsock: expose the core port allocator to
 transports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-vsock-dgram-support-v2-1-bacfc85b71ce@redhat.com>
References: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com>
 <20261113-vsock-dgram-support-v2-1-bacfc85b71ce@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 12:57:35 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The core port allocator is currently private to connection-oriented
> sockets. Virtio datagrams need the core bound table and port allocation,
> while VMCI datagrams must keep their own endpoint creation and port
> namespace.
>=20
> Export vsock_bind_common() with the bound-table locking inside the
> helper, and use it for stream and SEQPACKET binds. Keep datagram binds
> delegated to the transport so a transport can opt into the core
> allocator without changing other transports' binding behavior.
>=20
> Keep datagram and connection-oriented sockets in separate logical port
> spaces within the core bound table. Filter bind conflicts and bound-socket
> lookups by class, including wildcard CIDs and automatic port allocation,
> so datagram and stream/SEQPACKET sockets can share a CID and port. Stream
> and SEQPACKET sockets continue to conflict with each other.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-vsock-dgra=
m-support-v2-0-bacfc85b71ce@redhat.com?part=3D1

