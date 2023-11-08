Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1104235884
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XTWTtVCe"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 80D694012A
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 18:13:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 80D694012A
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XTWTtVCe
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zf4g1ZVeh5JG
	for <virtualization@lists.linux-foundation.org>;
	Wed,  8 Nov 2023 18:13:02 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2DF0F400FE
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 18:13:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2DF0F400FE
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c504a5e1deso95429391fa.2
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Nov 2023 10:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699467180; x=1700071980; darn=lists.linux-foundation.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XyM6VQ+HEN7IzJJ5bMoPN5/yYHnG+EAx9sBxv2Z/Ai8=;
        b=XTWTtVCe/E+HIVE8LHrvH7186ARwcNWfsuCe0LWMlBhwjrFmq7qHDuNZ+tgn05PjLR
         MLVJkBb+8eny8qcXzM0s93nORHwYO1Y8mDjiVzkPinY8G/p59oBAR59qtHo/FwhCnOsL
         Skvx6menNUdXGqEdiWIk9RHdPllG20QKuWXnKSe4oBxE9N1RX/4UtTWGRQYXSDa6juz9
         +aTGJ1CWF25S0zX+EUS2UhhXJ5RHxQkRFgQUFQZdBb/6kNlBBU2GjLF1hN6D25bjhQBg
         6hQ8xbSF4uyZBeBKUANl9uOdAOTfysHndgGA0Oh5KXAiDT98iM7NfZr6Ym8UiU5wV8cp
         owKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699467180; x=1700071980;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XyM6VQ+HEN7IzJJ5bMoPN5/yYHnG+EAx9sBxv2Z/Ai8=;
        b=Y0EZ3mDbsP6yNz8T1PgN506XOnM+nzwNeAdF2mdwcy2qZyA2ttqwzW729FNR184Bx2
         dFsVADyyM4els9+8hjda0798lZ1Q0o51loa2k/hHH6+AB72jSNy06QtjYQexIH/mcpLP
         QlQFtGjN1RiyuJ1ep7aSbgu47QT8U9anFS7OFG8YOpMELUvoyrQipYqk/xWiUJyrnwXI
         pk0bkV4bwCFs3UkZ8WIQ+//jW/210bpV8F04c9Es48iD5OsprpRDo+yMyo4IT1B6yYOR
         TuF0oNXmaLI+htrjgP53eYssvBkwvbboyTeJxDCBn6YHp7n6ahPBAIB8BWZDpnNK1qgU
         s2Dw==
X-Gm-Message-State: AOJu0YxhSQCnPhgKWY1/1JmyfXqMWDNVz9Dkw2Ul/BPe2oSI4K4gBlyr
	kfC2ZEKWyxUR2YXyXTKPoANQew==
X-Google-Smtp-Source: AGHT+IEAPIM/7orU2/kUz+9e+TY8CYDTNJKLdVzPi+Pze4e6FKjzPA1Tq2W37LpeXm1IyotL7oPMlg==
X-Received: by 2002:a2e:8e7b:0:b0:2c5:582:fd8d with SMTP id t27-20020a2e8e7b000000b002c50582fd8dmr2179335ljk.30.1699467179768;
        Wed, 08 Nov 2023 10:12:59 -0800 (PST)
Received: from [10.1.1.118] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id d20-20020a05600c4c1400b003fd2d3462fcsm739766wmp.1.2023.11.08.10.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 10:12:58 -0800 (PST)
Message-ID: <e57f11915745674521b8c73d88a198a0b9c32c21.camel@linaro.org>
Subject: Re: [PATCH RFC 12/17] iommu: Make iommu_ops_from_fwnode() static
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>,
 acpica-devel@lists.linuxfoundation.org,  Alyssa Rosenzweig
 <alyssa@rosenzweig.io>, Albert Ou <aou@eecs.berkeley.edu>,
 asahi@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>, Catalin Marinas
 <catalin.marinas@arm.com>,  Dexuan Cui <decui@microsoft.com>,
 devicetree@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,  Frank
 Rowand <frowand.list@gmail.com>, Hanjun Guo <guohanjun@huawei.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Christoph Hellwig <hch@lst.de>,
 iommu@lists.linux.dev,  Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-hyperv@vger.kernel.org,  linux-mips@vger.kernel.org,
 linux-riscv@lists.infradead.org,  linux-snps-arc@lists.infradead.org,
 linux-tegra@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Hector Martin <marcan@marcan.st>, Palmer
 Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore
 <robert.moore@intel.com>, Rob Herring <robh+dt@kernel.org>,  Robin Murphy
 <robin.murphy@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Suravee
 Suthikulpanit <suravee.suthikulpanit@amd.com>, Sven Peter
 <sven@svenpeter.dev>, Thierry Reding <thierry.reding@gmail.com>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Krishna Reddy
 <vdumpa@nvidia.com>, Vineet Gupta <vgupta@kernel.org>, 
 virtualization@lists.linux-foundation.org, Wei Liu <wei.liu@kernel.org>,
 Will Deacon <will@kernel.org>
Cc: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Date: Wed, 08 Nov 2023 18:12:56 +0000
In-Reply-To: <12-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References: <12-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4-1 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jason,

On Fri, 2023-11-03 at 13:44 -0300, Jason Gunthorpe wrote:
> There are no external callers now.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
> =C2=A0drivers/iommu/iommu.c | 3 ++-
> =C2=A0include/linux/iommu.h | 6 ------
> =C2=A02 files changed, 2 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 62c82a28cd5db3..becd1b881e62dc 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2945,7 +2945,8 @@ bool iommu_default_passthrough(void)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(iommu_default_passthrough);
> =C2=A0
> -const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle
> *fwnode)
> +static const struct iommu_ops *
> +iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct iommu_ops *o=
ps =3D NULL;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iommu_device *iomm=
u;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 27e4605d498850..37948eee8d7394 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -701,7 +701,6 @@ static inline void iommu_fwspec_free(struct
> device *dev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->iommu->fwspec =3D NU=
LL;
> =C2=A0}
> =C2=A0int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)=
;
> -const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle
> *fwnode);
> =C2=A0int iommu_fwspec_append_ids(struct iommu_fwspec *fwspec, u32 *ids,
> int num_ids);
> =C2=A0
> =C2=A0static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct
> device *dev)
> @@ -1044,11 +1043,6 @@ static inline int iommu_fwspec_add_ids(struct
> device *dev, u32 *ids,
> =C2=A0}
> =C2=A0
> =C2=A0static inline
> -const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle
> *fwnode)
> -{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return NULL;
> -}
> -
> =C2=A0static inline int
> =C2=A0iommu_dev_enable_feature(struct device *dev, enum iommu_dev_feature=
s
> feat)

This leaves the extra line with 'static inline', it should also be
removed.

Cheers,
Andre'

