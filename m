Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71BC241E6
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KI+nWV5D"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 505CA60E91
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 20:06:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 505CA60E91
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KI+nWV5D
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QOSExeNVHJtW
	for <virtualization@lists.linux-foundation.org>;
	Mon, 13 Nov 2023 20:06:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EC86660E83
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 20:06:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EC86660E83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699905969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
	b=KI+nWV5DZur8IYrILSc23EAt7M+eyfphxDucCHIyuHyD9cC2l+V1XYvUFMjiZ2PRp/gnX1
	nw+DxfG2wL7PSsPdIAwmzjDA9R+Tpj0yLX+1/Y6chv3BqK8UhoawFbICpRH8yRj7G6PntR
	JvqsNM3TXfgRZAis5v9wAINlFnTKqYU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-TWllbIJ7NWao4VUkk6KgLg-1; Mon, 13 Nov 2023 15:06:07 -0500
X-MC-Unique: TWllbIJ7NWao4VUkk6KgLg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-66d0b251a6aso59225726d6.2
        for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 12:06:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699905966; x=1700510766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=rXhiI4EomjXcco8sxW8RW5/96wlAMhDIgAElrASBUqm2hT7IDP9n1Td7MtBzGymZMu
         8oO75+Hr55VsoOJkYH1g4wdH52TZPcLCDi63nOgmeVtSCvLEApUHS1yOo3iCdtFvOdrv
         17YxpkYcRt5ybfhsTgJ3bNW2cPDEav0waemLQcLAraxOHNWyfj4TpZXJKoj6vsoskPXG
         FPK2Igj1GKnac8ryNS1x1rRF8sO7CdsVkNAQ9lYIPzmede3+FZ3Boda9TjUO6DTzINPW
         gUXC46iMLIhbEOy6VteEEq3pWYQJ1kPFEnta6lFoqZxxUcQMtPfttsCvKRLmzBO2m05N
         oIBw==
X-Gm-Message-State: AOJu0YzwyDnYVVsAh7284WlWp3qqmPNOOl1SOV6yklPpDbqsKbTnTrVM
	SMOM92OThQaXe/su2fds8rD5OW7uXRJI6BuGd3ErEcenAz+EtM/VpjlVNAW2q8fHc6OK59/DQD9
	z/gtfI2sgOXe4TMn9gWQVTl/D2DIfLVQejhLtVgnLdw==
X-Received: by 2002:ad4:53c6:0:b0:63f:80a0:4eea with SMTP id k6-20020ad453c6000000b0063f80a04eeamr283846qvv.24.1699905966596;
        Mon, 13 Nov 2023 12:06:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHU546dToL/RnbvSEEgGYhgfAOuTUeuUj6W3IfV3UEMZ3+1fSCYuM0AW5xrguKdlx+xfhHm1A==
X-Received: by 2002:ad4:53c6:0:b0:63f:80a0:4eea with SMTP id k6-20020ad453c6000000b0063f80a04eeamr283817qvv.24.1699905966425;
        Mon, 13 Nov 2023 12:06:06 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id q8-20020a0ce208000000b00647386a3234sm2299097qvl.85.2023.11.13.12.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:06:06 -0800 (PST)
Date: Mon, 13 Nov 2023 13:06:04 -0700
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
Subject: Re: [PATCH RFC 13/17] iommu: Remove dev_iommu_fwspec_set()
Message-ID: <fussoe3f2shd222d2lwvcts3odhnyuvfxpgv6c3k2d4udxu3uv@db53jszpgq7v>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <13-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <13-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

