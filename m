Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C263286D7C;
	Mon, 30 Jun 2025 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751290726; cv=none; b=dtBpYqOJlpRFx5PR4xCHWeVJN5/np+vQQc2XxwjstExsgsGeQ5Hv314/wyMASDu82CTgpJtTOnpARtzvY9TDvGxd43OFG+YuZTdoQjYGQlbi3C2uMz0I0yJVf+kT9NQw9ABDaK3XocGK4uoRtryBskJFq2iBnzYlh7TknkW6MwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751290726; c=relaxed/simple;
	bh=LZiG3HgLUNmpOImgoNORgqbqT6uE7HpQAw31fKnOkVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXDcJ+sP0+vx0O8PGhWfen0TUSYPKbQE0dMAamp4SmBX1qjW/vYa/n+qsB5dgL5SG3Gmu72PmVkCPHvE67YePyVptg1+WBFe0/S/wrbe4qn2YMlZFsDKzEdVr+wPextp7NR9izwXquJuno/8ZaGKRPCWyVWIHqqMp99skPOukH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BF34B227A88; Mon, 30 Jun 2025 15:38:39 +0200 (CEST)
Date: Mon, 30 Jun 2025 15:38:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, iommu@lists.linux.dev,
	virtualization@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 0/8] dma-mapping: migrate to physical address-based API
Message-ID: <20250630133839.GA26981@lst.de>
References: <CGME20250625131920eucas1p271b196cde042bd39ac08fb12beff5baf@eucas1p2.samsung.com> <cover.1750854543.git.leon@kernel.org> <35df6f2a-0010-41fe-b490-f52693fe4778@samsung.com> <20250627170213.GL17401@unreal>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627170213.GL17401@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 27, 2025 at 08:02:13PM +0300, Leon Romanovsky wrote:
> > Thanks for this rework! I assume that the next step is to add map_phys 
> > callback also to the dma_map_ops and teach various dma-mapping providers 
> > to use it to avoid more phys-to-page-to-phys conversions.
> 
> Probably Christoph will say yes, however I personally don't see any
> benefit in this. Maybe I wrong here, but all existing .map_page()
> implementation platforms don't support p2p anyway. They won't benefit
> from this such conversion.

I think that conversion should eventually happen, and rather sooner than
later.

