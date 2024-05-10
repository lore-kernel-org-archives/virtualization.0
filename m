Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93D812EBED
	for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715358539; cv=none; b=dKsalrsaEgphH1uG+vZ+woqvyR1nWSrSSxVrVi2n0UrPIofyoIPYPFokcWKAH/0EvkdtJju17V4cXllEuwmZYUfRMuNCoZdR4rPdf6WSWiQdrEXWUu4V073FSM0+V7qUSvnHNsTyQokCPCcpJNLlrQj4uHAeHTmMS5JizJkFah0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715358539; c=relaxed/simple;
	bh=qRAfYIuRtk26fUbO0g/YhxEfQgubTQ5I5K3SO5qx7O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHD4zQHFdbkklQrN3n6AFNrKS7bHOhVgXgEBzsbOgNmtCRxgvfRuYf19zww7Ngexs3Dbw5IGx/IyMqCsxTocr3La3dGE/x2vJZlCI4XSuBmZPY1isEQZIqatDUUhSVDAVAjBvfGiBRdq7BqvweDvGqelv0j9148qL1KTkcE1Knw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=V8PyujCi; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="V8PyujCi"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6BE7641EBE
	for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 16:28:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SLBLcTeDDAaP for <virtualization@lists.linux-foundation.org>;
 Fri, 10 May 2024 16:28:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::733; helo=mail-qk1-x733.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2BE3741E99
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2BE3741E99
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=V8PyujCi
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2BE3741E99
	for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 16:28:56 +0000 (UTC)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-792b8c9046bso172721685a.3
        for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 09:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715358535; x=1715963335; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YgVJGtSdSQoxiH/JwZGPbdmDn+FTEW1VhqEVzZ5vcs0=;
        b=V8PyujCi+68/RMSe4AobBgwFvvVstt29ZhqhGcWatLcdJ1W4WuluMqDAaCCicL7vjl
         0Z0hfEBMRe5EuC0HKUIrM79/xokzz4RnCh4XHQpyOxQ4CI9/PnYNPscQjiQkyIZwcKnC
         eCtUEsscxnJyMsPAAAgxy5Ldx/8twKyX/YiJTqrZtMGn+Ft82qHMj73wxmy8O3dbP0Zz
         A+Aoa9M10RUNoGpifDQgx6QtjKfogyNGNqdyTpI/fq3HBaONhL6jLDNRMGjOawpqWCT5
         adI3ymUBrM337aqNHJ+x2Pbx3XwIdhJVwgblBhT8LNw0G48NOqmvKkGTnKSdr21baICX
         wn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715358535; x=1715963335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgVJGtSdSQoxiH/JwZGPbdmDn+FTEW1VhqEVzZ5vcs0=;
        b=YlKCCGOAKEvfyFCSu5UuWFCV4E2lxhsLhJs1w1kf3bwEiDXyh3NzAV+64Rabxg+K8b
         /m71R6UsNvXhaZt7aRVRAK3dKnpLGz7/6yjGfIQ5KQtwu7DUn6dEvAI3A/fqgUlVTDyv
         M9dMNGuPQTITYpMLYm/8EThF1aCXhpMJroCN20sme/s/9+di5tFAP7Z/eNascueZAMoO
         DjYnUUhPgzB/IW6mIz/hsYR8D3na3XTtaxUcjguya8z4Xo6STwcAeEBW3f999jDbA13e
         IwQ7Av+jmVJ4UaEVSuj+mHLPjR7GgwvprceSa/WONFDTmwphZSBRKPClP0M1jLctNubZ
         uBJA==
X-Forwarded-Encrypted: i=1; AJvYcCUTOmzt47lT6mYbXmfb9pNmWIdn4PL8KdZdDlE8jeW+auhvMVhXNDgVTSLefmOQnIDZvKWkKxwRcwNkie31fbA6rbtTOhTqqwTPBLOe4evo/QTm6GuWfbwSMw==
X-Gm-Message-State: AOJu0YyXZeDjwsdU1ha8PiZyH0E2DfvHTOVRHF8M78Q7n5FaxM0nEHlH
	L8qyV9Ux1NcZaU713X+hvLXiZoETkGr0q5lMwsznK1Vw0ocYeaDlsTOjCklTnHo=
X-Google-Smtp-Source: AGHT+IEBNBZwJ7UY/w207T6liKWy0qcUwPh16uAcjxrCG90REmApCaJsv6Dn931r+vPN21G8/a76Hw==
X-Received: by 2002:a05:6214:3186:b0:6a0:ae8a:e8ba with SMTP id 6a1803df08f44-6a168141010mr32027096d6.10.1715358535647;
        Fri, 10 May 2024 09:28:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1cd35bsm18630826d6.87.2024.05.10.09.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 09:28:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s5T78-006c0p-B6;
	Fri, 10 May 2024 13:28:54 -0300
Date: Fri, 10 May 2024 13:28:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/9] iommu: Add attachment handle to struct iopf_group
Message-ID: <20240510162854.GY4718@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-4-baolu.lu@linux.intel.com>
 <20240508000454.GM4718@ziepe.ca>
 <21ffbcc7-1103-4481-af14-5ee8856b9625@linux.intel.com>
 <20240510133824.GW4718@ziepe.ca>
 <0de7c71f-571a-4800-8f2b-9eda0c6b75de@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0de7c71f-571a-4800-8f2b-9eda0c6b75de@linux.intel.com>

On Fri, May 10, 2024 at 10:30:10PM +0800, Baolu Lu wrote:

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 35ae9a6f73d3..09b4e671dcee 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -173,6 +173,8 @@ struct iommu_domain_geometry {
> 
>  #define __IOMMU_DOMAIN_NESTED  (1U << 6)  /* User-managed address space
> nested
>                                               on a stage-2 translation
> */
> +#define __IOMMU_DOMAIN_PASID   (1U << 7)  /* User-managed domain for a
> +                                             specific PASID*/
> 
>  #define IOMMU_DOMAIN_ALLOC_FLAGS ~__IOMMU_DOMAIN_DMA_FQ
>  /*
> @@ -204,6 +206,9 @@ struct iommu_domain_geometry {
>  #define IOMMU_DOMAIN_SVA       (__IOMMU_DOMAIN_SVA)
>  #define IOMMU_DOMAIN_PLATFORM  (__IOMMU_DOMAIN_PLATFORM)
>  #define IOMMU_DOMAIN_NESTED    (__IOMMU_DOMAIN_NESTED)
> +#define IOMMU_DOMAIN_NESTED_PASID                              \
> +                               (__IOMMU_DOMAIN_NESTED |        \
> +                                __IOMMU_DOMAIN_PASID)

Yeah, something like that, I don't know about naming though..

How about

DOMAIN_NESTED = Attachment to RID or PASID
DOMAIN_NESTED_PASID_TABLE = RID and the entire PASID space

?

Jason
