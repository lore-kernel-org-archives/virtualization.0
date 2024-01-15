Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B2A1804E
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jan 2024 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LhudZ/VG"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD5746FC33
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jan 2024 17:59:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DD5746FC33
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=LhudZ/VG
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d3PJZwQ7D6Dn
	for <virtualization@lists.linux-foundation.org>;
	Mon, 15 Jan 2024 17:59:02 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B8D0C612B4
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jan 2024 17:59:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B8D0C612B4
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-68163449a36so3626266d6.2
        for <virtualization@lists.linux-foundation.org>; Mon, 15 Jan 2024 09:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1705341540; x=1705946340; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1wGaOr22tAz8ZsKDr+cBOsYsgD9Gp6tmTN5qVEUIqRw=;
        b=LhudZ/VG3m8LwE/f7rPXo67mzjN3lOELSpBkJoKig3FwQj0wviH+HFoOni/rfDhbl4
         9ZTF2cxFQKRPKOfCDLXYJORm24BlzJlv4M2qGNu3OWe3Ba4eyGpeHeAjt96alR5mQMlQ
         evODxVDeEyF/K9w70xfM1YBFMNfmrz60R53JCvSOY/Nw/GK2pbG7xYDJQWe/CL9zTBeW
         07mMl6YNPViSsUvqY6ogYn8nQLmrb9kSQKcZC3g7av1FVJeQJpcKu4s9EYz1XIcysiW7
         +G53lpCJXCVt9R9ZZwpwxFaEngtrTmlz7fUTg74d+eQXDqJM8BJCC3KQ9r/u4gWwdRwO
         ZfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705341540; x=1705946340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wGaOr22tAz8ZsKDr+cBOsYsgD9Gp6tmTN5qVEUIqRw=;
        b=OBzvFdduQ6JDy6TTDas7RYzZUc3FaLCJvzk1Nfj0t6P2ipPeaphcNl0Bt1Eb7+mKo8
         IeQcDWjOgs6UPYI1voNFS5J9W7gqd8w+P7LsSvy+DdNVlbh1JtW1d8xoyg77o2v97HJY
         xY8xd+QaBOyEVqLqp6VeYBsBPJRqP1dhrjRdP21rDIhRPFyRuTY3d501/qUYV5/LKy/0
         N7Ys29azHFkZ30jiYIqE7vQ3w7V+nv2NY+/Zti5ltbirgVjOLBsK6xsOk5dMzsI9sP85
         wa7Ohi6/X2mAG9+UnMQfTAPnnFCf7d6dElxObz+T6mpsFHCUn1KLsBF/4yXdZqWUEK8E
         EpAA==
X-Gm-Message-State: AOJu0Yx1wl40zZ6FT9j0r6pQobpeykJoR318wUg5108wtpFHTqG74UGC
	UPVaNzr2avmNKiDvBNxQkI5UCI67CatVpg==
X-Google-Smtp-Source: AGHT+IH3qvjmHpS/20mUo+xR0imhTBslJ6twopYzo9p1d1flQYlhOLrwJcWYbmGWgldNtbhvIF7Uzw==
X-Received: by 2002:a05:6214:518c:b0:67f:d236:5c0f with SMTP id kl12-20020a056214518c00b0067fd2365c0fmr7596556qvb.90.1705341540583;
        Mon, 15 Jan 2024 09:59:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d10-20020a0cfe8a000000b0067f454b5307sm3452291qvs.108.2024.01.15.09.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 09:59:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rPREh-003u0V-Kj;
	Mon, 15 Jan 2024 13:58:59 -0400
Date: Mon, 15 Jan 2024 13:58:59 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] iommufd: Deliver fault messages to user space
Message-ID: <20240115175859.GC50608@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-5-baolu.lu@linux.intel.com>
 <b822096cc3b441309d99832c587be25a@huawei.com>
 <20240115164723.GB50608@ziepe.ca>
 <b1663110e1ca4301834f403270357bea@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1663110e1ca4301834f403270357bea@huawei.com>

On Mon, Jan 15, 2024 at 05:44:13PM +0000, Shameerali Kolothum Thodi wrote:

> > If it is valid when userspace does read() then it should be valid when
> > userspace does write() too.
> > 
> > It is the only way the kernel can actually match request and response
> > here.
> 
> The kernel currently checks the pasid only if IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID
> is set.
> 
> https://lore.kernel.org/linux-iommu/20200616144712.748818-1-jean-philippe@linaro.org/
> 
> > So, I think you have a userspace issue to not provide the right
> > pasid??
> 
> This is not just ARM stall resume case, but for some PCI devices as well as per
> the above commit log. So do we really need to track this in userspace ?

Yes, these weird HW details should not leak into userspace.

The PASID is required on the read() side, userspace should provide it
on the write() side. It is trivial for it to do, there is no reason to
accommodate anything else.

Alternatively I'm wondering if we should supply a serial number to
userspace so it can match the request/response instead of relying on
guessing based on pasid/grpid?

Jason
