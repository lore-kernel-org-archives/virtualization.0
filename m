Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C91D3AFCE9
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399824; cv=none; b=klTNR27FXF1wf/UGhbVE62mPa+Nqz3Vsb3VzUWTnyF3KM5QoN+o8hpjNj53YkQC0chN/vJUc0QrvU/XAA87g+OhweSIFRQKHFRoJV5su/nYTAePv/tyRpvnvsy8is9TC9WwCcdVP37+dMKqzSBmXn6FxfoGMu/CzHxa6a0sa80o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399824; c=relaxed/simple;
	bh=/DCIn8T/tG7pQsPCaQKHh4JCbPTt60dkZVsk6Apax7M=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=kpEU787p4B2jwAwTA7jrhLHdVBYAJLpiTwqppxodzmWriSTO+JbW5AUGre1RhstyZMkkeAV/vnHAyty6vU683C58I+QjS+HnRW8Pl1EY0ySOM9vSU14BQifrMFNfe3ijbAdZ6Y4I+UXbI/oEbgqUvR7d/5ndzQIK4TZqmwndpGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUlqmBEJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUlqmBEJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A206B1F000C4;
	Mon, 19 Oct 2026 08:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792399823;
	bh=iVygtDjexi+WWLVI2WOGxOMbfhOfBbglk9YfqCIHM0M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HUlqmBEJUUln/4MJpPIjJsKJCd03WnVNbKffZXjSi7l3PyIU2oW01d55bsq+nXvkC
	 4aajjovLHIC/WZduWtOdLHBcsoywhsIdcJFJffu1/yIMjmAlzrPjGN+Wq4nlzT2VZI
	 5BY9StVgv1IeDYdpqj8WzQadWMpgJxnc/+/P01op/TPNgArJs2EJeF8EbCiyBdMN0c
	 GKZdFHkRNMMZlVjISmm8/IZjXc/+3Ath0SUGphGiOXB/Ax7Dkq1s3SKe/zdY54vabJ
	 NBgE12mXqxFXtdEm26aQit2O5svEZjVhjOvWlVLow+LSAUVmv+UE2GXdw14xSe5WTr
	 zYmVPvNgZG35A==
Message-ID: <sashiko-outbox-176843@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] drm/qxl: reject empty TTM memory ranges
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiale Yao" <yaojiale02@163.com>, virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261019084138.1821477-4-yaojiale02@163.com>
References: <20261019084138.1821477-1-yaojiale02@163.com>
 <20261019084138.1821477-4-yaojiale02@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 08:50:22 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/qxl: missing TTM cleanup in qxl_ttm_init() on empty range error
--

commit f2a15ffcd9fd6a825e636790b113ef7e9cbc5bb0
Author: Jiale Yao <yaojiale02@163.com>

drm/qxl: reject empty TTM memory ranges

This commit adds a zero-size check to qxl_ttm_init_mem_type() so that empty
memory ranges return -EINVAL before reaching ttm_range_man_init() and
triggering a zero-range check in drm_mm_init().

> diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
> index 5d495c4798a35..c8cda805b6451 100644
> --- a/drivers/gpu/drm/qxl/qxl_ttm.c
> +++ b/drivers/gpu/drm/qxl/qxl_ttm.c
> @@ -185,6 +185,9 @@ static int qxl_ttm_init_mem_type(struct qxl_device *q=
dev,
>  				 unsigned int type,
>  				 uint64_t size)
>  {
> +	if (!size)
> +		return -EINVAL;
> +
>  	return ttm_range_man_init(&qdev->mman.bdev, type, false, size);
>  }

[Severity: High]
When qxl_ttm_init_mem_type() returns -EINVAL on a zero-page VRAM or Surfaces
range during qxl_pci_probe() -> qxl_device_init() -> qxl_bo_init() ->
qxl_ttm_init(), does qxl_ttm_init() leave qdev->mman.bdev initialized witho=
ut
cleaning it up?

In drivers/gpu/drm/qxl/qxl_ttm.c, qxl_ttm_init() initializes the TTM device
before calling qxl_ttm_init_mem_type(), and returns directly on failure:

drivers/gpu/drm/qxl/qxl_ttm.c:qxl_ttm_init() {
	r =3D ttm_device_init(&qdev->mman.bdev, &qxl_bo_driver, NULL,
			    qdev->ddev.anon_inode->i_mapping,
			    qdev->ddev.vma_offset_manager,
			    0);
	if (r) {
		DRM_ERROR("failed initializing buffer object driver(%d).\n", r);
		return r;
	}
	/* NOTE: this includes the framebuffer (aka surface 0) */
	num_io_pages =3D qdev->rom->ram_header_offset / PAGE_SIZE;
	r =3D qxl_ttm_init_mem_type(qdev, TTM_PL_VRAM, num_io_pages);
	if (r) {
		DRM_ERROR("Failed initializing VRAM heap.\n");
		return r;
	}
	r =3D qxl_ttm_init_mem_type(qdev, TTM_PL_PRIV,
				  qdev->surfaceram_size / PAGE_SIZE);
	if (r) {
		DRM_ERROR("Failed initializing Surfaces heap.\n");
		return r;
	}
	...
}

In the caller qxl_device_init() in drivers/gpu/drm/qxl/qxl_kms.c, a failure=
 in
qxl_bo_init() jumps to rom_unmap before qdev->gc_work is initialized, so
neither the error path nor qxl_device_fini() during devm release calls
qxl_bo_fini() / qxl_ttm_fini().

Because ttm_device_init() links &qdev->mman.bdev.device_list into the global
ttm_glob.device_list, won't returning here without calling
ttm_range_man_fini(&qdev->mman.bdev, TTM_PL_VRAM) (if the second call fails)
and ttm_device_fini(&qdev->mman.bdev) leak bdev->wq, bdev->pool, and the
TTM_PL_VRAM range manager, while leaving a dangling pointer in
ttm_glob.device_list after qdev is freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019084138.1821=
477-1-yaojiale02@163.com?part=3D3
