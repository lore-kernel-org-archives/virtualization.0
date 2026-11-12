Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794502284;
	b=QIdYsc4I7tDq5aD7k8Mss+2gyigSHeTZv3SsTmiyAklKqO3cD0/lfHMjjPG+U4OdNkFQ
	 2iLADlxf/FhYu/mA4XHQ9FREBWXGSgKhEikGfXyk8BJsvQqCFIr72JuZ3BM8zYoPaW0uu
	 UoKCmtdifTG67k1k+1/QZrP2WcYNgeJACRdTX2lnZvg24zj13eKnJY2vnwsoPhW0gy1+U
	 oedxNhvAb++BE1Fx8/WPsnOFrEe1BUM/JIZ0pHWyOa1B+Ty3afI2WNjfP1PHc4jvS9Wxo
	 /HEYu/SleI+eyk2MmtK+LzvatqNgf8kRNeI03aNThAkF75NbEnTTuGPaWmS2r8+NkHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502284;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kgfUPBxbDRkbIF6KE6+Wu7RphyBFCTkPZhvW+1RR6jg=;
	b=tltsgaM5oFF+zolrAxuxhRYEkhih0VL2tnrRsCllIfb+4LGqJi4J46HSAMQonLQylj6V
	 30ssb/8cFJ1QA3OsrerxNOEmDf9qTMavYImqXmIkqr742oHr4mg0j7S8MbysofTRf/6hX
	 7EIgukOWCAbsBlKokDrUWIT5ILWDQgdnUmbHSu/e10SHGZ1WGRIsLAGtn8x3kyufYGd8g
	 zjxwovb/azP9VhiyGuzgmGpsr0lQT1XgoIJzt1Ru0VzV9syH6cAbLgLZ5dFUPXi+QmERL
	 dCwP5Vk/ZzECuK7uKDIkPjdNskDkUdWBALdISNGsjepnJg/Z2S0pzEI1K1AQ4oTeSDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BteL3paI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5BC606A31C;
	Thu, 12 Nov 2026 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BteL3paI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B9B1F000C4;
	Thu, 12 Nov 2026 16:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794502284;
	bh=kgfUPBxbDRkbIF6KE6+Wu7RphyBFCTkPZhvW+1RR6jg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BteL3paIhw+DwolkCwBN+JF3ujGX2+Ikob0iRrDNt0yPZ/e4E8TtkTn3nQtpeiOcx
	 LfM6sGbBUR+1aJlm4WepPaR6PVMr9F6zkarNzdk4cUVIMxx2QmkHZTBm5fNqaMOrSv
	 cV0Txz4NBXiCQFKphRo9krfLcjcEE+8alGG0ps+UymUAT0sMmkN6hs4ptDGB/gWFjS
	 lyq84g7qdVtY7fYHcIKxDrys3ZQByMS8ahzjQcBqtJPHzhPLQ0S4LIwk59z83rO+2d
	 bthbVKqQgJm073tstetOT5T19g0K+vqpV1Jt24BrsqIz2KzLd6veTTl6prCaA+pwF/
	 GT/vabF3w3jOQ==
Date: Thu, 12 Nov 2026 08:51:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Longjun Tang <lange_tang@163.com>
Cc: mst@redhat.com, eperezma@redhat.com, jasowangio@gmail.com,
 xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, tanglongjun@kylinos.cn
Subject: Re: [PATCH 1/3] virtio: add virtqueue_get_last_used_idx() helper
Message-ID: <20261112085123.276997b4@kernel.org>
In-Reply-To: <20261109094310.103979-2-lange_tang@163.com>
References: <20261109094310.103979-1-lange_tang@163.com>
	<20261109094310.103979-2-lange_tang@163.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Nov 2026 17:43:08 +0800 Longjun Tang wrote:
> +/**
> + * virtqueue_get_last_used_idx - get the last consumed used ring index
> + * @_vq: the struct virtqueue we're talking about.
> + *
> + * Returns the index of the most recently consumed used buffer.

kdoc needs Returns: (missing :)
