Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611A1C3A5A7
	for <virtualization@archiver.kernel.org>; Thu,  8 Dec 2022 07:33:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB01840264;
	Thu,  8 Dec 2022 07:33:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DB01840264
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XMPL66dg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zq3w266nATnj; Thu,  8 Dec 2022 07:33:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2FDB440241;
	Thu,  8 Dec 2022 07:33:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2FDB440241
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8166C0032;
	Thu,  8 Dec 2022 07:33:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6748C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Dec 2022 07:33:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C7AF540247
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Dec 2022 07:33:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C7AF540247
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lRQKG41tt8-i
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Dec 2022 07:33:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C374340241
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C374340241
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Dec 2022 07:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670484807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KKpO4mivO2W1yNm3A0HXsqmTgKdI5x9eAmnflBCtN/Q=;
 b=XMPL66dg2jmzwgrY1JmsCOwNaOfo0NOMy0YeAc4YpimSOnaBp91sZQe2aOX5pA+IxyFyTn
 RPbfgnqa2hRYIUz9RaR+PLoU8pD88IrH1rqQGYcbE0v33r9hpHUZbJYrErRSiWBfUzvcw1
 gozNzekx6y3qLNVTU9TRFiV5zoLazpI=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-307-JGKS6v4qOYqW8EoNQsJhwg-1; Thu, 08 Dec 2022 02:33:26 -0500
X-MC-Unique: JGKS6v4qOYqW8EoNQsJhwg-1
Received: by mail-oo1-f70.google.com with SMTP id
 x13-20020a4a9b8d000000b0049eeca57fbcso169726ooj.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Dec 2022 23:33:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KKpO4mivO2W1yNm3A0HXsqmTgKdI5x9eAmnflBCtN/Q=;
 b=r5vOCdXpRzfxcP5/RnE4HvTlRepYXHehmpIg8gE3GJHnR1IlN9mN+DeGziDARSrUY4
 WQ1Sa5svzA5t/uZPUatQDxAc5RfEPqeMdZYAInKyAGmkVXEZvJgEgizFJQX0oWbcxER9
 sRibf8+biHExEIp2B1Vj/8roDRgxFr2VdJvNaflerUGdVLJObqiOZ0UFgcc/avDz2iuu
 LCXcA7iUlaXgyqTSOzQIToQDxUrPjqtH5XRL9JiUqACXbX0xwC1KjPp6rkNmxpNDVqzY
 lq8lflYqAgjSrNvs4HdggvcxbbBLgdlwGXRDbFn08h1HTMv1NdbdLhtB4qcengndrQnb
 nIvg==
X-Gm-Message-State: ANoB5pkrUKEOPCYPI9jBuCVbv6cFmfVqbR1dEDliAtWGbSEjP4GsLk4s
 cBLYkgiMXL4W3egVmTTqCO0PfdIc2LsFrapbASTVdCjP3uijHzXypZofSg/6CNl0R5O7S/C+FNP
 0wONd6bFT0Q3i8CyOH50diA8D73WPhJR4FerPigpUz1BXZ8MfQPLZc3Inpg==
X-Received: by 2002:a9d:832:0:b0:670:5283:dd3e with SMTP id
 47-20020a9d0832000000b006705283dd3emr6224369oty.201.1670484804226; 
 Wed, 07 Dec 2022 23:33:24 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5Z/YaUgjQym50YJjJOHD3I4Z+BYdpVXLlv581GRTQvj0YH5cF06AcofePFl78CMoLz23eOJpLzJJuRD6RTv/0=
X-Received: by 2002:a9d:832:0:b0:670:5283:dd3e with SMTP id
 47-20020a9d0832000000b006705283dd3emr6224356oty.201.1670484804020; Wed, 07
 Dec 2022 23:33:24 -0800 (PST)
MIME-Version: 1.0
References: <20221207120813.2837529-1-sunnanyong@huawei.com>
 <CACLfguXTQuYjt_ftPS=P-CUoMkiiE9K7=oXhQ4Up8p3g-OwXgw@mail.gmail.com>
In-Reply-To: <CACLfguXTQuYjt_ftPS=P-CUoMkiiE9K7=oXhQ4Up8p3g-OwXgw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 8 Dec 2022 15:33:13 +0800
Message-ID: <CACGkMEtC5Ed+JKhuyRMuvW4eoHNidr3MFNjv2F3-R4R0brrnWA@mail.gmail.com>
Subject: Re: [PATCH] vdpa/vp_vdpa: fix kfree a wrong pointer in vp_vdpa_remove
To: Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: wangkefeng.wang@huawei.com, mst@redhat.com, wangrong68@huawei.com,
 Nanyong Sun <sunnanyong@huawei.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, liushixin2@huawei.com,
 gautam.dawar@xilinx.com, elic@nvidia.com
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

On Thu, Dec 8, 2022 at 10:05 AM Cindy Lu <lulu@redhat.com> wrote:
>
> On Wed, 7 Dec 2022 at 19:23, Nanyong Sun <sunnanyong@huawei.com> wrote:
> >
> > From: Rong Wang <wangrong68@huawei.com>
> >
> > In vp_vdpa_remove(), the code kfree(&vp_vdpa_mgtdev->mgtdev.id_table) uses
> > a reference of pointer as the argument of kfree, which is the wrong pointer
> > and then may hit crash like this:
> >
> > Unable to handle kernel paging request at virtual address 00ffff003363e30c
> > Internal error: Oops: 96000004 [#1] SMP
> > Call trace:
> >  rb_next+0x20/0x5c
> >  ext4_readdir+0x494/0x5c4 [ext4]
> >  iterate_dir+0x168/0x1b4
> >  __se_sys_getdents64+0x68/0x170
> >  __arm64_sys_getdents64+0x24/0x30
> >  el0_svc_common.constprop.0+0x7c/0x1bc
> >  do_el0_svc+0x2c/0x94
> >  el0_svc+0x20/0x30
> >  el0_sync_handler+0xb0/0xb4
> >  el0_sync+0x160/0x180
> > Code: 54000220 f9400441 b4000161 aa0103e0 (f9400821)
> > SMP: stopping secondary CPUs
> > Starting crashdump kernel...
> >
> > Fixes: ffbda8e9df10 ("vdpa/vp_vdpa : add vdpa tool support in vp_vdpa")
> > Signed-off-by: Rong Wang <wangrong68@huawei.com>
> > Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
> > ---
> >  drivers/vdpa/virtio_pci/vp_vdpa.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > index d448db0c4de3..8fe267ca3e76 100644
> > --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > @@ -647,7 +647,7 @@ static void vp_vdpa_remove(struct pci_dev *pdev)
> >         mdev = vp_vdpa_mgtdev->mdev;
> >         vp_modern_remove(mdev);
> >         vdpa_mgmtdev_unregister(&vp_vdpa_mgtdev->mgtdev);
> > -       kfree(&vp_vdpa_mgtdev->mgtdev.id_table);
> > +       kfree(vp_vdpa_mgtdev->mgtdev.id_table);
> >         kfree(mdev);
> >         kfree(vp_vdpa_mgtdev);
> >  }
> > --
> > 2.25.1
> >
> Reviewed-by: Cindy Lu <lulu@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
