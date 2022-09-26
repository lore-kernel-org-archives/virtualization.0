Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46EACC32771
	for <virtualization@archiver.kernel.org>; Mon, 26 Sep 2022 07:11:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A354960EA5;
	Mon, 26 Sep 2022 07:11:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A354960EA5
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tw8j6/eV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mxOkuShsopHV; Mon, 26 Sep 2022 07:11:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5F49B60B25;
	Mon, 26 Sep 2022 07:11:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5F49B60B25
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1103FC0033;
	Mon, 26 Sep 2022 07:11:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF429C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 07:11:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 95FAF826B4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 07:11:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 95FAF826B4
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tw8j6/eV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ylTR0DB--6Ov
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 07:11:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8DCC88148A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8DCC88148A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 07:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664176283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rTr3KkpBeIzK/w5kOAdUeb2F4VLX4yhqW2U+MYMdpt4=;
 b=Tw8j6/eV+yXYxswkL161DP0WrB5McIt5dLoFn1hWZGf6ppfUyq5KdPligG2ee1nGYE7ttW
 RC6pjPd9w0Nypo9SFXp3fWbVpNVlE7ceAOsknukrDBKRbwoNtcv3cRd4kkCFF3KQ+2kntM
 dJTds2l+wx0xrFVwtCUKFsgIcJRiu+8=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-595-b8eJquvhOOmeOMuWB_zckA-1; Mon, 26 Sep 2022 03:11:22 -0400
X-MC-Unique: b8eJquvhOOmeOMuWB_zckA-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-1277a4087f0so1988634fac.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 00:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=rTr3KkpBeIzK/w5kOAdUeb2F4VLX4yhqW2U+MYMdpt4=;
 b=5h2QgX9T4kv+2zN3Z5OuZYVRRJUhd3QjTBgW9QukRpMS2/PTF4N5Gd5us53M/lQ0b+
 /lxZtsZjK5oMAPKuIwrvusIKl+Hd0Ad+NcnY1ergP7jVxdVUkvO8TsnpXW9AipZ8dluO
 3DnEjT9hg9dV1BTiCOcbqPwXuRtfIpc24g3UjTKWfDBnluz/vpB87SPqw4xsETWmauY8
 lhQPzeePLIS3fUc/e20SGNVc456jci/f+FQiwixHhyj6aNhUmvYsxO5hEHuWGRgSF+eR
 NJ3Yi5DuwnFPBi1RPLX5txnYXpjkHE4FW4NJ/mOm/dwP/y1+/k7UUtRZ7oXiRGnspi4r
 4B/g==
X-Gm-Message-State: ACrzQf1xsSm6mX14O9kVpVxTTmyt7fnG+tmkp+8c5MtCwmYk6YcwXkZf
 xHnn58QlKCPhM0Y2ytdDQPtMyIuB+IvvFmyIU0/zQsjNGBqirOEtdoogqxvs6/MdQrHNyPWUR1E
 u5tr2gVFAAhx/yjdDDR/XP05VlTxZSx5VtIDReEvo3nDgznHTp+4WjTyqFQ==
X-Received: by 2002:a05:6870:73cd:b0:12a:dff3:790a with SMTP id
 a13-20020a05687073cd00b0012adff3790amr17513967oan.35.1664176281416; 
 Mon, 26 Sep 2022 00:11:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5cXS0akHljLMtgLGlvMqCBnKBPggdqK08akVV2C/fGuT5nl8vPIE4yZfA7Palpv36i9OMpJwxmvYF2lGND4EU=
X-Received: by 2002:a05:6870:73cd:b0:12a:dff3:790a with SMTP id
 a13-20020a05687073cd00b0012adff3790amr17513957oan.35.1664176281200; Mon, 26
 Sep 2022 00:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220922024305.1718-1-jasowang@redhat.com>
 <20220922024305.1718-3-jasowang@redhat.com>
 <a1e98754-114e-b401-e927-5f2b71c3c641@oracle.com>
In-Reply-To: <a1e98754-114e-b401-e927-5f2b71c3c641@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Sep 2022 15:11:10 +0800
Message-ID: <CACGkMEu9JfBDP4VkK76jdAnH225yUfTF+xMnqmy7_yDW3P0rKA@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Cindy Lu <lulu@redhat.com>, mst <mst@redhat.com>,
 Yongji Xie <xieyongji@bytedance.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Gautam Dawar <gdawar@xilinx.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Wu Zongyong <wuzongyong@linux.alibaba.com>,
 Eli Cohen <elic@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>
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

On Sat, Sep 24, 2022 at 4:01 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
>
>
> On 9/21/2022 7:43 PM, Jason Wang wrote:
> > This patch implements features provisioning for vdpa_sim_net.
> >
> > 1) validating the provisioned features to be a subset of the parent
> >     features.
> > 2) clearing the features that is not wanted by the userspace
> >
> > For example:
> >
> > # vdpa mgmtdev show
> > vdpasim_net:
> >    supported_classes net
> >    max_supported_vqs 3
> >    dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
> Sighs, not to blame any one and it's perhaps too late, but this
> "dev_features" attr in "mgmtdev show" command output should have been
> called "supported_features" in the first place.

Not sure I get this, but I guess this is the negotiated features actually.

I think Ling Shan is working on reporting both negotiated features
with the device features.

>
> >
> > 1) provision vDPA device with all features that are supported by the
> >     net simulator
> >
> > # vdpa dev add name dev1 mgmtdev vdpasim_net
> > # vdpa dev config show
> > dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> >    negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM
> Maybe not in this patch, but for completeness for the whole series,
> could we also add device_features to the output?

Lingshan, could you please share your thoughts or patch on this?

>
> When simply look at the "vdpa dev config show" output, I cannot really
> tell the actual device_features that was used in vdpa creation. For e.g.
> there is a missing feature ANY_LAYOUT from negotiated_features compared
> with supported_features in mgmtdev, but the orchestration software
> couldn't tell if the vdpa device on destination host should be created
> with or without the ANY_LAYOUT feature.

I think VERSION_1 implies ANY_LAYOUT. But it should be sufficient to
use features_src & feature_dst in this case. Actually, it should work
similar as to the cpu flags, the management software should introduce
the concept of cluster which means the maximal set of common features
is calculated and provisioned during device creation to allow
migration among the nodes inside the cluster.

Thanks

>
> Thanks,
> -Siwei
>
>
> >
> > 2) provision vDPA device with a subset of the features
> >
> > # vdpa dev add name dev1 mgmtdev vdpasim_net device_features 0x300020000
> > # vdpa dev config show
> > dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> >    negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
> >
> > Reviewed-by: Eli Cohen <elic@nvidia.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >   drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++-
> >   1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > index 886449e88502..a9ba02be378b 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > @@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
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
> >   };
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
