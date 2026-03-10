Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9582B3D47C9
	for <virtualization@lists.linux.dev>; Tue, 10 Mar 2026 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773146049; cv=none; b=IWIP6upJnXVx22Mn9y2lm9X6XpvzQxXAl9+0j71BN0CuSm19PTF1GESc+u5IN+wXPsesvmXyTeH8UnOQ3mR0XHUZTJwUWn8Jq02mcQS5RMYLVYVDtkjvYNtoJNGILpMrw3V1Tc/U5mTBxh6GVvsuYU8ci7b3bhx9ayBaP9WyCOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773146049; c=relaxed/simple;
	bh=cHUF2XHSTidsSmxJD0bQdgzaHWB25qEwufJ2YTbQfJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUc8/4YIrW/k+I5aDam//IGp5pCWsxA2/ljnzMLm/jy1OzWcIDtB8/BEpMIA7EKCAJtd7k4QNcXL5W8ALrn/NFGGbGdizDIQWfxWE6C9lzmRU6PpJZKjWXj1wt2hudj/unRajO0DhZNMpqZRIc8ywcJRaHEL7XscFGswLa/EuGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IOdW10L6; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IOdW10L6"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cd8d97aa2eso238095585a.3
        for <virtualization@lists.linux.dev>; Tue, 10 Mar 2026 05:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773146046; x=1773750846; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JidrQO5YBoJChSM6WSALz7pLZEnTQpjujRwwjFND6W8=;
        b=IOdW10L6hWu47yCEy2eykc5Q8E68BolXMY0P3zd1J74lwWui55YtbeLgd67eMUsHTh
         IYk3YcUMUoStHPg0SZLNudeVqSUc74wxdS1sksZGUefejcpLnO5ACbghnmttF1QgMWzX
         nqqXN57BEyPZJDTw+l44JYzmytOEjainwTsPsMbq+TTX6mnEZr6hRtZ2yvgAbsfXbq4f
         GHp0QGk54mPC32NzwyOL26qcVGT1EZ3877I9dzj4rQoZTfZ84RMWX+CX9ZLVdzdv/EZC
         I3Cm9IKuQsHtPm/Y88IH8uQcIUasBpCioySdIKDawUcjAKw+9aATG/UokvUQsj2jzONS
         bNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773146046; x=1773750846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JidrQO5YBoJChSM6WSALz7pLZEnTQpjujRwwjFND6W8=;
        b=t5R31IQxQCtOYtzOHpeVqulEJye25alDd5EQc6+xvNx4rpRPeyxd4/XkUqZ9yEnc2T
         EzB0mmw2svA5XDKAT6bEK6Tm8McJqrwhNDhUIIMhUju5ZstC6JRxXZ6NdWDtNCQkCA1K
         no4F1zDo6Ap1R4JoFRrsEXRVWWhTmStCNrzf/iytuQYHFMWZ1LlsptOzxF9hUiBi1J9A
         x8HCE2ArwyU32EbTM7H1QAjQIWQaLQ+9yo04JtJZzikIOJ4aHqzjqyCvRlupw/PCFNNG
         IEemFGOTaXdmv0/I2k8niikmJrJbWt/0O2XsFsahY2aSyD5ymqWxuFwJQNENg3pJ8ebE
         pHUw==
X-Forwarded-Encrypted: i=1; AJvYcCXfm+oGp/IbASn4/T3uzZi5IXpY0zOxGNoqKVJv8hbpsk+Xvxw4u4PltPzaCLQa+bPhOY0TlaHzS1BLQPvgVg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+9BWeq8gHlLGdu2NjCBxXLo/6hiLj7cVLgb/KhNpRcdiq7JUt
	r3JHqB0lO6O8ymXIGB/gcC6mBsAaWpm1yErz+rZJM5UVxmVnTnQGgOmu+/cvvfy3g5w=
X-Gm-Gg: ATEYQzzI6fEaxXE6GYb7z2Rw7kJbeoSaHKDI+/ZvYEmkj+a21qQZY35iJ4rbCUf6G5h
	OsyoK5Sx7jIOPhv6gXJCuUwlq8Fwx1RWXRrWYcZsNEZyRi1DUD5VL77knNp28+coroI0moMtboU
	Trmq1vfXptfjTAAf3ujymFJ8smoQzSUF4RSgFqGl518+g3tor73iOsufaswtPQHpmZEsQA7bstx
	EnRwvK7VqtjZyKQj3ozb38bgHTemEnbAJZcaHi7bQfQmI6qcjQdL2ak0rzIJ0bll1D9cK542/2P
	gRgXY0RaY49D4aLjh0q/RN98ZN570wv6Ct5+SYpz6EOWlFiOHsVeOVPoMrySZd7bOkPcPQFoegG
	xRvFzSj0a3zure/9bCZ2jo71LsVP5AYJ9vA7iD6SgELLQGGYl+HTcpRxf2h+77jhsnwLzfwxcbx
	pmPuC2+cas9lt3aSxXuzj1Hckk6VplwQlGLsmttxSQ+W3ZNWy6IwEAaFUQf9V+EQnWDjqrq9u6b
	WvYKiXI
X-Received: by 2002:a05:620a:4004:b0:8cd:9365:f27f with SMTP id af79cd13be357-8cd9365fb75mr416301385a.51.1773146046495;
        Tue, 10 Mar 2026 05:34:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd827a1ebbsm505561785a.8.2026.03.10.05.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 05:34:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vzwHl-00000005N1Z-0e7z;
	Tue, 10 Mar 2026 09:34:05 -0300
Date: Tue, 10 Mar 2026 09:34:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Petr Tesarik <ptesarik@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/3] dma-mapping: Clarify valid conditions for CPU cache
 line overlap
Message-ID: <20260310123405.GR1687929@ziepe.ca>
References: <20260307-dma-debug-overlap-v1-2-c034c38872af@nvidia.com>
 <20260308181920.GH1687929@ziepe.ca>
 <20260308184902.GR12611@unreal>
 <20260308230916.GI1687929@ziepe.ca>
 <CGME20260309090352eucas1p283a75c78cac495b5ad87df74c79aab07@eucas1p2.samsung.com>
 <20260309090342.GS12611@unreal>
 <c1d058f3-f864-4ed7-9f7a-683d6f4bf1ce@samsung.com>
 <20260309150502.GX12611@unreal>
 <20260309151356.GN1687929@ziepe.ca>
 <aaebc5b6-2805-46d3-a68e-549c26a3ef03@samsung.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaebc5b6-2805-46d3-a68e-549c26a3ef03@samsung.com>

On Tue, Mar 10, 2026 at 10:45:38AM +0100, Marek Szyprowski wrote:
> Jason is right. Indeed the rdma/uverbs case needs some extension to 
> ensure that the coherent mapping is used, what is not possible now. This 
> however doesn't mean that the DMA_ATTR_CPU_CACHE_OVERLAP is not needed 
> for that use case too. I'm open to accept both. The only question I have 
> is which name should we use? We already have DMA_ATTR_CPU_CACHE_CLEAN, 
> while DMA_ATTR_CPU_CACHE_OVERLAP and 
> DMA_ATTR_DEBUGGING_IGNORE_CACHELINES were proposed here. The last seems 
> to be most descriptive.

If we do DMA_ATTR_REQUIRE_COHERENCE then I imagine it would internally
also set DMA_ATTR_DEBUGGING_IGNORE_CACHELINES, but I'd prefer that
detail not leak into the callers.

Jason
