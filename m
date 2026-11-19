Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795053334;
	b=QRiP3tLYbNiFOwd2g6Mh/UpkFiy08Waq3KjmddZK2YUvDPY25rJdc+7reNX5IINFDij+
	 vdQYuKOjy143r6gZbjr4B2tC1a926m52fv4hI4uKKiPPCid2Nt1uM4fJS6vwV8SlRe1BS
	 zSJ0ORpX3u6WXPtIOfs7UKbGxx3lCMwRZgMZaj+NGHZEDgikO/22k9k+fVuYd7PgG9H64
	 yQ5kHuFynqf/9eLWNhqxJN/hUaj0RPt+YlBywUsgNhpRRvIqXOS0BYyBUUopp5G8/X8mx
	 /cdaO3ZaKvrjhdEiVq4OIXpWkdJthrEEZxCHlvEctkp/SSuOh9IryhqR+pTYUGWN6Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795053334;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=12mcZopB6M6zlY6aBdhptsPgEBB5G3xZg/5lWLH2sf0=;
	b=iZGvMwaAlo7fNIq88GCEQKGGCP3tLj4US1hdbX5w6QyOyf64B8Co8pwVj5ZsqiS6hG7q
	 /FHIxkOCkSsdTs1U9VkAzc2xkMhrSNsZV3cWSFsyyDlvX/PAQ7F0I8L8t78z6u0+fe2VC
	 KClEho85vkynk1qchJUomDPArKpsdTQRau2H6psaXvNOwCYX1HkeUQSgV8D5bbN6tdBnC
	 na2oyqwYAFc+oB+404pKdWAjUxQn2XRpQdBVHORza84bMOL37DulToLKuWWMkeMrcei7J
	 M+pdpkxIDna1nE2QEHGs3cg/QRRjXLmtlqPOg5Eyss+IAF0QZiBZxI1Cfn/VdGFFBqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SbSwNY6H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95758606A33D
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 01:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SbSwNY6H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F29E1F000C4;
	Thu, 19 Nov 2026 01:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795053334;
	bh=12mcZopB6M6zlY6aBdhptsPgEBB5G3xZg/5lWLH2sf0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SbSwNY6Hg8igpg7qIVn0R0jhKdFyaySgEilp5qprA0EvvNQkYSX7vKkukEzu5Y0ph
	 7dL3EML3CJYwT2lc4zVMrsELQCp3A/Li1r4Zcnh1fj0pmMRu9TnZqNyvI4kWXqt0o9
	 czbPEisIy27MWSH5nVf63OKLe+LLmDoINybhtLvh5NZvEpDWwm+eVV3Ylx0yWut9qJ
	 r3EfDFSOUxEC4RGkAMRUDvasimvayZciybY28Fo+zt9prTVJIWr9Cc+Jy148YgYacj
	 oYuiY+EcGXCPCj1aCGGZrgWNko0ZcAdJS0u/FRZ/BbFpClRa2Uas9ffAj4uEN/Q0uY
	 PtkelTaC5Nz7A==
Message-ID: <sashiko-outbox-222307@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v7 1/7] vsock: constify the transport in
 vsock_for_each_connected_socket()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261117-vsock-guest-ns-v7-1-7e522ea9dd9b@meta.com>
References: <20261117-vsock-guest-ns-v7-0-7e522ea9dd9b@meta.com>
 <20261117-vsock-guest-ns-v7-1-7e522ea9dd9b@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 01:55:33 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Allow const transports to be passed too. The function only compares the
> pointer against vsk->transport, which is itself const, and never writes
> through it.
>=20
> No functional change.
>=20
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-vsock-gues=
t-ns-v7-0-7e522ea9dd9b@meta.com?part=3D1

