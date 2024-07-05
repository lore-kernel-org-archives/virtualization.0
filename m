Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3AB13C813
	for <virtualization@lists.linux.dev>; Fri,  5 Jul 2024 12:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720181765; cv=none; b=siq31bWHC0stvk0gb9snTUfr6p76BdPRC6GwxUGXZeXA8oUVIyn6QUpsQFLx3gO6CbIUO0b3eG81vKoTKgEBDRQIHm9E3uFUiPCtYM5vI+X/Nl4aRWvtTy/R8e/kSBFbRn/i19CkJ4mFkjCypK6zRrJj5/vtOcvvhHudc/iuhU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720181765; c=relaxed/simple;
	bh=I43DRw7otkXHsKoWmisLdjj+YD0m5AZCSKGKARZltQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9rjfmHiyRQDKll6kODI7DTwEdk2FckO9IxUzlV4S8GEu1WWJUiRC664MmTCP0t8ZPy/McdmW4vqT/HR8QJnWEk2vbz5zOee8EKXmxfWYMUwIPkjk5qmJiLiaIkxfOC7GScxoNbkYBp+1VRKLoGBkjWbMvL+0YMmCG5PIxWx848=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3E59A68BFE; Fri,  5 Jul 2024 14:16:01 +0200 (CEST)
Date: Fri, 5 Jul 2024 14:16:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	pbonzini@redhat.com, stefanha@redhat.com, hare@suse.de,
	kbusch@kernel.org, hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 2/5] block: Validate logical block size in
 blk_validate_limits()
Message-ID: <20240705121600.GB29559@lst.de>
References: <20240705115127.3417539-1-john.g.garry@oracle.com> <20240705115127.3417539-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705115127.3417539-3-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

>  	if (!lim->logical_block_size)
>  		lim->logical_block_size = SECTOR_SIZE;
> +	else if (blk_validate_block_size(lim->logical_block_size))
> +		return -EINVAL;

This should print a message.  Unfortunately we don't have the device
name here (for that we'd need to set it at disk/queue allocation time,
which will require a bit of work), but even without that it will be
very useful.

> +/* blk_validate_limits() validates bsize, so drivers don't need to */

maybe throw in a usually or normally?

