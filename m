Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D845FB87
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Mar 2024 17:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711128157; cv=none; b=sQIGoD49yMSOEhMCpjqBuUiHB3M+Pgz1jmJUXq+4K7zy9owwkYUFLmxb0tLB6BHlIyqwbDaqTvg9mLt/vqMJkB9upmnStfc3PX/UTcujoaqbDMK1KOFA2HgtF29saGtCKTCVvUNTi3VSgGbZdcVE08UfL9owU1O3QhNHGQnPqnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711128157; c=relaxed/simple;
	bh=JRQSJkNbZDDh5hmntu8CppKCnDmLxnU8CBU620nL6DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fqqnk5q+q5qdHd0CzHEkxpeirxoIp7ejy/ROtTZPwaHng5/uuTzv+Ac1fG9CqgjNM43ihjdOVbVF/T20IBQC3v4Hda0oOV1irRz4EJh1hzxlkJUFI2wDX1UtyY6u0NN6hcoN64YEBAx3shttXU7zTSjwXno7innvqg9z69b6E+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=I5ZLeqtH; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="I5ZLeqtH"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 23BF3405CE
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Mar 2024 17:22:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RIOcI3bRxZUT
	for <virtualization@lists.linux-foundation.org>;
	Fri, 22 Mar 2024 17:22:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f29; helo=mail-qv1-xf29.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1FBEC40519
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1FBEC40519
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=I5ZLeqtH
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1FBEC40519
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Mar 2024 17:22:34 +0000 (UTC)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-690c1747c3cso18644596d6.0
        for <virtualization@lists.linux-foundation.org>; Fri, 22 Mar 2024 10:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1711128154; x=1711732954; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f2AQjZhkcpL+YcTkiIsVz9MRTBhpc8RMyyFuJbdJLXk=;
        b=I5ZLeqtHKuftCZxWI620RNWotnCQ8enGqlRZy0gyHmAui1DIgMq1Az/385ablWDsPv
         o6+3bnsVpnUw750I3XNA3mkRMR808Tr/BVdYNJ10EPBXddLGNigoNLht4oSOTx34Wt7r
         d7Y58hqraUV3LyHUxWHtFMj7bugfMPjvR/oJcms5dmVum6C+3jIf23g0FNyhOs6Sl8m4
         ugJ67oLHMBLU/fq/md223d9QNS1oPuHrQpbPcq8jFJ1jB4+gBna45zYWYhyNh11mBPpp
         YpWJM64j5i10O7mnOvzGLzeDqnIy02cWGJuPrD2bW+ASQ7o4ATY7Ji5DqM8dGl3UPwMB
         q6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711128154; x=1711732954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2AQjZhkcpL+YcTkiIsVz9MRTBhpc8RMyyFuJbdJLXk=;
        b=rWUlFSHxABOlY+QFHcMBRt49MZJ3plcEKaC394ALdpp+CVza+Id7lX786N3UWY0THj
         qUYUlZ2Rty4ooTvsVrl29S+qv0jayo6KGcolVmkE5oW//KBkP2RpBQhO/sUCMybsDEMQ
         l/53f3iMLdqJq9Q2jRJBcjaUWEwnyB9SwHsYUCrycbWKxNpDJatxE6+N6IhB6ViUrLVw
         mgRcyZDGhZLV5lzd0i2QM7lAAPZ7qh8pmI3IrKPCMommH0wJQ08UF4vXmhYoBekjlcFv
         hNCeyHND4FFXhD5MXpggBWw5J9pyvOU27cADmLp47IUWn8NkCwS4W3VK129RyynOdaVT
         MSVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG1ZiIfwArZ2OHQ8sqQeq27d2HrSnswFp4fHoUUqWl3caplpQtFKC+gzAUr/erIyBpbElBG+w92Bbp79vBK6HsOc1Omz7RYGwKKSV9KZyho0BBLy7i0gAJlg==
X-Gm-Message-State: AOJu0YxgoZTdbB6DVnCJA+DqNk1sme+k9k+rnEAc/1fopEZH9oZ6CFzW
	FN9oZHQ4rmbT9WaS1VQh9/+CFtGqOrrfxnS729mgKFa7fkmPBaQCwO5npcVF2fo=
X-Google-Smtp-Source: AGHT+IFkTNz9gzTcdcg16F0TwV7dxXOkqWGRizUzT+UpEdwSHdcAyu+RuzvoVxcbESzfseuHHEH9Lw==
X-Received: by 2002:a05:6214:1307:b0:690:b479:527e with SMTP id pn7-20020a056214130700b00690b479527emr4829755qvb.13.1711128153820;
        Fri, 22 Mar 2024 10:22:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id kl6-20020a056214518600b00691281bf661sm1267511qvb.5.2024.03.22.10.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 10:22:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rnibA-00CUem-JS;
	Fri, 22 Mar 2024 14:22:32 -0300
Date: Fri, 22 Mar 2024 14:22:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/8] iommufd: Add iommufd fault object
Message-ID: <20240322172232.GK66976@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-5-baolu.lu@linux.intel.com>
 <ad4575588dd247fa8beae60963f36404@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad4575588dd247fa8beae60963f36404@huawei.com>

On Wed, Mar 20, 2024 at 04:18:05PM +0000, Shameerali Kolothum Thodi wrote:
> 
> What I have noticed is that,
> -read interface works fine and I can receive struct tiommu_hwpt_pgfault data.
> -But once Guest handles the page faults and returns the page response,
>  the write to fault fd never reaches the kernel. The sequence is like below,
>  
>   sqe = io_uring_get_sqe(ring);
>   io_uring_prep_write(sqe, hwpt->fault_fd, resp, sizeof(*resp), 0);
>   io_uring_sqe_set_data(sqe, resp);
>   io_uring_submit(ring);
>   ret = io_uring_wait_cqe(ring, &cqe); 
>   ....
> Please find the function here[2]
> 
> The above cqe wait never returns and hardware times out without receiving
> page response. My understanding of io_uring default op is that it tries to 
> issue an sqe as non-blocking first. But it looks like the above write sequence
> ends up in kernel poll_wait() as well.Not sure how we can avoid that for
> write.

Ah, right, it is because poll can't be choosy about read/write, it has
to work equally for both directions. iommufd_fault_fops_poll() never
returns EPOLLOUT

It should just always return EPOLLOUT because we don't have any queue
to manage.

Jason
