Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794905085;
	b=4JajUKkCPFkL3h6KrLmElIQ+WDfMlOZbVA51pfkTzHmP74j7vtNiklRsKIAH9fTfCc8x
	 CNTTu0xXrN1APR16aGsBgLS8Aqg/BPE+3nP08+HTsE7Mj4oD4t0IzniagkO4TplgKAQjK
	 PQqKhsK+2ljdAMd4FkYiuimoQIRp/ljHLtgHtWtG2yLEkjO1/tyF6qaKQC481xWbRn3a3
	 jmcd0ukD/CRDn8x2n9TXMVnGpVsX40EpMDmI4zrwPW9yCx+MAS+EqplUIeSmCc17yfYat
	 JS/nA7v7+07v740HzPiY03ezDiM3BSeTXsRx/ozppJjawvVmgFumK8U1FsR5LU+zgyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794905085;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=b3QRJ+BL48/xaIGf1IJNf8hWhctrAzcsCmPEau90ghc=;
	b=t17HI9trM/FmkxuKlbxADbhMTs/N0RQCsXqQh+XUUNyAgSVXfVVUJRQWOhkm6Dtv9MnG
	 p7VkDts6BEXT+EDfPpdSknskzxSggpNWqQWnB/Ckq92srWT3LrJa36rLm89IqIWuNqBL8
	 IqJcdzqBw/KxzNDXyYSAJgLRLEZOTJgDkCLM/hY3yF2exa3l3Z4MlyNeRnzX8oNyLgd/C
	 OM4SzXiPhi/7+BJ1LC4zDWygUNmNz/9iDgWgBKlhtz4LeyBFB6XkSqRM91C6we9mYrc52
	 JTm3f5puNW/eMXcN4P9/aHRhW5Ntsq11U/sjml+CYgw2PlRyFJviKX4N2iXAfGvsJnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mZN/QcYb";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A24606A8B0
	for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 08:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mZN/QcYb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5931F000D3;
	Tue, 17 Nov 2026 08:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794905085;
	bh=b3QRJ+BL48/xaIGf1IJNf8hWhctrAzcsCmPEau90ghc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mZN/QcYbWfNmqvXKjq3DkZwQkoZSXZoRHCyQi7lgG2fofAFwyGnSYMqrjYrxfKx2L
	 j1iEx6ohfVq4C+k54M/B8PHiDqkjZKa4dKmdIGh4HKfTrh2O/tY1AMx6orQyHOrwI9
	 3ij49kJ2yU2cQfpmekn/A2zg9C0NFxNwJL7sZkoyaXXV6lbaIRz0mWLmfkdg4f6ZPs
	 4f5wlqC/v3YS+0Xf5kU/h0hjdUU7pb5kQx/5fEU2OLYhZSde506Q2Xablra3mGNwsr
	 +yCO8PSTKWLoo3gHShjTsoVxEOotaDtGYyDHcr7t3HxzI27QdsJvYPvEoH0OR+q4K3
	 91thg2sBou1vQ==
Message-ID: <sashiko-outbox-218428@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] tools/virtio: add a vhost dirty log test
Reply-To: sashiko-reviews@lists.linux.dev
To: zhaoguohan@kylinos.cn
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261117083323.89502-3-zhaoguohan@kylinos.cn>
References: <20261117083323.89502-1-zhaoguohan@kylinos.cn>
 <20261117083323.89502-3-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 08:44:44 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Khan Zhao <zhaoguohan@kylinos.cn>
>=20
> Add vhost_log_test, which exercises used-ring dirty logging through the
> existing vhost_test module. It sets a log base with VHOST_SET_LOG_BASE,
> enables VHOST_VRING_F_LOG on the ring, submits descriptors and checks
> the resulting bitmap from userspace. No new kernel interface is needed.
>=20
> The test covers:
>=20
>  - every bit in a byte, repeated sets, and neighbouring bytes being left
>    untouched, including the last byte of a page followed by a PROT_NONE
>    guard page
>  - a used ring write that spans two log pages, with both bits in the
>    same bitmap byte and in adjacent bytes
>  - a log page that has not been faulted in yet, read-only, PROT_NONE
> [ ... ]
> A --bench mode reports ns per descriptor with logging disabled and
> enabled. vhost_log_test.rst describes how to build and run the test.
>=20
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Khan Zhao <zhaoguohan@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117083323.8950=
2-1-zhaoguohan@kylinos.cn?part=3D2

