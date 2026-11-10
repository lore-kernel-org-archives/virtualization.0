Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338381;
	b=YAAidrFI/Oqw5I0Bz0G0peH/oXSGihWhKtOhTqQbuUGVo4NHWg9cHLQujJi2e51Wv+V7
	 HeuwYkbBQIlpYrDpwFAXot3GyI1D1oPz493Ohg457xHVXmpTobc5q3B3M5eUfK1/hHRlj
	 a1luZu9qcv6HowpYs4U6k8/9gqWU8AE2ogaGIfEfQYrIRV1t+uV96DS5Qu35BE3N10xbX
	 0ElfV1/GEMpdFxdYGvIzgishp05KTnotIbPpAY/uHl1pVYRLXQIh8y6dG0kgc3WKUcWO+
	 x1xW3O6s+RkXTC87tkEBT6kKHwVAj/utu+uWwiYJgZj+ESVMSPFEqJT+k4sjRWxxh+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338381;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=lgBsX/4ajBlOSJuEQTW3U4syAbk3rWHkGnOmGP2zj/M=;
	b=Ih/q6wIGBNQB1xvNeq/XPmkfeVxKmoDjlcSQGZrqagC91EbQPzg3hRjQpOpnHlvqk16q
	 wJCfBosWJQmpz7T1odgjKVoyGpep2WgnAn17NIaFl2p4sKqCC9XS/2T/2Axy7glpUuQ1g
	 mYl9AEVYoa312z5Di5y0DGfy6H+FstgUkR3Eq4WZoix0AXSC8rfGu9/1AUxENMOGjy59n
	 pdReKri4+5ET5J4kB6D0OglxgK2bk1muicGNsEkk4Z3OylnFrSPbqU+SBVeRYJ3hmEyJW
	 xzUz2m+Z7DNRdrg0XdNWAiNKikNEFI31Urvfa7vBbkSkj/Gy7JzMv9c4VlMNr93CF/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=b8wcirio;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A848A606A320;
	Tue, 10 Nov 2026 19:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A848A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=b8wcirio
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lgBsX/4ajBlOSJuEQTW3U4syAbk3rWHkGnOmGP2zj/M=; b=b8wcirioktk1V+I6cLxgnytfHt
	s+1gNzt+oNaj/8v1dB/y2ooHBs+sOIEHLV1guXHLK59Y0ipc+WH3YGXTdpmoCXAVaPIlKaFOebP9x
	Q5IjU/RAw03kchBuA4YhIuHn67fv4DvrG7GM8mSEoFF6gG8Ec3W2gJu2wrjCdEdxI6RsFxbL/xc8a
	rV8WT7MV79m+BKLbPEao/T/+olEtQaSWrcoxh4kWVD6r5loEe6lhcQZCaufTxfC9qjGpluQcQn8/D
	cRSHrQc9aTr9kcCKqogmnDRYf/CTOej2gLRp010jpVxxjtaJOi3Fc/5efWuKRC+T0KSc9Jq8nypQT
	BOKCuF3A==;
Received: from willy by casper.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQrNT-00000000PMy-0Ax1;
	Tue, 10 Nov 2026 19:19:31 +0000
Date: Tue, 10 Nov 2026 19:19:30 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Miklos Szeredi <miklos@szeredi.hu>, Amit Shah <amit@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>, Bernd Schubert <bschubert@ddn.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 1/4] virtio_console: copy pipe buffers in splice_write()
Message-ID: <avNuQqLf9CG9dSsE@casper.infradead.org>
References: <20261110145241.536019-1-kas@kernel.org>
 <20261110145241.536019-2-kas@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110145241.536019-2-kas@kernel.org>

On Tue, Nov 10, 2026 at 02:52:36PM +0000, Kiryl Shutsemau (Meta) wrote:
> +	page = alloc_page(GFP_KERNEL);
> +	if (!page)
> +		return -ENOMEM;
>  
> +	offset = sd->pos & ~PAGE_MASK;
>  
> +	len = sd->len;
> +	if (len + offset > PAGE_SIZE)
> +		len = PAGE_SIZE - offset;
>  
> +	src = kmap_local_page(buf->page);
> +	memcpy(page_address(page) + offset, src + buf->offset, len);
> +	kunmap_local(src);

	memcpy_from_page(page_address(page) + offset, buf->page, buf->offset,
			len);

> +	sg_set_page(&sgl->sg[sgl->n], page, len, offset);
>  	sgl->n++;
>  	sgl->len += len;
>  
>  	return len;
>  }
