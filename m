Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793843678;
	b=GNuNO7dyl9iIYawRj5BnTKn2baXix5KWstyFKOI3ixD8YFhttWiMifbyYg+x1+oEHTuB
	 u6g4pQRPIBXiASfi3VZdFAWFBIU0VtUYFZ2Aa+pnwlxkRsDzrU+Py3UcsSSb6yiFiN5PU
	 vmNnQPRFAF1rvxNU/xHiDiSyu04aObx8Iyr9EQoq9uuioiccWs5m/cNLu6w4w+9nrdb9X
	 OUM992bjc0UXTov0FeqtCH3rk6L30pXVpJu7OJF8OS7saC47B31Jd46S4wYHmCi/0SHhy
	 HLOqUU7WmlZQKsvIDcxv8GiZg7nTWWP83IIaReW5Ab3BlIdk+acuB/XPOUQJuIYpEAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793843678;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TRuzQZf7U/xQHjB42RRCBpCEfg4cKmloleRdeliy+3Q=;
	b=FmgsKowzOittbjqNe2S5YU3mpQydpe1bsgSZSz7Neb4R/+I7k04PORJOuOU9gV7b4WU6
	 Kl1Q3t1gmtxh89qikDxmyIVNi/ElaOuCj7KlCLMZzpA937H3ZuBbuaE59Z6zyYeG6rcoF
	 oR8cA7TKKyCnduLH4LbqlXUGm9eC5WcCYVJJuD+KuezvPYh/gi1kFa5J4ujDeyySBUzMk
	 RW2CmvEnUqcteaQ+b2D/8taX2a1kFZxDZOHr0uoQuesD2LJ1EtNiH9FKqDTgUSihIrSm4
	 78Mry6IofL360AhQ5m5pSon1RiADtFmbp4u0W1VSmtxVdBQg1cSid7sNNOcoL6Vrcdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="K++enpW/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E263606A326
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 01:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K++enpW/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AFD1F00919;
	Thu,  5 Nov 2026 01:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793843678;
	bh=TRuzQZf7U/xQHjB42RRCBpCEfg4cKmloleRdeliy+3Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K++enpW//9OR5KgH6UGvVn3PGKM4MsmsgTzIGvZAT6JOt41gaCTFok2RVTo7Z5o0m
	 sr5FMHYgRv5/nv4vg+cvIhyqcS8avzfAfam5xBG+nz1+f6qm60JLhDh5A9v8FkrQv3
	 iOnJ46BlyyFBu43ERYMosNLv6ghXNQSpCUVrCnIUwCSBxBynvu/nAi3n6uSxkHWtpD
	 jy60GHFB2yyargPKLHLDo0QaLv0zvY9WU7T/yIeamk/2H8OpPX9+fU88G2V61WjQf0
	 HDoQUfbmI39c6ftAYQuIcQhYlx1IcaSAhAIJ2O47omECqE7vjPJfdLhCl48gNEZRkC
	 Tc69cE3xUXorA==
Message-ID: <sashiko-outbox-198418@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 2/7] vsock: rename the vsock pernet
 operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103-vsock-guest-ns-v5-2-48179b9b66b8@meta.com>
References: <20261103-vsock-guest-ns-v5-0-48179b9b66b8@meta.com>
 <20261103-vsock-guest-ns-v5-2-48179b9b66b8@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 01:54:37 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> vsock_sysctl_ops and its two callbacks are named for the sysctl tables
> they register, but the init callback already does more than that: it
> also initialises the per-namespace vsock state through vsock_net_init().
>=20
> Rename them to vsock_pernet_ops, vsock_pernet_init and
> vsock_pernet_exit, so that later per-namespace work can be placed here
> too.
>=20
> No functional change.
>=20
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-vsock-gues=
t-ns-v5-0-48179b9b66b8@meta.com?part=3D2

