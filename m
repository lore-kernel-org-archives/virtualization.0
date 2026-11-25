Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600383;
	b=PzATpT62yvOdeB7Last9uV2WNgNa9p0L9wh2EUBMGW0xv0+RMWH94JwTCwC4uhzJ6Cyh
	 w6xkMaKMYVWepvNbaDF7e7nDWmFSQQop8Fvuij7yAkc6XaN6V6I73B7NG8DOw6p8nSv1Y
	 HDpBtgSoqJjUWPbTmPWGTFqpmBQ5qt3SQUVRaEaDrOdPfF0tsqQeijDWziP/6VZCnFFVh
	 A2Gfjg/Wwl3L/bzg3n6JQbpW3lK/tkBrjMlXPcuqNmIrch79DjPh+CgWe20eB0HezJwMo
	 lqfgXyxkZcFUyPQfSj5r9Y0UXX6wJlGbRYKIu8fjKZMxMuQfjdEpD/aCt+FsVDYr7rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600383;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZFR1777o5BbZctdew5HkaijIpX+kfP/b25u/Z7rGZWQ=;
	b=EqR1xOZ2QRu91jzc/CiquVryCayd/jeL62B+9oponcECedFINkYWN85KU+SqrGjK+Gya
	 SlubLMmYZ/0Gbm6mCxKPY+ObrqyisMflkQruRGODN4ySMmmAwDHbvFznOxBO62xwzBXsJ
	 HGymK9jx9uhmhRZ0r+7izy9A7i0RHd4FUr2dVsr2lKq1T4UywV9+N1Uad+8ZE7uL6fGjq
	 BVKgouMmoE6yVQRC8LL4rFh2khBuc2gOT6Oj8mVbqNBPwLLzlwqZVq+jqhW59fQK5gNZs
	 8FnLNll4/nq/ttfWbYVENDmnrtCna59qKfgJb+DV6ySBRUXgEJ9DFYaBQi279/M9XTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZroUO1F6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE97606A31E
	for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZroUO1F6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1581F000CA;
	Wed, 25 Nov 2026 09:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795600383;
	bh=ZFR1777o5BbZctdew5HkaijIpX+kfP/b25u/Z7rGZWQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZroUO1F6feoKrzJ9KmD2AHxJgmKpZQ/uB3p63H52GDuEtLLrCNrL8QTaYGHf3F6gp
	 BF1YS1yLIQ1xPDdL+6hhDFMgh95EDPxKAyPMeBZrBvY/sGtYG5YlJhdUvhRkPKHQZS
	 F/0owZou/WXSDwYpHJonuTSbnwwvW83TI3NB+dz20xQqHbvagt5H73P8pcpicK0c4M
	 JafsWhFrP9BOFsuj5PCRHUsh3nJhuzF7UGOddcWA8Eu6u4ceurdO88WfjaypUozMvA
	 7SJmlcmXsWB7yHgXQYlvbrHtjGa6299cNNBR9L/YzHO6Uy7wAyYXyhwfirIABcA0si
	 kRJFXwDErHp6g==
Message-ID: <sashiko-outbox-233077@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtiofs: fix lost reply due to unaligned cache line
 sharing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Li Wang" <liwang@kylinos.cn>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261125093908.48619-1-liwang@kylinos.cn>
References: <20261125093908.48619-1-liwang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 09:53:02 +0000
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
- [Low] fuse: FUSE_REQ_DMA_ALIGN macro on struct fuse_req breaks
  kernel-doc parsing
--

commit 3bc673b953140f81a8cc8d09ee9dceb6e21e9096
Author: Li Wang <liwang@kylinos.cn>

virtiofs: fix lost reply due to unaligned cache line sharing

This commit aligns struct fuse_req::out and struct fuse_req::waitq to
ARCH_DMA_MINALIGN when CONFIG_VIRTIO_FS is enabled and creates the
fuse_request slab cache with struct fuse_req alignment so DMA unmapping
of out.h does not share a cache line with waitq.

> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> index a8eba46a3e51d..e42f3dc30d3b6 100644
> --- a/fs/fuse/fuse_dev_i.h
> +++ b/fs/fuse/fuse_dev_i.h
> @@ -12,6 +12,18 @@
>  #include <linux/wait.h>
>  #include <linux/workqueue.h>
>  #include <linux/fs.h>
> +#include <linux/cache.h>
> +
> +/*
> + * virtiofs DMA-maps fuse_req::out.h for DMA_FROM_DEVICE in place.
> + * Put @out on its own granule and start @waitq on the next one.
> + * fuse_dev_init() allocates the slab at this alignment.
> + */
> +#if IS_ENABLED(CONFIG_VIRTIO_FS)
> +#define FUSE_REQ_DMA_ALIGN __aligned(ARCH_DMA_MINALIGN)
> +#else
> +#define FUSE_REQ_DMA_ALIGN
> +#endif
> =20
>  /* Ordinary requests have even IDs, while interrupts IDs are odd */
>  #define FUSE_INT_REQ_BIT (1ULL << 0)
> @@ -94,10 +106,10 @@ struct fuse_req {
>  	struct {
>  		/** @out.h: The request output header */
>  		struct fuse_out_header h;
> -	} out;
> +	} out FUSE_REQ_DMA_ALIGN;
> =20
>  	/** @waitq: Used to wake up the task waiting for completion of request =
*/
> -	wait_queue_head_t waitq;
> +	wait_queue_head_t waitq FUSE_REQ_DMA_ALIGN;

[Severity: Low]
Does placing FUSE_REQ_DMA_ALIGN after the member names break kernel-doc
parsing for struct fuse_req?

scripts/kernel-doc strips known attributes such as __aligned(...) from
struct members (via CTransforms.struct_xforms in
tools/lib/python/kdoc/xforms_lists.py), but it does not expand custom
wrapper macros.  As a result, kernel-doc parses FUSE_REQ_DMA_ALIGN as the
member identifier instead of out and waitq, emitting warnings for an
undescribed FUSE_REQ_DMA_ALIGN member and excess descriptions for out,
out.h, and waitq.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125093908.4861=
9-1-liwang@kylinos.cn?part=3D1
