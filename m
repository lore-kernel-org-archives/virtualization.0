Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0596024208
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 20:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QkFuWos4"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86835820CC
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 20:10:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 86835820CC
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QkFuWos4
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.599
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JWjVZ2ktR-qe
	for <virtualization@lists.linux-foundation.org>;
	Mon, 13 Nov 2023 20:10:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EA62981E56
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 20:10:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EA62981E56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699906247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
	b=QkFuWos4vfqSVbsvh7QXl3XJOrAGYJSPnYDADtfbc8++qTReh8+Cy97GqqC0DtipgMXCg0
	JjJGp3JKhqZTYh7Murx8cPeU8g15IeViWjFOufEFMGlR/uge1TBg8Ho3JfVgfPbEwDwceL
	eS+pdVvMhOmQefXQa3jc4AMiw4HnVGY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-bcBcSFAbNauti0TD_tf7-w-1; Mon, 13 Nov 2023 15:10:46 -0500
X-MC-Unique: bcBcSFAbNauti0TD_tf7-w-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-779ffb552eeso578618885a.3
        for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 12:10:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699906246; x=1700511046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=atKhx1Rm2tVqqsjTjmS/wPY2+Rv6Vy+b+CxI2LywnKD508iE0ru/ifIfqlKcHUs7Um
         glTHtZn3aT9yFhmyY+U2Yr0UxNcG5kFO6gij9EDNXEM1eQNIt88nCYntTKVy7rDZvesY
         yvNKHGYW1Ctn3Rq2SZXXTBnCcx5HXKo/sExXobWEw3DQ6yYXk1Q3uho79AJOakeF0bmX
         cbNZnrNKNORRMuBJmVVqvh6dmHA35IlTwp7u+AypIVhYvwn1dFzoVyWaO9ZfQawMMOmV
         I494TXj5ACGWah/HPoWFEBthl8Bj+OBx5VctUwDcBe3b2mQAHWAcanr6cbmkwnGMv/Iw
         k88w==
X-Gm-Message-State: AOJu0Yy28RJMFSZVcD+YNAWkvKO5Ew/bNRmEyZ8OzxHOBC7EsLw9WO8B
	/wUYGLyTWjUaJE1WIWWBgA/XfOKK9+oUSLypbxdVjUiF8gTfh8j+QGEZCunwZeuHOfFvvRIs3GB
	nnqDtqd18HOfJtELJ+16GeZqdW5DSTceuXVWHHqH8sg==
X-Received: by 2002:a05:620a:3710:b0:776:fb0c:6b5c with SMTP id de16-20020a05620a371000b00776fb0c6b5cmr322021qkb.13.1699906245970;
        Mon, 13 Nov 2023 12:10:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTedyYglCJvmi92iRdR2D4BIAbVzeajOKcDR1OXvlL6dJaLGV+tVe1Q6WIBYPyxZBc3gPFSw==
X-Received: by 2002:a05:620a:3710:b0:776:fb0c:6b5c with SMTP id de16-20020a05620a371000b00776fb0c6b5cmr321979qkb.13.1699906245767;
        Mon, 13 Nov 2023 12:10:45 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id o6-20020a05620a130600b007742bc74184sm2112406qkj.110.2023.11.13.12.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:10:45 -0800 (PST)
Date: Mon, 13 Nov 2023 13:10:44 -0700
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
Subject: Re: [PATCH RFC 05/17] iommu: Make iommu_fwspec->ids a distinct
 allocation
Message-ID: <bhbvxv5bt7b5tad27cuvy6efpkg2fwxx2delgcmnsd7sttqngl@irtpllmr7wq4>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <5-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <5-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

