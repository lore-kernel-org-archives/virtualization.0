Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368321;
	b=EJwO/auE47+FSvt4cjdw1oPd5gWF5o44wKcx7nO//xd86l2OdC1ExLFtweGY0Ai9w74s
	 ZvnAkITqJwo14T/8yiYiKCnb2M6Pq0X0kONB0Z2aXNuC1IgaUZ5le7LK093WLIwRdD4+t
	 Z8fJDzitDEVJURRuyEwX/nuVobo0BB+OIvcc2k6GByUitdoN9HKaTG7TgvocMKNmt5Kjr
	 f5Yu5TzvAHjJ5BxCF6dIAy7uiRCJQwykR22CdFRifcYolGzQt+jNl9faY4OMMFD0Bd+Ga
	 og76Sj5C6hSe5x54lCQsxECtyaKkbcOtc/vyN/+QuOdQXNsvRT+0nSZ83C61cpg5ZzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368321;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=coybdoEQ88ameE0ceDNsXhIwIodQdFqYk0frDyVQKtQ=;
	b=zKq4TYhsK5IYU242wmPaYk+M7J1ASNTCHs3PlSEb4OXgjkv7hvvgJvX5sDZj3uQBhH/e
	 mRNFWSk0Bobkaoect9oD39gRECHiqh5cbHjRZXwc0X/uL1L6I1fqRMjr2Gq205Td6aGTb
	 ja++JQ4qHvfk/hutbG27ira71myW0BpFKheUmzX69sO2m3R6opDUaWCNJ9HgxTC/Jh/xl
	 TA/ELE3cEjCIKbDj+lbx7QLt/mG45zC1AzMJ4ViW8EyBAs/s8qZR3Wv1KxFkLkEMx2oYg
	 xjEZdX5tgihoOM/YyOZLQ2EHZPWO3BCNTNEPOXflPN5Oz0+e4p2ykPQ1lXRnxn4gHXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QouOqcst;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571F3606A320
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 03:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QouOqcst
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F971F0089F;
	Wed, 11 Nov 2026 03:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794368321;
	bh=coybdoEQ88ameE0ceDNsXhIwIodQdFqYk0frDyVQKtQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QouOqcst1VwcaGLu7qjqi6buZl+iRcV0JIHclrWrrcdOjOv4y7cQy8MfNrkbvAh1I
	 593Dd+sjl2p3xQNQvTQopPICxpjQo9jiqR56FDhIA9skWBDyCEmVFdoXQhknwpbj4x
	 aWtaPgEmKZ6VaL6kHKgoNIPj3Ga6QGsWUQ4FRpmxSldomvcz1sULKtlpDNtJIBxBpl
	 A7nc5/THBGcEYf37PYp7N22NRM+NvS/xx2VXeY5wV/rEq3xiLg7NbBk8Go8OTF5cjd
	 OVeWy+2KNfEaaa1Ikwyi4oVSA+I5Gm1sQrjdkgX1Ilwd0NmY2G+2zmvt3yUGHPnHRk
	 Kc3N9OrsbngRQ==
Message-ID: <sashiko-outbox-208209@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v25 03/16] ALSA: pcm: add an optional reset operation
 under the stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111025655.63951-4-mynameisjune111@gmail.com>
References: <20261111025655.63951-1-mynameisjune111@gmail.com>
 <20261111025655.63951-4-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 03:38:40 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A driver may need to synchronize private capture accounting with the
> common RESET pointer observation and the core's position rebase.
>=20
> Add an optional reset operation called under the member's stream lock.
> Expose snd_pcm_lib_reset() so the callback can retain common pointer and
> time handling. On zero return the core completes that member's rebase
> before unlocking it. Drivers without the callback retain the ioctl path.
> The operation is also used after a successful prepare.
>=20
> Zero permits the position rebase; it does not promise XRUN recovery. A
> negative return skips the core rebase, so a callback returning an error
> must leave coherent pointer state even after partial work.
>=20
> Linked RESET and prepare stop at the first error without rollback.
> Earlier callback members may already have completed. Legacy members keep
> the existing post_action policy. Applications must recover the group
> after partial failure before relying on shared positions.
>=20
> This adds an internal kernel operation and no userspace ioctl or layout.
> Out-of-tree modules using snd_pcm_ops need to be rebuilt.
>=20
> Complete appl_ptr rebasing once in the callback path. A later linked
> member can sleep in prepare while the earlier member accepts SYNC_PTR; a
> subsequent unlocked post_prepare assignment would overwrite that
> acknowledgment. Keep explicit RESET playback silence processing and
> leave prepare-time filling to the normal START path, preserving samples
> written and rewound after prepare.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111025655.6395=
1-1-mynameisjune111@gmail.com?part=3D3

