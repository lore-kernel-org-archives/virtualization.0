Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590002;
	b=tzTbf09k1EgO52xXOZIJsyXrNasWjReBSrUSLbJ7E9rEKtZIL+Z1amzr7Tjo+FxPegVk
	 JqcHocT/kzUR5gjXBPoZYQzmjJhZupd7X5akVmoK5hebVJMBnR4+R5iMTyymsHG1/031f
	 ZNleXzZ4uVVpYFrVBzQMMDtmogaHOHyCYTd32Hm5mm/KEVlVRii5ohNw4E0rkVM2rl3l1
	 Ah8yGSiEEmX9fQJxiAtnoLzHYq5V1v3uJ6g0eQs5jtuyfnvC0f2qbWqg7UA0OtEZHPvVe
	 4hlEOlhO7uwCpvUzsHPR/IUxZZAz2OYfchliprZF31VnntsBEPNeravQskN9acvqOqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590002;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SB+ftxygcy63k/nZHBcqw7BnrJ0y0/MLiVb+YsbfEDI=;
	b=TdB7dlOW+JfMgFy0rSm1RwA9pPhKJgAMVnY1omxv9aI7H3eV/UJzu+Yh2W1aT5/oKTxL
	 YEokNleJ2mOTZMtb2wo6ZcIU/FGh0oc80NVI59hi2nMZcblqV/nGeKuey2BRPdofDJXlb
	 fEplwGrwUe+8g2COnH96HMh7AyLgHq6Kz35ETlNxjA8UjTa3tkQc34hx/IvGI7aQ3Bvk0
	 KNu1cia/MNbmg/qqrx7IC+2HFxewaRpSqlB8EHobwRt+b9bsBKwdzDePQ5bNUA72Yic55
	 CAVoEoJszWDZDryOGfSkC1k6mxNjaNdqDarjzHQtEAiLFaHxlzkMOJb0i0dAPJxsJLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h60bx021;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAED606A330
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h60bx021
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C0F1F000C7;
	Fri, 13 Nov 2026 17:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794590001;
	bh=SB+ftxygcy63k/nZHBcqw7BnrJ0y0/MLiVb+YsbfEDI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h60bx021Ffu44pF9wc0Lt+FXeZirAPlVz7hFI2EEbV8U3ylCKDX5HCxi1aPkYrZk4
	 /EV2IAXJ5PTjSavrBq61OTel76lWoZs4uNzk0r3SP4pZDLTq6qryQ+Z6uUTSAKsDl8
	 ZLmP4K3nguhrSDy7XfRFUUrt1ZcjQX46TXMxyqhVEJ0meIZINUHg3KxkRa+fFncIFN
	 exsBeCT1eqhjXwbA2wKIVL1St9a7CmcJoYArVUMYFsGayGHKJZdWkXCYymKgyK/aDP
	 JQDpPERY4UTl8Hep66tSrYIAE5V8kproTu3Ey3unZfUC+JO2hJGaqmTIsrEvkRPjKM
	 aPxbmYZK+KJbw==
Message-ID: <sashiko-outbox-213284@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vsock/vmci: reject datagram binds in local network
 namespaces
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-vsock-vmci-netns-isolation-v1-1-ced02054ea61@redhat.com>
References: <20261113-vsock-vmci-netns-isolation-v1-1-ced02054ea61@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:13:21 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> VMCI already rejects datagram sends from local network namespaces, but a
> datagram bind still creates a receive handle in VMCI's global port space.
> A VMCI sender outside the namespace can therefore deliver to the local
> socket. Its handle also prevents a global-namespace socket from binding
> the same port.
>=20
> Reject VMCI datagram binds in local namespaces. No namespace-local
> datagram transport exists, so EOPNOTSUPP reflects the available receive
> paths. The receive callback also rejects any local-mode socket as a
> defensive check.
>=20
> In a KASAN/lockdep QEMU guest, a reproducer observed cross-namespace
> delivery and the global port collision before the fix. After the fix,
> local bind returns EOPNOTSUPP, the global bind succeeds, and a global
> VMCI datagram still reaches the global socket.
>=20
> Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/sashiko-outbox-212907@kernel.org/
> Signed-off-by: Sergio Lopez <slp@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-vsock-vmci=
-netns-isolation-v1-1-ced02054ea61@redhat.com?part=3D1

