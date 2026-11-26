Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795675338;
	b=xtsWa2nNJGwXavUvKCV7cRfQzdjBXzlGFudkPfBkdbResdh43eQqRylQ2ccK6nJVcHRG
	 FAiFflH9kBrwuLiNlwsHgHkyYMOF2kyG5Wv8Aw4qz/nVKZJJPMusPkixxTQd8LAsECsoh
	 U+eE5BIwKIUwuMF9AW6N36BgECxkjfhOs2R3t37AqLE+btAksklTdD2FzOXKNaXZtYa0y
	 QRNwQ9qBalLGlA/1+rC5Kp9nSC2FvBQV66GofxT0PQ27pHa+/cFnfbmT8XZ38ttLcJrvv
	 945OXsOEfVb2GFaB3rBNSK+Hdc1FvrDvvRRl7IkkKlKJ3ol9TulpDlYebThNToDSvGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675338;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NMMlBjkhahUbr+KRoRpNBww5ng2UrcnOe7utsBaNfaY=;
	b=PNACo5gXhEVU0TFU0j0pJTN3RqDsAib6jcCkJ6epq7wypjbvA6FSFt4FwrVUOtwCB70Z
	 rBs3UMrvY1vU0oU2yFp0MTObFkQ1JABj4sVdDKjR1YjaJS9ftTK8mHCPOWxCTkwtx/Lvr
	 BRvypRqhLP5QAPV1MKfROljO2xnDTllzPz8/RpnOgAWP1rqEaoCdp0iIa2Crmc/+iLX07
	 r9vWJvxQ4kJSnTLh+4q4Cb1XWUK3FRc5q/Z80axIO1kIJvydFysUk+g89ZFHhC+qaNH7U
	 pVl9DVq+SSPicXExFMaHWOlNH0+h7lAeI8SQ5idU8P3MM0SDyR23rWpQEamHkyVvvHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CmGvkxRE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C880E606A31E
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 06:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CmGvkxRE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC881F000C4;
	Thu, 26 Nov 2026 06:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795675338;
	bh=NMMlBjkhahUbr+KRoRpNBww5ng2UrcnOe7utsBaNfaY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CmGvkxRE8gydDCoNeELB3RdNJSB3eLj2hTuro/V5jxKq+sPwgWIO2yFElIc1MVnVc
	 C6TIm4Yyww5wTI0+QSwb+DAbjkcqkzpcLlDjM8tPR0h2qpP3JcUmp6URcyD9QuS19x
	 4Wzzw4qd1NyEIUsRYT98d1aBYSYgQCwjBn4dkXoa+SEdEuHktkbGKPp8As1apgAFVl
	 tN0kQWwtwCJsPM5w5DBMVQBFN/OuJSxlwxWp2fg9fUEXLj6CX/mnhSBx75tGUnbq3E
	 yf4yoCzWBFrnvv89yVsZtx1konFy6YXKUoHLWks/OMHDBj8/oMF8vMb8basUPlfCB+
	 pWpVO8Y2KlwAw==
Message-ID: <sashiko-outbox-234880@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] vduse: don't set VM_IO on the domain file mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "chenglong ma" <longpareto@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261126062915.209-1-longpareto@gmail.com>
References: <20261126062915.209-1-longpareto@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 06:42:18 +0000
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
- [Medium] vduse: cross-domain file cycle leak via
  vduse_domain_set_map()
--

commit 5d6d83b780f71f3d27a9d94c43292bad6883037d
Author: chenglong ma <longpareto@gmail.com>

vduse: don't set VM_IO on the domain file mapping

This commit drops VM_IO from vduse_domain_mmap() so that mmap() of the VDUSE
domain file no longer fails the mm check on mm-managed mappings.

> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_use=
r/iova_domain.c
> index 28a977248a0d3..3c6fa18703b46 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -588,7 +588,7 @@ static int vduse_domain_mmap(struct file *file, struc=
t vm_area_struct *vma)
>  {
>  	struct vduse_iova_domain *domain =3D file->private_data;
> =20
> -	vm_flags_set(vma, VM_IO | VM_DONTDUMP | VM_DONTEXPAND);
> +	vm_flags_set(vma, VM_DONTDUMP | VM_DONTEXPAND);
>  	vma->vm_private_data =3D domain;
>  	vma->vm_ops =3D &vduse_domain_mmap_ops;
> =20

[Severity: Medium]
Can dropping VM_IO here allow two VDUSE domains to pin each other's domain
files in a reference cycle and leak both vduse_iova_domain instances?

Without VM_IO, vhost_vdpa_va_map() no longer skips MAP_SHARED mappings of
VDUSE domain files and forwards them to vduse_domain_set_map(), which only
rejects mappings backed by the target domain's own file:

drivers/vdpa/vdpa_user/iova_domain.c:vduse_domain_set_map() {
	...
		map_file =3D (struct vdpa_map_file *)map->opaque;
		if (!map_file || map_file->file =3D=3D domain->file) {
			ret =3D -EINVAL;
			goto err;
		}
		ret =3D vduse_iotlb_add_range(domain, map->start, map->last,
					    map->addr, map->perm,
	...
}

If two domains (such as two address spaces on one device or two VDUSE
devices) import mappings of each other's domain files via vhost-vdpa, each
domain's iotlb holds a get_file() reference to the other's domain->file.
Imported iotlb entries are only freed in vduse_domain_release() when
domain->file's refcount reaches zero, while vduse_domain_destroy() only cal=
ls
fput(domain->file), so neither domain can ever be released.

Checking map_file->file->f_op =3D=3D &vduse_domain_fops in
vduse_domain_set_map() would reject mappings of any VDUSE domain file.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126062915.209-=
1-longpareto@gmail.com?part=3D1
