Return-Path: <SRS0=/kjp=CE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C69DC433E3
	for <virtualization@archiver.kernel.org>; Wed, 26 Aug 2020 13:26:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40609214F1
	for <virtualization@archiver.kernel.org>; Wed, 26 Aug 2020 13:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTWsgNyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40609214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0F9CF87916;
	Wed, 26 Aug 2020 13:26:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JTan6yOXJLsq; Wed, 26 Aug 2020 13:26:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5546987AA1;
	Wed, 26 Aug 2020 13:26:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E04CC0891;
	Wed, 26 Aug 2020 13:26:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8A21C07FF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 13:26:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9F4FD864AA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 13:26:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3J-gJpoS9QYU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 13:26:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7C3E286463
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 13:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598448387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MkzQ6QG6I3q9nGpvzTY0xeeHjgqsvGJlxwUyvGFDZ+4=;
 b=iTWsgNyOACqcCH9DnQgv/Jt567GaYxfBx2Xr92qdYiHhaZN00FQn1Js8Bga6DgnAjrCcFG
 HMQuQRvqazoY5ZkDG/pH8FQAQFJ//jCsJAP+2PX0n6odZLeX48fvSCNBN2F2xMDFoym5YU
 qMBTzIuDGw+W4QixXTpB/uhAQ7+6qrs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-swBTtZAnNZm1lu2mhaiemg-1; Wed, 26 Aug 2020 09:26:21 -0400
X-MC-Unique: swBTtZAnNZm1lu2mhaiemg-1
Received: by mail-wr1-f69.google.com with SMTP id o10so514399wrs.21
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 06:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MkzQ6QG6I3q9nGpvzTY0xeeHjgqsvGJlxwUyvGFDZ+4=;
 b=kTYHmGELTvEjjFFnBm5P4SkfXqNbunIQJEU4CG33vja5VpoPlxAk9OO0em65ID8E5t
 ja6Jk+DEqdKVPvR/E0Cy2V9yiY8kOCw9xOHOMD1kxWrbvCZB4yle2siq+M+t9LZJKdrY
 OrGI84hz6Uw4Q29xrFbDRwkLbp0HmAR7cbVoIzfUZYZDrSlBX0C12L4J1BsByisQXenR
 s0n5zTyF3cqKtAJgDsrrV3NPsHWznM1d+49rMfDFtdQwhybdfAskTlmjPfx75FC6j3J+
 EBHIFc3UUNsPsmRrgHBPxLW9mkITjfXgJIbmVSzsO6KaGJHz9HAEoxJeP0Q0O+c1jYSQ
 bWOw==
X-Gm-Message-State: AOAM531GS5wlYr5V5tZC4SrozqEqQAb367eLFAbc/skTGRWmRNpvZkrf
 bxRl3yUh7AztQ5hb12wmqbpTabbuyeuwXUMW7lEWPiGPyEnQHojqK7hymprsf2NdkhohCbqU1AN
 JXmYb2panrQZxBdh+v1jdhZvbr9LCxEZZaHc97cy3Sw==
X-Received: by 2002:a7b:cc0b:: with SMTP id f11mr7456510wmh.31.1598448379685; 
 Wed, 26 Aug 2020 06:26:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwi9aZpSBzDPZ4YhRao8GK4t0yYAUzHdvj2YCsqb1ChjyiMN53z1cQZmWVo7qm7qMPKOLNWDA==
X-Received: by 2002:a7b:cc0b:: with SMTP id f11mr7456493wmh.31.1598448379478; 
 Wed, 26 Aug 2020 06:26:19 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id v7sm8462813wma.1.2020.08.26.06.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 06:26:18 -0700 (PDT)
Date: Wed, 26 Aug 2020 09:26:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200826092542-mutt-send-email-mst@kernel.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200821131540.2801801-1-jean-philippe@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, bhelgaas@google.com
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

On Fri, Aug 21, 2020 at 03:15:34PM +0200, Jean-Philippe Brucker wrote:
> Add a topology description to the virtio-iommu driver and enable x86
> platforms.
> 
> Since [v2] we have made some progress on adding ACPI support for
> virtio-iommu, which is the preferred boot method on x86. It will be a
> new vendor-agnostic table describing para-virtual topologies in a
> minimal format. However some platforms don't use either ACPI or DT for
> booting (for example microvm), and will need the alternative topology
> description method proposed here. In addition, since the process to get
> a new ACPI table will take a long time, this provides a boot method even
> to ACPI-based platforms, if only temporarily for testing and
> development.

OK should I park this in next now? Seems appropriate ...

> v3:
> * Add patch 1 that moves virtio-iommu to a subfolder.
> * Split the rest:
>   * Patch 2 adds topology-helper.c, which will be shared with the ACPI
>     support.
>   * Patch 4 adds definitions.
>   * Patch 5 adds parser in topology.c.
> * Address other comments.
> 
> Linux and QEMU patches available at:
> https://jpbrucker.net/git/linux virtio-iommu/devel
> https://jpbrucker.net/git/qemu virtio-iommu/devel
> 
> [spec] https://lists.oasis-open.org/archives/virtio-dev/202008/msg00067.html
> [v2] https://lore.kernel.org/linux-iommu/20200228172537.377327-1-jean-philippe@linaro.org/
> [v1] https://lore.kernel.org/linux-iommu/20200214160413.1475396-1-jean-philippe@linaro.org/
> [rfc] https://lore.kernel.org/linux-iommu/20191122105000.800410-1-jean-philippe@linaro.org/
> 
> Jean-Philippe Brucker (6):
>   iommu/virtio: Move to drivers/iommu/virtio/
>   iommu/virtio: Add topology helpers
>   PCI: Add DMA configuration for virtual platforms
>   iommu/virtio: Add topology definitions
>   iommu/virtio: Support topology description in config space
>   iommu/virtio: Enable x86 support
> 
>  drivers/iommu/Kconfig                     |  18 +-
>  drivers/iommu/Makefile                    |   3 +-
>  drivers/iommu/virtio/Makefile             |   4 +
>  drivers/iommu/virtio/topology-helpers.h   |  50 +++++
>  include/linux/virt_iommu.h                |  15 ++
>  include/uapi/linux/virtio_iommu.h         |  44 ++++
>  drivers/iommu/virtio/topology-helpers.c   | 196 ++++++++++++++++
>  drivers/iommu/virtio/topology.c           | 259 ++++++++++++++++++++++
>  drivers/iommu/{ => virtio}/virtio-iommu.c |   4 +
>  drivers/pci/pci-driver.c                  |   5 +
>  MAINTAINERS                               |   3 +-
>  11 files changed, 597 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/iommu/virtio/Makefile
>  create mode 100644 drivers/iommu/virtio/topology-helpers.h
>  create mode 100644 include/linux/virt_iommu.h
>  create mode 100644 drivers/iommu/virtio/topology-helpers.c
>  create mode 100644 drivers/iommu/virtio/topology.c
>  rename drivers/iommu/{ => virtio}/virtio-iommu.c (99%)
> 
> -- 
> 2.28.0
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
