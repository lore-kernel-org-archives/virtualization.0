Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CABA24216
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 20:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TETKR5gE"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E4C3F41761
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 20:11:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E4C3F41761
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TETKR5gE
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GVEPn9lwhP6L
	for <virtualization@lists.linux-foundation.org>;
	Mon, 13 Nov 2023 20:11:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3CC1941704
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 20:11:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3CC1941704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699906302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
	b=TETKR5gEqAHG8BMIkcGPuwULTW0Rk8Vc9TY0Nk3rmBw9RrQDuw/NQ7rtYPDQtXOal9X/FY
	HeGfV8BmQ1aMhp3IyZO3rjBi76cxpjCzrLKZoXRSipuLu7hu1zeVCnSbbdf3eWZ1lZTYQV
	3B69cOWP2DBPlgeaRbvgL3Cku0KAn94=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-0bUJHUymORea94oqf0mgGw-1; Mon, 13 Nov 2023 15:11:40 -0500
X-MC-Unique: 0bUJHUymORea94oqf0mgGw-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-589fa8cd181so3873748eaf.2
        for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 12:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699906300; x=1700511100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=ShBxO3P1lV5TfRh6vNN7Oilgb0HdmIuFh2j80TLzStGJKT+/ln4VonL1sqqtQ8kT5d
         2fgrx7OEqmUVb+pWUs/8L10HR0Gg+r9ncolpTm5uhRAnkL5Dnoya95EyH56Gxzfktu9q
         ih2NRXAnt+KGv1iblzbpitZ3t38T/9BEvRIK0xNT3bPmulbLnvaytlWl77QtodeHw1r1
         hAeAZOF1Sme+TnjvDLVqttw/TaJr0yt+/IDw/VA+2GiPw4c0AvZz/CCKs1vorPm0JtG1
         OBdv7EYQ03RvyJAI+A4H1B0PGw2lXmBCoWRl+2Pj2y4W8fbmeyHZ4yOt3x12O0CZuCvL
         b80Q==
X-Gm-Message-State: AOJu0Yw0yW8ERkJTV/mQgdjdbXhF/sjNQsvVj2cHmE5IGyMHEge+iBZt
	3GzWFKs9H8mmGBpsS5LIeVaIvcZuRuWKfF3NpYEVnAUfwp/aJi1OAzyYwIfln5zLWYPxmZ215C7
	oobVk3up960H1c4MbIoh55jaQHXt/0ZxA2/AL9MPgtg==
X-Received: by 2002:a05:6358:2904:b0:168:e592:f8d2 with SMTP id y4-20020a056358290400b00168e592f8d2mr367424rwb.25.1699906299915;
        Mon, 13 Nov 2023 12:11:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIOetclT7JIwJMgw/sY1gBz67FNYTbvIhgzf8jdwnJ0WmLDY550/th30Kkt+kh8RpDUm+sYQ==
X-Received: by 2002:a05:6358:2904:b0:168:e592:f8d2 with SMTP id y4-20020a056358290400b00168e592f8d2mr367389rwb.25.1699906299658;
        Mon, 13 Nov 2023 12:11:39 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id i2-20020ac87642000000b004194c21ee85sm2173891qtr.79.2023.11.13.12.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:11:39 -0800 (PST)
Date: Mon, 13 Nov 2023 13:11:37 -0700
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
Subject: Re: [PATCH RFC 07/17] iommu: Add iommu_probe_device_fwspec()
Message-ID: <uw2q27tpuqmxe5gzjjsmnjy2rvtztqomdh4czbws3yredeshzl@7zy6ls5ozqg7>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <7-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <7-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

