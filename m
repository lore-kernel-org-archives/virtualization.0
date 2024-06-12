Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E081791F4
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 13:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718197865; cv=none; b=DqWM94Wy7Sks+smUfIoNKar87gZeQVJ9c8Pp2TltGc+SNbloyHYbTyVMXml3mRW1KR/6v0ni1v5vSAXYD2kKdq3vq3ckawMjVYaTrrj1RnNY53LYtpcmlLdObFD13ZBaewgQLrzzIr9bEZY9MjFO6TLoqvXBI+W5ojt3e4SJBMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718197865; c=relaxed/simple;
	bh=65xpeURwcmOmVb9HhCKWlX4HTGmbshxZsViqDHmAa2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=La1MVz6GxQRiqIg5ozqzWwhTvnNy7s8MIsfTWDumBA8ftlDzdAmiRjcU6QNRbjsevEuMj/yHxGHBd/OWy2bDjn5MzFPZjRNmLUC+Ma9SiKafgySMW7bejTvR/qSUHlXOFMthu6MfxXxRcfIqBGFU66Gm3K26KPdM1GJzJtNFp/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Gu4vT4mF; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Gu4vT4mF"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 07A1D402E0
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 13:11:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WBv8Ct0WHTcO for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jun 2024 13:11:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A0A0640026
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A0A0640026
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Gu4vT4mF
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A0A0640026
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 13:11:02 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6f9ca219760so1666350a34.2
        for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 06:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718197861; x=1718802661; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GDxonTYHz9nxQaqpOoNfBlOFb36tO8nlEtyL7Ho8AwQ=;
        b=Gu4vT4mFSqpsUAelS6KCSnOytAxVxWSxBEN3JjCBi9ZdWJ5Mx+Bw8uz3Pbw1eB9Har
         JR7PCBd28wNZ1hJOo9RZ6MsAyy2xrN5Fj6KRDL1SYqyZWEQXTQD4zMCDIQKYnfnz8kYN
         xvhln/9i+y9PKi+ALbigUmxQviSg2+kxG8EnkSg4csOmrA0uqYbYRn651ujIX+W/Rdqb
         8jDFz6a7dCRQe6XBRPr7tyr/QT7HKXSsCJ50UpAaWkcPjenSl4lNsjBACtvzniXWOwtK
         Q1rRqISUdF0gc/dl1VWflZFsdvyhfVKrgQH7akE3dZj02+7CZv4ws/usHiCh9JwwWrkc
         dF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718197861; x=1718802661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDxonTYHz9nxQaqpOoNfBlOFb36tO8nlEtyL7Ho8AwQ=;
        b=X/pgNrv/4OE5ZQeROE8jLTy28500+vEpcTs2aNhIu7tPhDWQYsUBiSH+x4KMEaJ37c
         Hf6FJPZery5+Ubf8qcUky5oUdi0TnsgQ6v4zZq2w1FqtxIrunqhPS2dNBncfL8xyT58J
         rhx6cxjjL6ZVxL/sieBDsAOXwAQihvU/K1ZEfGYXTgXF1sS1khQFXCzRdSQqc8bjRirJ
         67P9Hy0tjU42XXxjpp2j2fV/64x4NCsfLMGgJPILcpT0UXW1PQBpDRkoRUwIZb5iivAo
         06ELnAy0zv2sAfpLADjUOnV5T8+HkjHtxKATPFxyJCx+kefObR7sg9weAX0XuR48hpD+
         roag==
X-Forwarded-Encrypted: i=1; AJvYcCVsPAPyYP0rRiOl14wqwjpVTcRSmtuiRM9lkQQiGqeuOkxJ6Lz1V970zDvGBHwk+JJ9IRwvjqwFXMyNaZJIXDzltvKY8JMFFAokpvxTKJVpzJXFNVf8truOFQ==
X-Gm-Message-State: AOJu0Ywr0npvebkDjrP/fE83rmocoHOcLTpTX8K/1iPrAMzEOGx5+4on
	VTjidGZRB+bj3zdixgyh5jgYbcZTLdeKIW1jB5w01jpxiy+0yZ73o8vWHU2epP8=
X-Google-Smtp-Source: AGHT+IGl8HcoadNuoHnllo+K1b1rGMd1ZFrjzpRpn566P4vS2gHW66FG2Ie4jvGYbR3pikDM/mmSHg==
X-Received: by 2002:a05:6830:1e04:b0:6f9:b580:e420 with SMTP id 46e09a7af769-6fa1c43951emr1549072a34.37.1718197861362;
        Wed, 12 Jun 2024 06:11:01 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7954f6f337dsm444526785a.42.2024.06.12.06.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:11:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sHNkh-008pLb-LU;
	Wed, 12 Jun 2024 10:10:59 -0300
Date: Wed, 12 Jun 2024 10:10:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 01/10] iommu: Introduce domain attachment handle
Message-ID: <20240612131059.GS791043@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52767B3B1F441D9AA656AC258CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ae7c05b0-104e-4c71-99aa-fed2a4f209fb@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae7c05b0-104e-4c71-99aa-fed2a4f209fb@linux.intel.com>

On Thu, Jun 06, 2024 at 01:33:29PM +0800, Baolu Lu wrote:

> > But if certain path (other than iopf) in the iommu core needs to know
> > the exact domain pointer then this change breaks it.
> 
> The iommu core should not fetch the domain pointer in paths other than
> attach/detach/replace. There is currently no reference counter for an
> iommu domain, hence fetching the domain for other purposes will
> potentially lead to a use-after-free issue.

If you are doing this then we should get rid of
iommu_get_domain_for_dev_pasid, and always return the handle
there. Making it clear that all those flows require handles to work.

But is this really OK? What happened to the patch fixing the error
unwind in attach_pasid? Doesn't it always need the domain to undo a
failed attach?

Jason
