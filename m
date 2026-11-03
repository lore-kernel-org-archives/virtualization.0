Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690811;
	b=BHxPonwLWdqWudgC6q9Y3qp8EHxuf13QmO26/3ufWltfQLmEWItUNAnUbf5I7Ggfq1Ob
	 a4gr+091Wr/alDfzDR1+dxRA9BsQxiSDNKoeuM6rw39nNrwBXefHQxHjrubTvOK8SP3jd
	 fC9P161ZLp8/LL7ZitHDdyNTOkgMlOiSN+XKNvF/YyZM3dsCUaKd5s2ThDAP1cVe2d7iF
	 H9JTTZHhHJK8N79ybpEbYef//msvZIiKn7eoVxoCexn7IY2dsKTm9BJUnVs7YWc1mnYWF
	 xkU2qxvFbuNdeQn678gftMEtAvwEUmalTZJFgDalhLpNFEuALODrEkOOgw/iC89eWKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690811;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xeOz21GdoCPeNpFUEa0jl7zrHso+M35UQy/LYSv6XQw=;
	b=DBiRFGj2D+xxPlZYdDtdTKXvegXltYrK4/XkdiHXgjHU7iCnXWYWmGoviJqA8E9uGFje
	 +pTKNKw7yPUjQ6ip/2fdyebGm6SvSNKXjBKOjuHGyeFPhxQ5m3qPr1Uqlqv+Ow4gIc50V
	 Pbcozq7y/4av/yWq2hNMoDjildJtdelFZXml0L7i58lTDrjBi+FPTqzAGSk+GSHgaXty0
	 YPDGxdDK3FiemUyt+kpvTmRQJQdJXc4lprWIFxX7ufv+6lbzDHaUHKZzmibLpxDFPdxeF
	 /z6sFgNkg6d/Ok/3UWGgfD25rJ5lHgY0OIVjFPYmJOD1Yj05fWgJBeQf5jmKWv0lbDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QTD6kFzA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A62D606A32D
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 07:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QTD6kFzA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23C61F0093A;
	Tue,  3 Nov 2026 07:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793690811;
	bh=xeOz21GdoCPeNpFUEa0jl7zrHso+M35UQy/LYSv6XQw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QTD6kFzAZoIms2OBB3QqQIxiFMoqGL5+0fesPl0sDuXrAqrs+HZaqey5Ap+PplOdF
	 9ta3WXO8mg92nxQcpk/0tQyORTB/sGUO6Pgs3w39iA6aqAX6FyG0dsIo2/S+aHk7Z3
	 paKAULeg47Ysw2fxIng1k7sBAgUDCJv3W0Due41f2N/n8gf/93Zn8rZwH7pMTyeu2q
	 SQYL/9E4RVcuRWiLEUar+JuLpSltMewgOTmQ4FZtxSbyXIr3AyJiWbiBUGvk1QtPcU
	 Rk+y/IplD+MBxD72CFDq9HyDDfu6yu46ognY3iXpQkFJdbGtgvaYZj2YUgEw8VfZfO
	 OlwhJAW5RFLvQ==
Message-ID: <sashiko-outbox-194710@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/1] x86/vmware: Allocate shared storage for
 steal-time counters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zack Rusin" <zack.rusin@broadcom.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <52b57836c0c28abe1c4157646b39329c603ff77f.1792471114.git.zack.rusin@broadcom.com>
References: <cover.1792471114.git.zack.rusin@broadcom.com>
 <52b57836c0c28abe1c4157646b39329c603ff77f.1792471114.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 07:26:50 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Steal time accounts for time a virtual CPU waits to run on the host.
> VMware updates a counter in guest memory, but encrypted guests currently
> register private memory which the host cannot write.
>=20
> Allocate the counters together instead of embedding them in every CPU's
> per-CPU area, and share them before registering any address. Move setup
> for all guests to an early initcall, after the page allocator is available
> and before secondary CPUs start, so it can use the normal conversion API.
>=20
> Keep the allocation for CPU hotplug. Enable accounting only after boot-CPU
> registration succeeds, and retain pages whose encryption state is unknown
> on failure. A secondary CPU's registration failure must not prevent the
> other CPUs from unregistering their counters.
>=20
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20261001235950.GHar7z9v3zfk8odoTh@fat_cra=
te.local
> Link: https://lore.kernel.org/r/20260309235250.2611115-5-alexey.makhalov@=
broadcom.com
> Co-developed-by: Bo Gan <bo.gan@broadcom.com>
> Signed-off-by: Bo Gan <bo.gan@broadcom.com>
> Co-developed-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792471114.gi=
t.zack.rusin@broadcom.com?part=3D1

