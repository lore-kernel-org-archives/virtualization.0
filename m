Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0318BC433F5
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 19:35:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61B484058B;
	Tue, 23 Nov 2021 19:35:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SNNBrwpWsgNN; Tue, 23 Nov 2021 19:35:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E6545403F9;
	Tue, 23 Nov 2021 19:35:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4311C002E;
	Tue, 23 Nov 2021 19:35:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A98C0C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 19:35:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8320580E3D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 19:35:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2lccU7Z67iuW
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 19:35:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CD50280D27
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 19:35:54 +0000 (UTC)
Received: by mail-pf1-x436.google.com with SMTP id z6so275968pfe.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 11:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5gWZdeoaC7jqVM8zeJ3InHmY5XgJ6AqsmAXMbMD6MVc=;
 b=RJbNLKJNENQkqCXxCv3ZqjAgJzmntRoY3C9WBVTRGPV4VV3BsA76Ni4hsnMjx2nH/v
 HoiW9wDtjxXp5Nt6qMkQL0DPLfSBqYL70YxFRSH4TO9PJ9rbhGeY0C9ffVxxiP3dggG6
 ohinBGy+D49Vm9oB3XNJcjF56eTmII8MaKy/6svWS/35apN6jxq7L2Jsl7ZSria5TcBs
 sLOxMGIhfsaMyGw+N0BmXXRNkuqqf4hp2KFJVKWMR0zMfA+xCeAOOLZYbsOOHncwIK6l
 JAuPbkyAWXwtk4Cvm6LivVMjAyUckXc1oEC/hdIwN1ZU2iT426Roiy5HqofbB7cbAMCs
 R42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5gWZdeoaC7jqVM8zeJ3InHmY5XgJ6AqsmAXMbMD6MVc=;
 b=Qz/b7Fju5Xl9mlfHLbAH/iKVelpbQC3X6CSlnt+DGcvQWuPGT5zAUdXghPcwAWWqo2
 W+MkEAZTkEWKhUaUNsH11Gjtwx3sdwdT3u4v9xie3sOJD/zWrbESeklLb7MHPCtDOQWr
 2LtjZ8sX+pO/ylvp8r6cdd9SCY6VF4kyuHAmh29ixVWyS84/qyFwW8cLaqAquWM01BS4
 KjgFyY/diDu8z5QCHNYvHXqtKPCmSwCWPUiQQ/nTznNZ+zMRWjvieK8+c3fPZxpd6Id4
 5FboYs/pBihrYZlGu9bjGN7JYngLfOjEC9gGHY9n+QrtQzZTctQmd9Mdm3RX87Pxoox+
 eF/Q==
X-Gm-Message-State: AOAM531DqCSZ5Eo6KYTFn86I0qCCcWII2i2Q3hAUTDKSGAMv4kwzNJyO
 FPtVoJaiBCbvGvDuXula2VYGYUs+o4axKSJkvR4Jsw==
X-Google-Smtp-Source: ABdhPJyUgiLjRKYUsHsrV83l3gO1RrPxkMBAXyAi/veRroUOh2xEn4EazOAyxkpoKqaxXeG2LfQdh/0f6yLjguWrfLs=
X-Received: by 2002:a63:5401:: with SMTP id i1mr5642151pgb.356.1637696154262; 
 Tue, 23 Nov 2021 11:35:54 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-14-hch@lst.de>
In-Reply-To: <20211109083309.584081-14-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Nov 2021 11:35:43 -0800
Message-ID: <CAPcyv4i=PnXu6ixHtj4Bqi0gy=bJJijrWgTNEcQ6uEJiut4PfQ@mail.gmail.com>
Subject: Re: [PATCH 13/29] fsdax: use a saner calling convention for
 copy_cow_page_dax
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
> Just pass the vm_fault and iomap_iter structures, and figure out the rest
> locally.  Note that this requires moving dax_iomap_sector up in the file.

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/dax.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index 73bd1439d8089..e51b4129d1b65 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -709,26 +709,31 @@ int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
>         return __dax_invalidate_entry(mapping, index, false);
>  }
>
> -static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_dev,
> -                            sector_t sector, struct page *to, unsigned long vaddr)
> +static sector_t dax_iomap_sector(const struct iomap *iomap, loff_t pos)
>  {
> +       return (iomap->addr + (pos & PAGE_MASK) - iomap->offset) >> 9;
> +}
> +
> +static int copy_cow_page_dax(struct vm_fault *vmf, const struct iomap_iter *iter)
> +{
> +       sector_t sector = dax_iomap_sector(&iter->iomap, iter->pos);
>         void *vto, *kaddr;
>         pgoff_t pgoff;
>         long rc;
>         int id;
>
> -       rc = bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
> +       rc = bdev_dax_pgoff(iter->iomap.bdev, sector, PAGE_SIZE, &pgoff);
>         if (rc)
>                 return rc;
>
>         id = dax_read_lock();
> -       rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
> +       rc = dax_direct_access(iter->iomap.dax_dev, pgoff, 1, &kaddr, NULL);
>         if (rc < 0) {
>                 dax_read_unlock(id);
>                 return rc;
>         }
> -       vto = kmap_atomic(to);
> -       copy_user_page(vto, kaddr, vaddr, to);
> +       vto = kmap_atomic(vmf->cow_page);
> +       copy_user_page(vto, kaddr, vmf->address, vmf->cow_page);
>         kunmap_atomic(vto);
>         dax_read_unlock(id);
>         return 0;
> @@ -1005,11 +1010,6 @@ int dax_writeback_mapping_range(struct address_space *mapping,
>  }
>  EXPORT_SYMBOL_GPL(dax_writeback_mapping_range);
>
> -static sector_t dax_iomap_sector(const struct iomap *iomap, loff_t pos)
> -{
> -       return (iomap->addr + (pos & PAGE_MASK) - iomap->offset) >> 9;
> -}
> -
>  static int dax_iomap_pfn(const struct iomap *iomap, loff_t pos, size_t size,
>                          pfn_t *pfnp)
>  {
> @@ -1332,19 +1332,16 @@ static vm_fault_t dax_fault_synchronous_pfnp(pfn_t *pfnp, pfn_t pfn)
>  static vm_fault_t dax_fault_cow_page(struct vm_fault *vmf,
>                 const struct iomap_iter *iter)
>  {
> -       sector_t sector = dax_iomap_sector(&iter->iomap, iter->pos);
> -       unsigned long vaddr = vmf->address;
>         vm_fault_t ret;
>         int error = 0;
>
>         switch (iter->iomap.type) {
>         case IOMAP_HOLE:
>         case IOMAP_UNWRITTEN:
> -               clear_user_highpage(vmf->cow_page, vaddr);
> +               clear_user_highpage(vmf->cow_page, vmf->address);
>                 break;
>         case IOMAP_MAPPED:
> -               error = copy_cow_page_dax(iter->iomap.bdev, iter->iomap.dax_dev,
> -                                         sector, vmf->cow_page, vaddr);
> +               error = copy_cow_page_dax(vmf, iter);
>                 break;
>         default:
>                 WARN_ON_ONCE(1);
> --
> 2.30.2
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
