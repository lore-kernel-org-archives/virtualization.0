Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792607221;
	b=hdc+aRzHXi2RxJAXtdspO/hk5ZhOLkfkpdPdnHqpJB/awQHpu40CXZZtk5BkUS9vMsfV
	 1m3rIumy2BiJB4XmEnMt9z9StMEMVVq0SNBj8GuqQYYDloHZnDrI2FTpVFbA8XjW+lSO7
	 45kpOsdypm3ox+qfX8B2c0+zLGitplvtxVL9lAavKwYU0jCKxcn8ozKLtvSAvuIP3W4um
	 v91Mx3LV760eoig2Y09A6q4G7BaEskYeeyecDHs8mgS04ec5FB+49vhdypoya6xm+UUXX
	 yvbO282K5inlZkSO5Ov9xxkCAneYxzQJoKdMLwKBIdT+Y2mI3pzru28xHZ8CWeslunA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792607221;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gkN4QWyQx+J5vEuDNI/rxgklY0dBtc1m9fB3Rnf49AU=;
	b=JoLi2Sea47MPvqeSrqSUBjmt4wQkm5Qzm6cNSIOsqccqCT69LE8AgvpZihFkPOHDlewd
	 vEyhupdKEALjtuc//5Q7IrEyJfkMHh7ZGWxibaMNczEdmyP/bRZLoNQt3emmuuRuxABTh
	 mBl4fCr3EBiwFGmQm6d2RgMTShuhGJY019CGiVyoDI5j1779FPjUtVJAAHI9hvwP5DYIm
	 BWYtOMdRJ2wro8v23YVSmXyBIpcnYsiPRBRwW4pNLgyYtWGnAdWgCaCrnrziT3zyeC+7Q
	 VLqCpQdmMGEC2AzDXX2I7Tz2w0zqlwMoRlcA/xWoIqFKXAhIE1glim9EK+1/HHqUQhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G+umEbtD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC239606A31A;
	Wed, 21 Oct 2026 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G+umEbtD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA061F000C1;
	Wed, 21 Oct 2026 18:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792607220;
	bh=gkN4QWyQx+J5vEuDNI/rxgklY0dBtc1m9fB3Rnf49AU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G+umEbtDrl9Dc5eRpsWgSt6aObsxcLeW9jz4+WyRzuk7o87XAndG8P0kw9P/4knhz
	 IZTqdr4Zs3uXGAH3JXQSenqiVwhp5bYFm+OS0n4XI7Orpy1MOtYUGwxbeaTuIgP9u6
	 Wyy5tGEsE2bEu0U/pNsAMfvd98Nv5BoP3DKFXCQZV/Y2F4V6ANg0D+6dfUfCR1F3Qc
	 Cs4zWy4cKCcgPequo0yHHUbsYU6orcvTcMhUgdAkPyWCi6lCNVFCNDU0QWuGSLbbbB
	 2BWe9GfiMddrvghESCDeYjuET9eq6y4/sJ8dclHyqafV4kVt56+acf5tClYDaFa8ib
	 nW+HAfsCiMWdg==
Message-ID: <sashiko-outbox-180555@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND] vhost-scsi: use FOLL_PIN for DMA page pinning
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karthikeyan KS" <karthiproffesional@gmail.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261020182640.2048506-1-karthiproffesional@gmail.com>
References: <20261020182640.2048506-1-karthiproffesional@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 18:27:00 +0000
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
- [High] vhost-scsi: page pin leak in vhost_scsi_map_to_sgl() error path
--

commit 1042924e4de0195bca9a4409c2fafbb0c7c58e45
Author: Karthikeyan KS <karthiproffesional@gmail.com>

vhost-scsi: use FOLL_PIN for DMA page pinning

This commit switches vhost-scsi from iov_iter_get_pages2() (FOLL_GET) to
iov_iter_extract_pages() (FOLL_PIN) when mapping guest I/O buffers into
scatterlists, and updates the teardown and error paths to unpin the pages
with unpin_user_page().

> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 885fac5ed042e..8162d83bdfcc9 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c

[ ... ]

> @@ -842,9 +851,9 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
>  	size_t offset;
>  	unsigned int n, npages =3D 0;
> =20
> -	bytes =3D iov_iter_get_pages2(iter, pages, LONG_MAX,
> -				VHOST_SCSI_PREALLOC_UPAGES, &offset);
> -	/* No pages were pinned */
> +	bytes =3D iov_iter_extract_pages(iter, &pages, LONG_MAX,
> +				VHOST_SCSI_PREALLOC_UPAGES, 0, &offset);
> +	/* No pages were extracted */
>  	if (bytes <=3D 0)
>  		return bytes < 0 ? bytes : -EFAULT;
> =20
> @@ -867,7 +876,7 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
>  		    cmd->tvc_sgl_count > BIO_MAX_VECS) {
>  			WARN_ONCE(true,
>  				  "vhost-scsi detected misaligned IO. Performance may be degraded.");
> -			goto revert_iter_get_pages;
> +			goto revert_iter_extract_pages;
>  		}
> =20
>  		sg_set_page(sg, pages[npages++], n, offset);
> @@ -879,14 +888,17 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
>  	*sgl =3D sg;
>  	return npages;
> =20
> -revert_iter_get_pages:
> -	vhost_scsi_revert_map_iov_to_sgl(iter, *sgl, sg);
> +revert_iter_extract_pages:
> +	vhost_scsi_revert_map_iov_to_sgl(iter, *sgl, sg,
> +			is_prot ? cmd->tvc_prot_need_unpin : cmd->tvc_need_unpin);
> =20
>  	iov_iter_revert(iter, bytes);
>  	while (bytes) {
>  		n =3D min_t(unsigned int, PAGE_SIZE, bytes);
> =20
> -		put_page(pages[npages++]);
> +		if (is_prot ? cmd->tvc_prot_need_unpin : cmd->tvc_need_unpin)
> +			unpin_user_page(pages[npages]);
> +		npages++;
>  		bytes -=3D n;
>  	}
> =20

[Severity: High]
Can the cleanup loop at revert_iter_extract_pages in vhost_scsi_map_to_sgl()
leak a FOLL_PIN page pin on the last page in pages[] when the misaligned-IO
check triggers on the first iteration with a non-zero offset?

In vhost_scsi_map_to_sgl(), iov_iter_extract_pages() extracts and pins
DIV_ROUND_UP(offset + bytes, PAGE_SIZE) pages into pages[], where pages[0]
only covers min_t(unsigned int, PAGE_SIZE - offset, bytes) bytes starting at
offset:

	while (bytes) {
		n =3D min_t(unsigned int, PAGE_SIZE - offset, bytes);
		...
		if (!is_prot &&
		    (offset & (SECTOR_SIZE - 1) || n & (SECTOR_SIZE - 1)) &&
		    cmd->tvc_sgl_count > BIO_MAX_VECS) {
			WARN_ONCE(true,
				  "vhost-scsi detected misaligned IO. Performance may be degraded.");
			goto revert_iter_extract_pages;
		}

		sg_set_page(sg, pages[npages++], n, offset);
		sg =3D sg_next(sg);
		bytes -=3D n;
		offset =3D 0;
	}

If this check fails on the first page (npages =3D=3D 0) when offset > 0, it=
 jumps
to revert_iter_extract_pages before bytes is reduced by PAGE_SIZE - offset
and before offset is reset to 0.

At revert_iter_extract_pages, the loop steps by PAGE_SIZE instead of
PAGE_SIZE - offset:

	while (bytes) {
		n =3D min_t(unsigned int, PAGE_SIZE, bytes);

		if (is_prot ? cmd->tvc_prot_need_unpin : cmd->tvc_need_unpin)
			unpin_user_page(pages[npages]);
		npages++;
		bytes -=3D n;
	}

When offset + bytes crosses an extra page boundary (for example, offset =3D=
 3840
and bytes =3D 512, which pins 2 pages across the boundary while bytes <=3D
PAGE_SIZE), the loop only runs DIV_ROUND_UP(bytes, PAGE_SIZE) iterations
instead of DIV_ROUND_UP(offset + bytes, PAGE_SIZE) iterations, leaving the
last page in pages[] pinned.

Should the cleanup loop account for offset on the first iteration (using
min_t(unsigned int, PAGE_SIZE - offset, bytes) and then setting offset =3D =
0),
matching the main loop?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020182640.2048=
506-1-karthiproffesional@gmail.com?part=3D1
