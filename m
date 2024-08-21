Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F06166314
	for <virtualization@lists.linux-foundation.org>; Wed, 21 Aug 2024 05:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724216819; cv=none; b=RWtJFHEoz8/Y9zvkFC5u+DGY75zQpWYFBcIOAm+xQuzXxOq4klPvVVulnfId93dbD2KJwODtOh3VxAaFUPRYC8jMoxlP0/Qz1xiL1HmLYPl+6nwbipy4Rv51HUzqIDUtMg5O6mOI+essNIiGLj0sVetzOIc/4hNq6RKNTiPfHY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724216819; c=relaxed/simple;
	bh=2DshrC2wPT+HqiB+wk4KnOX9Ljc4ztK2HKSMQXVrYLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQBg7tGZDJW3fJj4uBL4e6dBQLEtkVV171+UCDBFRaQFHdcTzxo+biVQvHk7pljWOjGPxYyl+OOi4m4/k1T9glGE4TNo3ke2JwbufVAC9dDvwfrjYB/UukWKohJHq7pfjE4WSYDqAl/Mszr/hiIyJRFDpdumXbYEc9U+Uer7ZdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BKAGViLS; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BKAGViLS"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 315E9812E8
	for <virtualization@lists.linux-foundation.org>; Wed, 21 Aug 2024 05:06:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.398
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lZ3-rMKrtmsJ for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Aug 2024 05:06:55 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+5a17de65a486cdde784a+7668+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DC703812E7
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=infradead.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DC703812E7
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BKAGViLS
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DC703812E7
	for <virtualization@lists.linux-foundation.org>; Wed, 21 Aug 2024 05:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2DshrC2wPT+HqiB+wk4KnOX9Ljc4ztK2HKSMQXVrYLc=; b=BKAGViLSWfMEJV0625RQ5Nq6YW
	fi6KD8w33W2oBpV8nDnmQn4n5XZhE7NWCdJX1vR92gC/C2Rc/JN/5GH7No5gIXKb+IhkCWF6U/w1+
	FKtxs9AzgguhFbmbvIj7Y9A3Kkc766zncuPmer7xuHjTrSI1QgHyq2i/qCT6IyZDZb3U5h8UVDt33
	jEKf9BtzBh5XnDGEfKlzqzgVL27hQ8tf8zhK3vndQelIRwIqNXWU7fmnNCqR5zo+rJPWiiC2UT6Um
	1EtOAkYu2IXLmDvJMhEwE7q3WdZ92UoHDS0flRqw92bUZNVn7SqMdetD3FdKyd5TowJSmXaw06umI
	evK8eohA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgdYa-00000007XQL-47dr;
	Wed, 21 Aug 2024 05:06:52 +0000
Date: Tue, 20 Aug 2024 22:06:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [RFC 7/7] vhost: Add new UAPI to support changing Kthread mode
Message-ID: <ZsV17ACIEelIQuKx@infradead.org>
References: <20240819092851.441670-1-lulu@redhat.com>
 <20240819092851.441670-8-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819092851.441670-8-lulu@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 19, 2024 at 05:27:33PM +0800, Cindy Lu wrote:
> Add a new UAPI to support setting the vhost device to
> use kthread mode. The user space application needs to use
> VHOST_SET_USE_KTHREAD to set the mode. This setting must
> be set before VHOST_SET_OWNER is set.

Usage of an API is a complete kernel internal detail that has absolutely
no business being exposed to applications.

What is the application visible behavior that the API use is the proxy
for?

