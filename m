Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2309FC433F5
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 09:21:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A1F6461345;
	Wed, 23 Mar 2022 09:21:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A2X-UHgOWQI0; Wed, 23 Mar 2022 09:21:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0479261347;
	Wed, 23 Mar 2022 09:21:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BAEBDC001A;
	Wed, 23 Mar 2022 09:21:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB0C5C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 09:21:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B4D8841823
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 09:21:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mP-T563o7atA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 09:21:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DBB0B417EF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 09:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648027280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jBYkM0rtMkD7czk830JnwZ6fzXDNz3tWd/U/7zjOmJc=;
 b=TsON8InpGFB4d2DRTsyqSPzeH/DTFXd0dLF+RJLvXik1dJEHG9A4VyYj2ODJS8ZcT8HEvB
 8d4JDU/lsfdVbKyk4W1WRtmEuJpGCqIUBwNSdORjFfO1/z3KaAMwFPCqdmMW+wtDwt071Y
 Hiog20n0Yp7UdkVn0enDMFBWVGPf2q4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-304-s68Z-mFMPJKJJ8HzZtXy1A-1; Wed, 23 Mar 2022 05:21:19 -0400
X-MC-Unique: s68Z-mFMPJKJJ8HzZtXy1A-1
Received: by mail-lj1-f198.google.com with SMTP id
 x3-20020a05651c104300b00247ebe980b7so351587ljm.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 02:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jBYkM0rtMkD7czk830JnwZ6fzXDNz3tWd/U/7zjOmJc=;
 b=sd73R5PKN+VdJdzaxJtASqRjd8ueBzLseC1cAWIN6Y1O5hf/bjOlX5Uccr0TzZHEuu
 aU7tXKIZ2o3UW+8ikerzqpQIdXTIsJr6QsVPQzANFPW3BqPs6S7HcM60bD5dgzQr2q4W
 S/iF029ZfN4UJ9iitz/TFYENMgvD3t/IVyQrABr3wn/GBsEicunJ9QvaUT1cc63DS/ON
 TLBw11PXBjps71FXtp0/y3ewtS5kkNUbmm1GPOAUP4X2CIiuo4eKicYi+JslYFPp0BeY
 CtMV6bI0BfEORB8m5LgoKu8rz/uCSEK3n4y+oCovexGRJFmmrqvpMXy0a1Ji3ic/5iYk
 u7iA==
X-Gm-Message-State: AOAM532d4aeLyIJOyfsHTJa6QfcmUyc5dAGiTyZqUvc4mcP9NEP8Dy9j
 aetacm2ZlmoqxmWUVs5yqxPxtN/ybh2mLCphc8GsUBBwm8t+n+mDloOU+qDf6gBDkYA/knbTdIo
 ewG/I4HN3gSqXxZI+tImrKBAD2EZisxx8xMv7DMRy21SUO6O1i4yZ7F7A2A==
X-Received: by 2002:a05:6512:3341:b0:433:b033:bd22 with SMTP id
 y1-20020a056512334100b00433b033bd22mr21065911lfd.190.1648027277455; 
 Wed, 23 Mar 2022 02:21:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlKIpKMCHsHpNFxAPW0LOjLsecKFsixZILeSSjEm36ZGhM07eqBvMg43ujyUQQFUctG2VOVuH/6QDI6dXFafI=
X-Received: by 2002:a05:6512:3341:b0:433:b033:bd22 with SMTP id
 y1-20020a056512334100b00433b033bd22mr21065888lfd.190.1648027277133; Wed, 23
 Mar 2022 02:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220322151952.2950143-1-keirf@google.com>
 <CACGkMEubcU4rFVem7neKYb-qT3TQUN802bbLNq7vh+y8gdD5AA@mail.gmail.com>
 <YjrknlVIlB4QuwtZ@google.com>
In-Reply-To: <YjrknlVIlB4QuwtZ@google.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Mar 2022 17:21:05 +0800
Message-ID: <CACGkMEsEe=vkpY-xxZM0_F2cN6Mx0Nn9CDzH-1-Tb9XEU6Px-Q@mail.gmail.com>
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

On Wed, Mar 23, 2022 at 5:13 PM Keir Fraser <keirf@google.com> wrote:
>
> On Wed, Mar 23, 2022 at 03:57:59PM +0800, Jason Wang wrote:
> > On Tue, Mar 22, 2022 at 11:20 PM Keir Fraser <keirf@google.com> wrote:
> > >
> > > The bar index is used as an index into the device's resource list
> > > and should be checked as within range for a standard bar.
> > >
> > > Also clean up an existing check to consistently use PCI_STD_NUM_BARS.
> > >
> > > Signed-off-by: Keir Fraser <keirf@google.com>
> > > ---
> > >  drivers/virtio/virtio_pci_modern.c     | 10 ++++++++--
> > >  drivers/virtio/virtio_pci_modern_dev.c |  8 +++++++-
> > >  2 files changed, 15 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > > index 5455bc041fb6..84bace98dff5 100644
> > > --- a/drivers/virtio/virtio_pci_modern.c
> > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > @@ -293,7 +293,7 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
> > >
> > >         for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR); pos > 0;
> > >              pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
> > > -               u8 type, cap_len, id;
> > > +               u8 type, cap_len, id, res_bar;
> > >                 u32 tmp32;
> > >                 u64 res_offset, res_length;
> > >
> > > @@ -317,7 +317,12 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
> > >
> > >                 /* Type, and ID match, looks good */
> > >                 pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> > > -                                                        bar), bar);
> > > +                                                        bar), &res_bar);
> > > +               if (res_bar >= PCI_STD_NUM_BARS) {
> > > +                       dev_err(&dev->dev, "%s: shm cap with bad bar: %d\n",
> > > +                               __func__, res_bar);
> > > +                       continue;
> > > +               }
> > >
> > >                 /* Read the lower 32bit of length and offset */
> > >                 pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap,
> > > @@ -337,6 +342,7 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
> > >                                                      length_hi), &tmp32);
> > >                 res_length |= ((u64)tmp32) << 32;
> > >
> > > +               *bar = res_bar;
> > >                 *offset = res_offset;
> > >                 *len = res_length;
> > >
> > > diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> > > index e8b3ff2b9fbc..a6911d1e212a 100644
> > > --- a/drivers/virtio/virtio_pci_modern_dev.c
> > > +++ b/drivers/virtio/virtio_pci_modern_dev.c
> > > @@ -35,6 +35,12 @@ vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
> > >         pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap, length),
> > >                               &length);
> > >
> > > +       if (bar >= PCI_STD_NUM_BARS) {
> > > +               dev_err(&dev->dev,
> > > +                       "virtio_pci: bad capability bar %u\n", bar);
> > > +               return NULL;
> > > +       }
> > > +
> > >         if (length <= start) {
> > >                 dev_err(&dev->dev,
> > >                         "virtio_pci: bad capability len %u (>%u expected)\n",
> > > @@ -120,7 +126,7 @@ static inline int virtio_pci_find_capability(struct pci_dev *dev, u8 cfg_type,
> > >                                      &bar);
> > >
> > >                 /* Ignore structures with reserved BAR values */
> > > -               if (bar > 0x5)
> > > +               if (bar >= PCI_STD_NUM_BARS)
> > >                         continue;
> >
> > Just notice that the spec said:
> >
> > "
> > values 0x0 to 0x5 specify a Base Address register (BAR) belonging to
> > the function located beginning at 10h in PCI Configuration Space and
> > used to map the structure into Memory or I/O Space. The BAR is
> > permitted to be either 32-bit or 64-bit, it can map Memory Space or
> > I/O Space.
> >
> > Any other value is reserved for future use.
> > "
> >
> > So we probably need to stick 0x5 instead of 0x6 (PCI_STD_NUM_BARS) for
> > this and other places.
>
> The comparison(s) are changed to greater-or-equal, so they are logically
> equivalent to the old check against naked 0x5 while documenting the intent
> better.

You're right, So:

Acked-by: Jason Wang <jasowang@redhat.com>

>
> > Thanks
> >
> > >
> > >                 if (type == cfg_type) {
> > > --
> > > 2.35.1.894.gb6a874cedc-goog
> > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
