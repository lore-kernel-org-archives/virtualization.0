Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD841241E8
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 20:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzKjPLC8"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D8E3605E9
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 20:02:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2D8E3605E9
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hzKjPLC8
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eyn9Zpoxmbdo
	for <virtualization@lists.linux-foundation.org>;
	Mon, 13 Nov 2023 20:02:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0536861048
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 20:02:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0536861048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699905765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x5sbsbZrhM7njh7UJ8Gfj3jbjPzQiV5xODIk6atjKoU=;
	b=hzKjPLC8dDR7BDwse82isMxO13UeaBMKipUi9Bb07z59RK/CPEbBXEYxq2EgSlbC7w//9y
	T/OWsXBTyl915xwdmxyS9lwBOGS1VjP6AUih2kCoYFmd5mSAF4WDXtXMJ+HtKYmFEp0DRC
	KAfYX+HVw9xeQrwcmO66dgl1Ysev07U=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-rdjWUGi4OqGZXr-XEKA1DA-1; Mon, 13 Nov 2023 15:02:43 -0500
X-MC-Unique: rdjWUGi4OqGZXr-XEKA1DA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-66d159f725cso63272026d6.2
        for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 12:02:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699905763; x=1700510563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5sbsbZrhM7njh7UJ8Gfj3jbjPzQiV5xODIk6atjKoU=;
        b=RgDBAhahLwpMxGJQr391wACf82CuUeFctGxR2lIaLhj/VjLhCq/MWurMaet/wwUhAL
         +zj/lrqRy9tyJafxSVVLxP+6HCiyJUUZpQhi2VP9kmnBoQqhNhphNiIBHKklp1UaPR0j
         UM57lk58G0Jo4vKLBHSm3xgUHxu+WOaSy65ssT7k2yS5z9UyTiVRdYn6L2wuCKt71ZEE
         DsuG6JNkXMwUuxYweH9zNn1k3jEMRyJmKX32Y4ccfoow287GoWtuOkIf/QUBT7HOtxIH
         Te68xevThIgaM5jf67BwT/wkG0Svco02RF/seG5vvuIX7Bcd8DE0POsKghrAKvPUv32m
         g4EA==
X-Gm-Message-State: AOJu0YymDe1OeXLJojAeCf3KkhdSclmn5vmIFUwuZwFKqoo9R+wzXK6t
	jKJI49azlfLV871t7Bkzq68F6d6lFlcFA4BQEc5ew6sheAknH8/GHj1q2V/4YkbnaOZ3BM/5stN
	/l5VJ+KzQZnjO2vQ6KKebk/BY1ex+Qo0k0SERWWSOqg==
X-Received: by 2002:a0c:f9d2:0:b0:66d:9970:6464 with SMTP id j18-20020a0cf9d2000000b0066d99706464mr233536qvo.13.1699905762794;
        Mon, 13 Nov 2023 12:02:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVvfJ/8QycB4sitSkyNc9BJr+XhgbESVoJGYkT8lKAjf1cMgXzof7Oqc5lCEmlPE1oL2APNQ==
X-Received: by 2002:a0c:f9d2:0:b0:66d:9970:6464 with SMTP id j18-20020a0cf9d2000000b0066d99706464mr233490qvo.13.1699905762358;
        Mon, 13 Nov 2023 12:02:42 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id vr2-20020a05620a55a200b007757fefea79sm2097337qkn.130.2023.11.13.12.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:02:41 -0800 (PST)
Date: Mon, 13 Nov 2023 13:02:40 -0700
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
Subject: Re: [PATCH RFC 12/17] iommu: Make iommu_ops_from_fwnode() static
Message-ID: <gg6ecoukkia32t33vjfunny4y54pulz6k6zfkfpp6nahav4otj@z6e62pbavceb>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <12-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <12-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 03, 2023 at 01:44:57PM -0300, Jason Gunthorpe wrote:
...
> @@ -1044,11 +1043,6 @@ static inline int iommu_fwspec_add_ids(struct device *dev, u32 *ids,
>  }
>  
>  static inline

   ^ was missed in the deletion below

> -const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
> -{
> -	return NULL;
> -}
> -
>  static inline int
>  iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features feat)
>  {
> -- 
> 2.42.0
> 

