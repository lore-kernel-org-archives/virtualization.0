Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B691D529
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ewam7RU0"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 297874012B
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 13:43:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 297874012B
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ewam7RU0
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OGy_rX8qcFAb
	for <virtualization@lists.linux-foundation.org>;
	Fri,  8 Dec 2023 13:43:20 +0000 (UTC)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 27A49400CB
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 13:43:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 27A49400CB
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-77f37772ab6so97263985a.0
        for <virtualization@lists.linux-foundation.org>; Fri, 08 Dec 2023 05:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702042999; x=1702647799; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5aDtOWyPfn3w5tEvf3D6QXjzQ1IFO5OBYuP3/lTcT5U=;
        b=ewam7RU07DatAQHksdkUyJYHMGc+ATKLTOmwNJ0RXbCoeisIIWw2mEV3ErJaUFelkp
         9tg9pV5SllwlnRS/1YJX1fNOvG82pvXKFfstVVVnOHBvplK5ZsM3KkAiMN5zHJ4hGn95
         hlKOnvZYJwMF3Sn3Nszoe55NDujS8ZI+EzBmFV2e8FyhALGlMhES0yTrbTTfJqEGhn7r
         BZZTMwyGSFDjdEG/r7X34KGFUjCQz/gC3KQwjW8CjILNLo+Sbo2FTpLp4mQg9ztAd68U
         J2xEyJy7vZ6HfnQvAim/E0ez3PRAF76VJ301pdhTqlQQs3Z5nt4XO4wwc/8H8+sjbNQ5
         VcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702042999; x=1702647799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aDtOWyPfn3w5tEvf3D6QXjzQ1IFO5OBYuP3/lTcT5U=;
        b=htkFjxeUX/GWtjRIRhFwj+F2uMrbHXc4ISrytBSCcYXUS/8cff9sL/M/6IhbTpYS6K
         TDMU8mdph13J9vBq6V9nKeUH8fmjOjwPqOZb8oIDX13sbTzvI/kWWu1JuClbLRguyAQF
         IEDxy9Q/cELk1Wmv6I4QpTTj9bH5RxKI50HhULOj6u8+8EOh9b9vCtM+6oX8KH62AIAz
         MaZYyVE4T90RFX+L2gHEDHQeSjG1Iz6+L2f6wA8hzfEzAm+pQAGF6DeaCdlNopCFIFH2
         RJK+iVJfsMt+umA7RN/u/fqpUZG958obMS1Vv1ZpKuL5Pc47cU2uR8UBtdLt0SVxRwTT
         PlQA==
X-Gm-Message-State: AOJu0YwtcWfRE1W/cqqNn99zVcSyP50CwheubcBU4SMsSepO6pnD4EYV
	wgHojeTyuOE52FRrJUEuV0kprA==
X-Google-Smtp-Source: AGHT+IHv12Tb/0Ej5uN/WlXa3rS44BxBF06RODHchs+ChcBQjqI7N5TgNevBZ3fMHu6sl89MwDK8fg==
X-Received: by 2002:a05:6214:e87:b0:67a:a721:b1be with SMTP id hf7-20020a0562140e8700b0067aa721b1bemr5609000qvb.121.1702042998853;
        Fri, 08 Dec 2023 05:43:18 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id a19-20020a0cefd3000000b0067abb3f1ad0sm804745qvt.92.2023.12.08.05.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 05:43:18 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rBb8P-00C89F-TH;
	Fri, 08 Dec 2023 09:43:17 -0400
Date: Fri, 8 Dec 2023 09:43:17 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Message-ID: <20231208134317.GX1489931@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231201142427.GJ1394392@ziepe.ca>
 <46c80b4e-9f05-4fb2-a31d-7386a41c895a@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46c80b4e-9f05-4fb2-a31d-7386a41c895a@linux.intel.com>

On Fri, Dec 08, 2023 at 01:57:26PM +0800, Baolu Lu wrote:
> On 12/1/23 10:24 PM, Jason Gunthorpe wrote:
> > On Thu, Oct 26, 2023 at 10:49:24AM +0800, Lu Baolu wrote:
> > > Hi folks,
> > > 
> > > This series implements the functionality of delivering IO page faults to
> > > user space through the IOMMUFD framework for nested translation. Nested
> > > translation is a hardware feature that supports two-stage translation
> > > tables for IOMMU. The second-stage translation table is managed by the
> > > host VMM, while the first-stage translation table is owned by user
> > > space. This allows user space to control the IOMMU mappings for its
> > > devices.
> > > 
> > > When an IO page fault occurs on the first-stage translation table, the
> > > IOMMU hardware can deliver the page fault to user space through the
> > > IOMMUFD framework. User space can then handle the page fault and respond
> > > to the device top-down through the IOMMUFD. This allows user space to
> > > implement its own IO page fault handling policies.
> > > 
> > > User space indicates its capability of handling IO page faults by
> > > setting the IOMMU_HWPT_ALLOC_IOPF_CAPABLE flag when allocating a
> > > hardware page table (HWPT). IOMMUFD will then set up its infrastructure
> > > for page fault delivery. On a successful return of HWPT allocation, the
> > > user can retrieve and respond to page faults by reading and writing to
> > > the file descriptor (FD) returned in out_fault_fd.
> > 
> > This is probably backwards, userspace should allocate the FD with a
> > dedicated ioctl and provide it during domain allocation.
> 
> Introducing a dedicated fault FD for fault handling seems promising. It
> decouples the fault handling from any specific domain. I suppose we need
> different fault fd for recoverable faults (a.k.a. IO page fault) and
> unrecoverable faults. Do I understand you correctly?

I haven't thought that far ahead :) Once you have a generic fault FD
concept it can be sliced in different ways. If there is a technical
need to seperate recoverable/unrecoverable then the FD flavour should
be specified during FD creation. Otherwise just let userspace do
whatever it wants.

Jason
