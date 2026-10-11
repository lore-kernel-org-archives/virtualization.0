Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FA827467F
	for <virtualization@lists.linux.dev>; Sun, 11 Oct 2026 03:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791688661; cv=none; b=S3zSju1ZQc+M/+2AzRhBdJYueKd8bFy75jLlQ2f5/OdqtWa6DEy0FXzNJ9jD2jIFhUd2F18jvUvgbM18kU8W02Jky89ttqUjRG+vQuaMPcUJB4N2Daxi2/NUEXATB9atJ6fa9DNJP0W4Yep6Mrs0WUgJ9WP44VXcTHvaYM/BEfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791688661; c=relaxed/simple;
	bh=rj0pdCoj8CHqM1tfuGy/7lBAsWE6TbW8I9geetnK1Vs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QTjInIFWUqskLjZ9SNPi3iJ9iyJQLFf0l1rb3rB2Dt+tKGsUSjczmg7kwO8KQ6VR84mzvSwiu3x+DRzdUSsHvRwIc2fJqGWDgfQ4aKc5PCQKcCrfwjkNz+EyeUNGz0tB5MLY+XTkFoGwIkp/Le6pSITiGWOR/pImzeBMCvGPd2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0sQ4UJN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0sQ4UJN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5ED1F000FF;
	Sun, 11 Oct 2026 03:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791688660;
	bh=NokxSFb1h9XdhnQOxk5VMfAMvUbsl5r+4iR7ulSshbM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k0sQ4UJNUYdzHvo9UZ5fce7T/f3JhiQBRorMG7aE6p/VPJjj6WFqkSyC+jVhm405d
	 ynhzti1emtoKTE2ITLpwya8H9lNeJ2oHbL5oPmvvgnZYl9x8Mlae7yBd0Vkt6lfM8Q
	 WlYfoPaS9hLGxYCQdQOyq0ODN1vNn5hd2X1kQMxXO3ZOxVYT4ypbuTx6H49GtbfVhH
	 v7cx9FGXIP3mVAXmRRITrRQLcV7H3tjpSS4QexSlIgXMsWPRZc+s0K+bB5/gw0pZeo
	 jPuItbhYOvUcO/NNAmkfP3ZgQaqRSagZjY1Ixsvhj/YacCspHXWtfPxGybZGQENrp/
	 pP/PpJ+0076nA==
Message-ID: <sashiko-outbox-166994@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/qxl: validate relocation destination offsets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhou Qiuyue" <n0ps1edzz@gmail.com>
Cc: dri-devel@lists.freedesktop.org, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <6acafc03.6b76d992.279a8.b343@mx.google.com>
References: <6acafc03.6b76d992.279a8.b343@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 03:17:39 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] qxl: unaligned dst_offset causes page-boundary cross and alignment=
 faults
--

commit 214f69f63b016ba44fb4af3f2bea1273b9aa972b
Author: Zhou Qiuyue <n0ps1edzz@gmail.com>

drm/qxl: validate relocation destination offsets

This patch validates the user-supplied relocation offset against the
destination object's size to prevent out-of-bounds kernel writes. It also
widens data types to prevent truncation and sign-extension vulnerabilities.

> diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_io=
ctl.c
> index 591b026ceff9c..ae32295fd5e84 100644
> --- a/drivers/gpu/drm/qxl/qxl_ioctl.c
> +++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
[ ... ]
> @@ -231,6 +232,23 @@ static int qxl_process_single_command(struct qxl_dev=
ice *qdev,
>  			reloc_info[i].dst_offset =3D reloc.dst_offset + release->release_offs=
et;
>  		}
> =20
> +		/*
> +		 * The relocation is applied with a plain write into the memory
> +		 * window of the destination object, so the user supplied offset
> +		 * must be validated against the object size.  Otherwise userspace
> +		 * can write anywhere in the mapping window set up by
> +		 * qxl_bo_kmap_atomic_page(), i.e. outside of the object.
> +		 */
> +		reloc_size =3D (reloc.reloc_type =3D=3D QXL_RELOC_TYPE_BO) ?
> +			     sizeof(uint64_t) : sizeof(uint32_t);
> +		if (reloc_info[i].dst_offset > reloc_info[i].dst_bo->tbo.base.size ||
> +		    reloc_size > reloc_info[i].dst_bo->tbo.base.size -
> +				 reloc_info[i].dst_offset) {

[Severity: High]
Does this bounds check ensure that dst_offset is properly aligned to
reloc_size?

If userspace passes an unaligned dst_offset, could the pointer write in
apply_reloc() cross a page boundary?

In qxl_ioctl.c:apply_reloc():
    reloc_page =3D qxl_bo_kmap_atomic_page(qdev, info->dst_bo,
                                         info->dst_offset & PAGE_MASK);
    *(uint64_t *)(reloc_page + (info->dst_offset & ~PAGE_MASK)) =3D ...;

If (dst_offset & ~PAGE_MASK) > PAGE_SIZE - 8, the 8-byte write could cross
into an unmapped or adjacent page, potentially causing a fault when using
CONFIG_HAVE_ATOMIC_IOMAP.

Additionally, could the unaligned cast to (uint64_t *) trigger unaligned ac=
cess
exceptions on architectures with strict alignment requirements?

> +			DRM_DEBUG("reloc dst offset out of bounds\n");
> +			ret =3D -EINVAL;
> +			goto out_free_bos;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/6acafc03.6b76d992.2=
79a8.b343@mx.google.com?part=3D1
