Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBE6B64C
	for <virtualization@lists.linux-foundation.org>; Sat, 29 Jun 2024 01:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719623516; cv=none; b=Vs2Xpz144y+lXJlOpWTjFbMpxBsJZKmW+XPH/tDXJZgSOK69b++UDaHwqjDJ59fgsuzwsI3HDcw7bPW38KUGruKJRQ9E14zZPsFS+DD9V3HJOuL1QYvPli/Nk7nswiQu2tnuqsHv+g2WClvzeB0B4fyVdoQRId0OAAv7YbRUuZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719623516; c=relaxed/simple;
	bh=aef4F0Bvpd2E+ekA6aOSsipc4x6PfNlwGk26KdC5swY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQB1UafDVjTbySrYQ30CouxJMI57pmxHXzkZsVINavc4cl+U4/ks5YKRfuXt+Q2svquPRCGn98gfTPJiJo62dnZp6PHKmjzxgypO1LFIb6af8srW9oll1VZ82/D2P+lmxD4mH5pQ2rbwFNovIM/X217WFuApKo1Cdl6y45U8XsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GrVXoyuo; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GrVXoyuo"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F39941E47
	for <virtualization@lists.linux-foundation.org>; Sat, 29 Jun 2024 01:11:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ioacxTS48sTY for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jun 2024 01:11:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1895C41DD5
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1895C41DD5
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=GrVXoyuo
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1895C41DD5
	for <virtualization@lists.linux-foundation.org>; Sat, 29 Jun 2024 01:11:54 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3d562b35fb6so696450b6e.3
        for <virtualization@lists.linux-foundation.org>; Fri, 28 Jun 2024 18:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719623513; x=1720228313; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T+KbwleecXN3riScVDyiugaIffNMxefx2YjUriSCAW8=;
        b=GrVXoyuozdzg64Yamj/E2xifFrT2fm+v+nsfdsNC/DKz8HLxRCcOi2OquSPhv0oSGR
         gCOQVzcSgeWY+oDSeNhyW4oFdf8wDskJsA2Wq+KatZW++YX+E7LUxGS6eqdcbo43Uqrd
         RSg5hP0qt0SOEBw8MXVPjiR/CYSkEzI392iVK36Df5QFVEigc2CaiQHDgxXOjetL4zk1
         xmRKsKVIX3CaRuhEQEfZANhXmewsA1fFxpCT+ztIBhSsBjTHB20h6bofzPdT3UqBubKV
         Djr+UkE4HZNQ1eAihpFAAU/bygLct0b2zGvfCqZN31h8psjdLSAtHfr2ECOlgyx+73F8
         PnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719623513; x=1720228313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+KbwleecXN3riScVDyiugaIffNMxefx2YjUriSCAW8=;
        b=uPGKeMLwC+WyfXWqM9IHuo6PZA9pjJeCu00Prlsse9BgMaIbJoCiyL1ZyvpR3bmrwX
         NO3l3AUDj03OIoo/7FGb9UrLYl+2oFWVsY1GinRrUtSbS0M8pxPvTZJCuQQlJ178YWL6
         ifr8Ul72Jn0DWGVE0DuKxh+Dc8og+CYtR+cxaylgKPCR1Ce+F6OTyH4h173H+c4txFXs
         IanMsZU8mV8fHUPvOgT7N87MCTGx9uQ2DgVcXJeGZXCjsVdgNX/ZsF4qP8WbIC1/o45O
         iplSAuS1VnB7bNQcZq3ZyzWwIorvIvSv0JuRBdlx51rPJgR/oNVsBZSInqzPpjD7GmYY
         qbHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq2kU/yGltWxfDB988ZkdIAr0u9ljkAVBNve3k3q4SaukT7z/DlSnsVv/wuY9JwVExbfQOWfzWpbWHB75alFl3yf0gdfwG2yr5jLORT+c9qyd+N5QxgY0Ggw==
X-Gm-Message-State: AOJu0Ywc3yx/vU0lzLg/8cQuToipXxnZw/X5HTQXdHiCWJhtxhhpG3dP
	1aAd7us6uPfeFva6qQkDZ1yPXNbM1DBQ0hMEXNIEp4q9Yn7W+l6gZ0MPU4Pi3iE=
X-Google-Smtp-Source: AGHT+IGI3SD8A1N5RAQhEKo93yRDR33fQ3JlDGvi7EAwNp2DA4Cb9gac0LEseC9mjRgt/U5qth10Jw==
X-Received: by 2002:a05:6808:17a7:b0:3d6:342b:d7f3 with SMTP id 5614622812f47-3d6342bdbb0mr2109008b6e.52.1719623513063;
        Fri, 28 Jun 2024 18:11:53 -0700 (PDT)
Received: from ziepe.ca ([24.114.37.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53be5sm1784142a12.16.2024.06.28.18.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 18:11:52 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sNJrv-0004oI-S0;
	Fri, 28 Jun 2024 19:14:59 -0300
Date: Fri, 28 Jun 2024 19:14:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/10] IOMMUFD: Deliver IO page faults to user space
Message-ID: <Zn814+VwyCJ/okax@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616061155.169343-1-baolu.lu@linux.intel.com>

On Sun, Jun 16, 2024 at 02:11:45PM +0800, Lu Baolu wrote:

> Lu Baolu (10):
>   iommu: Introduce domain attachment handle
>   iommu: Remove sva handle list
>   iommu: Add attach handle to struct iopf_group
>   iommu: Extend domain attach group with handle support
>   iommufd: Add fault and response message definitions
>   iommufd: Add iommufd fault object
>   iommufd: Fault-capable hwpt attach/detach/replace
>   iommufd: Associate fault object with iommufd_hw_pgtable
>   iommufd/selftest: Add IOPF support for mock device
>   iommufd/selftest: Add coverage for IOPF test

Small remarks aside this all looks fine to me, send a v8 and I'll try
to pick it up next week

Thanks,
Jason
