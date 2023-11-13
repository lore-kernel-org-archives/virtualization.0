Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6238624207
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBFFsj20"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E402B8214A
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 20:12:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E402B8214A
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iBFFsj20
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6CG_I9X3o8in
	for <virtualization@lists.linux-foundation.org>;
	Mon, 13 Nov 2023 20:12:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 20C9282141
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 20:12:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 20C9282141
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699906321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
	b=iBFFsj20zF4uVQYjWx7q2rniacseIJG7dEck+YcTElQhFRu6mxmerJ81FvHJI4iskAJKGf
	+Qbm7qRqzdOduAHKilbvu/mRSyDV+3T2j3mpqj3Sru8ewxm51idjUs/63iPaog3uzQfxbF
	4KG7nFanKadGBB4x2TgzLUUM7uf5b8I=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-VNj7VktkMY-JAeUaeFCLSw-1; Mon, 13 Nov 2023 15:11:59 -0500
X-MC-Unique: VNj7VktkMY-JAeUaeFCLSw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-41cdc542b56so58305391cf.0
        for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 12:11:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699906318; x=1700511118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=gA8rZlxkqozZ7eJ1HVjOOdDyMl8HRvP04FXvdmrDe+50MMlvYC1MTjRWE2C60uj2lE
         OshECQw9INzZVZarp9Ii/cvindKMjKmIGIJYSx8GKorx4CAujQvp3zXF6KnoDLPs4WYO
         0im1Gty/C8Pu3Dox0GYND9LQNso2LF7X0HTyiciWCk5THPWDrzTDZeEF3VV45gTBTdvj
         zZUeiy10OxpywtV+GKlnKUdLReW9deUI/ajTKMP5LK7cr4WUbvi8uIu6JlbT/jRpWdZj
         g5PrTA+8Gl0xBA+Xuz6ymMN1A6oGxIOYsYoJsv7aKuWrUAw21XVfkT0ApmnLUgLcLRod
         rlnA==
X-Gm-Message-State: AOJu0YwalxN9GCZTF0aGgGV60NU7lJ3MRR5DnHsiyD2EIApqhuGpyBwH
	zI+QrA2VgmxkqqbHtslU3JY3I4sV/pUQC/dBJBgvuy5P+hWxQht8iKxstUMhhfdEp+Ar2/hBQvs
	LsKoDsRNnkQcu0fC8aXj5wKKZFQnfAIGjWZHtzjmXBQ==
X-Received: by 2002:ac8:5f0c:0:b0:41c:e02c:858 with SMTP id x12-20020ac85f0c000000b0041ce02c0858mr147799qta.49.1699906318642;
        Mon, 13 Nov 2023 12:11:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFswPYZrUE+iHPpixm0usY52QHAZzAKPKkAbEgaDvDovqU3DEFNzLkKbZFJyBFwEre9EilUMA==
X-Received: by 2002:ac8:5f0c:0:b0:41c:e02c:858 with SMTP id x12-20020ac85f0c000000b0041ce02c0858mr147719qta.49.1699906318082;
        Mon, 13 Nov 2023 12:11:58 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id f19-20020ac840d3000000b0041cb8732d57sm2169319qtm.38.2023.11.13.12.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:11:57 -0800 (PST)
Date: Mon, 13 Nov 2023 13:11:56 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linuxfoundation.org, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev, 
	Lu Baolu <baolu.lu@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>, Frank Rowand <frowand.list@gmail.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-snps-arc@lists.infradead.org, linux-tegra@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Hector Martin <marcan@marcan.st>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Sven Peter <sven@svenpeter.dev>, Thierry Reding <thierry.reding@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Krishna Reddy <vdumpa@nvidia.com>, 
	Vineet Gupta <vgupta@kernel.org>, virtualization@lists.linux-foundation.org, 
	Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>, 
	Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: Re: [PATCH RFC 08/17] of: Do not use dev->iommu within
 of_iommu_configure()
Message-ID: <ciuy76347ki3xb5jzyji5fbzpsm2ssvcyvfgm6q7fqbneaoj7y@v5fpadftudhm>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <8-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <8-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

