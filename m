Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA24AC433F5
	for <virtualization@archiver.kernel.org>; Tue, 22 Mar 2022 03:36:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CD9461199;
	Tue, 22 Mar 2022 03:36:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cnWZlnWSE3dx; Tue, 22 Mar 2022 03:36:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1060461197;
	Tue, 22 Mar 2022 03:36:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7AC7C001A;
	Tue, 22 Mar 2022 03:36:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFD6EC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 03:36:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BADD284345
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 03:36:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fvMVlseK9gvl
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 03:36:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0896D84342
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 03:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647920198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iMzx+aioEJysUsrwA03nQ3DLxiWp0PNXhW4lisYP70U=;
 b=ija/uiPG7vViYO1JI+76TgZGvUhEoHTwz2vk3WcRXw531UfQ++nsGBJDrHiNOqMVqzYqPV
 M971K3lr+t/91cw3WK2+TTfO68BVJvd3CPmCTtCHwkMxWpfaahYiDK8iGQsR1rhMT4PSLz
 1gD8nzeAQGWNVSzcXpwHkxYeuC0z0AY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-s1Qkh1p1O3mdv8p2pyM3cg-1; Mon, 21 Mar 2022 23:36:37 -0400
X-MC-Unique: s1Qkh1p1O3mdv8p2pyM3cg-1
Received: by mail-lj1-f199.google.com with SMTP id
 x3-20020a05651c104300b00247ebe980b7so6983453ljm.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 20:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iMzx+aioEJysUsrwA03nQ3DLxiWp0PNXhW4lisYP70U=;
 b=f/0/cA+8BebMIC5yI+NCSR8vVijxgcVerKu6B+eV4lqtx68vlxOWykKLPQuU4TXg9O
 knEd210A8waMhJFbHEt19GVDNzg2tAr+guqo9o/drXqlPHDnqz8a956khJoJnZqKWdui
 RLtSs4jvMndn5XNQ8+lbCz6hapvGbzRaA2ZHFYAInjFCHvuUOxGoXOzPwa/h9Shr3bxI
 VGU2/pJHD7+NuIWThZNIF8V3MxBLotEBeBKQxYbi9seR++K5utIj7DlmeNts988rNVQY
 vOSqqhxXL4Wits+t8JpUBFCMBQMGGYGhhesjjpooSYGHHVw8wxXjJH4R0fLRzcxleqxR
 h5iQ==
X-Gm-Message-State: AOAM532Ya9qlNq3bkZclLggYG8RVIPeMDL1zNRF4EBpuw3zJK7aI34sk
 B5fwGUpxhiYLTNFAYEzDytr7o4EWY8eDInCqHbKpu/O5irwDsx6mFUZjmX/Atzmdxk3+NHZ8QAW
 GBE2gQfC31QliP0CUWjqoN+M/MTY9E6MpEN0GaTNCiqHS23OLQP4bmqXSGg==
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id
 b1-20020a0565120b8100b00448b342513cmr16747265lfv.257.1647920195462; 
 Mon, 21 Mar 2022 20:36:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyj1G/AYOP3skVnNg/P+5mXQxxZT3muCA9UKvGxFZZI4XYPIarVqtXRw6VTfqLiA2IK6CTrcVHAKh6xTpSY7rc=
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id
 b1-20020a0565120b8100b00448b342513cmr16747254lfv.257.1647920195269; Mon, 21
 Mar 2022 20:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220321154931.859511-1-keirf@google.com>
In-Reply-To: <20220321154931.859511-1-keirf@google.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 22 Mar 2022 11:36:23 +0800
Message-ID: <CACGkMEuEh+vsDok6hrp96kgGHkxbmzskFMJOouR3mo3d3VjwdQ@mail.gmail.com>
Subject: Re: [PATCH] virtio: pci: Sanity check the bar index in find_shm_cap
To: Keir Fraser <keirf@google.com>
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

On Mon, Mar 21, 2022 at 11:49 PM Keir Fraser <keirf@google.com> wrote:
>
> The bar index is used as an index into the device's resource list
> and should be checked as within range for a standard bar.
>
> Signed-off-by: Keir Fraser <keirf@google.com>

Patch looks good, do we need a similar check in vp_modern_map_capability()?

Thanks

> ---
>  drivers/virtio/virtio_pci_modern.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 5455bc041fb6..84bace98dff5 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -293,7 +293,7 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
>
>         for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR); pos > 0;
>              pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
> -               u8 type, cap_len, id;
> +               u8 type, cap_len, id, res_bar;
>                 u32 tmp32;
>                 u64 res_offset, res_length;
>
> @@ -317,7 +317,12 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
>
>                 /* Type, and ID match, looks good */
>                 pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> -                                                        bar), bar);
> +                                                        bar), &res_bar);
> +               if (res_bar >= PCI_STD_NUM_BARS) {
> +                       dev_err(&dev->dev, "%s: shm cap with bad bar: %d\n",
> +                               __func__, res_bar);
> +                       continue;
> +               }
>
>                 /* Read the lower 32bit of length and offset */
>                 pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap,
> @@ -337,6 +342,7 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
>                                                      length_hi), &tmp32);
>                 res_length |= ((u64)tmp32) << 32;
>
> +               *bar = res_bar;
>                 *offset = res_offset;
>                 *len = res_length;
>
> --
> 2.35.1.894.gb6a874cedc-goog
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
