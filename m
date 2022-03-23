Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD51C433EF
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 13:23:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6356812D3;
	Wed, 23 Mar 2022 13:23:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zo2_cngyPLIz; Wed, 23 Mar 2022 13:23:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E8653812B1;
	Wed, 23 Mar 2022 13:23:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC858C001A;
	Wed, 23 Mar 2022 13:23:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31996C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:23:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 13E9141877
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:23:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 51VfN7jhbjxI
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:23:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 418FD41868
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648041814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CiGA+PyLZ8LfaBJ1qR+riMRxzoYnfAKJVvAXqmVbb5k=;
 b=A8NrB/kf4PDIYwipw7kuqSry3A766MilVDQ6slrvJZGV9w6SzqLiC7hfg6PYMA2Ry8spE2
 4HDEdcRgqnh5xASmFvU+zuudwBRpgthzZS5uX5h7kkZ2gD2Kym0paMe+ZetNBWl4oQ6+jJ
 g8fd9LGFHBS1U6sYasnuqdd1+zAqbKA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-365-n_YnFayYPVGAoH4cj12Xjw-1; Wed, 23 Mar 2022 09:23:32 -0400
X-MC-Unique: n_YnFayYPVGAoH4cj12Xjw-1
Received: by mail-wm1-f69.google.com with SMTP id
 q6-20020a1cf306000000b0038c5726365aso609878wmq.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 06:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CiGA+PyLZ8LfaBJ1qR+riMRxzoYnfAKJVvAXqmVbb5k=;
 b=8I9UX636Ych96lIgxc5DIvYR1ukHWBDQL8Eo+U8iCoD7TXLa/kHULoFkDXFZUb13Cd
 TrvHcxP3hF9oJ8ba2hL/zniXRrGSd1+kiPVw9QXKjg63DknCsFKM0ZkkSTXAut0z2JUY
 4mycP2W1LXYSogGdk2+Ri9fpgnXBu5xMTh0IxZZWq4dG0hb/H1hhOWgW+vIiHoMiztFt
 +4qgDX+By48EJsWefu6SWNWzjeUhe6DVYRcYdlRd/5y4fnwrbjrofDL6BusoAyAo5Smg
 4AltCg1EJ+14oY6ioAqr9HJ+Va9SkBASHPMQkpQgsWVZDXkPya5hbksLJmNAbAgPfpdW
 140Q==
X-Gm-Message-State: AOAM530AcOXXGXTSE4CGgWjZEdAW+rdTo4TPzo2Xb5/dNR4MoMWxNiBk
 xT80l9cdWuw8U4RKUPkhMPZnQjHvxVIIfBHnmC0bKaqNOPfy/hn9CjRFWnL1LdPpcm67+FUg1sY
 cnNOd++jP9Xyuyc7g4xPHOYo6yT5BbwDBoCWlYCpo4A==
X-Received: by 2002:a05:6000:1568:b0:203:fd87:e9c2 with SMTP id
 8-20020a056000156800b00203fd87e9c2mr18103892wrz.395.1648041811725; 
 Wed, 23 Mar 2022 06:23:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzw9qIzVCJtNVCj/qNkTbKcPIXoNpVSv+cUDgmX9w2JJYJLzCQKYCHIF7twgn2QkbQw7LuT5g==
X-Received: by 2002:a05:6000:1568:b0:203:fd87:e9c2 with SMTP id
 8-20020a056000156800b00203fd87e9c2mr18103875wrz.395.1648041811470; 
 Wed, 23 Mar 2022 06:23:31 -0700 (PDT)
Received: from redhat.com ([2.55.151.118]) by smtp.gmail.com with ESMTPSA id
 g6-20020a5d5406000000b001f049726044sm17753615wrv.79.2022.03.23.06.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 06:23:30 -0700 (PDT)
Date: Wed, 23 Mar 2022 09:23:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Keir Fraser <keirf@google.com>
Subject: Re: [PATCH v2] virtio: pci: sanity check bar indexes
Message-ID: <20220323092254-mutt-send-email-mst@kernel.org>
References: <20220322151952.2950143-1-keirf@google.com>
 <CACGkMEubcU4rFVem7neKYb-qT3TQUN802bbLNq7vh+y8gdD5AA@mail.gmail.com>
 <20220323075030-mutt-send-email-mst@kernel.org>
 <Yjse870sgpcMGsT6@google.com>
MIME-Version: 1.0
In-Reply-To: <Yjse870sgpcMGsT6@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kernel-team@android.com, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Wed, Mar 23, 2022 at 01:21:55PM +0000, Keir Fraser wrote:
> On Wed, Mar 23, 2022 at 08:01:42AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Mar 23, 2022 at 03:57:59PM +0800, Jason Wang wrote:
> > > On Tue, Mar 22, 2022 at 11:20 PM Keir Fraser <keirf@google.com> wrote:
> > > >
> > > > The bar index is used as an index into the device's resource list
> > > > and should be checked as within range for a standard bar.
> > > >
> > > > Also clean up an existing check to consistently use PCI_STD_NUM_BARS.
> > > >
> > > > Signed-off-by: Keir Fraser <keirf@google.com>
> > > > ---
> > > >  drivers/virtio/virtio_pci_modern.c     | 10 ++++++++--
> > > >  drivers/virtio/virtio_pci_modern_dev.c |  8 +++++++-
> > > >  2 files changed, 15 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > > > index 5455bc041fb6..84bace98dff5 100644
> > > > --- a/drivers/virtio/virtio_pci_modern.c
> > > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > > @@ -293,7 +293,7 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
> > > >
> > > >         for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR); pos > 0;
> > > >              pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
> > > > -               u8 type, cap_len, id;
> > > > +               u8 type, cap_len, id, res_bar;
> > > >                 u32 tmp32;
> > > >                 u64 res_offset, res_length;
> > > >
> > > > @@ -317,7 +317,12 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
> > > >
> > > >                 /* Type, and ID match, looks good */
> > > >                 pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> > > > -                                                        bar), bar);
> > > > +                                                        bar), &res_bar);
> > > > +               if (res_bar >= PCI_STD_NUM_BARS) {
> > > > +                       dev_err(&dev->dev, "%s: shm cap with bad bar: %d\n",
> > > > +                               __func__, res_bar);
> > > > +                       continue;
> > > > +               }
> > > >
> > > >                 /* Read the lower 32bit of length and offset */
> > > >                 pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap,
> > 
> > In fact, the spec says such BAR values are reserved, not bad, so
> > the capabiluty should be ignored, they should not cause the driver to error out
> > or print errors.
> 
> Ah yes, so I see. It makes sense then to silently ignore the capability and print nothing.
> I will fix it.
> 
> > > > @@ -337,6 +342,7 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
> > > >                                                      length_hi), &tmp32);
> > > >                 res_length |= ((u64)tmp32) << 32;
> > > >
> > > > +               *bar = res_bar;
> > > >                 *offset = res_offset;
> > > >                 *len = res_length;
> > > >
> > > > diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> > > > index e8b3ff2b9fbc..a6911d1e212a 100644
> > > > --- a/drivers/virtio/virtio_pci_modern_dev.c
> > > > +++ b/drivers/virtio/virtio_pci_modern_dev.c
> > > > @@ -35,6 +35,12 @@ vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
> > > >         pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap, length),
> > > >                               &length);
> > > >
> > > > +       if (bar >= PCI_STD_NUM_BARS) {
> > > > +               dev_err(&dev->dev,
> > > > +                       "virtio_pci: bad capability bar %u\n", bar);
> > 
> > In fact, I would say the issue is less that bar is reserved.
> > The real issue is that the value apparently changed since
> > we read it the first time. I think it's a good idea to
> > reflect that in the message. Maybe find_capability should return
> > the capability structure so we don't need to re-read it from
> > the device?
> 
> I will have a look and fix it up one way or the other, and respin
> this patch.
> 
>  Thanks,
>   Keir

BTW avoiding extra reads is good for start up speed. This is slow path,
but still.

> > > > +               return NULL;
> > > > +       }
> > > > +
> > > >         if (length <= start) {
> > > >                 dev_err(&dev->dev,
> > > >                         "virtio_pci: bad capability len %u (>%u expected)\n",
> > > > @@ -120,7 +126,7 @@ static inline int virtio_pci_find_capability(struct pci_dev *dev, u8 cfg_type,
> > > >                                      &bar);
> > > >
> > > >                 /* Ignore structures with reserved BAR values */
> > > > -               if (bar > 0x5)
> > > > +               if (bar >= PCI_STD_NUM_BARS)
> > > >                         continue;
> > > 
> > > Just notice that the spec said:
> > > 
> > > "
> > > values 0x0 to 0x5 specify a Base Address register (BAR) belonging to
> > > the function located beginning at 10h in PCI Configuration Space and
> > > used to map the structure into Memory or I/O Space. The BAR is
> > > permitted to be either 32-bit or 64-bit, it can map Memory Space or
> > > I/O Space.
> > > 
> > > Any other value is reserved for future use.
> > > "
> > > So we probably need to stick 0x5 instead of 0x6 (PCI_STD_NUM_BARS) for
> > > this and other places.
> > > 
> > > Thanks
> > 
> > It does not matter much IMHO, the reason spec uses 0 to 0x5 is precisely
> > because that's the standard number of BARs. Both ways work as long as we
> > are consistent, and I guess PCI_STD_NUM_BARS might be preferable since
> > people tend to copy paste values.
> > 
> > > >
> > > >                 if (type == cfg_type) {
> > > > --
> > > > 2.35.1.894.gb6a874cedc-goog
> > > >
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
