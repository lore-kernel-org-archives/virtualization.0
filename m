Return-Path: <SRS0=Tn2H=KJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807ADC433B4
	for <virtualization@archiver.kernel.org>; Fri, 14 May 2021 12:35:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25B416145B
	for <virtualization@archiver.kernel.org>; Fri, 14 May 2021 12:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B416145B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E3B8460AC9;
	Fri, 14 May 2021 12:35:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8hU7XHABXjNn; Fri, 14 May 2021 12:35:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A76560AE1;
	Fri, 14 May 2021 12:35:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D669C000E;
	Fri, 14 May 2021 12:35:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8C3CC0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 12:35:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C876660AEE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 12:35:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a55kcMpk5xRZ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 12:35:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D059160AC9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 12:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620995748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4A2APivfcyDaCt/06VnummJz8bYOcJRXXs3FFpQO3XU=;
 b=DR8350E5faQ7MzMSnkOahdHjYXiCViQSRTV+8/uWnf5Wroy3AkLlB5epAqp8pt8crF082w
 4j8zDi8Rqg4jbWXoKPsUA2Uw5487GxUUFjXIgBApPTmD8fGITFTK5NrbN1COOvD5PC1vum
 bQ3N+TZxysCOanY19VGYKy7axJVpvLw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-LG-SACVoNcKLrugXFRDz6Q-1; Fri, 14 May 2021 08:35:34 -0400
X-MC-Unique: LG-SACVoNcKLrugXFRDz6Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 g206-20020a1c39d70000b029016ac627fbe9so824112wma.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 05:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4A2APivfcyDaCt/06VnummJz8bYOcJRXXs3FFpQO3XU=;
 b=HL4kMI/a1AsV2sy88mT3GZe2u0kRNiMMh/D405Kau49mRLcNgUboDbckd/VrO0+f8U
 YzLbdOBUZeKFK15feKv+dhrFMybpdSh1dWrIGgAx/BjBC3pNzSNEbFEXgqCFDt5BjEhq
 /sJAJaFLPcRqk5zeVV6eUujSXiwcXKjnLyuN24cZNyN910vQOc1uCewZ3iMgIp8bKZ/O
 rVUTttvz9Ug3jsoFChv1pnjKZh+c3laiKpOPXEsD0aZSIwEJB9MXFRZBiN6TbNbxXgEk
 aODO6T3Nt4GV33BsyTDX1ab7xoIEeee1n7CDHQNCW70uJ2StUZC/vrmb+84F6DqieXYh
 7Eww==
X-Gm-Message-State: AOAM530o5/d3w5+xc+s58mr68/TmA6cZnir1y8rjKyto+Zb9u+zzeDbA
 4CC4JQsXK/rBFzuT4DyTGUWbGLAGK/XOy8z9XRsrsyl2TVeDk9jJfd7BOz316+wcMvy1R0K0gL3
 ilbtgavWXERDwr22vdrcYwu+tFpxsuIsLPG5/ddu5Kg==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr49597660wmc.90.1620995733553; 
 Fri, 14 May 2021 05:35:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjfU7fJ2sLn26ewhol2WN23VUlfrplBITfOMhtu8CSpXBAXmHZPIuRLwrEYMB8vP4IQNrraA==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr49597643wmc.90.1620995733363; 
 Fri, 14 May 2021 05:35:33 -0700 (PDT)
Received: from redhat.com ([2a10:800c:1fa6:0:3809:fe0c:bb87:250e])
 by smtp.gmail.com with ESMTPSA id q27sm2855356wrz.79.2021.05.14.05.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 May 2021 05:35:32 -0700 (PDT)
Date: Fri, 14 May 2021 08:35:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v2 0/6] Add support for ACPI VIOT
Message-ID: <20210514083449-mutt-send-email-mst@kernel.org>
References: <20210423113836.3974972-1-jean-philippe@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20210423113836.3974972-1-jean-philippe@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lorenzo.pieralisi@arm.com, eric.auger@redhat.com, catalin.marinas@arm.com,
 joro@8bytes.org, sudeep.holla@arm.com, rjw@rjwysocki.net, robin.murphy@arm.com,
 virtualization@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com,
 guohanjun@huawei.com, lenb@kernel.org, will@kernel.org, dwmw2@infradead.org,
 linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com
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

On Fri, Apr 23, 2021 at 01:38:31PM +0200, Jean-Philippe Brucker wrote:
> Add a driver for the ACPI VIOT table, which provides topology
> information for para-virtual platforms. Enable virtio-iommu on
> non-devicetree platforms, including x86.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Mostly ACPI stuff so I assume it's best to merge through that tree.

> Since v1 [1]:
> * The VIOT header definitions have been picked for v5.13
> * Share more code with IORT. Patches 1 and 2 extract the common code
>   from IORT.
> * Simplify the VIOT driver. Use the existing fwnode infrastructure
>   instead of adding hooks to the IOMMU driver.
> 
> You can find a QEMU implementation at [2], with extra support for
> testing all VIOT nodes including MMIO-based endpoints and IOMMU. This
> series, based on linux-next, is at [3]
> 
> [1] https://lore.kernel.org/linux-iommu/20210316191652.3401335-1-jean-philippe@linaro.org/
> [2] https://jpbrucker.net/git/qemu/log/?h=virtio-iommu/acpi
> [3] https://jpbrucker.net/git/linux/log/?h=virtio-iommu/acpi
> 
> Jean-Philippe Brucker (6):
>   ACPI: arm64: Move DMA setup operations out of IORT
>   ACPI: Move IOMMU setup code out of IORT
>   ACPI: Add driver for the VIOT table
>   iommu/dma: Pass address limit rather than size to
>     iommu_setup_dma_ops()
>   iommu/dma: Simplify calls to iommu_setup_dma_ops()
>   iommu/virtio: Enable x86 support
> 
>  drivers/acpi/Kconfig         |   3 +
>  drivers/iommu/Kconfig        |   4 +-
>  drivers/acpi/Makefile        |   2 +
>  drivers/acpi/arm64/Makefile  |   1 +
>  include/acpi/acpi_bus.h      |   3 +
>  include/linux/acpi.h         |   3 +
>  include/linux/acpi_iort.h    |  14 +-
>  include/linux/acpi_viot.h    |  19 ++
>  include/linux/dma-iommu.h    |   4 +-
>  arch/arm64/mm/dma-mapping.c  |   2 +-
>  drivers/acpi/arm64/dma.c     |  50 +++++
>  drivers/acpi/arm64/iort.c    | 129 ++-----------
>  drivers/acpi/bus.c           |   2 +
>  drivers/acpi/scan.c          |  60 +++++-
>  drivers/acpi/viot.c          | 350 +++++++++++++++++++++++++++++++++++
>  drivers/iommu/amd/iommu.c    |   9 +-
>  drivers/iommu/dma-iommu.c    |  17 +-
>  drivers/iommu/intel/iommu.c  |  10 +-
>  drivers/iommu/virtio-iommu.c |   8 +
>  MAINTAINERS                  |   8 +
>  20 files changed, 548 insertions(+), 150 deletions(-)
>  create mode 100644 include/linux/acpi_viot.h
>  create mode 100644 drivers/acpi/arm64/dma.c
>  create mode 100644 drivers/acpi/viot.c
> 
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
