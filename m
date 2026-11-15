Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794712872;
	b=Dw0Rd4plD0PM6nGgcVQ6n+tiCvMRfIfD5kBB6dOECWruLKhNpUMaqOIVVWhlfqIYqf0j
	 Uh33oaI5vQW3m+cqVvQ6tPAQT4dQRZil7Tuup8fT32+B2lMFO5oxJwEBB+KsdXdP5c2rK
	 7FSgz5luUC+VrrG7CSEHHuhO1HL3HVFOOd4FJ5kSlWUWvSmja70aVxzxkM15CrmUwzpER
	 6fNy6vuY9/LYc1Cue8OlvLAw7fx2qwon4okgN/o9JgD3kKwG7AeMLmiGRpt5fbpuSd+mN
	 b57BV0CHBUaZlwxl8ubmXSeoMvOM2xQPBnV00hh/3eIQNHUAB0qMeCdqcohf3QNiM7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794712872;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wnW8vDmUfgwtrL00SGQjdVOF1oYBz2dC5SNHYVvSh+I=;
	b=ayp+driu+RIP/sBtYkHsUfDM5eGdVVZzln75N53dp2oxz6Ulk2VRwPDK12Ak0vX5qsRi
	 0XvYKsBwKEwq4psyWhdy60FASCWf0CudXXIFyLrOmH8G/oQWs+qWv8Qq9vyB+C3/NavPm
	 bZd4UhJLFTGQY1jAKAYsuRqyNuTNTzgow6+E0GfUb9dlDHdJlHbXE+7syr1E06mK1Z9c3
	 1WfKUiEFqzAMKtWmx5sY3UwyV64dPbDmX/sSiBbbgsxfk+YJYCFG7E8anG03IYLWdM2pR
	 neP+TayU4oqabeuRSt+de3RXx55VoD9u4sEtPXm4XN9QTf7hqsPTHHMoSQ7b573WhLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nh2OBtdQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73121606A333
	for <virtualization@lists.linux.dev>; Sun, 15 Nov 2026 03:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nh2OBtdQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CBF1F000C6;
	Sun, 15 Nov 2026 03:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794712872;
	bh=wnW8vDmUfgwtrL00SGQjdVOF1oYBz2dC5SNHYVvSh+I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nh2OBtdQSVXehqu3Qx6jgms1WtFW19lETnYmA0j6WyGWVwvhlfA1aS9OHsxbRMywU
	 DNp/rWWHE4wNqXgNIdDX2gZB1Iqw3TugxaX3ILQaIZFXomTyutqlfpeLNw0hijEXP8
	 ue3xTve7KG3xNEyI4VLOFCd33v3MUCsjkLIAQisj/jxTPuzgwmL/Umuu7wwNg77Los
	 tO1uytZRt0kfrjiMeiuUAaEzoXiwu2Mw2grld69S5nkfkgUmhK9OjSr9t508E13BVz
	 ZMv+HF9n8v6B1tNOPcm41ypc7AtQ98xN3O9110/BWfoAIRu/7lGPQ9roN2NzdZfKl3
	 +YdYKQnAF3MAQ==
Message-ID: <sashiko-outbox-215196@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v6 3/8] vsock: rename the vsock pernet
 operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-vsock-guest-ns-v6-3-3737ce4673c0@meta.com>
References: <20261113-vsock-guest-ns-v6-0-3737ce4673c0@meta.com>
 <20261113-vsock-guest-ns-v6-3-3737ce4673c0@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 03:21:11 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-vsock-gues=
t-ns-v6-0-3737ce4673c0@meta.com?part=3D3

