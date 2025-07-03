Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C402D29C8;
	Thu,  3 Jul 2025 08:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533030; cv=none; b=l53SyF1ULEbyaLOF0qEm3ODNaL3dNT7ZAtGoapiWPWn7EkXxMFPOILidAkASf7fOTonlqaGF4tEnQDA1WznIF0ODFvgvs4ViJ60rbXNqX1Yr4FdCkiLjy/24xmh5nMkUu4HaM+GeWaBnXg/V+irCC6wUFtyQniBDgsNH9hyR11c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533030; c=relaxed/simple;
	bh=NFW2YyTqEtJaZEFW122fYjnxT1eH+RBQ4tejPPFMRCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2QhSo/hhX/2msagvFZaCeM7FHWqznVef/worDkW+TjFoB4jf/sp5iAccsbzxyGLCA//JHgTPEkb+surAuZl+c6MuVnZpV1GtHhebmTn+TSJi2pjMdRlIl9aQB9WIQNTVWzmZdmeMVhc33Ex7cts56LLOZ/FQ5hoW9livwTV6pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mBrdP+dT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mBrdP+dT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7v+FVph2p3AjKUXXMP962eD76NtSca8p122IP5PfJck=; b=mBrdP+dTWCx2IeD12Mcjc459U7
	StfEKWNoxulXdMYk5WiKT5+w1eKkPakUmCOz6ef/r/TTPSPeCbaan+lpZv6L8rD4y5Esz+1LdDfhC
	ocgQo/0dF+d7PCZC+PbbGiuiCOB9hmOz90fnW6eZUr6Fwnf+Uw0yrXPt3hGq6AsDyN9NOjMlNAVOk
	gAs/NiZ7QrQfDCKl2/3oDSRFW4zxx7Q+o+zLTAcGbrSxcIMfinYM6wFn3wCioRIQzc7GqPmbxycdM
	D5dq/e/VaLMiYUa6RUr9veQIwIeQXu8vQymBGLzH6YSB8lbG29oV6WxPvRxt5QdrDn7Ir7i9ikRXZ
	Kxz5ROqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXFkh-0000000AkgY-3XwQ;
	Thu, 03 Jul 2025 08:57:07 +0000
Date: Thu, 3 Jul 2025 01:57:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, hch@infradead.org,
	xieyongji@bytedance.com
Subject: Re: [PATCH 0/9] Refine virtio mapping API
Message-ID: <aGZF4025JPO3wgnm@infradead.org>
References: <20250701011401.74851-1-jasowang@redhat.com>
 <20250701030150-mutt-send-email-mst@kernel.org>
 <CACGkMEtr+Rwu+imU1rLtLLQxY50sNzCC8gi8sE4xVhCoDphJwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEtr+Rwu+imU1rLtLLQxY50sNzCC8gi8sE4xVhCoDphJwg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 01, 2025 at 04:00:31PM +0800, Jason Wang wrote:
> Actually not, it doesn't change how things work for the device that
> does DMA already like:
> 
> If device has its specific mapping ops
>         go for device specific mapping ops
> else
>         go for DMA API
> 
> VDUSE is the only user now, and extra indirection has been used for
> VDUSE even without this series (via abusing DMA API). This series
> switch from:
> 
> virtio core -> DMA API -> VDUSE DMA API -> iova domain ops
> 
> to
> 
> virtio core -> virtio map ops -> VDUSE map ops -> iova domain ops

And that's exaxctly how it should be done.

Thanks for doing the work!  I'll go through if I find some nitpicks,
but the concept is the only right one here.

