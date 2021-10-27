Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CC1C4321E
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 20:53:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1047F60720
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 20:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1047F60720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CC0E1400F5;
	Wed, 27 Oct 2021 20:53:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zAo8m7TTfaQl; Wed, 27 Oct 2021 20:53:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 14D77400FE;
	Wed, 27 Oct 2021 20:53:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E133FC0019;
	Wed, 27 Oct 2021 20:53:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA481C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 20:53:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C2153607AF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 20:53:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AQGHkfbu99QA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 20:53:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 810856071D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 20:53:33 +0000 (UTC)
Received: by mail-pl1-x634.google.com with SMTP id n18so2899447plc.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 13:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JF27tid0jnJ4Lv4ojsqdS1ywAxF2Yh/rXBicw2Nx/Bg=;
 b=1isnZNLrwmgFC3LXRliYMUrYtu55I8EQQ7pQxVF+w9vAU0wMFXPxuqqMaEfcBFZxXg
 qcnLJVTOmdX1rGsKPaKzFF9Qu8Ee1ZOBQ182Hw4pibX9D4X5BrxrW8qLlaMVoa3uA3Tk
 KGDMGjWdaecMTrVHOCSpZJWK2sZUzx48BP4iJpaAETHGMQ4UeJfwWrv7HXh9aCqjIq+2
 9ALeonJXxoVD6TAd61eVgIdGSZeRVRycG+QFqApL/sPZtYnF3KhgHnv0ssu3/ANRUj/4
 POtGkuO11AqaPuPuXfXiiUY+Tsb2EtZLFRQXaHjr8SeP+pOqWQy14Q9lU0490jcBhr1l
 CXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JF27tid0jnJ4Lv4ojsqdS1ywAxF2Yh/rXBicw2Nx/Bg=;
 b=PK/bJuJ6EdwF9IO/YZjZ21dgS8pp2zyguurT4PXaS5ObXzrJrquCW3SxmRi8uGJW+Y
 8vX8NWEoOZYn9nNdUVvBg4guLhDPw9vVHv9VDnsXBR7053ORKPEnwuVa6T/vLA3y5kB1
 SuteXeQbjiw8kO2mur0+Nr17GZZCdQV2AA67JXT9cRCqqmNoZQWV8I+BSNB9Dw17zeRP
 BPY20hoyuZt1rhM3YA25XZsxpHLEvEZuKlst/9Gloa1qI5LndF30h8rst57kd4IpXUun
 sGTObxNdNGRCdOioDN9H0DYeTECShaXlCSo4IqiVxSrLhT91HvD67aEHUY1JNHmVK4f/
 qc8A==
X-Gm-Message-State: AOAM533noEZjB4CB4XLLzJ3CG3CoI8romtAOq+1UR6WtywC2YojbZS6A
 4XFbRdxakEm8qKX6i9mZps0v8/u95eCyN/qrMIpQ8Q==
X-Google-Smtp-Source: ABdhPJzghlFw+zkjpuNy8dyEqDgjwZ/Nb0+yCd5621faImzBOeUtIgX/3CShbYonbAi1vtWBePJ7pkat1hh6sB8QXRU=
X-Received: by 2002:a17:90b:3b88:: with SMTP id pc8mr3618pjb.93.1635368012904; 
 Wed, 27 Oct 2021 13:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-2-hch@lst.de>
In-Reply-To: <20211018044054.1779424-2-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 27 Oct 2021 13:53:21 -0700
Message-ID: <CAPcyv4hrEPizMOH-XhCqh=23EJDG=W6VwvQ1pVstfe-Jm-AsiQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] dm: make the DAX support dependend on CONFIG_FS_DAX
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
> The device mapper DAX support is all hanging off a block device and thus
> can't be used with device dax.  Make it depend on CONFIG_FS_DAX instead
> of CONFIG_DAX_DRIVER.  This also means that bdev_dax_pgoff only needs to
> be built under CONFIG_FS_DAX now.

Looks good.

Mike, can I get an ack to take this through nvdimm.git? (you'll likely
see me repeat this question on subsequent patches in this series).

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/dax/super.c        | 6 ++----
>  drivers/md/dm-linear.c     | 2 +-
>  drivers/md/dm-log-writes.c | 2 +-
>  drivers/md/dm-stripe.c     | 2 +-
>  drivers/md/dm-writecache.c | 2 +-
>  drivers/md/dm.c            | 2 +-
>  6 files changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index b882cf8106ea3..e20d0cef10a18 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -63,7 +63,7 @@ static int dax_host_hash(const char *host)
>         return hashlen_hash(hashlen_string("DAX", host)) % DAX_HASH_SIZE;
>  }
>
> -#ifdef CONFIG_BLOCK
> +#if defined(CONFIG_BLOCK) && defined(CONFIG_FS_DAX)
>  #include <linux/blkdev.h>
>
>  int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t size,
> @@ -80,7 +80,6 @@ int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t size,
>  }
>  EXPORT_SYMBOL(bdev_dax_pgoff);
>
> -#if IS_ENABLED(CONFIG_FS_DAX)
>  /**
>   * dax_get_by_host() - temporary lookup mechanism for filesystem-dax
>   * @host: alternate name for the device registered by a dax driver
> @@ -219,8 +218,7 @@ bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(dax_supported);
> -#endif /* CONFIG_FS_DAX */
> -#endif /* CONFIG_BLOCK */
> +#endif /* CONFIG_BLOCK && CONFIG_FS_DAX */
>
>  enum dax_device_flags {
>         /* !alive + rcu grace period == no new operations / mappings */
> diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
> index 679b4c0a2eea1..32fbab11bf90c 100644
> --- a/drivers/md/dm-linear.c
> +++ b/drivers/md/dm-linear.c
> @@ -163,7 +163,7 @@ static int linear_iterate_devices(struct dm_target *ti,
>         return fn(ti, lc->dev, lc->start, ti->len, data);
>  }
>
> -#if IS_ENABLED(CONFIG_DAX_DRIVER)
> +#if IS_ENABLED(CONFIG_FS_DAX)
>  static long linear_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
>                 long nr_pages, void **kaddr, pfn_t *pfn)
>  {
> diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
> index d93a4db235124..6d694526881d0 100644
> --- a/drivers/md/dm-log-writes.c
> +++ b/drivers/md/dm-log-writes.c
> @@ -903,7 +903,7 @@ static void log_writes_io_hints(struct dm_target *ti, struct queue_limits *limit
>         limits->io_min = limits->physical_block_size;
>  }
>
> -#if IS_ENABLED(CONFIG_DAX_DRIVER)
> +#if IS_ENABLED(CONFIG_FS_DAX)
>  static int log_dax(struct log_writes_c *lc, sector_t sector, size_t bytes,
>                    struct iov_iter *i)
>  {
> diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
> index 6660b6b53d5bf..f084607220293 100644
> --- a/drivers/md/dm-stripe.c
> +++ b/drivers/md/dm-stripe.c
> @@ -300,7 +300,7 @@ static int stripe_map(struct dm_target *ti, struct bio *bio)
>         return DM_MAPIO_REMAPPED;
>  }
>
> -#if IS_ENABLED(CONFIG_DAX_DRIVER)
> +#if IS_ENABLED(CONFIG_FS_DAX)
>  static long stripe_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
>                 long nr_pages, void **kaddr, pfn_t *pfn)
>  {
> diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> index 18320444fb0a9..4c3a6e33604d3 100644
> --- a/drivers/md/dm-writecache.c
> +++ b/drivers/md/dm-writecache.c
> @@ -38,7 +38,7 @@
>  #define BITMAP_GRANULARITY     PAGE_SIZE
>  #endif
>
> -#if IS_ENABLED(CONFIG_ARCH_HAS_PMEM_API) && IS_ENABLED(CONFIG_DAX_DRIVER)
> +#if IS_ENABLED(CONFIG_ARCH_HAS_PMEM_API) && IS_ENABLED(CONFIG_FS_DAX)
>  #define DM_WRITECACHE_HAS_PMEM
>  #endif
>
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 7870e6460633f..79737aee516b1 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1783,7 +1783,7 @@ static struct mapped_device *alloc_dev(int minor)
>         md->disk->private_data = md;
>         sprintf(md->disk->disk_name, "dm-%d", minor);
>
> -       if (IS_ENABLED(CONFIG_DAX_DRIVER)) {
> +       if (IS_ENABLED(CONFIG_FS_DAX)) {
>                 md->dax_dev = alloc_dax(md, md->disk->disk_name,
>                                         &dm_dax_ops, 0);
>                 if (IS_ERR(md->dax_dev))
> --
> 2.30.2
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
