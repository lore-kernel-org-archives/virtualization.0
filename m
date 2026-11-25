Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795593951;
	b=AOFY62JN1LfKeV12UJL8ceVTacO8ihF+WDNzYOiaCoVg6m/CzEsnL0QRpulEylLMVajz
	 +XEVh0hhC5CIPRJ2k0mzqUduieQdfRPF0zu+LfOCE4/y0RFFU96G8bOb5xcYRnn0G2VfJ
	 bedZJUIOB2V39RIiSrxX5qaMNZMIEGLOxDy70ZwoyLxrgEUZYt5O4oR+YQQi8pLFCosYv
	 eUTglKsemR6+5DmmPWIbKNZFC6oZ4SQ+v6ZdGCMDzM5cVdXhQNCqsBje8UVF2aNSmFyQe
	 F9ABW+MoXxX/im79siqI9PAzrZSk/TQpYpdvsdGiHIt/p/rr55h1rfHmwKHUuL3wodA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593951;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=etEAWUrbmSvqkobS6VkcWjONmJR+RuD1uvddtdmVtLY=;
	b=Ne8o7xMzYVgnPcgFjh25/8evnivYwDloHbO8Zhyzxh1VeD7vr0q0YWiFFhru4c7CbqCC
	 0dGyj3gfT21ChXekj8fPn5GzwUQqhVeZ6izw2j/KI98HfPp71lTDhn9CYcCs8+E8+IxTC
	 NMi+/BmCZCprTYEAj1QE5Fg3C1+kW2kWUd9UHCJmRtyghPsLQQf5l3/r4wIqa1XKxDJBZ
	 dFHelPW9C1RLORN5tDyujXrHt1fNNb/RLN1HlD8YASLi/rTLF6gh+JBAxAPq9hzytlFkn
	 Aha329PCDSP/J+WLuQXizkT0IjUWn4B5ZX7/lMODBaHllWE0UuHwmGhPzz5d/5WXviA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lFnjtPgL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BF3606A323
	for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 08:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lFnjtPgL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867631F000C6;
	Wed, 25 Nov 2026 08:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795593950;
	bh=etEAWUrbmSvqkobS6VkcWjONmJR+RuD1uvddtdmVtLY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lFnjtPgLGen3iIEcEXgd37+GvPKIYltJYxYcBsuzhccRrOgwOBgKKH1qMEDS7/hA5
	 oO3B/EHqmx6hxkLdTyWOsFrh55nH/x0w1qACdwhL+KqHP1bO6l+wBnBOQ9vDyLGER2
	 ORKAJvDaGBfpxTdoae0i4myZMK1Gux8hd/zHmICbos0VEt+ipwNaUpsn4vifm5avl8
	 FLClKfPoENQMCG+FdT+GNIp/G4bvbtDlz5kzCterI/5hSHjCm/PYphetafChkmdddK
	 OtFsZWCdC/DVMHsfAFj4UHgyljyLzym3rVFN9HOohBI6el+DPADUt3ubZZ+tMTn2ey
	 iWqizd2ZKowPg==
Message-ID: <sashiko-outbox-232862@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] vdpa_sim_blk: add support for FUA writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alberto Faria" <afaria@redhat.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261125075408.226762-3-afaria@redhat.com>
References: <20261125075408.226762-1-afaria@redhat.com>
 <20261125075408.226762-3-afaria@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 08:05:50 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] vdpa_sim: vdpasim_create() clobbers ret with 0, returning
  NULL on error
--

commit 44caf7459577594a98fabfacf52e1c5c4e5f2cf1
Author: Alberto Faria <afaria@redhat.com>

vdpa_sim_blk: add support for FUA writes

This commit adds a validate_features callback to vdpasim_dev_attr and
exposes VIRTIO_BLK_F_REQ_FLAGS and VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA in
vdpa_sim_blk.

> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdp=
a_sim.c
> index 97d437d89524a..888ea80f6e0af 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -209,6 +209,12 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_at=
tr *dev_attr,
>  		if (config->device_features &
>  		    ~dev_attr->supported_features)
>  			return ERR_PTR(-EINVAL);
> +		if (dev_attr->validate_features) {
> +			ret =3D dev_attr->validate_features(
> +				config->device_features);
> +			if (ret)
> +				return ERR_PTR(ret);
> +		}
>  		dev_attr->supported_features =3D
>  			config->device_features;
>  	}

[Severity: Medium]
Can assigning the return value of dev_attr->validate_features() to ret
cause vdpasim_create() to return NULL instead of an error pointer on later
failures?

ret is initialized to -ENOMEM at the start of vdpasim_create() for the
allocation and dma_set_mask_and_coherent() failure paths that jump to
err_iommu without setting ret.  When validate_features() succeeds, it
overwrites ret with 0, so a later allocation failure frees dev and returns
ERR_PTR(0) (NULL), causing callers such as vdpasim_blk_dev_add() that only
check IS_ERR(simdev) to dereference NULL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125075408.2267=
62-1-afaria@redhat.com?part=3D2
