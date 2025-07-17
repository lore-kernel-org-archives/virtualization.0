Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03741A2541
	for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752758766; cv=none; b=I5k+y4kgKKrQ02s0gZGUOM+iXsxN85P1aq156A4T0Ul4PhQv5ImBnlmuPvAJvZZH0WfPExPhpdTAKB8qs+VjQkaoz6zhhoMi+MXIdxur3Gpj7FA1WMdNmrCqdve9iEZq4ODCyITBKNCxL8Ge4icJMvUouwf10BANY95eI2yW6fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752758766; c=relaxed/simple;
	bh=IU1dF5lwv8rt9bIv7aasD/ShHa2ae6HGq+CqFRQWRTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWdsna5ctHKIh8zlS7JWRpof210Dm3EyQ8+ktQJfd2N0UKEiJB2l4ui2f6XPY8KnDo6nby0JcQjmWjjGACwSouS/WiW5nN1rwOR/RxIRnp4NGP2YKU0etRUp8pUjWhBbI6impB/KW19Bmf5gupjXjaQI8T8HkCzP36vWrno38XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oLB7z9lc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oLB7z9lc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IU1dF5lwv8rt9bIv7aasD/ShHa2ae6HGq+CqFRQWRTA=; b=oLB7z9lcAWlLP6uqx9HLvIcPAA
	qmEFABnnfnewLS2fVddCKKvb4/pefgv6013K9GROA4ESV476gPy28nnfNd6cHC0I3IMuI9eRXLOdL
	nXzsl2T1jCQdsVdYcAfY307PVNVbnssXiUTK0cfbZ7wsBeDpdFV4iBXYOHtg3H4hKx0+nsP8mGxPm
	1GcU1OO7XFd8NhSjR/LZAoi0qKZ2t4IP7qOv+JtOuk5GZCi5h0AarC/9d/c31lZat6hb0cHrKrxeI
	88iEzr+ype5BTbOczZN5dPtTw48NtCbj2ShGY9513/owHSLLd7z7Rth0xjedghlW/6R+9pK67sh1b
	mEVfqWPw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucOcb-0000000AFfF-2m6e;
	Thu, 17 Jul 2025 13:26:01 +0000
Date: Thu, 17 Jul 2025 06:26:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev
Subject: Re: [PATCH V2 0/9] Refine virtio mapping API
Message-ID: <aHj56eMSTxR6wZBi@infradead.org>
References: <20250717080237.6518-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717080237.6518-1-jasowang@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jul 17, 2025 at 04:02:28PM +0800, Jason Wang wrote:
> From: root <root@dell-per760-18.lab.eng.pek2.redhat.com>

This looks wrong, and will give really odd author info when committed.

Except for that and the Kconfig nitpick on the last patch the series
looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
