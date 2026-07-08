Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D366843932C
	for <virtualization@lists.linux.dev>; Wed,  8 Jul 2026 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783527880; cv=none; b=YAubh1VL2J6nJoUmeTozwi9gMUt6lgdAckA0GdVnaZohSgkp0DwzM0tY7UEjLkDLsVgMKyd88bAoC7iN5KOIfeEYSy5MrB6TROjl8WDXHUZ0WoIIUQpkBx+kIvOa49x/ixShHNVsyJsrM5HEHN/R28Q+qC9mtrmMQuGLJ42rImM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783527880; c=relaxed/simple;
	bh=ctHH6AeqN8ieWSSWnaVJOLb16nkCvz2lOMAZwspUqms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsTHoFayYPwjMHSaIs1P4IxtnwrMMovfi8XaNi5uP5t6afOn8wQaMp41eybFA7f0iIH8D4AV54Noceeaqaq8hY73heDMJ3Lv/CXMrIaJgrXb/IdzrKfGbAq4VPBa41dBL9XtieL+nPGsdH+iYKEWx9Vf8AYh6Rx79BTf5s2Coco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5975668BFE; Wed,  8 Jul 2026 18:24:35 +0200 (CEST)
Date: Wed, 8 Jul 2026 18:24:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Baokun Li <libaokun@linux.alibaba.com>
Subject: Re: [PATCH] virtio-pmem: use GFP_NOIO for flush bio allocation
Message-ID: <20260708162435.GB2502@lst.de>
References: <20260708124238.2817165-1-joseph.qi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708124238.2817165-1-joseph.qi@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 08, 2026 at 08:42:38PM +0800, Joseph Qi wrote:
> diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> index 4176046627beb..081370aac6317 100644
> --- a/drivers/nvdimm/nd_virtio.c
> +++ b/drivers/nvdimm/nd_virtio.c
> @@ -117,7 +117,7 @@ int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
>  	if (bio && bio->bi_iter.bi_sector != -1) {
>  		struct bio *child = bio_alloc(bio->bi_bdev, 0,
>  					      REQ_OP_WRITE | REQ_PREFLUSH,
> -					      GFP_ATOMIC);
> +					      GFP_NOIO);
>  
>  		if (!child)
>  			return -ENOMEM;

This NULL  check can go away now, and probaby should to avoid confusion.

Also bio_alloc allocates from fs_bio_set, so if the incoming bio
is from that, we can still deadlock.  We'll need a separate bio_set
for this to be deadlock free.  disk->bio_split isn't otherwise
used for the drivers/nvdimm/ driverss, so you might be able to
repurpose that if you want to be creative.
