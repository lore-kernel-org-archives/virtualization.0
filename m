Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53838405D8
	for <virtualization@lists.linux.dev>; Thu, 22 Feb 2024 20:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708633763; cv=none; b=Gk35tY7ZG+oJteoGfrXgWwmr8iUgDDu6fRoBGTu4kLxTObagXjWa3okpN5pmVUpWDx1CRWmQvb5Zijgf2rCAl8ITPwFsNVVO1skNpdwA49pYaGXfVpvcEpfn9vBqQw2MYcwmFIzHNFxvyKEy9SD2mQd8aRppyxxuiPx/JCIMsHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708633763; c=relaxed/simple;
	bh=EIRl5JmeNnsCCCvrzAJOkSjYNmO/xKRIFAlKwErah0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tAX9xHXSY2T/ifRi0b/onBxGhaij6UwYVaAWHbqlg5YvvmcmQ3LClsexrX16TOxxgPP7ePTtxINFWJWOVnLvMs872m1vS6DdqGeIRLnrjDKzJV/TDwTJCyfYD5CrYO2cTs4b3qIS1I6Vm5Tsr1BG+/SF0R1AypTCX+GU9Eu8DhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GnNp+y7l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GnNp+y7l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708633761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g9U/SuU7EoZOYs84Oq+NGNW63wWSqGFV+44C2eP5B4o=;
	b=GnNp+y7lj4fd3KSHBNXjRXfvxWZpSAun8XEqx+eF+sThOLU74VNzJq0Sc6z93c3hMKNkMb
	q/Ib3fWMAE79AAIoHFoHm+L2298umJz3f1dVUPaAe17A4EWyf+UHaYB8p2pu9ZADKuWzVw
	WUctRIWIYT2sV9jlJLxsg/MKxwjAblM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-NLzd-afhMtK5tP7ZRlFNyQ-1; Thu, 22 Feb 2024 15:29:20 -0500
X-MC-Unique: NLzd-afhMtK5tP7ZRlFNyQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33d73e15097so63954f8f.1
        for <virtualization@lists.linux.dev>; Thu, 22 Feb 2024 12:29:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708633759; x=1709238559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9U/SuU7EoZOYs84Oq+NGNW63wWSqGFV+44C2eP5B4o=;
        b=bq+26fe6Q3+zWnWl/GryOLpYpe0QM+qrvmQBmuYgZQKqWcxgXvZ7vOMCt0vKrPEJyF
         XK+QW41yp76LQYenODdu9Km44n/L93uukYHdkgS3ty86yEqBRCByD9a/1CF0AVxdi8XJ
         y6CdyZ3Mq3k0iQdtECcd+eMmoTGdlcToSr9Mfe2LadcErbUMNUWJ0zLlobaq9glMSlFv
         PByJCcw/XXqOvvgKE8ma43H+yJcUJi2g+8828nGn/psH2fblgamiRSq883v8x4iX2DYi
         ccAuZfmebNqk/dg7t1d1142i4cjXhaObxDKkN5z7or8J45LZvMqV9CeFu//RTeQx3mIo
         c6bg==
X-Forwarded-Encrypted: i=1; AJvYcCWuoCLIcOXZkC4z5Tqalu2Ipg1CGPPHya2UGeEPfZHnuITPzkircCfMUAoYgWTDhwBfbLLS2NwStUuirAbz2Gz55DFAyxK2IcZLydp21GQ=
X-Gm-Message-State: AOJu0YyaYRF58wRcqSJv1LWyXak3q8hjjQW4Ai6e7OBxqrcymemZ6S4k
	f/1ceaw2leQBaaBeo0ss0pm4mNY1B3w3oXZTJIPDUvibICE0WO74I186UIA1ib/SUGY8gdfAlbt
	lP3aeziO8F5FORV5THyLxYlWtrpbz2Xg/2v99n93NCJJNuol8nIcVcxGX8KnM0hNO
X-Received: by 2002:a5d:490b:0:b0:33d:513a:9248 with SMTP id x11-20020a5d490b000000b0033d513a9248mr3036123wrq.15.1708633758959;
        Thu, 22 Feb 2024 12:29:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmu72LYTYj8EKBymqMoqhVGv0sg4c6wtoeXMyJjoPERBEKhLX3cOJNp9rtBUbNB6tc0W/0bg==
X-Received: by 2002:a5d:490b:0:b0:33d:513a:9248 with SMTP id x11-20020a5d490b000000b0033d513a9248mr3036108wrq.15.1708633758639;
        Thu, 22 Feb 2024 12:29:18 -0800 (PST)
Received: from redhat.com ([172.93.237.99])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600004cf00b0033b1c321070sm142852wri.31.2024.02.22.12.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 12:29:18 -0800 (PST)
Date: Thu, 22 Feb 2024 15:29:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, xieyongji@bytedance.com,
	axboe@kernel.dk, gregkh@linuxfoundation.org, brauner@kernel.org,
	lstoakes@gmail.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	david.marchand@redhat.com
Subject: Re: [PATCH] vduse: implement DMA sync callbacks
Message-ID: <20240222152541-mutt-send-email-mst@kernel.org>
References: <20240219170606.587290-1-maxime.coquelin@redhat.com>
 <ZdRqcIRmDD-70ap3@infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZdRqcIRmDD-70ap3@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 20, 2024 at 01:01:36AM -0800, Christoph Hellwig wrote:
> On Mon, Feb 19, 2024 at 06:06:06PM +0100, Maxime Coquelin wrote:
> > Since commit 295525e29a5b ("virtio_net: merge dma
> > operations when filling mergeable buffers"), VDUSE device
> > require support for DMA's .sync_single_for_cpu() operation
> > as the memory is non-coherent between the device and CPU
> > because of the use of a bounce buffer.
> > 
> > This patch implements both .sync_single_for_cpu() and
> > sync_single_for_device() callbacks, and also skip bounce
> > buffer copies during DMA map and unmap operations if the
> > DMA_ATTR_SKIP_CPU_SYNC attribute is set to avoid extra
> > copies of the same buffer.
> 
> vduse really needs to get out of implementing fake DMA operations for
> something that is not DMA.

In a sense ... but on the other hand, the "fake DMA" metaphor seems to
work surprisingly well, like in this instance - internal bounce buffer
looks a bit like non-coherent DMA.  A way to make this all prettier
would I guess be to actually wrap all of DMA with virtio wrappers which
would all go if () dma_... else vduse_...; or something to this end.  A
lot of work for sure, and is it really worth it? if the only crazy
driver is vduse I'd maybe rather keep the crazy hacks local there ...

-- 
MST

