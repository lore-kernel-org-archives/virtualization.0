Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581D5E7106C
	for <virtualization@archiver.kernel.org>; Thu, 21 Sep 2023 13:16:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B8909404E9;
	Thu, 21 Sep 2023 13:16:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B8909404E9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W5H5Uj5H
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IllgSUBfBrxs; Thu, 21 Sep 2023 13:16:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B8997401D0;
	Thu, 21 Sep 2023 13:16:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B8997401D0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8685CC0039;
	Thu, 21 Sep 2023 13:16:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 975EFC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 13:16:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7166140A54
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 13:16:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7166140A54
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=W5H5Uj5H
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wDYxp22GYWYO
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 13:16:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 923B2409BD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 13:16:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 923B2409BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695302190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uMrLP3EdMK20MxEzCyyOc/FFAdpv+7+G+3025LP6tgo=;
 b=W5H5Uj5H7EvKaWq+notZ6UyH2g2EPueyAb8dQ652byfGZrtNRoX9URj8UCsroMGMHdrPmX
 ZZrsss4viLLL1dqGP7U3IUVuzkuQdn47ZbrPOtdZLcBzX1UNmu+QIbaaMoVrdgfATqxm/U
 L+mh19mhCD96Ng8SCSNkqpLRgJ1BKZI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-42RtvszLOQehTrERM2-YAQ-1; Thu, 21 Sep 2023 09:16:28 -0400
X-MC-Unique: 42RtvszLOQehTrERM2-YAQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2c020ca4de0so12007651fa.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 06:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695302187; x=1695906987;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uMrLP3EdMK20MxEzCyyOc/FFAdpv+7+G+3025LP6tgo=;
 b=IkqYsOHZiV72p8LI1c9crLnhq3heAg9e+4h1FJByjGeWGjpNHngEpGIJsdaK9Ec4Ki
 /iJpUXsYF88BeHxaj46GNbQNYXvXsqe05nYc5w+zsoaTFNpFjVcuto29ax3wV7go11k6
 u4d+lOqcwaGqxkGoEOzf15PWaRjhvglE00fYcuQpwxCF85s5rikoE5d4BJs0awkkmL1H
 0xkIb7Iej9dacTGd8DUXt4nP33txJ3iS6WMJl5JA1srTfphurAEMNkx7HIi3kHJ3tBzm
 5Ig+0+yxZEwJe8md4Wk/xHevvx4Bc+dMArhxKqLBWzUD32DG+L9LbtkppSEGtRSCWKBc
 vY/w==
X-Gm-Message-State: AOJu0Ywj6xotJjrT/YD6b9qgkc3DzOkp5ZDceQi2leBYuDi7SgKQxwvO
 JMybE5+NiYoupo9UPZ2tCGJ/AIOTXCs5zW4qvv/0iP8LeF6CDFVdiiuIF4/llIzMFeBhhpkyw/b
 3iy47bjP3qYWPq+z7ME2zneCaC9e6oJqxSXkfbkKsPA==
X-Received: by 2002:a2e:7808:0:b0:2bc:b6a3:5a9 with SMTP id
 t8-20020a2e7808000000b002bcb6a305a9mr4817720ljc.37.1695302187236; 
 Thu, 21 Sep 2023 06:16:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeHong65EmWyH9vC8e5QQ/mKvYJR1RUZd7rLbip2eyBn/fsU5KhMYivpgffSPQfjWqcCK9Iw==
X-Received: by 2002:a2e:7808:0:b0:2bc:b6a3:5a9 with SMTP id
 t8-20020a2e7808000000b002bcb6a305a9mr4817688ljc.37.1695302186796; 
 Thu, 21 Sep 2023 06:16:26 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 o26-20020a1709061b1a00b0099bc08862b6sm1052811ejg.171.2023.09.21.06.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 06:16:25 -0700 (PDT)
Date: Thu, 21 Sep 2023 09:16:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230921090844-mutt-send-email-mst@kernel.org>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-12-yishaih@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230921124040.145386-12-yishaih@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jgg@nvidia.com, jiri@nvidia.com,
 leonro@nvidia.com
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


>  MAINTAINERS                      |   6 +
>  drivers/vfio/pci/Kconfig         |   2 +
>  drivers/vfio/pci/Makefile        |   2 +
>  drivers/vfio/pci/virtio/Kconfig  |  15 +
>  drivers/vfio/pci/virtio/Makefile |   4 +
>  drivers/vfio/pci/virtio/cmd.c    |   4 +-
>  drivers/vfio/pci/virtio/cmd.h    |   8 +
>  drivers/vfio/pci/virtio/main.c   | 546 +++++++++++++++++++++++++++++++
>  8 files changed, 585 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/vfio/pci/virtio/Kconfig
>  create mode 100644 drivers/vfio/pci/virtio/Makefile
>  create mode 100644 drivers/vfio/pci/virtio/main.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bf0f54c24f81..5098418c8389 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22624,6 +22624,12 @@ L:	kvm@vger.kernel.org
>  S:	Maintained
>  F:	drivers/vfio/pci/mlx5/
>  
> +VFIO VIRTIO PCI DRIVER
> +M:	Yishai Hadas <yishaih@nvidia.com>
> +L:	kvm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/vfio/pci/virtio
> +
>  VFIO PCI DEVICE SPECIFIC DRIVERS
>  R:	Jason Gunthorpe <jgg@nvidia.com>
>  R:	Yishai Hadas <yishaih@nvidia.com>

Tying two subsystems together like this is going to cause pain when
merging. God forbid there's something e.g. virtio net specific
(and there's going to be for sure) - now we are talking 3 subsystems.

Case in point all other virtio drivers are nicely grouped, have a common
mailing list etc etc.  This one is completely separate to the point
where people won't even remember to copy the virtio mailing list.


diff --git a/drivers/vfio/pci/virtio/Kconfig b/drivers/vfio/pci/virtio/Kconfig
new file mode 100644
index 000000000000..89eddce8b1bd
--- /dev/null
+++ b/drivers/vfio/pci/virtio/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VIRTIO_VFIO_PCI
+        tristate "VFIO support for VIRTIO PCI devices"
+        depends on VIRTIO_PCI
+        select VFIO_PCI_CORE
+        help
+          This provides support for exposing VIRTIO VF devices using the VFIO
+          framework that can work with a legacy virtio driver in the guest.
+          Based on PCIe spec, VFs do not support I/O Space; thus, VF BARs shall
+          not indicate I/O Space.
+          As of that this driver emulated I/O BAR in software to let a VF be
+          seen as a transitional device in the guest and let it work with
+          a legacy driver.
+
+          If you don't know what to do here, say N.

I don't promise we'll remember to poke at vfio if we tweak something
in the virtio kconfig.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
