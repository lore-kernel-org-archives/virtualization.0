Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B21AF9FE
	for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 06:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737527577; cv=none; b=eRxDtRY4VkeOPGfF+Ht/mGxP2bWo9XQM5n0hkJzMvua6xTRnenkpm9p9ZwLd8hYT5z0Osj/6muMa+B6CIeXpMjy9aIYGV0LqyHXqFlYvID9lWe0ckrNGyiOYEMVmSQF4vaCaQmdh2vqa45VdCKLbRD+GKrbJZxI/1nRyNS8mQ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737527577; c=relaxed/simple;
	bh=GYJzEwIQBHEGL7aDYcJ5bTXyzU9977MRchbIzgX7Uuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEOX3N+9qlxXYpSqLt9mpZuhL7pQEDUvAilGB5eG8Wekvz2OQMQxykpfUmgPuCyUpoUojBmovvNtoI4lB+x/aUa/E0tazdhiqPiOlNyydN7mKD5kMnKaNXSxBMWy22bIgRw18WcAJIgSgWO1BGgHGy3SaBBue7EGyJGx3V8APjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5197C68D05; Wed, 22 Jan 2025 07:32:51 +0100 (CET)
Date: Wed, 22 Jan 2025 07:32:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, nbd@other.debian.org,
	ceph-devel@vger.kernel.org, virtualization@lists.linux.dev,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/2] loop: force GFP_NOIO for underlying file systems
 allocations
Message-ID: <20250122063251.GA31207@lst.de>
References: <20250117074442.256705-1-hch@lst.de> <20250117074442.256705-2-hch@lst.de> <Z4pFgIqB50gz-ODi@fedora>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4pFgIqB50gz-ODi@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jan 17, 2025 at 07:56:48PM +0800, Ming Lei wrote:
> If we call memalloc_noio_save() here, setting PF_MEMALLOC_NOIO can be removed
> from loop_process_work().

Nah, we can skip this patch as the explicit PF_MEMALLOC_NOIO does
everything that is needed.

