Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B872E19047F
	for <virtualization@lists.linux.dev>; Wed,  9 Oct 2024 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728466186; cv=none; b=gwEQmTv+YW6dNzsyD0Z2b57B5Pp6bjTetJCNpSdR1W/SEqsB1qa15K1Qs01tJ0t1ZSiTUhlVYXg5++SG5QDVrMWgRGrDN4K3kylyEeW6bpzZUxMH0LF4d/YSXO1mng/HWx7c0ej3AfF0KWQU1TxM2ROSoxg7JCU3+XZy0ySteSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728466186; c=relaxed/simple;
	bh=jv4yr89ODSW3N4ld/yynLf7Urvvt49R+EFqjpMQbhU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OS3NjChQTliqZOTUVOTyqspjAKPDRvlZik6/fKyQ0Pos1+8kx0LlAy9+2Eyx7faZPDr835pT0qTf+pTW7iHpC35UpWgmcbj3nGDQC7Ex4H8STpLNJ4E2J0ON/DqmHBUqiSB6xXn1qTkuqlV8hVCEpJVfyWzhp4ofY3G9lhFLcvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NGDfpRt8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGDfpRt8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728466183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S8lB9GVRxRia3sQO6QFobcvy8nr5iOlkWYV84jG88n8=;
	b=NGDfpRt8lqcFQbMrgf/cGExKnd+Lkqpx5WYeJcJlWB/WouhkxJ8ELXNJwA+dHOOa35aruU
	rsig0clmsUtjed9gh5sCcydwareSj1u1bDGpExMm7jFbqp85P3PrcSfCX0yHdHnjHYwDqZ
	u0HjJ4fl93toZPAOV9rUu9L5ySEcYbI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-_aLzM111MHezb-cJcAUH5w-1; Wed, 09 Oct 2024 05:29:41 -0400
X-MC-Unique: _aLzM111MHezb-cJcAUH5w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d38a174ecso500379f8f.2
        for <virtualization@lists.linux.dev>; Wed, 09 Oct 2024 02:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728466180; x=1729070980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8lB9GVRxRia3sQO6QFobcvy8nr5iOlkWYV84jG88n8=;
        b=sl7EYvqM6sFG3bXIQrRKyvPNmLdiVCvyneqYKTiBqtd/aDkz7IZrfspZOG+0BnwKHz
         tZWvTzCFsWdLDrevIZNw444MEXURmQn0w7xIPvMdUcw1sS+y0scbFyS7+0hRgnuiodsJ
         MCLURPyZC9FG/UbSnDTGH6R+JglY2RoMyKPVTM0YSfNW7c3bMETRkKs863YcZXuMGPMQ
         InuexsesEfcvDwH1M0/4bGyfupb81rQplbGUMWFZIQs2hipuXMmp1UQ01aEQs4EBqEkf
         Fz/e3i9O6aDLmCJhWmWxOzRcKlTorbXMeTyADdiQKtvIMwKmSmMi5v9ZIm0xea99+aFg
         Onqg==
X-Gm-Message-State: AOJu0YxCmQMj6Ax0PoCuoDZM3t9OEnqK2jsUn5Xrv+dslTKubSACVVHX
	68K1As0oC2hb79VS2C0OI2KG/WiSMTw/yKtOBuZqj7XmHwX46rgw/Y4LmIRp3nnvkl6ZGXedGnt
	uNdiJWqSdZ6UZd1p2lIiZB6cqRjRraoRh4ofc+hpldByj4hYZ6klCyp9f4ZsSnVBX
X-Received: by 2002:adf:e652:0:b0:374:c8cc:1bb1 with SMTP id ffacd0b85a97d-37d3ab30fefmr994186f8f.39.1728466180291;
        Wed, 09 Oct 2024 02:29:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbh/uRYFnr/6tynUNs9C7u8f52PxXdACVOsZocGPPTKpy2x5pkgDOD0J6lJtVLs9VBFm3e7g==
X-Received: by 2002:adf:e652:0:b0:374:c8cc:1bb1 with SMTP id ffacd0b85a97d-37d3ab30fefmr994176f8f.39.1728466179933;
        Wed, 09 Oct 2024 02:29:39 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17d:fb13:fd72:22f:64e2:b824])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16920195sm9900451f8f.50.2024.10.09.02.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 02:29:39 -0700 (PDT)
Date: Wed, 9 Oct 2024 05:29:35 -0400
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
Message-ID: <20241009052843-mutt-send-email-mst@kernel.org>
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
> 
> Thanks.

It's been a month - were you going to post patches fixing bugs in premap
and then re-enabling this?

Thanks!


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
> 

