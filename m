Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB29C433EF
	for <virtualization@archiver.kernel.org>; Wed,  8 Dec 2021 22:19:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A26160675;
	Wed,  8 Dec 2021 22:19:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yqvdslOqOP8W; Wed,  8 Dec 2021 22:19:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2695E60B8D;
	Wed,  8 Dec 2021 22:19:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E845BC001E;
	Wed,  8 Dec 2021 22:19:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5AABC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 22:19:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 90A9C60B8D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 22:19:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q7bJu5KvHJPT
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 22:19:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5514D60675
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 22:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639001955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PreSFQ9NMf7Pktne6qmfy8XkfYdhqYpBJuPe8BD+6Po=;
 b=Shrf52X2yrHP9lZQsDnaBQLNkzCpcnwjgyXodLGNlrKEH0MC0iEq+RynxYs5F8uIAjNijM
 knpo1xOt4L8NxX4APN2ostq08GXLCbRgQ2i3jDZjyq87XpAXsYI9VXd2sNB2GPHm1i+NOo
 h3+8dC0czNYQmVeJ2WaHfhapka/u/Iw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-531-KfWaSLr4MPKFkd0dqjRYkQ-1; Wed, 08 Dec 2021 17:19:11 -0500
X-MC-Unique: KfWaSLr4MPKFkd0dqjRYkQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 ay17-20020a05600c1e1100b0033f27b76819so2033616wmb.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Dec 2021 14:19:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PreSFQ9NMf7Pktne6qmfy8XkfYdhqYpBJuPe8BD+6Po=;
 b=r7il8n/2cGSFEmHBRJdJ0O3PbI8Y6BrWv44ptDBLuU77DZnInA0cboJ5qE/hxFgf3N
 SVxRBVxantaP8WJ6gUXqQLqgAWIM5/O/SBqIGG3O4bnMefBqSf7937T79Waz0U8a009m
 jlfJY8EL6AtaNXFDzFxodjJAv3UwrY3RoIJEOmDZFCL4Xz9M+VVhGFte4u0oq7zQnD6k
 BXLg93WG+DMeQaIa+rJm7geNnQsTNQkH3zeCvc0o4F17hH/6P3Sh8OuiMJHICNdyOgh3
 yMdyFkrpZhfUIvTgx15ABFpHakkaX9CAoaqqo84G3oKDZM7YuLwni3G4UN6QmXBJHLak
 3uJQ==
X-Gm-Message-State: AOAM531LJ+heREK396FMX76wkmUOATbot8HAb7pC0WlIcjXMsq4pEoSR
 lNwlCDHeMgRf992lvanhubtahsgP01Bfw8XZR9ViwtFgVYlJn6ywLhq2EJSMTwqxOaZrGC+DudG
 E8LRYC+x60oENkKmHNUEsLgSz1Od/lvkZA7hwyKxE8w==
X-Received: by 2002:a05:600c:19d1:: with SMTP id
 u17mr1996602wmq.148.1639001950826; 
 Wed, 08 Dec 2021 14:19:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPeV5Bfi1VRi8kXW0PzecBfblsGTyIGjeEBtvY+g2p2clfaT3svOHOc+bqkdPnkKT0oPbV/A==
X-Received: by 2002:a05:600c:19d1:: with SMTP id
 u17mr1996565wmq.148.1639001950477; 
 Wed, 08 Dec 2021 14:19:10 -0800 (PST)
Received: from redhat.com ([2.55.18.120])
 by smtp.gmail.com with ESMTPSA id n1sm4102671wmq.6.2021.12.08.14.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Dec 2021 14:19:09 -0800 (PST)
Date: Wed, 8 Dec 2021 17:19:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] eni_vdpa: alibaba: select VIRTIO_PCI_LIB
Message-ID: <20211208171830-mutt-send-email-mst@kernel.org>
References: <20211203185522.692489-1-arnd@kernel.org>
 <20211208144916-mutt-send-email-mst@kernel.org>
 <CAK8P3a0w9ij80Ww7rkaxutXFynOnC6=gEBQZ-X0Va+dx5jxfPg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0w9ij80Ww7rkaxutXFynOnC6=gEBQZ-X0Va+dx5jxfPg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>,
 Xie Yongji <xieyongji@bytedance.com>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, Eli Cohen <elic@nvidia.com>
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

On Wed, Dec 08, 2021 at 10:31:03PM +0100, Arnd Bergmann wrote:
> On Wed, Dec 8, 2021 at 8:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Dec 03, 2021 at 07:55:14PM +0100, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > When VIRTIO_PCI_LIB is not built-in but the alibaba driver is, the
> > > kernel runs into a link error:
> > >
> > > x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_features':
> > > eni_vdpa.c:(.text+0x23f): undefined reference to `vp_legacy_set_features'
> > > x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_vq_state':
> > > eni_vdpa.c:(.text+0x2fe): undefined reference to `vp_legacy_get_queue_enable'
> > > x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_vq_address':
> > > eni_vdpa.c:(.text+0x376): undefined reference to `vp_legacy_set_queue_address'
> > > x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_vq_ready':
> > > eni_vdpa.c:(.text+0x3b4): undefined reference to `vp_legacy_set_queue_address'
> > > x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_free_irq':
> > > eni_vdpa.c:(.text+0x460): undefined reference to `vp_legacy_queue_vector'
> > > x86_64-linux-ld: eni_vdpa.c:(.text+0x4b7): undefined reference to `vp_legacy_config_vector'
> > > x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_reset':
> > >
> > > Selecting VIRTIO_PCI_LIB_LEGACY is not sufficient here since that is
> > > only part of the VIRTIO_PCI_LIB support.
> > >
> > > Fixes: e85087beedca ("eni_vdpa: add vDPA driver for Alibaba ENI")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> >
> > Confused. These are all part of
> > drivers/virtio/virtio_pci_legacy_dev.c
> >
> > and
> > obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o
> >
> > what gives?
> 
> The patch was wrong, see
> 
> https://lore.kernel.org/lkml/20211206085034.2836099-1-arnd@kernel.org/
> 
> for the correct fix.
> 
>         Arnd

Oh, ok then, I picked that one up, that explains why the issue does not
reproduce for me.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
