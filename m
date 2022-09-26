Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263CFC07E9D
	for <virtualization@archiver.kernel.org>; Mon, 26 Sep 2022 07:14:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD98681A39;
	Mon, 26 Sep 2022 07:14:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AD98681A39
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LejZambm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wTaN3SIOW1Dd; Mon, 26 Sep 2022 07:14:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 26CFC81947;
	Mon, 26 Sep 2022 07:14:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 26CFC81947
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E968FC0033;
	Mon, 26 Sep 2022 07:14:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53D91C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 07:14:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 260A2410A3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 07:14:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 260A2410A3
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LejZambm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YQfZpLkuYV7U
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 07:14:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D9A2340E46
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D9A2340E46
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 07:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664176459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XXiARgUsG+PUWi1cWxOlhUBb4oeulSL8cu/tM+c0DoA=;
 b=LejZambmcayVEdoNCfTLyJRQ1ucGe4y72w+/iHFBCHybTzUhTNZyF1m4wEpG3ruSrKagSB
 DV2IiLlOHYbFHFJknla7L3Z2gG+IgWCMXGvdrJJkLE/8eKM6vudZF5Iw5dsg4+D0rvZq9I
 GAisbp8qqAaGOGfPbSqwimC13zh+sPU=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-561-5j7AWaK2Mvm_JxmNB007Bw-1; Mon, 26 Sep 2022 03:14:17 -0400
X-MC-Unique: 5j7AWaK2Mvm_JxmNB007Bw-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-11eadf59e50so1986716fac.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 00:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=XXiARgUsG+PUWi1cWxOlhUBb4oeulSL8cu/tM+c0DoA=;
 b=qDK61bpTpkV8C8GEmwAPePMarM24/mcP19F5FezkVaxnPbbu8GFF2QsWE/K7gfWcFu
 e6+q9yFarnpt6XXVYGCL8IOhVM8RCR8B0M+nrGyv1iCSXkddCakxbCSjSI/4tynQhQaD
 t2aKEwfw0bQF5lyYmYA91tjUCvyTLWYW8IJm20UhZecYSiuRj+fYBHfT97iEUaPjBxdV
 xH0ce0LAFJqMncVwBhl+HH5C9NxbtFL5CnwiQVSwavVNNJ4g0XK0gOIWqwRmbABo83kE
 n/38TmYCYEWyZFvJPfeljPCGqPZIWWwkC/Eu4eVQHHybKY1P6wbvQulEqN8YzfGKWwAf
 PD8w==
X-Gm-Message-State: ACrzQf0CoiYL+OgUuzwZEXcKZErU1QIehbh4mtXKvQUHESj+4t82Mkpm
 GQVncRvmDe77kOjtIbkscfhT87N254aBoqx0OZLTsOpttCtsBPZniVkErqKQpqabH39VidX3a9+
 SpYTSHsB4RG3Tjvbt+eA0h1a2OGzQWwruAid09agFdjLS8Rzb0MaCVRQNyw==
X-Received: by 2002:a4a:1101:0:b0:476:7b37:e379 with SMTP id
 1-20020a4a1101000000b004767b37e379mr24031ooc.57.1664176456209; 
 Mon, 26 Sep 2022 00:14:16 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6TUJ30sHwYR/Es/rIpBdbt2i7FD4cKNj6nawhekXj4N+TplLFWJjSMoJbr8rSvo64GUcjqZEfHt/vc3cVbDKo=
X-Received: by 2002:a4a:1101:0:b0:476:7b37:e379 with SMTP id
 1-20020a4a1101000000b004767b37e379mr24011ooc.57.1664176455971; Mon, 26 Sep
 2022 00:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220922024305.1718-1-jasowang@redhat.com>
 <20220922024305.1718-4-jasowang@redhat.com>
 <649cf77d-849b-1ed1-e804-3abab9e339d1@oracle.com>
In-Reply-To: <649cf77d-849b-1ed1-e804-3abab9e339d1@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Sep 2022 15:14:05 +0800
Message-ID: <CACGkMEvHNdp1MCt4VLVGFnC-CEqgpur+uwXiRz1d6ke30L-iJg@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] vp_vdpa: support feature provisioning
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

On Sat, Sep 24, 2022 at 4:11 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
>
>
> On 9/21/2022 7:43 PM, Jason Wang wrote:
> > This patch allows the device features to be provisioned via
> > netlink. This is done by:
> >
> > 1) validating the provisioned features to be a subset of the parent
> >     features.
> > 2) clearing the features that is not wanted by the userspace
> >
> > For example:
> >
> > # vdpa mgmtdev show
> > pci/0000:02:00.0:
> >    supported_classes net
> >    max_supported_vqs 3
> >    dev_features CSUM GUEST_CSUM CTRL_GUEST_OFFLOADS MAC GUEST_TSO4
> >    GUEST_TSO6 GUEST_ECN GUEST_UFO HOST_TSO4 HOST_TSO6 HOST_ECN HOST_UFO
> >    MRG_RXBUF STATUS CTRL_VQ CTRL_RX CTRL_VLAN CTRL_RX_EXTRA
> >    GUEST_ANNOUNCE CTRL_MAC_ADDR RING_INDIRECT_DESC RING_EVENT_IDX
> >    VERSION_1 ACCESS_PLATFORM
> >
> > 1) provision vDPA device with all features that are supported by the virtio-pci
> >
> > # vdpa dev add name dev1 mgmtdev pci/0000:02:00.0
> > # vdpa dev config show
> > dev1: mac 52:54:00:12:34:56 link up link_announce false mtu 65535
> >    negotiated_features CSUM GUEST_CSUM CTRL_GUEST_OFFLOADS MAC
> >    GUEST_TSO4 GUEST_TSO6 GUEST_ECN GUEST_UFO HOST_TSO4 HOST_TSO6
> >    HOST_ECN HOST_UFO MRG_RXBUF STATUS CTRL_VQ CTRL_RX CTRL_VLAN
> >    GUEST_ANNOUNCE CTRL_MAC_ADDR RING_INDIRECT_DESC RING_EVENT_IDX
> >    VERSION_1 ACCESS_PLATFORM
> >
> > 2) provision vDPA device with a subset of the features
> >
> > # vdpa dev add name dev1 mgmtdev pci/0000:02:00.0 device_features 0x300020000
> > # dev1: mac 52:54:00:12:34:56 link up link_announce false mtu 65535
> >    negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
> >
> > Reviewed-by: Eli Cohen <elic@nvidia.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >   drivers/vdpa/virtio_pci/vp_vdpa.c | 16 ++++++++++++++--
> >   1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > index 04522077735b..4b28e0c95ba2 100644
> > --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > @@ -17,6 +17,7 @@
> >   #include <linux/virtio_ring.h>
> >   #include <linux/virtio_pci.h>
> >   #include <linux/virtio_pci_modern.h>
> > +#include <uapi/linux/vdpa.h>
> >
> >   #define VP_VDPA_QUEUE_MAX 256
> >   #define VP_VDPA_DRIVER_NAME "vp_vdpa"
> > @@ -35,6 +36,7 @@ struct vp_vdpa {
> >       struct virtio_pci_modern_device *mdev;
> >       struct vp_vring *vring;
> >       struct vdpa_callback config_cb;
> > +     u64 device_features;
> >       char msix_name[VP_VDPA_NAME_SIZE];
> >       int config_irq;
> >       int queues;
> > @@ -66,9 +68,9 @@ static struct virtio_pci_modern_device *vp_vdpa_to_mdev(struct vp_vdpa *vp_vdpa)
> >
> >   static u64 vp_vdpa_get_device_features(struct vdpa_device *vdpa)
> >   {
> > -     struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
> > +     struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> >
> > -     return vp_modern_get_features(mdev);
> > +     return vp_vdpa->device_features;
> >   }
> >
> >   static int vp_vdpa_set_driver_features(struct vdpa_device *vdpa, u64 features)
> > @@ -475,6 +477,7 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> >       struct pci_dev *pdev = mdev->pci_dev;
> >       struct device *dev = &pdev->dev;
> >       struct vp_vdpa *vp_vdpa = NULL;
> > +     u64 device_features;
> >       int ret, i;
> >
> >       vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
> > @@ -491,6 +494,14 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> >       vp_vdpa->queues = vp_modern_get_num_queues(mdev);
> >       vp_vdpa->mdev = mdev;
> >
> > +     device_features = vp_modern_get_features(mdev);
> > +     if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> > +             if (add_config->device_features & ~device_features)
> > +                     return -EINVAL;
> Should use "goto err" rather than direct return. Also, would be the best
> to tell user the reason why device creation is failing. In the other
> places of the same function, dev_err() or dev_warn() is used.

Right, let me fix this.

Thanks

>
> -Siwei
>
> > +             device_features &= add_config->device_features;
> > +     }
> > +     vp_vdpa->device_features = device_features;
> > +
> >       ret = devm_add_action_or_reset(dev, vp_vdpa_free_irq_vectors, pdev);
> >       if (ret) {
> >               dev_err(&pdev->dev,
> > @@ -599,6 +610,7 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >       mgtdev->id_table = mdev_id;
> >       mgtdev->max_supported_vqs = vp_modern_get_num_queues(mdev);
> >       mgtdev->supported_features = vp_modern_get_features(mdev);
> > +     mgtdev->config_attr_mask = (1 << VDPA_ATTR_DEV_FEATURES);
> >       pci_set_master(pdev);
> >       pci_set_drvdata(pdev, vp_vdpa_mgtdev);
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
