Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794605704;
	b=1EdZZwNQFvMS5Kdifw6RyJ7CvUOPjSU5GLIuSM7JxfohoNA2INRMUcsNCP+DSnBp0okY
	 mWmBR3J00tYlc+AqJadVBUCJNq7ClI6/UXAlcYH02r2lehmAZsdb7XZfSRDm9jw9Wi88x
	 S0+e1ejM62PUbCrplcSXdZ85iq3HVb4fh3/gSbWddyOf130HhQUJRN8V3fVk0Q8Wr+C4b
	 DT8aGncxm9b4HfaMQ+yUQ15+Yb2axh5p5ubljTXkcFlDlLXDbU0P/W+vcipJ8xsFq06EG
	 G8O9+CkazibVthyu7mB63waNFppfQJ28h8ZbF0bYKlTjzuw7i0rc2vi5zAkBYfL0IEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605704;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=U0prbtWZkGCz0Wz/ro1qP1+MPQ0O/VcplEKjhOl43iE=;
	b=qprTnCLMQ6PLi+jvlT97BnFeDD6EkMquVXRU2bpQU8vjqB+nqwIIvLIztwNYlVVLN6Vj
	 wrUJd6cP+j0IcBllKiqQhpoJc5jYTx18kj164lGGaUjP8VNqJD7KX3jA1EuZF2dYZTAog
	 Zg/9Rws2oT2/8/YsqCl/JtXT8dDqwjfWL7PIMXFPeX9+22ZWEJQnjm59T0dghiIgW+KCP
	 yubehqtt+UwJQyr8aKe5oIrAowtJ4JFW5drwdPh9TOCfSO121msJRnK8gJCiXNHJwc84c
	 6177l5qXNEApNI/k0eSOq6Xn0vndZHo0FM1mNXVrHxmoXi9StuRG7nnfjZIbwwvGLfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QdrW4y5V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA97606A327
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 21:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QdrW4y5V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DF91F000C5;
	Fri, 13 Nov 2026 21:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794605703;
	bh=U0prbtWZkGCz0Wz/ro1qP1+MPQ0O/VcplEKjhOl43iE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QdrW4y5VwQ4n5UVL5mVGLzUQQuGMeg6xREwFszLt8Vh/xOseJJuk5qPGbzSHOqKLw
	 Pv1C2R/RS8gpCuTqR8V1MVOZLmr4mfcFDxsHKf/wiW2zsCtbWISDQN4tGjlQuUjaXF
	 PARnLoa7who0CucqRiK36Emy1TUlxekUfyWsnMinAii8DkrEQF5iBuqVOgbYNzjGn6
	 Vk4E6U/A9BEvqtPIre4NMyMZs2ko+uow52km9lIXO0i7SO7qYMKvdTmDd7xjSixDB3
	 ezLgngaOCCYA0kDvpt7ygQhbAPBwXcTYJy+TfZCuQBMHegElv8YCSWQbBlP+5WMwhC
	 RH09INuvmCkVg==
Message-ID: <sashiko-outbox-213721@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v6 2/2] selftests: net: add a vhost-net test for the
 tun NAPI queue bound
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antonio Quartulli" <antonio@mandelbit.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113212237.1742984-3-antonio@mandelbit.com>
References: <20261113212237.1742984-1-antonio@mandelbit.com>
 <20261113212237.1742984-3-antonio@mandelbit.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:35:03 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Feed a tap device with IFF_NAPI from vhost-net with netdev_max_backlog
> set to 8, in the three ways vhost-net passes packets to tun: batches of
> XDP buffers, single packets with MSG_MORE and zerocopy buffers. Check
> that excess packets are dropped and counted, that the queue keeps
> draining and that every buffer comes back.
>=20
> The wrapper loads vhost_net and, if it can reload it, also runs the
> zerocopy variant with experimental_zcopytx=3D1.
>=20
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113212237.1742=
984-1-antonio@mandelbit.com?part=3D2

