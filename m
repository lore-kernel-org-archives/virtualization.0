Return-Path: <SRS0=15I4=NC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8880BC4338F
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 20:50:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 399386104F
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 20:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 399386104F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0129560807;
	Wed, 11 Aug 2021 20:50:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LewiTF0veNw7; Wed, 11 Aug 2021 20:50:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 62415607D2;
	Wed, 11 Aug 2021 20:50:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21B53C001A;
	Wed, 11 Aug 2021 20:50:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A5C7C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 20:50:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6212540205
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 20:50:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1CvsINouMZUT
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 20:50:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7202340343
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 20:50:05 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 fa24-20020a17090af0d8b0290178bfa69d97so7168118pjb.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 13:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=jZGeSAAU7onBeh3HEPoqzf+/vukmKvwMGLkowK3VOKk=;
 b=Bmi7pmufh9Vsbkan7zdQUnedlZy6ZAEm0WkhUIqSlFtVV3jbRI0H8Inizvdl5W5jIK
 mWdWQGpFkSQD8lcQXn+fWKKutAgxJHLB31xV/4DJghAuKaG3e1ztxjmv9YBsKLHs7o26
 mkgfB/xpiy8TqFo+r91GlPUZth84KA9fwQL7DwX5bDZnO1jIfJzn2LJ/A8NxewzgbI8h
 HQUMW7aEQZ3L4GADT03kZ0rQYrVymR9cY+XszhMVstVRRybC122nY1UjYs2BaS512A43
 1M04PEv3Q5lOxfV6+a0KgIVi8eyz9XSOZC1B2kpJ71genVNZMo6eZIDMQ5VavXEEiiqb
 rbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=jZGeSAAU7onBeh3HEPoqzf+/vukmKvwMGLkowK3VOKk=;
 b=UiAMgjwt+vo3F9a0W8LkOYddPHoUjZ3qmXkJc3YeH8uP3cYKXIwKq1IYlvs2Fh7ZYg
 j3DuMKPClHLaihfYaw2ARUlWVLVDTY+v4eZAD0eQnnJijkcXUaOkogQK6gtiYTR6I+v2
 mTBnOvu7bvzvWbub+yGt0xI/oTjvloA+Gx4lpdimmv/ix4SyIGyzk8hoY+zinThrl4xK
 qJqHWL2FWTA4CtCcZ2RWuI6ZDJHiP3jEFPYbk/k4jWrzG0T7cwmnDJkcDMyhBRrdX0dP
 XEmQpXQfdFLJyZU/wzEy5/t2GtlrGbsXDBF1nSjooU0nh/RzcfCivMkGcSl33Vx/u69E
 1X/A==
X-Gm-Message-State: AOAM530lJ31MqO/hOIlaWMJlvXy04e4oThfEAA/kGRlXzyjPDjJgBkz2
 L3lcSHfcgnxOCzc9Do+mnxyTVzMnDzo2yTcTK50=
X-Google-Smtp-Source: ABdhPJw0jxtaI8jh62pTfBhKY36OatS6rWfc8NgMCY3e2Xn1UAYHoax6bhFppW4uA2WO79GeVtcsWz4vsW4hf3J1cXw=
X-Received: by 2002:a63:40c1:: with SMTP id n184mr601477pga.74.1628715004856; 
 Wed, 11 Aug 2021 13:50:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90b:4c4e:0:0:0:0 with HTTP; Wed, 11 Aug 2021 13:50:04
 -0700 (PDT)
In-Reply-To: <20210811203612.138506-2-david@redhat.com>
References: <20210811203612.138506-1-david@redhat.com>
 <20210811203612.138506-2-david@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 11 Aug 2021 23:50:04 +0300
Message-ID: <CAHp75VdCMG==52RDea4b2Qyk+vQSX=DX1FB5uYG-HQy4cRk4bw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] /dev/mem: disallow access to explicitly excluded
 system RAM regions
To: David Hildenbrand <david@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Hanjun Guo <guohanjun@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>
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
Content-Type: multipart/mixed; boundary="===============8491942873029679770=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============8491942873029679770==
Content-Type: multipart/alternative; boundary="0000000000004e0d0f05c94ec38f"

--0000000000004e0d0f05c94ec38f
Content-Type: text/plain; charset="UTF-8"

On Wednesday, August 11, 2021, David Hildenbrand <david@redhat.com> wrote:

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
>
> Any range marked with "IORESOURCE_SYSTEM_RAM | IORESOURCE_EXCLUSIVE"
> will be excluded, even if not busy. For now, there are no applicable
> ranges and we'll modify virtio-mem next to properly set
> IORESOURCE_EXCLUSIVE on the parent resource.
>
> As next_resource() will iterate over children although we might want to
> skip a certain range completely, let's add and use
> next_range_skip_children() to optimize that case, avoding having to
> traverse subtrees that are not of interest.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/char/mem.c     | 22 +++++++++-------------
>  include/linux/ioport.h |  1 +
>  kernel/resource.c      | 42 ++++++++++++++++++++++++++++++++++++++++++
>  lib/Kconfig.debug      |  4 +++-
>  4 files changed, 55 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index 1c596b5cdb27..bb6d95daab45 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -60,13 +60,18 @@ static inline int valid_mmap_phys_addr_range(unsigned
> long pfn, size_t size)
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
> +       return !iomem_range_contains_excluded(PFN_PHYS(pfn), PAGE_SIZE);
>  }
> +
>  static inline int range_is_allowed(unsigned long pfn, unsigned long size)
>  {
> +#ifdef CONFIG_STRICT_DEVMEM
>         u64 from = ((u64)pfn) << PAGE_SHIFT;
>         u64 to = from + size;
>         u64 cursor = from;
> @@ -77,18 +82,9 @@ static inline int range_is_allowed(unsigned long pfn,
> unsigned long size)
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
> +       return !iomem_range_contains_excluded(PFN_PHYS(pfn), size);
>  }
> -#endif
>
>  #ifndef unxlate_dev_mem_ptr
>  #define unxlate_dev_mem_ptr unxlate_dev_mem_ptr
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 8359c50f9988..50523c28a5f1 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -308,6 +308,7 @@ extern struct resource * __devm_request_region(struct
> device *dev,
>  extern void __devm_release_region(struct device *dev, struct resource
> *parent,
>                                   resource_size_t start, resource_size_t
> n);
>  extern int iomem_map_sanity_check(resource_size_t addr, unsigned long
> size);
> +extern bool iomem_range_contains_excluded(u64 addr, u64 size);
>  extern bool iomem_is_exclusive(u64 addr);
>
>  extern int
> diff --git a/kernel/resource.c b/kernel/resource.c
> index ca9f5198a01f..2938cf520ca3 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -73,6 +73,13 @@ static struct resource *next_resource(struct resource
> *p)
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
>  static void *r_next(struct seq_file *m, void *v, loff_t *pos)
>  {
>         struct resource *p = v;
> @@ -1700,6 +1707,41 @@ int iomem_map_sanity_check(resource_size_t addr,
> unsigned long size)
>         return err;
>  }
>
> +/*
> + * Check if a physical memory range is completely excluded from getting
> + * mapped/accessed via /dev/mem.
> + */
> +bool iomem_range_contains_excluded(u64 addr, u64 size)
> +{
> +       const unsigned int flags = IORESOURCE_SYSTEM_RAM |
> IORESOURCE_EXCLUSIVE;
> +       bool excluded = false;
> +       struct resource *p;
> +
> +       read_lock(&resource_lock);
> +       for (p = iomem_resource.child; p ;) {



Same comment as per patch 3.


> +               if (p->start >= addr + size)
> +                       break;
> +               if (p->end < addr) {
> +                       /* No need to consider children */
> +                       p = next_resource_skip_children(p);
> +                       continue;
> +               }
> +               /*
> +                * A system RAM resource is excluded if
> IORESOURCE_EXCLUSIVE
> +                * is set, even if not busy and even if we don't have
> strict
> +                * checks enabled -- no ifs or buts.
> +                */
> +               if ((p->flags & flags) == flags) {
> +                       excluded = true;
> +                       break;
> +               }
> +               p = next_resource(p);
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
>           be used by people debugging the kernel. Note that with PAT
> support
>           enabled, even in this case there are restrictions on /dev/mem
> -         use due to the cache aliasing requirements.
> +         use due to the cache aliasing requirements. Further, some drivers
> +         will still restrict access to some physical memory regions either
> +         already used or to be used in the future as system RAM.
>
>           If this option is switched on, and IO_STRICT_DEVMEM=n, the
> /dev/mem
>           file only allows userspace access to PCI space and the BIOS code
> and
> --
> 2.31.1
>
>

-- 
With Best Regards,
Andy Shevchenko

--0000000000004e0d0f05c94ec38f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, August 11, 2021, David Hildenbrand &lt;<a href=3D"mai=
lto:david@redhat.com">david@redhat.com</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">virtio-mem dynamically exposes memory inside a device memory =
region as<br>
system RAM to Linux, coordinating with the hypervisor which parts are<br>
actually &quot;plugged&quot; and consequently usable/accessible. On the one=
 hand, the<br>
virtio-mem driver adds/removes whole memory blocks, creating/removing busy<=
br>
IORESOURCE_SYSTEM_RAM resources, on the other hand, it logically (un)plugs<=
br>
memory inside added memory blocks, dynamically either exposing them to<br>
the buddy or hiding them from the buddy and marking them PG_offline.<br>
<br>
virtio-mem wants to make sure that in a sane environment, nobody<br>
&quot;accidentially&quot; accesses unplugged memory inside the device manag=
ed<br>
region. After /proc/kcore has been sanitized and /dev/kmem has been<br>
removed, /dev/mem is the remaining interface that still allows uncontrolled=
<br>
access to the device-managed region of virtio-mem devices from user<br>
space.<br>
<br>
There is no known sane use case for mapping virtio-mem device memory<br>
via /dev/mem while virtio-mem driver concurrently (un)plugs memory inside<b=
r>
that region. So once the driver was loaded and detected the device<br>
along the device-managed region, we just want to disallow any access via<br=
>
/dev/mem to it.<br>
<br>
Let&#39;s add the basic infrastructure to exclude some physical memory<br>
regions completely from /dev/mem access, on any architecture and under<br>
any system configuration (independent of CONFIG_STRICT_DEVMEM and<br>
independent of &quot;iomem=3D&quot;).<br>
<br>
Any range marked with &quot;IORESOURCE_SYSTEM_RAM | IORESOURCE_EXCLUSIVE&qu=
ot;<br>
will be excluded, even if not busy. For now, there are no applicable<br>
ranges and we&#39;ll modify virtio-mem next to properly set<br>
IORESOURCE_EXCLUSIVE on the parent resource.<br>
<br>
As next_resource() will iterate over children although we might want to<br>
skip a certain range completely, let&#39;s add and use<br>
next_range_skip_children() to optimize that case, avoding having to<br>
traverse subtrees that are not of interest.<br>
<br>
Signed-off-by: David Hildenbrand &lt;<a href=3D"mailto:david@redhat.com">da=
vid@redhat.com</a>&gt;<br>
---<br>
=C2=A0drivers/char/mem.c=C2=A0 =C2=A0 =C2=A0| 22 +++++++++-------------<br>
=C2=A0include/linux/ioport.h |=C2=A0 1 +<br>
=C2=A0kernel/resource.c=C2=A0 =C2=A0 =C2=A0 | 42 ++++++++++++++++++++++++++=
++++<wbr>++++++++++++<br>
=C2=A0lib/Kconfig.debug=C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 +++-<br>
=C2=A04 files changed, 55 insertions(+), 14 deletions(-)<br>
<br>
diff --git a/drivers/char/mem.c b/drivers/char/mem.c<br>
index 1c596b5cdb27..bb6d95daab45 100644<br>
--- a/drivers/char/mem.c<br>
+++ b/drivers/char/mem.c<br>
@@ -60,13 +60,18 @@ static inline int valid_mmap_phys_addr_range(<wbr>unsig=
ned long pfn, size_t size)<br>
=C2=A0}<br>
=C2=A0#endif<br>
<br>
-#ifdef CONFIG_STRICT_DEVMEM<br>
=C2=A0static inline int page_is_allowed(unsigned long pfn)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return devmem_is_allowed(pfn);<br>
+#ifdef CONFIG_STRICT_DEVMEM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!devmem_is_allowed(pfn))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+#endif /* CONFIG_STRICT_DEVMEM */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return !iomem_range_contains_<wbr>excluded(PFN_=
PHYS(pfn), PAGE_SIZE);<br>
=C2=A0}<br>
+<br>
=C2=A0static inline int range_is_allowed(unsigned long pfn, unsigned long s=
ize)<br>
=C2=A0{<br>
+#ifdef CONFIG_STRICT_DEVMEM<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 from =3D ((u64)pfn) &lt;&lt; PAGE_SHIFT;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 to =3D from + size;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 cursor =3D from;<br>
@@ -77,18 +82,9 @@ static inline int range_is_allowed(unsigned long pfn, un=
signed long size)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cursor +=3D PAGE_SI=
ZE;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pfn++;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
-}<br>
-#else<br>
-static inline int page_is_allowed(unsigned long pfn)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
-}<br>
-static inline int range_is_allowed(unsigned long pfn, unsigned long size)<=
br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
+#endif /* CONFIG_STRICT_DEVMEM */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return !iomem_range_contains_<wbr>excluded(PFN_=
PHYS(pfn), size);<br>
=C2=A0}<br>
-#endif<br>
<br>
=C2=A0#ifndef unxlate_dev_mem_ptr<br>
=C2=A0#define unxlate_dev_mem_ptr unxlate_dev_mem_ptr<br>
diff --git a/include/linux/ioport.h b/include/linux/ioport.h<br>
index 8359c50f9988..50523c28a5f1 100644<br>
--- a/include/linux/ioport.h<br>
+++ b/include/linux/ioport.h<br>
@@ -308,6 +308,7 @@ extern struct resource * __devm_request_region(struct d=
evice *dev,<br>
=C2=A0extern void __devm_release_region(struct device *dev, struct resource=
 *parent,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resource_size_t start, resour=
ce_size_t n);<br>
=C2=A0extern int iomem_map_sanity_check(<wbr>resource_size_t addr, unsigned=
 long size);<br>
+extern bool iomem_range_contains_excluded(<wbr>u64 addr, u64 size);<br>
=C2=A0extern bool iomem_is_exclusive(u64 addr);<br>
<br>
=C2=A0extern int<br>
diff --git a/kernel/resource.c b/kernel/resource.c<br>
index ca9f5198a01f..2938cf520ca3 100644<br>
--- a/kernel/resource.c<br>
+++ b/kernel/resource.c<br>
@@ -73,6 +73,13 @@ static struct resource *next_resource(struct resource *p=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return p-&gt;sibling;<br>
=C2=A0}<br>
<br>
+static struct resource *next_resource_skip_children(<wbr>struct resource *=
p)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0while (!p-&gt;sibling &amp;&amp; p-&gt;parent)<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p =3D p-&gt;parent;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return p-&gt;sibling;<br>
+}<br>
+<br>
=C2=A0static void *r_next(struct seq_file *m, void *v, loff_t *pos)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct resource *p =3D v;<br>
@@ -1700,6 +1707,41 @@ int iomem_map_sanity_check(<wbr>resource_size_t addr=
, unsigned long size)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;<br>
=C2=A0}<br>
<br>
+/*<br>
+ * Check if a physical memory range is completely excluded from getting<br=
>
+ * mapped/accessed via /dev/mem.<br>
+ */<br>
+bool iomem_range_contains_excluded(<wbr>u64 addr, u64 size)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const unsigned int flags =3D IORESOURCE_SYSTEM_=
RAM | IORESOURCE_EXCLUSIVE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool excluded =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct resource *p;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0read_lock(&amp;resource_lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (p =3D iomem_resource.child; p ;) {</blockq=
uote><div><br></div><div><br></div><div>Same comment as per patch 3.</div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (p-&gt;start &gt=
;=3D addr + size)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (p-&gt;end &lt; =
addr) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* No need to consider children */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0p =3D next_resource_skip_children(p)<wbr>;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * A system RAM res=
ource is excluded if IORESOURCE_EXCLUSIVE<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * is set, even if =
not busy and even if we don&#39;t have strict<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * checks enabled -=
- no ifs or buts.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((p-&gt;flags &a=
mp; flags) =3D=3D flags) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0excluded =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p =3D next_resource=
(p);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0read_unlock(&amp;resource_lock);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return excluded;<br>
+}<br>
+<br>
=C2=A0#ifdef CONFIG_STRICT_DEVMEM<br>
=C2=A0static int strict_iomem_checks =3D 1;<br>
=C2=A0#else<br>
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug<br>
index 5ddd575159fb..d0ce6e23a6db 100644<br>
--- a/lib/Kconfig.debug<br>
+++ b/lib/Kconfig.debug<br>
@@ -1780,7 +1780,9 @@ config STRICT_DEVMEM<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 access to this is obviously disastrous, =
but specific access can<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 be used by people debugging the kernel. =
Note that with PAT support<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enabled, even in this case there are res=
trictions on /dev/mem<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0use due to the cache aliasing requiremen=
ts.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0use due to the cache aliasing requiremen=
ts. Further, some drivers<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0will still restrict access to some physi=
cal memory regions either<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0already used or to be used in the future=
 as system RAM.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 If this option is switched on, and IO_ST=
RICT_DEVMEM=3Dn, the /dev/mem<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file only allows userspace access to PCI=
 space and the BIOS code and<br>
-- <br>
2.31.1<br>
<br>
</blockquote><br><br>-- <br>With Best Regards,<br>Andy Shevchenko<br><br><b=
r>

--0000000000004e0d0f05c94ec38f--

--===============8491942873029679770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8491942873029679770==--
