Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40B36BB54
	for <virtualization@lists.linux.dev>; Thu,  1 Feb 2024 07:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706771433; cv=none; b=j/j3lAGAuxzZcojkbOBZcffSkt1sQeIeuxPf6cbr7dWpA5eWlVhaQ31GSfFH8fFu20BCKEwDMiJicpgD0mjKXU06c6oVCcXbD5ZVOfEkMxkB6JtYzaNKgefNonF4Lmu6s31RMCguBOLbOnhKXGy+LP/qkTMFkokIRIB+6TxQbpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706771433; c=relaxed/simple;
	bh=7ThMcqxMWMFAzFSiypcx8eQwh6KrhQ8ur72LvKcKoHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sa2OTrGe7+aV24WxJ2N8ENc2o5R4A14t8q9xrNGCyLJJJv5GH7H7dt6CddB0bTSEZ9Ofk+GI8BnVLmJlbzcNoCM07zArTW3P1ocFiDgoKjLXUO2y3PIRIDltmvoB5sxjyTOfdAePSEdb7sM/rvF8Z+x2fKJffvN9KA4fIPqmHuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EC02968AFE; Thu,  1 Feb 2024 08:10:27 +0100 (CET)
Date: Thu, 1 Feb 2024 08:10:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: Re: atomic queue limits updates v3
Message-ID: <20240201071027.GA17571@lst.de>
References: <20240131130400.625836-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131130400.625836-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

I don't want to spam the list with a full resend again, but I've
updated the branch here:

   git://git.infradead.org/users/hch/block.git blk-limits-base

   http://git.infradead.org/?p=users/hch/block.git;a=shortlog;h=refs/heads/blk-limits-base

with the bisection hazard found by Keith and the various review tags.
