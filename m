Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793407545;
	b=Ij+y2VcwBW7tVl/qSJ3lS7ngHlIrXlYHq3fgKM63FifcomsmV9k8PE/4DH87rwN7tCh1
	 zTFTJ+Ovqdwi4iFOWYxSxfBlLBt1zctcVVB2OTvM3R/EJhhkkZpSYENJXLN7uaXku+lke
	 yFNf00eTJeiqP8wFMCCGNd47/QxE4kpFfokdx+X+g7xgXb7N+0Q8g+9uqirzuT7jRjcBS
	 Rrnz2hLDgKNqYM+HBOPiJiMSlcB4qBIopkrMAX61k554WVspQ3FlOue03tZtfJNLtGL1k
	 /Dn1/V7VrvENIjPlaYKmT7JN+24y9MFqOB1gVAxSyyB6SZwWlWufQ7A84acfWkmelBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793407545;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0QbYCVsMDSP7Nm4j/a/SbxS52zvNwop46zy4uwNf+Kw=;
	b=bvHG1lc3oxot3xbfhNmCsQDXEs2KJhbu/ideCBeZQjUeqta19ktbLrbzKayD/VMY9d8L
	 nrM1wNTTbpj4U8dKUX34nFDOmOgjjPFuxDD7yYbQVXu1ZG8yPS0Tm1SFreia9mTFQFPcg
	 TpWVGCvVvG5r29YbIqAD+G+OoJt9YSXFDEIf+WE7GCcpE9zogHb7uS6AvVkf5zLK5VOTx
	 IJ5P29eN8QhrtsikjkIGPSyK9dQEO+1KVPZTU7OP5jHx4afZoNDMtBxzfr8v4KaZrqvH7
	 dq/2eHiUw2vOxDyMCxDn0YkKZ3htui/IpEs6b0xvb/N9A5pPuEka3XcV7LZzQmqsZ9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbI529CN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBF5606A31A
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 00:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbI529CN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9998B1F000C1;
	Sat, 31 Oct 2026 00:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793407544;
	bh=0QbYCVsMDSP7Nm4j/a/SbxS52zvNwop46zy4uwNf+Kw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QbI529CNX9cPSURLIkjcNPSGXJ500lwG+vL4jpWwY4UWH27Zxq9xnzMyqbfJVOuVU
	 W/aWC8LFtXF6BHAa3K2mWZsFsZXCImF1e8WUQu8On/UKmEiDuLvawCHauj0UO0o5aJ
	 BMfJM04TNzQjtuLmdpopBME5+7ea9qtkBG86ds3CxZ8U3U0JnxEVv/64cbjIEVYSwn
	 CVv8YWkhWkG+FZW44i7yvq4j5LAWdvqc7nGBzoCXodNdQEG5lnIc6U8EQXUEZ6da3a
	 bUnhrb53nNVidJppEBrD9qnbeiryjzPoFbLkW7P5GxL3yw+0mVVzrWc/Ajt2oIYO0o
	 MQ+FFPsrnlCBA==
Message-ID: <sashiko-outbox-191684@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] x86/paravirt: Add ioremap_verify_range hook and
 implement it for Xen PV
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Andryuk" <jason.andryuk@amd.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261031003309.3751-1-jason.andryuk@amd.com>
References: <20261031003309.3751-1-jason.andryuk@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 00:45:44 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] x86/ioremap: KMSAN shadow/origin page leak in __ioremap_caller()
--

commit 17e6df6da515e9dac650cd6369fda70f312c2a6a
Author: Jason Andryuk <jason.andryuk@amd.com>

x86/paravirt: Add ioremap_verify_range hook and implement it for Xen PV

This commit adds an ioremap_verify_range hook to pv_mmu_ops so __ioremap_ca=
ller() can verify that page table entries were actually mapped after iorema=
p_page_range(). On Xen PV, it walks the virtual address range with lookup_a=
ddress() and fails if any PTE is not present, causing ioremap() to return N=
ULL when Xen rejects mapping machine frames.

Link: https://lore.kernel.org/xen-devel/20251219010131.12659-1-ariadne@aria=
dne.space/

> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 12c8180ca1ba7..6b45a7eef5934 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -301,6 +301,9 @@ __ioremap_caller(resource_size_t phys_addr, unsigned =
long size,
>  	if (ioremap_page_range(vaddr, vaddr + size, phys_addr, prot))
>  		goto err_free_area;
> =20
> +	if (ioremap_verify_range(vaddr, size))
> +		goto err_free_area;

[Severity: Medium]
When CONFIG_KMSAN=3Dy is enabled, can failing ioremap_verify_range() in
__ioremap_caller() leak the KMSAN shadow and origin pages allocated by
ioremap_page_range()?

In ioremap_page_range() -> vmap_page_range(), kmsan_ioremap_page_range()
allocates and maps order-1 shadow and origin pages (which are normal guest
RAM and succeed on Xen PV even when Xen refuses the MMIO PTEs):

mm/vmalloc.c:vmap_page_range() {
	err =3D vmap_range_noflush(addr, end, phys_addr, pgprot_nx(prot),
				 ioremap_max_page_shift);
	flush_cache_vmap(addr, end);
	if (!err)
		err =3D kmsan_ioremap_page_range(addr, end, phys_addr, prot,
					       ioremap_max_page_shift);
	return err;
}

When ioremap_verify_range() subsequently fails and jumps to err_free_area,
free_vm_area(area) calls remove_vm_area() -> free_unmap_vmap_area() ->
vunmap_range_noflush() -> kmsan_vunmap_range_noflush(), which unmaps the
shadow and origin PTEs without freeing the underlying pages.

In contrast, iounmap() in arch/x86/mm/ioremap.c explicitly calls
kmsan_iounmap_page_range() before remove_vm_area() so KMSAN can look up and
free the shadow and origin pages before their PTEs are cleared:

arch/x86/mm/ioremap.c:iounmap() {
	...
	kmsan_iounmap_page_range((unsigned long)addr,
		(unsigned long)addr + get_vm_area_size(p));
	memtype_free(p->phys_addr, p->phys_addr + get_vm_area_size(p));

	/* Finally remove it */
	o =3D remove_vm_area((void __force *)addr);
	...
}

Should the failure path after ioremap_page_range() call
kmsan_iounmap_page_range(vaddr, vaddr + size) before free_vm_area(area)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031003309.3751=
-1-jason.andryuk@amd.com?part=3D1
