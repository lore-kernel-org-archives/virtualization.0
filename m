Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E18288C97
	for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750095189; cv=none; b=DCp/bDyTtJsVUv6HUHE3vedOrWPGwZ/kr/mXJY0xHKG+eN6oCaBxMgoDEZufT8UWeF/1g6jl8pdvzu1wd2M31Se6wKX9HT1b98/+SwzqrLNFiQVo47sJqMO2wVghuFBFunWf8BUoREh8gNqF588Eo5k+UT1vT4IHGlP+v4aCkWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750095189; c=relaxed/simple;
	bh=xFsrEhbFGU3z9UoiI2uJaXv//xa6Xz4juyBcTH3R7C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4Lyum2HnASpdc+gNHkYKJbGz/YXa7K9Cg/HMPyaA5NHa8iC1EW0T7nJsOzMFDIV9j2/Vs0tYFsX8++AtkmtzlKpmXaBNin6SSj2XGVzi3OoZ6Piobm0GPeYt6CtGPz6yVxTL61vZoUgUqFgU4xPhJ1bcuLay6xG/K/R4UsdCQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=drqhHnHS; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="drqhHnHS"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7d09ab17244so457612385a.0
        for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 10:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1750095186; x=1750699986; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8X31SysrSCqMRM+zb4wzBK8eDdmvTJaf6Uq+iS7ehOE=;
        b=drqhHnHSpOW1JDYYB2RpeH2S/H5md1qSpXxYJQrLOauxW4vHcswcMQGKHzme+cLzZH
         yd0ots11BTp1FsW5C8YyseBmxesdooLmZ0x+DWFnlDM/IuiEg3KB4AeiSme9IednEOeO
         8LwX6JqKNf2rE5BWZ+Q4wOEOCDJJTIiD0s89tDL3Fogw/9qETJUDg+p8zg02QJbpl18/
         OCacL/Z3OmuoNbl4V5TBDvGzTdxrx1GkfNTDevN8iTT4h3Dea/CrZePq9Ac/LFxzoTGs
         gJiAFW0mHnZcReQL1x3fQYJkVrGtzct21B9nWSWtMCN5CeUm9vkKOBDE8iXHSKW0AwM9
         fS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750095186; x=1750699986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8X31SysrSCqMRM+zb4wzBK8eDdmvTJaf6Uq+iS7ehOE=;
        b=ug6YSoCeQ6BbUPVaYKPKUQUSeymprCDAH74xwlT6IF6Z8Ohf9q0xwaRDbCf2pVMD/E
         R4jaqDO2Yme9gNBAiZcZ3UKqEGLpBlW3VdOmoY/I8hPvk8qcbTTaDe8RbtNaBkONsWvR
         8Bx1di0VzE3x66RkDl8pJdhY7b1uO9bPp5aZhi/VlAol460MSEYad+VDymZoKz+t77GJ
         hC/5elvTm3CLqYqXC3YQ+Vl2y5dJisDJUjK92Hf6cdw0n7hl+3ThFAhNiSErdV3UrkvP
         lS4tA6zxhA/sehlUb5FNIvEhMS7HgliV/uney23oKxyM0zJaHkDhhWdEXz5dWzQ4pZjl
         jA3w==
X-Forwarded-Encrypted: i=1; AJvYcCVn+haPZBRFYZmq2PcH3CjeE1yifRpTkvY8MYHtQgpfAYEJsTjDjjqPKM8cSO0Z2O9MjYGDOsykv+i/V6I3bw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVoEyh74tQd6MGH+N7YlRR+WrMhbCOizbxuKiAOd1e6LZno781
	gJa/d/vxATbh3S78mY2tBfGHgJqRfmhjU69qcbO3vH8CLEqUTkfw/S2mqYkReDRp+Ec=
X-Gm-Gg: ASbGncsuOOFPYotf+yYsKEBoKJzCpJqbqpSBG3sWPHFbd4Mv0ybJDNbhmTmMJG+s+qK
	T5AT9JuLGRp4jsdtocC08rW9/nNQfJ3UI5d9ebnC9gralulu8Ju7G3aKPkRqKkOPqK09nRijPdD
	bN7D4v3JjPPMGKFmsiQFzP+hln6gjaUoFdhKyGtzGnaJGe00B9jS3aeqjN93VMFqYOSQPv1j05a
	QPIGGs7o7Dl6unH0VY0QBmnm00QZsE6iP7GgMSYiezPhvh3hHtxa7uWeMCdY8CMzR1URC/0Gst+
	TIwWn5aQXPmg9cWwjUKkQQN9b3suQ6+zLO7I5xu7mzXZXbgIZbbFyw5I0Mu62f7CtV1oeVgpHmt
	QQBRk+3rVasE5r2w0VlU6gJwlz5z07NIuDqMSZQ==
X-Google-Smtp-Source: AGHT+IF4chGBuDLOAfxdrZKfkSU9t0Ai/SG6GB1rXrSJpRvbZP1WNygH1xEW0dli48w32M0hptcl5w==
X-Received: by 2002:a05:620a:c4f:b0:7ca:dac1:a2d9 with SMTP id af79cd13be357-7d3c6cdf0c2mr1264284085a.28.1750095186387;
        Mon, 16 Jun 2025 10:33:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8dc9b58sm553436685a.13.2025.06.16.10.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 10:33:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uRDhh-00000005m43-1aC1;
	Mon, 16 Jun 2025 14:33:05 -0300
Date: Mon, 16 Jun 2025 14:33:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
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
Message-ID: <20250616173305.GA1376249@ziepe.ca>
References: <>
 <a65d955c-192b-4e79-ab11-8e2af78b62af@gmail.com>
 <20250616132031.GB1354058@ziepe.ca>
 <8c3b08d5-24aa-4db2-84e1-dfd1d2c52065@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c3b08d5-24aa-4db2-84e1-dfd1d2c52065@gmail.com>

On Mon, Jun 16, 2025 at 12:53:40PM -0400, Demi Marie Obenour wrote:

> > AFAIK hyperv shows how to build something like this.
> Would this need KVM patches?  I'm concerned that implementing this
> in userspace would interact badly with the irqfd fast path.

I don't know. I think you get the same issues even if you did
virtio-iommu irq handling, it shouldn't be any different.

I'm not sure there even is a fast path here, remapping happens during
initial vector setup/affinity change only. That isn't fast path. So
long as the MSI is delivered to the correct CPU vector entirely in KVM
it seems OK.

And the hyperv approach of asking the hypervisor for the addr/data
pair to achieve certain parameters will work alot better with existing
Linux than trying to build a iommu emulation where the guest is
building its own private addr/data pairs :\

Jason
