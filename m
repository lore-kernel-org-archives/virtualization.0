Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7CA12EBCA
	for <virtualization@lists.linux.dev>; Wed, 14 Aug 2024 07:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618815; cv=none; b=lBUdo7LtrAkG4CEBXO4W1Maa/odSX4G+pxOqfi1dxhfv2l0k8w0CUgTNNaM8iQjjw7T6wJFO16dLGM9OSQUJmxo/xBt/AcOpW+y9G9BxM1JU07JSRp0GBhJ92/f05mcwMG/rYpy0BoIZ02W+1RmxsmBbQBxZ2qQMlFZesP6tozo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618815; c=relaxed/simple;
	bh=P07S/sz++xvSKCCgINNJ4f7IaTa3C8tbQxkg3d0eXV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cHI4uwEBoUwVfwzB4PBYBZw/zARCQByTu/WqCcc4JeC6rPaKBTShxPcy+d1uL0C3Q1Nt+SC1Kpuv2TovaCJqYHbzLOeYP5EsD1gPO5vvTABBl5UD65Jgpq87uOsYrnkKqVKqMUFTmiZeZ8wS0NTPFNFxkxyaFNDogS39M7aqSxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SqvL1tO2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqvL1tO2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723618813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KbworbXyEObZ56AD2569t8EG6Xuo9H5MtG4Kac2AzcI=;
	b=SqvL1tO2MuumoOGktvNj0HetZ0uFf0wN6k0GpD5zf6DL9nikRSDoVjmjjtSuz8Av21qdVN
	xKx8mmL51xfoi/YwTsXSca24f2G4JBZoTeUeFvhl0OpFig0PimInc/wDC0qJK3t4n3ted6
	AuyBzM9k2+cG1xLWtrM1h3jU5sje2Io=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-tg4iGJVuPhCEXsrhOCBtbw-1; Wed, 14 Aug 2024 03:00:10 -0400
X-MC-Unique: tg4iGJVuPhCEXsrhOCBtbw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52efe4c2261so8250093e87.1
        for <virtualization@lists.linux.dev>; Wed, 14 Aug 2024 00:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723618808; x=1724223608;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KbworbXyEObZ56AD2569t8EG6Xuo9H5MtG4Kac2AzcI=;
        b=HJzgw/rDBIfaD3Fxvh3hmpapMibZjJfPuPc2mKh+H4KDSmIiltSipMiXVG3AASTt6o
         Uevhd3MsJtXAzT05e27FGrgIO6kLV+1IYnem+EE96y7ZT50ktXFnifCJ/Q5wsOGZe0r5
         QYUHLn7+bp8YfMsLsKFJbGFjSxCFF+8retsh3odGwVe1Mlngma1/IhEHi1h7JNtV6EQU
         Q8B+GKBA1sKQksv+G4VpTZHA+9wRPz+7H4ue4vF/WdE9g88xfcST6c9O6tMMLm1egFaa
         fPuTDGX4pl2XVPTwMyuq7o7g8Jl4PZDYdDGa9/dAuSZuHUqutaNc2hniXGREl3szbgPk
         nCRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQW+kUbKloc77LyqLI3NYEvBMPDkWx2k9r9PkkuYjhsl/nr2HWyNhD5OqpwlkAUEsNiY25f862IDZv4PNuE8RqmeLTJ0yNbVCFp5Z21PM=
X-Gm-Message-State: AOJu0YxXvWrWjqohg900G1TbYqDZbvyprEcZ8+O+ZvfAD1+P7KhL5zjM
	qSCHjefmzQfxL4yhJEEstC5bv+SO1ffRVCJhI6PNrzBLx71MwY/JdcX4DCeKdR8jBoi7KZxVzWU
	EZzU5FGTODtWfK+6xW7b2C9HKbdTepf2w1TcknU6fIrNAkUebs2YwAL8vXS4IGQxH
X-Received: by 2002:a05:6512:3191:b0:52c:a20e:4da4 with SMTP id 2adb3069b0e04-532edbc05f7mr1408762e87.57.1723618808507;
        Wed, 14 Aug 2024 00:00:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsgPLZfbEeDzMU1Cf2AWqexIhDGUtlzIFV4zWpd7PEPzd/Fad6OXEe36f7DkG6dU3SfVJrrA==
X-Received: by 2002:a05:6512:3191:b0:52c:a20e:4da4 with SMTP id 2adb3069b0e04-532edbc05f7mr1408709e87.57.1723618807737;
        Wed, 14 Aug 2024 00:00:07 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:dcde:9c09:aa95:551d:d374])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa69cesm137227766b.57.2024.08.14.00.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 00:00:07 -0700 (PDT)
Date: Wed, 14 Aug 2024 03:00:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Darren Kenny <darren.kenny@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH net-next v5 1/4] virtio_ring: enable premapped mode
 whatever use_dma_api
Message-ID: <20240814025926-mutt-send-email-mst@kernel.org>
References: <20240511031404.30903-1-xuanzhuo@linux.alibaba.com>
 <20240511031404.30903-2-xuanzhuo@linux.alibaba.com>
 <8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com>
 <20240813154458-mutt-send-email-mst@kernel.org>
 <3a6bc28d-dc53-430f-b308-b639276bdc39@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <3a6bc28d-dc53-430f-b308-b639276bdc39@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Aug 13, 2024 at 08:39:53PM -0700, Si-Wei Liu wrote:
> Hi Michael,
> 
> I'll look for someone else from Oracle to help you on this, as the relevant
> team already did verify internally that reverting all 4 patches from this
> series could help address the regression. Just reverting one single commit
> won't help.
> 
>   9719f039d328 virtio_net: remove the misleading comment
>   defd28aa5acb virtio_net: rx remove premapped failover code
>   a377ae542d8d virtio_net: big mode skip the unmap check
>   f9dac92ba908 virtio_ring: enable premapped mode whatever use_dma_api
> 
> In case I fail to get someone to help, could you work with Darren (cc'ed)
> directly? He could reach out to the corresponding team in Oracle to help
> with testing.
> 
> Thanks,
> -Siwei
> 

OK, I posted an untested revert for your testing:

Message-ID: <20240511031404.30903-1-xuanzhuo@linux.alibaba.com>



> On 8/13/2024 12:46 PM, Michael S. Tsirkin wrote:
> > Want to post a patchset to revert?
> > 

