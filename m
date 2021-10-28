Return-Path: <SRS0=hVMj=PQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A74C433EF
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 01:41:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 015F461106
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 01:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 015F461106
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B91586067B;
	Thu, 28 Oct 2021 01:41:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7_kqd9Jh70ty; Thu, 28 Oct 2021 01:41:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4828D6066A;
	Thu, 28 Oct 2021 01:41:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B986C0012;
	Thu, 28 Oct 2021 01:41:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 640B2C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 01:41:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3E5D44010E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 01:41:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P_K5TnXueRK4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 01:41:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 34EC940112
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 01:41:25 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 x1-20020a17090a530100b001a1efa4ebe6so4387046pjh.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 18:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+57OykW2c30gUJR4jUskDQk4x1gwxn9Qbm17JsREFMA=;
 b=GwABTqD6Tkvmyhn2eav2yJwtbW1tJceyJOpR55oElF8Cpl62Tl7fpwDRJSoK85tktg
 WcSZzYI1J3gqZuBvcpDIMaP3fjxWgAXp2/71GNnfMTHJUKsW82nQtl3PxcHMw5XB0BGj
 ol0Z6vrOct/ohRKJEQ4971tC4ghv27sixDbbqgpjArwG9QA0di/1K6lcnuWx54KE2Iv0
 PlLdrGzgfAPZa89z4zZVquTUHRBE3n1XFA2eZslunyTMpQ/h+DaZ/H5bzksM/u3SBYyF
 eGC2TY3oTZ8dh7yBcSfW5yNsChH5J+OrCKaL/dFJg1o9GeZbeU8dYWzE/mMch4zQe8Vr
 Evvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+57OykW2c30gUJR4jUskDQk4x1gwxn9Qbm17JsREFMA=;
 b=3C+sQfgjsCOTUgR+DIpo1gkqDsj/k31vRfxm6e230sI/1mikW0S5Gy8GfpRcBcH0yU
 nhFcEbK+ELPJk2TgDa98cjKzQ5Il5MP1TBEUYNe7Ue8vl0Kb7FcpfET5hrqQ6RF+u9fq
 wcKmradri+tI15vO9MOtVqxuRez5gWG2qUxIs79ZU2fd6afsEoKCQ1rg+pDPtJXEOM/r
 vQ8esQ/BHSeJQXyGUDnvrP5bJUKoJJ+Z4WjnInxQ2qXNMNVBvA9kXFzY0r68pSntmzrH
 VPwUYdqo6wbrUYA/APvMumRCuDhgePK4hofI4Rt9OI6cVFCRJO2hWu7OkwkW6FeyY6B4
 +OTQ==
X-Gm-Message-State: AOAM533WnO9ft/5ApapCM1INa4sr0TRtsCFueHaCos6K6g3GAYid11b1
 jqkiKyT/KzZMW/z6YwesNKY5WGFOY07fkCh03ha2Pg==
X-Google-Smtp-Source: ABdhPJy+l4+hDjjFqjiYrNzY24jHwGCV82yPyLMD7+lqHF6GqMdOIsbo6sHeOhaMgqSlqL4IZjgKI/J2hsCPQtYDPIA=
X-Received: by 2002:a17:902:ab50:b0:13f:4c70:9322 with SMTP id
 ij16-20020a170902ab5000b0013f4c709322mr995386plb.89.1635385285322; Wed, 27
 Oct 2021 18:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-11-hch@lst.de>
In-Reply-To: <20211018044054.1779424-11-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 27 Oct 2021 18:41:13 -0700
Message-ID: <CAPcyv4iLbbqyAsy1yjFXT48D3Ssp+jy4EMJt+Sj_o2W-WMgK9w@mail.gmail.com>
Subject: Re: [PATCH 10/11] dm-stripe: add a stripe_dax_pgoff helper
To: Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>,
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
> Add a helper to perform the entire remapping for DAX accesses.  This
> helper open codes bdev_dax_pgoff given that the alignment checks have
> already been done by the submitting file system and don't need to be
> repeated.

Again, looks good. Kind of embarrassing when the open-coded version is
less LOC than using the helper.

Mike, ack?

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/md/dm-stripe.c | 63 ++++++++++--------------------------------
>  1 file changed, 15 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
> index f084607220293..50dba3f39274c 100644
> --- a/drivers/md/dm-stripe.c
> +++ b/drivers/md/dm-stripe.c
> @@ -301,83 +301,50 @@ static int stripe_map(struct dm_target *ti, struct bio *bio)
>  }
>
>  #if IS_ENABLED(CONFIG_FS_DAX)
> -static long stripe_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
> -               long nr_pages, void **kaddr, pfn_t *pfn)
> +static struct dax_device *stripe_dax_pgoff(struct dm_target *ti, pgoff_t *pgoff)
>  {
> -       sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
>         struct stripe_c *sc = ti->private;
> -       struct dax_device *dax_dev;
>         struct block_device *bdev;
> +       sector_t dev_sector;
>         uint32_t stripe;
> -       long ret;
>
> -       stripe_map_sector(sc, sector, &stripe, &dev_sector);
> +       stripe_map_sector(sc, *pgoff * PAGE_SECTORS, &stripe, &dev_sector);
>         dev_sector += sc->stripe[stripe].physical_start;
> -       dax_dev = sc->stripe[stripe].dev->dax_dev;
>         bdev = sc->stripe[stripe].dev->bdev;
>
> -       ret = bdev_dax_pgoff(bdev, dev_sector, nr_pages * PAGE_SIZE, &pgoff);
> -       if (ret)
> -               return ret;
> +       *pgoff = (get_start_sect(bdev) + dev_sector) >> PAGE_SECTORS_SHIFT;
> +       return sc->stripe[stripe].dev->dax_dev;
> +}
> +
> +static long stripe_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
> +               long nr_pages, void **kaddr, pfn_t *pfn)
> +{
> +       struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
> +
>         return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
>  }
>
>  static size_t stripe_dax_copy_from_iter(struct dm_target *ti, pgoff_t pgoff,
>                 void *addr, size_t bytes, struct iov_iter *i)
>  {
> -       sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
> -       struct stripe_c *sc = ti->private;
> -       struct dax_device *dax_dev;
> -       struct block_device *bdev;
> -       uint32_t stripe;
> -
> -       stripe_map_sector(sc, sector, &stripe, &dev_sector);
> -       dev_sector += sc->stripe[stripe].physical_start;
> -       dax_dev = sc->stripe[stripe].dev->dax_dev;
> -       bdev = sc->stripe[stripe].dev->bdev;
> +       struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
>
> -       if (bdev_dax_pgoff(bdev, dev_sector, ALIGN(bytes, PAGE_SIZE), &pgoff))
> -               return 0;
>         return dax_copy_from_iter(dax_dev, pgoff, addr, bytes, i);
>  }
>
>  static size_t stripe_dax_copy_to_iter(struct dm_target *ti, pgoff_t pgoff,
>                 void *addr, size_t bytes, struct iov_iter *i)
>  {
> -       sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
> -       struct stripe_c *sc = ti->private;
> -       struct dax_device *dax_dev;
> -       struct block_device *bdev;
> -       uint32_t stripe;
> -
> -       stripe_map_sector(sc, sector, &stripe, &dev_sector);
> -       dev_sector += sc->stripe[stripe].physical_start;
> -       dax_dev = sc->stripe[stripe].dev->dax_dev;
> -       bdev = sc->stripe[stripe].dev->bdev;
> +       struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
>
> -       if (bdev_dax_pgoff(bdev, dev_sector, ALIGN(bytes, PAGE_SIZE), &pgoff))
> -               return 0;
>         return dax_copy_to_iter(dax_dev, pgoff, addr, bytes, i);
>  }
>
>  static int stripe_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
>                                       size_t nr_pages)
>  {
> -       int ret;
> -       sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
> -       struct stripe_c *sc = ti->private;
> -       struct dax_device *dax_dev;
> -       struct block_device *bdev;
> -       uint32_t stripe;
> +       struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
>
> -       stripe_map_sector(sc, sector, &stripe, &dev_sector);
> -       dev_sector += sc->stripe[stripe].physical_start;
> -       dax_dev = sc->stripe[stripe].dev->dax_dev;
> -       bdev = sc->stripe[stripe].dev->bdev;
> -
> -       ret = bdev_dax_pgoff(bdev, dev_sector, nr_pages << PAGE_SHIFT, &pgoff);
> -       if (ret)
> -               return ret;
>         return dax_zero_page_range(dax_dev, pgoff, nr_pages);
>  }
>
> --
> 2.30.2
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
