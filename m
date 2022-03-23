Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04CAC433F5
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 07:58:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 59C1E40215;
	Wed, 23 Mar 2022 07:58:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GOdav8MTm4n4; Wed, 23 Mar 2022 07:58:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CFB3340239;
	Wed, 23 Mar 2022 07:58:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84AE0C0012;
	Wed, 23 Mar 2022 07:58:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28856C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 07:58:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 01DD560E32
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 07:58:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ToFkRBLLoGbC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 07:58:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B0F1160C06
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 07:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648022294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gAyVkbGAsQwthsHwR2YL1Xu7ffsSB44wUq5hKIC/Uq0=;
 b=JaOT7tKCSGUPgrRdtYK45PB1/05LwBboJ673NcjEAnOEhu+vY7Op+NRjp7V0TB0ICB78m5
 4I0mrGOFB/24uHyezL9KCtkr9+VdyrvBsTh+OMAR3cDE+HSD8LjaQU9ZhQyhud7E97gZ6Y
 LFmodKvKncCR8Ql63muRsAnOh4N2htU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-61p3W-ezPOy3A_9mwyZh6g-1; Wed, 23 Mar 2022 03:58:13 -0400
X-MC-Unique: 61p3W-ezPOy3A_9mwyZh6g-1
Received: by mail-lf1-f69.google.com with SMTP id
 u29-20020ac251dd000000b0044a245bcc1aso326665lfm.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 00:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gAyVkbGAsQwthsHwR2YL1Xu7ffsSB44wUq5hKIC/Uq0=;
 b=yQ0LpJNqwtLipTryjTifbSdo1EH9eMszj6xFj+3uTuHj6YqwHP0lnul83QGwMETffV
 kagMnfE7mPNv/2sr4MQhOaq3UdVEPh14sjJHArHvLTAe813CKrYf9reMDYV+VOfuBnVE
 KjgFEohEEOkJ8YlsWg3HAIP7IlU6ige8+i+uo5ocSj4rWcAK38+xDuqSBkxRs1FSywvJ
 6Ee2ptSeoxPw9/boBZ/62oIejrJ7hvZHseNUbUyueeXDgj1VTzmEuvKWf9MdfTRr+vNT
 ngILdXlTv6Gc2mBNgCJ9ROoZOjyaa2hyNLR6eH400vb+o0W79xIEEu5aBcrbbHFbxW/6
 fYAw==
X-Gm-Message-State: AOAM533Eg1AcfBhLzHNkviXK7V8vR6h3IwovugvR9gen02ZPY5LATeeI
 nNw4PQ6tG/U9v3erHxUTT5lNpbsB/b3Eurh4UWFAGKK1g/85dVK+71OJ50B+98pjnvRK7NQS1mV
 okMMiGckmAaL3r+WlgAl5PwT7VuumsHP421rbVZhFLYQKN7cuk567uScl5Q==
X-Received: by 2002:a05:651c:90a:b0:249:5d82:fe9c with SMTP id
 e10-20020a05651c090a00b002495d82fe9cmr21556665ljq.300.1648022291810; 
 Wed, 23 Mar 2022 00:58:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzehhqEud0nAsdq/Kd29NYle9hKa9jnJAZWN6DSBqWRHij5C2bX9h3lR7Tb3iqEW8RSonlF1JIW0PRX8/99XHI=
X-Received: by 2002:a05:651c:90a:b0:249:5d82:fe9c with SMTP id
 e10-20020a05651c090a00b002495d82fe9cmr21556651ljq.300.1648022291581; Wed, 23
 Mar 2022 00:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220322151952.2950143-1-keirf@google.com>
In-Reply-To: <20220322151952.2950143-1-keirf@google.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Mar 2022 15:57:59 +0800
Message-ID: <CACGkMEubcU4rFVem7neKYb-qT3TQUN802bbLNq7vh+y8gdD5AA@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: pci: sanity check bar indexes
To: Keir Fraser <keirf@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 kernel-team@android.com, linux-kernel <linux-kernel@vger.kernel.org>,
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

On Tue, Mar 22, 2022 at 11:20 PM Keir Fraser <keirf@google.com> wrote:
>
> The bar index is used as an index into the device's resource list
> and should be checked as within range for a standard bar.
>
> Also clean up an existing check to consistently use PCI_STD_NUM_BARS.
>
> Signed-off-by: Keir Fraser <keirf@google.com>
> ---
>  drivers/virtio/virtio_pci_modern.c     | 10 ++++++++--
>  drivers/virtio/virtio_pci_modern_dev.c |  8 +++++++-
>  2 files changed, 15 insertions(+), 3 deletions(-)
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
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index e8b3ff2b9fbc..a6911d1e212a 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -35,6 +35,12 @@ vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
>         pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap, length),
>                               &length);
>
> +       if (bar >= PCI_STD_NUM_BARS) {
> +               dev_err(&dev->dev,
> +                       "virtio_pci: bad capability bar %u\n", bar);
> +               return NULL;
> +       }
> +
>         if (length <= start) {
>                 dev_err(&dev->dev,
>                         "virtio_pci: bad capability len %u (>%u expected)\n",
> @@ -120,7 +126,7 @@ static inline int virtio_pci_find_capability(struct pci_dev *dev, u8 cfg_type,
>                                      &bar);
>
>                 /* Ignore structures with reserved BAR values */
> -               if (bar > 0x5)
> +               if (bar >= PCI_STD_NUM_BARS)
>                         continue;

Just notice that the spec said:

"
values 0x0 to 0x5 specify a Base Address register (BAR) belonging to
the function located beginning at 10h in PCI Configuration Space and
used to map the structure into Memory or I/O Space. The BAR is
permitted to be either 32-bit or 64-bit, it can map Memory Space or
I/O Space.

Any other value is reserved for future use.
"

So we probably need to stick 0x5 instead of 0x6 (PCI_STD_NUM_BARS) for
this and other places.

Thanks

>
>                 if (type == cfg_type) {
> --
> 2.35.1.894.gb6a874cedc-goog
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
