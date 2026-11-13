Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591285;
	b=PZXZeW/TaQIYQMPRODX9bV5gowF5VhX/VQ/oR/L6TTLE/mzARUEpVTU7YsDo+PKaUgfa
	 7JjhHhu3eIdxRMG8nVEbmHPaD7LygStxTlZ9yANpySqFZrN0xnsUF0vPpqMK1tdGUIlJu
	 2vAkGItOeVPjkuIA/ORHZjoOAPhZPltnZeI2gKr4PU681Go8gskeoYNv0bFR8Lj2XbzRU
	 7ZdvxYIm+srG6FGuONaK1ZT8f0+W/sMhUmKSxzsODdeBxUALICf4U4I2+a2331h0D5RZ6
	 NgTeUKwhNdHcs1454n591sJKMbLHAUZWGA5Qzjkx4IDMkLIR0wpU4n/D/eJJqjuxxzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591285;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Kn5nf/fBn0VnbLnPDhS1UwMv/DxVmLJ18gBRqxhzmVM=;
	b=tMZFOmgJf6rEtpGX533GGoq+j+nKArrtwuD2HbH8m+1vj06TGz4C5d+yUx+oabXoOsjn
	 Wm+/qpH8CDFt3HkeOq+oQQOC6eqfPmWeo9c4bcDDrXtVlri2iIxYl/LcYuO19CyRAeXUC
	 J3WJ/bU2hQRO3o0DEXV9M7s0OXIUfZaoQ1Lm/MXA9DweL6AmwJqPLuwgkbO+cxNp2UPoO
	 9+S0WkqERBJL3scptaY1YmR6F9qxPWqLn4z7G1NTSNDc9sME3UNt+Rlx8+T5dxyOe8Yz7
	 2rVhR1B0e7+IGVpxpDLzsvhhHjFL3dRKlELpjHTeIXRrxpsRx4nbnyUQMFN3GKa7fhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0k1lvkS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24956077D4B
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0k1lvkS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2B91F000C4;
	Fri, 13 Nov 2026 17:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591285;
	bh=Kn5nf/fBn0VnbLnPDhS1UwMv/DxVmLJ18gBRqxhzmVM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W0k1lvkSrTPEq8SN5OZoK6kKn/Gsjxc+mk6DBb0A+NYBwFtSlM3Cw87OP5yggsjWY
	 kBjrXGjn+kM8XzA1LVi+rAsbn1LeN+Y98Cg/CWmIhHgU7/PS5u/LoNt8OAKsdQ0Khi
	 dqHXd2N6RcsIsc7HD+YOxIUzDUZBzV8/TEFquN9XBrpf37cUDGkPwt1Xahm21itsq1
	 omcFLXJWBCa0sKrQdu0kPi30gYblhjDemrB3/02k5itTBiqPAXKLeJb1Oh7vfVbO2V
	 dlo2lRaipRmpXhCjW4pR5Ms7BKaB13elDjqcvTCdj3Fo/TCMJQJybKU2yhBhf7hqCQ
	 DLsfo2uaVFo7A==
Message-ID: <sashiko-outbox-213326@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 7/8] vsock: fragment datagrams across receive
 buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-vsock-dgram-support-v3-7-1523c8e9b27e@redhat.com>
References: <20261113-vsock-dgram-support-v3-0-1523c8e9b27e@redhat.com>
 <20261113-vsock-dgram-support-v3-7-1523c8e9b27e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:34:45 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The guest already uses page-sized RX allocations. A datagram can exceed
> one RX buffer. Growing every posted buffer to hold a full datagram would
> increase virtqueue memory use and make small queued datagrams retain large
> backing allocations. With delayed reads, a bounded receive queue could
> then fill after only a few messages.
>=20
> Define START and EOM flags for datagram packets. Mark outgoing messages
> with both flags, and let vhost split a message across guest RX buffers,
> keeping START on the first fragment and EOM on the last. When a data
> packet meets a descriptor with no payload space, vhost returns that
> descriptor with zero used bytes. It drops datagrams but requeues stream
> and seqpacket data for a later buffer.
>=20
> Reassemble consecutive fragments in the guest before tap or socket
> delivery. Bound a partial message to 64 fragments and 64 KiB. Discard
> incomplete messages on malformed packets, a new START, a peer mismatch,
> an intervening non-datagram packet, or virtqueue teardown. Require comple=
te
> framing for host and loopback ingress.
>=20
> A QEMU reproducer now delivers a 9 KiB datagram as one message and all
> 16 messages of a delayed-read burst. Paired host/guest selftests cover
> 64 KiB messages and the burst through both a userspace backend and the
> patched Linux vhost backend, with stream and seqpacket controls. A nested
> vhost-vsock guest posting header-only RX buffers also passes stream and
> seqpacket receive tests.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-vsock-dgra=
m-support-v3-0-1523c8e9b27e@redhat.com?part=3D7

