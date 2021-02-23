Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E1EC433DB
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 12:16:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 444DF64E00
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 12:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444DF64E00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4382605BE;
	Tue, 23 Feb 2021 12:16:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O7fCo6fj6Vx8; Tue, 23 Feb 2021 12:16:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9CA2605A5;
	Tue, 23 Feb 2021 12:16:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AAD66C000A;
	Tue, 23 Feb 2021 12:16:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CFE0C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:16:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5D255605BE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:16:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id skvGf-7ly9dr
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:16:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5432C605A5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614082581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xuJP4Lr7WK3/XdWa+jgHVjgU3TlUDGqnV/N8eDtiKQU=;
 b=AbnxgOijRDUUQaQzIAO4GxwbUzoE3DX4eE98lJsQ2LLxFlrufmFX+U0lEISszyAfPJIhkz
 S3YDzRCX2d21hnIE1+BKDS0RyKtPtDU6OaoL9/nvlBjK571bJjhl/C86+le+y46sxx7APq
 4kxr5MpIhd0Nf+LmT0i829K+KPos4KE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-pJqqAfPUP7ms3yuSB8EfGQ-1; Tue, 23 Feb 2021 07:16:20 -0500
X-MC-Unique: pJqqAfPUP7ms3yuSB8EfGQ-1
Received: by mail-wr1-f72.google.com with SMTP id t14so3955694wrr.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 04:16:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xuJP4Lr7WK3/XdWa+jgHVjgU3TlUDGqnV/N8eDtiKQU=;
 b=nkOpZSF//G2d/O+ENegM3yuVaPXLDgn7ERMlNfhT/tnSZ1VxaNgX0sg+XcMVQjN4Ww
 QSr001Vg1Wqqgu1DJJMuBY7JqpPJUc9gS5OrPWGauwL4Os+1rHYeySM+ewUPgqhzmbIH
 VNwrAmK1LNBDIAXLQI08XREoUSIZgHHgrJL9zboWWECdKAVu5SctaVUlH8JS1qK29C5v
 gpD9pZ/NKiW/X2uadoCHKMVM5dQI940SjFHkWetarkmPsiSRqcmDv9Lc5D1zc5mvSRsR
 r05Bb0YplYD/kjZp+v46UTuTpX5SCoZ6CS+3luJ7RpYztFZWbkVtNSeA3S/QHBfqV4PO
 I+bA==
X-Gm-Message-State: AOAM530DrHjbMx1Vtf7SO32ykMgtHT2W+EbJ7ULXzWu2gWxtGwonb/3L
 HjBd7QLks/3SCvKFwXHulXuSG3SqkqCklVSwZtqU3Jb1i5lGfoaHafHqfo2BMZkfgumOjF08hFV
 3qRxLMaF3dShXVB97XN3xHUQOK4474sFRGBeKvx4SUQ==
X-Received: by 2002:a1c:2094:: with SMTP id
 g142mr25118664wmg.101.1614082579254; 
 Tue, 23 Feb 2021 04:16:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy5Kc68688ni+tAKGFRwlPs7B7s2yQYYlt3GZobippa3eeeUTvLqoC0yTypnY2RJi3fn105/g==
X-Received: by 2002:a1c:2094:: with SMTP id
 g142mr25118650wmg.101.1614082579126; 
 Tue, 23 Feb 2021 04:16:19 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id 7sm2660622wmi.27.2021.02.23.04.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 04:16:18 -0800 (PST)
Date: Tue, 23 Feb 2021 07:16:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V4 0/3] virtio-pci: introduce modern device module
Message-ID: <20210223071553-mutt-send-email-mst@kernel.org>
References: <20210223061905.422659-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210223061905.422659-1-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: shahafs@mellanox.com, rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Tue, Feb 23, 2021 at 02:19:02PM +0800, Jason Wang wrote:
> Hi all:
> 
> This series tries to implement a vDPA driver for virtio-pci device
> which will bridge between vDPA bus and virtio-pci device.
> 
> This could be used for future feature prototyping and testing.
> 
> Please review

OK just one thing: subject should have had V5, not V4.


> Changes since V4:
> - include the patch to let VIRTIO_PCI_LIB to be auto selected
> - style fixes in the Kconfig for vp-vdpa driver
> - fix the err value returned during vp-vdpa driver probing
> 
> Changes since V3:
> - rebase to vhost.git
> 
> Changes since V2:
> 
> - tweak config prompt
> - switch from 'cb' to 'config_cb' for vp_vdpa config interrupt
> - use a macro for vp_vdpa msix name length
> 
> Changes since V1:
> 
> - don't try to use devres for virtio-pci core
> - tweak the commit log
> - split the patches furtherly to ease the reviewing
> 
> Changes since RFC:
> 
> - Split common codes from virito-pci and share it with vDPA driver
> - Use dynamic id in order to be less confusing with virtio-pci driver
> - No feature whitelist, supporting any features (mq, config etc)
> 
> Jason Wang (3):
>   virtio: don't prompt CONFIG_VIRTIO_PCI_MODERN
>   vdpa: set the virtqueue num during register
>   vdpa: introduce virtio pci driver
> 
>  drivers/vdpa/Kconfig                 |   7 +
>  drivers/vdpa/Makefile                |   1 +
>  drivers/vdpa/ifcvf/ifcvf_main.c      |   5 +-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c    |   4 +-
>  drivers/vdpa/vdpa.c                  |  18 +-
>  drivers/vdpa/vdpa_sim/vdpa_sim.c     |   2 +-
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c |   2 +-
>  drivers/vdpa/virtio_pci/Makefile     |   2 +
>  drivers/vdpa/virtio_pci/vp_vdpa.c    | 458 +++++++++++++++++++++++++++
>  drivers/virtio/Kconfig               |  11 +-
>  drivers/virtio/Makefile              |   2 +-
>  include/linux/vdpa.h                 |  10 +-
>  12 files changed, 496 insertions(+), 26 deletions(-)
>  create mode 100644 drivers/vdpa/virtio_pci/Makefile
>  create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa.c
> 
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
