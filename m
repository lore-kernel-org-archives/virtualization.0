Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1046C54EE9
	for <virtualization@archiver.kernel.org>; Tue, 27 Sep 2022 04:07:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5098F405D4;
	Tue, 27 Sep 2022 04:07:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5098F405D4
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cr0xaJXL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id okFgJZy2jE9m; Tue, 27 Sep 2022 04:07:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6F5BE40112;
	Tue, 27 Sep 2022 04:07:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6F5BE40112
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46CA6C0033;
	Tue, 27 Sep 2022 04:07:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6ABAAC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:07:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EBFCB60F89
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:07:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EBFCB60F89
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cr0xaJXL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CVUsAw9xeK6k
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:07:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8F90F60F84
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8F90F60F84
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664251640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qcLBCLM+PH8ycKWx1k07/7s89oEdWy95TuEbp0KpqhA=;
 b=Cr0xaJXL1TY1i+8Df/Db+VqwwLNW6aKMZXt0Vagh7DcQB44B43BwhVqAPtrRYU8GsWI56X
 pG1wJr4JgUjzOShR9xkhABKsdQIaxDR068NGAz5NTvNwUkzrfEpcoqLFPp+aXFh4aLejFx
 yLmFdBEzXk8IcERZ+r3MdhjAHgZTt/U=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-557-x8Eoqpb8Moqetf9X9RmYaQ-1; Tue, 27 Sep 2022 00:07:18 -0400
X-MC-Unique: x8Eoqpb8Moqetf9X9RmYaQ-1
Received: by mail-oi1-f198.google.com with SMTP id
 f16-20020a05680814d000b003506268b99fso2786706oiw.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 21:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date;
 bh=qcLBCLM+PH8ycKWx1k07/7s89oEdWy95TuEbp0KpqhA=;
 b=K0pLTE3DjUbvtuI2pPOIdHJxrpfx4aRX13q3VyOqvGCabcb8+TJrOtW+5/amO1LTsh
 W1vZxZOLsb4D9UADgpYMrIR3rrnzSXNwKwaOsiZG8bebbt6u1waBwphlE8fZ6gmAVdVU
 IR5OnVzQDZjO0YSza4PLijin48OyjIRYXwGHSw2oyoIlWYtGdZFlvTKUmbzi5rYJvC61
 9zRGBq//RkwVO6WZHkkfaGZBaAqdmzv/dA+aMR4pIiRwga8sYhKg7fErxHwTppDiaH59
 /pmkP0L3UO2Q+Ryraf3pemoVcRdU2/qxfGio/+im2tIkKGCmIi0gFC/l7AkGhFhXHkm7
 W9dw==
X-Gm-Message-State: ACrzQf12JdPfUd71Ujo5SRwkRSp2ibXRo08ADfYrOUG2T1tOvMft7Stz
 TsBQGlvdbiMyCf9PTbctKgDm8jgtm1cvQrbTbTCFpx0Thp/TE3JuzbRiQ6JfARuaxh5TusMCOu0
 DyHurlBDcnMtwJ0Id4dvvtUAUkG0X2k8jfz5cmUKMJvCIBLzBLs2UvMBA5A==
X-Received: by 2002:a05:6808:1304:b0:350:649b:f8a1 with SMTP id
 y4-20020a056808130400b00350649bf8a1mr895312oiv.280.1664251637625; 
 Mon, 26 Sep 2022 21:07:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4QxXyHj924wjaBEB7J29sMV1LhennrHiDY3BAsK2SHC05C6DnICL3Vj/1TwCJGn69NBgD2UzusGqwUyLj6jxw=
X-Received: by 2002:a05:6808:1304:b0:350:649b:f8a1 with SMTP id
 y4-20020a056808130400b00350649bf8a1mr895301oiv.280.1664251637343; Mon, 26 Sep
 2022 21:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220922024305.1718-1-jasowang@redhat.com>
 <20220922024305.1718-3-jasowang@redhat.com>
 <a1e98754-114e-b401-e927-5f2b71c3c641@oracle.com>
 <CACGkMEu9JfBDP4VkK76jdAnH225yUfTF+xMnqmy7_yDW3P0rKA@mail.gmail.com>
 <afe960d3-730a-b52c-e084-40bf080b27fa@oracle.com>
 <CACGkMEsWPbTs+D4PBHQL2hUOtGWj_6zo-669cUhYK5zK039QCQ@mail.gmail.com>
In-Reply-To: <CACGkMEsWPbTs+D4PBHQL2hUOtGWj_6zo-669cUhYK5zK039QCQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Sep 2022 12:07:06 +0800
Message-ID: <CACGkMEuQHV-pECAPy3EozDE20Gdeh6QjaBvu6u0djeL3PZT2NA@mail.gmail.com>
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

On Tue, Sep 27, 2022 at 11:59 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Tue, Sep 27, 2022 at 9:02 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
> >
> >
> >
> > On 9/26/2022 12:11 AM, Jason Wang wrote:
> >
> > On Sat, Sep 24, 2022 at 4:01 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
> >
> >
> > On 9/21/2022 7:43 PM, Jason Wang wrote:
> >
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
> >
> > Sighs, not to blame any one and it's perhaps too late, but this
> > "dev_features" attr in "mgmtdev show" command output should have been
> > called "supported_features" in the first place.
> >
> > Not sure I get this, but I guess this is the negotiated features actually.
> >
> > Actually no, that is why I said the name is a bit confusing and "supported_features" might sound better.
>
> You're right, it's an mgmtdev show actually.
>
> >This attribute in the parent device (mgmtdev) denotes the real device capability for what virtio features can be supported by the parent device. Any unprivileged user can check into this field to know parent device's capability without having to create a child vDPA device at all. The features that child vDPA device may support should be a subset of, or at most up to what the parent device offers. For e.g. the vdpa device dev1 you created below can expose less or equal device_features bit than 0x308820028 (MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM), but shouldn't be no more than what the parent device can actually support.
>
> Yes, I didn't see anything wrong with "dev_features", it aligns to the
> virtio spec which means the features could be used to create a vdpa
> device. But if everyone agree on the renaming, I'm fine.
>
> >
> >
> > I think Ling Shan is working on reporting both negotiated features
> > with the device features.
> >
> > Does it imply this series is connected to another work in parallel? Is it possible to add a reference in the cover letter?
>
> I'm not sure, I remember Ling Shan did some work to not block the
> config show in this commit:
>
> commit a34bed37fc9d3da319bb75dfbf02a7d3e95e12de
> Author: Zhu Lingshan <lingshan.zhu@intel.com>
> Date:   Fri Jul 22 19:53:07 2022 +0800
>
>     vDPA: !FEATURES_OK should not block querying device config space
>
> We need some changes in the vdpa tool to show device_features
> unconditionally in the "dev config show" command.

Ok, Lingshan post an example here:

https://lore.kernel.org/netdev/20220927025035.4972-2-lingshan.zhu@intel.com/T/#u

Thanks

>
> >
> >
> > 1) provision vDPA device with all features that are supported by the
> >     net simulator
> >
> > # vdpa dev add name dev1 mgmtdev vdpasim_net
> > # vdpa dev config show
> > dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> >    negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM
> >
> > Maybe not in this patch, but for completeness for the whole series,
> > could we also add device_features to the output?
> >
> > Lingshan, could you please share your thoughts or patch on this?
> >
> > Noted here the device_features argument specified during vdpa creation is introduced by this series itself, it somehow slightly changed the original semantics of what device_features used to be.
>
> I'm not sure I get this, we don't support device_features in the past
> and it is used to provision device features to the vDPA device which
> seems to be fine.
>
> >
> >
> > When simply look at the "vdpa dev config show" output, I cannot really
> > tell the actual device_features that was used in vdpa creation. For e.g.
> > there is a missing feature ANY_LAYOUT from negotiated_features compared
> > with supported_features in mgmtdev, but the orchestration software
> > couldn't tell if the vdpa device on destination host should be created
> > with or without the ANY_LAYOUT feature.
> >
> > I think VERSION_1 implies ANY_LAYOUT.
> >
> > Right, ANY_LAYOUT is a bad example. A good example might be that, I knew the parent mgmtdev on migration source node supports CTRL_MAC_ADDR, but I don't find it in negotiated_features.
>
> I think we should use the features that we got from "mgmtdev show"
> instead of "negotiated features".
>
> >On the migration destination node, the parent device does support all features as the source offers, including CTRL_MAC_ADDR. What device features you would expect the mgmt software to create destination vdpa device with, if not otherwise requiring mgmt software to remember all the arguments on device creation?
>
> So in this example, we need use "dev_features" so we get exact the
> same features after and operation as either src or dst.
>
> >
> > SOURCE# vdpa mgmtdev show
> > vdpasim_net:
> >    supported_classes net
> >    max_supported_vqs 3
> >    dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
> > SOURCE# vdpa dev config show
> > dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> >    negotiated_features MTU MAC CTRL_VQ VERSION_1 ACCESS_PLATFORM
> >
> > DESTINATION# vdpa mgmtdev show
> > vdpasim_net:
> >    supported_classes net
> >    max_supported_vqs 3
> >    dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
> >
> >  But it should be sufficient to
> > use features_src & feature_dst in this case. Actually, it should work
> > similar as to the cpu flags, the management software should introduce
> > the concept of cluster which means the maximal set of common features
> > is calculated and provisioned during device creation to allow
> > migration among the nodes inside the cluster.
> >
> > Yes, this is one way mgmt software may implement, but I am not sure if it's the only way. For e.g. for cpu flags, mgmt software can infer the guest cpus features in use from all qemu command line arguments and host cpu features/capability, which doesn't need to remember creation arguments and is easy to recover from failure without having to make the VM config persistent in data store. I thought it would be great if vdpa CLI design could offer the same.
>
> One minor difference is that we have cpu model abstraction, so we can
> have things like:
>
> ./qemu-system-x86_64 -cpu EPYC
>
> Which implies the cpu features/flags where vDPA doesn't have. But
> consider it's just a 64bit (or 128 in the future), it doesn't seems to
> be too complex for the management to know, we probably need to start
> from this and then we can try to introduce some generation/model after
> it is agreed on most of the vendors.
>
> Thanks
>
> >
> > Thanks,
> > -Siwei
> >
> >
> > Thanks
> >
> > Thanks,
> > -Siwei
> >
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
> >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
