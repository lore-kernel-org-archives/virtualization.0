Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1D2C433F5
	for <virtualization@archiver.kernel.org>; Tue, 22 Mar 2022 13:23:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BB14140156;
	Tue, 22 Mar 2022 13:23:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JF1YtZ41vcpj; Tue, 22 Mar 2022 13:23:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 29D8D4000B;
	Tue, 22 Mar 2022 13:23:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A271C0012;
	Tue, 22 Mar 2022 13:23:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 114C6C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 13:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0097440353
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 13:23:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M_30-owB5FMG
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 13:23:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 21D824034D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 13:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647955408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JN8ATPDk4cHWzEEAufgy9h9WUwilvG31Oc3TZ9z83IM=;
 b=ESWGYmqUaPfjaJ7e7zaQAiFARkKjBe5J6IMGNGu0xCsKRlKoXhVipRaRYCdstjeksXLY1T
 SUtKqHMqRwnfv0RBkISdRMmERaFHjiJzq0wJftQb5sl95nw1VXCnyk5olVJvbEKsAdQ5Ye
 05S3BpsWWc2ZpdBZLu7YaWU6tZB/PhI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-zHQYiBt_OtiqJqaq4Q2Pag-1; Tue, 22 Mar 2022 09:23:26 -0400
X-MC-Unique: zHQYiBt_OtiqJqaq4Q2Pag-1
Received: by mail-wm1-f72.google.com with SMTP id
 o10-20020a1c4d0a000000b0038c6e5fcbaeso903902wmh.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 06:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JN8ATPDk4cHWzEEAufgy9h9WUwilvG31Oc3TZ9z83IM=;
 b=PbX1qpQ48KCFbcN4O25WpGGtD5eiJTinaHue/dkCeyGgUOmbT/Lf0mi67z2E1ZTkJM
 WSRkz6X4x822dzhmHjeIKAlQ8cQ3n+ozxjUSoLA6yOeNJ2vhGJrK1zLtPmXIx5Kg41Yp
 b3emzS8LwKwoiuBTfRE9dexPgXbnQxQVXKOtO0C+fnnP2i7Dhe/Jj1pKpvrh12bImbSp
 LJgwN5+zoFqlvdw2BI6vMMU+j+rA4GdQ8IqdB7UiUiTBSqgHqa2t2DFU3kOQ/VdXotP3
 1Wcx8mXOiGAT55V35/vGRqPsEMTwVufr8YGW9HQjWfTQ4wRDvl7dJ7e1pZCakj2GQLco
 +C/g==
X-Gm-Message-State: AOAM5322+OzCOb1G2SQS6CEHr7Gpyfo4FhQZAlQ5FVy+TVMjRgEAuo54
 vpzX8XlWDm3doJW1R94HuDi+e6cpy6nn/jSPmX07E+gP79E/JgYp5spKqOLiwtheUoVXPOMw0Hz
 wiprSusca0+WydPnlNbU4pSdlxLjreYi3OpYA43svnw==
X-Received: by 2002:a5d:6d8a:0:b0:204:8aa:309f with SMTP id
 l10-20020a5d6d8a000000b0020408aa309fmr10216362wrs.38.1647955405630; 
 Tue, 22 Mar 2022 06:23:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyByAs22ZvY5MKHs71gUXwXledIH2kM5TZiQ459vndkLSUuZjSqIZEm1xr9SHTYs19ZsINSjw==
X-Received: by 2002:a5d:6d8a:0:b0:204:8aa:309f with SMTP id
 l10-20020a5d6d8a000000b0020408aa309fmr10216347wrs.38.1647955405389; 
 Tue, 22 Mar 2022 06:23:25 -0700 (PDT)
Received: from redhat.com ([2.55.132.0]) by smtp.gmail.com with ESMTPSA id
 az26-20020adfe19a000000b00204154a1d1fsm4599514wrb.88.2022.03.22.06.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Mar 2022 06:23:24 -0700 (PDT)
Date: Tue, 22 Mar 2022 09:23:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Keir Fraser <keirf@google.com>
Subject: Re: [PATCH] virtio: pci: Sanity check the bar index in find_shm_cap
Message-ID: <20220322092255-mutt-send-email-mst@kernel.org>
References: <20220321154931.859511-1-keirf@google.com>
 <CACGkMEuEh+vsDok6hrp96kgGHkxbmzskFMJOouR3mo3d3VjwdQ@mail.gmail.com>
 <YjmU22PnTLEy58+V@google.com>
MIME-Version: 1.0
In-Reply-To: <YjmU22PnTLEy58+V@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
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

On Tue, Mar 22, 2022 at 09:20:27AM +0000, Keir Fraser wrote:
> On Tue, Mar 22, 2022 at 11:36:23AM +0800, Jason Wang wrote:
> > On Mon, Mar 21, 2022 at 11:49 PM Keir Fraser <keirf@google.com> wrote:
> > >
> > > The bar index is used as an index into the device's resource list
> > > and should be checked as within range for a standard bar.
> > >
> > > Signed-off-by: Keir Fraser <keirf@google.com>
> > 
> > Patch looks good, do we need a similar check in vp_modern_map_capability()?
> 
> Yes it looks like we do. Would you like me to fix that also? If so: separate patch, or
> revised version of this patch?

Yes pls. A fixed version is better, less work for everyone.

> > Thanks
> > 
> > > ---
> > >  drivers/virtio/virtio_pci_modern.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
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
> > > --
> > > 2.35.1.894.gb6a874cedc-goog
> > >
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
