Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161B9EB64D7
	for <virtualization@archiver.kernel.org>; Wed, 28 Jun 2023 12:49:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8AE5E403C4;
	Wed, 28 Jun 2023 12:49:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8AE5E403C4
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=YkH3CQCp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XeQwDPOwv6GX; Wed, 28 Jun 2023 12:49:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1C69940223;
	Wed, 28 Jun 2023 12:49:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1C69940223
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E365BC007C;
	Wed, 28 Jun 2023 12:49:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57F61C0037
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 12:49:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1AA984094D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 12:49:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1AA984094D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca
 header.a=rsa-sha256 header.s=google header.b=YkH3CQCp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nDPAytQS1lVc
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 12:49:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2BCDB40145
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2BCDB40145
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 12:49:33 +0000 (UTC)
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7659dc74da1so315215685a.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 05:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1687956573; x=1690548573;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jfOsXJab4slJjnxwoDTS70GHD4a6XTLVcr8PMnR6dnU=;
 b=YkH3CQCpfgI7DsqXU/4gxSJnl/4Dx066SB/wOKx9jGovBXVNkQBpWrEiGpN14LRKGU
 XJdhd7gGhYYd2s8IlI5dlCV4sELnIWiL8LaNznLp/7rtjVBvIvDWkFfBP1BlP3guCvuS
 p8nBvCP6GX0qCxnAroaDo6uG9CstSg8xDAbARHcTTQu+CzYNQXPJD5dYMIcRagx5/XGl
 p1L2WSGYR1JaI8+wmV+sB41Ur9L9jeH54uCsAXjrgdC1cEzSTeAtajjtMHM6lUKraVEi
 FVicyhQPFGsP0rGMpltdkb2EwsYwRVpqjUG9sFmBfxBClAxh1Rq3zrKsK68ysEZeRw33
 tEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687956573; x=1690548573;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jfOsXJab4slJjnxwoDTS70GHD4a6XTLVcr8PMnR6dnU=;
 b=jjJ+FNVGwVwYjv2yXTMK2/UtWRqiErRb2WSsWV2UErvO9Edqus1H4hERnmAnPCNf/A
 iYUrm3KUphcBrUT73/AT8o4ytGFBOq8b/8mzXrWFeI7Rmm/XImKoIm4cGF5N65CNqJy9
 AZHk/muasZXozvchpttGbYw0rzdlGdvqJulfKuG5d2ifcc/U7hFqv+QJVU+fNVN76CWX
 w2gSOZKJgJUZVPcjmeEmsIKQEmPjfuc5LCpeO4DbhHCeEE8nAS2RrH0JCUXl0MawuTuY
 SfDckt4YpvidhNJ8MUE4FJzsF+bRp02l4vXs/9YI//GA5BmvFoL79X1diUi4reKtsyKq
 3eUg==
X-Gm-Message-State: AC+VfDydULBQF0izLzay5tPxBlJ5cLRWUObY5l6VpyT5PCVUXtKkqB2R
 W2woak6lcdezYeECA9/89ZsY2Q==
X-Google-Smtp-Source: ACHHUZ5VTYEuYZ18Yx3pf3BTkEN/W0B1f5+DHaQ0fxgwOjq0lP8R3ZMqT/sYgn+dLBdwLJd9PlzH/w==
X-Received: by 2002:a05:6214:f08:b0:623:6b1a:c5f1 with SMTP id
 gw8-20020a0562140f0800b006236b1ac5f1mr44056481qvb.4.1687956572852; 
 Wed, 28 Jun 2023 05:49:32 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.25.194]) by smtp.gmail.com with ESMTPSA id
 d19-20020a05620a141300b007653a7977e6sm5003782qkj.97.2023.06.28.05.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 05:49:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
 (envelope-from <jgg@ziepe.ca>) id 1qEUbz-009DhQ-F5;
 Wed, 28 Jun 2023 09:49:31 -0300
Date: Wed, 28 Jun 2023 09:49:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCHES 00/17] IOMMUFD: Deliver IO page faults to user space
Message-ID: <ZJwsW3eFy0bMhkOt@ziepe.ca>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
 <ZHZFi28jRxeZMKK3@Asurada-Nvidia>
 <a8ccbac8-c456-d116-24a2-7503ccbb720c@linux.intel.com>
 <ZJnZ7bEIZHsqmyAG@ziepe.ca>
 <26b97776-7ce5-51f6-77b7-0ce837aa7cca@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <26b97776-7ce5-51f6-77b7-0ce837aa7cca@linux.intel.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Yi Liu <yi.l.liu@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
 linux-kselftest@vger.kernel.org, Will Deacon <will@kernel.org>
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

On Wed, Jun 28, 2023 at 10:00:56AM +0800, Baolu Lu wrote:
> > If the driver created a SVA domain then the op should point to some
> > generic 'handle sva fault' function. There shouldn't be weird SVA
> > stuff in the core code.
> > 
> > The weird SVA stuff is really just a generic per-device workqueue
> > dispatcher, so if we think that is valuable then it should be
> > integrated into the iommu_domain (domain->ops->use_iopf_workqueue =
> > true for instance). Then it could route the fault through the
> > workqueue and still invoke domain->ops->iopf_handler.
> > 
> > The word "SVA" should not appear in any of this.
> 
> Yes. We should make it generic. The domain->use_iopf_workqueue flag
> denotes that the page faults of a fault group should be put together and
> then be handled and responded in a workqueue. Otherwise, the page fault
> is dispatched to domain->iopf_handler directly.

It might be better to have iopf_handler and
iopf_handler_work function pointers to distinguish to two cases.

> > Not sure what iommu_register_device_fault_handler() has to do with all
> > of this.. Setting up the dev_iommu stuff to allow for the workqueue
> > should happen dynamically during domain attach, ideally in the core
> > code before calling to the driver.
> 
> There are two pointers under struct dev_iommu for fault handling.
> 
> /**
>  * struct dev_iommu - Collection of per-device IOMMU data
>  *
>  * @fault_param: IOMMU detected device fault reporting data
>  * @iopf_param:  I/O Page Fault queue and data
> 
> [...]
> 
> struct dev_iommu {
>         struct mutex lock;
>         struct iommu_fault_param        *fault_param;
>         struct iopf_device_param        *iopf_param;
> 
> My understanding is that @fault_param is a place holder for generic
> things, while @iopf_param is workqueue specific.

Well, lets look

struct iommu_fault_param {
	iommu_dev_fault_handler_t handler;
	void *data;

These two make no sense now. handler is always iommu_queue_iopf. Given
our domain centric design we want the function pointer in the domain,
not in the device. So delete it.

	struct list_head faults;
	struct mutex lock;

Queue of unhandled/unacked faults? Seems sort of reasonable

> @iopf_param could be allocated on demand. (perhaps renaming it to a more
> meaningful one?) It happens before a domain with use_iopf_workqueue flag
> set attaches to a device. iopf_param keeps alive until device_release.

Yes

Do this for the iommu_fault_param as well, in fact, probably just put
the two things together in one allocation and allocate if we attach a
PRI using domain. I don't think we need to micro optimze further..
 
Jason
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
