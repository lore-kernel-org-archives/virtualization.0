Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD367633
	for <virtualization@lists.linux-foundation.org>; Tue, 21 Nov 2023 00:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="n/NnZZa3"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 766EB60EF4
	for <virtualization@lists.linux-foundation.org>; Tue, 21 Nov 2023 00:14:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 766EB60EF4
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=n/NnZZa3
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aHvcy_p9OV0J
	for <virtualization@lists.linux-foundation.org>;
	Tue, 21 Nov 2023 00:14:55 +0000 (UTC)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2287F60EC8
	for <virtualization@lists.linux-foundation.org>; Tue, 21 Nov 2023 00:14:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2287F60EC8
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-58a42c3cbb8so2838035eaf.3
        for <virtualization@lists.linux-foundation.org>; Mon, 20 Nov 2023 16:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1700525694; x=1701130494; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cM4nXDiFJOID9V8g8m4rSnX0D2eYIgzoLqQUP7X4x5w=;
        b=n/NnZZa3hu22jmx+2DVFxkuVjlY63yGzJ242YIgGyDTFRpRCB7YtrzrDdF5if0Drak
         CAtqbr42G4Urz5eDcI143sjZLwVh01bxsLKO+7RetaBTlAKmu3iFD45u3bwHg0/vOiX3
         HdyMylObkEvAH0rnVBdMabnFUfsAtLcusKCRRIp7ndAYKde9+NIK/ODxRdG2/GX5Jq3O
         neANT0KjTh7+RU60NzPbHATrhflOCOKcy7OqOZBQzN4sXo02gaF1USwV1bCewrV92hum
         00A8pobPq9X2Y/Vf4wklZtuFQqWdqBz6r7un7oxC4vX2Ld4n7u5fsHvoY9CdHCeLkC79
         /cYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700525694; x=1701130494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cM4nXDiFJOID9V8g8m4rSnX0D2eYIgzoLqQUP7X4x5w=;
        b=XT10/p52DscZs/8JTOKFyYcv2jWNjyOgxsbNa9FaXa1ICer+npi6IO6S3TRmTVX9FD
         ERyVMQKLtDG7oXVQtsfnI1zCyjdKf8kI9uyH12SxAY8RRlIuO5rQgxn+ujBQD/Yi/ZSJ
         rxzpQYC1txPW6V+D0KIYZj88mVf7aajTsnXeVTQaH+67qw7yTdk3NAnYM8JMpKAmo9Ek
         E5iqNiKaPPbzXjzzxsu/hYgb91vA5duw1Jwx5VmoXT+0/dllgRCRKRxkzNW0DdPFllje
         PQ02cvnd6EXbyCqZY/2V9KH207afUqYS3Guo5/iABbQXolMSR27po0odkXHFHTEpUYJA
         RIbA==
X-Gm-Message-State: AOJu0YxBifP0YhMKyqGr/joGgOwvwBOojZVCm20kIA02lnz5CE15lVlB
	3fZbqQ2IoIPStZl6L8hdRtOzuQ==
X-Google-Smtp-Source: AGHT+IHCW/gnwvCFARN/IZLYIino35BqbfjASz8DDrzzSvjMWgTO3xenCZoSHE50H7LZjgQneLoOoA==
X-Received: by 2002:a05:6820:1628:b0:581:ed12:98c6 with SMTP id bb40-20020a056820162800b00581ed1298c6mr10069537oob.4.1700525694024;
        Mon, 20 Nov 2023 16:14:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id w9-20020a4aaf09000000b005840b5783a1sm1569061oon.43.2023.11.20.16.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 16:14:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r5EPk-0019u1-1E;
	Mon, 20 Nov 2023 20:14:52 -0400
Date: Mon, 20 Nov 2023 20:14:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Liu, Jing2" <jing2.liu@linux.intel.com>
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
Message-ID: <20231121001452.GF10140@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231102124742.GA4634@ziepe.ca>
 <c774e157-9b47-4fb8-80dd-37441c69b43d@linux.intel.com>
 <ZVTObiybC1MYlSam@ziepe.ca>
 <8f24918e-aa57-4160-902a-58d10021246e@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f24918e-aa57-4160-902a-58d10021246e@linux.intel.com>

On Thu, Nov 16, 2023 at 09:42:23AM +0800, Liu, Jing2 wrote:
> Hi Jason,
> 
> On 11/15/2023 9:58 PM, Jason Gunthorpe wrote:
> > On Wed, Nov 15, 2023 at 01:17:06PM +0800, Liu, Jing2 wrote:
> > 
> > > This is the right way to approach it,
> > > 
> > >     I learned that there was discussion about using io_uring to get the
> > >     page fault without
> > > 
> > >     eventfd notification in [1], and I am new at io_uring and studying the
> > >     man page of
> > > 
> > >     liburing, but there're questions in my mind on how can QEMU get the
> > >     coming page fault
> > > 
> > >     with a good performance.
> > > 
> > >     Since both QEMU and Kernel don't know when comes faults, after QEMU
> > >     submits one
> > > 
> > >     read task to io_uring, we want kernel pending until fault comes. While
> > >     based on
> > > 
> > >     hwpt_fault_fops_read() in [patch v2 4/6], it just returns 0 since
> > >     there's now no fault,
> > > 
> > >     thus this round of read completes to CQ but it's not what we want. So
> > >     I'm wondering
> > > 
> > >     how kernel pending on the read until fault comes. Does fops callback
> > >     need special work to
> > Implement a fops with poll support that triggers when a new event is
> > pushed and everything will be fine.
> 
> Does userspace need also setup a POLL flag to let io_uring go into poll, or
> io_uring always try to poll?

io_uring can trigger poll and use other approaches, it is flexible the
driver can scale this in different ways.

Jason
