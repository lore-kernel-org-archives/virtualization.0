Return-Path: <SRS0=hVMj=PQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4142C433EF
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 01:44:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B2F361107
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 01:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5B2F361107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A2C5405AB;
	Thu, 28 Oct 2021 01:44:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YxCdGb2xz6AC; Thu, 28 Oct 2021 01:44:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BAD3D405A1;
	Thu, 28 Oct 2021 01:44:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BAB2C0012;
	Thu, 28 Oct 2021 01:44:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8913C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 01:44:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A498781BC0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 01:44:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b5hq8mwwvy4V
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 01:44:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8512D81BBD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 01:44:17 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 t5-20020a17090a4e4500b001a0a284fcc2so6667143pjl.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 18:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=X1wiwLbjvMr0fUU/Ik7bpLL2xq562nKRBks78M/tbQ0=;
 b=NwrWjK1zEgkC/h0OltkWmV8v6U9kycWNkAzFyZ2UqlXn15yubZLd83LVcZWNlLL1f0
 Fv5BW1FJAtxuVzU9kXByXaxfMtmiH5UDaukXhF9R+cJyfOGMfQT6zf04USpHM9TDLMLF
 8zm7+00diA9rU2lDu/DTfvUOEu2zCMioGVYImhjXSkJTydRCIKV9cRbUQapJjcrGiqMK
 QnZf8nIfPhTNHOoqGDCmmZuYu6PaW3nbxj784zhi1I6uIMMPp2z6oTqTZJk+LfG12Qzb
 jA/Y5wJffgH2J2qLufj0bLW03BgfGI/buoZEjp4mtmSwLrMRhWqThDSfNCSg+TsSc0DH
 V6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X1wiwLbjvMr0fUU/Ik7bpLL2xq562nKRBks78M/tbQ0=;
 b=nuULfE+Mi1ExwO/KM4mRHxj1Vmlj9+EIINaDjvAFmTutHcUVFfPI23Wtr+NkETGJV4
 40+Bll6fFrrp6U3V3INncq6OaXumfq6dxVlv7xtX0uHm2NiqNfgaSLFzT7Xx9+MeYU0O
 pTAHTiiDcsBdUFoIICoafZbJuqVv4nJLDzvGtQedsuiOKibRB/yD1iMWd95zJU31iLvd
 +nA/QbuMftRN6wiEdL8p7xM8amPgv95K/un187Q1FEOYUsEY72PQD2Qgow82zz3StK0l
 bcYo82QupOQuuXW6Zf/MGsYTIqHUg4JkVmk2hQg6TSw3Tu4HvZ8UKpp4b01XGlP9E5I/
 1wXA==
X-Gm-Message-State: AOAM532pQnbd79ti3JvT6FDz65a5JuooL0rs989Q77xMVEfFGJIKjQ3w
 UNZSt1MQkZW5Hs0R7M8C52g8+nTwU5bnthn5Mi8VdA==
X-Google-Smtp-Source: ABdhPJyk8c8xZHfkX0RONmluScnz61A4HGhWerdM4JYgASaD4FzedQ2nCFUwr5W/5xCzT57VlrSOf0tWDKABqHHbWT8=
X-Received: by 2002:a17:902:8a97:b0:13e:6e77:af59 with SMTP id
 p23-20020a1709028a9700b0013e6e77af59mr1240292plo.4.1635385456643; Wed, 27 Oct
 2021 18:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-12-hch@lst.de>
In-Reply-To: <20211018044054.1779424-12-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 27 Oct 2021 18:44:04 -0700
Message-ID: <CAPcyv4ht6fZOdx4YN9FRCnmD2Wy4zzG7nJPQSdSPAgvZNHxoFw@mail.gmail.com>
Subject: Re: [PATCH 11/11] dax: move bdev_dax_pgoff to fs/dax.c
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
> No functional changet, but this will allow for a tighter integration

s/changet/changes/

> with the iomap code, including possible passing the partition offset

s/possible/possibly/

> in the iomap in the future.  For now it mostly avoids growing more

s/now/now,/

...all of the above fixed up locally.

Other than that, it looks good to me.

> callers outside of fs/dax.c.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/dax/super.c | 14 --------------
>  fs/dax.c            | 13 +++++++++++++
>  include/linux/dax.h |  1 -
>  3 files changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 803942586d1b6..c0910687fbcb2 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -67,20 +67,6 @@ void dax_remove_host(struct gendisk *disk)
>  }
>  EXPORT_SYMBOL_GPL(dax_remove_host);
>
> -int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t size,
> -               pgoff_t *pgoff)
> -{
> -       sector_t start_sect = bdev ? get_start_sect(bdev) : 0;
> -       phys_addr_t phys_off = (start_sect + sector) * 512;
> -
> -       if (pgoff)
> -               *pgoff = PHYS_PFN(phys_off);
> -       if (phys_off % PAGE_SIZE || size % PAGE_SIZE)
> -               return -EINVAL;
> -       return 0;
> -}
> -EXPORT_SYMBOL(bdev_dax_pgoff);
> -
>  /**
>   * dax_get_by_host() - temporary lookup mechanism for filesystem-dax
>   * @bdev: block device to find a dax_device for
> diff --git a/fs/dax.c b/fs/dax.c
> index 4e3e5a283a916..eb715363fd667 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -709,6 +709,19 @@ int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
>         return __dax_invalidate_entry(mapping, index, false);
>  }
>
> +static int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t size,
> +               pgoff_t *pgoff)
> +{
> +       sector_t start_sect = bdev ? get_start_sect(bdev) : 0;
> +       phys_addr_t phys_off = (start_sect + sector) * 512;
> +
> +       if (pgoff)
> +               *pgoff = PHYS_PFN(phys_off);
> +       if (phys_off % PAGE_SIZE || size % PAGE_SIZE)
> +               return -EINVAL;
> +       return 0;
> +}
> +
>  static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_dev,
>                              sector_t sector, struct page *to, unsigned long vaddr)
>  {
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 439c3c70e347b..324363b798ecd 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -107,7 +107,6 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
>  #endif
>
>  struct writeback_control;
> -int bdev_dax_pgoff(struct block_device *, sector_t, size_t, pgoff_t *pgoff);
>  #if IS_ENABLED(CONFIG_FS_DAX)
>  int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk);
>  void dax_remove_host(struct gendisk *disk);
> --
> 2.30.2
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
