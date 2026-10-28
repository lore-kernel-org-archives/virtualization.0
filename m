Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156440;
	b=kfPUL2YZqHlYe/EhpDQuP9xJ75hTc8ES0GYiPg+v6ZCk60SfWewQLU5V3wrmQR3CgPXm
	 fz6tLBs63rO/0oApEBO/EBT3LLXpcQNU62NJM1M41XGSgpa4bKaZ0FGhmozR8sobkXMG3
	 QU1VBc+y3EzNwrn0bLnyjeyoAqgeKm8sgWVNTYBJXz/aVrdfvW2ld12lKn1nBnEHsrVMP
	 NaQriW67uumN69129tjo3Sstp5Os2sqe0z+N/U6gqsRyQohBTPomdEgYxD/a8EN31IMY0
	 72D8bPiXxciwXSVCQ5L0HylTKzkafqIKiVuYQXPv7hltsHT70pJKnPIB89sQeMAVaiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156440;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3gM60uQFA1cVB45kngf04dg/qUWK7eBZRDClemfM4Jc=;
	b=ya7U0k8gwuYIsvK+qHB3owWCARWLO7W+NjknHlbjkbUgQFH0B36GGrZaLvwPngCTGpXI
	 mB2ivn14aiyav6p2Wc58PWei3lK8RgpA2Ujg0sdiBlS4YQLH8veFGCRoqUKkC5+qEBk31
	 BZ+70DRErN1JibGsn8qQpwwLDoYN5F9tTy9mDJ8OzKDBWnjAAB5kwdqgx0du+fGjaIWQn
	 DjjAHMT7ckbzKg+H8vT8YClA0W483K/kvflgGgl58/JyRhS8+8pSE/Yzzaep9aecnJ+Qm
	 50xlhuuj5xC4XK8db0HIsQB7iD3kfLI9VlptTHwKl7m67wwCrLD/CfZNY9xlJPMVGVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HdF3SfkT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955C1606A31E
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 03:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HdF3SfkT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27231F01825;
	Wed, 28 Oct 2026 03:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793156440;
	bh=3gM60uQFA1cVB45kngf04dg/qUWK7eBZRDClemfM4Jc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HdF3SfkTAZBS6eDfwy9MyJAXipLBhLSYymkig6pRidCME1eUcrBFYKB2TGiRAM+xa
	 VvnFwARBXE6iWL9gpPtC1q1Evg7NqBsUQEzJbvHzA/56l7bFnyol8NFMwLBL+ymKaN
	 W+cDElOnCRJfIsmSWDU5noB4zRAqFZbw9aeuvWk0XlzxePArv56TVIIM4n1UH6ydg/
	 f8aOP5vjtNIF+9E8tDgntA9inlu+V/UClvLrNpkiq7RI+SZxyG02OxgMa5GvgfFja2
	 0ei/26oMVqC/u+0QXRxWx7lax5mH+HOWXEY6XUipp8e/X7U3v48P+sTvNLQBYalqIf
	 PxFIyo+Kgp4mA==
Message-ID: <sashiko-outbox-187370@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/14] ALSA: virtio: prioritize staged capture period
 work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028025317.92450-10-mynameisjune111@gmail.com>
References: <20261028025317.92450-1-mynameisjune111@gmail.com>
 <20261028025317.92450-10-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:00:39 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> CPU contention can delay staged capture period notifications while RX
> completions continue filling the unread ring. In a two-vCPU VZ guest with
> 16 nice-0 CPU workers, the ACK-fixed baseline stopped with ring_capacity
> and EPIPE in three runs, after 11.74, 30.77 and 30.33 seconds of audio.
>=20
> Route staged capture period work through system_highpri_wq with a common
> helper at all ten producers, including ACK errors and self-requeue. Keep
> playback and non-staged streams on the normal workqueue. Initialization,
> cancellation, buffer geometry and capture accounting remain unchanged.
>=20
> With the same kernel, input, geometry and userspace priority, the candida=
te
> completed three 70-second captures and immediate reopens. Its maximum
> matched queue-to-start delay was 20.366 ms, versus 108.112 ms in the first
> baseline failure. The other baseline failures had pending work without
> matching execution, so matched-only statistics do not bound that delay.
>=20
> Reader scheduling delays were also present. Both arms passed a separate
> nice -10 reader control, and host load varied between runs. These results
> support the change for the tested workload without isolating a kernel-only
> cause or guaranteeing lossless capture under arbitrary CPU load.
> KASAN/lockdep QEMU regressions passed with the unchanged candidate source.
>=20
> This follows the staged ACK fix and pending VZ capture support. The
> introducing staged-capture patch has no upstream Fixes commit ID yet.
>=20
> Link: https://lore.kernel.org/all/rfc-v2-vz-capture-compat-1.b9ab4c1540dc=
4691@gmail.com/
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028025317.9245=
0-1-mynameisjune111@gmail.com?part=3D9

