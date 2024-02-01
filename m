Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB26157E89
	for <virtualization@lists.linux.dev>; Thu,  1 Feb 2024 07:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706771051; cv=none; b=gZ+nKy10D8wEdR0B7YwHTawtzg094D8//lDu13uYKzY1rVOIdoJV/CL35Yim2MC2bJKVUGpRT/4V7qG//XRPpCrG++XrBkGjja5JdE3EQD+Ia71dhFYxStCU8XJsIvo0Mdran08MzMwcR4DKINBG8ovB3XtXX28H7Pn3llqiNkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706771051; c=relaxed/simple;
	bh=NReHrCxnEObsR8kjXt1VLycYyw5s1+VRYfIlVlsRyt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7dd1ex73KF812YirqXAAStJjRa5ieP1o+GQCVYDVCfLU6Wz+TzEkVXFJl0tRKJnD0iiSMLAAIxkSiUQfVyomPk+RTt92Zg23ZONL7VKlQvFtdtay0Wg1GzkHSWD/pxQ3ExGwaM1HN/HGC2G/7tjUo2TMeyqymbR0/D/Xg0rwbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9E0C168AFE; Thu,  1 Feb 2024 08:04:03 +0100 (CET)
Date: Thu, 1 Feb 2024 08:04:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: Re: atomic queue limits updates v3
Message-ID: <20240201070402.GA17262@lst.de>
References: <20240131130400.625836-1-hch@lst.de> <yq1o7d1qeax.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1o7d1qeax.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 31, 2024 at 06:26:49PM -0500, Martin K. Petersen wrote:
> Looks nice in general and avoids the annoyances I had with my discovery
> series wrt. discard. I'm in the process of rebasing that series to fit
> on top of your changes and things get cleaned up nicely. We'll probably
> have to coordinate the sd changes a bit.

FYI, I haven't really started on SCSI for a bit of protoyping, and it
will take a while to get to it.

