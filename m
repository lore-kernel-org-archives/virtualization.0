Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFC81171C
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Dec 2023 14:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YpJpy8rY"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 85DF743706
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Dec 2023 14:24:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 85DF743706
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=YpJpy8rY
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L9Q54J1nc-7B
	for <virtualization@lists.linux-foundation.org>;
	Fri,  1 Dec 2023 14:24:30 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C66E040158
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Dec 2023 14:24:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C66E040158
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77dd08f75afso115170185a.3
        for <virtualization@lists.linux-foundation.org>; Fri, 01 Dec 2023 06:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701440668; x=1702045468; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBsvr3M7y7nivS2i0Ob2cINhbfVirpoyS0qfXlH/VdM=;
        b=YpJpy8rYuLQNfT1ddVMla5QoPjhpALD8rcYnmDvdV3kDYjNx5I5XTNwiNAgOwpqGsH
         DUcJGLPC8XxZGPXYFm8nfSNTLiKFFti9M8pWnEt3/aUdwTDugop3zntPCN1KmsJM+Mtv
         n95Wj74fY3rbRDrgZHDFKbHbJqbmz+wQMMUcN13/b1wi4ixLdTXAvpZ6t4rsU6ZeHiMU
         tnwuX90xYH1zDbp6JWonDSlqvq5tkicOoTgMKxht6B77iWogNXGtVP0+cv0vJZPWjRtr
         iXPyqBp+lkM59ZKOf3TLQxlAEiGonEBhMhwkkQb8XW7SouvgbI02i2jeiVUiGsHvCF0A
         J+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701440668; x=1702045468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBsvr3M7y7nivS2i0Ob2cINhbfVirpoyS0qfXlH/VdM=;
        b=nBBlOJreqNe6ApurbyobJDnm+Qv9kjYYMxvZjK0P2a3SYlnpzIUfAdFEDxsa/We8zf
         0OboVnEmkIK6sC37A5nM5QtTZ5gMCPWA5gpFu6PpySBpHH3avLv+ClSu3UFpZDm/TSbo
         DMyUgkwIwUf4jSUHLvC7hIL8J2xTmBJe+5i/4oCpzMUomT78tqyTIESEhLC7Q9suw9xt
         Ba/CZHxDS73Q3SGMvp6oucYE32XCcga+uxNPtwOrsOqc69CMqpror8WJf4c5T9HbuOiZ
         vRDqMThJ+XV6A1zi6RJzMTxn/E4lTF6gpXUFSw2BaU4utQvNrp/BVdlDmPmbpySXukFS
         5dPQ==
X-Gm-Message-State: AOJu0YxNbm3W8l3yf7dQcArCnOdZRf8sTUHcxXPet8eeutMHDtP1/y13
	qN2Gg5Wxf/JULy3V0+pFffmJcA==
X-Google-Smtp-Source: AGHT+IFhbf0pnfqRmkrdAgeW6divQjwDnNZXsygeLqQa4cWucFhgEwsEVMG94jE+nlw/p5nE/n3K4A==
X-Received: by 2002:a05:620a:1daa:b0:779:deb9:72c6 with SMTP id pj42-20020a05620a1daa00b00779deb972c6mr24340270qkn.14.1701440668556;
        Fri, 01 Dec 2023 06:24:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id v15-20020a05620a122f00b0077d606bec92sm1519643qkj.108.2023.12.01.06.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 06:24:27 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r94RP-006FTp-4e;
	Fri, 01 Dec 2023 10:24:27 -0400
Date: Fri, 1 Dec 2023 10:24:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Message-ID: <20231201142427.GJ1394392@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026024930.382898-1-baolu.lu@linux.intel.com>

On Thu, Oct 26, 2023 at 10:49:24AM +0800, Lu Baolu wrote:
> Hi folks,
> 
> This series implements the functionality of delivering IO page faults to
> user space through the IOMMUFD framework for nested translation. Nested
> translation is a hardware feature that supports two-stage translation
> tables for IOMMU. The second-stage translation table is managed by the
> host VMM, while the first-stage translation table is owned by user
> space. This allows user space to control the IOMMU mappings for its
> devices.
> 
> When an IO page fault occurs on the first-stage translation table, the
> IOMMU hardware can deliver the page fault to user space through the
> IOMMUFD framework. User space can then handle the page fault and respond
> to the device top-down through the IOMMUFD. This allows user space to
> implement its own IO page fault handling policies.
> 
> User space indicates its capability of handling IO page faults by
> setting the IOMMU_HWPT_ALLOC_IOPF_CAPABLE flag when allocating a
> hardware page table (HWPT). IOMMUFD will then set up its infrastructure
> for page fault delivery. On a successful return of HWPT allocation, the
> user can retrieve and respond to page faults by reading and writing to
> the file descriptor (FD) returned in out_fault_fd.

This is probably backwards, userspace should allocate the FD with a
dedicated ioctl and provide it during domain allocation.

If the userspace wants a fd per domain then it should do that. If it
wants to share fds between domains that should work too.

Jason
