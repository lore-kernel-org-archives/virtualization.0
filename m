Return-Path: <SRS0=sVkE=DB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6430AC4346E
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 09:00:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6D512376F
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 09:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hj+dKOLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D512376F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9330086B7F;
	Thu, 24 Sep 2020 09:00:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oH6rkOnnrY6w; Thu, 24 Sep 2020 09:00:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AE09586A6B;
	Thu, 24 Sep 2020 09:00:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4E34C0889;
	Thu, 24 Sep 2020 09:00:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A42BC0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 09:00:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6BDEA874DF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 09:00:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ib+NQmMLVeMb
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 09:00:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4D8DB874BB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 09:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600938050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GUGrf6sKN5n1jpxMEY27z8eDMfPfaHEAHvK9zipmPr8=;
 b=hj+dKOLUeE1sMBJk8zFWRmLGTpb45D8rgn+MT8XgeG7zTLnQpuGaJX75WrciS86pm81uou
 9oyMUp7eFPkm8aOJr7H54LWLNAuTRyUZr8hNUOuJ9wOd/NlVOXJNNmOrSBomc6g3bckmIU
 AvZkrkd3TMMNqY7UB+dD/J9oA/rrOYc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-MUvhiEX8MGqbLl79bkW5Sg-1; Thu, 24 Sep 2020 05:00:41 -0400
X-MC-Unique: MUvhiEX8MGqbLl79bkW5Sg-1
Received: by mail-wr1-f69.google.com with SMTP id d9so968386wrv.16
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 02:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GUGrf6sKN5n1jpxMEY27z8eDMfPfaHEAHvK9zipmPr8=;
 b=LDqIj0zcfuWEetvG9u13QnY3BwHmwKI6XVuSsniNQ69ZbfcmfxYhicB1gpBxRm3EqW
 4F7+mLYB4c69C5yP4CMOOtDhklzrbaabjm8upvn+PfB2GsTHfG6+F7H/IxJfo/DSyjZb
 M2ZvOlmwtpVzG6TrFVZb3U3GkneEBFTikutPe+j30Dk6de7qcYABlF5zyYG3aoxVnkkM
 VbaFRFXiVolwZXxb8Fai8sa4fi2sG4JNJe8z4ktY6v99Rsn9YEa6mZP5pdJtupRndoGu
 C8YK4h2dXhPJsQ/0zR572tg25kJ/l632vH3e9RsO7FOeqMK/oyPZ/bcKQ0D+iK2588mb
 AXaw==
X-Gm-Message-State: AOAM531d55qArEqH/PlLTbQgfOcTt6flqO35CrulqZQL4o24PqtYfiyC
 iTEGSEF/XoX04ZjG8rStyeYx1f0AGsh1LXcDjtIdDnpr3DPm8iSc1U3MGSgvyAq9fdyPUOU5l45
 WEfe1Y+KgPED/oO5jhXuvRHRNko8XV8pzYti4u8nX0Q==
X-Received: by 2002:adf:fe42:: with SMTP id m2mr3827881wrs.367.1600938040414; 
 Thu, 24 Sep 2020 02:00:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwM6amM8onmWtTQ2m03dl19rxCsYdxhcLJwZMHlUC1IovGw8tlcX+SAAylK/ze3a948rFpahg==
X-Received: by 2002:adf:fe42:: with SMTP id m2mr3827842wrs.367.1600938040173; 
 Thu, 24 Sep 2020 02:00:40 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id h16sm3001574wre.87.2020.09.24.02.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 02:00:39 -0700 (PDT)
Date: Thu, 24 Sep 2020 05:00:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200924045958-mutt-send-email-mst@kernel.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, lorenzo.pieralisi@arm.com,
 virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org, joro@8bytes.org,
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

On Fri, Sep 04, 2020 at 06:24:12PM +0200, Auger Eric wrote:
> Hi,
> 
> On 8/21/20 3:15 PM, Jean-Philippe Brucker wrote:
> > Add a topology description to the virtio-iommu driver and enable x86
> > platforms.
> > 
> > Since [v2] we have made some progress on adding ACPI support for
> > virtio-iommu, which is the preferred boot method on x86. It will be a
> > new vendor-agnostic table describing para-virtual topologies in a
> > minimal format. However some platforms don't use either ACPI or DT for
> > booting (for example microvm), and will need the alternative topology
> > description method proposed here. In addition, since the process to get
> > a new ACPI table will take a long time, this provides a boot method even
> > to ACPI-based platforms, if only temporarily for testing and
> > development.
> > 
> > v3:
> > * Add patch 1 that moves virtio-iommu to a subfolder.
> > * Split the rest:
> >   * Patch 2 adds topology-helper.c, which will be shared with the ACPI
> >     support.
> >   * Patch 4 adds definitions.
> >   * Patch 5 adds parser in topology.c.
> > * Address other comments.
> > 
> > Linux and QEMU patches available at:
> > https://jpbrucker.net/git/linux virtio-iommu/devel
> > https://jpbrucker.net/git/qemu virtio-iommu/devel
> I have tested that series with above QEMU branch on ARM with virtio-net
> and virtio-blk translated devices in non DT mode.
> 
> It works for me:
> Tested-by: Eric Auger <eric.auger@redhat.com>
> 
> Thanks
> 
> Eric

OK so this looks good. Can you pls repost with the minor tweak
suggested and all acks included, and I will queue this?

Thanks!

> > 
> > [spec] https://lists.oasis-open.org/archives/virtio-dev/202008/msg00067.html
> > [v2] https://lore.kernel.org/linux-iommu/20200228172537.377327-1-jean-philippe@linaro.org/
> > [v1] https://lore.kernel.org/linux-iommu/20200214160413.1475396-1-jean-philippe@linaro.org/
> > [rfc] https://lore.kernel.org/linux-iommu/20191122105000.800410-1-jean-philippe@linaro.org/
> > 
> > Jean-Philippe Brucker (6):
> >   iommu/virtio: Move to drivers/iommu/virtio/
> >   iommu/virtio: Add topology helpers
> >   PCI: Add DMA configuration for virtual platforms
> >   iommu/virtio: Add topology definitions
> >   iommu/virtio: Support topology description in config space
> >   iommu/virtio: Enable x86 support
> > 
> >  drivers/iommu/Kconfig                     |  18 +-
> >  drivers/iommu/Makefile                    |   3 +-
> >  drivers/iommu/virtio/Makefile             |   4 +
> >  drivers/iommu/virtio/topology-helpers.h   |  50 +++++
> >  include/linux/virt_iommu.h                |  15 ++
> >  include/uapi/linux/virtio_iommu.h         |  44 ++++
> >  drivers/iommu/virtio/topology-helpers.c   | 196 ++++++++++++++++
> >  drivers/iommu/virtio/topology.c           | 259 ++++++++++++++++++++++
> >  drivers/iommu/{ => virtio}/virtio-iommu.c |   4 +
> >  drivers/pci/pci-driver.c                  |   5 +
> >  MAINTAINERS                               |   3 +-
> >  11 files changed, 597 insertions(+), 4 deletions(-)
> >  create mode 100644 drivers/iommu/virtio/Makefile
> >  create mode 100644 drivers/iommu/virtio/topology-helpers.h
> >  create mode 100644 include/linux/virt_iommu.h
> >  create mode 100644 drivers/iommu/virtio/topology-helpers.c
> >  create mode 100644 drivers/iommu/virtio/topology.c
> >  rename drivers/iommu/{ => virtio}/virtio-iommu.c (99%)
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
