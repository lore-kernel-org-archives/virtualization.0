Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191663C09EB;
	Thu,  4 Jun 2026 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589070; cv=none; b=PXCFDhuBzVcTEyGPD1QjoeDVYWauDSJqrkeFQxXQ2gj4LXN91Y3nIrxUN0xPXRdMY0SHGaR7xjZS5LiKx5f1NCzhdSEiePdpdpvb6T+RfT3Q4yQlFnsqptCbJ/WWmKvLdXFqZH7jXOygbGAZxwR5H/gtuCKVEyQecavQicBTjDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589070; c=relaxed/simple;
	bh=+XICY+YDEgurFpXgath+1laCa4If6hpRbFiUZcxI3W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9fIscoBHA4MM8WqYx9IkkHhMPZsoKBi3wv3onwapfzDOXqHnLv58EG/sICRu5pd7yCWA2qoFXpjR0/lc3zO7WtFPTe//mPQ26sImiqFcVwUUV0rWPHDTtOZF2DPqvdhywEwAYk8cRyqCfZW2Aojv6XIg0dFBZrCcx8y99HmZqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhvU6qpa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhvU6qpa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C3D1F00893;
	Thu,  4 Jun 2026 16:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780589068;
	bh=7mgnBtdEgLUmZt02VyMe6Hui1aO83yGWW+LKR/CGzm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bhvU6qparCN4gzuFi2YM/txdBRxic4bIE1acQCa3EysEVT2ygI6dS8PULlfI3ynOp
	 IJQpmFLMNXmC94p0H6sV0LdgkHG13rQ8J04IjCkVSvMrJRy/Tyf6zHIKsVjF/mpXAv
	 EKkJ8hkCHLW0dWF4OjuADN2K9zzuGcU5xSqL4uEct90cKf4QoBo7p9cKjIBQ31NnWD
	 fPs4Xo+bDvQQJmJvdB8V0aulluzcjInFGZH+VLy0z/uNFV7Og/CVu/wqZu0zk3mprn
	 Arf3zwmx3vhtvC9RlZphW0cj/oDBmAAmhsdVr7HqudMjlJ2syKR2LvwpDWzV5mvtV0
	 g51BAIvoNjsXg==
Date: Thu, 4 Jun 2026 17:04:49 +0100
From: Jean-Philippe Brucker <jpb@kernel.org>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 2/2] iommu/virtio: Avoid using the list iterator past the
 loop in viommu_add_resv_mem()
Message-ID: <20260604160449.GA1619938@myrica>
References: <CAHPEe=G-FZvEXjkE+vAXN5MHXCtsOaUoKwg2RQL6m=om+c20hQ@mail.gmail.com>
 <20260604051816.2976221-1-maoyixie.tju@gmail.com>
 <20260604051816.2976221-3-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604051816.2976221-3-maoyixie.tju@gmail.com>

On Thu, Jun 04, 2026 at 01:18:16PM +0800, Maoyi Xie wrote:
> viommu_add_resv_mem() walks vdev->resv_regions to find the insertion
> point. When every element has a smaller start address, the
> list_for_each_entry() iterator ends up one past the last entry, and
> &next->list then aliases the list head, so the following list_add_tail()
> still appends at the tail. The result is correct, but using the iterator
> after the loop is undefined per the list_for_each_entry() contract.

Thank you for removing this hack, though I don't find a contract in the
list_for_each_entry() doc, and the fix still accesses a cursor outside the
loop. Since you mentioned C11 UB in another email, do you have more info
on the precise operation which is undefined in the kernel (container_of
into an invalid object or the &next->list addition)?  Just so I can avoid
it in the future.

Anyway, thanks for the patch. If this is just general cleanup that's fine
too.

Reviewed-by: Jean-Philippe Brucker <jpb@kernel.org>

> 
> The loop only needs a list_head as the insertion point, so iterate with
> list_for_each() and keep the typed list_entry() dereference inside the loop
> body. No functional change.
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

> ---
>  drivers/iommu/virtio-iommu.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 587fc13197f1..1d58d6b626a5 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -486,7 +486,8 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
>  	size_t size;
>  	u64 start64, end64;
>  	phys_addr_t start, end;
> -	struct iommu_resv_region *region = NULL, *next;
> +	struct iommu_resv_region *region = NULL;
> +	struct list_head *pos;
>  	unsigned long prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
>  
>  	start = start64 = le64_to_cpu(mem->start);
> @@ -520,11 +521,14 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
>  		return -ENOMEM;
>  
>  	/* Keep the list sorted */
> -	list_for_each_entry(next, &vdev->resv_regions, list) {
> +	list_for_each(pos, &vdev->resv_regions) {
> +		struct iommu_resv_region *next =
> +			list_entry(pos, struct iommu_resv_region, list);
> +
>  		if (next->start > region->start)
>  			break;
>  	}
> -	list_add_tail(&region->list, &next->list);
> +	list_add_tail(&region->list, pos);
>  	return 0;
>  }
>  
> -- 
> 2.34.1
> 
