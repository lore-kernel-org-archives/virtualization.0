Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16143EB64D9
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 18:33:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 678A8405F5;
	Mon, 26 Jun 2023 18:33:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 678A8405F5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=JVUAS6Mw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h2GByad08722; Mon, 26 Jun 2023 18:33:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E313A400C6;
	Mon, 26 Jun 2023 18:33:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E313A400C6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69CA8C007A;
	Mon, 26 Jun 2023 18:33:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0611C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 18:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EF16740347
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 18:33:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EF16740347
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DusAaBe6YrOC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 18:33:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 68F65400C6
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 68F65400C6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 18:33:20 +0000 (UTC)
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-4718aa39ee6so1000494e0c.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 11:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1687804399; x=1690396399;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Llh4gIlToO5IIgOre9UJS/YUO0ldCTUXip1sWklWSMQ=;
 b=JVUAS6Mwd4CGVgbTg2A/4nZBcOTwKzPyRt4TC3yOvNM2+tIbS6xPD0y0D61ppUoIqP
 kZrkBWOA7Ql4ra0BfHP6nORKavSIwwHUciNKkQa/xmCuLHQQU0FKrjqNuDpFFUV2WhAs
 bj0vBswCZ/jeImDakg37V6RL9mG+1bVuMZuVcmiIwOAR2fw7RzomjAA6nEM2czoRF5T3
 UfxPt3ZwyqtBl2AfZC59Q6h21ylliaEpNdI5EVodei9o/wAyUMzWRcPPeO/chWAPw5Vz
 /ewQOBhvCVgbaU8C2DAN4F+GwhoddBQvjmntOXBFEFx01mMP8Ky6gACQ9gm16ROU2eWf
 tjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687804399; x=1690396399;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Llh4gIlToO5IIgOre9UJS/YUO0ldCTUXip1sWklWSMQ=;
 b=lnEi4FcyBKBzY1pFEkB+uq63AE+CleAmut43I3qPxJ2DQsUu89mWKyuSS20jXkC5z9
 btaVsAwEdwSpCAtI7pebujC0+gJXtCga5Za2gBfiUcnnpwCncxjtuRYawpA/t5RoyvhI
 o81T+M2pz4ruTpnMRn88hTIhrRYWRcUktWiO/g0A49RaiR7NH/GvtutdL4PO6jhXp1Vq
 oDp5PY1zO+Y5gDQwQPrN4Hngc42S2KU5h1NbcfgjvfvJo6sjRzShnb+djs7CI/76Y5Ze
 74brQOsiVpqZi2zMvZTXpkJZ+X8PHbGZvF3GaoaCUoOVAysRfe9FOdWL2sCdUncZGt5W
 +9hg==
X-Gm-Message-State: AC+VfDz8ffgRUoQTMb8Jj2UBWtnEUJeKLPMHTgCiX6LWLRkJCbNHe1dX
 n4JmLGIy/qPowjXC/Xra0moAKw==
X-Google-Smtp-Source: ACHHUZ71l/DblDrK7Oyn3lB5D1oIYfT7tQ+BssB+t+iwqPFJMSrWpCc/dst5XGo0zmyM+elBVv+q6Q==
X-Received: by 2002:a1f:3fca:0:b0:471:5939:f4f2 with SMTP id
 m193-20020a1f3fca000000b004715939f4f2mr9532857vka.8.1687804399118; 
 Mon, 26 Jun 2023 11:33:19 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.25.194]) by smtp.gmail.com with ESMTPSA id
 z24-20020ac875d8000000b003fddd8e7bbasm3348807qtq.30.2023.06.26.11.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 11:33:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
 (envelope-from <jgg@ziepe.ca>) id 1qDr1Z-008pJc-JP;
 Mon, 26 Jun 2023 15:33:17 -0300
Date: Mon, 26 Jun 2023 15:33:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCHES 00/17] IOMMUFD: Deliver IO page faults to user space
Message-ID: <ZJnZ7bEIZHsqmyAG@ziepe.ca>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
 <ZHZFi28jRxeZMKK3@Asurada-Nvidia>
 <a8ccbac8-c456-d116-24a2-7503ccbb720c@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a8ccbac8-c456-d116-24a2-7503ccbb720c@linux.intel.com>
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

On Sun, Jun 25, 2023 at 02:30:46PM +0800, Baolu Lu wrote:

> Agreed. We should avoid workqueue in sva iopf framework. Perhaps we
> could go ahead with below code? It will be registered to device with
> iommu_register_device_fault_handler() in IOMMU_DEV_FEAT_IOPF enabling
> path. Un-registering in the disable path of cause.

This maze needs to be undone as well.

It makes no sense that all the drivers are calling 

 iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);

The driver should RX a PRI fault and deliver it to some core code
function, this looks like a good start:

> static int io_pgfault_handler(struct iommu_fault *fault, void *cookie)
> {
>         ioasid_t pasid = fault->prm.pasid;
>         struct device *dev = cookie;
>         struct iommu_domain *domain;
> 
>         if (fault->type != IOMMU_FAULT_PAGE_REQ)
>                 return -EOPNOTSUPP;
> 
>         if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID)
>                 domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
>         else
>                 domain = iommu_get_domain_for_dev(dev);
> 
>         if (!domain || !domain->iopf_handler)
>                 return -ENODEV;
> 
>         if (domain->type == IOMMU_DOMAIN_SVA)
>                 return iommu_queue_iopf(fault, cookie);
> 
>         return domain->iopf_handler(fault, dev, domain->fault_data);

Then we find the domain that owns the translation and invoke its
domain->ops->iopf_handler()

If the driver created a SVA domain then the op should point to some
generic 'handle sva fault' function. There shouldn't be weird SVA
stuff in the core code.

The weird SVA stuff is really just a generic per-device workqueue
dispatcher, so if we think that is valuable then it should be
integrated into the iommu_domain (domain->ops->use_iopf_workqueue =
true for instance). Then it could route the fault through the
workqueue and still invoke domain->ops->iopf_handler.

The word "SVA" should not appear in any of this.

Not sure what iommu_register_device_fault_handler() has to do with all
of this.. Setting up the dev_iommu stuff to allow for the workqueue
should happen dynamically during domain attach, ideally in the core
code before calling to the driver.

Also, I can understand there is a need to turn on PRI support really
early, and it can make sense to have some IOMMU_DEV_FEAT_IOPF/SVA to
ask to turn it on.. But that should really only be needed if the HW
cannot turn it on dynamically during domain attach of a PRI enabled
domain.

It needs cleaning up..

Jason
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
