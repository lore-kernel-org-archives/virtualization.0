Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC1517DE2E
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718198737; cv=none; b=HqijWr+k0OKEV/LA8r0M9feOXXxd/ED7A7qsMPLUnEyK533es57PYK5exLIySt+x/f6labUoZmMI3KM1QrgzHibnKGdO6P5sLuQ8Lg04mlDWbnKzntR8ddtFnsT6IMywlP4EMjUrYasWDauVJnm0EKWlM46lPi7Xk51IvwrjpoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718198737; c=relaxed/simple;
	bh=5r7kTei3l3CsdNg/q8RBiLmWZ032Se1UCEEyvhJU1a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogmJEljVyI2pSgCdV5rVs4k6pxQBhjWKKrXE9EE3MfP3l2NtQOaRQtwr51X0euNavmiswQfmFvgJo22+gDnR9Ge6LrV/QTWFYVWY2HFglsyJC35zSEYU1+GT6xJR3g7VszMuVc1X/K5gbUK5m0515XBP9uXWonbugD95fkqpHck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=n3TcgvOg; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="n3TcgvOg"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2780440C1A
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 13:25:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AwHjBEnrjizr for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jun 2024 13:25:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::835; helo=mail-qt1-x835.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 067AA40C1B
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 067AA40C1B
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=n3TcgvOg
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 067AA40C1B
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 13:25:34 +0000 (UTC)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-440655e64bdso20763301cf.0
        for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 06:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718198733; x=1718803533; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zUSqpmX+ejk/HnC4nbAm5rQmmAITtEvd4QugKxTCvc0=;
        b=n3TcgvOgskVXlu8Vl4XlymtUrJibQM+YdmJCyJy3CazRPxz0t9Aa/Y3t16M0om5bXI
         ioSqjBvwuGM7Sy3x2pYPx1OP2pbVC4z1QO5BjYtFHFbsrzwI/DNW6Peb+lEMt3Zyboo+
         4FLaYat1ULm5FROphtM+9jEMb42jbWcGQ86pcP7KgyqlWxOzTylJsOJriPzLkhZC6b2o
         jqUSmN0apX/WrHphNkRhIDVKiFw879R6DnqRT2xrZhtVvWSl+tHIcfcyMsxKKOSxC6Bv
         Ms9xqfFOltykxiArhY+ubBtyRSns6gchuUVwfh20WPxbddkejue/D3K4vnfQKl9+CvVc
         vXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718198733; x=1718803533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUSqpmX+ejk/HnC4nbAm5rQmmAITtEvd4QugKxTCvc0=;
        b=UNOdriwSy6LfyLE4qHDszPqMxlp1UTo8AiZ1UuSApihOyQruOetLRGm84v+c/grC4a
         pOI0iMeTAGx5KTJ4V3Oufqa0igrn49CL+rW+/RAzWuwcvfNw1KmBQiBV4T/BZdYPzLZO
         bDeLqA+b0QJJSkWYzTvNBu2Hyn+hNhmtsW4SG2o1XY52I7Sqocpw6bDU+e7hy0guUJSm
         U01X6+sFql8+1FnD+j1lKvo07ZRi0NCw1io+avk4MeGnXzyz2hWAU08XVX9ftU2SvII9
         RJRRoBgpKtRat1IiVDhmzVfJLjkv43lgzicBoHS855uhwZPURIgTgAcjOLkQRVUNfKIo
         +MhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3KDyWXEWoJ9XWewBDtnsCUeksLz4uAJHfP5vGvuRoEzkp8jJ/67RH8d9i4+sELdoyAVAE2gD35me9RsuDmD5qHC/B22ssew+OXi6Oo99fpIOarc8Raj/HQw==
X-Gm-Message-State: AOJu0YzBnhWRc47QMTN8vX4i8pSIsEA1ejhszTP9Xs1KH6lGcq8mD6pA
	lhfEVShDXTVEIEqLkwHArDqNB9xrFAqIKlDkPRX0oxSyf/x6wda2VS1SCRj78Tw=
X-Google-Smtp-Source: AGHT+IEaSleQ5/4nSB1kEi3YoGwZTAao8TntM14Myn/eVd0unCfawvyN6q3ByV4cJt9BsHj66DtLGg==
X-Received: by 2002:ac8:5d92:0:b0:441:37b:cd68 with SMTP id d75a77b69052e-4415abd5a8emr18860231cf.25.1718198733475;
        Wed, 12 Jun 2024 06:25:33 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-440542e98f8sm42778781cf.18.2024.06.12.06.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:25:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sHNyl-008tWb-7f;
	Wed, 12 Jun 2024 10:25:31 -0300
Date: Wed, 12 Jun 2024 10:25:31 -0300
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
Subject: Re: [PATCH v6 06/10] iommufd: Add iommufd fault object
Message-ID: <20240612132531.GV791043@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-7-baolu.lu@linux.intel.com>
 <BN9PR11MB527615EC664698C340A0CA878CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <a17113d3-500e-45ef-a2d2-747d890c9c5e@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a17113d3-500e-45ef-a2d2-747d890c9c5e@linux.intel.com>

On Sat, Jun 08, 2024 at 05:58:34PM +0800, Baolu Lu wrote:

> > > +static int iommufd_fault_fops_release(struct inode *inode, struct file *filep)
> > > +{
> > > +	struct iommufd_fault *fault = filep->private_data;
> > > +
> > > +	iommufd_ctx_put(fault->ictx);
> > > +	refcount_dec(&fault->obj.users);
> > > +	return 0;


This is in the wrong order, dec users before ctx_put.

> > hmm this doesn't sound correct. the context and refcount are
> > acquired in iommufd_fault_alloc() but here they are reverted when
> > the fd is closed...
> 
> These two refcounts were requested when the fault object was installed
> to the fault FD.
> 
>        filep = anon_inode_getfile("[iommufd-pgfault]", &iommufd_fault_fops,
>                                    fault, O_RDWR);
>         if (IS_ERR(filep)) {
>                 rc = PTR_ERR(filep);
>                 goto out_abort;
>         }
> 
>         refcount_inc(&fault->obj.users);
>         iommufd_ctx_get(fault->ictx);
>         fault->filep = filep;
> 
> These refcounts must then be released when the FD is released.

Yes

The ctx refcount is to avoid destroying the ctx FD, which can't work,
while the fault FD has an object pinned. This is also why the above
order is backwards.

Jason
