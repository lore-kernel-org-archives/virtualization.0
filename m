Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D5738F239
	for <virtualization@lists.linux.dev>; Mon, 16 Mar 2026 10:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773657849; cv=none; b=GVbk9a7h2Qj6V1xgFWPLFAQ6s6tEMJtrDkNUfBWneqicANm+Hi9kYIhNn+IyjBDN9c7fvVMzPBnyfTWXZb7/YvjQXw0G/DwdFJW/AgQAZlXBUsyezSdVSjMeuZAb7x6zs4iTyAZ99PQezTVhDnz2QmZmz4fkDdotFnEF4tyzweM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773657849; c=relaxed/simple;
	bh=Sfai54yGfVswX06wKRJbvlx+Ae5w4/tFvgMB8FyVF0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rW4tvFtnvuZIkYW8gbpDi5WMsDOOgxkXYcoUAo3m1+gvrDtTfOAmJbuL0/Rk43jSGGo9+6cIAcXMSxN9TO1YsroLdaXOFw+ttRa97/zscMpkBT/XHpJUwG/n9uD7b433xhUguum7vROAr+ho3VDf+B1rz/6wYm3USJpcW23JNRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G848RMsI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G848RMsI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773657846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N/gyi8r2QqrmKNfnuildAwIe3Wu8jqbPwSPfbNMez1o=;
	b=G848RMsIykfGvEzrRxY+2+Ez7Sc7my0bZqfvakOq16UZT8IgiyQbbk/SM5WBSuYzuA5JtS
	TxAqz43MRUsp61Du0qrXvfKK7Qd4gTxwFTuNbT7rI4WEV9DLOo2i+CkDWP+R1JoaRvsvja
	hlazSUMepqzlAbK/+Ntj2/M/SdJcCDI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-zAuTZF7wMAW6zuhAiLBFAw-1; Mon, 16 Mar 2026 06:44:04 -0400
X-MC-Unique: zAuTZF7wMAW6zuhAiLBFAw-1
X-Mimecast-MFC-AGG-ID: zAuTZF7wMAW6zuhAiLBFAw_1773657843
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43b3da235dbso1291599f8f.1
        for <virtualization@lists.linux.dev>; Mon, 16 Mar 2026 03:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773657843; x=1774262643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/gyi8r2QqrmKNfnuildAwIe3Wu8jqbPwSPfbNMez1o=;
        b=bFO1tUhOKo5YWBU/xPIKI0wnaSQJ5yaXj/DlMpKWqD5jtD75tVPvzneyzeIrPgZwnO
         7c/HYc6zDu5RAon4+KdEALtlXnk6n9jDOHwOEaUyJSpBtrp23XQFFh96sA+hGFaVtO6/
         QkS4otzOA6WZNn1qXAH5EkR3EVbqVLoj/AHHOybuG8qzIfm9g9+ZEUATSteCWu+xLEmW
         yb4Yg79QqgSxWOo02kuN6WRujZeUaSqXtgJzAuA8pJv2KLpiH6wPThs99tMs4CdZhI7w
         PwtLAKGOTOrqpByj5HD1OV9nvHMpFgqnuWK9P88tUSvzEsMJAeUeDYRPqBFtEFFMtAKs
         qX7A==
X-Forwarded-Encrypted: i=1; AJvYcCVm/JmJ2GCK7Odmzex31+I6zV0M4FsVni3QaXeRRSFIQVjZcTCc/A4NJtnj4Sw5Ok4xsauKRKDjf2xHrqhj1g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/nJzh/KKlbNygMvhIefBuwZhidDr+T4fF1AQMFedeP87zpCZN
	dDG5TLNoiRVHxR8jsc+O8koZftRe+19rQfP0wpO/3U+IdUaj76B3lX6JfOCBkT7Hoyd+FVohkFh
	pWYqOyZI/BXWd7o+yPDp7rFhRDrvCAAkKmAsNo+k9XfBY16GJ0UFkNn/klcTawTnBKTSQ
X-Gm-Gg: ATEYQzxUhJmI6IsRyNaPuEAeQ4Yn3m72tGRHzSOao/L6X9mjkQzN988Bb11ZITLIc2/
	XfZmFJyRThwuA8t4K2wPknk13H32QOyLYpgdjRkqrkorAEpcYLKrNK40sEFMXxBPmYf2xYncuFX
	rnxEgHeejRu9/74Rg8yWwAIxRZeZ6qEMk2OhoLvZ6t7HaF97/3DXi/npPXscRnKsuFWbPNX0VVa
	sB9lUsiDfW8GW7b/69y8FsY7hW7bWNy7aQvyR4N2YKCWz9hNWf5dFkxUy1KdpFeqwksjGJNTKWL
	/aSO3ZFjoEDdtfcxygdqlXaNOWq3BTDpKeIW3h9Wg17lkFyBI9ATOgRih9Ktz2lM3phZwGKNBpB
	PoaMuXTmJsT6fZs0h+yvyiD92B+cMr0ICV9/P3XAfBGuZjw==
X-Received: by 2002:a05:6000:381:b0:439:d8cb:1392 with SMTP id ffacd0b85a97d-43a04d91a43mr23683328f8f.26.1773657843172;
        Mon, 16 Mar 2026 03:44:03 -0700 (PDT)
X-Received: by 2002:a05:6000:381:b0:439:d8cb:1392 with SMTP id ffacd0b85a97d-43a04d91a43mr23683282f8f.26.1773657842675;
        Mon, 16 Mar 2026 03:44:02 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b45e51681sm3730121f8f.25.2026.03.16.03.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 03:44:02 -0700 (PDT)
Date: Mon, 16 Mar 2026 06:43:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, Matteo Croce <technoboy85@gmail.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v11] virtio_net: add page_pool support for
 buffer allocation
Message-ID: <20260316064256-mutt-send-email-mst@kernel.org>
References: <20260310183107.2822016-1-vishs@meta.com>
 <20260316054232-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260316054232-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O7S3RJe1I47tuZIwOr6HumsJUvkVJkd-wzHTD_3hodQ_1773657843
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 16, 2026 at 05:56:20AM -0400, Michael S. Tsirkin wrote:
> On Tue, Mar 10, 2026 at 11:31:04AM -0700, Vishwanath Seshagiri wrote:
> > @@ -5857,7 +5863,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
> >  	/* In big_packets mode, xdp cannot work, so there is no need to
> >  	 * initialize xsk of rq.
> >  	 */
> > -	if (vi->big_packets && !vi->mergeable_rx_bufs)
> > +	if (!vi->rq[qid].page_pool)
> >  		return -ENOENT;
> >  
> >  	if (qid >= vi->curr_queue_pairs)
> 
> 
> 
> It seems that a qid that exceeds curr_queue_pairs would previously get
> -EINVAL and now gets -ENOENT.

Or maybe this if (qid >= vi->curr_queue_pairs) is dead code?
I looked at it some more and I can't find a path where this
triggers.

> Maybe reorder the checks:
> 
>         if (qid >= vi->curr_queue_pairs)
>                 return -EINVAL;
> 
>         /* In big_packets mode, xdp cannot work, so there is no need to
>          * initialize xsk of rq.
>          */ 
>        if (!vi->rq[qid].page_pool)
>                return -ENOENT;
> 
> 
> Alternatively I think we can completely drop this chunk: we already seem
> to init page_pull at all times except for big packets mode, so the
> current code is fine I think.
> 
> 
> -- 
> MST

