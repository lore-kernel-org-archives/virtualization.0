Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1335B37C92A
	for <virtualization@lists.linux.dev>; Sat, 19 Sep 2026 22:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856117; cv=none; b=k5XiUdj8RTbx/HLD6zfqe/hYhdkRcTGyugOSN/VHHzBj1ecWhXv2/I7QOR7VsTJz/CsXX+LVY6disP+DsT5iwajsqG/w1qhk7swdacZfrOajx7+X7jEGNrkhqzULW25+kT249PP/iqQ/wzpzbqKzeGZuN21JeC2WT9dROypBoW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856117; c=relaxed/simple;
	bh=mm42zjeZEyxatcG1+G7MJvUEzT19UDOYM61kp4o7uUQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hn3UPFPk8Zbuj630/K5eDLDuuYcNdXs4OzKaw0nsfOPgg4YmAJGDe4ZKGOZ/Gaz2819FoyuJQOqw9PfTtQuzznwAYXgCDHDJaw3O88TnkNTj4QaiALGad/HApiPetjHeC4X1kZfSMzKr788w9jr/JBOH0JvT3oQgg/q22X+774U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHgD/EZ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHgD/EZ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CF01F000FF;
	Sat, 19 Sep 2026 22:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789856115;
	bh=g0V6bqgdshBf93AEaMSLofIKx74YdMRzCtFg3iNiUdc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gHgD/EZ9glfkO4xS+RkfLxqry1CkdnESi/+2fERA3MC0InkorqnlwKPqCwy3zsFmW
	 AR8MkvDiESrehrmrw+LrUv0xOGN0hAwBh3uApHZz4qgFhhqEvfa2eZaMmVYenj7TQw
	 lRU5ppNdLnGCDNaeeFFMhcrHNAg1JSglYAQRuiuriPwLn+r4Y0wYzcdjdhkZ0rM85X
	 6FNcba46MZTAbO69eWp2iCcxC76RammoEfgL/KSfPEgiLJD8Y6gLC8QxUTI/Tq2FTX
	 AFkMsaidhrcQrZmXODRD3sv3pZ8vFYG6Ot6SilcN0mMRr/KYaSllxaS/z9YQi2JsT9
	 4KQW6xsHVb9iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/qxl: fix vmalloc OOB write, surface size overflow,
 and BO reloc leaks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Peng" <benquike@gmail.com>
Cc: dri-devel@lists.freedesktop.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260919215228.3469508-1-benquike@gmail.com>
References: <20260919215228.3469508-1-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 22:15:14 +0000
Message-Id: <20260919221515.55CF01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/qxl: Silent failure in apply_reloc allows bypassing hardware r=
elocations
- [Medium] drm/qxl: Meaningful code and commit message mismatch on BO reser=
vation
--

commit 19602cc9bae945e0036cb9d92dfb3b6be072f8de
Author: Hui Peng <benquike@gmail.com>

drm/qxl: fix vmalloc OOB write, surface size overflow, and BO reloc leaks

This commit addresses multiple memory safety and resource management issues
in the QXL driver, including out-of-bounds kernel vmalloc writes during
relocation processing, integer overflows in surface size calculations, and
resource leaks.

> 3. In qxl_process_single_command(), prevent overwriting the union
>    qxl_release_info header at offset 0 of cmd_bo, and reserve/unreserve
>    non-command dst_bo buffers around apply_reloc()/apply_surf_reloc().

[Severity: Medium]
The commit message mentions adding logic to reserve/unreserve non-command
dst_bo buffers around apply_reloc() and apply_surf_reloc(). Is this
description accurate?

Looking at the relocation loop in qxl_process_single_command(), there are
no local reserve or unreserve calls added by this patch.

It seems qxlhw_handle_to_bo() adds dst_bo to the release object, which is
then batch-reserved by qxl_release_reserve_list() before the loop. The
buffers appear to be safely reserved already, but does the commit message
need an update to reflect the actual batch reservation mechanism used?

> diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_io=
ctl.c
> index 591b026ceff9c..6bb609bc6a7ea 100644
> --- a/drivers/gpu/drm/qxl/qxl_ioctl.c
> +++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
> @@ -89,6 +89,8 @@ apply_reloc(struct qxl_device *qdev, struct qxl_reloc_i=
nfo *info)
>  	void *reloc_page;
> =20
>  	reloc_page =3D qxl_bo_kmap_atomic_page(qdev, info->dst_bo, info->dst_of=
fset & PAGE_MASK);
> +	if (!reloc_page)
> +		return;

[Severity: High]
Does returning early without an error code here allow unpatched commands to
reach the hardware?

If qxl_bo_kmap_atomic_page() fails (for example, due to vmalloc exhaustion
when a user specifies a dumb buffer for dst_bo), this silently aborts the
relocation.

Since the caller loop in qxl_process_single_command() assumes success:

    for (i =3D 0; i < cmd->relocs_num; ++i) {
        if (reloc_info[i].type =3D=3D QXL_RELOC_TYPE_BO)
            apply_reloc(qdev, &reloc_info[i]);
        ...
    }

could this allow a user to bypass validation and submit unpatched,
user-controlled physical addresses to the virtual GPU? Should these apply
functions return an error code to properly abort the ioctl?

>  	*(uint64_t *)(reloc_page + (info->dst_offset & ~PAGE_MASK)) =3D qxl_bo_=
physical_address(qdev,
>  											      info->src_bo,
>  											      info->src_offset);
> @@ -105,6 +107,8 @@ apply_surf_reloc(struct qxl_device *qdev, struct qxl_=
reloc_info *info)
>  		id =3D info->src_bo->surface_id;
> =20
>  	reloc_page =3D qxl_bo_kmap_atomic_page(qdev, info->dst_bo, info->dst_of=
fset & PAGE_MASK);
> +	if (!reloc_page)
> +		return;

[Severity: High]
Similar to apply_reloc() above, this early return silently ignores the map
failure for surface relocations, leading to the same risk of submitting a
corrupted command to the hardware.

>  	*(uint32_t *)(reloc_page + (info->dst_offset & ~PAGE_MASK)) =3D id;
>  	qxl_bo_kunmap_atomic_page(qdev, info->dst_bo, reloc_page);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919215228.3469=
508-1-benquike@gmail.com?part=3D1
