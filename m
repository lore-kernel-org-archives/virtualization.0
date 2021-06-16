Return-Path: <SRS0=d+i8=LK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64123C48BE5
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 12:40:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26D1F60249
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 12:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D1F60249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1DC3540254;
	Wed, 16 Jun 2021 12:40:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wE3kWwpHyujy; Wed, 16 Jun 2021 12:40:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AAE3240443;
	Wed, 16 Jun 2021 12:40:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3EF26C0025;
	Wed, 16 Jun 2021 12:40:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AB24C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 12:40:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 787644020C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 12:40:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dXqAjHiNkbFo
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 12:40:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1CB6E40141
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 12:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623847209;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ubsBv6f8Gfa2qgRyhsGa5AFvRPZ+U40JlVZfwTYe0kE=;
 b=IspAIRSF5MLfvSgrlk/9zo7P4Y6ElTeBMmxbscxifP5BJnleb1bwbnaZ7A1BKSXMoq8BFk
 ezDiPyfluXiorcOtD0h0V9NTXM9AezksmZ7+wf//3H/FwFvBIv5IqfKC/XuM6+NwTiMI/e
 z95SraD19jUqhk22we8t9P+JXcj06eo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-HJ4-tFl0M1Of5eOLGG12uQ-1; Wed, 16 Jun 2021 08:40:06 -0400
X-MC-Unique: HJ4-tFl0M1Of5eOLGG12uQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 n21-20020a7bcbd50000b02901a2ee0826aeso1245509wmi.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 05:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=ubsBv6f8Gfa2qgRyhsGa5AFvRPZ+U40JlVZfwTYe0kE=;
 b=Y2ZpDrVPeNGxSZLxFG6iVzPwiUyy6G/jWs2cOGXlhsAryVktqGS/GEasP+ALDv/lVp
 zMnS+BDzngZj2nJXeqjdYeBYPjmtqTjORHYYWCwm8ais8GyIbh8UMqefJp9gx9W1XDfU
 wITTpBcybMp3RCxo/Axla5iRD9G98OgT4NGhDEyy5Vo5anoPWsSbbi4zaZPFQkC211dn
 JzYqPUUtfOLobS71geSd1Z1e9mxrl9HhdrRRpNHLOm74YTdAuiiR2f6z2Nl3/J56pCS6
 OPMvdZXzXYcmtL0UIClWdImBLTI+8QTJ8FsHnmBSZ+j5mHlQ/JXxMS865hPXPYTfpStq
 g/+A==
X-Gm-Message-State: AOAM530FQDaIy9mnQ0NIsj29wRK68DFpFhwWPHuSRWcuLk0mbLmo/1AJ
 jD0medC21wyPyFwe5/ezSmjfYKLTh4TI3C6iGLSH6ae4dQQyNp7ASwP8JthCeSKOwCVmstaxupF
 g+szsl3JuE5WplFBOXPnVfHimxnjTvQ4OZHe8xNGBpw==
X-Received: by 2002:a5d:59af:: with SMTP id p15mr5235737wrr.292.1623847205720; 
 Wed, 16 Jun 2021 05:40:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5WQBLU4IKG9p3xxW0FVoOol8q9XU19Rj2M+rLCk3pLwV7dw9cSLzoXZeV3mgmVA67Soicyw==
X-Received: by 2002:a5d:59af:: with SMTP id p15mr5235693wrr.292.1623847205520; 
 Wed, 16 Jun 2021 05:40:05 -0700 (PDT)
Received: from [192.168.43.95] ([37.172.247.238])
 by smtp.gmail.com with ESMTPSA id v15sm4914297wmj.39.2021.06.16.05.40.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jun 2021 05:40:04 -0700 (PDT)
Subject: Re: [PATCH v4 0/6] Add support for ACPI VIOT
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, rjw@rjwysocki.net,
 lenb@kernel.org, joro@8bytes.org, mst@redhat.com
References: <20210610075130.67517-1-jean-philippe@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <883de842-d50a-53f9-7589-a6d20e913f2d@redhat.com>
Date: Wed, 16 Jun 2021 14:40:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210610075130.67517-1-jean-philippe@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, sudeep.holla@arm.com,
 robin.murphy@arm.com, virtualization@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, guohanjun@huawei.com, will@kernel.org,
 dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org,
 baolu.lu@linux.intel.com
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
Reply-To: eric.auger@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Jean,

On 6/10/21 9:51 AM, Jean-Philippe Brucker wrote:
> Add a driver for the ACPI VIOT table, which provides topology
> information for para-virtual IOMMUs. Enable virtio-iommu on
> non-devicetree platforms, including x86.
>
> Since v3 [1] I fixed a build bug for !CONFIG_IOMMU_API. Joerg offered to
> take this series through the IOMMU tree, which requires Acks for patches
> 1-3.
>
> You can find a QEMU implementation at [2], with extra support for
> testing all VIOT nodes including MMIO-based endpoints and IOMMU.
> This series is at [3].
>
> [1] https://lore.kernel.org/linux-iommu/20210602154444.1077006-1-jean-philippe@linaro.org/
> [2] https://jpbrucker.net/git/qemu/log/?h=virtio-iommu/acpi
> [3] https://jpbrucker.net/git/linux/log/?h=virtio-iommu/acpi

I tested the series on both aarch64 and x86_64 with qemu. It works for me.
Feel free to add my T-b.

Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

>
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
>  drivers/acpi/scan.c          |  78 +++++++-
>  drivers/acpi/viot.c          | 364 +++++++++++++++++++++++++++++++++++
>  drivers/iommu/amd/iommu.c    |   9 +-
>  drivers/iommu/dma-iommu.c    |  17 +-
>  drivers/iommu/intel/iommu.c  |  10 +-
>  drivers/iommu/virtio-iommu.c |   8 +
>  MAINTAINERS                  |   8 +
>  20 files changed, 580 insertions(+), 150 deletions(-)
>  create mode 100644 include/linux/acpi_viot.h
>  create mode 100644 drivers/acpi/arm64/dma.c
>  create mode 100644 drivers/acpi/viot.c
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
