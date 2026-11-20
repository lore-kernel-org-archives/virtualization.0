Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795153750;
	b=xXcLmKiWgqOL9dZ5fNffBNzC7sa6wD++7vYmWM6jRdBNvp4aPG2TUXRMHwA7ncoxZ0ZV
	 vqzC+BYcD3Eon1z7gIlgtS6bysqj2q2E8HDUoR5dMekNdtHUQCHm0jPPG8yx+KL7E4G3b
	 N5rzTpUO7B0jFAbyI60uXIdAXlJbdi43jXw4S1w6tRMXd3V0W6Oiw8yJ+lt0ZsNQMXbRN
	 bMLVrul4TYzDdd8Pr9Ct3P0obr2tyAEKulgHVKj2PyvzepdIKEmxt64jJNXK4QlzjjQfo
	 Zp9ZkZbcPfcMx2pqHytnoD1dtIG1KA5hgw0WWc5zEiSeIkD0jbFpwVo5AxIySLcCaGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795153750;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IBJnbOHwVJkmRCpEQS11A3KQZKqhqbcUNfswSKPAEyk=;
	b=MF5z4RThN4QlSww/hYn1CJcdIsjRQbQLTV6Zk6Wp8cXPx+gxnWkNPWnXE5NWZ8qkRgWJ
	 2vbxaSUMTDuOD0wUTJhsE5nGx4j291A68Z5+SZsDFJWwITPqghB6TN2cafWKXpgekZWte
	 SHWE4hZSp0EztfNhLxZaAg+N+oY86jJrWLy3PqCRJOzRoDc3+OeiL7dkRvCe6iGOBh5tf
	 reGswtPBjWMXuJ8g5xlUHgRGD8SUJOnQDdPMmOTpsH5nm7OwRqwJ2rkMPrOqL8s70Zzqu
	 ttn2R+ei+GSQ0JaPWCFuykfPUPLEAK9VWtkbH+XeXMBYxtch1iWK8k/OffIa9uf+F9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cGEGkpmY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D3C606A320
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 05:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cGEGkpmY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5A31F000C4;
	Fri, 20 Nov 2026 05:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795153750;
	bh=IBJnbOHwVJkmRCpEQS11A3KQZKqhqbcUNfswSKPAEyk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cGEGkpmYcC5DNXccWZeI9ymCfp2nTr8mlqwTaGyW+yNz+UVqRWA3gIpnczbiw0VPh
	 Uat+EgmM3KR7gtcwcdFhmEC0a2rt/kWej+JvDxJlQ/jONMR8rK7Y0dHtOArvmUVB+P
	 rPgRHt4ZBbZMEhcHRX2z+QXYmcGm3KbaV3rHBYwrljYYC4IyNG6AlyCWmejal07pLM
	 AhhO/O+OC7O6JBhiXODAk8yxHwg/0AIEf0bNMvpSy+8LN+jfhGCJrWzzbzNV7B/Nmn
	 NQARC+aAP0ptAR445uzTmRVxR8pLX5UwbVW/Y33SoKG19KFDMVy3WrxcOYLttvLKsr
	 NjP7r2o3upEZA==
Message-ID: <sashiko-outbox-224513@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] vhost: account the per-device kernel allocations to
 memcg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261120054517.526275-1-cui.tao@linux.dev>
References: <20261120054517.526275-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 05:49:09 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Tao Cui <cuitao@kylinos.cn>
>=20
> Everything except the worker struct is allocated with plain GFP_KERNEL:
> the per-vq iovec and log arrays at VHOST_SET_OWNER, the memory table at
> VHOST_SET_MEM_TABLE whose size follows the user supplied region count,
> the pending message nodes, and the vhost_net/vhost_vsock device structs
> with their fallback to vmalloc.  The worker has been accounted since the
> vhost_task conversion.
>=20
> A container that can open /dev/vhost-net or /dev/vhost-vsock, which
> device plugins hand out with passthrough, holds roughly 150KB of
> resident kernel memory per device after SET_OWNER.  Charge the rest the
> same way the worker already is.
>=20
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120054517.5262=
75-1-cui.tao@linux.dev?part=3D1

