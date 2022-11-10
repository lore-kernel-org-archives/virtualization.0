Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F42C4332F
	for <virtualization@archiver.kernel.org>; Thu, 10 Nov 2022 06:25:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6A334401C2;
	Thu, 10 Nov 2022 06:25:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6A334401C2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ga+4bQp9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mrMFNgnaWYiH; Thu, 10 Nov 2022 06:25:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0FC31400E7;
	Thu, 10 Nov 2022 06:25:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0FC31400E7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D75A4C0033;
	Thu, 10 Nov 2022 06:25:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9700DC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 06:25:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 717BA4017B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 06:25:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 717BA4017B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pkjz4LhxyrIo
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 06:25:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8629C400E7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8629C400E7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 06:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668061554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cT7MIb473qqDDSVVXwyDEMmLSzN/VjsHwdjNL16ENvg=;
 b=Ga+4bQp9WAodEm7h8aaUgB4q2MPgvZ+QRj7INJOZDfH5ghYceLC49NdHTEnZVL+kQmbJF5
 K40SMMj5cmZ73BfWr/wHlrIVTKTk6e/e7aQ8d5ynwaBNnJ6pwgRen2uZTFtdYw6bQ6nNT4
 58XEkgUKXljQAHUa8T1nVx90MjcbckI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-151-9DrDTn3nPzKPDsrCtnYicg-1; Thu, 10 Nov 2022 01:25:52 -0500
X-MC-Unique: 9DrDTn3nPzKPDsrCtnYicg-1
Received: by mail-ed1-f70.google.com with SMTP id
 w17-20020a056402269100b00461e28a75ccso777023edd.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Nov 2022 22:25:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cT7MIb473qqDDSVVXwyDEMmLSzN/VjsHwdjNL16ENvg=;
 b=fHVrEVdXIW6BUdbbTIxqh7H17cGvMslpMOC4B4JKl5ut5wfdikFgwkHcarPJS/guAr
 VoqPVZVyT0xc44nkdz4nACxBdfI0xo240hIZyux8JKr4TiEwbiCe5MX9Ms/Pp/mP8Wrb
 bKfirrQiwurF8pfHkEOlfqSi1fIaNMrt4DToQRGUzTCsKk+xmUCLis0l7P1JRfCaHRYS
 5NnVzymf/g6OJe3EK9rAPp7c3sSkB3ILYcftSlUjh7StWz6BypjFpIfieOWpnDa74sqW
 8AwdV7IEu3I/OeipSwV9lbcmxkGCaSBNEgKMK1h27Vm0eGO0xWyROsaa8ftPPmGJ+3aX
 b+mQ==
X-Gm-Message-State: ACrzQf24q7h1Zz8yQEHPh89HgvKPlRz0tb9ESZCxJ9KcE+OurQYWEBFC
 2EhfcVzvCwMJ6dMpXEcGJlzqqUxbAH0O1wFPVNgvHek8uZRfZvjCOmgFnQJE6o/aDl+SU7lqrA4
 YraUTHBf1VMAbE8uOTTvsnIdB04H7jHQiRVTQR7P9alKX3MXDK9ab3LgZjQ==
X-Received: by 2002:a17:906:8a54:b0:7ad:e517:1eb with SMTP id
 gx20-20020a1709068a5400b007ade51701ebmr45520141ejc.567.1668061551689; 
 Wed, 09 Nov 2022 22:25:51 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7747G9NLhB7GE8qdR42UGnM94e4TCOGXhh6mmCvtRvV+rwu838gSmYF2yH5z1M0jPQd+NuaqydVuMzCLcQLhU=
X-Received: by 2002:a17:906:8a54:b0:7ad:e517:1eb with SMTP id
 gx20-20020a1709068a5400b007ade51701ebmr45520132ejc.567.1668061551543; Wed, 09
 Nov 2022 22:25:51 -0800 (PST)
MIME-Version: 1.0
References: <20221110061111.383076-1-xianting.tian@linux.alibaba.com>
In-Reply-To: <20221110061111.383076-1-xianting.tian@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 10 Nov 2022 14:25:36 +0800
Message-ID: <CACGkMEtxEe=SdjgE=qm5_TNy-XrY0x9gRZFLNnrA+3JShfLtYw@mail.gmail.com>
Subject: Re: [PATCH] virtio_pci: use PAGE_SIZE for pci vring align
To: Xianting Tian <xianting.tian@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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

On Thu, Nov 10, 2022 at 2:14 PM Xianting Tian
<xianting.tian@linux.alibaba.com> wrote:
>
> As the comments of VIRTIO_PCI_VRING_ALIGN shows, we should use
> PAGE_SZIE not the hard code 4096.
>
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>  include/uapi/linux/virtio_pci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> index f703afc7ad31..ed5f678c682b 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -90,7 +90,7 @@
>
>  /* The alignment to use between consumer and producer parts of vring.
>   * x86 pagesize again. */

See the comment above, PAGE_SIZE varies among archs.

Thanks

> -#define VIRTIO_PCI_VRING_ALIGN         4096
> +#define VIRTIO_PCI_VRING_ALIGN         PAGE_SIZE
>
>  #endif /* VIRTIO_PCI_NO_LEGACY */
>
> --
> 2.17.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
