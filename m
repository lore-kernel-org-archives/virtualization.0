Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A9D171658
	for <virtualization@lists.linux.dev>; Sun,  8 Sep 2024 19:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725824340; cv=none; b=CmrTftR0zjlayCfCRHetA434sKqi7v2IbJ8xamb8ixI5I1bU3L1+SNC4NKPkfcDDCPOdndHf4YeHDvxfk9iWjJMBwAwv+oKd801NxEtpm14VyHQE8A8kRpj9P22Al6WXLjZNEY2vqKZxjPf6QRfQlo7mrV3VyINeCRfVn3j1QyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725824340; c=relaxed/simple;
	bh=b78tAKcRS4epmgnAYIwAGMxqn2q0gumpr1tdaNU5Pvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Y8MRSw/wtLVTQo7Sa42SQwPcLYNP1bUm4uHSL3B1vMXNOBWMdOfgr1J2udr6UIN0soZ7sF42WIwFIIhwPAA7fioL0kB1MkWi97eZty4152Ly6I8QkWRHCL2MNTHD1NZtGjXf7mUSH102q+qZqayCdc8dlHSU6sR1H0xqoHkQ8Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=djTehYSu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djTehYSu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725824337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ib4Cg1mwnO6N/iUumzqg1slbWobcDxhzCttJjbOrRIo=;
	b=djTehYSuvzlEQomR5kNFXt+7lMtN5vGQ9YTfmDjLrPWGcoI9nK/+IMmQ1kYQr7BxONXXh2
	Xq4RmI8g13FX9DHJwOasbRvf4lcsmA/Fk/vkJW79eyk68qJiWNjrU5Qf02ToZEH/pLD7YC
	Z8HzqDuDvshmp76yS57AmEIOVtadHxk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-bwf_soWvPoCsBkWuzWVbBA-1; Sun, 08 Sep 2024 15:38:55 -0400
X-MC-Unique: bwf_soWvPoCsBkWuzWVbBA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb0b0514bso9385235e9.1
        for <virtualization@lists.linux.dev>; Sun, 08 Sep 2024 12:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725824334; x=1726429134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ib4Cg1mwnO6N/iUumzqg1slbWobcDxhzCttJjbOrRIo=;
        b=evVYER8p5ZbkKZ7ExlUxlEQG/BYatZ3CTNLHiyhSe6ZagYvRjfMKwdjuIu4oLvmX1m
         dBczDBiXM37Wj/LY4tbeGzICkWd7wFMz0SVHALEloj+RPxJQVCzyNke+UkILwVj0bxwA
         xrNc4GSWXdyzX2AZa29Qtok1vKvEZEXQuDtUUcEVm2dF+Lfj3Ign+eWCL8pBqOY0Ssvq
         1N1+4KvZwd6mupylU6FaNG9+gL6qm4bGaYpGvpZLNznbnQH6EsZG3BEtnnO8FlID2MJ+
         XmEZBkuSc5d0IZWkTGIfsrVE8G1JYNqndFCVXPlrn+FOUauG7MjiJ+fj3FWeyLR9JM4Q
         Fa8g==
X-Gm-Message-State: AOJu0YzYenGm6FetSynbF1OnLGwMbr5Neu/e5Cv03N3WBQkwXybCG+7p
	id1ICR3KoyxvbZbooanlaLJk8EBat14e6kgnm3GdkoLWhq0bOB9vcgrb3YW0bjVCDd4iukdb6xD
	CNHoorMmRsgXq0SwQ/PCVRXjzUw2AK6M7Jl3dsRaCllYX6DRcHgpfee2/Zhu7SZg1
X-Received: by 2002:a05:6000:18cd:b0:368:68d3:32b5 with SMTP id ffacd0b85a97d-378895ca930mr5169711f8f.13.1725824334262;
        Sun, 08 Sep 2024 12:38:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYoGWEjuYnS32HktLwjz8Iy78rl7gj33gQqlWLnq5lNTQ++a1rzU1N3LGu/UZ9Tp8g8Ri5mA==
X-Received: by 2002:a05:6000:18cd:b0:368:68d3:32b5 with SMTP id ffacd0b85a97d-378895ca930mr5169695f8f.13.1725824333389;
        Sun, 08 Sep 2024 12:38:53 -0700 (PDT)
Received: from redhat.com ([31.187.78.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a1a0sm4057332f8f.23.2024.09.08.12.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 12:38:52 -0700 (PDT)
Date: Sun, 8 Sep 2024 15:38:48 -0400
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
Message-ID: <20240908153712-mutt-send-email-mst@kernel.org>
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


Acked-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Takero Funaki <flintglass@gmail.com>


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
> 

