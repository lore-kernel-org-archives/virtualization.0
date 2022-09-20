Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296FCC6FA8B
	for <virtualization@archiver.kernel.org>; Tue, 20 Sep 2022 01:46:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 90D1940445;
	Tue, 20 Sep 2022 01:46:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 90D1940445
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RveDw4PI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Phnh1YpJM4Ih; Tue, 20 Sep 2022 01:46:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E2CC44041C;
	Tue, 20 Sep 2022 01:46:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E2CC44041C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEB6DC0033;
	Tue, 20 Sep 2022 01:46:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C36EC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 01:46:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1E9EF60B5A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 01:46:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1E9EF60B5A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RveDw4PI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZYvcWKwBRgJ3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 01:46:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F934606FF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2F934606FF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 01:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663638387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dNim4t6D3u1EwkeGcilMNCdWN9K4ooOqRZJUBMK5sfw=;
 b=RveDw4PIRhnva9D8LikD5aF6F14+U9KzYZGxgxTjzLbmPBxCLD+on+y8A6l4Lxz2VAJ52m
 c2dRsUcgQtlp7qfQepkjoKhq7EiM3D2RnyorvseHhDcpj0RdMHoCPRC4RGhlZ1u3bmNMkg
 dZx7bQi6f0TzhbhukX91DR29B1TfPYI=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-519-RLV_L3AINDC2fgVZln2Xig-1; Mon, 19 Sep 2022 21:46:21 -0400
X-MC-Unique: RLV_L3AINDC2fgVZln2Xig-1
Received: by mail-vk1-f200.google.com with SMTP id
 e17-20020a056122023100b003a1e6de5bf9so310583vko.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Sep 2022 18:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=dNim4t6D3u1EwkeGcilMNCdWN9K4ooOqRZJUBMK5sfw=;
 b=665RUewjcNEP5pC4XITJJT2lnhx/900OQxSbzE9+sr0ctbOBut7fry8R7aLKfk8IyH
 5OcMaDcsbBhHcXau3gkDeWbHKCFLp5lORbA+umPe2WziYRBIPQeEGuv3bzZCZIZc7WdL
 fpcsYjKMs8j1FjdumAsAxKJCwbh0NGHuauMEXz9AB9V1UeXU3bD4cpl8GTwla1oYl5c/
 TyMLwEEffxPGSMxTqWPxAUXWCNZA1XFU/wnWJw1f784QoaexoL+ShJUBmg1DP/Zk1xem
 XfCvieq83KlzgffzhdB4EsTHePy1gJvBTRgrwHgcLEyenIIk2Yxsg38LASTKtlrMacyU
 pnEw==
X-Gm-Message-State: ACrzQf2qSBbgIHjgkzEbwFRJL1Qa5VfEuDs81Ug/IxZE93EnO/dWIoM2
 FhoSq3UM2rG9L5n+esdUAua9NubOHrb2DpXtkoDVZtzSZzdFaW35VmSN3srxbT2Etrrsxoq3nE/
 QpFH4HkWkrxw8yQULcY2SoSBKJtMmiGfisJNkVIaIYPczCIcUh9D97UeIhw==
X-Received: by 2002:a05:6102:1341:b0:398:889e:7f28 with SMTP id
 j1-20020a056102134100b00398889e7f28mr7895725vsl.21.1663638378562; 
 Mon, 19 Sep 2022 18:46:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7JBb7Mo2xytvr3fAEMap8eoE5rMUKQpFtpDBJku09gWoXRFMGIOXN7RsLeq1N74DEtjIIGtJP0zYUmbEs6kzI=
X-Received: by 2002:a05:6102:1341:b0:398:889e:7f28 with SMTP id
 j1-20020a056102134100b00398889e7f28mr7895714vsl.21.1663638378361; Mon, 19 Sep
 2022 18:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220915085048.12840-1-jasowang@redhat.com>
 <20220915085048.12840-4-jasowang@redhat.com>
 <DM8PR12MB54006A97A99515542260B5D6AB4D9@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB54006A97A99515542260B5D6AB4D9@DM8PR12MB5400.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 20 Sep 2022 09:46:07 +0800
Message-ID: <CACGkMEtfLGjHgFV7bgWrjWoFZyiTQMf9oDBGi5L=diQ5mtNRnA@mail.gmail.com>
Subject: Re: [PATCH 3/3] vp_vdpa: support feature provisioning
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

On Mon, Sep 19, 2022 at 3:05 PM Eli Cohen <elic@nvidia.com> wrote:
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Thursday, 15 September 2022 11:51
> > To: mst@redhat.com; jasowang@redhat.com
> > Cc: Eli Cohen <elic@nvidia.com>; si-wei.liu@oracle.com; Parav Pandit
> > <parav@nvidia.com>; wuzongyong@linux.alibaba.com;
> > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > eperezma@redhat.com; lingshan.zhu@intel.com; gdawar@xilinx.com;
> > lulu@redhat.com; xieyongji@bytedance.com
> > Subject: [PATCH 3/3] vp_vdpa: support feature provisioning
> >
> > This patch allows the device features to be provisioned via
> > netlink. This is done by:
> >
> > 1) validating the provisioned features to be a subset of the parent
> >    features.
> > 2) clearing the features that is not wanted by the userspace
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/vdpa/virtio_pci/vp_vdpa.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > index 04522077735b..4b28e0c95ba2 100644
> > --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/virtio_ring.h>
> >  #include <linux/virtio_pci.h>
> >  #include <linux/virtio_pci_modern.h>
> > +#include <uapi/linux/vdpa.h>
> >
> >  #define VP_VDPA_QUEUE_MAX 256
> >  #define VP_VDPA_DRIVER_NAME "vp_vdpa"
> > @@ -35,6 +36,7 @@ struct vp_vdpa {
> >       struct virtio_pci_modern_device *mdev;
> >       struct vp_vring *vring;
> >       struct vdpa_callback config_cb;
> > +     u64 device_features;
> >       char msix_name[VP_VDPA_NAME_SIZE];
> >       int config_irq;
> >       int queues;
> > @@ -66,9 +68,9 @@ static struct virtio_pci_modern_device
> > *vp_vdpa_to_mdev(struct vp_vdpa *vp_vdpa)
> >
> >  static u64 vp_vdpa_get_device_features(struct vdpa_device *vdpa)
> >  {
> > -     struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
> > +     struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> >
> > -     return vp_modern_get_features(mdev);
> > +     return vp_vdpa->device_features;
> >  }
>
> Unrelated to this patch. Maybe put in another patch?

Actually not, since we don't want to report the features that are
supported by the device, but the features that are provisioned via
netlink:

> > +     if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> > +             if (add_config->device_features & ~device_features)
> > +                     return -EINVAL;
> > +             device_features &= add_config->device_features;
> > +     }
> > +     vp_vdpa->device_features = device_features;

Thanks

>
> >
> >  static int vp_vdpa_set_driver_features(struct vdpa_device *vdpa, u64
> > features)
> > @@ -475,6 +477,7 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev
> > *v_mdev, const char *name,
> >       struct pci_dev *pdev = mdev->pci_dev;
> >       struct device *dev = &pdev->dev;
> >       struct vp_vdpa *vp_vdpa = NULL;
> > +     u64 device_features;
> >       int ret, i;
> >
> >       vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
> > @@ -491,6 +494,14 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev
> > *v_mdev, const char *name,
> >       vp_vdpa->queues = vp_modern_get_num_queues(mdev);
> >       vp_vdpa->mdev = mdev;
> >
> > +     device_features = vp_modern_get_features(mdev);
> > +     if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> > +             if (add_config->device_features & ~device_features)
> > +                     return -EINVAL;
> > +             device_features &= add_config->device_features;
> > +     }
> > +     vp_vdpa->device_features = device_features;
> > +
> >       ret = devm_add_action_or_reset(dev, vp_vdpa_free_irq_vectors,
> > pdev);
> >       if (ret) {
> >               dev_err(&pdev->dev,
> > @@ -599,6 +610,7 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const
> > struct pci_device_id *id)
> >       mgtdev->id_table = mdev_id;
> >       mgtdev->max_supported_vqs =
> > vp_modern_get_num_queues(mdev);
> >       mgtdev->supported_features = vp_modern_get_features(mdev);
> > +     mgtdev->config_attr_mask = (1 << VDPA_ATTR_DEV_FEATURES);
> >       pci_set_master(pdev);
> >       pci_set_drvdata(pdev, vp_vdpa_mgtdev);
> >
> > --
> > 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
