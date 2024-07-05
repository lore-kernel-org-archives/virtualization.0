Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF04314A4CC
	for <virtualization@lists.linux.dev>; Fri,  5 Jul 2024 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720181699; cv=none; b=Jc+YPniAGJ/lJ/g2Ma/mursCPv2252B94oYLZD+k5myEmO6zxbGEKfP4VyFhxUWyBPbCju9oncRj0M5nO/fqV16Z42bWa/Ot4KLzhQhddCturvz/HpJ4TwbSIbJTUOXJLH3bkUV+PlQIb0JetYhISZvYFsDtXH0m2/LYrX0Wu+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720181699; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aX+hJmpQuAKxsesyBvx7KwOfn14o7lE3xGOV6pEFDq5t7D01WSWiok+ZVNoX4YFQvE+M9erycHga5XBaeblPFDZlkV/xocO7QzxpeVAufP0MQ8fYF3zvR9yA3gjnrkPk6md1SQst0v5ii4CpW7hPF6mb3zfHGfhPFpxGT7fY4ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DAAD668B05; Fri,  5 Jul 2024 14:14:53 +0200 (CEST)
Date: Fri, 5 Jul 2024 14:14:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	pbonzini@redhat.com, stefanha@redhat.com, hare@suse.de,
	kbusch@kernel.org, hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 1/5] virtio_blk: Fix default logical block size fallback
Message-ID: <20240705121453.GA29559@lst.de>
References: <20240705115127.3417539-1-john.g.garry@oracle.com> <20240705115127.3417539-2-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705115127.3417539-2-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
