Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C1DC433F5
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 03:25:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75B3A60AC2;
	Tue, 22 Feb 2022 03:25:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e4ExzmPIiNwF; Tue, 22 Feb 2022 03:25:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E2C8260A84;
	Tue, 22 Feb 2022 03:25:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6717C001A;
	Tue, 22 Feb 2022 03:25:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9082C0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 03:25:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A124D60A84
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 03:25:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GrX-QOpHiFUO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 03:25:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9151460AC2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 03:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645500331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LxxD0HcoaZKzQBhxL2/4ZeGyUXomH65XBCY4hjiGwFA=;
 b=HcEbZn9zwNix+37/R6iqHbJGg4QMQJcD0UcmAud0qKHNi1JkEpTQXCeVovvwBb4RB55/P1
 QGz8mJSDRzbhD/PoAmnP7gyjilt9GMLKH9420KgQZgoaW4MzDLnEiaBcUaLjp2xhfA8M+G
 BXEU+BkLiTuAnvhNTtciDmiWOtDnGQE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-kt2VVbcJMAqd3YAsX6Aoww-1; Mon, 21 Feb 2022 22:25:29 -0500
X-MC-Unique: kt2VVbcJMAqd3YAsX6Aoww-1
Received: by mail-lj1-f197.google.com with SMTP id
 q17-20020a2e7511000000b0023c95987502so4997235ljc.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 19:25:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LxxD0HcoaZKzQBhxL2/4ZeGyUXomH65XBCY4hjiGwFA=;
 b=tyjWjHhX6im3wes3Gjz0czOKD7fqE81AFydY0JQMJ5KA6KNmDTOoRxZBFS56AgJJg+
 cGmP3VJWgasYyd0OZypInaZlyl7O5UuOiVBDGwHx73JBi15Jddu4vmS3MycU2jSpoR6M
 L7r1mKyk+03gMzaBWG3yzeCO6DPf28mn6qcblGQbesaG8XMKaVr+ZeXc5/my7a6go2fQ
 y04TFbosXouWjj5y4o1VE8r7YTzIbJZKsBn5w+BPRQpDKtH5VAyKYv2ljLh3hhWGysD6
 A+jc8zOO81KZtt2pUx58S/aiLLetsHsaNnXP9txTf2OSejhYkRkxCkIw4jCYAYgokGj/
 CRsA==
X-Gm-Message-State: AOAM530I/S7647yRaty8YhSm1/A4sQcZawBhIpB1o6ROyYamtsujf9kF
 wfYhoFgyhknvSV6Iu8P94YU/3dHNYMpn1kI4NcfJk/v6GJw5OzOAJ7N1eud4MSNt0RKILI8OB7+
 JkO1eNyjLXeP9qyYKbPgFJt0N34/94sIiVr0NMbFCrZNRWbzjIsVqQ2AuWw==
X-Received: by 2002:ac2:5dc9:0:b0:443:5db1:244c with SMTP id
 x9-20020ac25dc9000000b004435db1244cmr16260341lfq.84.1645500328167; 
 Mon, 21 Feb 2022 19:25:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzgclXkZ4so+3pHZp3beg+SMuuvNf+mQCavH/1HthOChAx9iEQFRetN/+EmIDBrnSE47bn8vJcbii0Wu+Z0MDg=
X-Received: by 2002:ac2:5dc9:0:b0:443:5db1:244c with SMTP id
 x9-20020ac25dc9000000b004435db1244cmr16260331lfq.84.1645500327952; Mon, 21
 Feb 2022 19:25:27 -0800 (PST)
MIME-Version: 1.0
References: <c1895bcc240d413ff067f982b6e653996ace9887.camel@infradead.org>
In-Reply-To: <c1895bcc240d413ff067f982b6e653996ace9887.camel@infradead.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 22 Feb 2022 11:25:16 +0800
Message-ID: <CACGkMEuXOuXqJPouDkGSm=4uZTSQf6cA+W+vPeM8gEDSKGiP5Q@mail.gmail.com>
Subject: Re: [PATCH] tools/virtio: Test virtual address range detection
To: David Woodhouse <dwmw2@infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Tue, Feb 22, 2022 at 12:17 AM David Woodhouse <dwmw2@infradead.org> wrote:
>
> As things stand, an application which wants to use vhost with a trivial
> 1:1 mapping of its virtual address space is forced to jump through hoops
> to detect what the address range might be. The VHOST_SET_MEM_TABLE ioctl
> helpfully doesn't fail immediately; you only get a failure *later* when
> you attempt to set the backend, if the table *could* map to an address
> which is out of range, even if no out-of-range address is actually
> being referenced.
>
> Since userspace is growing workarounds for this lovely kernel API, let's
> ensure that we have a regression test that does things basically the same
> way as https://gitlab.com/openconnect/openconnect/-/commit/443edd9d8826
> does.

I wonder if it's useful to have a small library that wraps vhost
kernel uAPI somewhere.

(In the future, we may want to let the kernel accept 1:1 mapping by
figuring out the illegal range by itself?)

Thanks

>
> This is untested as I can't actually get virtio_test to work at all; it
> just seems to deadlock on a spinlock. But it's getting the right answer
> for the virtio range on x86_64 at least.
>
> Signed-off-by: David Woodhouse <dwmw2@infradead.org>
> ---
>
> Please, tell me I don't need to do this. But if I *do*, it needs a
> regression test in-kernel.
>
>  tools/virtio/virtio_test.c | 109 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 106 insertions(+), 3 deletions(-)
>
> diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> index cb3f29c09aff..e40eeeb05b71 100644
> --- a/tools/virtio/virtio_test.c
> +++ b/tools/virtio/virtio_test.c
> @@ -11,6 +11,7 @@
>  #include <sys/ioctl.h>
>  #include <sys/stat.h>
>  #include <sys/types.h>
> +#include <sys/mman.h>
>  #include <fcntl.h>
>  #include <stdbool.h>
>  #include <linux/virtio_types.h>
> @@ -124,6 +125,109 @@ static void vq_info_add(struct vdev_info *dev, int num)
>         dev->nvqs++;
>  }
>
> +/*
> + * This is awful. The kernel doesn't let us just ask for a 1:1 mapping of
> + * our virtual address space; we have to *know* the minimum and maximum
> + * addresses. We can't test it directly with VHOST_SET_MEM_TABLE because
> + * that actually succeeds, and the failure only occurs later when we try
> + * to use a buffer at an address that *is* valid, but our memory table
> + * *could* point to addresses that aren't. Ewww.
> + *
> + * So... attempt to work out what TASK_SIZE is for the kernel we happen
> + * to be running on right now...
> + */
> +
> +static int testaddr(unsigned long addr)
> +{
> +       void *res = mmap((void *)addr, getpagesize(), PROT_NONE,
> +                        MAP_FIXED|MAP_ANONYMOUS, -1, 0);
> +       if (res == MAP_FAILED) {
> +               if (errno == EEXIST || errno == EINVAL)
> +                       return 1;
> +
> +               /* We get ENOMEM for a bad virtual address */
> +               return 0;
> +       }
> +       /* It shouldn't actually succeed without either MAP_SHARED or
> +        * MAP_PRIVATE in the flags, but just in case... */
> +       munmap((void *)addr, getpagesize());
> +       return 1;
> +}
> +
> +static int find_vmem_range(struct vhost_memory *vmem)
> +{
> +       const unsigned long page_size = getpagesize();
> +       unsigned long top;
> +       unsigned long bottom;
> +
> +       top = -page_size;
> +
> +       if (testaddr(top)) {
> +               vmem->regions[0].memory_size = top;
> +               goto out;
> +       }
> +
> +       /* 'top' is the lowest address known *not* to work */
> +       bottom = top;
> +       while (1) {
> +               bottom >>= 1;
> +               bottom &= ~(page_size - 1);
> +               assert(bottom);
> +
> +               if (testaddr(bottom))
> +                       break;
> +               top = bottom;
> +       }
> +
> +       /* It's often a page or two below the boundary */
> +       top -= page_size;
> +       if (testaddr(top)) {
> +               vmem->regions[0].memory_size = top;
> +               goto out;
> +       }
> +       top -= page_size;
> +       if (testaddr(top)) {
> +               vmem->regions[0].memory_size = top;
> +               goto out;
> +       }
> +
> +       /* Now, bottom is the highest address known to work,
> +          and we must search between it and 'top' which is
> +          the lowest address known not to. */
> +       while (bottom + page_size != top) {
> +               unsigned long test = bottom + (top - bottom) / 2;
> +               test &= ~(page_size - 1);
> +
> +               if (testaddr(test)) {
> +                       bottom = test;
> +                       continue;
> +               }
> +               test -= page_size;
> +               if (testaddr(test)) {
> +                       vmem->regions[0].memory_size = test;
> +                       goto out;
> +               }
> +
> +               test -= page_size;
> +               if (testaddr(test)) {
> +                       vmem->regions[0].memory_size = test;
> +                       goto out;
> +               }
> +               top = test;
> +       }
> +       vmem->regions[0].memory_size = bottom;
> +
> + out:
> +       vmem->regions[0].guest_phys_addr = page_size;
> +       vmem->regions[0].userspace_addr = page_size;
> +       printf("Detected virtual address range 0x%lx-0x%lx\n",
> +              page_size,
> +              (unsigned long)(page_size + vmem->regions[0].memory_size));
> +
> +       return 0;
> +}
> +
> +
>  static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
>  {
>         int r;
> @@ -143,9 +247,8 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
>         memset(dev->mem, 0, offsetof(struct vhost_memory, regions) +
>                            sizeof dev->mem->regions[0]);
>         dev->mem->nregions = 1;
> -       dev->mem->regions[0].guest_phys_addr = (long)dev->buf;
> -       dev->mem->regions[0].userspace_addr = (long)dev->buf;
> -       dev->mem->regions[0].memory_size = dev->buf_size;
> +       r = find_vmem_range(dev->mem);
> +       assert(r >= 0);
>         r = ioctl(dev->control, VHOST_SET_MEM_TABLE, dev->mem);
>         assert(r >= 0);
>  }
>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
