Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D1B274FE5
	for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 20:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750190523; cv=none; b=d45jz8V5fP4kZL2HRdugk24VZulO8MPaQ5IHXELD2xlF5faU2iyDgo2AesbMpu4ZffeON3n2MZpvfKYbiyGYP3pWspOzvLqDWS3Kuf0RHoaNDCot10zW3rq5nA1wNd6k9JKGjjF5BafB/KQYr1oXNxby/B6fQUG24YQPB+XLEA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750190523; c=relaxed/simple;
	bh=XMvjS9h95kOV8JujLb2GDDrONYa4hpVobP4wUiW7o7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kSq2G1PSp6Vkqmal/0XZkBg/tWB3NRH+5V1uGMQu2IRsjt6oGArwvW8YvFohBjOXJCsvouVYFGhjCEhyJxUPwVtJgQuEN6oz23Kzow82gSlTb4U188WoU95q1wUbabZwAHcukIVD9n8D2llUiTXVBkh8zuCIC6UPghT3+1dNehU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X/rhBhJb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/rhBhJb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750190520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O+NoG2Xo5HkG5dYXEBVx8rtfO3qQh/xgk518Z7oyOlQ=;
	b=X/rhBhJbsd8a0qt3OVm4vEyhpoEpud7JSWr1ukksyefRO/hBcmuEMACGgR3bk4iIs+5gY4
	hhsPypCwvJvn7cdQ+FlfKz+BVrkX99Py6YkvgMSyB7fOBZaoUygIV8zkCUbw6pxbVxtmr5
	e0U02JDLQcOuCOerGTKBi0rbsHSvd08=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-o4XKowQ6NbqBwXfGAIJxmQ-1; Tue, 17 Jun 2025 16:01:59 -0400
X-MC-Unique: o4XKowQ6NbqBwXfGAIJxmQ-1
X-Mimecast-MFC-AGG-ID: o4XKowQ6NbqBwXfGAIJxmQ_1750190518
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451deff247cso87595e9.1
        for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 13:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750190518; x=1750795318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+NoG2Xo5HkG5dYXEBVx8rtfO3qQh/xgk518Z7oyOlQ=;
        b=AopeOsf5booExLLt/w7uRA+EfAMxghf8C2rjP45QxeY7+DLfIChRcGElLMbKkPND1X
         zw+AbSmi/u8hPX03zCKd+TvttZyjvRbLKkfF9AZNbiikGGsTmUi9FS+S8MDE5jIgpTNN
         workca4Yih5oQSAnfcVOCPQKUidi6Uifk9a1cdWwaVDlEPAUkGqXfHy/Tppb2iyfS03V
         JqNFipyO184cQQYyNm62+S4b/LmO4VgY0Md8TZZPfHj1A9HaEpzkxkyO6h6O3Wy9QyAg
         E5X49zjZH5QgSl/aqGVHOiqnTHy64am0dQDLEonIk3P08gyK07IOt+empWT1OO0eK7rm
         b4aQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2isNsNEYL0hYbffW88mDgV0+Gablhcp1AbfDTuqGNu+zBStu8+aRIGZyHHQxAWKWb71tm6u07PikFNRgLZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQ4qngLw2fKIwXvCe8z/+0CkKjKfoKP6dac49vf7FX2VdPffp6
	wEOtB+7SptDu37/fwMCNotylT8sfv7+0gZY+5yOq8QwkxAVV8Uo1ENWbccrWf/3MAL0vdFf5Vl3
	ehzpMt9Ep/Su/lXRjQTM8aB/w/B7mcNIjDZWrK+wp17riAFBXQYH9ztLI1RMaekrZjMB0
X-Gm-Gg: ASbGncsvPX+V3OmDR0aB7CMwq+ILKcY8Mri4PfhQMwnH3ofTqq/Ivv3NcXGW5IC3z0X
	IQXQMN+GyXJBunI1aFHXsbkasSmNEmwVChgEjAZR0txlCGmE05KE1mKb0zxL59p+ZiUrRvrKpmf
	1lfPa4paEe8lRwhbvfH16ORlyAVrSc6yjyr2isxRsZUQqWeV3MW+wEqNZYLt4vJduaT74aj6rrY
	WtLh4uuZw6+ChrrfLhdi33ZtGLMh/cpAhMm4ackVX0XUvQYZ++L2VnEsxsiC6MynGiN5vCMTjE+
	B7uErsBITuUnkc/M
X-Received: by 2002:a05:600c:574b:b0:43c:ed33:a500 with SMTP id 5b1f17b1804b1-4533b2723fbmr106294525e9.10.1750190517522;
        Tue, 17 Jun 2025 13:01:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNEtk99gWXSpZ+RahNNIJ+KZNHzBGaVUSD+dSFjshNFQhawiqf1xX90P7+NZhpbwqFDbMbUg==
X-Received: by 2002:a05:600c:574b:b0:43c:ed33:a500 with SMTP id 5b1f17b1804b1-4533b2723fbmr106294125e9.10.1750190517096;
        Tue, 17 Jun 2025 13:01:57 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:4300:f7cc:3f8:48e8:2142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b4cc7bsm14653724f8f.86.2025.06.17.13.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 13:01:56 -0700 (PDT)
Date: Tue, 17 Jun 2025 16:01:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Demi Marie Obenour <demiobenour@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Alyssa Ross <hi@alyssa.is>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev, x86@kernel.org,
	Spectrum OS Development <devel@spectrum-os.org>
Subject: Re: Virtio-IOMMU interrupt remapping design
Message-ID: <20250617160103-mutt-send-email-mst@kernel.org>
References: <>
 <a65d955c-192b-4e79-ab11-8e2af78b62af@gmail.com>
 <20250616132031.GB1354058@ziepe.ca>
 <20250617154331-mutt-send-email-mst@kernel.org>
 <20250617195720.GI1376515@ziepe.ca>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250617195720.GI1376515@ziepe.ca>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MJmDC4Mx-K7cCaC9aZc_vlT60eLJwORZsXc20bFyTnA_1750190518
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 17, 2025 at 04:57:20PM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 17, 2025 at 03:44:20PM -0400, Michael S. Tsirkin wrote:
> > On Mon, Jun 16, 2025 at 10:20:31AM -0300, Jason Gunthorpe wrote:
> > > On Sun, Jun 15, 2025 at 02:47:15PM -0400, Demi Marie Obenour wrote:
> > > 
> > > > Is a paravirtualized IOMMU with interrupt remapping something that makes
> > > > sense?
> > > 
> > > IMHO linking interrupt remapping to the iommu is a poor design,
> > > interrupt routing belongs in the irq subsystem, not in the iommu.
> > > 
> > > The fact AMD and Intel both coupled their interrupt routing to their
> > > iommu hardware is just a weird design decision. ARM didn't do this,
> > > for instance.
> > 
> > why does it matter in which device it resides?
> 
> It would cleanup the boot process if the IRQ components were available
> at the same time as the IRQ drivers instead of much later when the
> iommu gets plugged in.
> 
> > Way I see it, there is little reason to remap interrupts without
> > also using an iommu, so why not a single device.  what did I miss?
> 
> Remapping interrupts can be understood to be virtualizing the MSI
> addr/data pair space so that the CPU controls where the interrupt goes
> though its internal tables not the device through the addr/data.
> 
> On x86 you also need to use remapping to exceed the max CPU count that
> can be encoded in the MSI, no iommu required to need this.

More of an x86 quirk though, isn't it?

> There is also some stuff related to IMS that could get improved here.
> 
> You don't need an iommu to enjoy those benefits.
> 
> Jason

