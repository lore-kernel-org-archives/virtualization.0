Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458E52F5313
	for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 23:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750201418; cv=none; b=kOODbLS/zORc5bQSPV3JjWXlTkcpVYjxPhu0kAmtPHZt1SfhfCmDavhPFsjiRBAje/bsYaOXNxFjBel5z+EMyAtWM2jdpjECYjXyLgkrCVPKbtNZm46DyqNsyElPagLPIWBynAd+XQgswDouvKunzFBwDDB1m1nBo0L9FF215zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750201418; c=relaxed/simple;
	bh=7yQyAg9QQkikdevayCOR4HwJNpcyiWJT9okKkefa+HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/DTWcHNlBJaZzD8kbTDywiKGrP/7zFUUMrd7d3bMxOel8HhScAzn+n7O7YPMmgnXlOnXp6KRl3OkcIaynw3NgCd1jFYSVTNoxrQI4FwmxrZFrT9n5LtfvBk30CozxH8DJhfClQR1RzMCl2vc/MsQ0TdIbLZ7BFfK2fLjW8vmbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iglruPSZ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iglruPSZ"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7d3da67de87so236350485a.3
        for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 16:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1750201416; x=1750806216; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qeHg/OOZNjjpk2NyiVqmd4EaAAlIU7s30yRkT324JII=;
        b=iglruPSZ4QoNl6G7LEaB1hRTVfvUHeNppRaSFpHOzBg576btvEq6C9fOmUS1NuQcQ4
         9u+sCE3m7LhZI/kwqgD1l/NBKaQAXeohMaRvdpxpEcAhX+Aw8iBMYYgZcQ8pzYBO9e/f
         mZF3etmMptY0UB4qfGErIhjbfmYzNkxDFIs5DKWOA31A1Ex7RZ/MM/e4jY6U72NA6lrS
         16SfoaqCjq9yrNXN/3FeS1t+Udx4b9v3WDcjR2cDT82px7jCkp5+H65kpq7uzMtbuOLc
         mT2irn5Cu+vdnjzd0FTv7bXDRJw/M3GgR3ExGrblEbaY/ifZh/227zPlwh562XDhn1/c
         okaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750201416; x=1750806216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeHg/OOZNjjpk2NyiVqmd4EaAAlIU7s30yRkT324JII=;
        b=bRyhrxt5HJN3zQUloghOU1wY5MOIEVCnxPI/K1od//RPEQYTjCYc8iX7CKmczM3mIl
         LkLbscGim0NHo/JKOaB3YHn129cXaQCG0Xkf2BeHSuY9B760A0SJV/aKYRdZmluHfVpd
         r7MqRJCvN4E6zyAmcVK8ib6EM7Za3r4NgFDYpWdZ7qcNz5YgTYHz8YJ1+Bi4rBkDKuzL
         6ZhFmOvspEt+5PVBjgqEfPdPOgRmkaYgACCmxPO0FrwtdMIx0N4fOieJRXXMX3M/OLxc
         WA+yXQq0YZu0dEWPg7TTyvGKv14WwW69MfrwrI7/qSh7CAMRWNurkRqo0/X45qRcyfbG
         p8CA==
X-Forwarded-Encrypted: i=1; AJvYcCWUNuN6LpYtt/6TRh3GUUsacaXOaY0V78bDZRf6rgmfRg6XwtiRnONKUijTdZ9YOhCKcf0LjLit5qq3MFzHUw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOSGLbENqJtpmsKOQnds5yvTnULCjCEWt42QR6svgBYn5rl+wk
	ZqeCcwZkd67Rsv3wBl486MH4y0CFO7mQCiMIsg1wdwQHrKhSS9vGuXWqADr79iBWTTo=
X-Gm-Gg: ASbGncuJMlu7zWPUJbACKRE7IreL3K0kLmZQgrI3eIPOcjbC2DD5Gdr9W4enLYnKT0O
	mbUa8pHeHR1aM3InnhmzXWSZ4vG6tixPKvQuuEyvQlvgxOZQcf+PMMZdBvvOH20/SZfxnUWDZgf
	TWq5KfRpGabgF6XX4TKilDyq64c7dEuehRZHMeO3G5f03zUrKzbRrdkFynz5O9n81PYv7KEvUBP
	kjhPSuSGpF0uIq1LZJwDubOIAMOqGvDbENJ9E9gtysWl0YEmZsdgqevVMWaC2EuQJ2QEhjpc0uS
	jayciEeT4OCNw4tG2lqhIVWEDPEcYr4pMscpjM0Eh0XNNDEAHk/Ku+Puj1h8rbO4i5fasSuySn0
	BxW7Jd8JvSKmCu7kHMyVP1guxOyjJasnmnHpLgg==
X-Google-Smtp-Source: AGHT+IG5E4/SL5wvb+OTW2Z6g1HmGu8oKyQFTaoQSeLjiG0Pk8NLxhD4sGUeZI2iyMgdjVlOfelwLQ==
X-Received: by 2002:a05:620a:404b:b0:7d0:9519:8329 with SMTP id af79cd13be357-7d3c6c09cb8mr2841621585a.8.1750201416029;
        Tue, 17 Jun 2025 16:03:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8eaca05sm705183585a.73.2025.06.17.16.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 16:03:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uRfL4-00000006eJX-07UY;
	Tue, 17 Jun 2025 20:03:34 -0300
Date: Tue, 17 Jun 2025 20:03:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Demi Marie Obenour <demiobenour@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
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
Message-ID: <20250617230334.GJ1376515@ziepe.ca>
References: <>
 <a65d955c-192b-4e79-ab11-8e2af78b62af@gmail.com>
 <20250616132031.GB1354058@ziepe.ca>
 <20250617154331-mutt-send-email-mst@kernel.org>
 <20250617195720.GI1376515@ziepe.ca>
 <20250617160103-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617160103-mutt-send-email-mst@kernel.org>

On Tue, Jun 17, 2025 at 04:01:53PM -0400, Michael S. Tsirkin wrote:
> > On x86 you also need to use remapping to exceed the max CPU count that
> > can be encoded in the MSI, no iommu required to need this.
> 
> More of an x86 quirk though, isn't it?

Yes, but so is bundling IOMMU and remapping HW together <shrug>

GIC fully integrates it into the interrupt controller architecture.

Jason
