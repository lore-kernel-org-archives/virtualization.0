Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72403C433EF
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 20:54:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E48610C8
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 20:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 14E48610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C54D34044A;
	Wed, 27 Oct 2021 20:54:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id anVYWxtP1fgK; Wed, 27 Oct 2021 20:54:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4E7B840109;
	Wed, 27 Oct 2021 20:54:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33066C0019;
	Wed, 27 Oct 2021 20:54:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA41FC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 20:54:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC05A40537
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 20:54:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ykm3u3oGwJeH
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 20:54:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 117CA4044C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 20:54:36 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id 75so4189256pga.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 13:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MW2+yuOLdVC2FiYNaHWFO+PStoIyhupC83aZvNmdg00=;
 b=xAWE2Gs6elQhyFnpgWWwNUZcIIN+S0dTB23e1v1SGSkr3xAYgCO6FZbQyPbRQqQf23
 9I8Y78UczhWRyEynzMK/aUvy5wOw4Vy6/4LxJus/eHVGZMzDNjEAK+zx722FS9qK0he2
 1U1cd8YzY36X3CDASwjtuR6iKB/eUu6jn2zPH05rfMggNUg3QvABlXcipTgHgz3k7BuS
 H+rhb1Vq1z7S7EkZGdXP0ONpo163cZlk5BsINHv2ASIpi7dd31Nuhi/Qnq9EJvDvkYxw
 Pntfc80cc9CfDzJp6vju7flE64Efz7hVPlBsr/GGmt1WhUviknbfEb0n+v3Q2OiU1RqV
 8kaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MW2+yuOLdVC2FiYNaHWFO+PStoIyhupC83aZvNmdg00=;
 b=YV+erINciM8M+SpdsirT95Wr6m9pQ5Ak4NeOwvk/3+FX11z1WJiPJTeFQOtd0zgyh7
 SX5XSJY4IaSRLzVwole+GPXSoKdC7GCwMi3fSqbq6VxrEVd1rpwfo432NWy5xiyiUfgv
 q/JSsdwhJVW7n74MI5gxuT01Zcpcx1vI3YywDoZnYx6dmOzolkMzxoNoSYTP3RhuM4bC
 LPBMjtcY90pY71O/JQJ2aF2vnkLVeTCnpK5zL3ISP49tLAVQ0+rSRQoHxD01YZeei63f
 exY+DXTOPWj3E54raxChe66S5l9FGWXl5DtJOTVx8KUTA1GNDe6JDe3oonM53g6UZCpg
 OjTg==
X-Gm-Message-State: AOAM531jiS54fzH1nQ7QO9ualPiYkGTBknjsdJl8sXXCazQEQWj2fBLl
 7Hjv1tDRA2glUOz1KucyPQcujjQ8Ie954wFKC4G0kg==
X-Google-Smtp-Source: ABdhPJxqYRzrssHaaThSAQ3S9v6yHWHIiMadGqtNgSbRxpNG6jDSA2a4I6mJJqbjxV8Pnl8ItfliO9eaeQbTvv574gs=
X-Received: by 2002:a63:770e:: with SMTP id s14mr43824pgc.377.1635368076533;
 Wed, 27 Oct 2021 13:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-3-hch@lst.de>
In-Reply-To: <20211018044054.1779424-3-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 27 Oct 2021 13:54:25 -0700
Message-ID: <CAPcyv4jAd5O=keOkvtKzrnqpy21dfH0sJSk7Oo16wYrFfPnk=Q@mail.gmail.com>
Subject: Re: [PATCH 02/11] dax: remove CONFIG_DAX_DRIVER
To: Christoph Hellwig <hch@lst.de>
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>, Mike Snitzer <snitzer@redhat.com>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org,
 linux-xfs <linux-xfs@vger.kernel.org>,
 device-mapper development <dm-devel@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
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

On Sun, Oct 17, 2021 at 9:41 PM Christoph Hellwig <hch@lst.de> wrote:
>
> CONFIG_DAX_DRIVER only selects CONFIG_DAX now, so remove it.

Looks good, I don't think an s390 ack is needed for this one.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/dax/Kconfig        | 4 ----
>  drivers/nvdimm/Kconfig     | 2 +-
>  drivers/s390/block/Kconfig | 2 +-
>  fs/fuse/Kconfig            | 2 +-
>  4 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
> index d2834c2cfa10d..954ab14ba7778 100644
> --- a/drivers/dax/Kconfig
> +++ b/drivers/dax/Kconfig
> @@ -1,8 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -config DAX_DRIVER
> -       select DAX
> -       bool
> -
>  menuconfig DAX
>         tristate "DAX: direct access to differentiated memory"
>         select SRCU
> diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
> index b7d1eb38b27d4..347fe7afa5830 100644
> --- a/drivers/nvdimm/Kconfig
> +++ b/drivers/nvdimm/Kconfig
> @@ -22,7 +22,7 @@ if LIBNVDIMM
>  config BLK_DEV_PMEM
>         tristate "PMEM: Persistent memory block device support"
>         default LIBNVDIMM
> -       select DAX_DRIVER
> +       select DAX
>         select ND_BTT if BTT
>         select ND_PFN if NVDIMM_PFN
>         help
> diff --git a/drivers/s390/block/Kconfig b/drivers/s390/block/Kconfig
> index d0416dbd0cd81..e3710a762abae 100644
> --- a/drivers/s390/block/Kconfig
> +++ b/drivers/s390/block/Kconfig
> @@ -5,7 +5,7 @@ comment "S/390 block device drivers"
>  config DCSSBLK
>         def_tristate m
>         select FS_DAX_LIMITED
> -       select DAX_DRIVER
> +       select DAX
>         prompt "DCSSBLK support"
>         depends on S390 && BLOCK
>         help
> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> index 40ce9a1c12e5d..038ed0b9aaa5d 100644
> --- a/fs/fuse/Kconfig
> +++ b/fs/fuse/Kconfig
> @@ -45,7 +45,7 @@ config FUSE_DAX
>         select INTERVAL_TREE
>         depends on VIRTIO_FS
>         depends on FS_DAX
> -       depends on DAX_DRIVER
> +       depends on DAX
>         help
>           This allows bypassing guest page cache and allows mapping host page
>           cache directly in guest address space.
> --
> 2.30.2
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
