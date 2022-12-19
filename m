Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1081C4332F
	for <virtualization@archiver.kernel.org>; Mon, 19 Dec 2022 06:06:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D8BA60B4C;
	Mon, 19 Dec 2022 06:06:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4D8BA60B4C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gy2OMhMv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WYdQRqkeG-KO; Mon, 19 Dec 2022 06:06:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C6F5460681;
	Mon, 19 Dec 2022 06:06:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C6F5460681
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92D04C0032;
	Mon, 19 Dec 2022 06:06:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C938AC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 06:06:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 943D5400FE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 06:06:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 943D5400FE
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gy2OMhMv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1WjZrcTURhWW
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 06:06:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2ADAC400F8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2ADAC400F8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 06:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671429995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XigryfQRFtsWdEbkv6Wm3U8owFw61u6BpVpPnZJFRMg=;
 b=gy2OMhMv44EKa8fkwJ6emkND70G5L83AqWWRZslc3pYmkZ89n8Z4WumKp7vMmsbZqPvWtM
 l/jUWfeoTxzuPxMbu5CE5403iUwLGzwHyfDbxmPWwIcR6w6lk38MjHfzslrH77FSu7p0xQ
 FVHqiA+jCNFx71E2wM/nKwS2hHDI1wQ=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-551-Iw1qPFvCPx2yo7k_OtNBPA-1; Mon, 19 Dec 2022 01:06:32 -0500
X-MC-Unique: Iw1qPFvCPx2yo7k_OtNBPA-1
Received: by mail-oo1-f71.google.com with SMTP id
 v30-20020a4a245e000000b004a4e70a880aso4010829oov.8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Dec 2022 22:06:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XigryfQRFtsWdEbkv6Wm3U8owFw61u6BpVpPnZJFRMg=;
 b=yDUbS8JXiLDC/i6Fg2Bo0O2FuOs/6zIyoCfQ/NoLmJVE3qx9aWwbK0OlFTwptGus6q
 k1Ba9xw4CDYV922ngMcXH6N/gL3NpP1K8JDGWGCQel7WQsxXE3KxS24UPVAwkA5BDgen
 Vl/SfS7t+SGkLwZ+I2++OUzwf6frGt0mLUvS/woE53erpBOtWWPaDPjOkneFjfcTUEc1
 eYGQcAMVu8f1YrPVCLWsNNYlr3tIYC2clgY2aX3X2pSJ2CgZpXvkY/1AT16xP6mg9IT7
 PUI/ueLcwf+CelF7J5qbtWkbLeR0hlvgksma5v09sIxMVO5UapSmnM2lSvVHXe3XYRQs
 C8Rw==
X-Gm-Message-State: AFqh2krhXL783U7jqxRXWGdaFhKIf8YNx5L7IMHRrQJixCGlXIPEc9tH
 RYXUKK/vNtMMOrkimDiiahoIhP/+ggHcqDpenf7nf2FFg7j4jV4bdd9W9S0Q+XzPNqi4cSQkMum
 So2dElfOg24wR0mxe7ZfwjejJRpF4H2XOxSMWmMg4oH9QifUxbcj1Vn7svQ==
X-Received: by 2002:a05:6870:bb1a:b0:144:b22a:38d3 with SMTP id
 nw26-20020a056870bb1a00b00144b22a38d3mr1559335oab.280.1671429991552; 
 Sun, 18 Dec 2022 22:06:31 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtEMJgS1ChBokfoPuf9NBXHkuhyfDrZNuIeENNBw3Xhfy0B/3jRCocYKgxZ7bMQ6hn9bzIu5zP6t5dKWvNJIIo=
X-Received: by 2002:a05:6870:bb1a:b0:144:b22a:38d3 with SMTP id
 nw26-20020a056870bb1a00b00144b22a38d3mr1559328oab.280.1671429991369; Sun, 18
 Dec 2022 22:06:31 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com>
 <20221205084127.535-4-xieyongji@bytedance.com>
 <CACGkMEvYpBz6wdOPFvRveT=0AO=g-nzaeJt3y99oqWDLHUs=qw@mail.gmail.com>
 <CACycT3u237c2jHaYeoPQoXK1eb4FDOJJcc6_21N3m=aBHsDwFg@mail.gmail.com>
In-Reply-To: <CACycT3u237c2jHaYeoPQoXK1eb4FDOJJcc6_21N3m=aBHsDwFg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 19 Dec 2022 14:06:20 +0800
Message-ID: <CACGkMEtoX_jPkJnCB6bx0qkB4pfOAPcSDAdwmd9pL4d8Z3cnEg@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] vdpa: Add set_irq_affinity callback in
 vdpa_config_ops
To: Yongji Xie <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>, "Michael S. Tsirkin" <mst@redhat.com>
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

On Mon, Dec 19, 2022 at 12:39 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Fri, Dec 16, 2022 at 11:58 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Mon, Dec 5, 2022 at 4:43 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > >
> > > This introduces set_irq_affinity callback in
> > > vdpa_config_ops so that vdpa device driver can
> > > get the interrupt affinity hint from the virtio
> > > device driver. The interrupt affinity hint would
> > > be needed by the interrupt affinity spreading
> > > mechanism.
> > >
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > ---
> > >  drivers/virtio/virtio_vdpa.c | 4 ++++
> > >  include/linux/vdpa.h         | 8 ++++++++
> > >  2 files changed, 12 insertions(+)
> > >
> > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > > index 08084b49e5a1..4731e4616ee0 100644
> > > --- a/drivers/virtio/virtio_vdpa.c
> > > +++ b/drivers/virtio/virtio_vdpa.c
> > > @@ -275,9 +275,13 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
> > >         struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
> > >         struct vdpa_device *vdpa = vd_get_vdpa(vdev);
> > >         const struct vdpa_config_ops *ops = vdpa->config;
> > > +       struct irq_affinity default_affd = { 0 };
> > >         struct vdpa_callback cb;
> > >         int i, err, queue_idx = 0;
> > >
> > > +       if (ops->set_irq_affinity)
> > > +               ops->set_irq_affinity(vdpa, desc ? desc : &default_affd);
> >
> > I wonder if we need to do this in vhost-vDPA.
>
> I don't get why we need to do this in vhost-vDPA? Should this be done in VM?

If I was not wrong, this tries to set affinity on the host instead of
the guest. More below.

>
> > Or it's better to have a
> > default affinity by the vDPA parent
> >
>
> I think both are OK. But the default value should always be zero, so I
> put it in a common place.

I think we should either:

1) document the zero default value in vdpa.c
2) set the zero in both vhost-vdpa and virtio-vdpa, or in the vdpa core

>
> > (Looking at virtio-pci, it doesn't do something like this).
> >
>
> Yes, but we did something like this in the pci layer:
> pci_alloc_irq_vectors_affinity().

Ok.

Thanks

>
> Thanks,
> Yongji
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
