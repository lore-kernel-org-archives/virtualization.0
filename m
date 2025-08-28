Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D8627A461
	for <virtualization@lists.linux.dev>; Thu, 28 Aug 2025 06:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756362859; cv=none; b=IaAYxmjVvFKVJnwB19oDneXRFA3qU9K5mSoO67oCCylUfx72gLdEMA+DiK1+/EcUKbQV2eCaYjt1r3mGTHfcbjV2PQuwQLzltGK29BSwuNnx9H791PJfo1HPoV3WzdE/uWrM7USg2T4/MAl7PWgrroNxaRDu+b7TZQnI7lEMjhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756362859; c=relaxed/simple;
	bh=O+hoOkpxKzFagM4YINohrcCRbkfOC3WyapBZoGGUub0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mpT/EGFubRRvz5NjZhhsLUj1hM2kYCjk7UsASsTsmP5N60b8z1mQz+k9TwDB0CzaqeUW1T9WCmeRN6ChwYu5FqMT8PmaT2qF0ry/EaplRxJQfKO7YYzyvS2MxC259qEAiaR0fFaQrfGyTAWe3e2SUb0xaHu9dLjoCERuU9g5Oww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KN6OXcDp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KN6OXcDp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756362856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NBle0psK83326FXvykrXUefZ5fJAW3yvhWvuCeWq0c4=;
	b=KN6OXcDpNpt8iqG5zeZ/9xXnzfGZkZVFK+3TN/9efJjdlo1tIyaMDpkWgdtMRS4G5fwQIJ
	502B94iylZgdaq/TYlL0lfYjBxwH1jChngM7x/TY0D1aqHKhWuZFQ8S82zGkAMdJZACAqQ
	SSJ6miLOkcphsJxKuNuHGeeknn8Cj18=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-D68xveRBNlSWzAc-FlB_vA-1; Thu, 28 Aug 2025 02:34:14 -0400
X-MC-Unique: D68xveRBNlSWzAc-FlB_vA-1
X-Mimecast-MFC-AGG-ID: D68xveRBNlSWzAc-FlB_vA_1756362853
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0b14daso3019975e9.2
        for <virtualization@lists.linux.dev>; Wed, 27 Aug 2025 23:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756362853; x=1756967653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBle0psK83326FXvykrXUefZ5fJAW3yvhWvuCeWq0c4=;
        b=BBbNfOIz9fmM+dRDqBAI6km41ysug5qr82Di8jpLDc0l21rGr+BhohO1M1YBdfeqdU
         DIDC1w89+cvDL1rQIbQp8AIdqWFCYr80yLy1I4++dz0GVrwPfV6//QZxaoQA6sigAsVu
         ZVBqNvRHFvbasgBPl6NXFKmWrqq3kQHSnEkG0wt00kiGNT9trISm5bxoqo4F/w7UGjV4
         tts0LCpV/GdmtoL5e/7i4oDUzK2k8OA8JhbTwmfXHGxROsoYSkLOou3sVr9hhnGHhpXX
         mZiLignyLCLLhIwWqNZtJLLbo42JZu/RyKtm7Co+h+n9PeNWfLJB/+Gn6IhlVIV+ICrq
         Ceog==
X-Forwarded-Encrypted: i=1; AJvYcCXDdD+dFXsZqNZYh9YfJuORsBkB0IoeCsX87eHNL7KiTlhpBFm4latcHsYv/rgzEYvyK/1qz0hLRQTyTwTSyg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzR2wrZN90o8aN+FN8KPyHESW+v5woBwif/xX+KBmyzTY3SXVUX
	rYVSNWCRkLaHslbSh8pdDVh1zHVa+AQZ88CkZdUV8/DJWiR/aEQ36H158AhKNXQYe5c2bYqgNQK
	myO3C1xeLP0EndohYFR7I4ejfFXqYgdTN3PYztr+LqgcmLa6W6jhaOTku8r2/itvx/NCh
X-Gm-Gg: ASbGnctFibP/aHPY/+7mR9UWQI37QpyS97claoZI9qd0AR1jBdsfgVCbz2sPV4x0HJq
	L6ko0R3HfS4VXKkGxrtYL9ToVPX+Gpi5u3c3JHYiv9rXkaWLqzoRmpVy9oBf5D3VtyEWXYQKez8
	LV8oCaFQw9HoyFn4gw0hkOXWFKUGWpqmHgCJIaalPCMh1zf8aJdEZIl5lPI5AYneeDwuFYAqu2g
	CkCvQ0SOmEhhJ/kQdb2iBMUMdM35oAVmA0MXIhDpBMks/k8/yqrdm4aZ4b0XzAPpjIMsvkSUL5O
	Vmt3WTaYQ/oZ+H+zh7kcxfOeN7xWmtGX
X-Received: by 2002:a05:600c:a46:b0:456:19be:5e8 with SMTP id 5b1f17b1804b1-45b517d459dmr188529365e9.20.1756362853185;
        Wed, 27 Aug 2025 23:34:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ8ShxovhE59HtjACcDksQuottjD5sgqN9H8NEO7Hjz/jKK66gFgjy+2JmPy1tKxjXKq2wUw==
X-Received: by 2002:a05:600c:a46:b0:456:19be:5e8 with SMTP id 5b1f17b1804b1-45b517d459dmr188529155e9.20.1756362852764;
        Wed, 27 Aug 2025 23:34:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b797dcad5sm17887505e9.18.2025.08.27.23.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 23:34:12 -0700 (PDT)
Date: Thu, 28 Aug 2025 02:34:09 -0400
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
Message-ID: <20250828022502-mutt-send-email-mst@kernel.org>
References: <CY8PR12MB7195996E1181A80D5890B9F1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822090407-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195425BDE79592BA24645C1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822095948-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71954425100362FBA7E29F15DC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250824102542-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195EC4A075009871C937664DC39A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250827061925-mutt-send-email-mst@kernel.org>
 <20250827064404-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71950328172FA0A696839623DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CY8PR12MB71950328172FA0A696839623DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1qQG9WgemRDoQce-mcr3JjWceKFA3jopKK2e4Q5j9-s_1756362853
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 28, 2025 at 06:23:02AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: 27 August 2025 04:19 PM
> > 
> > On Wed, Aug 27, 2025 at 06:21:28AM -0400, Michael S. Tsirkin wrote:
> > > On Tue, Aug 26, 2025 at 06:52:11PM +0000, Parav Pandit wrote:
> > > > > > > If it does not, and a user pull out the working device, how
> > > > > > > does your patch help?
> > > > > > >
> > > > > > A driver must tell that it will not follow broken ancient
> > > > > > behaviour and at that
> > > > > point device would stop its ancient backward compatibility mode.
> > > > >
> > > > >
> > > > >
> > > > > I don't know what is "ancient backward compatibility mode".
> > > > >
> > > > Let me explain.
> > > > Sadly, CSPs virtio pci device implementation is done such a way that, it
> > works with ancient Linux kernel which does not have commit
> > 43bb40c5b9265.
> > >
> > >
> > > OK we are getting new information here.
> > >
> > > So let me summarize. There's a virtual system that pretends, to the
> > > guest, that device was removed by surprise removal, but actually
> > > device is there and is still doing DMA.
> > > Is that a fair summary?
> > 
> Yes.
>
> > If that is the case, the thing to do would be to try and detect the fake removal
> > and then work with device as usual - device not doing DMA after removal is
> > pretty fundamental, after all.
> > 
> The issue is: one can build the device to stop the DMA.
> There is no predictable combination for the driver and device that can work for the user.
> For example, 
> Device that stops the dma will not work before the commit 43bb40c5b9265.
> Device that continues the dma will not work with whatever new implementation done in future kernels.
> 
> Hence the capability negotiation would be needed so that device can stop the DMA, config interrupts etc.

So this is a broken implementation at the pci level. We really can't fix
removal for this device at all, except by fixing the device. Whatever
works, works by chance.  Feature negotiation in spec is not the way to
fix that, but some work arounds in the driver to skip the device are
acceptable, mostly to not bother with it.

Pls document exactly how this pci looks. Does it have an id we can use
to detect it?

> > For example, how about reading device control+status?
> > 
> Most platforms read 0xffff on non-existing device, but not sure if this the standard or well defined.

IIRC it's in the pci spec as a note.

> > If we get all ones device has been removed If we get 0 in bus master: device
> > has been removed but re-inserted Anything else is a fake removal
> > 
> Bus master check may pass, right returning all 1s, even if the device is removed, isn't it?


So we check all ones 1st, only check bus master if not all ones?


> > Hmm?
> > 
> > 
> > 
> > > --
> > > MST
> > 

