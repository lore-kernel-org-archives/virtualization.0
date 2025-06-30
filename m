Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA94A299952
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751304363; cv=none; b=j6cCEiwgMJjWZVEEkb8jPLl7I9t+ret4vUGu0xNybm3x/uHw3z3AXBCLajVLhf4gdc8cVfx5At4Y9ZwoyIIl8unudlD1OEDIp5etS+294Xh71Q0XHgEt9CS4w4l7oSXE/Y4b8V4HeSpeurAj1wF5j3pEeFgw+I0nxn/knd1Jrlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751304363; c=relaxed/simple;
	bh=/ed1E/z18Xh1fVpk+ZX4y+GGRM+8GW66EdG4YQHARuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uFIrWf3EDcw4tq2+fIJLE/Ap1gT6il8Oz6K/T0OuF/RGNtfCcecPeaaUcAfvpX29iLZbMZIKIFWXqbZQe/OuKXueIBw39+UBnc5VBVeH5Rnl097YXyZ+y1BCTNlby/PnelqkhMl4BsM2HhBbLvPBeroqlPtqf7iS+mxUUjFWX64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bShMX1zV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bShMX1zV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751304361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DirzX1KCKtv521PxYtm6kg9uFvxjRQhuzEiLEHXJyMU=;
	b=bShMX1zVTSZB2mWfzaDhM/r8zA0d1amoo7TUlFAOC87Vemw6kBOO7RhWR7wgUIkzGgD6JO
	nK/jiA9cs0WvVcvFjymCQhJUxYWghAvbC5aSEczyzHAqePXR+1EyliFNFy3sjvJAVB7WVe
	sJBjBXkUPr4/xLoPLZSpV5vjJUMbQWU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-_Ku1lNhQMmCgXqBKfIGLHw-1; Mon, 30 Jun 2025 13:25:59 -0400
X-MC-Unique: _Ku1lNhQMmCgXqBKfIGLHw-1
X-Mimecast-MFC-AGG-ID: _Ku1lNhQMmCgXqBKfIGLHw_1751304358
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a58939191eso807686f8f.0
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 10:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751304358; x=1751909158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DirzX1KCKtv521PxYtm6kg9uFvxjRQhuzEiLEHXJyMU=;
        b=LdkrybDA482WmD15ZxEXH8TyJlYyvuC6Uihu15iAFgDVYyvKTdRs3zBo/Z1WMRH7hL
         PiIHjKcCXYs6Rd3LbySDX1de+fekDYcr/nfed7Tm2EKmQihW4XLFJwT9mIemohfZXaTk
         OLZ57hcIOx/6DSeQ1itu3iA/Wp/fsuzJAh8D/e1TMX/SGmg4gOyq5IX2nqLEco6tkF4L
         HCONstUQyZ8/L0ZQpFS/vmcyXDAz19PNRzAlMP0HUsqvLpq1GG+yjy6I/Fnn0KET3BQq
         JgtnBfYfxb2szKDbrX2DovtkNaKTNur2m8H2BGHpKbfJJIPfMzXVzTgLIBHOZ8p3MKJW
         ftYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6r6bRdLCymvME9EJlsGomZgMc9//A6eXs9kYSnOQbaXW9z5F2MIFxD2o72D1kGwxPTCceC5TdCE7TKPEUTA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxqvegwTT9PK7pZNxXLSgUxUAcgLMeihEdooToZVbP+vtrtfOp1
	Oe6kx20VCqDqPe9Xshr04dmO8aTmjC29E0SrvJ/gKPwk3yO+u9lxVYqyeDa3y3h6KagLFNu08oP
	xY1vW/bydzdTVArDPtu4uC7RZ1avQhjBgDhiGrwq5hEd9kB7XW19cznMvzF8XBfhuqsKA
X-Gm-Gg: ASbGncuSA+yBW03yS+tHSALLsaCBRHITYS8obL39xTrONORuCmnmvMlFbkKBRd5k+6l
	xNWTZxawY10swYcipU2dGoqK1Va049sQJHJ8isNV1kcSXTiInxMB9UyYbzhNcimTAwYkjCR67ab
	NbnYW2VPQm0T3i4hILr8zFY0fSE5w9Fxx5grVvvh2lMNYVVOVdZGVlCGjD/AR6mV+/xMneCGVI4
	Sg59jWFzLrdlj5pw4r2UFd/Nlw4xhbdNB29KCOJdyJ14jkORaWVTRTlZ40+PeJMwFKWt6Q7cnon
	mFWjsVlUTY3FjcZD
X-Received: by 2002:a05:6000:710:b0:3aa:c9a8:a387 with SMTP id ffacd0b85a97d-3aac9a8a39cmr8482272f8f.0.1751304358220;
        Mon, 30 Jun 2025 10:25:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxJNxP8kFLxbkJcu5vn1wYxIzXeajCRrSl1+SZhoLGhSVkUygc5Y6gw3Iwu1mrPLUoBFlNVA==
X-Received: by 2002:a05:6000:710:b0:3aa:c9a8:a387 with SMTP id ffacd0b85a97d-3aac9a8a39cmr8482242f8f.0.1751304357754;
        Mon, 30 Jun 2025 10:25:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45388888533sm152948825e9.21.2025.06.30.10.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:25:57 -0700 (PDT)
Date: Mon, 30 Jun 2025 13:25:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Parav Pandit <parav@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>
Subject: Re: [PATCH RFC] pci: report surprise removal events
Message-ID: <20250630132444-mutt-send-email-mst@kernel.org>
References: <11cfcb55b5302999b0e58b94018f92a379196698.1751136072.git.mst@redhat.com>
 <aGFBW7wet9V4WENC@wunner.de>
 <20250629132113-mutt-send-email-mst@kernel.org>
 <aGHOzj3_MQ3x7hAD@kbusch-mbp>
 <CY8PR12MB7195F2F2900BAEA69F5431E9DC46A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <aGKUqsudjfk8wCHI@kbusch-mbp>
 <CY8PR12MB7195583E429203129577B51ADC46A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <aGLB_8SFF1Cw95MZ@kbusch-mbp>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aGLB_8SFF1Cw95MZ@kbusch-mbp>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -KvqSd_QphT5JvZZ3jngzLLeTSWARLhi_ZMReQRzyag_1751304358
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 30, 2025 at 10:57:35AM -0600, Keith Busch wrote:
> On Mon, Jun 30, 2025 at 01:52:26PM +0000, Parav Pandit wrote:
> > > 
> > > But I didn't suggest calling error_detected from report_error_detected.
> > > Just call it directly without device_lock. It's not very feasible to enforce a non-
> > > blocking callback, though, if speed is really a concern here.
> > Yeah, it would better to either always call a callback with or without the lock.
> > In some flows with lock and in some flows without lock would likely be
> > very bad as one cannot establish a sane locking order.
> 
> On closer look, my suggestion without the device_lock may be racy, but
> using the device_lock prevents the notification that needs to happen.
> Hm, not as easy as I thought. :(

I think I will just add a work_struct and a flag that the driver can set
to schedule it on surprise removal then. Hmm?

-- 
MST

