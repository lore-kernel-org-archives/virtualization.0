Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AABFECAAD3
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 06:53:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 04DA7402F5;
	Wed,  7 Sep 2022 06:53:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 04DA7402F5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RRkiIXbl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fPqHX62Lb9AM; Wed,  7 Sep 2022 06:53:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 708C540199;
	Wed,  7 Sep 2022 06:53:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 708C540199
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 466B8C0033;
	Wed,  7 Sep 2022 06:53:37 +0000 (UTC)
Received: from smtp4.osuosl.org (unknown
 [IPv6:2605:bc80:3010:0:a800:ff:fe79:d16b])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67FB7C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 06:53:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3807F40193
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 06:53:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3807F40193
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RRkiIXbl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Agl9hcwGixXw
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 06:53:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1436E40187
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1436E40187
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 06:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662533612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W5bAvksPKLrdgVN4e/5QNhWQHloHMa0JMC3CFrEBk7Q=;
 b=RRkiIXbl5R1wRP392Iit3uEKxrMBA2UCmgyRuz12MCMKYHE2iZKCxVZl5sJQhpjaRxiSED
 hfxw8qvbLAoBty1CTQst0tXZ4a8/7fkaZ4buBLBlWIBZshUVTFn1q2vZFhtfFDUY9c+JI9
 h4rYDzEm8QsALGCrQqZOYIdpgyqsobs=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-329-NgESoQorOv2zZ45rbI8nkg-1; Wed, 07 Sep 2022 02:53:31 -0400
X-MC-Unique: NgESoQorOv2zZ45rbI8nkg-1
Received: by mail-ua1-f72.google.com with SMTP id
 50-20020ab00435000000b003af2b0ed833so1175463uav.22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Sep 2022 23:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=W5bAvksPKLrdgVN4e/5QNhWQHloHMa0JMC3CFrEBk7Q=;
 b=ICr/Ldi6RBXjAZ1DFieuul0qlGKOKBF2gxhCEOapqcNBdX/WkbJrxj9s7aDngKzTso
 0MvJCmKkAoWo6KoM9BE/YNGhvGAJyEF3XmvgUW+Yh+cSUklOpBKz0QJQBRvUxrFsdpB5
 V7BsdwDbb8BfgmQnf9T/bYz3vX0MAyx09ON490Y2mryGiInTlfy+OtTnY2lYbalCJoVX
 Z+Z8/OyA80D+A4jJhrJnOIRZduOrxdbGgDUjQPYSH47F/1pTmRqbTKAxcWc5f1go4enX
 f4CMAjnJAblW9k4ll8epVeGnIviQ/Rxk0M8ZdWgjFKi4XUloWvWrysmwEYW4Z5gFkGPE
 fd8A==
X-Gm-Message-State: ACgBeo3OyLVSJtsvhgcuR6EuymaHj64O//b70QjA9iCv7VV2XLyqo38j
 F/AtTP1gfeqHZqu0yePJJUvD9ryt4XCHT8dsjj0k1tiNjX3mHkfLdoZZNtZg8DE2FVUlem450vl
 ziR1JhWPk+B0eBpQgka0vdicD1Bog+J78CgVdMNzDImd2fF5nmDIf0NoT5Q==
X-Received: by 2002:a05:6102:fa5:b0:390:d814:d6d7 with SMTP id
 e37-20020a0561020fa500b00390d814d6d7mr618674vsv.4.1662533611002; 
 Tue, 06 Sep 2022 23:53:31 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5FbL6e/AWOk14APVaDLNoldSpD/ONXWmJIFKefHXYftZCmw0UrSHde+x+r5ao9C04Kp4d7MHC7tPpo2ffYND4=
X-Received: by 2002:a05:6102:fa5:b0:390:d814:d6d7 with SMTP id
 e37-20020a0561020fa500b00390d814d6d7mr618670vsv.4.1662533610842; Tue, 06 Sep
 2022 23:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220907060110.4511-1-jasowang@redhat.com>
 <DM8PR12MB540034620ADF0AE749C2D099AB419@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB540034620ADF0AE749C2D099AB419@DM8PR12MB5400.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 7 Sep 2022 14:53:19 +0800
Message-ID: <CACGkMEvjgyxs3HX_ZzUbMticntqnUxDQJMrr2MqTBwuRB7jCdw@mail.gmail.com>
Subject: Re: [PATCH] vdpa: conditionally fill max max queue pair for stats
To: Eli Cohen <elic@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>
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

On Wed, Sep 7, 2022 at 2:11 PM Eli Cohen <elic@nvidia.com> wrote:
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, 7 September 2022 9:01
> > To: mst@redhat.com; jasowang@redhat.com; Eli Cohen <elic@nvidia.com>;
> > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH] vdpa: conditionally fill max max queue pair for stats
> >
> > For the device without multiqueue feature, we will read 0 as
> > max_virtqueue_pairs from the config.
> If this is the case for other vdpa vendor drivers, shouldn't we fix it there? After all,
> config->max_virtqueue_pairs should always show valid values.

Not for the case when the device doesn't offer MQ. According to the
spec, the max_virtqueue_pairs doesn't exist in this case.

>
> > So if we fill
> > VDPA_ATTR_DEV_NET_CFG_MAX_VQP with the value we read from the
> > config
> > we will confuse the user.
> >
> > Fixing this by only filling the value when multiqueue is offered by
> > the device so userspace can assume 1 when the attr is not provided.
> >
> > Fixes: 13b00b135665c("vdpa: Add support for querying vendor statistics")
> > Cc: Eli Cohen <elic@nvidia.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/vdpa/vdpa.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > index c06c02704461..bc328197263f 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -894,7 +894,6 @@ static int vdpa_fill_stats_rec(struct vdpa_device
> > *vdev, struct sk_buff *msg,
> >  {
> >       struct virtio_net_config config = {};
> >       u64 features;
> > -     u16 max_vqp;
> >       u8 status;
> >       int err;
> >
> > @@ -905,15 +904,15 @@ static int vdpa_fill_stats_rec(struct vdpa_device
> > *vdev, struct sk_buff *msg,
> >       }
> >       vdpa_get_config_unlocked(vdev, 0, &config, sizeof(config));
> >
> > -     max_vqp = __virtio16_to_cpu(true, config.max_virtqueue_pairs);
> > -     if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
> > max_vqp))
> > -             return -EMSGSIZE;
> > -
> >       features = vdev->config->get_driver_features(vdev);
> >       if (nla_put_u64_64bit(msg,
> > VDPA_ATTR_DEV_NEGOTIATED_FEATURES,
> >                             features, VDPA_ATTR_PAD))
> >               return -EMSGSIZE;
> >
> > +     err = vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
> > +     if (err)
> > +             return err;
> > +
>
> So that means that you can't read statistics when MQ is not supported. Is this worth sacrificing?

vdpa_dev_net_mq_config_fill() will return 0 in the case of !MQ, so it
should still work.

Thanks


>
> >       if (nla_put_u32(msg, VDPA_ATTR_DEV_QUEUE_INDEX, index))
> >               return -EMSGSIZE;
> >
> > --
> > 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
