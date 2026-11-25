Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623140;
	b=boBXYbyPhj3Xwt7KSAVrYPH9JOSZF5JnylJ4gSdyuJ/QXY0Rf967ityFI3evEOsmQM0L
	 KLiUARCWwrwWQVxG9nFpzZKG01qlYu1pvCFS/Ea4R/5qndkC4d/30kSROOheF4DFTFf/q
	 sxFmf+MhUNhAOFMcf/p9VDNAQPwLWHG5WvagoQen8584VtE/OvOnDGnfaBLzdDowroX73
	 po3EOBfKJQ1xgz4rqRek1Whfa2csK3G+Mqb70+6kaSzlABUQWG8u5dachrwVYWQcODLgY
	 5nhr/ifqWDuvhDBgcrAz4hUC5IjHGEHfNNVsbZJkxM2Fb00aYj0AzcST0xNqmD4Jamw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623140;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Uj3+Zb0y6mkfDiIzQtJJG9Mtb/ZPiPGBbhp2jXw7114=;
	b=PEdgjfI9LQSt8aocxaXYIV4uiH5baDvQb+2VPHzeu358QvCExRWEvSjloR9gsyRPqVg3
	 0Z6jv9JPjoC378H3NjbbzonJb8Vj/w5JAOhtoq8Z/w9Vxf6cf0BHZr/hmXaK+rtSBI3TI
	 XqA1E3GtMzuPvzPGlSwQ9X6MAqvDRH6+ydMa2RlyyCfcHlxkmMRjhm2NMUpjaPtPCiRLY
	 uMqwqzNQWWCuYkQTVTUhbJOe+LhXooeP/Q/ZLpA0o2XL8a22jHGLh91pVOfCzJUa1jv1w
	 PdRRK3U9CqRLHI0Q/XzAX/89vhZ9JAL+C3Cx44t6nGuX6NMF6pZ3wbxc191TiXTXVsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qtd9FKQN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC519606A31E
	for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qtd9FKQN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C75F1F000C0;
	Wed, 25 Nov 2026 16:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795623139;
	bh=Uj3+Zb0y6mkfDiIzQtJJG9Mtb/ZPiPGBbhp2jXw7114=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qtd9FKQN/r9v3Y9jKvBwqaVeV+Fr4iFuG+ug+z20YgfeTZomHgXdxRzo1JbdLjBw8
	 jV0Zwd3SMp+RWgAWAjJXZ6Xe8GWYWlnch977HiOydLDQyOLFZWagv8p9TGVQwxF/Ej
	 p/uiZ/V3gvJ00j+B32PH96xEtvcIRfBfGBi3aenWvDTywYWwHlbMg1oSvpNg7RuRTK
	 e8ppSWERHoPL17pO8GxYRHywxWP6TYj+h9W6UZIGg+c/qPbjr+RrxVXw1eF7VHQf+q
	 xMuqMT5vR4g7BPJbh0evLOf0U5vRccvTtRD7arydVYdUHwSWJPtOQZUVxY9MBpLFVa
	 WP67JUlDQd0pQ==
Message-ID: <sashiko-outbox-233722@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vduse: don't set VM_IO on the domain file mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: chenglong.ma <longpareto@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261125160128.796-1-longpareto@gmail.com>
References: <20261125160128.796-1-longpareto@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 16:12:18 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Commit bb2e6f166547 ("vduse: fix VA/PA confusion in the coherent page fau=
lt path")
> set VM_IO on the domain file mapping so that
> vhost_vdpa_va_map() would skip it. Since 99fd6bf43d5d, mm refuses VM_IO
> on mm-managed mappings: mmap() of the domain file fails with a
> WARN_ON_ONCE() and -EINVAL, which breaks VDUSE userspace.
>=20
> VDUSE is currently broken in 7.4 because of this. Please treat this as
> a hotfix for 7.4.
>=20
> VM_IO is not needed. vduse_domain_set_map() already rejects vhost-vdpa
> entries backed by the domain file, and the file check in
> vduse_domain_get_coherent_page() keeps any other entry from being
> translated as a physical address. A self-referencing mapping now
> reaches vduse_domain_set_map() and is refused with -EINVAL.
>=20
> Fixes: bb2e6f166547 ("vduse: fix VA/PA confusion in the coherent page fau=
lt path")
> Reported-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Closes: https://lore.kernel.org/r/awWOpS3HR_2FTN3I@gremlin
> Suggested-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: chenglong.ma <longpareto@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125160128.796-=
1-longpareto@gmail.com?part=3D1
