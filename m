Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C449250F3
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 20:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDz++v72"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 834BC41B54
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 20:23:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 834BC41B54
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UDz++v72
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ig4P_tFz4o7W
	for <virtualization@lists.linux-foundation.org>;
	Mon, 13 Nov 2023 20:23:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CF91641B5C
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 20:23:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF91641B5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699907014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
	b=UDz++v728cnjhBP5mHYKtusMPfGvPebQ2vefvEtyu2yOvPumEttY9cJ1kovly7+R5iRQOB
	YyeudiBEdTNh5w21tWRNPYKpHXj1LSfXS5jAtvD1H6m0/nvgtRfvt6YOzriZKEv7MTbCc4
	VY+0SGAR/lnTFLOSlskIg3+CjYUCfvE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-zgLYk_1FOWqO8g5Jm4ysgQ-1; Mon, 13 Nov 2023 15:23:33 -0500
X-MC-Unique: zgLYk_1FOWqO8g5Jm4ysgQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-41cdc542b56so58426051cf.0
        for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 12:23:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699907013; x=1700511813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=j/nu3S0MXSm3PEm2PCzdxa8E/WrPG0xHUx06ED3gRl8B3DdzzEzs1+7TBKxTti/F6F
         nOdVGLOWiOcciHL8LeJZ/vX+nzXtn27AvV3NOH0INx6xlRblmt7Uy+83xPylPe9hU8kz
         2D3LYSdLKhXb9aUuThLJznCQN4q/Vn3gj1V2gvLCX8YiITCLbZu0NrXHCPD97T0W/EqN
         Q1lCenMTn6Q2th0tPbdIXmk5T/q1chUds/AHj6WlrJa9A1zTWaUNYVW/RTquYBsUdYdw
         bb7hapTkNn5al0yHJ95SANx49PKBUORrHqOo9YGmGnkst7w4BoLWbOgcHiWANFEOIrLa
         vsAA==
X-Gm-Message-State: AOJu0Yz0XK+KHY6QRBo5HxGc9FZ8pjye5HH5QrkaYjFnn3eKAzgZL1Rx
	/cY+S5k9UaOpYQ8Skyc/cQvHAFOM8YNGv19gUAqNSs9OrJCW3rutB7ulitfHRH+N+24Tcv/TUlW
	rcd/RlWm72r3lN0KF496YTPl+6Cudg8JH1hYhhdC4lg==
X-Received: by 2002:ac8:7dcb:0:b0:41c:c489:5737 with SMTP id c11-20020ac87dcb000000b0041cc4895737mr181019qte.52.1699907013271;
        Mon, 13 Nov 2023 12:23:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETLe6ua2NZBk5C5HvQsSQRhq7xoJL++WLnwlLCZjQoU3YIRy9czQKgZx9fuBDkEqY7LDc6Jg==
X-Received: by 2002:ac8:7dcb:0:b0:41c:c489:5737 with SMTP id c11-20020ac87dcb000000b0041cc4895737mr180976qte.52.1699907013032;
        Mon, 13 Nov 2023 12:23:33 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id z10-20020ac8710a000000b004196a813639sm2177639qto.17.2023.11.13.12.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:23:32 -0800 (PST)
Date: Mon, 13 Nov 2023 13:23:31 -0700
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
Subject: Re: [PATCH RFC 15/17] iommu: Add ops->of_xlate_fwspec()
Message-ID: <j56kfjb5dt3drcxh56lyc4om3qjnwddot2i5f62f6u6gwefj7i@rxmgclwaevf4>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <15-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <15-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

