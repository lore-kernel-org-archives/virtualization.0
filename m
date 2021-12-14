Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88817C433F5
	for <virtualization@archiver.kernel.org>; Tue, 14 Dec 2021 08:53:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19A5C60B91;
	Tue, 14 Dec 2021 08:53:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1_ii6YaTJrHb; Tue, 14 Dec 2021 08:53:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B3A286068F;
	Tue, 14 Dec 2021 08:53:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73C5DC001E;
	Tue, 14 Dec 2021 08:53:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63865C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 08:53:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 52A2F40194
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 08:53:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FT-ZdTno218R
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 08:53:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 700C5400C9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 08:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639471995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D+FJ51g4bkkjesocmgOAMB2yzFCTLT2ZmmHAF7MwAmI=;
 b=FBdpUly6Jlz39/MPJeLkGe9xkRRaAYH8NZG4q641twADBsu2hhoDwiAoRLhpVUbPJlc3NF
 xmnCKVoN8lLi+162ENo5XmJtfNRyCQt0L9u9kq+fMt+J6+TLpOmOkWQTi2gf9OR+rugzUe
 Z0YhgQON1ieC9MniyokhnJrLepvkPKU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-UooQ4NexMkaz932Guxw1Hg-1; Tue, 14 Dec 2021 03:53:13 -0500
X-MC-Unique: UooQ4NexMkaz932Guxw1Hg-1
Received: by mail-lf1-f71.google.com with SMTP id
 o11-20020a056512230b00b0041ca68ddf35so8701575lfu.22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 00:53:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D+FJ51g4bkkjesocmgOAMB2yzFCTLT2ZmmHAF7MwAmI=;
 b=zkUJh1mLd5QaE5AKcfcP5Rce96HKUw8HWVPyo7Nb5rIbFsrFbZ4qO5BgiU+vuTm/Vs
 A5YXiq9+Ae50kas3318bwygKo8ADStb8/fXQXHbtwKxGr4O4zyf//J4dgVba3jym9amU
 P2xnKK3Pb80f6+qLlC53pKpi0/p4ZjkHGC+i9/VRfFbylf8pi2z8UeDooNGNBU1FfZRz
 +PI4ns3bVtGxNG0wMstT1bRbEcPEfH7lOVKyK/1Fs9REZh5+OdemffTUfskXd4B6rfnl
 BuP+OHEvFREjMHcHMmGUzMjr3hH/moMFQ+lR5K54ebsR7fGw3UyDTF35VnR4gyF8Sg0p
 xllQ==
X-Gm-Message-State: AOAM533XPCocpDRkXZl/ljWW4G0tWLa6ILhC0GaEo3kxkJ/o3ic4XHUD
 dQ7pk339wwV6n1/2EQAH1RjU1pUxss8/fvEeFLq2GX69Q3vdmyfWnfav18+0ZO4WcmuMylpL7bO
 bmbhadSYTXn/hGu6MmiGTTvp2Sh2Fa8IaMOP6WOCNc2igNLef+z9QVhhxOQ==
X-Received: by 2002:a2e:3012:: with SMTP id w18mr3585352ljw.217.1639471991635; 
 Tue, 14 Dec 2021 00:53:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzi2MaIVGYi/BowshT7n/i1WFrOMw9+dRdWFcJ7NWVRBBACyYaK8t1f+KHlzYhIZ9TZRKROlbvHvYU2n+kYhlE=
X-Received: by 2002:a2e:3012:: with SMTP id w18mr3585341ljw.217.1639471991424; 
 Tue, 14 Dec 2021 00:53:11 -0800 (PST)
MIME-Version: 1.0
References: <20211213144258.179984-1-elic@nvidia.com>
 <20211213144258.179984-4-elic@nvidia.com>
 <CACGkMEuJPc6jU0f3ZjEJJoXqZ_07WXEUcZoU0UgFoBPXUu0K-Q@mail.gmail.com>
 <20211214071411.GA89087@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20211214071411.GA89087@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Dec 2021 16:53:00 +0800
Message-ID: <CACGkMEsDYWtS22EpGL=oEh75X2=2GZj0YrHkzqnu0VETUKYVfQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] vdpa: Read device configuration only if
 FEATURES_OK
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>
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

On Tue, Dec 14, 2021 at 3:14 PM Eli Cohen <elic@nvidia.com> wrote:
>
> On Tue, Dec 14, 2021 at 11:44:06AM +0800, Jason Wang wrote:
> > On Mon, Dec 13, 2021 at 10:43 PM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > > Avoid reading device configuration during feature negotiation. Read
> > > device status and verify that VIRTIO_CONFIG_S_FEATURES_OK is set.
> > > Otherwise, return -EAGAIN.
> > >
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> >
> >
> >
> > > ---
> > >  drivers/vdpa/vdpa.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > index 42d71d60d5dc..5749cf0a1500 100644
> > > --- a/drivers/vdpa/vdpa.c
> > > +++ b/drivers/vdpa/vdpa.c
> > > @@ -819,8 +819,15 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
> > >  {
> > >         u32 device_id;
> > >         void *hdr;
> > > +       u8 status;
> > >         int err;
> > >
> > > +       status = vdev->config->get_status(vdev);
> > > +       if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
> > > +               NL_SET_ERR_MSG_MOD(extack, "Features negotiation not completed");
> > > +               return -EAGAIN;
> > > +       }
> > > +
> > >         hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
> > >                           VDPA_CMD_DEV_CONFIG_GET);
> > >         if (!hdr)
> >
> > It looks to me we need to synchronize this with set_status() and
> > cf_mutex (set_config).
>
> Makes sense.
>
> >
> > Or simply return all the config space (the maximum set of features)
>
> No sure I follow you on this. Are you suggesting to return in the
> netlink message all the fields of struct virtio_net_config as individual fields?
>
> How is this related to the need to sync with cf_mutex?

I meant the reason for the synchronization is because some config
fields depend on the feature negotiation. I wonder if it would be
easier we just return all the possible config fields, then there's
probably no need for the synchronization since we don't need to check
the driver feature but the device features.

Thanks

>
> >
> > Thanks
> >
> > > --
> > > 2.33.1
> > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
