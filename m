Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAD07261A;
	Mon, 23 Jun 2025 05:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750655347; cv=none; b=BabUM//KVANH7PSCRxtIPN4qHgzUg25TOEhENqIXxG7kQg71Pu4dx8CH8mLDRDGCwfZBbMrTXLQHqgMV8zQkHe2VQQ11i9835ERmV1LHMCNS+mhB5lMiPS4fG/jMvSv4uyrtEUSYLSvEMkSqEh92c7iJGGh+idqnGAUPzM+WSQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750655347; c=relaxed/simple;
	bh=6iWlujoY50kerxQF35ybfPM2DMpHKWvi0bipvqJkT10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIdLNcIDhSq3Y71YhS89uGwjFL+xnd5SZm89Pt80jLqDEe/zHu+FpPVkCYYmSheH5Hg0ze3JQcvR0zTlzglSPz/oeZjZkNutKGf5jyl/hurhRyGDaQldQOnPAdkxnWb4U7myW0jzXzRYDvZVXqxWp51vPy2Q2qC+/x9qEPAndQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UBc+fN4R; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UBc+fN4R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IWYX9UfQNxtgOzFexY+WFuS+DowB6uedUOfP1xT8sZg=; b=UBc+fN4RFLPykqGB06dxJsdxcm
	DBEecUGA3/YBwSXVsi+bQEZz5YAy4UtVpVjrSQkboMQ/qDrrkgvaN7hAGUrt6EyXDrEsJBl8SxeHQ
	y2AUdYTExlmRa7eesbMYcjRvQwZ1lPuwuKdZKAbf6T+iHqptLVSV3Qn1OGqwpWbsxuJOQfxwKNKjb
	xLHZNTnXmBf+eqrS6BbSkWK1EE4cihjqA9TktpFltzH3XKJNIIxiTV1QyKnRglClVhvm/nrba9MDx
	EZUmGEHTA+SSSidLFErvg109P1T2JMmD/FSc12mjcWoZ1pJDm4PAe5DEnDLL1I3yTj+xst0DFDh7G
	d1ctTaHw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZQS-00000001ajw-0rDN;
	Mon, 23 Jun 2025 05:09:00 +0000
Date: Sun, 22 Jun 2025 22:09:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, jasowang@redhat.com,
	Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Laurent Vivier <lvivier@redhat.com>
Subject: Re: [RFC 0/6] Add multiple address spaces support to VDUSE
Message-ID: <aFjhbCnEI7KZW8Sr@infradead.org>
References: <20250606115012.1331551-1-eperezma@redhat.com>
 <aEZ2SYAXdqffWoqk@infradead.org>
 <CAJaqyWek+ckdXFZdhpcXwDB7a5X=PMSktEADVpR5Nbi-n+MR0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJaqyWek+ckdXFZdhpcXwDB7a5X=PMSktEADVpR5Nbi-n+MR0w@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 20, 2025 at 08:25:50AM +0200, Eugenio Perez Martin wrote:
> This code does not touch the DMA API at all. Actually, we could even
> remove all the DMA code and these changes would work the same. Can't
> we just continue with this series and remove the abuse of the DMA API
> in parallel?

But it touches vduse.  And vduse is marked broken because it still has
this long standing issues.  You don't add "ehancements" to code marked
BROKEN begfore fixing that.

