Return-Path: <SRS0=MQJa=KV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03C3C47082
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 10:04:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A3D7613B6
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 10:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3D7613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ECF5282B51;
	Wed, 26 May 2021 10:04:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a4PO3ZtN08pb; Wed, 26 May 2021 10:04:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9385B82B97;
	Wed, 26 May 2021 10:04:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 301F3C0001;
	Wed, 26 May 2021 10:04:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A261C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 10:04:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1A0D440208
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 10:04:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Xybl3XppvQV
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 10:04:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BD36D400CA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 10:04:23 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id gb17so1484897ejc.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 03:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=6vKl5wXX6m3B8S615pg0hNiDymSmdGcKHVZ5IanzTbQ=;
 b=RvdlZigy0NWOWJ5IX5kOqv4M+9H8owkJpPuwqCEa0ZFeXMQvC2wnCU0G1XLX2Oh6Qc
 UAXeaBKUhYPqs1/d/mttTaGZGK9zKg+9e4AxltWH+fx4279o+OGKgeEKOSqFliABtgMd
 F5RxumrPAmjoNhm4FfbM/nnmwiar30lyihH6qjQ/l9AeaQfwTFxDUQ5ihdPJQg49O5EB
 xqKeQmK8Hhze3vM0He32bxgYZrIYVzF1W6r7Zf3YaPHaylVedwvZbQi2Ub/EoitPSdKS
 9isi5bRJBqy0mWSlA6p4kk3B9OZH1XzUFbOe0Q2MUXOGJckm8xFm2WR4gOBvIf1ClDZb
 zwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6vKl5wXX6m3B8S615pg0hNiDymSmdGcKHVZ5IanzTbQ=;
 b=pQCqGRFv0e5LrxXmNPj6ujhTpXCw7gZcXKqq58TypJOZbLo3RhU17CEcSRrG8TkMlU
 E3rhenq35ncUP3v8nrMq1sJUBTTi0avcvztlZ5+vyCR5P3Mtr1lXVP0SthEUX164l++4
 ImX+fTkwntFQJ67RgpT0y2/m+EgWPFhufBsQGnFT9SLooYGVGA3ZbYg33/9M5vA04yAQ
 a2ZnoRAisCQWWhdgtWC/eQNKv2+Z/0BHVHxWO5hEamb01u8QVuWrz5F+4hg8eTJ+AL0n
 XCWzsZpIpTMEqAaSP4oZVIApIX4lwzESYtUqQqD28JafgMRZxYTePd8ffU9SECZE1yX8
 MepQ==
X-Gm-Message-State: AOAM533M+FR4TVol/EV66tdzNm7PbsizF5AOoiARq6TevEL0Of5M9YI9
 y/4XX87VcFmWCPjWW0dKe2WB9A==
X-Google-Smtp-Source: ABdhPJyikgVRUFu3nC9T4AMVWatJFwbVikBSeD8fXfrM/F9mmEI89dlrOXNO+Hf2sPTVJ5KE1IhXEQ==
X-Received: by 2002:a17:906:7f06:: with SMTP id
 d6mr32984690ejr.189.1622023461876; 
 Wed, 26 May 2021 03:04:21 -0700 (PDT)
Received: from myrica (adsl-84-226-106-126.adslplus.ch. [84.226.106.126])
 by smtp.gmail.com with ESMTPSA id j4sm9339398edq.13.2021.05.26.03.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 03:04:21 -0700 (PDT)
Date: Wed, 26 May 2021 12:04:03 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 3/6] ACPI: Add driver for the VIOT table
Message-ID: <YK4dE+46ukG1Gcza@myrica>
References: <20210423113836.3974972-1-jean-philippe@linaro.org>
 <20210423113836.3974972-4-jean-philippe@linaro.org>
 <CAJZ5v0hoM-y2ajCVx8y4pXdPgAiNUBU6NUZ9m==NiVH8QcvWtw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hoM-y2ajCVx8y4pXdPgAiNUBU6NUZ9m==NiVH8QcvWtw@mail.gmail.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Robin Murphy <robin.murphy@arm.com>, virtualization@lists.linux-foundation.org,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 sebastien.boeuf@intel.com, Eric Auger <eric.auger@redhat.com>,
 Hanjun Guo <guohanjun@huawei.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>
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

On Fri, May 21, 2021 at 06:39:24PM +0200, Rafael J. Wysocki wrote:
> > diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
> > new file mode 100644
> > index 000000000000..710e5a5eac70
> > --- /dev/null
> > +++ b/drivers/acpi/viot.c
> > @@ -0,0 +1,350 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Virtual I/O topology
> 
> In the first place, more information on what this is all about, please.
> 
> What it does and how it is used.

Sure, I can add:

 *
 * The Virtual I/O Translation Table (VIOT) describes the topology of
 * para-virtual IOMMUs and the endpoints they manage. The OS uses it to
 * initialize devices in the right order, preventing endpoints from
 * issuing DMA before their IOMMU is ready. 
 *
 * When binding a driver to a device, before calling the device driver's
 * probe() method, the driver infrastructure calls dma_configure(). At
 * that point the VIOT driver looks for an IOMMU associated to the device
 * in the VIOT table. If an IOMMU exists and has been initialized, the
 * VIOT driver initializes the device's IOMMU fwspec, allowing the DMA
 * infrastructure to invoke the IOMMU ops when the device driver
 * configures DMA mappings. If an IOMMU exists and hasn't yet been
 * initialized, VIOT returns -EPROBE_DEFER to postpone probing the device
 * until the IOMMU is available.
 */

Thanks,
Jean
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
