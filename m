Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68418C43219
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 19:45:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6EF980FF8;
	Tue, 23 Nov 2021 19:45:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uRv58oeMbb4i; Tue, 23 Nov 2021 19:45:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5ED7280FFA;
	Tue, 23 Nov 2021 19:45:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E50EC002E;
	Tue, 23 Nov 2021 19:45:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CD10C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 19:45:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 365D74010E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 19:45:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pufckYyxY9xS
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 19:45:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3E91C400BF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 19:45:10 +0000 (UTC)
Received: by mail-pf1-x42c.google.com with SMTP id c4so346506pfj.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 11:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w+rFmLhgbnDpLxCzHmV2glN1Ln3seAnXjsHProy9jpQ=;
 b=8TuMlU3us3235PZEUw3+wIh4bMh3IEosMWINytQJPA8EsImL389OAaoHvBi2CGGdSf
 Rh9yn/jAP3LDfN6pR6SaRHTOUUOMLxOtUmam8reDwGSfD4w6FZveFANrjn8s/jihbP8a
 /9V60kc9Qtf+3Dml6kBEgRntEDh+nU+GrodQG++rP8I/zmuwILZOgR3w9QCJOIZ0g5zH
 9zH2kBIZ/cPSJQRWiB/2Y/XDrzvPyF3Hv3bN8XyfkxJRgVz69+M/RXyGlI55Xt+WpWs9
 wMU+SWPcM07FWqrOx/09zV4DI9sUcLhs84CFSiM/9XDv/STaLOihgU7ct0RV7chhixuh
 VA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w+rFmLhgbnDpLxCzHmV2glN1Ln3seAnXjsHProy9jpQ=;
 b=vB0Be1YZEeE95pD3vc92Rg0Smv5ZWY4vQewcIPMzyjOR9WHCmQNzalTaW41Kp9k3+v
 Nfb7fxPmd+vryx5ZBORvAvvGi76ZK9yLl8PCD3hG8zxJD+argqNerkBGSiK647DwbjSa
 6RBfzfYWI3MkqoW0suDm/K7quUHoOAlCs6Pbm4iIY68xMKiNSVNr9SOpBimN6gqieEe6
 4ArbWAhNgdH2/i6sJw++Pkp0t5qNgrylFOF/K62TAjmJ14sZIHAcwLpl5iku8Yp72i1y
 K7ioUDsmHN3nS4cnpTjW1tDXRjUOerhgC0HlDYB01u5radlwx1nL3mAV5SrJTIYt5ADK
 2Qfw==
X-Gm-Message-State: AOAM530U+ijehuHTiDTNejBE2d/yPfU+x243dE0XUWASTd2oOBsjgKsk
 P6qMPM6o4HiA7pMJ0phk/3oGDAV1AiCunT1XufiWAA==
X-Google-Smtp-Source: ABdhPJyXaOgPCWXg03K7i5Yu4pkRtA/C9CDsmT0Wx6XfkWLs2OyDjuogWwUi8QvAPldXDBn8n1H52ogjjyzkBt9HYEc=
X-Received: by 2002:aa7:8d0a:0:b0:4a2:82d7:1695 with SMTP id
 j10-20020aa78d0a000000b004a282d71695mr8142364pfe.86.1637696709602; Tue, 23
 Nov 2021 11:45:09 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-15-hch@lst.de>
In-Reply-To: <20211109083309.584081-15-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Nov 2021 11:44:59 -0800
Message-ID: <CAPcyv4gVjR05Go=WpK9k-FYO53o+X9PZz2nFL9gniz85nCXu4w@mail.gmail.com>
Subject: Re: [PATCH 14/29] fsdax: simplify the pgoff calculation
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

On Tue, Nov 9, 2021 at 12:33 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Replace the two steps of dax_iomap_sector and bdev_dax_pgoff with a
> single dax_iomap_pgoff helper that avoids lots of cumbersome sector
> conversions.

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/dax/super.c | 14 --------------
>  fs/dax.c            | 35 ++++++++++-------------------------
>  include/linux/dax.h |  1 -
>  3 files changed, 10 insertions(+), 40 deletions(-)
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
> index e51b4129d1b65..5364549d67a48 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -709,23 +709,22 @@ int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
>         return __dax_invalidate_entry(mapping, index, false);
>  }
>
> -static sector_t dax_iomap_sector(const struct iomap *iomap, loff_t pos)
> +static pgoff_t dax_iomap_pgoff(const struct iomap *iomap, loff_t pos)
>  {
> -       return (iomap->addr + (pos & PAGE_MASK) - iomap->offset) >> 9;
> +       phys_addr_t paddr = iomap->addr + (pos & PAGE_MASK) - iomap->offset;
> +
> +       if (iomap->bdev)
> +               paddr += (get_start_sect(iomap->bdev) << SECTOR_SHIFT);
> +       return PHYS_PFN(paddr);
>  }
>
>  static int copy_cow_page_dax(struct vm_fault *vmf, const struct iomap_iter *iter)
>  {
> -       sector_t sector = dax_iomap_sector(&iter->iomap, iter->pos);
> +       pgoff_t pgoff = dax_iomap_pgoff(&iter->iomap, iter->pos);
>         void *vto, *kaddr;
> -       pgoff_t pgoff;
>         long rc;
>         int id;
>
> -       rc = bdev_dax_pgoff(iter->iomap.bdev, sector, PAGE_SIZE, &pgoff);
> -       if (rc)
> -               return rc;
> -
>         id = dax_read_lock();
>         rc = dax_direct_access(iter->iomap.dax_dev, pgoff, 1, &kaddr, NULL);
>         if (rc < 0) {
> @@ -1013,14 +1012,10 @@ EXPORT_SYMBOL_GPL(dax_writeback_mapping_range);
>  static int dax_iomap_pfn(const struct iomap *iomap, loff_t pos, size_t size,
>                          pfn_t *pfnp)
>  {
> -       const sector_t sector = dax_iomap_sector(iomap, pos);
> -       pgoff_t pgoff;
> +       pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
>         int id, rc;
>         long length;
>
> -       rc = bdev_dax_pgoff(iomap->bdev, sector, size, &pgoff);
> -       if (rc)
> -               return rc;
>         id = dax_read_lock();
>         length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
>                                    NULL, pfnp);
> @@ -1129,7 +1124,7 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
>  s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
>  {
>         sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
> -       pgoff_t pgoff;
> +       pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
>         long rc, id;
>         void *kaddr;
>         bool page_aligned = false;
> @@ -1140,10 +1135,6 @@ s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
>             (size == PAGE_SIZE))
>                 page_aligned = true;
>
> -       rc = bdev_dax_pgoff(iomap->bdev, sector, PAGE_SIZE, &pgoff);
> -       if (rc)
> -               return rc;
> -
>         id = dax_read_lock();
>
>         if (page_aligned)
> @@ -1169,7 +1160,6 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>         const struct iomap *iomap = &iomi->iomap;
>         loff_t length = iomap_length(iomi);
>         loff_t pos = iomi->pos;
> -       struct block_device *bdev = iomap->bdev;
>         struct dax_device *dax_dev = iomap->dax_dev;
>         loff_t end = pos + length, done = 0;
>         ssize_t ret = 0;
> @@ -1203,9 +1193,8 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>         while (pos < end) {
>                 unsigned offset = pos & (PAGE_SIZE - 1);
>                 const size_t size = ALIGN(length + offset, PAGE_SIZE);
> -               const sector_t sector = dax_iomap_sector(iomap, pos);
> +               pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
>                 ssize_t map_len;
> -               pgoff_t pgoff;
>                 void *kaddr;
>
>                 if (fatal_signal_pending(current)) {
> @@ -1213,10 +1202,6 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>                         break;
>                 }
>
> -               ret = bdev_dax_pgoff(bdev, sector, size, &pgoff);
> -               if (ret)
> -                       break;
> -
>                 map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
>                                 &kaddr, NULL);
>                 if (map_len < 0) {
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
