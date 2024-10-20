Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9149B7FD
	for <virtualization@lists.linux.dev>; Sun, 20 Oct 2024 00:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729383415; cv=none; b=DPBCBIgmx0YjdK48TTvzObJYbLtW+YHoewvF9QYt6imC5sGw1t0emE7KkIEMI2hI3eTIu093rOyDZj1/vJ5UWNyFueo6BfxbNDgyQ80PMsk27P9GKVCDFXIqPhEAzoPuAxDz85S5R+3hqAGpeB0CnHSgEXEEeYE5LkWcLVasWP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729383415; c=relaxed/simple;
	bh=4nWCcVgNwZmT+J155u8sQ6LHY+zidjsozMsC45vxYmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QxrntSJHoRdn5N+8PS252dSjHGSG4joQ9X5WVdVPu6fchgEJUwAS0ZOQcK4rC9LrmEN6onZbC0qb2yBRMhGEjH5SetQMB25LI9ZmJZwIuIayWrB/hY0cDfjC+9CMtamIg/ARoqjL2OIsAiX6op4l62As+U+LgQ4BQ93KasPbNX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d6lNs9NC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6lNs9NC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729383412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=or/yiB9Bu3RiCaJk2pWKK99jtEnWq4g9dV4LlVxDLOc=;
	b=d6lNs9NCvVKc1hO87pZwpqRra47voKkxLWUwbH7NTeWgRcADtCrG77GmIKwDuR57SK+o22
	TFASrhUvBI0eNRR2vTLv13b07v1HTwsYrTzc2CxJSx+pu4Ef3v3Qmgzk2bL+d74/RDaKMi
	1BXBYrvvg9F4ah2dquVxHwb3mByQPBQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-7d1ExIBvNYyrPJWNOR9g7Q-1; Sat, 19 Oct 2024 20:16:51 -0400
X-MC-Unique: 7d1ExIBvNYyrPJWNOR9g7Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43157e3521dso22623705e9.1
        for <virtualization@lists.linux.dev>; Sat, 19 Oct 2024 17:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729383410; x=1729988210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=or/yiB9Bu3RiCaJk2pWKK99jtEnWq4g9dV4LlVxDLOc=;
        b=M8SnZDHvfAe1eGe7sF/CPSdUcxMzWFvUaawNNBoBqunJ38bduA8T4kOtx8FoBrB4r3
         fh6IGlE7W6C8Bkm2Hclau5kJpEoVWpGmSnyWvV31oZZ16+wVL6ch3Qd/E0K25mPr1oPZ
         uaMrq8vTEUGa2sG6tO9lb8rL8oUAw0jpx20/VxfsysIXC1oSr9hh5xEuI1Nj50Sc/0o8
         d12cEjm5n5tthqDFGRc4UEVf0HNAt9GvXDY5Ek38zYzY38WCbZB/6o++NHHosL77tcYG
         DDR5Q12wzLzhFeaKIlN7k8+H+FAb1lFp63go9e2G7f0wuyT13fQbftSrhmeQeVuRr/T2
         a9Fw==
X-Forwarded-Encrypted: i=1; AJvYcCU2aYZeJfwCslxKQ2XKzU269suGoD4gTkmac/PSqKfwL/O8fPMH2GPB4a08WVFWYQ5Zu+hkaaxPTO7ACEUF6g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMKZb8h5HqjUv3XMAcFyrHyCre2cCgnHCfLCWHo1Yf4RNTuFhq
	zUIiuIMWsPy03DWYDcuHqVA0opXVhq3xd/HDyEEtNVZVB/DoGRdamJ8tTE5KLnFNurOC4xPG8n3
	R0staJsusYLYEhamVFKLugk3TGJiSpN0gl0CRzmiifizh0aN0D+nBR+sjSGd/uTlZ
X-Received: by 2002:a5d:4952:0:b0:374:fa0a:773c with SMTP id ffacd0b85a97d-37eab4ed869mr4187057f8f.47.1729383409835;
        Sat, 19 Oct 2024 17:16:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFW8rNNSMLfWH/xZFL3V72aDhzOhHJhrgTxKwJDJWnDH+yL3bJWVtZvNkVfYNU8FESgNMMTWg==
X-Received: by 2002:a5d:4952:0:b0:374:fa0a:773c with SMTP id ffacd0b85a97d-37eab4ed869mr4187044f8f.47.1729383409436;
        Sat, 19 Oct 2024 17:16:49 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7405:9900:56a3:401a:f419:5de9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94131sm585161f8f.81.2024.10.19.17.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 17:16:47 -0700 (PDT)
Date: Sat, 19 Oct 2024 20:16:44 -0400
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
Message-ID: <20241019201059-mutt-send-email-mst@kernel.org>
References: <20240920140530.775307-1-schalla@marvell.com>
 <Zvu3HktM4imgHpUw@infradead.org>
 <DS0PR18MB5368BC2C0778D769C4CAC835A0442@DS0PR18MB5368.namprd18.prod.outlook.com>
 <Zw3mC3Ej7m0KyZVv@infradead.org>
 <20241016134127-mutt-send-email-mst@kernel.org>
 <ZxCrqPPbidzZb6w1@infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZxCrqPPbidzZb6w1@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 16, 2024 at 11:16:08PM -0700, Christoph Hellwig wrote:
> On Wed, Oct 16, 2024 at 01:41:51PM -0400, Michael S. Tsirkin wrote:
> > It's basically because vfio does, so we have to follow suit.
> 
> That's a very bold argument, especially without any rationale of
> 
>  a) why you need to match the feature set

Because people want to move from some vendor specific solution with vfio
to a standard vdpa compatible one with vdpa.

We could just block them since we don't support tainted kernels anyway,
but it's a step in the right direction since it allows moving to
virtio, and the kernel is tained so no big support costs (although
qe costs do exist, as with any code).

>  b) how even adding it to vfio was agood idea

That ship has sailed.

-- 
MST

