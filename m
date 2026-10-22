Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792631784;
	b=sl8zKwvutd9RZaH67mGMek/hmuSL0vIP9Uz+/YSDXmziTk468HbgxTNf2zVIFeFHHEC/
	 ZF0pIrnkUoXefHS+ATL40MNGwDOGGxJV8woYh0rLUqFBkjYEIrI88+ZHIYnb2Ev346bXZ
	 ljYaBgxv0l9jZCA0HjHVXu3MH4nIVhgsxzEZ3FRyHvKzorKEwXBdsIDIt6/7ncMz4IOMV
	 fX05tHmxrmOJqfrJf7Ce2QcK6fFxyesCoQneEpFNvsh3WzwkaI9pBKqIIXXnPym+kZVim
	 tnhXSyQOZW6kSykLlilGYQQvhMPFM0+9gFzKCuyD21uQflqt3cMOap48eQBzeZurf5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792631784;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WhM3q0voj0miiCIXJQ0DBWe11LncZNP77aWygqyBHls=;
	b=f8BTERrKFRS/zB23xBN8kBOuEly/YREXwsjkvwgHQANXW0839310k4FXGutiC0kiKENP
	 XvRsT0Rdwv3WaCHcqgSNVe26X0G4DuL6SL75GyqfIDbys9cLlPAufNutb5x5Pb+QqaOnK
	 6faMWu2wOxYIx8qFhzD9LxmekMgYX/Ea2xTNzaIC9AemlBFNy4mkcdWpGi9xrx7tcDIzf
	 JF+uRhBU+2nr5t8xevZ4PETyoSTnKD0hP3LCVcvlN5dLEt6cBxFB3ynT33xay7kDuL8i8
	 2YAvx+lmll4WsG+kb2V5yyV7pp2+LFkaeCQeoxQpd3DqWgrqKLdtid87ly48CqjKpjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OVApsHJM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AE5606A31E
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 01:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OVApsHJM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473381F000C1;
	Thu, 22 Oct 2026 01:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792631783;
	bh=WhM3q0voj0miiCIXJQ0DBWe11LncZNP77aWygqyBHls=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OVApsHJM4OY92NyoFpohlLsXPZ8alwWZJvT42JtEuo9Rft7sUFrFfF7t2dDXP4yE9
	 vWkGLZiOiIRUCNN4BJEdk0IWizyrveGT9nqjm/RmlocRUVYX5YRt5N5f0LtyPbBTFa
	 h72h0ceBuHAjzYf9Ba1vRhlPjezRWnnJzZIhe2xWw1j/BBVlRYmy3k1zzJYSvjTgAW
	 hYswWUX2BWF9lowrOUtcgKftcBUedvzS6cvT2xkoXCL6QFsIE+rO4suwY++gbdQE1h
	 5AvcJFk434A3pO5JVi/q4NFNYOnNUGES6TtSqA+r2/vXboyPjfMyiGvBG2ZTDY4GCQ
	 kg6r0mUC12i6A==
Message-ID: <sashiko-outbox-180843@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 6/7] selftests/vsock: test the guest vsock
 device network namespace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261020-vsock-guest-ns-v4-6-047527cfccfc@meta.com>
References: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
 <20261020-vsock-guest-ns-v4-6-047527cfccfc@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 01:16:22 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Add tests for guest vsock device namespace assignment, including ns
> destruction and the device moving between namespaces.
>=20
> The tests drive the device through ynl's cli.py and create guest
> namespaces with unshare, so they need python3, PyYAML and unshare. A
> missing one skips only these tests, not the whole script.
>=20
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020-vsock-gues=
t-ns-v4-0-047527cfccfc@meta.com?part=3D6

