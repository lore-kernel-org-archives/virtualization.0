Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663B91465A1
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jul 2024 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720456202; cv=none; b=RK2Rx1lm+DcPwohEn1r7LMonh17NBgk1MnZpf/nq6zdwCbb4T9QvAMRrQKpbdHlLPi502tn7fK64xa4RpVcefUZknJgI1FTKZjS+mDJgRY6Q7vK7dXJe0YGCG5dg7FL3G8BrWf0DcQcjDQUp9pyehcd8I9n8DIsx5aAwfjpyVtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720456202; c=relaxed/simple;
	bh=3h766dFHjusL9yF2BAWAi2RB7FAbv/vaFEWG4U4Nou4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyhz6GwqdChFv2AkN92xnu8mImsAUPcVpA2+fMdzirU91solTEGVwU9dstflqcu5UqLxusZY9M7oyDnXd0tFrCht3lfbay1tfjU8AZFuz58wbAwgQVlBQTycg+927sBPwyfOR5b7Cb9/z7RdOrAtuRMgYdtJeH5S35rmAm+qco0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Dr9Jw70h; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Dr9Jw70h"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 13E1C4094F
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jul 2024 16:30:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v67froCcA_8n for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Jul 2024 16:30:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::829; helo=mail-qt1-x829.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A98EE40286
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A98EE40286
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Dr9Jw70h
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A98EE40286
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jul 2024 16:29:59 +0000 (UTC)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-447e3a64aa1so9561651cf.2
        for <virtualization@lists.linux-foundation.org>; Mon, 08 Jul 2024 09:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720456198; x=1721060998; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bpADAnxMmPl0KnU1qL520o96mOq4J8FvDBj3a92ycMo=;
        b=Dr9Jw70hTOPNWv5ZRuzqeXpwbyZhAoU4FedINOBbE0fGJxou5jS5S/QPch0NkY2teJ
         CM03WbHUFLq2+tMbPn7RhJ8jqxZJYRqFHFIHnVieszXbVu3zEDYwWjgiTH0P06KDj1PA
         aUop6NokCKRGIgJzTzd7tTXqLGMMijLdDebjO0ejGcLx0DMg/6zXPRmexh41eHqK1zqV
         2X3hhrfcKa8Xk1oDvHa0Hw17Pw8n6fZpzCiJmzZJIFzknEL/ThyTeD43whzJfs2hLS7d
         ohpj5pJb3niDH24tw4OQabQdIBRCGyBPBJECfoCLnIv53Gebr7kK5zbtthNrzx+ScNoC
         TSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720456198; x=1721060998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpADAnxMmPl0KnU1qL520o96mOq4J8FvDBj3a92ycMo=;
        b=OyX2R+YJiCLek+sxrugAZS9JG6NI2XYPWKkqSftuKv8MyP9MjxUPhwantQS96GSYvs
         rlqPVaQibN8SwGLrZtBlyeVy/m5H1itXyXy0vwJH7K5CoMFp+bjH8YoUyntogZBt4m1Y
         /tL0gzv82PLOlQ+EDKpzCbdZpGM/3/wAIEMaNKcLcGSgTOk3TJ62kOiioTeAkn9nlPHi
         G0UQ3HvBzuHTWywm7gI8INBQWp4ZCflApa6IfVB4PQJ048qch0slakYxhY6ZQtB0iDCE
         IVTbGrstiy82pYiI003Ad5u6a0tqFliAJ8kJJMa4vug+JOeDgXiKf5vmPVDqns0EZODU
         bnvA==
X-Forwarded-Encrypted: i=1; AJvYcCXfqVS7gmcU9GdnaOJXlWn9ZI4LcTgKCgjhtqL3L76XZ3Ooov/HQD5ORe/Q4ASIGc/wPnejuvVUew46jartPO/ZAEyUpRQvLdiyrS981vtAOR8L3oaUGAeMZw==
X-Gm-Message-State: AOJu0Yx4gx0Pebrs9HI3Gy502H7AZWtnLlLH+FbvalvPVvagbf+sgBJz
	/54ePrbjzXQB+QdJ4wfvN4/rODBe5mLvHJimzfTpYcd2MvyFQp9SnFZol6/0364=
X-Google-Smtp-Source: AGHT+IFU/w14qf4HQu+71Ycg0U3BawEnHajgQaixjaC+e8UHgPl40rgFBfuNrXSLQ5sWrKc6QmM3IA==
X-Received: by 2002:a05:622a:13d2:b0:447:eb16:2e6a with SMTP id d75a77b69052e-447eb163298mr71776471cf.40.1720456198133;
        Mon, 08 Jul 2024 09:29:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9bfb2b7sm914951cf.86.2024.07.08.09.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 09:29:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sQrFV-000SlT-1j;
	Mon, 08 Jul 2024 13:29:57 -0300
Date: Mon, 8 Jul 2024 13:29:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 06/10] iommufd: Add iommufd fault object
Message-ID: <20240708162957.GB14050@ziepe.ca>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-7-baolu.lu@linux.intel.com>
 <ZoXZZ2SJ/WdlMJaX@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoXZZ2SJ/WdlMJaX@Asurada-Nvidia>

On Wed, Jul 03, 2024 at 04:06:15PM -0700, Nicolin Chen wrote:

> I learned that this hwpt->fault is exclusively for IOPF/PRI. And
> Jason suggested me to add a different one for VIOMMU. Yet, after
> taking a closer look, I found the fault object in this series is
> seemingly quite generic at the uAPI level: its naming/structure,
> and the way how it's allocated and passed to hwpt, despite being
> highly correlated with IOPF in its fops code. So, I feel that we
> might have a chance of reusing it for different fault types:
> 
> +enum iommu_fault_type {
> +	IOMMU_FAULT_TYPE_HWPT_IOPF,
> +	IOMMU_FAULT_TYPE_VIOMMU_IRQ,
> +};
> 
>  struct iommu_fault_alloc {
>  	__u32 size;
>  	__u32 flags;
> +	__u32 type;  /* enum iommu_fault_type */
>  	__u32 out_fault_id;
>  	__u32 out_fault_fd;
>  };

I think I would just add the type at the end of the struct and rely on
our existing 0 is backwards compat mechanism. 0 means HWPT_IOPF. ie no
need to do anything now.

It would make some sense to call this a "report" object than "fault"
if we are going to use it for different things. We could probably
rename it without much trouble. There is also not a significant issue
with having two alloc commands for FDs.

I'd also think VIOMMU_IRQ is probably not that right abstraction,
likely it makes more sense to push driver-specific event messages sort
of like IOPF and one of the messages can indicate a arm-smmu-v3 VCDMQ
interrupt, other messages could indicate BAD_CD and similar sorts of
events we might want to capture and forward.

So, I'm inclined to just take this series as-is

Jason
