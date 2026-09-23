Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEAB4FC8C5
	for <virtualization@lists.linux.dev>; Wed, 23 Sep 2026 13:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790171959; cv=none; b=R+AGFLLKHnaKEV04AaksMsQM91J17OApNs+b+5qm8+2VF58+KxR3pYP1es+APSyckw2bU2W1PUCJXUrg6oXFFUm3fdLD5B3cG0lW7V7h8skWln/eotrhrOY79i4yJ7+oCALnQNZ28hslz9ZhWyGnXQ7fiaL4EF/3ydWIdZ+2Gbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790171959; c=relaxed/simple;
	bh=izWDOnYnDG0HMDT1i3rA26H7+pDPJRtFUDAB9nH8WXY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rq5zQXMUoFyVIYiDvRGeGzglQZnOeTai9KFfsQuu3OZtWVLJM9oZcmmysqARXn5EQg5qQ0LOWZair99Wrgb35uAdCFG20M8TRwNKLOdXfpUQGe2eZwl3v1z4Y7cqxbzpIheNA9ApZ6HH3Si32P0qQJ6Km21XbITdVQURkbRmPJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIhqG3tJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIhqG3tJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5DD1F000FF;
	Wed, 23 Sep 2026 13:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790171956;
	bh=ZGV+V//FpYtY++nf6j5+NnSlKWY3IBj7GjG+SG5yZ1k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nIhqG3tJ66ws7/rX67sNMwmsGPT6MKuB4rH/0SsVdUxYycpOU5n8IhySu1PyGirfu
	 LCnlc2BD2vVmZaWyO8l4InqduBoOmqbbtwsyjs5O3q/CPjHXVfjilDl9W+M1q+jPRu
	 kuJoPPZxFIQhtjdyfvqjiZpx/b3SQpYkhfWmuj6fQY6uNojpNhY47ZWeANETktxgaO
	 hiPAhxd6S8u256r9ScK4PAjDbYXEPt7Mm3pUIXANFzgd3Co68S7RwqLK1O/IZbPenx
	 rR1ejnSqqVN+MCCUMA69oQqxp8x4uFCWKE07+3CLei99/nxyjyKU3dI15KfstBFfZy
	 DvuroTftgp9Ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/qxl: remove double page-size scaling in kmap
 fallback paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260923134952.1750600-1-qwe.aldo@gmail.com>
References: <20260923134952.1750600-1-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 13:59:16 +0000
Message-Id: <20260923135916.7C5DD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> qxl_bo_kmap_atomic_page() takes a page_offset parameter that callers
> compute as a byte offset aligned to a page boundary:
>=20
>     reloc_page =3D qxl_bo_kmap_atomic_page(qdev, info->dst_bo,
>                                          info->dst_offset & PAGE_MASK);
>=20
> The VRAM/PRIV path adds it directly to the mapping base (both in
> bytes), which is correct:
>=20
>     offset =3D bo->tbo.resource->start << PAGE_SHIFT;
>     return io_mapping_map_atomic_wc(map, offset + page_offset);
>=20
> But the two system-memory fallback paths multiply it by PAGE_SIZE
> again:
>=20
>     rptr =3D bo->kptr + (page_offset * PAGE_SIZE);
>=20
> For page_offset =3D 0x5000 (page 5), this computes
> 0x5000 * 0x1000 =3D 0x5000000, a 80 MiB offset instead of 20 KiB,
> producing a massive out-of-bounds access into kernel memory.
>=20
> Remove the spurious multiplication so the fallback paths use the
> same byte-offset semantics as the io_mapping path.
>=20
> Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923134952.1750=
600-1-qwe.aldo@gmail.com?part=3D1

