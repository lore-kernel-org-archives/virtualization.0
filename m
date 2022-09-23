Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE756C6FA8B
	for <virtualization@archiver.kernel.org>; Fri, 23 Sep 2022 04:17:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6119841793;
	Fri, 23 Sep 2022 04:17:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6119841793
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZOW9rdOF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5566v0Hhf6Zk; Fri, 23 Sep 2022 04:17:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 47C5D4177E;
	Fri, 23 Sep 2022 04:17:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 47C5D4177E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21D3AC0033;
	Fri, 23 Sep 2022 04:17:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16A36C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 04:17:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D7A5840546
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 04:17:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D7A5840546
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZOW9rdOF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ogwhZKuSdCof
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 04:17:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CA63440524
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CA63440524
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 04:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663906643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=92zMdR2dAGB3Is6NLBt9+wywGF1FY710JpEgke8Qr/Q=;
 b=ZOW9rdOF4EkwqE/umw0bvhAtpF8fIuh6XpfaYAKY/K5fo8CTlCowHgfFT7t6jqihxQeSAb
 A92VZ/gfIFGo01mvAi3ujjpaJdYn/FhPe8s+/CF+qZeT2mxi1MxgV9Q63TszxTDNLwi0Fw
 IG9zIc+s5aI23O31qQfyUxte4RGy+aw=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-153-CIKwP3DtPXSpWJJYVZHCKw-1; Fri, 23 Sep 2022 00:17:20 -0400
X-MC-Unique: CIKwP3DtPXSpWJJYVZHCKw-1
Received: by mail-ot1-f72.google.com with SMTP id
 36-20020a9d0627000000b0063927bfccb5so5427998otn.18
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 21:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=92zMdR2dAGB3Is6NLBt9+wywGF1FY710JpEgke8Qr/Q=;
 b=5SbfMH1fcYj7//qT8BkCoKsXlcGyqv1m9EN/BJnwmnq/m+IrML+6BtOe7NWmoUsGDY
 gKY6DKQMhY0eq8J8rFhdbqWoPLTlMxSHn6Rpdb7yldD0mN3bqUCXudr0Al8zk9DkKj/Y
 4jv1U2KI0oSFD6lXhksQ5nQrB9GwFVLngvOnNx7E/IKuuVMpk367phVC9OrH1bud7JSL
 JSltE1PFTeOkLrsGm7QFbGt/hUY5pR9cfnrRaILTiRH5XqN0nmGzIx03Ebspj2OCAktH
 dTP/tbMVgLewY1/6sJHjDhWnUZ7MjLsKl/5nrScd9n2qiuWjAEIY5wnyoGSfUuJWwyAG
 gyDw==
X-Gm-Message-State: ACrzQf0qywmVOzVYR90cxOrYhUcA4pgvDkqxUXNTTQRSdoeRwXvVDlGm
 In3kR18hNlKwflIXaNjaztxy1XMvmvXUWay2WrL1maRGZuRSeFYHzqRSUJIVglLSq/6bn+hcLEL
 kActdPDlQcTX4qmaxL+gtxvdYEEmD284WRkJT56t3+eiziOxH4i8o6cSh/w==
X-Received: by 2002:a05:6808:1b22:b0:350:c0f6:70ff with SMTP id
 bx34-20020a0568081b2200b00350c0f670ffmr7847600oib.35.1663906639915; 
 Thu, 22 Sep 2022 21:17:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6XholEdJ/1SqvGLYW89uFGiquRiCe67tSU4smswurScWGy3lq5RTP2Q8QWBr0p8a9Ed18p3x9lLYDzhSSfZHg=
X-Received: by 2002:a05:6808:1b22:b0:350:c0f6:70ff with SMTP id
 bx34-20020a0568081b2200b00350c0f670ffmr7847585oib.35.1663906639727; Thu, 22
 Sep 2022 21:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220922024305.1718-1-jasowang@redhat.com>
 <20220922024305.1718-3-jasowang@redhat.com>
 <DM8PR12MB54005C65A85B32063A5E17A8AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220922032858-mutt-send-email-mst@kernel.org>
 <DM8PR12MB5400D6550D2253E9964260F8AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220922035028-mutt-send-email-mst@kernel.org>
 <DM8PR12MB5400EC129B7A2B0D86EE72F2AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220922050639-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220922050639-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 23 Sep 2022 12:17:08 +0800
Message-ID: <CACGkMEvaP+Mev8rZbv9b_DR_brqFupBR85kPuvd2Y8k==srL0A@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "lulu@redhat.com" <lulu@redhat.com>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "gdawar@xilinx.com" <gdawar@xilinx.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 "wuzongyong@linux.alibaba.com" <wuzongyong@linux.alibaba.com>,
 Eli Cohen <elic@nvidia.com>, "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>
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

On Thu, Sep 22, 2022 at 5:12 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Sep 22, 2022 at 08:01:23AM +0000, Eli Cohen wrote:
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Thursday, 22 September 2022 10:53
> > > To: Eli Cohen <elic@nvidia.com>
> > > Cc: Jason Wang <jasowang@redhat.com>; si-wei.liu@oracle.com; Parav
> > > Pandit <parav@nvidia.com>; wuzongyong@linux.alibaba.com;
> > > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > > eperezma@redhat.com; lingshan.zhu@intel.com; gdawar@xilinx.com;
> > > lulu@redhat.com; xieyongji@bytedance.com
> > > Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
> > >
> > > On Thu, Sep 22, 2022 at 07:47:40AM +0000, Eli Cohen wrote:
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: Thursday, 22 September 2022 10:30
> > > > > To: Eli Cohen <elic@nvidia.com>
> > > > > Cc: Jason Wang <jasowang@redhat.com>; si-wei.liu@oracle.com; Parav
> > > > > Pandit <parav@nvidia.com>; wuzongyong@linux.alibaba.com;
> > > > > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > > > > eperezma@redhat.com; lingshan.zhu@intel.com; gdawar@xilinx.com;
> > > > > lulu@redhat.com; xieyongji@bytedance.com
> > > > > Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
> > > > >
> > > > > On Thu, Sep 22, 2022 at 05:13:59AM +0000, Eli Cohen wrote:
> > > > > > > From: Jason Wang <jasowang@redhat.com>
> > > > > > > Sent: Thursday, 22 September 2022 5:43
> > > > > > > To: mst@redhat.com; jasowang@redhat.com
> > > > > > > Cc: Eli Cohen <elic@nvidia.com>; si-wei.liu@oracle.com; Parav Pandit
> > > > > > > <parav@nvidia.com>; wuzongyong@linux.alibaba.com;
> > > > > > > virtualization@lists.linux-foundation.org; linux-
> > > kernel@vger.kernel.org;
> > > > > > > eperezma@redhat.com; lingshan.zhu@intel.com;
> > > gdawar@xilinx.com;
> > > > > > > lulu@redhat.com; xieyongji@bytedance.com
> > > > > > > Subject: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
> > > > > > >
> > > > > > > This patch implements features provisioning for vdpa_sim_net.
> > > > > > >
> > > > > > > 1) validating the provisioned features to be a subset of the parent
> > > > > > >    features.
> > > > > > > 2) clearing the features that is not wanted by the userspace
> > > > > > >
> > > > > > > For example:
> > > > > > >
> > > > > > > # vdpa mgmtdev show
> > > > > > > vdpasim_net:
> > > > > > >   supported_classes net
> > > > > > >   max_supported_vqs 3
> > > > > > >   dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT
> > > > > > > VERSION_1 ACCESS_PLATFORM
> > > > > > >
> > > > > > > 1) provision vDPA device with all features that are supported by the
> > > > > > >    net simulator
> > > > > > >
> > > > > > > # vdpa dev add name dev1 mgmtdev vdpasim_net
> > > > > > > # vdpa dev config show
> > > > > > > dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> > > > > > >   negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR
> > > VERSION_1
> > > > > > > ACCESS_PLATFORM
> > > > > > >
> > > > > > > 2) provision vDPA device with a subset of the features
> > > > > > >
> > > > > > > # vdpa dev add name dev1 mgmtdev vdpasim_net device_features
> > > > > > > 0x300020000
> > > > > >
> > > > > > How about "features_mask" instead of "device_features"? Could avoid
> > > > > confusion.
> > > > >
> > > > > Not sure I agree.
> > > > > features_mask to me would mean it is & with features. Not the case here.
> > > > >
> > > >
> > > >
> > > > See the code below
> > > >
> > > > @@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct
> > > vdpa_mgmt_dev *mdev, const char *name,
> > > >   dev_attr.work_fn = vdpasim_net_work;
> > > >   dev_attr.buffer_size = PAGE_SIZE;
> > > >
> > > > + if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> > > > +         if (config->device_features &
> > > > +             ~dev_attr.supported_features)
> > > > +                 return -EINVAL;
> > > > +         dev_attr.supported_features &=
> > > > +                  config->device_features;
> > > > + }
> > > > +
> > >
> > > Oh I didn't notice. It's unnecessary, isn't it?
> > > Can just equivalently be
> > >
> > >     dev_attr.supported_features = config->device_features;
> > >
> > > right?
> > >
> >
> > I don't think so. You want to mask the set of features that the device will offer but you cannot dictate it.
>
> Sure, but it's already a given because device_features is a subset of
> supported_features. Observe:
>
> After this line:
>
>          if (config->device_features &
>             ~dev_attr.supported_features)
>                 return -EINVAL;
>
> we know that config->device_features & ~dev_attr.supported_features
> is 0.
>
> Therefore logically
>
> config->device_features  ==
>     (config->device_features & ~dev_attr.supported_features) |
>     (config->device_features & dev_attr.supported_features);
>
> it follows that
>
> config->device_features  ==
>     0 |
>     (config->device_features & dev_attr.supported_features);
>
> and finally
>
> config->device_features  ==
>     (config->device_features & dev_attr.supported_features);
>
>
> now
>
>                 dev_attr.supported_features &=
>                          config->device_features;
>
> is equivalent to
>
>                 dev_attr.supported_features =
>     (config->device_features & dev_attr.supported_features);
>
> and therefore to
>
>                 dev_attr.supported_features = config->device_features;

Yes, let me do that in the next version.

Thanks

>
>
>
> > >
> > > > > > > # vdpa dev config show
> > > > > > > dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> > > > > > >   negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
> > > > > > >
> > > > > > > Reviewed-by: Eli Cohen <elic@nvidia.com>
> > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > ---
> > > > > > >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++-
> > > > > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > > > > > b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > > > > > index 886449e88502..a9ba02be378b 100644
> > > > > > > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > > > > > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > > > > > @@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct
> > > > > > > vdpa_mgmt_dev *mdev, const char *name,
> > > > > > >     dev_attr.work_fn = vdpasim_net_work;
> > > > > > >     dev_attr.buffer_size = PAGE_SIZE;
> > > > > > >
> > > > > > > +   if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> > > > > > > +           if (config->device_features &
> > > > > > > +               ~dev_attr.supported_features)
> > > > > > > +                   return -EINVAL;
> > > > > > > +           dev_attr.supported_features &=
> > > > > > > +                    config->device_features;
> > > > > > > +   }
> > > > > > > +
> > > > > > >     simdev = vdpasim_create(&dev_attr);
> > > > > > >     if (IS_ERR(simdev))
> > > > > > >             return PTR_ERR(simdev);
> > > > > > > @@ -294,7 +302,8 @@ static struct vdpa_mgmt_dev mgmt_dev = {
> > > > > > >     .id_table = id_table,
> > > > > > >     .ops = &vdpasim_net_mgmtdev_ops,
> > > > > > >     .config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
> > > > > > > -                        1 << VDPA_ATTR_DEV_NET_CFG_MTU),
> > > > > > > +                        1 << VDPA_ATTR_DEV_NET_CFG_MTU |
> > > > > > > +                        1 << VDPA_ATTR_DEV_FEATURES),
> > > > > > >     .max_supported_vqs = VDPASIM_NET_VQ_NUM,
> > > > > > >     .supported_features = VDPASIM_NET_FEATURES,
> > > > > > >  };
> > > > > > > --
> > > > > > > 2.25.1
> > > > > >
> > > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
