Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834AE2C84E
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CzxM1dUG"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E0088435FE
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 13:20:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E0088435FE
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=CzxM1dUG
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TeeJNRod_Y0s
	for <virtualization@lists.linux-foundation.org>;
	Wed, 13 Dec 2023 13:20:02 +0000 (UTC)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A05FA40636
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 13:20:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A05FA40636
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-67ef645be98so4690546d6.2
        for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 05:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702473600; x=1703078400; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pL0YocGPkvVGqiCu9lyP3UNNLSGUFRW6Fi4cZBlmelc=;
        b=CzxM1dUGuMvV5Q8JvdhUmmLIMDq2WetyJ66mT9yJ30IsoSfhlU+6ZYK+ZWWqmL/8j3
         QUyGyRvDRZ1qkxJyZC5CbPCB5jajgs8N5qP/8zzNSbGrLf6lII/uM1wJcdDIiD0uUZmX
         JWEJFK+t8C/wjYGKsTL7s4RIZQFuo1fZjMyrPNqm1WPndIhO6Fq/9h1GhLIgBpRM5855
         f1JE674aRd0AVJCg9HkwKLVJB4G3H7Na1r9Ekh3Vu19cxidCJiU3Qfbez1pIFJM7kiJt
         GTiyPxOhSCTd3cqdjvfW2qSLm2FGCbLliiRaJzdl/9DPNIpHYV/GVUYCVAC9kNeeZAGI
         wmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702473600; x=1703078400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pL0YocGPkvVGqiCu9lyP3UNNLSGUFRW6Fi4cZBlmelc=;
        b=wePCtG4U9gDZnWXClE9c10GMOrBND6K375gYyGaWfp/Wm1ivyQIFKCCZIWtZ6bou8U
         DorKYNbCO5B4dH8Hw/80pTCGNJ/9ZosMPQgGm2BkssySZHgLHTaNAyjrESzGVZFmKJ8u
         GHKmVdAMxTfDsh5qJRAqdsOkJZ41O1zK1sjFQX67zV7jHcTeGq6UkxOVV1mbhkmOYG5I
         b5D46tgvtvzrRYer1SGREgVQxnuZst7WH2V0m2al5Ka8kfvhsrcRd0/s0Eu5nLu9h6f8
         +weBGUVcyKfmoILfkmfgIDrVKXg/kkbjSC8QjmNZE82U1YIuwvyu3zEqwSZPr0atZBqG
         Ec1A==
X-Gm-Message-State: AOJu0Yy1LkUsjlBCb2B1f+aRXE97fSkM9HZhcXtTo3IFzYia0jRgiV/O
	mq1nLdZrX0Rd1pUmQ/sLcSU+bw==
X-Google-Smtp-Source: AGHT+IHBRIb2molU2pUmRSk3m8apIaaHB6x4+xMRVsRdDRSbKUM6I3jsw6DfyySmptvv5fd5r5efyw==
X-Received: by 2002:a05:6214:9d3:b0:67e:f7f2:2ba5 with SMTP id dp19-20020a05621409d300b0067ef7f22ba5mr1223954qvb.85.1702473600381;
        Wed, 13 Dec 2023 05:20:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id ov11-20020a05620a628b00b0077d7e9a134bsm4481925qkn.129.2023.12.13.05.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 05:19:59 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rDP9a-00Dftf-PX;
	Wed, 13 Dec 2023 09:19:58 -0400
Date: Wed, 13 Dec 2023 09:19:58 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] iommufd: Initializing and releasing IO page fault
 data
Message-ID: <20231213131958.GF3013885@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-4-baolu.lu@linux.intel.com>
 <CGME20231212131010eucas1p104d069ac6d6c97fce4987caa62c996ee@eucas1p1.samsung.com>
 <20231212131008.k6s5xwjgolp6geps@localhost>
 <20231212141208.GA3013885@ziepe.ca>
 <276597d0-9947-44f1-a6b9-16d245394b22@linux.intel.com>
 <BN9PR11MB52761698732F1899E65DE5A38C8DA@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52761698732F1899E65DE5A38C8DA@BN9PR11MB5276.namprd11.prod.outlook.com>

On Wed, Dec 13, 2023 at 02:15:28AM +0000, Tian, Kevin wrote:
> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Wednesday, December 13, 2023 10:05 AM
> > >
> > >> 2. This is not intended to work only with idxd and uacce. right?
> > > It should work everywhere, I suspect Intel Team didn't hit this
> > > because they are testing IDXD SIOV?
> > 
> > Yes.
> > 
> > > Can you guys also test it as a PF
> > > assignment?
> > 
> > For PF assignment, probably the driver (vfio-pci) needs to enable iopf.
> > 
> 
> We haven't merged anything for SIOV yet.
> 
> so the base of this series should be PCI functions (PF or VF) and vfio-pci
> has to be extended with whatever required to support iopf.

Right. I suggest you target full idxd device assignment to a guest
with working PRI/etc as a validation.

Jason
