Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EE4487BE
	for <virtualization@lists.linux.dev>; Wed, 23 Oct 2024 08:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671554; cv=none; b=mDipBbJZ/hR8J0Bc1pT2vxMAtcEnDiConMosdC/TWflk2s1cw0KUhGLWpLDWpQzGOeLnCxoCDy1+6+EMz15+rclWbT7Mq8PhLCTifRdSEl3Xx2FrOVT2omOpGqJEzJ8oyzQKesNvJbR72VCcLZuuJtLM9cBPhjdF+q3dJ1LPbyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671554; c=relaxed/simple;
	bh=YTmqyiXUVuGr+Gh619vU8cd1U4QuivNESwr11uwnKMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=n3JxRmlb4nZ7fZwscvxcMsipqvIPdM7exNQMR0pDYJTq/uUS/wLjx3SVsq0mTjijyTu4U1VACyfAl021cxA44iVa1P/Uc3RFU7c9hlV/lK1dMDThhNQWJwj0fXKRu4JSDS3+V6dwTihUGMSYZ6UIcJBZ7bSoaFKmcR41UWZ54JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YG2DuchW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YG2DuchW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729671551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lj3kTDQyz2Ila1/KyVdWNvT3mRytQreFHg0SSqDc3rk=;
	b=YG2DuchWv4Jj5FP366GK7iRbpZrRdqeh5mCRNjp+2swfvYgoTbcR9b47RR9woSEZRrQOJT
	SMahp+rSHuclKQSxIjXZcB3GWR9n6Z4tqtDd9y9NksdeAgL9kTpbn/Q1pNTzf40N8wVqM1
	EWTZjTFYXE76qaHRIu05gfIqnGAR5VY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-y4HO-VU_Nvm_AdC2UzaGMQ-1; Wed, 23 Oct 2024 04:19:10 -0400
X-MC-Unique: y4HO-VU_Nvm_AdC2UzaGMQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43157e3521dso47126975e9.1
        for <virtualization@lists.linux.dev>; Wed, 23 Oct 2024 01:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729671549; x=1730276349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lj3kTDQyz2Ila1/KyVdWNvT3mRytQreFHg0SSqDc3rk=;
        b=H1Ln7kXJknPdILXbBUuZZ12zw2ddOBX8cyp4XMTn34RYF2F+9DmJ8w9Sy0ruJekjex
         EOTMqgpFtRqfd/Ky+Mr0MqwdBzTcRnKd9SzO4b75YqXWbRw4MKKuiV824UWUnUQiYP3c
         Jx8mQdXNbxu62ay12lZbXI3IdNulQ+X3Tz9bnLYww7/x7mfhUTQFsmt5SuRrXPuDcv/P
         r2BSe6sviZMQkCAbKuh650ZsOIrgjZTa/4BtMCFM1mCyZ6RaGcB0Xa6ei+oJR3IQEkSA
         fkKaaXftxAXaXn+lBu4IXUYHD3eeT3B7iWHJlTNkLQzX3kZHSsRai67T2trIgNOSVtsw
         PYnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAYP4jg+8DjxJ7dtFKUuVpG8VF3L+sX3A3jnc04s6gyHd6SYnZ4GADijJDQxhbB6jTz2lIdWfhrUoIMv/hyg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/9NBUzx+xYWGyFwmlHABO7bDvUVzz64VKYQkkBwOMXabtmuBM
	0nVMBr2qF5ig4qDKGDXe3Qk/wX9lB6HVZVaTc+58Q6E7qesgiHrv68zlcpc2MA5XknJ66C9tAG6
	D71mDWYPkk2nAzWk/Qx2En3G1fdp+lPrcZVQhHwHDrXiVVpHaXEawPWFHEIajLxGZ
X-Received: by 2002:a05:600c:1e22:b0:430:5846:7582 with SMTP id 5b1f17b1804b1-431841ee1b9mr13708825e9.7.1729671549265;
        Wed, 23 Oct 2024 01:19:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFusMJgqND3nBXD0ggRCRYPJkNUCP74BP/zihbIdNOtOBhuotxICVzslO5BzRnF0Gmb6GzOdg==
X-Received: by 2002:a05:600c:1e22:b0:430:5846:7582 with SMTP id 5b1f17b1804b1-431841ee1b9mr13708575e9.7.1729671548910;
        Wed, 23 Oct 2024 01:19:08 -0700 (PDT)
Received: from redhat.com ([2.52.26.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186be531esm9272865e9.18.2024.10.23.01.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 01:19:07 -0700 (PDT)
Date: Wed, 23 Oct 2024 04:19:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Srujana Challa <schalla@marvell.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH v2 0/2] vhost-vdpa: Add support for
 NO-IOMMU mode
Message-ID: <20241023041739-mutt-send-email-mst@kernel.org>
References: <20240920140530.775307-1-schalla@marvell.com>
 <Zvu3HktM4imgHpUw@infradead.org>
 <DS0PR18MB5368BC2C0778D769C4CAC835A0442@DS0PR18MB5368.namprd18.prod.outlook.com>
 <Zw3mC3Ej7m0KyZVv@infradead.org>
 <20241016134127-mutt-send-email-mst@kernel.org>
 <ZxCrqPPbidzZb6w1@infradead.org>
 <20241019201059-mutt-send-email-mst@kernel.org>
 <ZxieizC7zeS7zyrd@infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZxieizC7zeS7zyrd@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 22, 2024 at 11:58:19PM -0700, Christoph Hellwig wrote:
> On Sat, Oct 19, 2024 at 08:16:44PM -0400, Michael S. Tsirkin wrote:
> > Because people want to move from some vendor specific solution with vfio
> > to a standard vdpa compatible one with vdpa.
> 
> So now you have a want for new use cases and you turn that into a must
> for supporting completely insecure and dangerous crap.

Nope.

kernel is tainted -> unsupported

whoever supports tainted kernels is already in dangerous waters.

-- 
MST

