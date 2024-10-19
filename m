Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9E113635F
	for <virtualization@lists.linux.dev>; Sat, 19 Oct 2024 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729355667; cv=none; b=o4J/vVc0qdlobQO6AX9jSYMXrO0FErj+ZX4Jhir9QsEd0c2P0eUQ4X9HcWQ8GDjR8etNl0Ll9bTZPOZhsCqkyGmb8WLcLwyHPn1BE+d6t2o7RAPXvEabVzTWb3Oh1FtTurKn01TObBr1bkFgKQhEIQWGMo1Fx/rcJWoCkwQYGBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729355667; c=relaxed/simple;
	bh=jch9XgVVnx4nwwASfU68hMMYbvw+WHzTg1ew1qQ+SsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LNsyCf0Qb+lGi5ab6gevd6Gl8+8LxC5VSjt9ul7IuuKm39CKCi3l8661Cpzg2bUHJXQQmckPuJk3qIHtSfal2to+RatwMEN+Fbj6fXn4lai3fsTx+0FG43aN1+92zV4Cl/u0zbYoC7GHxFQsA/91aS7cjAztvY+wQc5mVBifUVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SgLdfS2p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SgLdfS2p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729355664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XiQs+1gTFANjfDhSPEgP6TMIgvrMexQgV6eDFrVxdXM=;
	b=SgLdfS2p+e8PCQyI6KSN4p/oJKkwjP1ca+pvqHIspRwgwquGLutYNzyk6IcR7IRvnF+Y8Y
	7TfOJNwn4LaeOT2zo2jmstS1HYO4kfyLFPxI/gCGvUSRptZX9X9zImmChtFaBrKpK6+SIl
	ajdtOyrsT5uoVgcVMPsiQamiiXwn6Hw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-Di75NNODNtGAJ4AjtivjVg-1; Sat, 19 Oct 2024 12:34:23 -0400
X-MC-Unique: Di75NNODNtGAJ4AjtivjVg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d5a3afa84so1673647f8f.3
        for <virtualization@lists.linux.dev>; Sat, 19 Oct 2024 09:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729355662; x=1729960462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiQs+1gTFANjfDhSPEgP6TMIgvrMexQgV6eDFrVxdXM=;
        b=TrGOCa3FeTGLk/BaVy0WwndxNFX3ylzRyBVBw6An6wLBUSp82k8TlBuz+ENF9YJiW2
         xqXDx4Xz75hTFv8dA9hiZscwiW4MtfCELEQNLZsxUUgz9IMlYT4Mr1e6E2wKaVEvrZXG
         jFCs+5EMBC381VATcvGBRNi+FhzRMpvodzWMxl6ggwceNwTImur7Jpo+zV71WvKWVVa6
         5eKVnsYM+ETL7l/Wy5gWm9w5En2CVKGwesLkNVJLlIP06l+0/UtHmNNJaSEo2j3u44f1
         o20f7pmj7XsH29mBRf4stP2/EpvjZd1drSjUKt4eP7ucmHotezGGC37A6nl/LpKGX+95
         mEiA==
X-Forwarded-Encrypted: i=1; AJvYcCXgM7YpYMVEbWH5ACGYokiJt1QkgetaEf6Fd7Bzb/FA/emVQOvybITmswkipKeA2hQz/PhCVur3JyhOeGftFQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywpa7sf/9fu9JhMUPeggVs0JnWYMnijBOf2v0rt1aVzih/OgS8S
	jzpbSwZ9XCdM2XpaK/9714ZpTnzk4nOa+sYrwFOw35RIFpTuJYNGu6zNh2c5YLNVfDSL5FB3IRj
	ru4vm0aweVrSFovidzVw4n8HE3NDrm8BFjbZFot4r3C7m73+UCXDaSokKt+M3DfMj
X-Received: by 2002:adf:e2cf:0:b0:37c:fde2:93b6 with SMTP id ffacd0b85a97d-37ea2137100mr4358895f8f.11.1729355662163;
        Sat, 19 Oct 2024 09:34:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3ntIiX0c/pO202PMjCqaQ+6uSNTGtHipHdscexeRiZ6RU7rA3Tw0RUtPj58RWyVBiEIJPWw==
X-Received: by 2002:adf:e2cf:0:b0:37c:fde2:93b6 with SMTP id ffacd0b85a97d-37ea2137100mr4358879f8f.11.1729355661794;
        Sat, 19 Oct 2024 09:34:21 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7405:9900:56a3:401a:f419:5de9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316067dbb4sm59315585e9.9.2024.10.19.09.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 09:34:20 -0700 (PDT)
Date: Sat, 19 Oct 2024 12:34:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH 1/5] virtio-net: fix overflow inside virtnet_rq_alloc
Message-ID: <20241019123220-mutt-send-email-mst@kernel.org>
References: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com>
 <20241014031234.7659-2-xuanzhuo@linux.alibaba.com>
 <6aaee824-a5df-42a4-b35e-e89756471084@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <6aaee824-a5df-42a4-b35e-e89756471084@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 17, 2024 at 03:42:59PM +0200, Paolo Abeni wrote:
> 
> 
> On 10/14/24 05:12, Xuan Zhuo wrote:
> > When the frag just got a page, then may lead to regression on VM.
> > Specially if the sysctl net.core.high_order_alloc_disable value is 1,
> > then the frag always get a page when do refill.
> > 
> > Which could see reliable crashes or scp failure (scp a file 100M in size
> > to VM):
> > 
> > The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
> > of a new frag. When the frag size is larger than PAGE_SIZE,
> > everything is fine. However, if the frag is only one page and the
> > total size of the buffer and virtnet_rq_dma is larger than one page, an
> > overflow may occur.
> > 
> > Here, when the frag size is not enough, we reduce the buffer len to fix
> > this problem.
> > 
> > Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma_api")
> > Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> 
> This looks like a fix that should target the net tree, but the following
> patches looks like net-next material. Any special reason to bundle them
> together?
> 
> Also, please explicitly include the the target tree in the subj on next
> submissions, thanks!
> 
> Paolo

The issue is that net-next is not rebased on net, so if patches 2-5 land
in next and 1 only in net, next will be broken. I think the simplest fix
is just to have 1 on net-next, backport it to net too, and git will
figure it out. Right?

-- 
MST

