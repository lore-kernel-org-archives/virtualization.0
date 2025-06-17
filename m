Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6792877E1
	for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 19:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750190244; cv=none; b=M9RbFmqKZDCFZVLHNZmaaFw5H78QYVWq9F4d7tKCnuhCSPRDbZNW+VIpsc1I8EoGH/3qBZ8EAPrW7DC+wGgoDetI//ByQg4b3axEoQTuOGA/kbOKw7BkP8fNuMrpPWxQWlzoDGVZDWH1Ci8kY9uGsHdmKiiHI/V9CxaA1ffvVkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750190244; c=relaxed/simple;
	bh=g1hqr9LAd5tlBlXHUe2Abbj5LysvcxE3l71FgP8GPCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcsKYsaAUB9U1+rgJIuLARTUQWyv0FuRoYlSMDM5WBM3ex3Fak5tR8cIykft2lxjV/sO0oyjUHHZHRER1tUyGn2Mm4I4OJjjnVKCzgRVfbX1xIXGzwMdZ9qyfx8n/QA+pm6tb2zUL7o6oaO5TDtLqUzCYuW4Znmr220VdnoTg6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=daF76T+w; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="daF76T+w"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d09a032914so547600685a.3
        for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 12:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1750190242; x=1750795042; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GSljJoj4v6CeDXJDozVd8y37KP8tPNu+Cmnc8/7K2EU=;
        b=daF76T+wy9CiOZmcR+1hrlHOVlfB2+r+qNl/osIQFf50xCf4tG+3oZecJX3dh5caWy
         UXq58TfeuyKG37F8m8DXTECm/7B+Al+os17LQthFrkyFPRCsTP8cgdjW0n5nc6lRoiy/
         Shm29YhrCmMI5XapwJEEKOVowgJusLQGo7hVBbVYdukbnTE8UmB+msOMTyqepf8AJo97
         MzuDP84DlJDa5FKzpFHNszckEC4h1A5jDDMJaQ9IHd6BGUnExRqyeICj4hKUG3KhSl31
         Wp7B3w3nkeBSxsiETA26w2BmGOTM/mt/Do0r3Zt6cFDt2b58SIm0+2NRC+OGlHl9+a4J
         oiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750190242; x=1750795042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSljJoj4v6CeDXJDozVd8y37KP8tPNu+Cmnc8/7K2EU=;
        b=olYkU2nhTW8SD8efz87I6GcJ+C2XqTCJVckmB4OABgxm9x8iACDaaq7cFM6v4g8lhc
         AgR+TI3XCJDna80xEQ6guhYCk6f2ruTKYPTxpYva+IlFNjIk3qddJd885rDZ+KlIlHPc
         J9nKp9K/ZDaICJ180Zcf8jIvHm+8E5Gc/gekFyXYy+1DPBrH9o1vu4qYq0hGM9pVqI5T
         f8Gl6XwuV/zKYdEYHhPejf3LxtJfgTBFkGzsOoDxhNG57eebS5URvht5Rfres+QeR1KU
         wTUa2sweqkLFaRLBA0FrrRVzGyE34G6UOgmDeJPLUoKquKEYnX+AnpBwVevXx3eb8Kgg
         FcCA==
X-Forwarded-Encrypted: i=1; AJvYcCU1Ft8j3qxzppbjUczf0PatCOzd12spamJTErj04Ny6ojO01Xrbau/GiDEUZMKiWl7mQj0dPRX9bke7391h0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4e+VwU3qhfYZ4zv128ajPEVrky5osGsEzkNYCPVC0F53EWy5c
	uzPgUrPFZsV0eu/zC/4gH1/MJ13R9AhdfayjICpWYHwFDQoNmRf9gK+nkoZQn+p4Sks=
X-Gm-Gg: ASbGncuPhj/J4Dc3yy68J8VE2njvvfG9ZFw2bvERMhmMceZutcceyuLaRU9pEMOpw0H
	cmMxB591e9f3YpFYyAmd78CzduccKLIOFi/kfGpnQiGi9umHClnz03+47LvT5TEAVUexf3ieJ6A
	Kof+KFDm5bpzaHWdvEY6nxmQmCHIr83sRmfLmtuVK8S1P8hhnWnEhJaXAiXYH7//FW2h2Ihl6ux
	B05mwd/8iTsWzTWElhstOULpuLQzpIVoBfgFUoNgwsD3IIoUeIsJRHrE7O6Z82kTz04otolH0c2
	w2xkG5ayyJFoH4FA0xClRS4jj7yXgmvwh08s9jnjdkZLExkIaLb4Orpj7qIVZIgW+fhgf2n5HA+
	ii3MCgYTPjz521rIZPOG+djQSB7XUyLLZD7hHrA==
X-Google-Smtp-Source: AGHT+IHoE/CIYPSeBo9AkwYX6P5QyNezX929DkvT7AQbxP5vAuyPsD+eSrDU1SNqwDaclH2cAsl91Q==
X-Received: by 2002:ac8:5746:0:b0:494:f1e7:65ef with SMTP id d75a77b69052e-4a73c627abcmr231747311cf.44.1750190241701;
        Tue, 17 Jun 2025 12:57:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a72a4b0e93sm65849681cf.42.2025.06.17.12.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 12:57:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uRcQq-00000006ckX-2tam;
	Tue, 17 Jun 2025 16:57:20 -0300
Date: Tue, 17 Jun 2025 16:57:20 -0300
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
Message-ID: <20250617195720.GI1376515@ziepe.ca>
References: <>
 <a65d955c-192b-4e79-ab11-8e2af78b62af@gmail.com>
 <20250616132031.GB1354058@ziepe.ca>
 <20250617154331-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617154331-mutt-send-email-mst@kernel.org>

On Tue, Jun 17, 2025 at 03:44:20PM -0400, Michael S. Tsirkin wrote:
> On Mon, Jun 16, 2025 at 10:20:31AM -0300, Jason Gunthorpe wrote:
> > On Sun, Jun 15, 2025 at 02:47:15PM -0400, Demi Marie Obenour wrote:
> > 
> > > Is a paravirtualized IOMMU with interrupt remapping something that makes
> > > sense?
> > 
> > IMHO linking interrupt remapping to the iommu is a poor design,
> > interrupt routing belongs in the irq subsystem, not in the iommu.
> > 
> > The fact AMD and Intel both coupled their interrupt routing to their
> > iommu hardware is just a weird design decision. ARM didn't do this,
> > for instance.
> 
> why does it matter in which device it resides?

It would cleanup the boot process if the IRQ components were available
at the same time as the IRQ drivers instead of much later when the
iommu gets plugged in.

> Way I see it, there is little reason to remap interrupts without
> also using an iommu, so why not a single device.  what did I miss?

Remapping interrupts can be understood to be virtualizing the MSI
addr/data pair space so that the CPU controls where the interrupt goes
though its internal tables not the device through the addr/data.

On x86 you also need to use remapping to exceed the max CPU count that
can be encoded in the MSI, no iommu required to need this.

There is also some stuff related to IMS that could get improved here.

You don't need an iommu to enjoy those benefits.

Jason
