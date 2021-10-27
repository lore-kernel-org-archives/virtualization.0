Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3517C433F5
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 23:07:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FB4160F56
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 23:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6FB4160F56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D47B40598;
	Wed, 27 Oct 2021 23:07:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ea3BtSWCm5R2; Wed, 27 Oct 2021 23:07:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C7A9540586;
	Wed, 27 Oct 2021 23:07:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99A38C0012;
	Wed, 27 Oct 2021 23:07:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93363C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 23:07:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 730774010E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 23:07:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H6csg4-2Metl
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 23:07:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 84C0C400EA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 23:07:18 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 na16-20020a17090b4c1000b0019f5bb661f9so3262615pjb.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 16:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3af0vrDw+XvQKylIm0LDLH9D6xoJ74LhsidYuXkOM7g=;
 b=d6phRBLSNqEavLbFGa7qsltfCwCXOIkQGNewJdYfiMwINhHDbJ+v3Tvr+m7SXCKglh
 f1Y9JyoYsY7pru2o0qaf9ZrRobsN47Jue96kM8PwOADE6VAIkbXtDJTZy+mzrce1H5ii
 TDWfFC/E9fe8cXOG72hb4HndsLJ5qovtA1WXr8x1UXXNXsg6OU7/y9sWKZsB9Ro8FzaF
 3kotXlCmovzhrPQGnkvqh1aQ4+kBEwqSKMSlKnEz5Ahj4QsLMDMTI4jX5+IsmEJsZDOu
 D4ACx/M3ONMf14xOrt8n/jVyvHMKdyB04vPcp4aB9RBAawLg1e2wm7UXNUEREJEycjA9
 pSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3af0vrDw+XvQKylIm0LDLH9D6xoJ74LhsidYuXkOM7g=;
 b=5x8nvfdX87nCdkPEtLL/oayj6jomdrpfW2mgCd50lJlt33OuxqMbaXTSKUGLFrMr9m
 RPMy/ejx9RsYD4I2fWqhW/DZmm63Ffd0J1vxElzx/QkqrfCn5u5UxjC8PUqM5hytKKRu
 VZ/fNgoDCZfYM4kR1OnkvMT/ldBwI50HXHxz4z9gjwha43xKwYAXRcMHq0tKGUMV3x9Z
 alUYh3B/J4nKTOow1LmItSm7OV4L/YD2IKYRwNU3hRTOvqm9NU2P45/LClQmElQn1ZQ6
 f/TyIrkyuURNCvHPSyvKX3w3FsSYsGc5dukc/MR9xRHU/JsjNXqKxhynUyIZ7NGYgjC/
 RysQ==
X-Gm-Message-State: AOAM533eBVJOcPQp0WmDHvag96MD5XZ7RWaLu7lg1Cn/XEjdFKFpTCoD
 z45Lazq2NWh7nk2VZ4i/S5wrv/1WpNT9ux8B/mOoFQ==
X-Google-Smtp-Source: ABdhPJxTOfk9fcqxHjqgG3f1vnNsNPlrTHxqnz6/LIE7U1wpYxfkWo7JAy9TqN/B72HDrJA9DjHrJAEIhgWs2Md2+FA=
X-Received: by 2002:a17:90b:350f:: with SMTP id
 ls15mr618659pjb.220.1635376038542; 
 Wed, 27 Oct 2021 16:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-6-hch@lst.de>
In-Reply-To: <20211018044054.1779424-6-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 27 Oct 2021 16:07:07 -0700
Message-ID: <CAPcyv4iqkLQWEyqRYZPaBmA=bXyJy5DR699ch+wfBanY-MKu9g@mail.gmail.com>
Subject: Re: [PATCH 05/11] dax: move the partition alignment check into
 fs_dax_get_by_bdev
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
> fs_dax_get_by_bdev is the primary interface to find a dax device for a
> block device, so move the partition alignment check there instead of
> wiring it up through ->dax_supported.

Looks good.

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/dax/super.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 04fc680542e8d..482fe775324a4 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -93,6 +93,12 @@ struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
>         if (!blk_queue_dax(bdev->bd_disk->queue))
>                 return NULL;
>
> +       if ((get_start_sect(bdev) * SECTOR_SIZE) % PAGE_SIZE ||
> +           (bdev_nr_sectors(bdev) * SECTOR_SIZE) % PAGE_SIZE) {
> +               pr_info("%pg: error: unaligned partition for dax\n", bdev);
> +               return NULL;
> +       }
> +
>         id = dax_read_lock();
>         dax_dev = xa_load(&dax_hosts, (unsigned long)bdev->bd_disk);
>         if (!dax_dev || !dax_alive(dax_dev) || !igrab(&dax_dev->inode))
> @@ -107,10 +113,6 @@ bool generic_fsdax_supported(struct dax_device *dax_dev,
>                 struct block_device *bdev, int blocksize, sector_t start,
>                 sector_t sectors)
>  {
> -       pgoff_t pgoff, pgoff_end;
> -       sector_t last_page;
> -       int err;
> -
>         if (blocksize != PAGE_SIZE) {
>                 pr_info("%pg: error: unsupported blocksize for dax\n", bdev);
>                 return false;
> @@ -121,19 +123,6 @@ bool generic_fsdax_supported(struct dax_device *dax_dev,
>                 return false;
>         }
>
> -       err = bdev_dax_pgoff(bdev, start, PAGE_SIZE, &pgoff);
> -       if (err) {
> -               pr_info("%pg: error: unaligned partition for dax\n", bdev);
> -               return false;
> -       }
> -
> -       last_page = PFN_DOWN((start + sectors - 1) * 512) * PAGE_SIZE / 512;
> -       err = bdev_dax_pgoff(bdev, last_page, PAGE_SIZE, &pgoff_end);
> -       if (err) {
> -               pr_info("%pg: error: unaligned partition for dax\n", bdev);
> -               return false;
> -       }
> -
>         return true;
>  }
>  EXPORT_SYMBOL_GPL(generic_fsdax_supported);
> --
> 2.30.2
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
