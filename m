Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A18C433F5
	for <virtualization@archiver.kernel.org>; Wed, 24 Nov 2021 02:56:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1705481777;
	Wed, 24 Nov 2021 02:56:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id csmb61jwsQpa; Wed, 24 Nov 2021 02:56:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BE46E81762;
	Wed, 24 Nov 2021 02:56:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9597BC001E;
	Wed, 24 Nov 2021 02:56:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74B92C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 02:56:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5D21260AAD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 02:56:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cf_gSY0WrIcT
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 02:56:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A88C160AA8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 02:56:40 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 y14-20020a17090a2b4e00b001a5824f4918so3778372pjc.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 18:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K6aLDxpU5yyseOlKo6rNtA4cugi0ipNPCjlDJmHcgIw=;
 b=ZodTRA+l0cWcfcrO3HjZ5G1YiDvMh60G3gnO10/HB5K3wACoMILqWpq5tyghP5PaAd
 /HwKbMOp519uQpkZTsiaKbJxiO4I4LMxvhZKQ98u2R62HbNgGSXOiBZGNXqPhLpDseTa
 7vzzMoZl4/zH+br0ANjvCl5c9fXM78IWjkNvHtHR5BTyrgEmRWUa/QYkAkFWIBqAi3vh
 b+zNb07awMu9xLTaQ0QBdRnjc+S/g9oqwKglYR/Xxt8j7ck6Lkr6xNcD5O/IUvzABpY5
 Eu59hL+MFPuc5JaG7/+/vAaPPJWsBP2y6puOgx7hXkD43mLwWUFY6ZCNi+QL3gXyrcQM
 vLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K6aLDxpU5yyseOlKo6rNtA4cugi0ipNPCjlDJmHcgIw=;
 b=5jDSZAXKC0Auz9xx5bwRCBQ33GLYF+Z/lGqJPSm/vRX6ncBqdAKvlDJwLX6Pml2twv
 O+7hrBYyKr8cqTwm1E3HorrZ8fviyemGO0Vkzrvxer0eZ25JpkrPx6jysReUJVTijA3l
 eMG5M6TQNPhcHq6ykm1ADItDzLQl3o9eI1y2PYJS1Wzgz59smwsRr/CYYI6bsTvZPd1B
 GDy96oo8R2CnoKZLAAvZ4Sin877sD+YtjimwGFNC4aq7b+ERawkoKiEhzDA0aheIWom4
 QKUnUOKfkbGvpB1/uRQZwvB+ZNyMjyCCxJl9lRaWpb2OFk95n26frcYn9C/lgnvHF2B+
 48nw==
X-Gm-Message-State: AOAM531YvCFQSYkBy24bfFAw/aK2TZgQisHQ4WcTkaii49K0h+7S2bxk
 Nke2Xn0wxBqAvPvaif7qen3aPVLOY6571ARfvPGXnA==
X-Google-Smtp-Source: ABdhPJzo6eTnlpQwuRFEtmMj42wpPoH8sJWzIsynA2XekOCtzKT4A4dij0QV0bz7WFLT+916AMzKYpVsKpziQJRycmQ=
X-Received: by 2002:a17:90b:1e07:: with SMTP id
 pg7mr3567015pjb.93.1637722600133; 
 Tue, 23 Nov 2021 18:56:40 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-26-hch@lst.de>
In-Reply-To: <20211109083309.584081-26-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Nov 2021 18:56:29 -0800
Message-ID: <CAPcyv4jtWzd3c_S1_4fYA1SXTJZfBzP_1xk_OwYkeNp0UhxwSg@mail.gmail.com>
Subject: Re: [PATCH 25/29] dax: return the partition offset from
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

On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Prepare from removing the block_device from the DAX I/O path by returning

s/from removing/for the removal of/

> the partition offset from fs_dax_get_by_bdev so that the file systems
> have it at hand for use during I/O.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/dax/super.c | 9 ++++++---
>  drivers/md/dm.c     | 4 ++--
>  fs/erofs/internal.h | 2 ++
>  fs/erofs/super.c    | 4 ++--
>  fs/ext2/ext2.h      | 1 +
>  fs/ext2/super.c     | 2 +-
>  fs/ext4/ext4.h      | 1 +
>  fs/ext4/super.c     | 2 +-
>  fs/xfs/xfs_buf.c    | 2 +-
>  fs/xfs/xfs_buf.h    | 1 +
>  include/linux/dax.h | 6 ++++--
>  11 files changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index c0910687fbcb2..cc32dcf71c116 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -70,17 +70,20 @@ EXPORT_SYMBOL_GPL(dax_remove_host);
>  /**
>   * dax_get_by_host() - temporary lookup mechanism for filesystem-dax
>   * @bdev: block device to find a dax_device for
> + * @start_off: returns the byte offset into the dax_device that @bdev starts
>   */
> -struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
> +struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev, u64 *start_off)
>  {
>         struct dax_device *dax_dev;
> +       u64 part_size;
>         int id;
>
>         if (!blk_queue_dax(bdev->bd_disk->queue))
>                 return NULL;
>
> -       if ((get_start_sect(bdev) * SECTOR_SIZE) % PAGE_SIZE ||
> -           (bdev_nr_sectors(bdev) * SECTOR_SIZE) % PAGE_SIZE) {
> +       *start_off = get_start_sect(bdev) * SECTOR_SIZE;
> +       part_size = bdev_nr_sectors(bdev) * SECTOR_SIZE;
> +       if (*start_off % PAGE_SIZE || part_size % PAGE_SIZE) {
>                 pr_info("%pg: error: unaligned partition for dax\n", bdev);
>                 return NULL;
>         }
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 282008afc465f..5ea6115d19bdc 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -637,7 +637,7 @@ static int open_table_device(struct table_device *td, dev_t dev,
>                              struct mapped_device *md)
>  {
>         struct block_device *bdev;
> -
> +       u64 part_off;
>         int r;
>
>         BUG_ON(td->dm_dev.bdev);
> @@ -653,7 +653,7 @@ static int open_table_device(struct table_device *td, dev_t dev,
>         }
>
>         td->dm_dev.bdev = bdev;
> -       td->dm_dev.dax_dev = fs_dax_get_by_bdev(bdev);
> +       td->dm_dev.dax_dev = fs_dax_get_by_bdev(bdev, &part_off);

Perhaps allow NULL as an argument for callers that do not care about
the start offset?


Otherwise, looks good / clever.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
