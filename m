Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73101C433EF
	for <virtualization@archiver.kernel.org>; Wed, 20 Jul 2022 06:04:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EFBA0405A6;
	Wed, 20 Jul 2022 06:04:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EFBA0405A6
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DcT+Lhbc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mX1-X0tHJ5li; Wed, 20 Jul 2022 06:04:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 33C44405A5;
	Wed, 20 Jul 2022 06:04:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 33C44405A5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A890C0033;
	Wed, 20 Jul 2022 06:04:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42DBDC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 06:04:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1C56C8175E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 06:04:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C56C8175E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DcT+Lhbc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8Jf9Tn7tTyoJ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 06:04:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1D57E8175C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1D57E8175C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 06:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658297040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gb38UKRNv1Myphpxhs54+k5qSqfN6ylFDcrNHcncVsE=;
 b=DcT+LhbcVprRLcbFHWTypOpfCC6GCIvOuYAYwkWyC+GJogVD3EI6DkMOH9u1s3yF9Lp3uj
 3Rym3cywZWebl/00s1PWshlwsY/RGogxoHgNQu2KhSwYTIX41QqTjW4H/eWunbJt0s1Ia7
 sVAI/33BLSHDOSEtppWQUnpPUICoQzw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-FmEfO44VNsOYTvW6xuLAfQ-1; Wed, 20 Jul 2022 02:03:53 -0400
X-MC-Unique: FmEfO44VNsOYTvW6xuLAfQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 o20-20020ac24c54000000b0048a286ed00dso4834061lfk.14
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 23:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Gb38UKRNv1Myphpxhs54+k5qSqfN6ylFDcrNHcncVsE=;
 b=x5jesi+cMbMIbwEBKZTLMwGGQzUr1Grc+7cLLrM7a2TpCJu2d6KELoCbXuue+9HpYg
 Br8Mx7y8aNepir8z8oQ2RyjppL0dKcqPts6J7GK243O+9Ec/8+mE5tvuyuFCCaijvxYK
 7oyl1ie364PUtTPmoEttde7x1Wq8bVbSPfnXJ9MX/+q6ciu8XGXr0AS/7/FN4ODGv/gr
 wOVVfa8RYeN8OH+ujYUaHo9RX230bGmG6jL1KKxYax2UaTDbru/8//ZT0NORrlQXCl1t
 rMtOIUPa0a6CuO9t6rdpbAPJcMijS2QYMGWUbZhKwGQLsY4gEEDS6b9q9yTOpkuGJZ0K
 ARPQ==
X-Gm-Message-State: AJIora8eeGhJMHwbmIc4/4bMQqn7F2molpnc8q/ABxa73w5iFLcGzY1V
 4rqAAMXsMWQqcfBCkjaBl5T2Jjx3U6OzGRiDyplkPugPcgK8SNtleIKA5DF9dpHZyJLJRpuyBLj
 Auv6797yk5szCwB1HdKKCJRGR8KH8yjD2l6ampgxlusSBCvb+DJedW+nqgQ==
X-Received: by 2002:a05:6512:3f0e:b0:48a:5edd:99b2 with SMTP id
 y14-20020a0565123f0e00b0048a5edd99b2mr613009lfa.124.1658297031390; 
 Tue, 19 Jul 2022 23:03:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tiFBhubKd+yx90qUOeMnSEQR5UGF9w2hH/iwB1U/cT6rqs3h+jXVZCY6Jz3ePcSOoR/PkOYDO8cOG0TUVSkQw=
X-Received: by 2002:a05:6512:3f0e:b0:48a:5edd:99b2 with SMTP id
 y14-20020a0565123f0e00b0048a5edd99b2mr612996lfa.124.1658297031123; Tue, 19
 Jul 2022 23:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220720044144.90-1-xieyongji@bytedance.com>
 <20220720044144.90-4-xieyongji@bytedance.com>
In-Reply-To: <20220720044144.90-4-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Jul 2022 14:03:40 +0800
Message-ID: <CACGkMEsWs8vm9WeeHps5tj2wGGk-XRE95NNdJkPEuUbV794=zw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] vduse: Support using userspace pages as bounce
 buffer
To: Xie Yongji <xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>, Liu Xiaodong <xiaodong.liu@intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, songmuchun@bytedance.com
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

On Wed, Jul 20, 2022 at 12:42 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> Introduce two APIs: vduse_domain_add_user_bounce_pages()
> and vduse_domain_remove_user_bounce_pages() to support
> adding and removing userspace pages for bounce buffers.
> During adding and removing, the DMA data would be copied
> from the kernel bounce pages to the userspace bounce pages
> and back.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa_user/iova_domain.c | 96 +++++++++++++++++++++++++---
>  drivers/vdpa/vdpa_user/iova_domain.h |  8 +++
>  2 files changed, 96 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
> index 50d7c08d5450..e682bc7ee6c9 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -178,8 +178,9 @@ static void vduse_domain_bounce(struct vduse_iova_domain *domain,
>                             map->orig_phys == INVALID_PHYS_ADDR))
>                         return;
>
> -               addr = page_address(map->bounce_page) + offset;
> -               do_bounce(map->orig_phys + offset, addr, sz, dir);
> +               addr = kmap_local_page(map->bounce_page);
> +               do_bounce(map->orig_phys + offset, addr + offset, sz, dir);
> +               kunmap_local(addr);
>                 size -= sz;
>                 iova += sz;
>         }
> @@ -210,20 +211,23 @@ static struct page *
>  vduse_domain_get_bounce_page(struct vduse_iova_domain *domain, u64 iova)
>  {
>         struct vduse_bounce_map *map;
> -       struct page *page;
> +       struct page *page = NULL;
>
> +       read_lock(&domain->bounce_lock);
>         map = &domain->bounce_maps[iova >> PAGE_SHIFT];
> -       if (!map->bounce_page)
> -               return NULL;
> +       if (domain->user_bounce_pages || !map->bounce_page)
> +               goto out;
>
>         page = map->bounce_page;
>         get_page(page);
> +out:
> +       read_unlock(&domain->bounce_lock);
>
>         return page;
>  }
>
>  static void
> -vduse_domain_free_bounce_pages(struct vduse_iova_domain *domain)
> +vduse_domain_free_kernel_bounce_pages(struct vduse_iova_domain *domain)
>  {
>         struct vduse_bounce_map *map;
>         unsigned long pfn, bounce_pfns;
> @@ -243,6 +247,73 @@ vduse_domain_free_bounce_pages(struct vduse_iova_domain *domain)
>         }
>  }
>
> +int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
> +                                      struct page **pages, int count)
> +{
> +       struct vduse_bounce_map *map;
> +       int i, ret;
> +
> +       /* Now we don't support partial mapping */
> +       if (count != (domain->bounce_size >> PAGE_SHIFT))
> +               return -EINVAL;
> +
> +       write_lock(&domain->bounce_lock);
> +       ret = -EEXIST;
> +       if (domain->user_bounce_pages)
> +               goto out;
> +
> +       for (i = 0; i < count; i++) {
> +               map = &domain->bounce_maps[i];
> +               if (map->bounce_page) {
> +                       /* Copy kernel page to user page if it's in use */
> +                       if (map->orig_phys != INVALID_PHYS_ADDR)
> +                               memcpy_to_page(pages[i], 0,
> +                                              page_address(map->bounce_page),
> +                                              PAGE_SIZE);
> +                       __free_page(map->bounce_page);
> +               }
> +               map->bounce_page = pages[i];
> +               get_page(pages[i]);
> +       }
> +       domain->user_bounce_pages = true;
> +       ret = 0;
> +out:
> +       write_unlock(&domain->bounce_lock);
> +
> +       return ret;
> +}
> +
> +void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain)
> +{
> +       struct vduse_bounce_map *map;
> +       unsigned long i, count;
> +
> +       write_lock(&domain->bounce_lock);
> +       if (!domain->user_bounce_pages)
> +               goto out;
> +
> +       count = domain->bounce_size >> PAGE_SHIFT;
> +       for (i = 0; i < count; i++) {
> +               struct page *page = NULL;
> +
> +               map = &domain->bounce_maps[i];
> +               if (WARN_ON(!map->bounce_page))
> +                       continue;
> +
> +               /* Copy user page to kernel page if it's in use */
> +               if (map->orig_phys != INVALID_PHYS_ADDR) {
> +                       page = alloc_page(GFP_ATOMIC | __GFP_NOFAIL);
> +                       memcpy_from_page(page_address(page),
> +                                        map->bounce_page, 0, PAGE_SIZE);
> +               }
> +               put_page(map->bounce_page);
> +               map->bounce_page = page;
> +       }
> +       domain->user_bounce_pages = false;
> +out:
> +       write_unlock(&domain->bounce_lock);
> +}
> +
>  void vduse_domain_reset_bounce_map(struct vduse_iova_domain *domain)
>  {
>         if (!domain->bounce_map)
> @@ -318,13 +389,18 @@ dma_addr_t vduse_domain_map_page(struct vduse_iova_domain *domain,
>         if (vduse_domain_init_bounce_map(domain))
>                 goto err;
>
> +       read_lock(&domain->bounce_lock);
>         if (vduse_domain_map_bounce_page(domain, (u64)iova, (u64)size, pa))
> -               goto err;
> +               goto err_unlock;
>
>         if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)
>                 vduse_domain_bounce(domain, iova, size, DMA_TO_DEVICE);
>
> +       read_unlock(&domain->bounce_lock);
> +
>         return iova;
> +err_unlock:
> +       read_unlock(&domain->bounce_lock);
>  err:
>         vduse_domain_free_iova(iovad, iova, size);
>         return DMA_MAPPING_ERROR;
> @@ -336,10 +412,12 @@ void vduse_domain_unmap_page(struct vduse_iova_domain *domain,
>  {
>         struct iova_domain *iovad = &domain->stream_iovad;
>
> +       read_lock(&domain->bounce_lock);
>         if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
>                 vduse_domain_bounce(domain, dma_addr, size, DMA_FROM_DEVICE);
>
>         vduse_domain_unmap_bounce_page(domain, (u64)dma_addr, (u64)size);
> +       read_unlock(&domain->bounce_lock);
>         vduse_domain_free_iova(iovad, dma_addr, size);
>  }
>
> @@ -447,7 +525,8 @@ static int vduse_domain_release(struct inode *inode, struct file *file)
>
>         spin_lock(&domain->iotlb_lock);
>         vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
> -       vduse_domain_free_bounce_pages(domain);
> +       vduse_domain_remove_user_bounce_pages(domain);
> +       vduse_domain_free_kernel_bounce_pages(domain);
>         spin_unlock(&domain->iotlb_lock);
>         put_iova_domain(&domain->stream_iovad);
>         put_iova_domain(&domain->consistent_iovad);
> @@ -507,6 +586,7 @@ vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
>                 goto err_file;
>
>         domain->file = file;
> +       rwlock_init(&domain->bounce_lock);
>         spin_lock_init(&domain->iotlb_lock);
>         init_iova_domain(&domain->stream_iovad,
>                         PAGE_SIZE, IOVA_START_PFN);
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
> index 2722d9b8e21a..4e0e50e7ac15 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.h
> +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> @@ -14,6 +14,7 @@
>  #include <linux/iova.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/vhost_iotlb.h>
> +#include <linux/rwlock.h>
>
>  #define IOVA_START_PFN 1
>
> @@ -34,6 +35,8 @@ struct vduse_iova_domain {
>         struct vhost_iotlb *iotlb;
>         spinlock_t iotlb_lock;
>         struct file *file;
> +       bool user_bounce_pages;
> +       rwlock_t bounce_lock;
>  };
>
>  int vduse_domain_set_map(struct vduse_iova_domain *domain,
> @@ -61,6 +64,11 @@ void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
>
>  void vduse_domain_reset_bounce_map(struct vduse_iova_domain *domain);
>
> +int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
> +                                      struct page **pages, int count);
> +
> +void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain);
> +
>  void vduse_domain_destroy(struct vduse_iova_domain *domain);
>
>  struct vduse_iova_domain *vduse_domain_create(unsigned long iova_limit,
> --
> 2.20.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
