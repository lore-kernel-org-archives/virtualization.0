Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562692;
	b=LEwi84DsRnUQtHXvb1ImPcenmoSbaxF7T+GJC9/yFKxGC+534dSYjxx00pG/YwpdONTS
	 oNNMrq8rzJZHNzgOBGGLzcbadYbuJzK03c5502Jq5D3cs7IE4YHJFm9a20naM+QUU/8d+
	 8w7WXk0HUcgj69gZEF5QOSWue/kvkvpt5ls1t1nAgxqTc4YwSvoqZw44txdS9taKwpY0s
	 3Eu7t1/YbM+nQ5e+X11ykdsKq06Kl6IR50rkYb9Kgo4kUct6n1hS4qcJIl0MoWLy14N8f
	 FKLS1fcybnDrbo/nNBtX5C2YJ4JC1wDCjphL19HxWXjRJu6owAxFOyjxikzlWRIvk8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562692;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=G2A9VfIkpTA3vBXHcvkDA1NIGlcbL9GvGE3RD1cEAUE=;
	b=l01u9tHsk+3PCCABFAb/VduF3iMVHqLt/3yzfXhDHlfhwa6Ts4hSPYVPeikn3Z0IrSJ9
	 ta73gMnuL88iUKWx4g5oh1Z414xQWJPy8Ih8bSjyaM7zVlICkfT8nXwdTn+jUd4GZGqHo
	 NRjb2UoVJZ+WTML15+bVbbiQwtcVja2YDbLtshOKTOQOBdRAlEonCpX0HHUc53UnyH7Iu
	 8F/Su5/d54wBmSGB/cYoJgQo+Nxqh6Z8tYQs7MmdQFJ7Jk4Ftdkw/wOX5VP6s8Rs30MXR
	 +RCQBxNEvMyUYGSQVmQ7G1wuTMD51Ci4fp09AXP89sxq+CxeyWKdZtc6P/fPPKTwFbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lizcBnZv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB815606A31C
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lizcBnZv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061C81F000C4;
	Fri, 13 Nov 2026 09:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794562692;
	bh=G2A9VfIkpTA3vBXHcvkDA1NIGlcbL9GvGE3RD1cEAUE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lizcBnZvOpV1sbkdVjdG1iNqVbUASawaNd05UPANvq+D6Spzm+SX0TsG85Fg1rlk0
	 Xwbr8Mg8HDvNqrwqSOhtZX9gNbgE9xX2OL47p3+PFtMfo99wATiZe99YMoCTqYcQSs
	 yuGyIxzz7hHs5SOtfIvgXXNfPhfDNDy229t7k794/zVLSUCSgofXSvkpBQDNb7yCc6
	 yZX2L+YBBTK7wjMxTMMXsvN0A+oRhoWgV44xeVYa7rYDGRiejD7zkImFo4viyklCQ6
	 x6KlPgaoNpmOt3b94oKxHtsFyklsnlKbbCP/xreMCHi+Yd1QeyB+iPD8PTAnn380Qj
	 boMDXRmsn/l8w==
Message-ID: <sashiko-outbox-212559@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v33 11/18] ALSA: virtio: wait through signals for PCM
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v33-11-13a934ad5ece@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v33-11-13a934ad5ece@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 09:38:11 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Joonho Lee <mynameisjune111@gmail.com>
>=20
> A signal can end the interruptible wait while a STOP or RELEASE request
> is still pending. A later teardown may then submit another RELEASE
> before the first request completes.
>=20
> Keep both waits non-interruptible and use the existing message timeout.
> Other control requests remain interruptible. Device reset still cancels
> the pending request and wakes the waiter.
>=20
> Keep timeout and wait results in the types returned by the kernel wait
> APIs.
>=20
> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v33-0-13a934ad5ece@gmail.com?part=3D11

