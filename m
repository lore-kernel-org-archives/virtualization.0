Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7055919597F
	for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 12:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933984; cv=none; b=hiWUWPp4BsZ80/tZFYJZ6oEbxCc975FFaWECZDDV1ALM44c9M4MbicRhTibNEUQewAx3JBdq1PqO16YJJtCEXbdJJTCqMlfp0J45R857ahYsnGZDA9Zv9el3vRaInVM2CnSUY0dkb1gAeP/hZG/AiUfsAt9xCKJCPMTJ5fGaAzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933984; c=relaxed/simple;
	bh=mY8Dgd+cyNhrpv+N1nPy7rifO7MGwoUjGwjPCFQ5g1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YTZ19YNtCkG4xWsN0j9nktzfNYp8HMwl+rW82LcoL9/USHhVowLmKsDYGAyFHV1CPxM6Lpv42tFgIVEIGaSPv4Mss+Nb3sGVJtWEtLgyQRP7W+Mhk3mpqvcZAj4/t2bp39Zd/hEJMo1Wu5ldYW8tIUUm3Vh7Vqxl3tFI5LTmriU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HXiBo6z8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXiBo6z8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724933981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wSkQSupYh8srGReshPqFouB6VAGU7iib2jvE4nu45yM=;
	b=HXiBo6z8rW7k83YtpGL1qZIS5DZVvzndH5VDIwzdu040DDQpzB2A7IUB/OIWOzr44U4GG8
	4MqGGTw39SV9h7GnLTH69DyojoG+RyQSsU9N7+bScDjjs5C/tqAB6usk7ll1s2oG+siUZp
	h8C537MPtVzp7R4evMsaMrxv3wsAcz4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-2QPsoe5UOWW0UoKGMGaemw-1; Thu, 29 Aug 2024 08:19:38 -0400
X-MC-Unique: 2QPsoe5UOWW0UoKGMGaemw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a7d2d414949so53448466b.0
        for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 05:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724933977; x=1725538777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSkQSupYh8srGReshPqFouB6VAGU7iib2jvE4nu45yM=;
        b=k+EUVglBXIVUdoQmOrDR1yA/sTbq7+PocHmXv0KM1oT1r+uqfxVFxmiE3UGIxdHwun
         bK/dfoOsBhU3ce1WIX3+NYafP5ztySi5Y1WQ/hNloHfJ6dlTMxkeegsbliG+kN6lj1Xn
         Hu/h/pVw/qQmPryGO5RauaWU0b1VvP+gyZHw558AzDL96bRXE0i1tdpNiN6dVyJc5G44
         pQ78Yq6caGFsr6CLguhc2fvlOrOVNdjwW0NCXYI2Il/rcwjbZn3uUjXZwAZ0TeyEMnIV
         7yHfTZvngT4GrNEggm6TpRLVv+708+No+7hv+Te5ME8HRGARm33+uEZH46YlYkwZfqlC
         K3gw==
X-Forwarded-Encrypted: i=1; AJvYcCXnwI0iSWagh2k9jymQ26nTxXJ8jcodJ5UcQseLyDhg18rF8AvLqtecY1dWTU/fpKaKnVDMtEzaLt3idzu45w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx29zvPbNEeVMgCSvV1yS+2kay9va/iUoPOatPvGBo04FQz+OIj
	4A7tU1d8l+d/CN7Huzuvo/caOog3iLt87vq+Fy3QtQI+dxOhuh4df6FZ/Wmy0+37Uosb2zC4lP1
	/MvgIXO3U5zjkVcJv/O2O1/1gEKjTeBc0ZLs+6Dzypo8f9aIklCcVVnmoBuK2ty+c
X-Received: by 2002:a17:907:9712:b0:a86:78fd:1df0 with SMTP id a640c23a62f3a-a897f930bbdmr199685766b.34.1724933976994;
        Thu, 29 Aug 2024 05:19:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG9hsNF/FyU7NjcehPXdOC7KV+W3lxtyv+s5kfZUVe/jX8oMQoKUdOVwW1ijqi1fRaZigcQw==
X-Received: by 2002:a17:907:9712:b0:a86:78fd:1df0 with SMTP id a640c23a62f3a-a897f930bbdmr199676666b.34.1724933976116;
        Thu, 29 Aug 2024 05:19:36 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ed:a269:8195:851e:f4b1:ff5d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891968f4sm72412366b.106.2024.08.29.05.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 05:19:34 -0700 (PDT)
Date: Thu, 29 Aug 2024 08:19:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Luigi Leonardi <luigi.leonardi@outlook.com>
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	marco.pinn95@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com,
	stefanha@redhat.com, virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v4 0/2] vsock: avoid queuing on intermediate
 queue if possible
Message-ID: <20240829081906-mutt-send-email-mst@kernel.org>
References: <tblrar34qivcwsvai7z5fepxhi4irknbyne5xqqoqowwf3nwt5@kyd2nmqghews>
 <DU2P194MB21741755B3D4CC5FE4A55F4E9A962@DU2P194MB2174.EURP194.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <DU2P194MB21741755B3D4CC5FE4A55F4E9A962@DU2P194MB2174.EURP194.PROD.OUTLOOK.COM>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 29, 2024 at 01:00:37PM +0200, Luigi Leonardi wrote:
> Hi All,
> 
> It has been a while since the last email and this patch has not been merged yet.
> This is just a gentle ping :)
> 
> Thanks,
> Luigi


ok I can queue it for next. Next time pls remember to CC all
maintainers. Thanks!


> >Hi Michael,
> >this series is marked as "Not Applicable" for the net-next tree:
> >https://patchwork.kernel.org/project/netdevbpf/patch/20240730-pinna-v4-2-5c9179164db5@outlook.com/
> 
> >Actually this is more about the virtio-vsock driver, so can you queue
> >this on your tree?
> 
> >Thanks,
> >Stefano

