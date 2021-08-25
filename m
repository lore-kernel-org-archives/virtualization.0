Return-Path: <SRS0=Jt+z=NQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFACFC4338F
	for <virtualization@archiver.kernel.org>; Wed, 25 Aug 2021 00:58:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 593FC611AF
	for <virtualization@archiver.kernel.org>; Wed, 25 Aug 2021 00:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 593FC611AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1976F404ED;
	Wed, 25 Aug 2021 00:58:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y8NwkYPnDYxw; Wed, 25 Aug 2021 00:58:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 98D54404F0;
	Wed, 25 Aug 2021 00:58:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F8D5C001A;
	Wed, 25 Aug 2021 00:58:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41BA0C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 00:58:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 21C046138B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 00:58:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PzUvbSEm8yvA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 00:58:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E84C260B56
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 00:58:28 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id e1so6385043plt.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 17:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ob71979d90MnjOj85r+vOA9BYCgvaQIkyLQCHH+jqss=;
 b=lFFRGGzjrWGffuC8/K65BQQRki3zaQoEIJJxn/JB8Z9FJCYIyv21SAyBd8wMvprRpz
 39S3+pYiU0YP7bSg1qvuKs537qZy4BCcwyyNH1MPWoftDDHbwk7gZfYOI7bNJ3YtIc6T
 cuGaW7xPWpGZK41lD4UKG2TuLU/VI7iH4zVJ9l4ha4Zuwo1SEhwNXNynYDXdA0++zZ8s
 KjuDGm5qTckmXAaOLVt0cqYac4UZPkjQFSkrz8HvbW0wXVU5LskmmhXjT3jkeS33IQDt
 bFny6TgBjzOeaT7cMEA60GRacuVSU8Rd/e6d3FDTqGYjIWgl+CswTQQXmqVBZTcg4TqX
 hTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ob71979d90MnjOj85r+vOA9BYCgvaQIkyLQCHH+jqss=;
 b=U2AsVsYYVGZz63pSMlg0vLctYLjGWGvrNShQsAW+76V4Ze3llywid1k1S3/hsilSfY
 Zd18NKqMF4WiD6ejfRp13Mjcz6V7WJPk2HnHS/vb+FxcFNw5r3jo0ZzrnkKuQ8HV9RBX
 YOKCjBKRPlhB0oKlDlpTaRlC/IPS9HzM20Xkvyu701wPkPj/cU4J4Fm7ggVrZvCGXjmt
 FkDSftwkT4smFFsbww6Xw25guUD0WDT6h2S8Ufc3UlXbb3cO5MuRK45J90fnqcAygO7U
 HCgCBEednetacGSYxQxYmWmuQYHTcD5jgW6L+h84zMMvEbgtrEiDQ+7TxQAcNy3YObq6
 cVEg==
X-Gm-Message-State: AOAM533rIsykA6uKGcLkh/wI+p/s2HmSeJBvAyfCoLG4UuAHxqmMvlH7
 5lLQCT/tpD4Jg6vqMUXQfmNoSNcXBSJq4E9PNA5z9Q==
X-Google-Smtp-Source: ABdhPJxuZMTAhxvYtO4b94zLojEvlooMoigU04ezc3LW3HHFIgnsCDKSpuGuZRfSdRqkCYTPvvJxJGUOfUHf9APl8R4=
X-Received: by 2002:a17:902:edd0:b0:135:b351:bd5a with SMTP id
 q16-20020a170902edd000b00135b351bd5amr7583692plk.52.1629853108334; Tue, 24
 Aug 2021 17:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210816142505.28359-1-david@redhat.com>
 <20210816142505.28359-2-david@redhat.com>
In-Reply-To: <20210816142505.28359-2-david@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 24 Aug 2021 17:58:17 -0700
Message-ID: <CAPcyv4jfPSanWFNopzShtGiMDjwRuaci2n6hF3FCxsm1cG-ydg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] /dev/mem: disallow access to explicitly excluded
 system RAM regions
To: David Hildenbrand <david@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Linux MM <linux-mm@kvack.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Hanjun Guo <guohanjun@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>
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

On Mon, Aug 16, 2021 at 7:25 AM David Hildenbrand <david@redhat.com> wrote:
>
> virtio-mem dynamically exposes memory inside a device memory region as
> system RAM to Linux, coordinating with the hypervisor which parts are
> actually "plugged" and consequently usable/accessible. On the one hand, the
> virtio-mem driver adds/removes whole memory blocks, creating/removing busy
> IORESOURCE_SYSTEM_RAM resources, on the other hand, it logically (un)plugs
> memory inside added memory blocks, dynamically either exposing them to
> the buddy or hiding them from the buddy and marking them PG_offline.
>
> virtio-mem wants to make sure that in a sane environment, nobody
> "accidentially" accesses unplugged memory inside the device managed
> region. After /proc/kcore has been sanitized and /dev/kmem has been
> removed, /dev/mem is the remaining interface that still allows uncontrolled
> access to the device-managed region of virtio-mem devices from user
> space.
>
> There is no known sane use case for mapping virtio-mem device memory
> via /dev/mem while virtio-mem driver concurrently (un)plugs memory inside
> that region. So once the driver was loaded and detected the device
> along the device-managed region, we just want to disallow any access via
> /dev/mem to it.
>
> Let's add the basic infrastructure to exclude some physical memory
> regions completely from /dev/mem access, on any architecture and under
> any system configuration (independent of CONFIG_STRICT_DEVMEM and
> independent of "iomem=").

I'm certainly on team "/dev/mem considered harmful", but this approach
feels awkward. It feels wrong for being non-committal about whether
CONFIG_STRICT_DEVMEM is in wide enough use that the safety can be
turned on all the time, and the configuration option dropped, or there
are users clinging onto /dev/mem where they expect to be able to build
a debug kernel to turn all of these restrictions off, even the
virtio-mem ones. This splits the difference and says some /dev/mem
accesses are always disallowed for "reasons", but I could say the same
thing about pmem, there's no sane reason to allow /dev/mem which has
no idea about the responsibilities of properly touching pmem to get
access to it.


>
> Any range marked with "IORESOURCE_SYSTEM_RAM | IORESOURCE_EXCLUSIVE"
> will be excluded, even if not busy. For now, there are no applicable
> ranges and we'll modify virtio-mem next to properly set
> IORESOURCE_EXCLUSIVE on the parent resource.
>
> As next_resource() will iterate over children although we might want to
> skip a certain range completely, let's add and use
> next_range_skip_children() and for_each_resource(), to optimize that case,
> avoding having to traverse subtrees that are not of interest.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/char/mem.c     | 22 ++++++++------------
>  include/linux/ioport.h |  1 +
>  kernel/resource.c      | 47 ++++++++++++++++++++++++++++++++++++++++++
>  lib/Kconfig.debug      |  4 +++-
>  4 files changed, 60 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index 1c596b5cdb27..1829dc6a1f29 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -60,13 +60,18 @@ static inline int valid_mmap_phys_addr_range(unsigned long pfn, size_t size)
>  }
>  #endif
>
> -#ifdef CONFIG_STRICT_DEVMEM
>  static inline int page_is_allowed(unsigned long pfn)
>  {
> -       return devmem_is_allowed(pfn);
> +#ifdef CONFIG_STRICT_DEVMEM
> +       if (!devmem_is_allowed(pfn))
> +               return 0;
> +#endif /* CONFIG_STRICT_DEVMEM */
> +       return !iomem_range_contains_excluded_devmem(PFN_PHYS(pfn), PAGE_SIZE);
>  }
> +
>  static inline int range_is_allowed(unsigned long pfn, unsigned long size)
>  {
> +#ifdef CONFIG_STRICT_DEVMEM
>         u64 from = ((u64)pfn) << PAGE_SHIFT;
>         u64 to = from + size;
>         u64 cursor = from;
> @@ -77,18 +82,9 @@ static inline int range_is_allowed(unsigned long pfn, unsigned long size)
>                 cursor += PAGE_SIZE;
>                 pfn++;
>         }
> -       return 1;
> -}
> -#else
> -static inline int page_is_allowed(unsigned long pfn)
> -{
> -       return 1;
> -}
> -static inline int range_is_allowed(unsigned long pfn, unsigned long size)
> -{
> -       return 1;
> +#endif /* CONFIG_STRICT_DEVMEM */
> +       return !iomem_range_contains_excluded_devmem(PFN_PHYS(pfn), size);
>  }
> -#endif
>
>  #ifndef unxlate_dev_mem_ptr
>  #define unxlate_dev_mem_ptr unxlate_dev_mem_ptr
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 8359c50f9988..d31f83281327 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -308,6 +308,7 @@ extern struct resource * __devm_request_region(struct device *dev,
>  extern void __devm_release_region(struct device *dev, struct resource *parent,
>                                   resource_size_t start, resource_size_t n);
>  extern int iomem_map_sanity_check(resource_size_t addr, unsigned long size);
> +extern bool iomem_range_contains_excluded_devmem(u64 addr, u64 size);
>  extern bool iomem_is_exclusive(u64 addr);
>
>  extern int
> diff --git a/kernel/resource.c b/kernel/resource.c
> index ca9f5198a01f..f57a14617c49 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -73,6 +73,18 @@ static struct resource *next_resource(struct resource *p)
>         return p->sibling;
>  }
>
> +static struct resource *next_resource_skip_children(struct resource *p)
> +{
> +       while (!p->sibling && p->parent)
> +               p = p->parent;
> +       return p->sibling;
> +}
> +
> +#define for_each_resource(_root, _p, _skip_children) \
> +       for ((_p) = (_root)->child; (_p); \
> +            (_p) = (_skip_children) ? next_resource_skip_children(_p) : \
> +                                      next_resource(_p))
> +
>  static void *r_next(struct seq_file *m, void *v, loff_t *pos)
>  {
>         struct resource *p = v;
> @@ -1700,6 +1712,41 @@ int iomem_map_sanity_check(resource_size_t addr, unsigned long size)
>         return err;
>  }
>
> +/*
> + * Check if a physical memory range is completely excluded from getting
> + * mapped/accessed via /dev/mem.
> + */
> +bool iomem_range_contains_excluded_devmem(u64 addr, u64 size)
> +{
> +       const unsigned int flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_EXCLUSIVE;
> +       bool skip_children = false, excluded = false;
> +       struct resource *p;
> +
> +       read_lock(&resource_lock);
> +       for_each_resource(&iomem_resource, p, skip_children) {
> +               if (p->start >= addr + size)
> +                       break;
> +               if (p->end < addr) {
> +                       skip_children = true;
> +                       continue;
> +               }
> +               skip_children = false;
> +
> +               /*
> +                * A system RAM resource is excluded if IORESOURCE_EXCLUSIVE
> +                * is set, even if not busy and even if we don't have strict
> +                * checks enabled -- no ifs or buts.
> +                */
> +               if ((p->flags & flags) == flags) {
> +                       excluded = true;
> +                       break;
> +               }
> +       }
> +       read_unlock(&resource_lock);
> +
> +       return excluded;
> +}
> +
>  #ifdef CONFIG_STRICT_DEVMEM
>  static int strict_iomem_checks = 1;
>  #else
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 5ddd575159fb..d0ce6e23a6db 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1780,7 +1780,9 @@ config STRICT_DEVMEM
>           access to this is obviously disastrous, but specific access can
>           be used by people debugging the kernel. Note that with PAT support
>           enabled, even in this case there are restrictions on /dev/mem
> -         use due to the cache aliasing requirements.
> +         use due to the cache aliasing requirements. Further, some drivers
> +         will still restrict access to some physical memory regions either
> +         already used or to be used in the future as system RAM.
>
>           If this option is switched on, and IO_STRICT_DEVMEM=n, the /dev/mem
>           file only allows userspace access to PCI space and the BIOS code and
> --
> 2.31.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
