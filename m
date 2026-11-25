Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621150;
	b=Ga9tdZ9Sj3QtAMyECkKGzdEqN4fr42QFDgjWI+HHLZ8+dHEk/FZ8aOzEeifdMBhzXYq/
	 8dRRhUL1oG+EWF9N9JorhfNJ9kGRLL0eaFtlARgcBNBNAQBtAjbdnW/09V75bqLL6ncTA
	 ZA8jxHEtE12cuqLu5xb/po9wbQeTFDNAvv4iD65DEJ2OCJVXPjMapRQSLx6ZNGuObTySc
	 9K9La5HrrRAVmPG6wCY8bVygdwTYJY9Gjqyy4VuB24FN7V7vxTcawfWRAUm7uo/MZHWwp
	 DIP5jxosQJU960rdrrUX3MlLKtUuc4MxZhTn+O6UQRnpzY9VEyn1grvI/PmcCZoKO+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621150;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AE3inNoBkdE1ETO6IaN5xgmFRG2VnruuJBa+rnGK9Y4=;
	b=dZOhYRF3YseW6VseSjXa3SC9zoN+aASL2GgRSeG7AeOMzLjI/KVlkndJtYqUQeSceCPH
	 U7AJATQE83ASAiJOcbztVPrRdMU4L2KFJ8ujIRsvRTvnHDlPtEzPhpv2aNyO9lnSYqvTY
	 +yelxmmrrWJEHq0+nhxYYTa0HasE8B+ZylZmeKtMhwKdldGrDW0G+6bUgDiDhFkxZGi3z
	 +bN9rdKdmvE/vWmOCstKpEAxU1nS9umWioy5PR9j4LzsEWzNW5t9Zi5V6lhnUxGR3n0Hq
	 OD2M8WVYs5Hvr8kTyH3l15gjNBYSvFR4JyubbCnh9qAgASOEgzkNp6zGdisU7ZcRemw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=atDU6kF7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E55A606A323;
	Wed, 25 Nov 2026 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=atDU6kF7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3E81F000D1;
	Wed, 25 Nov 2026 15:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795621150;
	bh=AE3inNoBkdE1ETO6IaN5xgmFRG2VnruuJBa+rnGK9Y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=atDU6kF7Q7j3YuunedGMic2uyVymmjLyu/p4SriZ5HFryKHQPWHRypMfDwQCWKyW6
	 h2I7y3sax4RxeMnQbRV7oN4QWz1AEfyRJyM0/9wD5goiUUaCJkKXUvZgQQGVtK4hAg
	 HgFaRFKJ1kDhz3rxymoFCosQLK4iaE8RqM3/yvEVt50F+68DPj5TxYzZgDmweO8WIG
	 y5sgXlUOlBdKndwLzlqCRDoUM09lGA9iUR+u0UWQ0dNyNwabq82UZxXkhi2l6tup71
	 izIB6QJIfoqHPUHzCvBgG+Kot1kyZ0nAIJKOUbwEGZDvoWcUw71dVONI4gBCb16t4s
	 +mpj0z00L/L0g==
Date: Wed, 25 Nov 2026 15:39:05 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "chenglong.ma" <longpareto@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Xie Yongji <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vduse: don't set VM_IO on the domain file mapping
Message-ID: <awcAl1lCY0atZuoT@gremlin>
References: <20261125152800.485-1-longpareto@gmail.com>
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
In-Reply-To: <20261125152800.485-1-longpareto@gmail.com>

On Wed, Nov 25, 2026 at 11:28:00PM +0800, chenglong.ma wrote:
> Commit bb2e6f166547 ("vduse: fix VA/PA confusion in the coherent page fault path")
> set VM_IO on the domain file mapping so that
> vhost_vdpa_va_map() would skip it. Since 99fd6bf43d5d, mm refuses VM_IO
> on mm-managed mappings: mmap() of the domain file fails with a
> WARN_ON_ONCE() and -EINVAL, which breaks VDUSE userspace.
>
> VM_IO is not needed. vduse_domain_set_map() already rejects vhost-vdpa
> entries backed by the domain file, and the file check in
> vduse_domain_get_coherent_page() keeps any other entry from being
> translated as a physical address. A self-referencing mapping now
> reaches vduse_domain_set_map() and is refused with -EINVAL.

You should probably point out that the driver is _literally broken right now_ in
7.4. This is kinda urgent for those who use it :)

>
> Fixes: bb2e6f166547 ("vduse: fix VA/PA confusion in the coherent page fault path")
> Reported-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Closes: https://lore.kernel.org/r/awWOpS3HR_2FTN3I@gremlin
> Suggested-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Co-Authored-By: Claude Fable 5.2 <noreply@anthropic.com>

This tag is invalid. See the process on this [0]

[0]: https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

> Signed-off-by: chenglong.ma <longpareto@gmail.com>

Patch looks right though.

This is pretty urgent, so should be sent as a hotfix.

With the tag/commit msg bits addressed:

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
