Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AFC24A11
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EsoPlO93"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B38781FF8
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 20:25:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8B38781FF8
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EsoPlO93
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.599
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MLyvUSTiFKKz
	for <virtualization@lists.linux-foundation.org>;
	Mon, 13 Nov 2023 20:25:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EBB1281F8F
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 20:25:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EBB1281F8F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699907126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
	b=EsoPlO93xa9IbDgvEh3uBrUaKHGA2TgVsMGRGD6Yx6oHWeRvWdx1aV+WWOGBv88/IX6hVd
	jV3XdIqepXP+Swe2na1/oMMYrFc0INXer/5N3Uc8mVMUhhyywzfPBMZg18P/bO1wHQLLHT
	5mWePEi+opY3VO3GMuFts4mAiSIzw3U=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-BfOCihXPPYKiMolSFHSQHQ-1; Mon, 13 Nov 2023 15:25:25 -0500
X-MC-Unique: BfOCihXPPYKiMolSFHSQHQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-66fbd02d104so62174426d6.1
        for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 12:25:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699907125; x=1700511925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=TrOnaP8FxWxsd2lGYLtMD7qS1cC/r/R5/NBfs4KtkVRsyPGM/4mSR7qpWn7nqJCiBE
         RoKH7+ZICUNgeKyznRV8tExLhFiYarQdWyNpV+kX8uLfYAb+9detuvaOJuqR+odV7mNZ
         42zlj3hmszgR/IAh8b/uq3jG7mZ/bK+3/RnaIduXny/t2eI2NRZv1di5TN7yI0Ac/G1a
         upsva1o+K4P548jIJQs+ZrP9Phl98hfZK+lx9+/C7srv422L5hNbU4NOQYNjEXI6OGi1
         ebOY3rzZTv1HA/L/gnGKms6UuRJGsl0XtR+7IXf+tTm9c0hFLPs90hrff9uJ/EU4qmWW
         2epw==
X-Gm-Message-State: AOJu0YyONAgPtFN8EInTwnxZ+rEmXnhjP1g2VeOU3/ujJ0wnuitO5DCE
	MxohPyiwSy5awt0UzI2SOJRMUdzzk4mP2meMNH4W5zriDGc5VYdxZmXNB4/wp9+G0FV+edn5x+A
	GFhawFaXsfJRe9i9yS8nAi+fuL/7cSObIY7x/sqh68g==
X-Received: by 2002:a05:6214:2a9:b0:672:3f54:b94f with SMTP id m9-20020a05621402a900b006723f54b94fmr343495qvv.7.1699907125263;
        Mon, 13 Nov 2023 12:25:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDuwvOtoyPZ5iPmtgsnzi3ZmT4SfzU8sjdIavaCXICAagXeDLzw8KJuwOG1DaOAnqE0bqGXg==
X-Received: by 2002:a05:6214:2a9:b0:672:3f54:b94f with SMTP id m9-20020a05621402a900b006723f54b94fmr343444qvv.7.1699907125050;
        Mon, 13 Nov 2023 12:25:25 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id qz6-20020a05620a8c0600b00774292e636dsm2120525qkn.63.2023.11.13.12.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:25:24 -0800 (PST)
Date: Mon, 13 Nov 2023 13:25:23 -0700
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
Subject: Re: [PATCH RFC 16/17] iommu: Mark dev_iommu_get() with lockdep
Message-ID: <avqfvjfck64kedxvjtsw5rc7x2dkubbpm5ytz6roog6pb7of2z@g6up6nxawsmo>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <16-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <16-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

