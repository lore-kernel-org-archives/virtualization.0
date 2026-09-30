Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0758F318146
	for <virtualization@lists.linux.dev>; Wed, 30 Sep 2026 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790757234; cv=none; b=VIof2zZ/pLrPCSQyBUCh06eZQCEpKaId8+CV6ZovYvJteLuRWNSBwTPEZ70nQhgfkj8yzLPFZzeZbPnCohKB7iYySNnGIXw3PHxQlXwBOUjRdMg0Q0i1qQpetKc4snIUgeuakFPK8BxOIa4xRODz/YIFH2y7pKK4pk7enXGJfA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790757234; c=relaxed/simple;
	bh=767v94DE+/CIpg4TTWZLPageSIx4FUk2elY5DlLuozQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DutpGoi3ZFRJ6JIF62TSV3Zko2aBrZJ3WSftfcCPTEpd72yobEuIVny+47NWfpN/QGBnKFnWqJmXWi6jXxth7C8JRO7+l4w/NDM6uivzwyav3MLGrg9Psaj2fG3ViTQcDKT7Yi4o7TLvdDY31DZO+gB7Is/5SnB2DOKssnVZTu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGMqpvzt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGMqpvzt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A761F00898;
	Wed, 30 Sep 2026 08:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790757225;
	bh=W8HLs5UFEVcVfLbh0bMfosM7TmA2t1iCjofMhPvhgfI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jGMqpvztbbeX0orEslr8GLyQO/VbTlpiKOdAqKU3Q4XPBUtM7MUCCz0NQApadx+qj
	 J58XgkHEhMdSoZRJjDJeDXgbakOA70estLmQQvGrkb2zpEqX8QyqCOwDo7jHHFdT1S
	 hobokkPBVHxhcOp5BmMXIRD/w3R9iZXrHA4aHcBiJe5vrmUuKvR1j00vtvp8an6L0F
	 IrdTRo+iXUh8SBQNQBvJqcKT2E5cvjrXt8IN4ElrK12q8Bh7LIf4sxnKb5sHmNrBvU
	 2xw0/xGVPPOVmAZ2U7HuCk0OoBnEVfGRCEqa7gYoU3djx6iHjJhnEZ9ZgCRmvKRkUl
	 IZzMuCjlEQ3RQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] virtio-net: unwind VQs when irq moderation init
 fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jianlin Shi" <shijianlin11@foxmail.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <4e21386a0840526578eac3dd10443758bf3b84e2.1790751008.git.shijianlin11@foxmail.com>
References: <cover.1790751008.git.shijianlin11@foxmail.com>
 <4e21386a0840526578eac3dd10443758bf3b84e2.1790751008.git.shijianlin11@foxmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 08:33:45 +0000
Message-Id: <20260930083345.A8A761F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> virtnet_probe() calls init_vqs() before virtnet_init_irq_moder().
> The failure path used "goto free", which only calls free_netdev() and
> skips virtio_reset_device() and virtnet_del_vqs().  The virtqueues and
> their DMA mappings leak.
>=20
> Use the existing free_irq_moder label, as virtnet_create_page_pools()
> already does.  This is safe only after net_dim_init_irq_moder() clears
> dev->irq_moder on failure; otherwise virtnet_free_irq_moder() would
> free the dangling pointer.
>=20
> Fixes: dcb67f6a9ead6 ("virtio-net: support dim profile fine-tuning")
> Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790751008.gi=
t.shijianlin11@foxmail.com?part=3D2

