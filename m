Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575247;
	b=Hp87kuXlcroY7BFRXDWq/Ni36WxASYvFgIWgtbg/bptTtCoUsBIpx1ucJRy1EMSy46Zf
	 n22d2QxZ9PW6HQ5dPwFrJbBkyuVAMedZL4U07c1JSHJIYIZ6TFxtnpnjSPn0LB/6bJQO+
	 zBa/Pyv6xZN5A9M5DgRF0a2rNExxdNJWCrOZGwbCS95VdUI3damaRTrtOJ2VygBanqQb1
	 gBVf2Qfs0CpFiuNOmrvOtL1cnydA/8m8FzsR/+28WkVvo/HO9B1rkn8xWhKL6qyd6vCbI
	 BYBvPg1e8jKVwU7kWCr2/I6gZoZ+0DY4No4np1J1c+Rh5uBIgIWscLdBgcbht/MZOgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575247;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=n7qcq3XGNgWyA0CxABwEsucLCT/69/A3c09JVgClJiQ=;
	b=VbKEoSmr01DyRwalx8cP8wigLqZEeoHseHiFttiz1wIiFtkWM+/cYvIq/IpugT4VabpM
	 jlCEgCaqxlhhXbsuR89LnJC7/3UTl7NB2UhQsyOyo/mQQTy67szguivuXp2CcPGgidrQ1
	 YPCNY9iwjqSJigpwQerhfUKRwBgLvNzrD2Pv1WK4WEcmLikJLiKRjjAjQwVg0sWbufyK2
	 eZAbOyPJTGWe2SBheayD71nSUJ+h1GjZLPbFW8oxTi+nadCeMImaLStZVCegGi/RLecGh
	 4nH1VffBFoCHP+ga43sw+IQyofkZRsEHg1UQtpubmp1aSdyP6mvU6YLQoOD6KAzfe3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HT3hC/pQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359DF60A2623
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 13:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HT3hC/pQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7851F000C4;
	Fri, 13 Nov 2026 13:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794575246;
	bh=n7qcq3XGNgWyA0CxABwEsucLCT/69/A3c09JVgClJiQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HT3hC/pQbeLRNqJQGWvKz7il1KuKrMukna5X/0jglwe+2zpdM9C/xHeM7NZWWZthk
	 nVm3YCmZXBOb1z5BvyeAJhjIybdKTN2NhAuQcTGURfDvTi/9CBpfIil16XwgSjOkdj
	 XLa9ghZfSIluXtAXj6hojY1AVyHEAiNRTvoJgy4ra2aurmPyhQRUQ0yc+kfpQKzQRF
	 D06LencgXqiOrXjcpNY38c3qnJGndM3llXWuKwoKu6vboqFF/A+UhFwBI2Swj6wh+P
	 tNVvk3x4LqQbVJ0LZAsYngnNre6kmKCZgYfRXXChOGNlITKHrm0qRRlt9nf4sssXUf
	 N0RDeCTQijUfg==
Message-ID: <sashiko-outbox-212823@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 7/8] vsock: fragment datagrams across receive
 buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-vsock-dgram-support-v2-7-bacfc85b71ce@redhat.com>
References: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com>
 <20261113-vsock-dgram-support-v2-7-bacfc85b71ce@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 13:07:26 +0000
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
m-support-v2-0-bacfc85b71ce@redhat.com?part=3D7

