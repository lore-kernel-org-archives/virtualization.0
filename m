Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A817032C6E
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 18:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KP5v1+/X"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0313261079
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 18:35:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0313261079
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KP5v1+/X
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VHLRICOB3uhB
	for <virtualization@lists.linux-foundation.org>;
	Wed,  8 Nov 2023 18:35:04 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D983F60ADE
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 18:35:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D983F60ADE
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4094301d505so53584315e9.2
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Nov 2023 10:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699468502; x=1700073302; darn=lists.linux-foundation.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n9ZiV2Esj98CTfgH59OBDcgahkXqDMdEC5lhTkmlSa0=;
        b=KP5v1+/Xnn9kuyU3aRgyby/EdEBa56YNMjqqz0IUtjvikVIuuvTvHD2BZFTX1g5d9L
         5Ozw0L8VUn/WxivojnAfmPZ5Nj19mLIELDPQtPfQRTcyFDIFVws12Vf55ToLIs+V4A0B
         g43jibjh1WPDy5+4OIgOV1V+kZKFLTUcSSkLMF6ZjNZBbZ97etUkpPbcmo+2Lq+foH0q
         NRrQZjqKU+SWWzsXqLTO8P5Y791UBMDLJz+wdfGMEgICmLZQ8jc5i0ygERrewCqN0xTv
         kGNdadvw71S6QrrS3z9oAKHoI1HAa/kShuVRs+L6yg80KZVrKtMb6jPBkAK7lPcnrNnf
         3KBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699468502; x=1700073302;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n9ZiV2Esj98CTfgH59OBDcgahkXqDMdEC5lhTkmlSa0=;
        b=sbhIepK3Mmpd+A853beSup6QFUgOmZtPLWWhmdZRQKo3w6Wp4UzAcD7Dhk7NWif3lO
         wvi8jZmv8b1/nOL7IDLrk1mTOgCypSJIRs88Ns5bWjtZ7hWesv07AjvXczyI1eiUExcz
         fKuAZtIw5T2xHTuavaWwJflT6NniPA3TN23duI7/hGLyXXS+ixpqIY5A3z9t39ry8SCq
         2DvauGBH3nqPkmv6+wltdFC/FWiM05anofFe0kA4uooCc92Qrb0l1B5tjJUL8GtkD34e
         o1XONa2IkHQYXr1YCWEkvS7JqTAQOpBI1sqfX6/r128/F7Ykz29zJZwGmeUaEomM5ftn
         v39w==
X-Gm-Message-State: AOJu0YxmCLGokMoBkxz1ch9tOk36IvTtjaC2vyB/j59nrE5FwaZaDdM9
	NuRNj1tqeqoCMYStL1jizkFpUw==
X-Google-Smtp-Source: AGHT+IEerzRoblFu8LqWqAyQVzl32Dow78v7sZDoe2sPpmQgBWRRfSrEcftCpyNmsXV1yimnvtHQ6A==
X-Received: by 2002:a05:600c:190e:b0:405:1c19:b747 with SMTP id j14-20020a05600c190e00b004051c19b747mr2262734wmq.15.1699468501866;
        Wed, 08 Nov 2023 10:35:01 -0800 (PST)
Received: from salami.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id g4-20020a05600c310400b004068e09a70bsm20156528wmo.31.2023.11.08.10.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 10:35:00 -0800 (PST)
Message-ID: <d6664edcccd81edc5caa54e8da43b5c571a3ea76.camel@linaro.org>
Subject: Re: [PATCH RFC 00/17] Solve iommu probe races around iommu_fwspec
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Zhenhua Huang <quic_zhenhuah@quicinc.com>, 
 acpica-devel@lists.linuxfoundation.org, Alyssa Rosenzweig
 <alyssa@rosenzweig.io>,  Albert Ou <aou@eecs.berkeley.edu>,
 asahi@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,  Catalin
 Marinas <catalin.marinas@arm.com>, Dexuan Cui <decui@microsoft.com>,
 devicetree@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Frank
 Rowand <frowand.list@gmail.com>, Hanjun Guo <guohanjun@huawei.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Christoph Hellwig <hch@lst.de>,
 iommu@lists.linux.dev, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, "K.
 Y. Srinivasan" <kys@microsoft.com>,  Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org, 
 linux-tegra@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Hector Martin <marcan@marcan.st>, Palmer
 Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore
 <robert.moore@intel.com>, Rob Herring <robh+dt@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Suravee
 Suthikulpanit <suravee.suthikulpanit@amd.com>, Sven Peter
 <sven@svenpeter.dev>, Thierry Reding <thierry.reding@gmail.com>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>,  Krishna Reddy
 <vdumpa@nvidia.com>, Vineet Gupta <vgupta@kernel.org>, 
 virtualization@lists.linux-foundation.org, Wei Liu <wei.liu@kernel.org>,
 Will Deacon <will@kernel.org>
Date: Wed, 08 Nov 2023 18:34:58 +0000
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1-1 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jason,

On Fri, 2023-11-03 at 13:44 -0300, Jason Gunthorpe wrote:
> This is a more complete solution that the first attempt here:
> https://lore.kernel.org/r/1698825902-10685-1-git-send-email-quic_zhenhuah=
@quicinc.com
>=20
> I haven't been able to test this on any HW that touches these paths, so i=
f
> some people with HW can help get it in shape it can become non-RFC.

Thank you for this series.

Please note that we're also observing this issue on 6.1.
I think this series is a good candidate for a back port (slightly complicat=
ed by
the fact that various refactors have happened since).

For me, it's working fine so far on master, and I've also done my own back =
port
to 6.1 and am currently testing both. An official back port once finalised
could be useful, though :-)


Cheers,
Andre'

