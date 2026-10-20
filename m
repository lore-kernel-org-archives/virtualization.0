Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792497839;
	b=zw8IcdbgmKzD62gUpM/uBZR9GbKd+ZSt15tLErbfclA5AmYbEaQssUl2sX7o3LDS57Cf
	 9E2uf+IUqBC5xlRgInFGzN9CPtSKz8PfNLR1l0Oc1LEiazEekTbV4mMEsnmEaUVmmbgBn
	 Pb1tQgIdWBnV2Rl9R0Alxq3CmU3b4Yugi9ra5KIXsKB2+JKY21DscZJRyvsSBksOOYYVO
	 choRr9abLCULOVU+ky/sldoJDt/JyFP/UY72uRZ+tOt9GeVTTTEQ8fvyCWG3jUi++7jZb
	 OvJrn3JzVgOIVMgxl/ZRCKY5EHgrUXoq7xGt9WFhr77nCDNSuSPLwFIc7VdjFqRXAkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792497839;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7HsS3vsbUcLbA/1BG+EQNTDLuQQgO5sPRb8NfQiO21E=;
	b=3Upi3FpHZf2kyGrpisGzQYbCSNb7SiMBVxCe3cz0lbgDfz13rQus0hfuvE9j1I5LZURp
	 OaXt3V1yjN9V+PhH+0sUGtUgLLU8X8IFriDCVZTe/3KqpM3qECNss+qckJlSJxdcu8q2r
	 N3W4bDdgxt93LvTYejbhXM5Ax4DmhdAaqDQhC77YMGXTj/qfTXy5+9LQB8jHPkQYoMJLC
	 wQnQ0cwB7nKl5w0aXVlJ+05L2CS7OwMOyO6HA8QlPixKP7x25qxy1nlLyZ+a0W/KqPqmY
	 DgRN/S2hgn4VNgEhxuYp5I7WLFGrIluQ4cpKRZzLTYbhsAzRbpVRMrf6Ls6JvzkFAOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UMyQshqF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8922A606A31A
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UMyQshqF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC831F000C4;
	Tue, 20 Oct 2026 12:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792497839;
	bh=7HsS3vsbUcLbA/1BG+EQNTDLuQQgO5sPRb8NfQiO21E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UMyQshqFFP+uijQZNa0ZdsU/2j3SPuj++ep2SROxxhUK9PEh0sMVQwx3qlXV9/Sxf
	 vVHE7ruXap0rWZxq8lseotlr4WMRm4cXDDqqolXui4DaR7A6vDxu1CCIg/7HXJaHir
	 haJjQrkZ3NxHc3R/pLkhYS9CdSJHq/oeMJuUZXVhf6Rrkgb9O6CfQu93p2xM/wMGKE
	 WUOmq2eA1PAIL+BXZcf+bcqgL92MSJ2D4G8scNSC4BKD/uq1gbyUi/ZhoJwZcVkZ4e
	 ycBI4mUWRTQZDVlLzDlfgMEr2U6NqVDrcip6vAsVfoO9+zHeiwNL7qoK3phvaKRk3E
	 fDo/l6S/MS6WA==
Message-ID: <sashiko-outbox-178917@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 1/8] net: account for ingress-resolved virtio net
 hdr state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <b1dce3e055b973bd87bdbdc9e9729971fa383326.1792411304.git.mst@redhat.com>
References: <cover.1792411304.git.mst@redhat.com>
 <b1dce3e055b973bd87bdbdc9e9729971fa383326.1792411304.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 12:03:58 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The following patch will add ingress resolution of uncommon virtio net
> hdr checksum metadata (software checksum completion at ingress) which
> adds performance overhead to the packet processing.
>=20
> We should make it visible, so a hypothetical workload relying on
> uncommon metadata can be distinguished from none at all. This way issues
> in the parsing will be reported and not quietly pay the host-CPU
> checksum overhead instead of offload.
>=20
> Flip every call to virtio_net_hdr_to_skb to test for negative errno
> only, and have tun count these events per device as rx_csum_sw, exposed
> via ethtool -S.
>=20
> Assisted-by: LLM
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792411304.gi=
t.mst@redhat.com?part=3D1

