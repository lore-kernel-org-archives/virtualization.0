Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B96CC636CC
	for <virtualization@archiver.kernel.org>; Sun,  5 Feb 2023 10:02:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA641409A0;
	Sun,  5 Feb 2023 10:02:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DA641409A0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jMKh+Vhj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k9H6pbsf3aaP; Sun,  5 Feb 2023 10:02:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0E84B40918;
	Sun,  5 Feb 2023 10:02:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0E84B40918
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC677C0033;
	Sun,  5 Feb 2023 10:02:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92428C002B
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Feb 2023 10:02:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6C6A84093A
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Feb 2023 10:02:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6C6A84093A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iIxi9eFvI4-7
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Feb 2023 10:02:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D27054184C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D27054184C
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Feb 2023 10:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675591326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VrDv5M1D/Bnij+vafx4QbbnsdIPEMLEUcsFcsJyS3RE=;
 b=jMKh+VhjIpjDybvqhumXov0bGgGH3cwvEFy8Ut4SK8wiFmKIwUVzv9fcmLsOBwPIQPTZPc
 HYM615G/yx6WyGixkFKGephqEtk7IinDtPSUDpZsZwYEJufvB1Bd45o5bzfJmpXzgU19JG
 nh6DVgUqzN/SWnTPknwjiaF3n7p61eo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-499-X8Ih_jT1OceZMAQFjC2OhA-1; Sun, 05 Feb 2023 05:02:05 -0500
X-MC-Unique: X8Ih_jT1OceZMAQFjC2OhA-1
Received: by mail-wm1-f70.google.com with SMTP id
 l38-20020a05600c1d2600b003ddff4b9a40so5016290wms.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 05 Feb 2023 02:02:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VrDv5M1D/Bnij+vafx4QbbnsdIPEMLEUcsFcsJyS3RE=;
 b=DWqEoqBhvx+tWb0Dgc4ww29rKxF+XlhI2BXre73zoWtgcGTMWHdAixoXvYPvt5/d31
 xhDRfqStTyA0d2wVTOj+yiiSx6DWvGd+36gUdtyXXQES9VsQXc+jp8p6b66l/8nHxS8b
 qH1fVKLEwLR6hOK/FTuJw+wsRoGVhSttoGVJjHgtwXQL01HkwVKv4vCNfjVzpTVdhh7c
 H7rVvBFVMGhp3YcifFHzJ88XA37QwKYNcdngJE7lIDySlVmJMpfO1sVesuxFBhN9wuBa
 AqRFH5QVlUv70RqOIOdb/FWVoX6FvTJQVTmfZGk19y7dcQiUhoB9ITqiyvvyjJp50rch
 ka3Q==
X-Gm-Message-State: AO0yUKWUCvu9rgiWxnbtsm/v6LHCRkUnfz42WZGdLsy7CSN1VNkmMrgP
 U5nazn3zSct+tCkxHC9/SLY/wWTtLYJaoUy74GCmtQwFy00GZGrDWz1q1oXPQ2bpDFOM/rtBuo+
 tbJrK1KRwPL9bc3tUu4SDnbYd7bUd+83IEnWXI+kFyw==
X-Received: by 2002:a05:600c:3b91:b0:3dc:545f:e9ce with SMTP id
 n17-20020a05600c3b9100b003dc545fe9cemr16747401wms.24.1675591324639; 
 Sun, 05 Feb 2023 02:02:04 -0800 (PST)
X-Google-Smtp-Source: AK7set8YLVmOZelQcBfOFDQIwXIOlKP8w5Qv0I1NMGLe7/YwB6qM3lW7lMaCyN+hDLgREf6CkLg2yg==
X-Received: by 2002:a05:600c:3b91:b0:3dc:545f:e9ce with SMTP id
 n17-20020a05600c3b9100b003dc545fe9cemr16747383wms.24.1675591324442; 
 Sun, 05 Feb 2023 02:02:04 -0800 (PST)
Received: from redhat.com ([2.52.129.177]) by smtp.gmail.com with ESMTPSA id
 l20-20020a05600c089400b003dc41a9836esm7523257wmp.43.2023.02.05.02.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Feb 2023 02:02:03 -0800 (PST)
Date: Sun, 5 Feb 2023 05:01:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shunsuke Mie <mie@igel.co.jp>
Subject: Re: [RFC PATCH 0/4] PCI: endpoint: Introduce a virtio-net EP function
Message-ID: <20230205050122-mutt-send-email-mst@kernel.org>
References: <20230203100418.2981144-1-mie@igel.co.jp>
MIME-Version: 1.0
In-Reply-To: <20230203100418.2981144-1-mie@igel.co.jp>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
 Takanari Hayama <taki@igel.co.jp>, Manivannan Sadhasivam <mani@kernel.org>,
 linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Ren Zhijie <renzhijie2@huawei.com>,
 Jon Mason <jdmason@kudzu.us>, Bjorn Helgaas <bhelgaas@google.com>
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

On Fri, Feb 03, 2023 at 07:04:14PM +0900, Shunsuke Mie wrote:
> This patchset introduce a virtio-net EP device function. It provides a
> new option to communiate between PCIe host and endpoint over IP.
> Advantage of this option is that the driver fully uses a PCIe embedded DMA.
> It is used to transport data between virtio ring directly each other. It
> can be expected to better throughput.
> 
> To realize the function, this patchset has few changes and introduces a
> new APIs to PCI EP framework related to virtio. Furthermore, it device
> depends on the some patchtes that is discussing. Those depended patchset
> are following:
> - [PATCH 1/2] dmaengine: dw-edma: Fix to change for continuous transfer
> link: https://lore.kernel.org/dmaengine/20221223022608.550697-1-mie@igel.co.jp/
> - [RFC PATCH 0/3] Deal with alignment restriction on EP side
> link: https://lore.kernel.org/linux-pci/20230113090350.1103494-1-mie@igel.co.jp/
> - [RFC PATCH v2 0/7] Introduce a vringh accessor for IO memory
> link: https://lore.kernel.org/virtualization/20230202090934.549556-1-mie@igel.co.jp/
> 
> About this patchset has 4 patches. The first of two patch is little changes
> to virtio. The third patch add APIs to easily access virtio data structure
> on PCIe Host side memory. The last one introduce a virtio-net EP device
> function. Details are in commit respectively.
> 
> Currently those network devices are testd using ping only. I'll add a
> result of performance evaluation using iperf and etc to the future version
> of this patchset.


All this feels like it'd need a virtio spec extension but I'm not 100%
sure without spending much more time understanding this.
what do you say?

> Shunsuke Mie (4):
>   virtio_pci: add a definition of queue flag in ISR
>   virtio_ring: remove const from vring getter
>   PCI: endpoint: Introduce virtio library for EP functions
>   PCI: endpoint: function: Add EP function driver to provide virtio net
>     device
> 
>  drivers/pci/endpoint/Kconfig                  |   7 +
>  drivers/pci/endpoint/Makefile                 |   1 +
>  drivers/pci/endpoint/functions/Kconfig        |  12 +
>  drivers/pci/endpoint/functions/Makefile       |   1 +
>  .../pci/endpoint/functions/pci-epf-vnet-ep.c  | 343 ++++++++++
>  .../pci/endpoint/functions/pci-epf-vnet-rc.c  | 635 ++++++++++++++++++
>  drivers/pci/endpoint/functions/pci-epf-vnet.c | 387 +++++++++++
>  drivers/pci/endpoint/functions/pci-epf-vnet.h |  62 ++
>  drivers/pci/endpoint/pci-epf-virtio.c         | 113 ++++
>  drivers/virtio/virtio_ring.c                  |   2 +-
>  include/linux/pci-epf-virtio.h                |  25 +
>  include/linux/virtio.h                        |   2 +-
>  include/uapi/linux/virtio_pci.h               |   2 +
>  13 files changed, 1590 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet-ep.c
>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet-rc.c
>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet.c
>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet.h
>  create mode 100644 drivers/pci/endpoint/pci-epf-virtio.c
>  create mode 100644 include/linux/pci-epf-virtio.h
> 
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
