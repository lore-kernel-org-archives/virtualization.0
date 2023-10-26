Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B65C25B6B
	for <virtualization@archiver.kernel.org>; Thu, 26 Oct 2023 07:28:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7727641FA8;
	Thu, 26 Oct 2023 07:28:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7727641FA8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OqWH942j
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qy6dbGL_5Bjc; Thu, 26 Oct 2023 07:28:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C557C41F9B;
	Thu, 26 Oct 2023 07:27:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C557C41F9B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D07DC0071;
	Thu, 26 Oct 2023 07:27:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BDBAC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 07:27:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 573B68317B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 07:27:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 573B68317B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OqWH942j
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dTP0-2A7OafD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 07:27:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4A1F58318C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 07:27:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A1F58318C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698305275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jFAk/UX+mocmkaca8aE9iwm2NVVEyC9d5/N9h8Hr0Qk=;
 b=OqWH942jr5VDAiJQ67GiGN4jJNusBu+WMpti21kmx6bml+FzGw1v2GRn46V0oByizhgIje
 PtaU+CyEje/3HtbCpLq7RdZ4Z80vle+ZWUgEptmeAqxK2akWYE1HAHqMjAX+NFECzUJAuW
 McW97WFikY6veFB0l5RgfBaROviBU1g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-mBxti9_XNqWmp49blVKqYw-1; Thu, 26 Oct 2023 03:27:49 -0400
X-MC-Unique: mBxti9_XNqWmp49blVKqYw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4090fa518bbso4411085e9.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 00:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698305268; x=1698910068;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jFAk/UX+mocmkaca8aE9iwm2NVVEyC9d5/N9h8Hr0Qk=;
 b=RVV0pLl3d8f1GrvJEVMWazL+1chuaDi/5kNuFj5xc8e4hRRUQGTNLxsjiu4js1LAJb
 VJ/uXcoVNUkV980SWemRusCjrbv3ixXsRdOj9RlbRwixearPyfC/PxbUEZttpMjxqBoR
 NlPQWtPmIFQFg0/v8h0V3VZ3hdoz6Nuj3nH+1Lx1Pbi0Dlakw28DjJfQH1ARrSNackr9
 bFuIzK+B3FcXiymA+U0MnK8WwnarEqQCpo6U4weXgBIK7xtLo1hYsM6DwNyXKKN9SnJ6
 jbXbP8K3LPXNIzd0hGuICoQe7rM3OyXGUxcInIxtBlDNI+KnJXY40X8pOTUKPYPaE94m
 RQZQ==
X-Gm-Message-State: AOJu0Yxv/rdJ3PQhP7FUmJg1HMVRlyagsZ0vdgUX0lpY9vYV7PEXQrXs
 V+eFPEORSoPjPeXMMySWBPu9/nvRYaqW4fzU+KKGOzAH4nP1GZnhpL5jzPuPYL8RKiaLDHlbfJn
 LUdzwTQUq7ln+10Y7NhkKdFAzxZcAgsR73HOSyl/7Vg==
X-Received: by 2002:a05:600c:5122:b0:403:272:4414 with SMTP id
 o34-20020a05600c512200b0040302724414mr13653842wms.0.1698305268319; 
 Thu, 26 Oct 2023 00:27:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDmxe4z2Ra5Jw2xkZ3lS9zcLLaRq/+nM5ao37J48dzXRSejdwXRV3MKk8nh9wCEGGF4SoKdQ==
X-Received: by 2002:a05:600c:5122:b0:403:272:4414 with SMTP id
 o34-20020a05600c512200b0040302724414mr13653825wms.0.1698305267881; 
 Thu, 26 Oct 2023 00:27:47 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:3c98:7fa5:a31:81ed:a5e2])
 by smtp.gmail.com with ESMTPSA id
 f9-20020a7bc8c9000000b004054dcbf92asm1716144wml.20.2023.10.26.00.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 00:27:46 -0700 (PDT)
Date: Thu, 26 Oct 2023 03:27:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH v5 0/7] vdpa: decouple reset of iotlb mapping from device
 reset
Message-ID: <20231026032713-mutt-send-email-mst@kernel.org>
References: <1698304480-18463-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1698304480-18463-1-git-send-email-si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com
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

On Thu, Oct 26, 2023 at 12:14:33AM -0700, Si-Wei Liu wrote:
> In order to reduce needlessly high setup and teardown cost
> of iotlb mapping during live migration, it's crucial to
> decouple the vhost-vdpa iotlb abstraction from the virtio
> device life cycle, i.e. iotlb mappings should be left
> intact across virtio device reset [1]. For it to work, the
> on-chip IOMMU parent device could implement a separate
> .reset_map() operation callback to restore 1:1 DMA mapping
> without having to resort to the .reset() callback, the
> latter of which is mainly used to reset virtio device state.
> This new .reset_map() callback will be invoked only before
> the vhost-vdpa driver is to be removed and detached from
> the vdpa bus, such that other vdpa bus drivers, e.g. 
> virtio-vdpa, can start with 1:1 DMA mapping when they
> are attached. For the context, those on-chip IOMMU parent
> devices, create the 1:1 DMA mapping at vdpa device creation,
> and they would implicitly destroy the 1:1 mapping when
> the first .set_map or .dma_map callback is invoked.
> 
> This patchset is rebased on top of the latest vhost tree.
> 
> [1] Reducing vdpa migration downtime because of memory pin / maps
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg953755.html


If this is just a squash of v4 with fixes then I already pushed it.
Ignoring this for now.

> ---
> v5:
> - Squashed two fixups to the clean map patch
> 
> v4:
> - Rework compatibility using new .compat_reset driver op
> 
> v3:
> - add .reset_map support to vdpa_sim
> - introduce module parameter to provide bug-for-bug compatibility with older
>   userspace 
> 
> v2:
> - improved commit message to clarify the intended csope of .reset_map API
> - improved commit messages to clarify no breakage on older userspace
> 
> v1:
> - rewrote commit messages to include more detailed description and background
> - reword to vendor specific IOMMU implementation from on-chip IOMMU
> - include parent device backend feautres to persistent iotlb precondition
> - reimplement mlx5_vdpa patch on top of descriptor group series
> 
> RFC v3:
> - fix missing return due to merge error in patch #4
> 
> RFC v2:
> - rebased on top of the "[PATCH RFC v2 0/3] vdpa: dedicated descriptor table group" series:
>   https://lore.kernel.org/virtualization/1694248959-13369-1-git-send-email-si-wei.liu@oracle.com/
> 
> ---
> 
> Si-Wei Liu (7):
>   vdpa: introduce .reset_map operation callback
>   vhost-vdpa: reset vendor specific mapping to initial state in .release
>   vhost-vdpa: introduce IOTLB_PERSIST backend feature bit
>   vdpa: introduce .compat_reset operation callback
>   vhost-vdpa: clean iotlb map during reset for older userspace
>   vdpa/mlx5: implement .reset_map driver op
>   vdpa_sim: implement .reset_map support
> 
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
>  drivers/vdpa/mlx5/core/mr.c        | 17 ++++++++++
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 27 ++++++++++++++--
>  drivers/vdpa/vdpa_sim/vdpa_sim.c   | 52 ++++++++++++++++++++++++------
>  drivers/vhost/vdpa.c               | 52 +++++++++++++++++++++++++++---
>  drivers/virtio/virtio_vdpa.c       |  2 +-
>  include/linux/vdpa.h               | 30 +++++++++++++++--
>  include/uapi/linux/vhost_types.h   |  2 ++
>  8 files changed, 164 insertions(+), 19 deletions(-)
> 
> -- 
> 2.39.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
