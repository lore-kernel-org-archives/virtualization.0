Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624736;
	b=LtHIauYb5M9T+OUL7yVT128K0OpAfEMraP7UwUJmGfQK1QGVrMBmGNJCM68/iFhc3b5m
	 GP4Dw2bE4s/zEWLuYbtNUWcAL2XskbNhvMpK+CuLSaI4P0tCZHARXcmWd8jEwiEwScl1y
	 tdnYgdD0IjSjYMxqPZI51AprcTz7YWYoEKupymQaJr69+Bfi0OvwVOP9wSzet1ty+5GHp
	 3Lah4M+EUOX1GoEiek5rOFgoSR72lMT+q2NpPP8J0VI4e0MBOoXu2KwggGCinB2WxXjf4
	 /gqJiDLkE49Z9oFBLIxqvauHwExCn230WG5RbejnzA8yMPvRT5VlGFMQIk+SWjoSHHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624736;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XGZJDvX95X3i/OHk7sTVZ+Tez/XWAvUK1k5Ca8yfA3g=;
	b=unvrdgbpAB3bhgNpeP73WECp/9w10qgShWWCfekqZ+pyDZAUbm5xkJL/fvy/w7EvdAhQ
	 2y7/5X6fTS5G2xvydNOwmglTLBpFFPl1lYjofr9/hcv+VTwF6iC22n98alDYkFPLhgvCG
	 sXUqOflRGjVa6PZ7iFW5LBmXQlbZ0F5vmAw52pXAq4g/vmmpA9+5HPc7SFuioFZXyixUc
	 +xo+ndNYM1CLNN1y1/hDW//p9lLFT0LconBS1tUw6asxFyaMhahsVhaY++RUjfpH55jM0
	 lWE8JDocdlgM+pgyeyTgYc3adGDAszwSdnCUz33OmPezHCw8+lHy51GmRAMn2p276AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gb+KB40p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E641606A33C;
	Wed, 25 Nov 2026 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gb+KB40p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBDF1F000CF;
	Wed, 25 Nov 2026 16:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795624736;
	bh=XGZJDvX95X3i/OHk7sTVZ+Tez/XWAvUK1k5Ca8yfA3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gb+KB40pRfWiJmkNIILhDy9LLczCpQWfSNnSqZlycpdUhKP7rgCyI7irBk6fPJztV
	 uwyQQ6Ead+6YXdHiJKcD0hfodluisTywhkRj792ZEbIJeNdaFp0knyJIwx/39Gu93c
	 +uiknKSdIzfMEsNbNJnSCFHu5Omh3neML62SLcaabCXZIKPEYeMOt3wvwTZytOqAYj
	 mDKfmOApgA/88EUqXocIo1rt3oNwAX04HxhfNv7Fh2gnp2m6/ixO5F9RWL+pyNsq5F
	 5Iol1b6BmujgTOKnIV9e/SsYfpRexUGoakP0Ry5+zvSRxij5lKRwqw0EKGotUIb8mh
	 +9m0w7GvJYpwA==
Date: Wed, 25 Nov 2026 16:38:51 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "chenglong.ma" <longpareto@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Xie Yongji <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vduse: don't set VM_IO on the domain file mapping
Message-ID: <awcNt5C6jkZQLy0M@gremlin>
References: <20261125160128.796-1-longpareto@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125160128.796-1-longpareto@gmail.com>

This isn't how you send patches in the kernel...

See https://docs.kernel.org/process/submitting-patches.html

This is a v2 of the original patch. It should say [PATCH v2].

You shouldn't send a respin so quickly.

On Thu, Nov 26, 2026 at 12:01:28AM +0800, chenglong.ma wrote:
> Commit bb2e6f166547 ("vduse: fix VA/PA confusion in the coherent page fault path")
> set VM_IO on the domain file mapping so that
> vhost_vdpa_va_map() would skip it. Since 99fd6bf43d5d, mm refuses VM_IO
> on mm-managed mappings: mmap() of the domain file fails with a
> WARN_ON_ONCE() and -EINVAL, which breaks VDUSE userspace.
>
> VDUSE is currently broken in 7.4 because of this. Please treat this as
> a hotfix for 7.4.

You should say that it's broken and the patch fixes it in the commit message,
and leave commentary about it being a hotfix for below the ---.

>
> VM_IO is not needed. vduse_domain_set_map() already rejects vhost-vdpa
> entries backed by the domain file, and the file check in
> vduse_domain_get_coherent_page() keeps any other entry from being
> translated as a physical address. A self-referencing mapping now
> reaches vduse_domain_set_map() and is refused with -EINVAL.
>
> Fixes: bb2e6f166547 ("vduse: fix VA/PA confusion in the coherent page fault path")

Cc: stable?

You shouldn't be using VM_IO anywhere.

> Reported-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Closes: https://lore.kernel.org/r/awWOpS3HR_2FTN3I@gremlin
> Suggested-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

You failed to propagate my Reviewed-by tag...

> Signed-off-by: chenglong.ma <longpareto@gmail.com>

This Signed-off-by seems invalid, there shouldn't be a '.' there I don't think?

(Also gmail isn't really recommended for kernel stuff either, they drop a lot of
kernel mail).

Anyway, I assume Michael can pick this up and fix it up a bit?

For the patch itself:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>
> Notes:
>     Tested on v7.4-rc2 (commit 7475ea8b58616b33c04afb976cf0fbaad9dd63fb).
>
>     Control, without this patch: mmap() of the VDUSE domain file fails,
>     with the WARN_ON_ONCE() from 99fd6bf43d5d.
>
>     With this patch applied: mmap() of the domain file succeeds, and
>     importing that mapping through vhost-vdpa is refused by
>     vduse_domain_set_map() with -EINVAL.
>
>     Dynamic tests also confirmed that vduse_domain_get_coherent_page()
>     refuses to translate entries backed by any file other than the domain
>     file, and that legitimate coherent vring mappings are still translated.
>
>  drivers/vdpa/vdpa_user/iova_domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
> index 28a977248a0d..3c6fa18703b4 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -588,7 +588,7 @@ static int vduse_domain_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>  	struct vduse_iova_domain *domain = file->private_data;
>
> -	vm_flags_set(vma, VM_IO | VM_DONTDUMP | VM_DONTEXPAND);
> +	vm_flags_set(vma, VM_DONTDUMP | VM_DONTEXPAND);
>  	vma->vm_private_data = domain;
>  	vma->vm_ops = &vduse_domain_mmap_ops;
>
>
> base-commit: 44293796526f4343639f87b2acc53811c78b5d54
> --
> 2.45.2.windows.1
>

--
Cheers, Lorenzo
