Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02750155A24
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721826822; cv=none; b=Y8B4wpUDyrBGy8s9IlWiYSHCNuGWaI/UpqOLoe+ExAn1srKfgHN9pPZtey6yhkjVmkjqHgZxhYOBWsiFMEHfwuGdhIFNvmS9z+bXAa7xoeVQIxvFOfHYq1JayzN4mdPHKi9kfj4+iODc+KYM7V0n7mycx9bPF+tvv+WAxZKpebI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721826822; c=relaxed/simple;
	bh=rbZLnOtG2SmuY1lu5j6wYUvjtthdEY/rDRh0FfZv54o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjWTm1zDeoOvApwNAnBTGSfiyYiec0oBWddYtPCKpxS9rPJwUR8CNfzHCHB9o9Ycy0yJjwRgd8qDTzXeUuBbEHCxIIl4eTJPJAvuLU/felN4OT2HNUM7s6uzvlHeuNjFlV0O6y0DBEwHJPNXMImPTH+MtRlW2ZWYlOnnPzvj7qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3vx96B+2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3vx96B+2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GrETT9VNYgf4d47jWkFIpN9IEwQQPLWYKreKr1WWr1Q=; b=3vx96B+2AKbxghePVkvsvr85rD
	J61zwAd47IVwiRFL8jB+jlta7RDYg23P8V6O+496ZCq/3eJP1nSL7N0RNeSY4SKEQykkttvvkx0RQ
	4lZeKtEcEohMLkRXch8halPBdQ2HBcdEUwLal3MAnUGfDrW+WSnvhZnnJTR4Kvlly4Rri1+8vsl7/
	3RmRzSZHw5Dl8LLj7lBnch0LMfcTv8T04rpsrx+DQS4tAn4bLZk1jX/YixdIneJg+lp8EmdgeKaev
	GSKP/tnB77i7DChCzSRA/qW1AjZ4dLX0h43JW7Q/qbvDQFpq+wuOyS6Av1MvV9I4Js57stgiVZQFk
	IKDGDCvw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWboB-0000000FPaX-43uz;
	Wed, 24 Jul 2024 13:13:31 +0000
Date: Wed, 24 Jul 2024 06:13:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com,
	hch@infradead.org, iamjoonsoo.kim@lge.com, lstoakes@gmail.com,
	mhocko@suse.com, penberg@kernel.org, rientjes@google.com,
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com,
	virtualization@lists.linux.dev, hailong.liu@oppo.com,
	torvalds@linux-foundation.org
Subject: Re: [PATCH RFC 5/5] non-mm: discourage the usage of __GFP_NOFAIL and
 encourage GFP_NOFAIL
Message-ID: <ZqD9-yzGxQIFlxGQ@infradead.org>
References: <20240724085544.299090-1-21cnbao@gmail.com>
 <20240724085544.299090-6-21cnbao@gmail.com>
 <68ee812b-3b96-4c8b-9a54-70d4742488bb@suse.cz>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68ee812b-3b96-4c8b-9a54-70d4742488bb@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 24, 2024 at 11:53:49AM +0200, Vlastimil Babka wrote:
> GFP_KERNEL_NOFAIL which is GFP_KERNEL | __GFP_NOFAIL
> 
> And probably also GFP_NOFS_NOFAIL and GFP_NOIO_NOFAIL (sigh).

Let's not add these and force people to use the scope API which
we're trying to move to.  I think we should be able to simply
have GFP_NOFAIL which includes GFP_KERNEL and no variant.

