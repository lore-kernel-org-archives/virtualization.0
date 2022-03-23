Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B8BC433EF
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 12:02:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E47F3812F5;
	Wed, 23 Mar 2022 12:02:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MljGvkRXDCsw; Wed, 23 Mar 2022 12:02:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6191180D18;
	Wed, 23 Mar 2022 12:02:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12822C001A;
	Wed, 23 Mar 2022 12:02:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EDEBC001A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 12:02:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 22E47849CB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 12:01:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n32ydGc47MCW
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 12:01:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 40E638499F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 12:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648036910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=06IKLeK1HPa8EqbWxS+T+9EJyp3Gy0v+dNMgxkBuw9M=;
 b=ZXoVqGjRSee2gRF5tmHgBiDSXLiDtPi3OgpcEiyS37ZibR3f0Tthj+y3anEyumM5U0OijE
 lvnjQsg8cp0fCnnNDKf4rXie+H9bicgkTRliLfwLtd8CybpsAETlid1FbRiFzEchr9YIBi
 cKYSh66ReBjxpVuJ2y+ntUSW+oRlZF0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-bHsAfJEXMNi5aMVd3bvhaw-1; Wed, 23 Mar 2022 08:01:48 -0400
X-MC-Unique: bHsAfJEXMNi5aMVd3bvhaw-1
Received: by mail-wm1-f72.google.com with SMTP id
 12-20020a05600c24cc00b0038c6caa95f7so535579wmu.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 05:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=06IKLeK1HPa8EqbWxS+T+9EJyp3Gy0v+dNMgxkBuw9M=;
 b=dGeSfdah1N8voAZGUagywa741ylTg2bTFhnxVj+9mrn3QdBbhVnSgH65rmplu/lvyt
 S5IyQFMLtK7VigFeT6R5EPDAyDsr0XM0KGO0Xc28zQzp0xu0CMuuvtdmzexvt0RbMUyn
 oHwx04otKRH1ZwbYstxAuc97rL70tiJd2mtg/vpbFSyM+UIrDuM8Ns0u/IKhKwmkJE+j
 rPJsFaA1WqyBQhabjEv0pNwUcIGGKj88WE7MMyXceizO+DHE8teYN3h+vVad3d0PwG3F
 qfZp/66g3tNUY2aKthknrAIgEY4KVLeR8dLnV2KF6lxXH3ZhHD1hy6PGyjlVySWoiizk
 JRVg==
X-Gm-Message-State: AOAM5304NhaBbEsM0i04Ov4nJJzm+HtCRLwTd3BoEWcp6Zi7zQzSvd1B
 W9OM+iDjyNpjhhInPgTYs3PzJEwI1+miAByGcxhAA/pLsSYWIUNC5ryNEyYlw81yKNgGoUPeQfU
 Wil8Y1dZXfxnddMR52lMKkN5EPb9j8YAWD8iICrnCvw==
X-Received: by 2002:a5d:6750:0:b0:203:efaf:9fc1 with SMTP id
 l16-20020a5d6750000000b00203efaf9fc1mr23869412wrw.252.1648036907175; 
 Wed, 23 Mar 2022 05:01:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynjLJRb91b0j7OuTthwiOqxaUOL6Ex8tKvWylL7WSkMnM9JIzW97AzFCAg5VkEOFL8tDHc5w==
X-Received: by 2002:a5d:6750:0:b0:203:efaf:9fc1 with SMTP id
 l16-20020a5d6750000000b00203efaf9fc1mr23869390wrw.252.1648036906938; 
 Wed, 23 Mar 2022 05:01:46 -0700 (PDT)
Received: from redhat.com ([2.55.151.118]) by smtp.gmail.com with ESMTPSA id
 i74-20020adf90d0000000b0020373ba7beesm26224455wri.0.2022.03.23.05.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 05:01:45 -0700 (PDT)
Date: Wed, 23 Mar 2022 08:01:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2] virtio: pci: sanity check bar indexes
Message-ID: <20220323075030-mutt-send-email-mst@kernel.org>
References: <20220322151952.2950143-1-keirf@google.com>
 <CACGkMEubcU4rFVem7neKYb-qT3TQUN802bbLNq7vh+y8gdD5AA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEubcU4rFVem7neKYb-qT3TQUN802bbLNq7vh+y8gdD5AA@mail.gmail.com>
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

On Wed, Mar 23, 2022 at 03:57:59PM +0800, Jason Wang wrote:
> On Tue, Mar 22, 2022 at 11:20 PM Keir Fraser <keirf@google.com> wrote:
> >
> > The bar index is used as an index into the device's resource list
> > and should be checked as within range for a standard bar.
> >
> > Also clean up an existing check to consistently use PCI_STD_NUM_BARS.
> >
> > Signed-off-by: Keir Fraser <keirf@google.com>
> > ---
> >  drivers/virtio/virtio_pci_modern.c     | 10 ++++++++--
> >  drivers/virtio/virtio_pci_modern_dev.c |  8 +++++++-
> >  2 files changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > index 5455bc041fb6..84bace98dff5 100644
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
> > @@ -317,7 +317,12 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
> >
> >                 /* Type, and ID match, looks good */
> >                 pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> > -                                                        bar), bar);
> > +                                                        bar), &res_bar);
> > +               if (res_bar >= PCI_STD_NUM_BARS) {
> > +                       dev_err(&dev->dev, "%s: shm cap with bad bar: %d\n",
> > +                               __func__, res_bar);
> > +                       continue;
> > +               }
> >
> >                 /* Read the lower 32bit of length and offset */
> >                 pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap,

In fact, the spec says such BAR values are reserved, not bad, so
the capabiluty should be ignored, they should not cause the driver to error out
or print errors.

> > @@ -337,6 +342,7 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
> >                                                      length_hi), &tmp32);
> >                 res_length |= ((u64)tmp32) << 32;
> >
> > +               *bar = res_bar;
> >                 *offset = res_offset;
> >                 *len = res_length;
> >
> > diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> > index e8b3ff2b9fbc..a6911d1e212a 100644
> > --- a/drivers/virtio/virtio_pci_modern_dev.c
> > +++ b/drivers/virtio/virtio_pci_modern_dev.c
> > @@ -35,6 +35,12 @@ vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
> >         pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap, length),
> >                               &length);
> >
> > +       if (bar >= PCI_STD_NUM_BARS) {
> > +               dev_err(&dev->dev,
> > +                       "virtio_pci: bad capability bar %u\n", bar);

In fact, I would say the issue is less that bar is reserved.
The real issue is that the value apparently changed since
we read it the first time. I think it's a good idea to
reflect that in the message. Maybe find_capability should return
the capability structure so we don't need to re-read it from
the device?

> > +               return NULL;
> > +       }
> > +
> >         if (length <= start) {
> >                 dev_err(&dev->dev,
> >                         "virtio_pci: bad capability len %u (>%u expected)\n",
> > @@ -120,7 +126,7 @@ static inline int virtio_pci_find_capability(struct pci_dev *dev, u8 cfg_type,
> >                                      &bar);
> >
> >                 /* Ignore structures with reserved BAR values */
> > -               if (bar > 0x5)
> > +               if (bar >= PCI_STD_NUM_BARS)
> >                         continue;
> 
> Just notice that the spec said:
> 
> "
> values 0x0 to 0x5 specify a Base Address register (BAR) belonging to
> the function located beginning at 10h in PCI Configuration Space and
> used to map the structure into Memory or I/O Space. The BAR is
> permitted to be either 32-bit or 64-bit, it can map Memory Space or
> I/O Space.
> 
> Any other value is reserved for future use.
> "
> So we probably need to stick 0x5 instead of 0x6 (PCI_STD_NUM_BARS) for
> this and other places.
> 
> Thanks

It does not matter much IMHO, the reason spec uses 0 to 0x5 is precisely
because that's the standard number of BARs. Both ways work as long as we
are consistent, and I guess PCI_STD_NUM_BARS might be preferable since
people tend to copy paste values.


> >
> >                 if (type == cfg_type) {
> > --
> > 2.35.1.894.gb6a874cedc-goog
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
