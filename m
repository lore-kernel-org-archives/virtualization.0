Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794183893;
	b=ZVqPo4WZ2IescFeHSTsmk3L100Mq7+x2Xhd1ljbcaTQfcURNt+y4D2cgo35xAlZw8Uuf
	 A7fIHfHfhtJoGvqsodgHdwVfkRQapFbp69nKQzCJ62SncMiMUHY2Td0A3O8p8LVxhLr3z
	 b2FnimHNHNB5PQehn9YkMTi/vQmiDhGWVSLfJ/sWdWSvh2ZiAt9D1o8i9ZmappqgMGf5p
	 lL7GKpEsxhQWQCoME8F0/GymWVwfms4ru6XC7NmUs3UFa6QtpsgqhZv0zc2UlXwuHT838
	 cbBKGWHDArUfTJsWm+Qt2SKm560AmL+DH0wW+zFuQ4DLZGaYLQrV0K3QLpjMKGXEEVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794183893;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+f9t/zR6ZhnDZAwvpcCWc/qxMP97x7b17DJBquI9qi8=;
	b=ABCwCUfhsF5RpYcbWLzVhExQO7IBjBeoDy01hNdlG8UdFcIqk0K8+RiMui3UzvGLdoHh
	 0a6YWuKy6OdL+7xrFumKHz/fY586mDV7rhFGNZyGVYYuusqY6Gbm+ifBfbLWqpStrxoAk
	 wzdJdXExENKv4X/fhdOZcK2jMTNHkAt+G6aw99U3tChJmEz8Xg+wMqQKdJZE6dlON5XVE
	 JYwbYhd373RBVUDhV6AJ6I+72ElIoeyRHkMRuY5L5jOKaSAooMyfcaoXR1VJZwsVDg+MZ
	 M85buC6WbpZnYRNG8EyQCuqzfMSNsuzlgfZOFrR9diKPDcPTqagdJd9p+KmQJEfEwNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b9Huygmg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AA2606A31C
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 00:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b9Huygmg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F33A1F0089F;
	Mon,  9 Nov 2026 00:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794183893;
	bh=+f9t/zR6ZhnDZAwvpcCWc/qxMP97x7b17DJBquI9qi8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b9HuygmgFyr8No6V9dvMl7f5LxqH6/Gdn74S043dibTX12pz2++yCdG7Uc/PROCgG
	 IoywpGDvYdeepzSfkxopUOidOKdhW5ZSunEVvpJlVWZSEsMhT4wHPsQwh8KDmLue+l
	 Y13KJMsuHwtO9zXa5QKhh7LvHv1wXs7XKe3dVa0MN4DKiSv18wJEW6EGV0rVna3vC0
	 GVGASurE+R6wJbu6FzZOWqwXQOA2QVaNdtt4/YNyhC9JotLHvv6i8gGIV0G4J/1/aZ
	 GiJ54oYQYgCGiUmp1iTo0bTlXAcalNzH6WIcN99Zp065hQ5NTXI+sIlODfadBY/01R
	 1t9bJvQFowMgQ==
Message-ID: <sashiko-outbox-204209@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 05/12] ALSA: virtio: Recover PCM state after a
 failed start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261108235457.12688-6-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261108235457.12688-6-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 00:24:52 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Capture trigger queues I/O messages before PCM_START. If the START
> message cannot be allocated or sent, transfers may remain queued, and
> ALSA does not invoke the action undo callback for the failed trigger.
>=20
> Mark the stream stopped and disable transfers for every failed START
> path. Arm runtime->stop_operating so sync_stop releases pending I/O and
> prevents prepare, hw_params, or START retries until release succeeds.
>=20
> The stopped flag is shared with ACK callbacks that can run without the
> ALSA stream lock. Protect every stopped access with vss->lock. Read the
> pending message count under the same lock in open and hw_params. In
> sync_stop, decide whether RELEASE is needed and mark the stream stopped
> in one locked transition; leave it stopped when release or draining
> fails.
>=20
> Always cancel elapsed-period work in sync_stop, even when no RELEASE is
> needed.
>=20
> Record the RELEASE obligation after successful PREPARE and clear it as
> soon as RELEASE succeeds. If the subsequent RX wait fails, retry that
> wait without submitting RELEASE again.
>=20
> Fixes: da76e9f3e43a ("ALSA: virtio: PCM substream operators")
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108235457.1268=
8-1-mynameisjune111@gmail.com?part=3D5

