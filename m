Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1832EC77B73
	for <virtualization@archiver.kernel.org>; Sun,  4 Jun 2023 22:22:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 821E582AED;
	Sun,  4 Jun 2023 22:22:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 821E582AED
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UC7NdaZh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3jGSfLxLVKaF; Sun,  4 Jun 2023 22:22:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 07C68828B3;
	Sun,  4 Jun 2023 22:22:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 07C68828B3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C02E3C007A;
	Sun,  4 Jun 2023 22:22:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64A4AC0029
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Jun 2023 22:22:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2B72F82909
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Jun 2023 22:22:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2B72F82909
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GlCkaImkuu76
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Jun 2023 22:22:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3CE43828B3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3CE43828B3
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Jun 2023 22:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685917331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mEAySEmrQm5KUECWvzC3KIEl56j/qA4072z9r/Nit2Y=;
 b=UC7NdaZh4Rfz6rA/7AuTWXd+2+qzhtAmpc302qRILWM0m/nWV4xO9SFRZAkjqWSgEGrXlU
 wA9mNVIu1uQoagwb89wrKb0y/ZjdF1Jbo2zpTxFGG3dzDsFlFXTHS1OtlvZkTrTft2uI6v
 V1R1JQO/b18BmyDwj/IiOfmTkY227/w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-5vAZstlbNaaZLSLKFLw_LA-1; Sun, 04 Jun 2023 18:22:02 -0400
X-MC-Unique: 5vAZstlbNaaZLSLKFLw_LA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30af222c5feso2255895f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 04 Jun 2023 15:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685917321; x=1688509321;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mEAySEmrQm5KUECWvzC3KIEl56j/qA4072z9r/Nit2Y=;
 b=TfGw7xeV9jpmeW041IKigfYxP4haJ9QmesvSl0xX8fHeX5U99sALJ3c8Q4ctOa+DwZ
 vrSjSCysC00qKN/6GnLq8QaKzcKp/7YVjxtw3oN2qpQ34mRD+nRxOftqn4f50TBQgtYE
 N1N4rSYtZs1dVFgLyf9dFhAdz0anZzzpqFQSKhD+GP5GNqk+FM/0dcNX5spcx103vuzp
 nZWO0BZ21QNxpe7hZNp5Uw6F3H3qJUMFPpyVIEtvdtq0/DO/TGCD6eo4uAJr9jfETH3q
 34IYppIYPX5Hu4aKmZlSMUp7pFjbn7Uz0zD138686Q951nUjJbHy+R284F3PhZl1hmUO
 fjRg==
X-Gm-Message-State: AC+VfDz+q5XFPiq0uws6oCG5If4i4GsEfE4PeD02Lc5G+QHxDTc/34qb
 8V0L060jac1sO0W9yiubO9yMq7sBRMkSaFA3h4sNmzBnq/zdK8OyJVpCBZ7/1SfjaUanbVHbdQA
 qtmLqpXdDe9T6He5pbf8Z6g9TrLsAvQnAWvtX4RxG0A==
X-Received: by 2002:adf:e343:0:b0:30a:dcba:2d81 with SMTP id
 n3-20020adfe343000000b0030adcba2d81mr4640879wrj.38.1685917321604; 
 Sun, 04 Jun 2023 15:22:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5tzbvhkP4emoMzokycH0M+dhLf3oeRcK1NqVBp8HKOqgDJIRrsG7CoIsBMNzKlUPUPz19IiQ==
X-Received: by 2002:adf:e343:0:b0:30a:dcba:2d81 with SMTP id
 n3-20020adfe343000000b0030adcba2d81mr4640873wrj.38.1685917321268; 
 Sun, 04 Jun 2023 15:22:01 -0700 (PDT)
Received: from redhat.com ([2.55.4.169]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm7937638wrq.89.2023.06.04.15.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jun 2023 15:22:00 -0700 (PDT)
Date: Sun, 4 Jun 2023 18:21:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 1/1] virtio: move pci drivers files to a directory
Message-ID: <20230604181927-mutt-send-email-mst@kernel.org>
References: <20230515171338.8227-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230515171338.8227-1-mgurtovoy@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: yishaih@nvidia.com, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, bodong@nvidia.com, oren@nvidia.com
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

On Mon, May 15, 2023 at 08:13:38PM +0300, Max Gurtovoy wrote:
> The PCI transport drivers have many files under virtio directory. Move
> them to a dedicated directory to ease on the subsystem maintenance.
> 
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>

The benefit here seems marginal, they all have
virtio_pci prefix, pci/virtio_pci_ just seems redundant. OTOH I
could see a benefit to have transports, core, and a bunch of
misc devices in 3 separate directories.

> ---
>  drivers/virtio/Makefile                          | 7 ++-----
>  drivers/virtio/pci/Makefile                      | 7 +++++++
>  drivers/virtio/{ => pci}/virtio_pci_common.c     | 0
>  drivers/virtio/{ => pci}/virtio_pci_common.h     | 0
>  drivers/virtio/{ => pci}/virtio_pci_legacy.c     | 0
>  drivers/virtio/{ => pci}/virtio_pci_legacy_dev.c | 0
>  drivers/virtio/{ => pci}/virtio_pci_modern.c     | 0
>  drivers/virtio/{ => pci}/virtio_pci_modern_dev.c | 0
>  8 files changed, 9 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/virtio/pci/Makefile
>  rename drivers/virtio/{ => pci}/virtio_pci_common.c (100%)
>  rename drivers/virtio/{ => pci}/virtio_pci_common.h (100%)
>  rename drivers/virtio/{ => pci}/virtio_pci_legacy.c (100%)
>  rename drivers/virtio/{ => pci}/virtio_pci_legacy_dev.c (100%)
>  rename drivers/virtio/{ => pci}/virtio_pci_modern.c (100%)
>  rename drivers/virtio/{ => pci}/virtio_pci_modern_dev.c (100%)
> 
> diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> index 8e98d24917cc..8c39c0594cea 100644
> --- a/drivers/virtio/Makefile
> +++ b/drivers/virtio/Makefile
> @@ -1,14 +1,11 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o
>  obj-$(CONFIG_VIRTIO_ANCHOR) += virtio_anchor.o
> -obj-$(CONFIG_VIRTIO_PCI_LIB) += virtio_pci_modern_dev.o
> -obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o
>  obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
> -obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
> -virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o
> -virtio_pci-$(CONFIG_VIRTIO_PCI_LEGACY) += virtio_pci_legacy.o
>  obj-$(CONFIG_VIRTIO_BALLOON) += virtio_balloon.o
>  obj-$(CONFIG_VIRTIO_INPUT) += virtio_input.o
>  obj-$(CONFIG_VIRTIO_VDPA) += virtio_vdpa.o
>  obj-$(CONFIG_VIRTIO_MEM) += virtio_mem.o
>  obj-$(CONFIG_VIRTIO_DMA_SHARED_BUFFER) += virtio_dma_buf.o
> +
> +obj-$(CONFIG_VIRTIO_PCI)		+= pci/
> diff --git a/drivers/virtio/pci/Makefile b/drivers/virtio/pci/Makefile
> new file mode 100644
> index 000000000000..673c7532430a
> --- /dev/null
> +++ b/drivers/virtio/pci/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
> +obj-$(CONFIG_VIRTIO_PCI_LIB) += virtio_pci_modern_dev.o
> +obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o
> +
> +virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o
> +virtio_pci-$(CONFIG_VIRTIO_PCI_LEGACY) += virtio_pci_legacy.o
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/pci/virtio_pci_common.c
> similarity index 100%
> rename from drivers/virtio/virtio_pci_common.c
> rename to drivers/virtio/pci/virtio_pci_common.c
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/pci/virtio_pci_common.h
> similarity index 100%
> rename from drivers/virtio/virtio_pci_common.h
> rename to drivers/virtio/pci/virtio_pci_common.h
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/pci/virtio_pci_legacy.c
> similarity index 100%
> rename from drivers/virtio/virtio_pci_legacy.c
> rename to drivers/virtio/pci/virtio_pci_legacy.c
> diff --git a/drivers/virtio/virtio_pci_legacy_dev.c b/drivers/virtio/pci/virtio_pci_legacy_dev.c
> similarity index 100%
> rename from drivers/virtio/virtio_pci_legacy_dev.c
> rename to drivers/virtio/pci/virtio_pci_legacy_dev.c
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/pci/virtio_pci_modern.c
> similarity index 100%
> rename from drivers/virtio/virtio_pci_modern.c
> rename to drivers/virtio/pci/virtio_pci_modern.c
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/pci/virtio_pci_modern_dev.c
> similarity index 100%
> rename from drivers/virtio/virtio_pci_modern_dev.c
> rename to drivers/virtio/pci/virtio_pci_modern_dev.c
> -- 
> 2.18.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
