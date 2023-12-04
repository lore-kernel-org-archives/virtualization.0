Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D81B2C84D
	for <virtualization@lists.linux-foundation.org>; Mon,  4 Dec 2023 15:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cqG1DIsl"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0FD5441755
	for <virtualization@lists.linux-foundation.org>; Mon,  4 Dec 2023 15:32:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0FD5441755
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=cqG1DIsl
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gP0YrWRC5FuI
	for <virtualization@lists.linux-foundation.org>;
	Mon,  4 Dec 2023 15:32:12 +0000 (UTC)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 16AF8415FD
	for <virtualization@lists.linux-foundation.org>; Mon,  4 Dec 2023 15:32:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 16AF8415FD
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-425427286a8so22267801cf.3
        for <virtualization@lists.linux-foundation.org>; Mon, 04 Dec 2023 07:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701703931; x=1702308731; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QNErOhF1qMkgPNVpHAnyVSyCwAUX/1YSBmZDFvsm8OU=;
        b=cqG1DIslQA4Rd+4AV/TtennNECiSs5jV0fi1paDFMC5CYK8jXGPt+YoPKY7nUP1npW
         Y8o+V1A8O24YaX3HMytVXNDe7/G113+FG417+VPWBmhueEDfe5kiQ0BIPx2toEDt7HnK
         Z/n0oo4wK0O7C/u5hru8TDzw2W+iu7R85B8RP/dQJcibKuBbOG0OSFRdr9y1EYDxMkQ8
         qkEXJoEYzjb5FiGHJVJSoLUsgrhcc/NYHVUW6oJZ+E81PbHuTrTIuWCjwrh1wm/1VIun
         +3K81buhywe4xEed9jefy6OGN68oBsb7RjjAD9iGUlW3PI6EQPfNwUXuXjvCi2UTNhnE
         sS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701703931; x=1702308731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNErOhF1qMkgPNVpHAnyVSyCwAUX/1YSBmZDFvsm8OU=;
        b=KnalGSB2PB1k1/Q25jnix5+l/0qwqH+JoPwduditC5Eryac7InmlsiN6+FGdevUDb/
         SdrATa6pugqwILKANdCNUuzUcS9cGsRiYxBnscsJutJhNmzCGSC4SF7BTCgoVnNLf7+Q
         ZvnecbZFvRgVGOFBPSWu6JHQq3rLIMNo2v/q191FpYAV6X3Lgkc3QFKRwvtsXYLuaDnS
         XRxGppiPIoAf6teBhgAa2CSRA0Hhbkz1LmUIfNKcuqoiz+Qq3++vJCI+bfNffqMTenwD
         pPBpRV3oJAA24QBNI1/jLpX6fXM7ZjvWgVhI7BIHMQahZCAVzjqAdymUjvub9NLrTanw
         FyrQ==
X-Gm-Message-State: AOJu0YwANY+Cp7zl/YmpLBLAe5IvCx/HaET7oSC+lCM5r+b9Jxipeg9p
	4wVdk/RN+5B+Eg5dUnmHXufJcA==
X-Google-Smtp-Source: AGHT+IEnloh+umt8D2CaTqj/3erJ8LZq5gKurAnArFiVByvdfAGoIgyiu/VWyqqDTZ8kj1dh4ApCGQ==
X-Received: by 2002:a05:622a:1c8:b0:425:4043:96e2 with SMTP id t8-20020a05622a01c800b00425404396e2mr6614490qtw.111.1701703930810;
        Mon, 04 Dec 2023 07:32:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id df15-20020a05622a0ecf00b00423da75b0f4sm4371928qtb.71.2023.12.04.07.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 07:32:10 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rAAvZ-00B2r2-ML;
	Mon, 04 Dec 2023 11:32:09 -0400
Date: Mon, 4 Dec 2023 11:32:09 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joel Granados <j.granados@samsung.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Message-ID: <20231204153209.GN1489931@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <CGME20231204150747eucas1p2365e92a7ac33ba99b801d7c800acaf6a@eucas1p2.samsung.com>
 <20231204150744.db3hfpq4v55cuavn@localhost>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204150744.db3hfpq4v55cuavn@localhost>

On Mon, Dec 04, 2023 at 04:07:44PM +0100, Joel Granados wrote:
> On Thu, Oct 26, 2023 at 10:49:24AM +0800, Lu Baolu wrote:
> > Hi folks,
> > 
> > This series implements the functionality of delivering IO page faults to
> > user space through the IOMMUFD framework for nested translation. Nested
> Does this mean the IOPF_CAPABLE HWPT needs to be parented by a HWPT
> created with IOMMU_HWPT_ALLOC_NEST_PARENT set?

I would expect no. Both a nested and un-nested configuration should
work.

Jason
