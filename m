Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24C1286D4C
	for <virtualization@lists.linux.dev>; Fri, 22 Aug 2025 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867900; cv=none; b=WhQMCbsbC7e1wXMDe+3P2qFbRcG2guEKkDbFhBwXajxE6YlD1zh7XzWYtx+D2jzV4HiJlUoC82HRWKjhV1t8d6LCohXCvgR446hE+i3f93iqCS/ubMOjvvsmw6l3R8ln5EHkHjIazD3d7HUmxor1kh+ifutY5RKlmC0/sT1Mql0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867900; c=relaxed/simple;
	bh=w0Q+FsNizwQyUYK9BsZ2M/EWU17/ju7wdDubu9d4kts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MmY5T8Yv/3zAYXJMZpUBS2mBjqE6cMnv424bCZ17GlOi400BxInXSAJRJh/C5b8SCq11Gq4aYBajAqO+i3x8X7CJKUqVUByxG3leH9FIBWrVT/iVvXbhd9yW+g8MKjgJWhRfauHLvl1ux4tpXBaCyguM8XBy5jDufcC1RrfSycQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RBLUvTW+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBLUvTW+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755867897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HbdcQpncCh7btF+aNsL0pGSPRE3CkROlaSyGQtuUHUw=;
	b=RBLUvTW+IDXB0K4j3p1hFW7sA6NI6Lfx5o2M1KZ7DNj20cAozTczLmSo6ktlkQ0T3fIRGg
	5uVUcEgX9IWDx9SZA4QKAuYFjUds62OnUt9eVL8mflvfVbqXlawQibSwZzzJ/IrwmwVuVf
	jH1MJIMqWt33f+lyVJ4YnE2Ca/nWsGQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-UqQ-zozpNW2JDVtkupUgQQ-1; Fri, 22 Aug 2025 09:04:56 -0400
X-MC-Unique: UqQ-zozpNW2JDVtkupUgQQ-1
X-Mimecast-MFC-AGG-ID: UqQ-zozpNW2JDVtkupUgQQ_1755867895
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b05a59cso14973325e9.1
        for <virtualization@lists.linux.dev>; Fri, 22 Aug 2025 06:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755867895; x=1756472695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbdcQpncCh7btF+aNsL0pGSPRE3CkROlaSyGQtuUHUw=;
        b=k40jey6ElP2AMS3T+emQPR8CEriEomnT9E9mYPh6+Q2gTHwB5XHlBk2huX1ObXKKEm
         q+SNYU+J9vgWhaAdOEQxKBPPzC1PoRHkZLyeYdcrZZ71M116P33tmAgM3MBhvxtYDXUu
         nrHGxT2hjLxbZQoP5v+gKgKdoJzIca0A48K0cTDzj4mK9SeolkNdjgScOQJYVk9ftA2L
         N7uTNEXOCow9KxqqohUrOmWOajACxsNhsWhQ00NjFSRn11t9xg0VjWh/7UtCKR5FRSbZ
         f/bdFMvFZU6CYs1doXxnlnnyQ9/NjihkmkZivwb5Gvd7SNnvk0IYmPc9ghAln5JlT/xj
         Aojw==
X-Forwarded-Encrypted: i=1; AJvYcCUACoNNOlgQtBM+07GNZ07/QNVGJZoPfvvYt6qU0+HS8uDBB9uc3IcDdsjZSlM9S5AxiCSQWX0ptrOrOo6KtQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyF+XkiLVCr7o7mA5IB+ZeoLDRXywZAEd92bTH2CX3coS6FHq5w
	KWmBbJRaGeYqLN3gsbLkkR78Lc6RrHS/A3u08WX278iie2s+6zkhsvBot9dSnhPcSWuPVHGmS77
	hemM+CszkQ7rDJ5Y24+3a+iyG+8JmJQN238LCKAvfXX91YjAkfGiwm1vHOklNYGqUkHc5
X-Gm-Gg: ASbGnctW5mj4zPjWFxEgog94evN8UHxrdyfWoXXPZc1p2Y6ZVYezC75jsLQ17XExUBZ
	Qsfps8wO+diujngxzHUzUvfL3PLwuITOJqcMTNoI2di+dBwdQft2ybXitHLHa/klR1/e2kUwrf+
	UmVL6NdNSSwQx6V2lks4y2otbOEAQMNI6c0q5w0qWQ856ibe4eW5/XR7ua7iX+IcWY6VXuVHnif
	AnT7+XsKHE26DvnwdLP1AbzGOV5+wsWEgea3oF02sEc7bghcbmEky+UJGHLusUs+9d0+HZZ8FKw
	kLOh2wBIA2eVPzWszQyfbsShg4wbFiA1
X-Received: by 2002:a05:600c:8b17:b0:45b:47e1:ef68 with SMTP id 5b1f17b1804b1-45b517e8dc2mr23760045e9.35.1755867894713;
        Fri, 22 Aug 2025 06:04:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFngGGmvja+c3hZ9pHn+YWINTUlG6R2wYP0GDnbBthnGEIHH5TrUNX9aU7b3F3Zm40FnvOqRg==
X-Received: by 2002:a05:600c:8b17:b0:45b:47e1:ef68 with SMTP id 5b1f17b1804b1-45b517e8dc2mr23759625e9.35.1755867894246;
        Fri, 22 Aug 2025 06:04:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4e269d20sm37762895e9.2.2025.08.22.06.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:04:53 -0700 (PDT)
Date: Fri, 22 Aug 2025 09:04:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Message-ID: <20250822090407-mutt-send-email-mst@kernel.org>
References: <0cfe1ccf662346a2a6bc082b91ce9704@baidu.com>
 <CY8PR12MB7195996E1181A80D5890B9F1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CY8PR12MB7195996E1181A80D5890B9F1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lQePb5P9Aqv7aPmcgZzJkbBhQeTtIEmhjP8M9xPOvEU_1755867895
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 22, 2025 at 12:24:06PM +0000, Parav Pandit wrote:
> 
> > From: Li,Rongqing <lirongqing@baidu.com>
> > Sent: 22 August 2025 03:57 PM
> > 
> > > This reverts commit 43bb40c5b926 ("virtio_pci: Support surprise
> > > removal of virtio pci device").
> > >
> > > Virtio drivers and PCI devices have never fully supported true
> > > surprise (aka hot
> > > unplug) removal. Drivers historically continued processing and waiting
> > > for pending I/O and even continued synchronous device reset during
> > > surprise removal. Devices have also continued completing I/Os, doing
> > > DMA and allowing device reset after surprise removal to support such drivers.
> > >
> > > Supporting it correctly would require a new device capability and
> > > driver negotiation in the virtio specification to safely stop I/O and free queue
> > memory.
> > > Failure to do so either breaks all the existing drivers with call
> > > trace listed in the commit or crashes the host on continuing the DMA.
> > > Hence, until such specification and devices are invented, restore the
> > > previous behavior of treating surprise removal as graceful removal to
> > > avoid regressions and maintain system stability same as before the
> > > commit 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci
> > device").
> > >
> > > As explained above, previous analysis of solving this only in driver
> > > was incomplete and non-reliable at [1] and at [2]; Hence reverting
> > > commit
> > > 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci
> > > device") is still the best stand to restore failures of virtio net and block
> > devices.
> > >
> > > [1]
> > >
> > https://lore.kernel.org/virtualization/CY8PR12MB719506CC5613EB100BC6C6
> > > 38 DCBD2@CY8PR12MB7195.namprd12.prod.outlook.com/#t
> > > [2]
> > > https://lore.kernel.org/virtualization/20250602024358.57114-1-parav@nv
> > > idia.c
> > > om/
> > >
> > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio
> > > pci device")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: lirongqing@baidu.com
> > > Closes:
> > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b474
> > > 1@b
> > > aidu.com/
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > 
> > 
> > 
> > Tested-by: Li RongQing <lirongqing@baidu.com>
> > 
> > Thanks
> > 
> > -Li
> >
> Multiple users are blocked to have this fix in stable kernel.

what are these users doing that is blocked by this fix?

-- 
MST

