Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793785882;
	b=gZbAw/aLV3TtFyHdCLXS8d1v/GmwT4Nct7H7t/09cZVUCU4DiQ2FOCsJPhjApHPpNC6U
	 WTuLwvcSNeGxq6eQ7XGQSTtXjPacOfagL0vtuNmcEJVKCpYhy4s1LKY1gFQwd0Qf6t/F7
	 vymfzGZ+2tj+uWafVYnnHzIKx7kxFwLBGjHvfOqz0+Y6JKy/7o1EEEbJKp10z2Kp62FeS
	 iP7C5B283mqUKPi7DUpV0NY4AWiAlpR+ULQVkhv6Bv6QWxK6xmlSKtHQO5JwrVLZJGNxv
	 N2SfmK429vrFwRI9YAW7ZSZBhdFXPT3hPk5nCtXoqyEdVdFf48mzAOXR+MnzzBvvrJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785882;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JCg/WNPluj/7uEdOAn/L09MHH1iUxX2rdWlISIPWBCw=;
	b=rpTCw2XvRAd7leRsf/DeSQC5AIuHQ9uriSsm3ddqUpYoww1hp3ZaB6dIsTUHSvAsQ8Zz
	 LjueVMHO2lQZ6fdgWYcGswfS5HLgOxtJ997Q10HGXj/lG5ZeGlZoeA/IK2ofV2KPu5wvt
	 BdLGNBxxzdL8pHSq7ryBdfb52vXHszyyqbjfVNkzYdB5BmFQbWHvHBISqvJI4GKtE6PWK
	 rkZh+OkNc5do/++QR+PzrSI55kzTq/bvNqeXi151SQsBrnEyAGQQStpNzlzGZGvaQvssi
	 qz3xNJvkY5cdLo+4vkPAQ9WcyOfTkR3oE71XKsCXtzdq38h4/Ar8v0EUE/UTgrotJ6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gnzXgX81;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32DE606A332
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 09:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gnzXgX81
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451F81F00919;
	Wed,  4 Nov 2026 09:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793785881;
	bh=JCg/WNPluj/7uEdOAn/L09MHH1iUxX2rdWlISIPWBCw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gnzXgX81teB4dn6IaOUOoqcq5/rNF3yaGMSJUX1qWsnE+B9DMTBYoCdLuBEvIt4p0
	 /jcYwvnZsg9y+YjtlFQsc9Mhj7eP1JYnNR3W9v60ZAKZyH4iQ6ZnRsmyvTqN7dI8io
	 lPib75t8huaVYv9jeyyuK3rSjr57bKNQg8jAfzoHJ/HoAiY+PG6u5Lt8hfCPzEHgwJ
	 7shsH5Hrh3LrE/pMzFKgGOeWMk0e+EVEqfn5VUYWJUrxbv9nt05gBCDPrrEJKLl9W6
	 1S2Oen4/BxuPmx75aYxsOjY9HOX2iJCwQUec3BVenvofVaG2ZpRk4yFogeszn3jciZ
	 ReNgOmg1zWbgw==
Message-ID: <sashiko-outbox-197000@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/6] mm/memory_hotplug: add and export
 mhp_memmap_on_memory_nr_pages()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nikolaos Karaolidis" <nick@karaolidis.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103-virtio-mem-memmap-v1-1-308ae1da6240@karaolidis.com>
References: <20261103-virtio-mem-memmap-v1-0-308ae1da6240@karaolidis.com>
 <20261103-virtio-mem-memmap-v1-1-308ae1da6240@karaolidis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 09:51:20 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> virtio-mem wants to add memory with MHP_MEMMAP_ON_MEMORY. It has to
> know at probe time how many pages at the start of each memory block
> will host the memmap. Those pages never reach the buddy, so they must
> not be fake-offlined, and in Sub Block Mode they must stay plugged while
> the memory block is added.
>=20
> memory_block_memmap_on_memory_pages() returns a non-zero value even if
> the core would ignore MHP_MEMMAP_ON_MEMORY, and recomputing the value in
> the driver would duplicate the padding of
> "memory_hotplug.memmap_on_memory=3Dforce". Add a helper that returns the
> number of memmap pages, or 0 if the flag would be ignored. Both inputs
> are fixed after boot.
>=20
> Assisted-by: LLM
> Signed-off-by: Nikolaos Karaolidis <nick@karaolidis.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-virtio-mem=
-memmap-v1-0-308ae1da6240@karaolidis.com?part=3D1

