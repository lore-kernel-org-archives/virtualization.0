Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DF835F14
	for <virtualization@lists.linux.dev>; Wed, 15 Nov 2023 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCBhfDDf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700060979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
	b=RCBhfDDfYO/TKKaWW8Im6C39h4d4WZGaGXY/9CMEvFdaLn60W9dhTRUrUC/1lsvkCqW8Oq
	b6wgl/tZpSSrT3Z8/KwxdvVoiPpKElzPu/eQOy9SL+EW4DgGIB/Bjd/tYqDRuXGkOkxeBx
	Miuhkufw/+7QKliScp+LSHlhS79mxuc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-YPbxAgmgMQynbuOHPuErag-1; Wed, 15 Nov 2023 10:09:38 -0500
X-MC-Unique: YPbxAgmgMQynbuOHPuErag-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-421af801578so52975101cf.3
        for <virtualization@lists.linux.dev>; Wed, 15 Nov 2023 07:09:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700060978; x=1700665778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=dFDPEBbqzNyDhxP2/i48PosClXFsza1GhmDzySfKaF0AOsf7I0a2007xAGBnQzvAyR
         5R/z1Y59Im5TmkwZCoOUKcKjLWHYT2dDaG8LER7gXJZlD4jhKy7Z+IP4CA0fqmVLLFra
         htkQiUdVw+nHddpvBtXuO9oqozvi/WlXuuBp0wMR9iASWix/yVMpDG3yeI2Vp0W9Xxpt
         NFrnSWPoSrv9nb5rA0goxvZYMleNNK/ZrPj8RPwS8WmeLNWZ99Q+dALy8DU7B6ZnKzf9
         Ts7viKcIG0oiDmyGEp00PExgbO+ND1QCxD8ABpTGdhvTs19bBQtiUWOUAxqJWZF0uNdx
         3OwA==
X-Gm-Message-State: AOJu0YwRsjijQhupvvPibE/UEfYK07W8RV8ZnGAwoExjPdpcbKV+7kSU
	Cc7WbJZnl2U9iCkkdF8peTLOmb4kOnGnxbKWExeW9+LEkSVLoH0h3vo2J2KUc/cUwgpZ1GYreK6
	ktXkKKwakWhJAvIw9QUef7X2K72A=
X-Received: by 2002:ac8:570f:0:b0:418:a58:1cd2 with SMTP id 15-20020ac8570f000000b004180a581cd2mr6938259qtw.51.1700060978278;
        Wed, 15 Nov 2023 07:09:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJQ4sai83VgKMNcVk7LBkPO+lmGyR543b/SO2885Ys+XYhGZt/IKDco0l9338e20RsJ7UBFA==
X-Received: by 2002:ac8:570f:0:b0:418:a58:1cd2 with SMTP id 15-20020ac8570f000000b004180a581cd2mr6938210qtw.51.1700060977944;
        Wed, 15 Nov 2023 07:09:37 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id b3-20020ac85403000000b0041ea59e639bsm3597148qtq.70.2023.11.15.07.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 07:09:37 -0800 (PST)
Date: Wed, 15 Nov 2023 08:09:36 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>, 
	Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>, Frank Rowand <frowand.list@gmail.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Haiyang Zhang <haiyangz@microsoft.com>, iommu@lists.linux.dev, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-snps-arc@lists.infradead.org, linux-tegra@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Hector Martin <marcan@marcan.st>, 
	Palmer Dabbelt <palmer@dabbelt.com>, patches@lists.linux.dev, 
	Paul Walmsley <paul.walmsley@sifive.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Rob Herring <robh+dt@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Sven Peter <sven@svenpeter.dev>, 
	Thierry Reding <thierry.reding@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Krishna Reddy <vdumpa@nvidia.com>, Vineet Gupta <vgupta@kernel.org>, virtualization@lists.linux.dev, 
	Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>, 
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Christoph Hellwig <hch@lst.de>, Moritz Fischer <mdf@kernel.org>, 
	Zhenhua Huang <quic_zhenhuah@quicinc.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 12/17] iommu: Make iommu_ops_from_fwnode() static
Message-ID: <fc3a6krgqyi7awvm6dcjg5edbem5lead66b4tyi5ttetkcfdpp@iaya3ijkywwv>
References: <0-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
 <12-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <12-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

