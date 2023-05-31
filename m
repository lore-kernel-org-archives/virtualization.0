Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD15CC77B7A
	for <virtualization@archiver.kernel.org>; Wed, 31 May 2023 00:33:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50972607B0;
	Wed, 31 May 2023 00:33:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 50972607B0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=NSprOvAN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Im7fjFAHQd95; Wed, 31 May 2023 00:33:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A396A60615;
	Wed, 31 May 2023 00:33:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A396A60615
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68445C0037;
	Wed, 31 May 2023 00:33:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59FD7C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 00:33:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 34235408CC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 00:33:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 34235408CC
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca
 header.a=rsa-sha256 header.s=google header.b=NSprOvAN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VW_vlfkekXxP
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 00:33:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CA1C9408B1
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CA1C9408B1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 00:33:35 +0000 (UTC)
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-3f8115ca685so25003171cf.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 17:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1685493214; x=1688085214;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YxfeX6CjU1T6VFT6WQGkkGRNUy8IJFRL+Q8oTwikiYE=;
 b=NSprOvANr8rmmNMRfGUGQhrlbjOY3VNneKCREemdYMFsq+wZseIXs4cVn2cfctqTC4
 l/Fex2UztpB64Sv6bVKzNW2Qn0dqqb5NbD1cJWjIOn75Zk0NXfpMON7ItM9ydFy5Ew5U
 s1hUijdnCq5qu7Zs5EJmJe13GN3xQ65TBxqudO3SU+vn3Sqj6RrsWVsk2oCYcnPG3p84
 jQDN28rHXrMKZ637sGrN6F/CCcU4XEcphoJElhcnaXxrFBaFj8p/dlxWO0sR9zCxF7Dn
 z3eQ+08mRG3B2cvqFNdTFZputqdjR8OXMmJun0qCmRxWBxzTeKu07oZNguwRyhjTnf+2
 ghdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685493214; x=1688085214;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YxfeX6CjU1T6VFT6WQGkkGRNUy8IJFRL+Q8oTwikiYE=;
 b=NIN68PW4d3vHctXx4Nq4iuy6Xi+PEon8FVZ4mIfecQ1xm5VQYz+qJer1aCgFNaqXwz
 DfFZl/AryBS91oSWqMjduwE7Cqm1Qk1I7lSm4LJfCbEc0Isbwb7MJ01TWHQevY/jHH3Q
 12DNbbKpnIDTt0GdMBG44ZAiWSwAtB7l3YbkcRE6VrVT8GyMFgdZ2L9+dtyUEAT8ato3
 b87WAni+j8ey5ZplTGRZWOTMDWPbD4B+ljWYTGNGcBvdDpHIPMPZQjljjxlL6TnSa5Bf
 8x4TA8xvLwxkZodJ7N4uDE6T5ReqbQzeWYoiL+Z37tfOXNAJfKuBDUfyJE9Ir/iOuHND
 210Q==
X-Gm-Message-State: AC+VfDxUH98hLOK9EG5e09H6UC8kDKHvSfvl4sxseJdFLcNsQaeb+Wgx
 0LRBHIr7wqbCNGb4gzzwkZ5Srw==
X-Google-Smtp-Source: ACHHUZ76cGYRoxD2nR+OVC7+AsKBaaMRBv2OxrvCIPruwBslaqJO8TAA8q2yEjn3iVhl/m095jOZyA==
X-Received: by 2002:a05:622a:198f:b0:3f6:c52e:21bc with SMTP id
 u15-20020a05622a198f00b003f6c52e21bcmr4111272qtc.19.1685493214434; 
 Tue, 30 May 2023 17:33:34 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26]) by smtp.gmail.com with ESMTPSA id
 ff27-20020a05622a4d9b00b003f6bbd7863csm5256617qtb.86.2023.05.30.17.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 17:33:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
 (envelope-from <jgg@ziepe.ca>) id 1q49mO-000kYe-OG;
 Tue, 30 May 2023 21:33:32 -0300
Date: Tue, 30 May 2023 21:33:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCHES 00/17] IOMMUFD: Deliver IO page faults to user space
Message-ID: <ZHaV3GwYXCvfNUBn@ziepe.ca>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230530053724.232765-1-baolu.lu@linux.intel.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Yi Liu <yi.l.liu@intel.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
 linux-kselftest@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
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

On Tue, May 30, 2023 at 01:37:07PM +0800, Lu Baolu wrote:
> Hi folks,
> 
> This series implements the functionality of delivering IO page faults to
> user space through the IOMMUFD framework. The use case is nested
> translation, where modern IOMMU hardware supports two-stage translation
> tables. The second-stage translation table is managed by the host VMM
> while the first-stage translation table is owned by the user space.
> Hence, any IO page fault that occurs on the first-stage page table
> should be delivered to the user space and handled there. The user space
> should respond the page fault handling result to the device top-down
> through the IOMMUFD response uAPI.
> 
> User space indicates its capablity of handling IO page faults by setting
> a user HWPT allocation flag IOMMU_HWPT_ALLOC_FLAGS_IOPF_CAPABLE. IOMMUFD
> will then setup its infrastructure for page fault delivery. Together
> with the iopf-capable flag, user space should also provide an eventfd
> where it will listen on any down-top page fault messages.
> 
> On a successful return of the allocation of iopf-capable HWPT, a fault
> fd will be returned. User space can open and read fault messages from it
> once the eventfd is signaled.

This is a performance path so we really need to think about this more,
polling on an eventfd and then reading a different fd is not a good
design.

What I would like is to have a design from the start that fits into
io_uring, so we can have pre-posted 'recvs' in io_uring that just get
completed at high speed when PRIs come in.

This suggests that the PRI should be delivered via read() on a single
FD and pollability on the single FD without any eventfd.

> Besides the overall design, I'd like to hear comments about below
> designs:
> 
> - The IOMMUFD fault message format. It is very similar to that in
>   uapi/linux/iommu which has been discussed before and partially used by
>   the IOMMU SVA implementation. I'd like to get more comments on the
>   format when it comes to IOMMUFD.

We have to have the same discussion as always, does a generic fault
message format make any sense here?

PRI seems more likely that it would but it needs a big carefull cross
vendor check out.

Jason
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
