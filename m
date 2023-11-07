Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36C2C4332F
	for <virtualization@archiver.kernel.org>; Tue,  7 Nov 2023 17:54:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 54B4E41887;
	Tue,  7 Nov 2023 17:54:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 54B4E41887
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=chF8LrLk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wxBujtNzAZwJ; Tue,  7 Nov 2023 17:54:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1482E4169E;
	Tue,  7 Nov 2023 17:54:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1482E4169E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1D61C0039;
	Tue,  7 Nov 2023 17:54:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F22EC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 17:54:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DED6782016
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 17:54:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DED6782016
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca
 header.a=rsa-sha256 header.s=google header.b=chF8LrLk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sK5JG6kTVBop
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 17:54:08 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0AD8882015
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 17:54:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0AD8882015
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-41c157bbd30so37472691cf.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Nov 2023 09:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1699379647; x=1699984447;
 darn=lists.linux-foundation.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FW0RbAVGUFb+xdBElnhNAHeQGgYiHAEYAyCOW53R3XU=;
 b=chF8LrLkLLBl4IIvJdbhBzeAIMY1g54FtXrLIO/ey+JjXJVhGaaoREMahn/FUqekxx
 qe70HoA/hXpmBuwMz6eSt1qYfZ01JSzVwnzgZMRrgc+X9n/IRSns6zaqueOOw1aFR8br
 yAFT78Zr0bWOBhR6qXDqDR9bUrov3b/+2Az+1vS/QPzWyLGaHdhIpOiKN2FS2sgc8X/Z
 HPYOkcuY9jYYkexW76r4PsDmdsJDaAZ0yIWNPdZooxftQwIJ2IYyXMPG23aaHIPAAKO9
 pdxuvbWOCRXqh7M/STfIIj5MPZt38yUvh4+zOhGQCosqboR1+hFt6mDurL3BXrlhryF8
 di1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699379647; x=1699984447;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FW0RbAVGUFb+xdBElnhNAHeQGgYiHAEYAyCOW53R3XU=;
 b=A0QfhdFgsxtyQLwi8WMOc2dbFxiQZaZU6UePzZRzMA/RhthkyqMua9r0/ggrjaEKe1
 P6t5c4Ml6bXJOwm+t3AE4142smds2UeQOAp+jdbjuy6ynod7PYel2Rhu4w9Vz2+zJH8y
 XY5WORA+LepWujsz+PZ8Fe7rUt4o5q/ZyyVZ4sb8h7AGnLEa5qHZfz0hCDnhAJTJJxp0
 khSeVmXJiCeehef+NSK73pT2XCcJRs359+Fkrfq+9ot3BlxLIyOOWwTYF8MBtzs+Pevp
 4b8wl4if6zwzkzFTURS708xs2uH7JPZUnChlFyv122vMlBTFJ4LdgPrmoXKIUGk3epPg
 rC2g==
X-Gm-Message-State: AOJu0Yzw/d7GLaJTLLiYDnnAqZbMjwMUlvvFiPaERkHD5k+HQOY8740z
 G93HmxFcUwyhhitO32+LyScKXw==
X-Google-Smtp-Source: AGHT+IGQ+nRQt1M3ckW/OiQMHeS7z9x+pfYfws+XnYXuooXgVjVCkYIWxzYut+7AHyoqub3WHSQdKw==
X-Received: by 2002:a05:622a:d2:b0:41c:e76e:87f8 with SMTP id
 p18-20020a05622a00d200b0041ce76e87f8mr38242554qtw.34.1699379646766; 
 Tue, 07 Nov 2023 09:54:06 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.26.201]) by smtp.gmail.com with ESMTPSA id
 a10-20020ac8720a000000b004181d77e08fsm107696qtp.85.2023.11.07.09.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 09:54:06 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
 (envelope-from <jgg@ziepe.ca>) id 1r0QH7-001YR3-Ob;
 Tue, 07 Nov 2023 13:54:05 -0400
Date: Tue, 7 Nov 2023 13:54:05 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Message-ID: <20231107175405.GD4634@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231102124742.GA4634@ziepe.ca>
 <BN9PR11MB5276B1582CED568795725C198CA9A@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276B1582CED568795725C198CA9A@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Liu,
 Yi L" <yi.l.liu@intel.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Lu Baolu <baolu.lu@linux.intel.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Nov 07, 2023 at 08:35:10AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Thursday, November 2, 2023 8:48 PM
> >
> > On Thu, Oct 26, 2023 at 10:49:24AM +0800, Lu Baolu wrote:
> > > Hi folks,
> > >
> > > This series implements the functionality of delivering IO page faults to
> > > user space through the IOMMUFD framework for nested translation.
> > Nested
> > > translation is a hardware feature that supports two-stage translation
> > > tables for IOMMU. The second-stage translation table is managed by the
> > > host VMM, while the first-stage translation table is owned by user
> > > space. This allows user space to control the IOMMU mappings for its
> > > devices.
> > 
> > Having now looked more closely at the ARM requirements it seems we
> > will need generic events, not just page fault events to have a
> > complete emulation.
> 
> Can you elaborate?

There are many events related to object in guest memory or controlled
by the guest, eg C_BAD_CD and C_BAD_STE. These should be relayed or
the emulation is not working well.

> > > User space indicates its capability of handling IO page faults by
> > > setting the IOMMU_HWPT_ALLOC_IOPF_CAPABLE flag when allocating a
> > > hardware page table (HWPT). IOMMUFD will then set up its infrastructure
> > > for page fault delivery. On a successful return of HWPT allocation, the
> > > user can retrieve and respond to page faults by reading and writing to
> > > the file descriptor (FD) returned in out_fault_fd.
> > 
> > This is the right way to approach it, and more broadly this shouldn't
> > be an iommufd specific thing. Kernel drivers will also need to create
> > fault capable PAGING iommu domains.
> 
> Are you suggesting a common interface used by both iommufd and
> kernel drivers?

Yes
 
> but I didn't get the last piece. If those domains are created by kernel
> drivers why would they require a uAPI for userspace to specify fault
> capable?

Not to userspace, but a kapi to request a fault capable domain and to
supply the fault handler. Eg:

 iommu_domain_alloc_faultable(dev, handler);

Jason
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
