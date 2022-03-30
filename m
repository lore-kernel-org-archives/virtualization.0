Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B38DC433EF
	for <virtualization@archiver.kernel.org>; Wed, 30 Mar 2022 06:36:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24F8784569;
	Wed, 30 Mar 2022 06:36:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IKADLnAjr7bc; Wed, 30 Mar 2022 06:36:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B57538434C;
	Wed, 30 Mar 2022 06:36:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89A14C002C;
	Wed, 30 Mar 2022 06:36:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2CE6C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:36:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CA64384559
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:36:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Yr8R_q15uPA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:36:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1441E8434C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648622164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=++Hp64PybgFHOZx21HiH2lviwBio7CAIQp9pPc7sk78=;
 b=TavtPxw1j5FuXoHc+Xs54er/S2YUtntpe9H+0AYI0OamAFeNS8JYR7oAdYqVBzmBfZmvZS
 8DBKIJHzSMoBlJ1+FyZIRbq0im4LTRZAasPhPHEojmZjDTkMI4ufp3g+3CiQ8VLPBA8hNe
 DnfTFKo9eFQWcGV56iZLRVdwK6T74iY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-jv98JDWOMK-LUlBeO51tgw-1; Wed, 30 Mar 2022 02:36:01 -0400
X-MC-Unique: jv98JDWOMK-LUlBeO51tgw-1
Received: by mail-wr1-f72.google.com with SMTP id
 71-20020adf82cd000000b00203dc43d216so5615505wrc.22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 23:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=++Hp64PybgFHOZx21HiH2lviwBio7CAIQp9pPc7sk78=;
 b=RkdMEstpsgyEn+ixq2G4XMrz8rLvA4OeiT9DmF8oMRDFm5Y0n1Kp32ImvImrbfRY2/
 TOMgRphaHXCzx9W+nS36uT+sIKRvf3lxJIu6aQenV8SkWYQBWEGa8xqR9pO05AFRNlBB
 AS0lrrBsDZSbFXsRjw3cSuYjqW9TBmjb1NXFcbGAEl4oL+jKg4G7uK75otNJ7CsLUz1J
 1vgXG1Ly7kzSmcBF06OnY6+Uf7BPcXQp4Lu8/KQociSBX0JvYfoJO5G7PssqXY9NC2U6
 IVpJBzVb58Fv9g6dVKAu+dWtnwMBsNeCbKTzmGovuvoN7YTDrN3Cf7NRKs1Ru/R4aEeE
 5DWQ==
X-Gm-Message-State: AOAM531Je3ASd4LC6FetpsetFtwNWMs6IiR/ByP4h/yeaJmsbQyTvHlk
 yOAV7LTN4T+bVnwprjl1nd1Ewx4eyRMaPqpZpTPBvoeyF2JUvI8dl30rEcuvezYMHU/c7ZEfNsi
 we8PHTcv20FrY33CywV6Te0k8dihtl72ttNLbPcGZlw==
X-Received: by 2002:a05:6000:1704:b0:203:d857:aa7a with SMTP id
 n4-20020a056000170400b00203d857aa7amr33695855wrc.513.1648622159482; 
 Tue, 29 Mar 2022 23:35:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPMq/58RiltkrfV05P9P3GIe5dhwGOq9d4jVe60HJGdNlzdiCwBkYGFCnQi5Se1rEvBCFKBQ==
X-Received: by 2002:a05:6000:1704:b0:203:d857:aa7a with SMTP id
 n4-20020a056000170400b00203d857aa7amr33695842wrc.513.1648622159221; 
 Tue, 29 Mar 2022 23:35:59 -0700 (PDT)
Received: from redhat.com ([2.52.9.207]) by smtp.gmail.com with ESMTPSA id
 n18-20020a5d6612000000b00203fbd39059sm16698312wru.42.2022.03.29.23.35.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Mar 2022 23:35:58 -0700 (PDT)
Date: Wed, 30 Mar 2022 02:35:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3] virtio: pci: check bar values read from virtio config
 space
Message-ID: <20220330023536-mutt-send-email-mst@kernel.org>
References: <20220323140727.3499235-1-keirf@google.com>
 <CACGkMEuagKHAiXKNnB22wvcRL2=Qz9u9dKiaNnbMC91_=11J6w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuagKHAiXKNnB22wvcRL2=Qz9u9dKiaNnbMC91_=11J6w@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Keir Fraser <keirf@google.com>, kernel-team@android.com,
 linux-kernel <linux-kernel@vger.kernel.org>,
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

On Wed, Mar 30, 2022 at 10:43:40AM +0800, Jason Wang wrote:
> On Wed, Mar 23, 2022 at 10:07 PM Keir Fraser <keirf@google.com> wrote:
> >
> > virtio pci config structures may in future have non-standard bar
> > values in the bar field. We should anticipate this by skipping any
> > structures containing such a reserved value.
> >
> > The bar value should never change: check for harmful modified values
> > we re-read it from the config space in vp_modern_map_capability().
> >
> > Also clean up an existing check to consistently use PCI_STD_NUM_BARS.
> >
> > Signed-off-by: Keir Fraser <keirf@google.com>
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> 


Thanks! I don't want to rebase anymore though so not adding this ack.
Sorry!

> >  drivers/virtio/virtio_pci_modern.c     | 12 +++++++++---
> >  drivers/virtio/virtio_pci_modern_dev.c |  9 ++++++++-
> >  2 files changed, 17 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > index 5455bc041fb6..6adfcd0297a7 100644
> > --- a/drivers/virtio/virtio_pci_modern.c
> > +++ b/drivers/virtio/virtio_pci_modern.c
> > @@ -293,7 +293,7 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
> >
> >         for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR); pos > 0;
> >              pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
> > -               u8 type, cap_len, id;
> > +               u8 type, cap_len, id, res_bar;
> >                 u32 tmp32;
> >                 u64 res_offset, res_length;
> >
> > @@ -315,9 +315,14 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
> >                 if (id != required_id)
> >                         continue;
> >
> > -               /* Type, and ID match, looks good */
> >                 pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> > -                                                        bar), bar);
> > +                                                        bar), &res_bar);
> > +               if (res_bar >= PCI_STD_NUM_BARS)
> > +                       continue;
> > +
> > +               /* Type and ID match, and the BAR value isn't reserved.
> > +                * Looks good.
> > +                */
> >
> >                 /* Read the lower 32bit of length and offset */
> >                 pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap,
> > @@ -337,6 +342,7 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
> >                                                      length_hi), &tmp32);
> >                 res_length |= ((u64)tmp32) << 32;
> >
> > +               *bar = res_bar;
> >                 *offset = res_offset;
> >                 *len = res_length;
> >
> > diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> > index e8b3ff2b9fbc..591738ad3d56 100644
> > --- a/drivers/virtio/virtio_pci_modern_dev.c
> > +++ b/drivers/virtio/virtio_pci_modern_dev.c
> > @@ -35,6 +35,13 @@ vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
> >         pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap, length),
> >                               &length);
> >
> > +       /* Check if the BAR may have changed since we requested the region. */
> > +       if (bar >= PCI_STD_NUM_BARS || !(mdev->modern_bars & (1 << bar))) {
> > +               dev_err(&dev->dev,
> > +                       "virtio_pci: bar unexpectedly changed to %u\n", bar);
> > +               return NULL;
> > +       }
> > +
> >         if (length <= start) {
> >                 dev_err(&dev->dev,
> >                         "virtio_pci: bad capability len %u (>%u expected)\n",
> > @@ -120,7 +127,7 @@ static inline int virtio_pci_find_capability(struct pci_dev *dev, u8 cfg_type,
> >                                      &bar);
> >
> >                 /* Ignore structures with reserved BAR values */
> > -               if (bar > 0x5)
> > +               if (bar >= PCI_STD_NUM_BARS)
> >                         continue;
> >
> >                 if (type == cfg_type) {
> > --
> > 2.35.1.894.gb6a874cedc-goog
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
