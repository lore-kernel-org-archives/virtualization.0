Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621349;
	b=J6Y2qSKdCNXYFWX2ILLnTlUHLXDlkXmFPnIzm3Jl6U8ODLU1GXP9g9PUs0Cd/bXvdRG5
	 4yDh24xBbuzVWJrRnL0e4LXQlnX8do10HNHZoxEwUcd+JYuGia38fgnYU2qDb6De3sNtm
	 GvCqiIN5/TVkCRguvaZ3skgEs88muZztMEEqAa11/QYp39EB50WFVs7EtJ772zU8eJUbx
	 POt5M4aq6BsqnpgsyZgmLqWl3ADPQ7T6PkPaetRpeUjlRxPCb1DnFEXMBSRTL2UYAg7Qj
	 jdyb9oEUBW1Ff/VOGZdTTRUgC8AdfslPXovyAHUGXPwgX61Ej4sP0zWlZeQmEMlRyvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621349;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=z6R9JlqFZeNVbPW4SfAM98lKIPJRjxpAifSOcKpomD8=;
	b=gTfGs0U0V0TTuitqvz8mj29hIGR3WbmsxySOxuKW9zgolxrSFDjU341NXat/G+noXqbU
	 qORJOzim10IRTC858/dqWKT6hF3JdDE2IJME868p5DsxcBRTvvhfJSBAbd+PojcvYKiLB
	 5ZQ4YnqQX+ncFc+BZMTiCAV8/EbJzKyCJ9Fls/TZ4xl7J5XeUlz3VZvqnYyMy5QkpgF5w
	 JnteveNiKaTrcb4pTxgBqxeE8AZvfQ7C9BFEeJpFsThOwDuV4uXp7Q+yC5fXcRiI0HLI5
	 Lzvc0J+t9hvIqLekXADT3RalxxDUj9UKoqUr1HMphL31SwCD6fhrtelSJ7xV2W7oDgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m8HEoWV5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBA3606A334
	for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m8HEoWV5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00A01F000C6;
	Wed, 25 Nov 2026 15:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795621348;
	bh=z6R9JlqFZeNVbPW4SfAM98lKIPJRjxpAifSOcKpomD8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m8HEoWV5KSftrJr0ZmCfD6+RFefb7GibqzKguNavZDaup9WjkYXN8XwO72nnJEBhI
	 G7TEdaXkOlOCbtS8s19zGv9kiRO4UY+dZESQIaNkdwcSNRe2B+ukKC7zPRHr0abf10
	 stkrChu7Kw/5MQO2fB8JpiQ1mlhSdqrU4EYT78GHtrfC/ElgfUvUAurjW6bpzIW8m5
	 Ox0tVWBZ6TkK+BCU8Jxpx9E1nMvABXbvuw7bQSElLY8PaoYBlPyxPEWdu3Zr1OanS8
	 JTcU8MjVDyjMvXPN2z6FWihNxaKNbYKMguUyJn/jFYpQIzPQKNIVF7K6xXTeEPaVou
	 lOsprkVDX9EAw==
Message-ID: <sashiko-outbox-233668@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vduse: don't set VM_IO on the domain file mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: chenglong.ma <longpareto@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261125152800.485-1-longpareto@gmail.com>
References: <20261125152800.485-1-longpareto@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 15:42:28 +0000
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

commit f6d46c11d1a5c1adc989b443940eecb07ed23967
Author: chenglong.ma <longpareto@gmail.com>

vduse: don't set VM_IO on the domain file mapping

This commit removes VM_IO from the VMA flags set in vduse_domain_mmap()
so that mapping a VDUSE domain file does not fail mm validation.

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

[Severity: Medium]
Can removing VM_IO allow two VDUSE domains to pin each other's domain
file in domain->iotlb and permanently leak both domains?

Without VM_IO, vhost_vdpa_va_map() no longer skips MAP_SHARED mappings of
a VDUSE domain file, and vduse_domain_set_map() only rejects mappings of
the target domain's own file:

drivers/vdpa/vdpa_user/iova_domain.c:vduse_domain_set_map() {
    ...
		map_file =3D (struct vdpa_map_file *)map->opaque;
		if (!map_file || map_file->file =3D=3D domain->file) {
			ret =3D -EINVAL;
			goto err;
		}
		ret =3D vduse_iotlb_add_range(domain, map->start, map->last,
					    map->addr, map->perm,
					    map_file->file,
					    map_file->offset);
    ...
}

If two VDUSE domains (for example, two address spaces on a device with
nas >=3D 2) import mappings of each other's domain file via vhost-vdpa,
each domain's iotlb holds a get_file() reference to the other domain's
file.  Because imported entries in domain->iotlb are only freed in
vduse_domain_release() when domain->file's refcount reaches zero, and
vduse_domain_destroy() only calls fput(domain->file), neither file is
ever released.

Should vduse_domain_set_map() reject any file with
map_file->file->f_op =3D=3D &vduse_domain_fops instead of only
map_file->file =3D=3D domain->file?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125152800.485-=
1-longpareto@gmail.com?part=3D1
