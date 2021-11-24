Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F510C433EF
	for <virtualization@archiver.kernel.org>; Wed, 24 Nov 2021 03:22:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A2B380DF9;
	Wed, 24 Nov 2021 03:22:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7YrZqC0ogiVf; Wed, 24 Nov 2021 03:22:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A70E380CFB;
	Wed, 24 Nov 2021 03:22:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B3CAC002E;
	Wed, 24 Nov 2021 03:22:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59163C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 03:22:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3AE3960AAD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 03:22:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EM2gBGbf5fCu
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 03:21:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 79A8860AA8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 03:21:59 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 w33-20020a17090a6ba400b001a722a06212so3362368pjj.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 19:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EL31Cy62VKrYRYptuLHbJfb/IYu8BUfyrtV7sdQIaLc=;
 b=tTzNJ2xX5PU2ZMtodj9dANcIKZZwQKRHX4lB/NL5LZNN4Zr1VE+P5ovmtCw8EES+Wi
 NQ80+oi4ntIVYsB1h9MkMbp03nngY0IViVo2xEBceq5t5+uhw3UVcNgcwXpITZJ3CCyC
 SpZn8KQKXy9b4rqCakALc7KqdS6D7C5QHJit1vCpGIDnMWhrdqyaarz+LrZmWI3mEXOm
 ygI9Ibrs/NzMWc7N8tOq7qOYtk6nUBQRWJgA2OarsoGDF20YgKNLJkU8STlFqZsVqk64
 ncL/ACZOLTjitKw6c3ssSTeyj3d8bbWUIk03dhK9dD82q1d41Wmi7s8ZhTarVWeBvFfe
 SvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EL31Cy62VKrYRYptuLHbJfb/IYu8BUfyrtV7sdQIaLc=;
 b=wMwJ9Th+ms7GxjMNNMrLy/JOCeC8cbDNTxur4RkESNT5AibmCSHqAs7xKaDWPfcpEF
 +F2hHvc4Vtiq3TC1uvJVvjJLx4sMZfV5gweR1muGJVc/cXTI9O5xMnaR5+5Z3bHcMWCl
 Cu3ssTd2RtIH79pcI7I9ooMzqIVNTjDeaG/Jvve1k3FmgdzBykaFcnAV7dFMZfXBF1fB
 8cCeZ4LY6tTcIfrCUmTQV3Vj7bjY3tWJCfaZxxfR8N+w8T1hqlPSdl/9YkCJXbajLP2m
 E3ibH516lsqX7XgvUZHGnQS42J8mEcy39dRyc9dkc8uNZitwZ9pb04DtAV7RxvXIMBbC
 FBAA==
X-Gm-Message-State: AOAM533GLGsUF2rrisB/rJ23/XA+F6805JqOM4LPaimpV4FW2WyOwUbB
 BOrEtL0yTanwM0kkopvTF0zcY9BnG24CZq7eg+fm7g==
X-Google-Smtp-Source: ABdhPJy2aFen0PqWttd8BjEdIQsqphuBXqzJVHlhc+QCr5UJA27t1P+Fp9qpkknnP9tnEfW8e0xOGoy/eRGZQ5QtCf0=
X-Received: by 2002:a17:90b:1e49:: with SMTP id
 pi9mr3873250pjb.220.1637724118856; 
 Tue, 23 Nov 2021 19:21:58 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-27-hch@lst.de>
In-Reply-To: <20211109083309.584081-27-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Nov 2021 19:21:47 -0800
Message-ID: <CAPcyv4hHQMngb634K87hJkEgQEhMkGKft30JCbFy2eEXA57oKA@mail.gmail.com>
Subject: Re: [PATCH 26/29] fsdax: shift partition offset handling into the
 file systems
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
> Remove the last user of ->bdev in dax.c by requiring the file system to
> pass in an address that already includes the DAX offset.  As part of the
> only set ->bdev or ->daxdev when actually required in the ->iomap_begin
> methods.

Changes look good except for what looks like an argument position
fixup needed for an xfs_bmbt_to_iomap() caller below...

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/dax.c                 |  6 +-----
>  fs/erofs/data.c          | 11 ++++++++--
>  fs/erofs/internal.h      |  1 +
>  fs/ext2/inode.c          |  8 +++++--
>  fs/ext4/inode.c          | 16 +++++++++-----
>  fs/xfs/libxfs/xfs_bmap.c |  4 ++--
>  fs/xfs/xfs_aops.c        |  2 +-
>  fs/xfs/xfs_iomap.c       | 45 +++++++++++++++++++++++++---------------
>  fs/xfs/xfs_iomap.h       |  5 +++--
>  fs/xfs/xfs_pnfs.c        |  2 +-
>  10 files changed, 63 insertions(+), 37 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index 0bd6cdcbacfc4..2c13c681edf09 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -711,11 +711,7 @@ int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
>
>  static pgoff_t dax_iomap_pgoff(const struct iomap *iomap, loff_t pos)
>  {
> -       phys_addr_t paddr = iomap->addr + (pos & PAGE_MASK) - iomap->offset;
> -
> -       if (iomap->bdev)
> -               paddr += (get_start_sect(iomap->bdev) << SECTOR_SHIFT);
> -       return PHYS_PFN(paddr);
> +       return PHYS_PFN(iomap->addr + (pos & PAGE_MASK) - iomap->offset);
>  }
>
>  static int copy_cow_page_dax(struct vm_fault *vmf, const struct iomap_iter *iter)
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 0e35ef3f9f3d7..9b1bb177ce303 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
[..]
               }
> @@ -215,9 +218,13 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>         if (ret)
>                 return ret;
>
> -       iomap->bdev = mdev.m_bdev;
> -       iomap->dax_dev = mdev.m_daxdev;
>         iomap->offset = map.m_la;
> +       if (flags & IOMAP_DAX) {
> +               iomap->dax_dev = mdev.m_daxdev;
> +               iomap->offset += mdev.m_dax_part_off;
> +       } else {
> +               iomap->bdev = mdev.m_bdev;
> +       }

Ah, that's what IOMAP_DAX is for, to stop making iomap carry bdev
details unnecessarily.

[..]
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 704292c6ce0c7..74dbf1fd99d39 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -54,7 +54,8 @@ xfs_bmbt_to_iomap(
>         struct xfs_inode        *ip,
>         struct iomap            *iomap,
>         struct xfs_bmbt_irec    *imap,
> -       u16                     flags)
> +       unsigned int            flags,
> +       u16                     iomap_flags)

It would be nice if the compiler could help with making sure that
right 'flags' values are passed to the right 'flags' parameter, but I
can't think of

[..]
> @@ -1053,23 +1061,24 @@ xfs_buffered_write_iomap_begin(
>          */
>         xfs_iunlock(ip, XFS_ILOCK_EXCL);
>         trace_xfs_iomap_alloc(ip, offset, count, allocfork, &imap);
> -       return xfs_bmbt_to_iomap(ip, iomap, &imap, IOMAP_F_NEW);
> +       return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_NEW);
>
>  found_imap:
>         xfs_iunlock(ip, XFS_ILOCK_EXCL);
> -       return xfs_bmbt_to_iomap(ip, iomap, &imap, 0);
> +       return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0);

The iomap flags are supposed to be the last argument, right?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
