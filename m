Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACA3C433EF
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 11:07:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6D3860F23
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 11:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A6D3860F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D01E60891;
	Wed, 13 Oct 2021 11:07:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NRgBD3AcnRLX; Wed, 13 Oct 2021 11:07:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9AA6960877;
	Wed, 13 Oct 2021 11:06:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67675C001B;
	Wed, 13 Oct 2021 11:06:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A214C000F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 11:06:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7DC9B40795
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 11:06:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VHefa-Z3TWhu
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 11:06:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B7EFD40788
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 11:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634123216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mq9NhbL5Zl74gGkKc/51xfvAj3iKoFtcHheg7vPpxUE=;
 b=f6w8vp6vqyNXUYPhXQREKH5J/RS0aJNW2kI/iQQboYKaue2gR316tK+lISD+QHwluWaq7u
 mQnLsAEJ//nYzJ7YzsnjQ1MNvCRAzUsHpQcZWdbSTfNwbf7Cu2uwI3+FxRIbHT8XWNl/1S
 4QE7s3NJpMwv3KidFJVY1Gy+zeOatDE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-vDm4qtsJNa2XqBKgmjja5g-1; Wed, 13 Oct 2021 07:06:55 -0400
X-MC-Unique: vDm4qtsJNa2XqBKgmjja5g-1
Received: by mail-wr1-f71.google.com with SMTP id
 d13-20020adfa34d000000b00160aa1cc5f1so1666599wrb.14
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 04:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Mq9NhbL5Zl74gGkKc/51xfvAj3iKoFtcHheg7vPpxUE=;
 b=PCzCV13EOguzwVCkvM9SQ8Fe5cAzLDIwNtqPnxXeFs/TwjspNDUIaPAc/2kXmx4cdb
 Ob1H6GD4eoSzhQwgkoqDJ+uzKXxFsl05kiMcRx6YRek00msVuOLOUvEenUhvlHstc02P
 H8v6Ju0pCTDxkPEHtuYChqO5fkjK5v3M6zW66tF9p+KpGHrcgj31627eHf6Fmwe89ewh
 Ega8OYHKA3xxvr/ZUwofQIYMzzO2zoYOKne7JegqCN3P9e2L5MVdPe2CaO5cKu81529I
 n7kL8hhX0j7mmkZVVqdKs4AQNtEHXy69mELbxx+am/3LQGtEVJBsmuO+7OnjWMtNpVRI
 rzCw==
X-Gm-Message-State: AOAM531rxUMHVWXpyVQ5fcaEQmuORdX1TE7Rx5I8OTBsfk8LvEkGSk8Y
 8WKYm/V81YAHBpkQkaBeKEqUFw+kOsGKx5E0ZD8oi/NeqdlfkvN2p2YXHLB2jTSNlwNxbUHGE5C
 VncrrJ7nfPnx7jWFLoxzAcUkWcvCkrHj7X65TqP6wdQ==
X-Received: by 2002:a05:6000:1563:: with SMTP id
 3mr10663577wrz.152.1634123214144; 
 Wed, 13 Oct 2021 04:06:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrzot4ISfYRR0QDR70USAamtKa/Kw9Z8YSfKsW6zi3qA39y4gr9aIk8dLYQh3aRPBY3ZVEfQ==
X-Received: by 2002:a05:6000:1563:: with SMTP id
 3mr10663554wrz.152.1634123213925; 
 Wed, 13 Oct 2021 04:06:53 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
 by smtp.gmail.com with ESMTPSA id s186sm5524280wme.14.2021.10.13.04.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 04:06:53 -0700 (PDT)
Date: Wed, 13 Oct 2021 07:06:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v2] vduse: Fix race condition between resetting and irq
 injecting
Message-ID: <20211013070627-mutt-send-email-mst@kernel.org>
References: <20210929083050.88-1-xieyongji@bytedance.com>
 <CACGkMEtYny-5pH8o0BjMjpDU3ZOVq5rLQV11AqpxDEpsYpGPKQ@mail.gmail.com>
 <CACycT3vp-kxMGVL8W=ebQgOFt_aWs5Y33ZML-Up8KuwsTfQCwA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3vp-kxMGVL8W=ebQgOFt_aWs5Y33ZML-Up8KuwsTfQCwA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization <virtualization@lists.linux-foundation.org>
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

On Wed, Sep 29, 2021 at 04:50:24PM +0800, Yongji Xie wrote:
> On Wed, Sep 29, 2021 at 4:41 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Wed, Sep 29, 2021 at 4:32 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > >
> > > The interrupt might be triggered after a reset since there is
> > > no synchronization between resetting and irq injecting. And it
> > > might break something if the interrupt is delayed until a new
> > > round of device initialization.
> > >
> > > Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 37 +++++++++++++++++++++++++------------
> > >  1 file changed, 25 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > index cefb301b2ee4..841667a896dd 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -80,6 +80,7 @@ struct vduse_dev {
> > >         struct vdpa_callback config_cb;
> > >         struct work_struct inject;
> > >         spinlock_t irq_lock;
> > > +       struct rw_semaphore rwsem;
> > >         int minor;
> > >         bool broken;
> > >         bool connected;
> > > @@ -410,6 +411,8 @@ static void vduse_dev_reset(struct vduse_dev *dev)
> > >         if (domain->bounce_map)
> > >                 vduse_domain_reset_bounce_map(domain);
> > >
> > > +       down_write(&dev->rwsem);
> > > +
> > >         dev->status = 0;
> > >         dev->driver_features = 0;
> > >         dev->generation++;
> > > @@ -443,6 +446,8 @@ static void vduse_dev_reset(struct vduse_dev *dev)
> > >                 flush_work(&vq->inject);
> > >                 flush_work(&vq->kick);
> > >         }
> > > +
> > > +       up_write(&dev->rwsem);
> >
> > Rethink about this, do we need to sync set_status() as well?
> >
> 
> I'm not sure. But I don't see any case that needs synchronization.
> 
> Thanks,
> Yongji

Well you are testing under a lock but it can change at any time...

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
