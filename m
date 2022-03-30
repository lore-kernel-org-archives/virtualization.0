Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32D0C433EF
	for <virtualization@archiver.kernel.org>; Wed, 30 Mar 2022 02:44:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6364B61056;
	Wed, 30 Mar 2022 02:44:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5fWiL-6Kw1cg; Wed, 30 Mar 2022 02:44:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E9AB860777;
	Wed, 30 Mar 2022 02:44:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA1E0C001D;
	Wed, 30 Mar 2022 02:44:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31285C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 02:44:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2D0CC607BC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 02:44:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZpV2deg9CjwJ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 02:44:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6340D60777
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 02:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648608275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a2xX/Hy07omIgAr+hrUkEQ1I86CwFNCof15lsG56O6s=;
 b=XDpmEB16tRN/QDAQwApjKTF6p3QN9zz3Z399kWGluqmmhRDdOmYNeeiF/ftvvy7qJXYIX5
 saQlGKYx+Ud4PcH42THynqRuOaMkT8XP2KVySC5I9ZSwHclNrBlYOEfxK//lhUNtVfJEZ9
 ngnH5/7B/5RTp5laOTVa9LrjxhgcZCs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-424-llCVTkTtNKaB0Ayh3VbgpQ-1; Tue, 29 Mar 2022 22:43:53 -0400
X-MC-Unique: llCVTkTtNKaB0Ayh3VbgpQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 y23-20020a0565123f1700b00448221b91e5so5957197lfa.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 19:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a2xX/Hy07omIgAr+hrUkEQ1I86CwFNCof15lsG56O6s=;
 b=AMN6ye9jNdyKBPzeSFoOgAocK6jZwMq42Tt8Ick6gnNLgsNzwAMTzFHi+Yi74dWCWS
 RRO0zVR4og3/JMRGPkiVL9M2byjP4AFqonM7Xf2RsY2aJuio6sH+Ch9v4VJZzrFtUhop
 mhqusz/pORe7m1Uv8nui47Y/LS0r/Xqphhr8DaBvFbYTnbag3QF6BvGjqYQog7BOzVrH
 jvT5jNYhQA4q21T9tCeZqPhWkuWnkX1phTdxKQQh6U1/KERkJLdOmLIAUr3N6EcplNZw
 q/yW6DnQpU+TITNKewyz83bOy6qRgTcl7Xxg+uiWSiUl8c2qli4x8xJdDWn2QnbfqHxl
 QNuA==
X-Gm-Message-State: AOAM532MjxWIiFxNQeFI8OXHU48rJNZjAQ0aorgyDKzYJBGnpuRe7aD4
 ad6M1iT0ZcjDXbewMisg43wQTHVBykjh3/kt5tCqA8D16BRpRw6fXrzt43h8QskREzmEfb2B0rS
 0opz5A/Kq8W/oawymh/euuS6wkNJZDrDUuvJzVhARJDQZ28xNYSOICI0/Ow==
X-Received: by 2002:a05:651c:90a:b0:249:5d82:fe9c with SMTP id
 e10-20020a05651c090a00b002495d82fe9cmr5111065ljq.300.1648608232032; 
 Tue, 29 Mar 2022 19:43:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtjq6ZqsOr/okMJ8uC4fcXsHVSCCTYX6TFrpdrvMwrrKgYd6mwnApym+8qEZl8KaGKi0bV8pFJuBiTPe/kiDg=
X-Received: by 2002:a05:651c:90a:b0:249:5d82:fe9c with SMTP id
 e10-20020a05651c090a00b002495d82fe9cmr5111051ljq.300.1648608231806; Tue, 29
 Mar 2022 19:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220323140727.3499235-1-keirf@google.com>
In-Reply-To: <20220323140727.3499235-1-keirf@google.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 30 Mar 2022 10:43:40 +0800
Message-ID: <CACGkMEuagKHAiXKNnB22wvcRL2=Qz9u9dKiaNnbMC91_=11J6w@mail.gmail.com>
Subject: Re: [PATCH v3] virtio: pci: check bar values read from virtio config
 space
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

On Wed, Mar 23, 2022 at 10:07 PM Keir Fraser <keirf@google.com> wrote:
>
> virtio pci config structures may in future have non-standard bar
> values in the bar field. We should anticipate this by skipping any
> structures containing such a reserved value.
>
> The bar value should never change: check for harmful modified values
> we re-read it from the config space in vp_modern_map_capability().
>
> Also clean up an existing check to consistently use PCI_STD_NUM_BARS.
>
> Signed-off-by: Keir Fraser <keirf@google.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/virtio/virtio_pci_modern.c     | 12 +++++++++---
>  drivers/virtio/virtio_pci_modern_dev.c |  9 ++++++++-
>  2 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 5455bc041fb6..6adfcd0297a7 100644
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
> @@ -315,9 +315,14 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
>                 if (id != required_id)
>                         continue;
>
> -               /* Type, and ID match, looks good */
>                 pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> -                                                        bar), bar);
> +                                                        bar), &res_bar);
> +               if (res_bar >= PCI_STD_NUM_BARS)
> +                       continue;
> +
> +               /* Type and ID match, and the BAR value isn't reserved.
> +                * Looks good.
> +                */
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
> index e8b3ff2b9fbc..591738ad3d56 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -35,6 +35,13 @@ vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
>         pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap, length),
>                               &length);
>
> +       /* Check if the BAR may have changed since we requested the region. */
> +       if (bar >= PCI_STD_NUM_BARS || !(mdev->modern_bars & (1 << bar))) {
> +               dev_err(&dev->dev,
> +                       "virtio_pci: bar unexpectedly changed to %u\n", bar);
> +               return NULL;
> +       }
> +
>         if (length <= start) {
>                 dev_err(&dev->dev,
>                         "virtio_pci: bad capability len %u (>%u expected)\n",
> @@ -120,7 +127,7 @@ static inline int virtio_pci_find_capability(struct pci_dev *dev, u8 cfg_type,
>                                      &bar);
>
>                 /* Ignore structures with reserved BAR values */
> -               if (bar > 0x5)
> +               if (bar >= PCI_STD_NUM_BARS)
>                         continue;
>
>                 if (type == cfg_type) {
> --
> 2.35.1.894.gb6a874cedc-goog
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
