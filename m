Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9249318FDC5
	for <virtualization@lists.linux.dev>; Tue, 10 Sep 2024 12:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725970339; cv=none; b=tQSYIR5eVznMkWTztx2sZUw/DdabW/tBEYrvrxRY67wOdyXk8jIekKqQheXVs2lh/843ji/BspgVHOZaEu79YPlrPiY2GxnKcs6x14jdR/TAoZFV5yuK7dTHR3JL0onRWegDMzac/cb0KkrjSEjO7qOeFQIgyzzqVUJMhNnMMmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725970339; c=relaxed/simple;
	bh=pBX6i4GvcaB8VT5K1Bc2rZrTRGqF+KtopvGd4NVH/UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pIYNvG1x7y0AwbBdPkN6zoRg2Ikef4wNhqB9nY9UEHipGhApjtQAodxR7kTcVKKEOjK7oPyF/8H62Of1JGUr9bxcpbhx4sjJibVpP0Bjc6lsRiuWdzSUCUPOZ0bkwuWYe/C95OfOoc1h/qO4HnWeJyg6d0lkiivYYTJAQTQGRWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FAn0f1B3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAn0f1B3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725970336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jxCLNeuG7VDBjUPWydTqLmY+hll6gx2EUflZYj+Ot6I=;
	b=FAn0f1B31q9G9IpBpe/KriFzsCDpZtqOaK7VO8uN0LySBRkmPtPY/6AfEL/RYL3deW87sS
	avCqRbsUJLnACBNQr/xhdGFbEqNmHAcHh7ILimzDGnbZ7jxroZXTa55VwcLf1bpuDMn2tT
	eseJYJEUEIMq0fSUVxzcguXEByk7s6Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-Vkb--wW1OQWlnv2OAcw21g-1; Tue, 10 Sep 2024 08:12:13 -0400
X-MC-Unique: Vkb--wW1OQWlnv2OAcw21g-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb08ed3a6so13881455e9.0
        for <virtualization@lists.linux.dev>; Tue, 10 Sep 2024 05:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725970332; x=1726575132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxCLNeuG7VDBjUPWydTqLmY+hll6gx2EUflZYj+Ot6I=;
        b=mNh5LmRy4BPahnHu3OaVyW6/SNUU21CxEc9r90LeCUSz3nTXTEgjk3YCeyRDCHg6TL
         1ig7O3834wRcjcSPiBZJ3c0glREcb1D+KdCInAO1Ns3dXXEib/nDbymLXd2i2gpyXgBm
         ByT2yIBER6FhN4rMvZrSdOullB0puPGrOpzs3DSkWxq7+YpXJxde1J8iWzR3ymZYCR/j
         ZxcuHfkErmYV8qBX0fpSKUSmkjYpiFa21/06MvVwf6NWsYsmho6izud9XY2dPbUcgQsg
         DpNV4eM2kn8awr3MPzhNN2Xm/hs6R6K/kKoPCm3IvrZ78Er4skmMZ3AqXkrRZArneveC
         KwZg==
X-Gm-Message-State: AOJu0YwHsMRbpIaFuq25ylyxv000ngKkJprPBzZD1aMYL5radWbCUApR
	fatjJbRKCXV8dWVJMMkzZ1Pa2UmXQFl8du4DO78NEUdm/YHiNVTymNmjWgPfsVrycK48u/JwJwO
	1bXis21Grr1Ar37doH23zjsGJjrjtklXpR0iiP7A80FRxZ8U55FXCyyJpT7dQDlgw
X-Received: by 2002:adf:e805:0:b0:378:8b56:4665 with SMTP id ffacd0b85a97d-378a8a5a250mr1813925f8f.24.1725970332099;
        Tue, 10 Sep 2024 05:12:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmn/gKeqcT9UfHd0dzbWOJJz88lOVLahfI9N5q60XR38JEBFW338jR09cWZYWTndF5aL8i8w==
X-Received: by 2002:adf:e805:0:b0:378:8b56:4665 with SMTP id ffacd0b85a97d-378a8a5a250mr1813883f8f.24.1725970331478;
        Tue, 10 Sep 2024 05:12:11 -0700 (PDT)
Received: from redhat.com ([31.187.78.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564aef9sm8756786f8f.5.2024.09.10.05.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 05:12:10 -0700 (PDT)
Date: Tue, 10 Sep 2024 08:12:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Darren Kenny <darren.kenny@oracle.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH 0/3] Revert "virtio_net: rx enable premapped mode by
 default"
Message-ID: <20240910081147-mutt-send-email-mst@kernel.org>
References: <20240906123137.108741-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240906123137.108741-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 06, 2024 at 08:31:34PM +0800, Xuan Zhuo wrote:
> Regression: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
> 
> I still think that the patch can fix the problem, I hope Darren can re-test it
> or give me more info.
> 
>     http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com
> 
> If that can not work or Darren can not reply in time, Michael you can try this
> patch set.

Just making sure netdev maintainers see this, this patch is for net.

> Thanks.
> 
> Xuan Zhuo (3):
>   Revert "virtio_net: rx remove premapped failover code"
>   Revert "virtio_net: big mode skip the unmap check"
>   virtio_net: disable premapped mode by default
> 
>  drivers/net/virtio_net.c | 95 +++++++++++++++++++---------------------
>  1 file changed, 46 insertions(+), 49 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f

