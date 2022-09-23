Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42563C6FA8E
	for <virtualization@archiver.kernel.org>; Fri, 23 Sep 2022 04:20:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA05583E07;
	Fri, 23 Sep 2022 04:20:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BA05583E07
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LcACmQYH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w_6DHtwoCqJ7; Fri, 23 Sep 2022 04:20:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4058F837C9;
	Fri, 23 Sep 2022 04:20:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4058F837C9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 288F0C0033;
	Fri, 23 Sep 2022 04:20:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC43BC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 04:20:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 86FB941796
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 04:20:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 86FB941796
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LcACmQYH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CNzQpxcdukDp
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 04:20:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 72EC041795
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 72EC041795
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 04:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663906825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zEIeJ9KcUC7PEIn7+/HEyTDs3dhCwcqq5MBHBVNCbfg=;
 b=LcACmQYH/SwFP5MmsDUeO7jBowTlA2U0D+YYJXA9JFDYqf4UZjefNyPhPxvTweYS0hYIvN
 1uDIUvUHzbD4nfrohmO9T1ONWHXWnhPnSavL41lAWzsfGoSYG1449U3bIGV/lyOkco7MBa
 6Mw1x7tOtdDFAwHncjv0PD9ofoavO30=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-580-NNmJ8wxZOl6ZkUgwZXOtzQ-1; Fri, 23 Sep 2022 00:20:24 -0400
X-MC-Unique: NNmJ8wxZOl6ZkUgwZXOtzQ-1
Received: by mail-ot1-f71.google.com with SMTP id
 p4-20020a9d4544000000b0065952fed1aeso5419884oti.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 21:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=zEIeJ9KcUC7PEIn7+/HEyTDs3dhCwcqq5MBHBVNCbfg=;
 b=nyn0QTaRyjXIdgwDfH2OozEVr4wi710xLpePVpb5oOrqMkXiHK2x+77qEcjA5dN0DI
 cM1kihfXOlJyyVCBn4Q7RQm/DXrqAfdFTaRofaR49gsGtOG/fystLu6q7xs4Kw7Vqrw+
 G3T6mnuZsWzs35vBNgRpsjjY49R0iDKw8G9C7mDdqvpNQzJRT82d1aRoQ1atc2r2lUa7
 Qox7AdOjRRmASwOi5p3BeAj/HdUF4txkMyUY1A8LX8RrMIXYEoT1JyoZwKN6YqUVY39c
 9zG6LqjmmDiAeYA3mh+mqSnCtYKVT6OWzk0068+6ZM3+5zjiFrG9yh1mMXr8T3Sg2s5D
 eXBA==
X-Gm-Message-State: ACrzQf39Y7O//hv4YrZtA5hd/8KdU2YNlp540TVq1c1SGfsSWZH2Hpq7
 rJSQH77x5X3P/pyxC/ohGeAi6zi23ji/2dJEOhRN7qK6r8+Mp73l7phQG0rGPbDPX6Vr6v68chM
 bG8Qd2d4q0SJ42cxINKrUNOuBncXmCjyLPFYfUEAtZ+EDPhW+MRXXmvzbZg==
X-Received: by 2002:a9d:7d04:0:b0:655:ad62:6dbe with SMTP id
 v4-20020a9d7d04000000b00655ad626dbemr3124979otn.201.1663906823529; 
 Thu, 22 Sep 2022 21:20:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4sPLwXUi8ibB7BZqlkpwkitSjs4HLpoSlg485F4FQ5/fubdhcQ+EnMMPtKZctGyxWmESRtFxJlI8lt9D3B+kI=
X-Received: by 2002:a9d:7d04:0:b0:655:ad62:6dbe with SMTP id
 v4-20020a9d7d04000000b00655ad626dbemr3124973otn.201.1663906823313; Thu, 22
 Sep 2022 21:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220922024305.1718-1-jasowang@redhat.com>
 <20220922024305.1718-3-jasowang@redhat.com>
 <DM8PR12MB54005C65A85B32063A5E17A8AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB54005C65A85B32063A5E17A8AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 23 Sep 2022 12:20:12 +0800
Message-ID: <CACGkMEvRL3iN8iAP_1dZXLfOhRKv4573DYK6=C9gwME-85=03Q@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
To: Eli Cohen <elic@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "lulu@redhat.com" <lulu@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "gdawar@xilinx.com" <gdawar@xilinx.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 "wuzongyong@linux.alibaba.com" <wuzongyong@linux.alibaba.com>,
 "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>
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

On Thu, Sep 22, 2022 at 1:14 PM Eli Cohen <elic@nvidia.com> wrote:
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Thursday, 22 September 2022 5:43
> > To: mst@redhat.com; jasowang@redhat.com
> > Cc: Eli Cohen <elic@nvidia.com>; si-wei.liu@oracle.com; Parav Pandit
> > <parav@nvidia.com>; wuzongyong@linux.alibaba.com;
> > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > eperezma@redhat.com; lingshan.zhu@intel.com; gdawar@xilinx.com;
> > lulu@redhat.com; xieyongji@bytedance.com
> > Subject: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
> >
> > This patch implements features provisioning for vdpa_sim_net.
> >
> > 1) validating the provisioned features to be a subset of the parent
> >    features.
> > 2) clearing the features that is not wanted by the userspace
> >
> > For example:
> >
> > # vdpa mgmtdev show
> > vdpasim_net:
> >   supported_classes net
> >   max_supported_vqs 3
> >   dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT
> > VERSION_1 ACCESS_PLATFORM
> >
> > 1) provision vDPA device with all features that are supported by the
> >    net simulator
> >
> > # vdpa dev add name dev1 mgmtdev vdpasim_net
> > # vdpa dev config show
> > dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> >   negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR VERSION_1
> > ACCESS_PLATFORM
> >
> > 2) provision vDPA device with a subset of the features
> >
> > # vdpa dev add name dev1 mgmtdev vdpasim_net device_features
> > 0x300020000
>
> How about "features_mask" instead of "device_features"? Could avoid confusion.

It's device_feautres not a mask (the kernel code is probably confusing
per Michael's comment), so I tend to tweak the kernel code and keep
the name.

Thanks

>
> > # vdpa dev config show
> > dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> >   negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
> >
> > Reviewed-by: Eli Cohen <elic@nvidia.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > index 886449e88502..a9ba02be378b 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > @@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct
> > vdpa_mgmt_dev *mdev, const char *name,
> >       dev_attr.work_fn = vdpasim_net_work;
> >       dev_attr.buffer_size = PAGE_SIZE;
> >
> > +     if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> > +             if (config->device_features &
> > +                 ~dev_attr.supported_features)
> > +                     return -EINVAL;
> > +             dev_attr.supported_features &=
> > +                      config->device_features;
> > +     }
> > +
> >       simdev = vdpasim_create(&dev_attr);
> >       if (IS_ERR(simdev))
> >               return PTR_ERR(simdev);
> > @@ -294,7 +302,8 @@ static struct vdpa_mgmt_dev mgmt_dev = {
> >       .id_table = id_table,
> >       .ops = &vdpasim_net_mgmtdev_ops,
> >       .config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
> > -                          1 << VDPA_ATTR_DEV_NET_CFG_MTU),
> > +                          1 << VDPA_ATTR_DEV_NET_CFG_MTU |
> > +                          1 << VDPA_ATTR_DEV_FEATURES),
> >       .max_supported_vqs = VDPASIM_NET_VQ_NUM,
> >       .supported_features = VDPASIM_NET_FEATURES,
> >  };
> > --
> > 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
