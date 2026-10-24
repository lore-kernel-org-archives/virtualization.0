Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792854592;
	b=M6Pkeged/kf0QOMXLxTV6cZBH8p32CgWv0Y0f6zLJHIcGuPZWgwhNqV8P00Vsx9vWviA
	 hpPTKm1S7go856Y9UpYlOHf8Ewuz6scouIBC+BowHRmZd+L6zDAeZRTbp+juJhP+p2hTE
	 2oIDfuh+9YKU2yOU5P1gSCI2tWwMw4seiMy1FB93iJ4aMDy0jin8NEFfewTCZ5O5Warbq
	 gxNgwVyziycTABYuKRriHa4puQ+zFJBiGicbnX6Mwv7pNdUL9C9TCnQ7VjwUb6GXAx3Kz
	 tNrPUIa1SBMMJtSZJbuWS2uN4QbrXBdhOy6U0VWQK171w63fFNJTvOKJwhCSFkMHbKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792854592;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0nz9L2Ic058v5IAApc24TPVvF6QUaPBMJXYCW5LGXsk=;
	b=WunL76MBgbgPptTC2JhqqyJhl8XoheODujQGHcUVLNLYnRxYuuIZTEwseDv5ZGFdqzP+
	 iwB65muN1Xk3lGhsbkTFncMiYpYtg0boq2q/AhEn6SxuLsI6osEa4w3FILU9B3xd6Zz6Q
	 kxp6y164PwK6HvhcW+9jsERA33AB0mbVmrJt5RrL73a+Dt8pNNSp0oqrTm30fGJ9j37U0
	 ej1aq08GuEV5L9/YjEyjgZ86be02dSaY5kyxH/YJsjz6T2sKhwP6OK+VZgbRSjhqkmab7
	 8wUeUmA16lnZNDD4WfO4+U7YTeQCiACc8VXY86X7J0i8qrfB+iHEjiXtxx/E6HLkqjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gf25m8Jc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D847D606A326
	for <virtualization@lists.linux.dev>; Sat, 24 Oct 2026 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gf25m8Jc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8906C1F01825;
	Sat, 24 Oct 2026 15:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792854591;
	bh=0nz9L2Ic058v5IAApc24TPVvF6QUaPBMJXYCW5LGXsk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gf25m8JceOXp1ev6onew3bq0TVwHfNjb4SKFhOB6PM9qpjJXPxZp7DHps4g+upxIW
	 ElRtAgkbXE3YAeXoQScZKucMRrjtMZIcTweeFFU/bXmbXiM6HWEEF6DLpqREotdtM3
	 JCZQhxu8Uw03xgv41L/TDLzhfrsQtsmMsTnsyywZ9lFC58W7hvxHUJNmxzFGCz5iXV
	 5/vXHdgSbWWtxTdZ6n7UlRilkRkSnZzbthSEXbrxjO6o66H/c46CUrFA3OhyuNXFJx
	 XyDmgS2S6epnyaSlj2uOzH+bXRIQZQlmAO3i+6ccBOIyaOWdWBSbccotuNaIq3r1LX
	 vEDdqgHW3Cq4g==
Message-ID: <sashiko-outbox-183771@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v6 5/5] net: add a sysctl to opt out of virtio net
 hdr checksum validation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <a631141eaf64501420583332af5d97d2641a8d98.1792768096.git.mst@redhat.com>
References: <cover.1792768096.git.mst@redhat.com>
 <a631141eaf64501420583332af5d97d2641a8d98.1792768096.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 15:09:51 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The ingress validation as implemented by the previous
> patch is stricter than what it replaced: GSO
> packets whose checksum metadata matches no transport header are
> dropped, and non-GSO ones get their checksum completed in place.
> Such packets used to pass with the metadata unvalidated,
> and with no overhead.
>=20
> I judge that this should not affect any deployments, but there is still
> some risk that it does.  In case a deployment depends on them anyway,
> provide a per-netns switch to get the old behavior back:
>=20
> echo 0 > /proc/sys/net/core/virtio_net_hdr_validate
>=20
> The default is validating.
>=20
> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792768096.gi=
t.mst@redhat.com?part=3D5

