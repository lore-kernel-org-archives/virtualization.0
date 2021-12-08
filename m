Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B09C433EF
	for <virtualization@archiver.kernel.org>; Wed,  8 Dec 2021 06:29:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9F97640002;
	Wed,  8 Dec 2021 06:29:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mbmnytUk794Q; Wed,  8 Dec 2021 06:29:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E441E400B9;
	Wed,  8 Dec 2021 06:29:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE966C001E;
	Wed,  8 Dec 2021 06:29:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F659C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 06:29:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 19723400B9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 06:29:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BUvP-CYEyatf
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 06:29:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C89C840002
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 06:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638944976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J4iVUv2eTosWO8gDMypPZhpUPZDwc/PETxwmcbkHizM=;
 b=H/yhcWZqJn7PxTy8HaKxpeLONaFkcMFPt4gNXTIfTRYotIlnRBZlsuzI64znCXztUbo8qa
 cTYF3ZRMNfPCiTDDapiht6QtL5FKfcX16LL3TgZWKmdNnmRaYklZbFJ6S77boyQrbetyih
 wLXS84OI41eqIzgaVNpzocwbfeq7LWY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-7HRF-P3bOr6H4LDSMf4cpg-1; Wed, 08 Dec 2021 01:29:32 -0500
X-MC-Unique: 7HRF-P3bOr6H4LDSMf4cpg-1
Received: by mail-lj1-f197.google.com with SMTP id
 p21-20020a2e9ad5000000b00219ee503efeso415794ljj.14
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Dec 2021 22:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J4iVUv2eTosWO8gDMypPZhpUPZDwc/PETxwmcbkHizM=;
 b=g2shAgS76RlTQzDva+BLwf4SDq1YPf0piIDd/mk0+AkUsSsRyYTO0PlFIXxLi2yfri
 0Z9bY56Mp+U7bet8qX5T8Byrw4HgK/hwUCgV6AgSs91yNPEcvaFXpcfC5luG0qGeNzjM
 5Y1HTnR3+7XrKix+vwgE2/949fYr8WGWVOEh16GO7pNa5lhwbsWjdvIeq4Jd9Vcgm/jB
 BoUfWVjkVHLI9nst9Jo/AZeV5+zIqyEpJ6fJ5CEBsQlmr8is7u4rebCDZQNhAVrMs3Ph
 HZtAwQS8sWmhYkSewqtPcVmG3teXxlwLj1XcGzWPVyP3nK9Y0QA0FMzKGtJypnweqL6a
 pgPg==
X-Gm-Message-State: AOAM5313VZaJSEX0zFAAN8CoDOpkPNvFG+NiDKjK+8OtRoGuix5mquWI
 xieZ6+zyAnCIg3o7hAcuLUPkjq2P2I2k1GEkqDRRnszi7vbxl4aD6uioderg7y1OA/Y8v0g7AoM
 ZSIOexBcURcYR6+s9U2qoexbRiM0bxEenlXy8EOwpUEcxASau8mSXrET+OA==
X-Received: by 2002:a2e:2ac1:: with SMTP id
 q184mr47516141ljq.420.1638944970646; 
 Tue, 07 Dec 2021 22:29:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvFQ88wD64KWY1XT+Oj8aZLgB8ScW4WEGaS313ll/Vp9TGCeFs2+YL5/bQ+/Ap8FQwlWEWOgCv8M9fXIf8hAQ=
X-Received: by 2002:a2e:2ac1:: with SMTP id
 q184mr47516115ljq.420.1638944970402; 
 Tue, 07 Dec 2021 22:29:30 -0800 (PST)
MIME-Version: 1.0
References: <20211201195724.17503-1-elic@nvidia.com>
 <20211201195724.17503-6-elic@nvidia.com>
 <CACGkMEsB2x2tX_bPdZRSFMU+pOAB6g3eYNeGerSGasVOu-8wrw@mail.gmail.com>
 <20211207075732.GC15767@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEs0cKfiQjRf=dFcS81shECHDeXb5rzsjJQJu3Dx+H0Ptw@mail.gmail.com>
 <20211208060721.GA59227@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20211208060721.GA59227@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Dec 2021 14:29:19 +0800
Message-ID: <CACGkMEtiXzti2iVfcT91xYEMqfDr1vnwkxB0=GcmbXv67C75KQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] vdpa: Add support for querying control virtqueue index
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

On Wed, Dec 8, 2021 at 2:07 PM Eli Cohen <elic@nvidia.com> wrote:
>
> On Wed, Dec 08, 2021 at 11:25:01AM +0800, Jason Wang wrote:
> > On Tue, Dec 7, 2021 at 3:57 PM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > > On Fri, Dec 03, 2021 at 10:35:30AM +0800, Jason Wang wrote:
> > > > On Thu, Dec 2, 2021 at 3:58 AM Eli Cohen <elic@nvidia.com> wrote:
> > > > >
> > > > > Add netlink attribute and callback function to query the control VQ
> > > > > index of a device.
> > > >
> > > > It's better to explain the motivation of this. Actually we can deduce
> > > > it from the max_virtqueue_paris if I was not wrong.
> > > Right, we can deduce it. But I think, let's let the kernel deduce it.
> > > e.g., we can avoid the new get_ctrl_vq_idx() callback, but still return
> > > the value to userspace with VDPA_ATTR_DEV_CTRL_VQ_IDX.
> > >
> > > > So it means the
> > > > value varies depending on if VIRTIO_NET_F_MQ
> > > I guest you meant VIRTIO_NET_F_CTRL_VQ
> > > > is negotiated which can
> > > > be changed after a query. This may probably confuse the userspace
> > > > sometime.
> > >
> > > No sure I follow you on this. The CVQ index is dictated after the call
> > > to _vdpa_register_device() and cannot change. Whether there is a CVQ or
> > > isn't depends on VIRTIO_NET_F_CTRL_VQ but the index doesn't change.
> >
> > Looks not, according to the spec, consider we have a device with 2
> > queue pairs plus cvq.
> >
> > When MQ is negotiated, cvq index is 4.
> > When MQ is not negotiated, cvq index is 2.
> >
>
> When you say MQ negotiated, do you mean both ways or just offered by the
> upstream driver?

I meant MQ feature is enabled from the driver and accepted by the device.

>
> I think I saw different behavior and I am going to check again.
>
> BTW, could you send reference to where the specs refers to the index of
> the control virtqueue?

You may refer spec chapter 5.1.2:
https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-csprd01.html#x1-1960002

Thanks

>
> > Thanks
> >
> > >
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > ---
> > > > >  drivers/vdpa/vdpa.c       | 18 ++++++++++++++++++
> > > > >  include/linux/vdpa.h      |  1 +
> > > > >  include/uapi/linux/vdpa.h |  1 +
> > > > >  3 files changed, 20 insertions(+)
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > > > index f06f949d5fa1..ca3ab0f46188 100644
> > > > > --- a/drivers/vdpa/vdpa.c
> > > > > +++ b/drivers/vdpa/vdpa.c
> > > > > @@ -712,6 +712,20 @@ static int vdpa_nl_cmd_dev_get_dumpit(struct sk_buff *msg, struct netlink_callba
> > > > >         return msg->len;
> > > > >  }
> > > > >
> > > > > +static int vdpa_dev_net_ctrl_vq_fill(struct vdpa_device *vdev,
> > > > > +                                    struct sk_buff *msg, u64 features)
> > > > > +{
> > > > > +       u16 val_u16 = 0;
> > > > > +
> > > > > +       if (features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ) &&
> > > > > +           vdev->config->get_ctrl_vq_idx) {
> > > > > +               val_u16 = vdev->config->get_ctrl_vq_idx(vdev);
> > > > > +               return nla_put_u16(msg, VDPA_ATTR_DEV_CTRL_VQ_IDX, val_u16);
> > > > > +       }
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > >  static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
> > > > >                                        struct sk_buff *msg, u64 features,
> > > > >                                        const struct virtio_net_config *config)
> > > > > @@ -730,6 +744,7 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
> > > > >         struct virtio_net_config config = {};
> > > > >         u64 features;
> > > > >         u16 val_u16;
> > > > > +       int err;
> > > > >
> > > > >         vdpa_get_config(vdev, 0, &config, sizeof(config));
> > > > >
> > > > > @@ -746,6 +761,9 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
> > > > >                 return -EMSGSIZE;
> > > > >
> > > > >         features = vdev->config->get_features(vdev);
> > > > > +       err = vdpa_dev_net_ctrl_vq_fill(vdev, msg, features);
> > > > > +       if (err)
> > > > > +               return err;
> > > > >
> > > > >         return vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
> > > > >  }
> > > > > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > > > > index 820621c59365..fca9bfeed9ba 100644
> > > > > --- a/include/linux/vdpa.h
> > > > > +++ b/include/linux/vdpa.h
> > > > > @@ -274,6 +274,7 @@ struct vdpa_config_ops {
> > > > >         (*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
> > > > >         /* vq irq is not expected to be changed once DRIVER_OK is set */
> > > > >         int (*get_vq_irq)(struct vdpa_device *vdev, u16 idx);
> > > > > +       u16 (*get_ctrl_vq_idx)(struct vdpa_device *vdev);
> > > > >
> > > > >         /* Device ops */
> > > > >         u32 (*get_vq_align)(struct vdpa_device *vdev);
> > > > > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > > > > index a252f06f9dfd..2e3a7f89f42d 100644
> > > > > --- a/include/uapi/linux/vdpa.h
> > > > > +++ b/include/uapi/linux/vdpa.h
> > > > > @@ -34,6 +34,7 @@ enum vdpa_attr {
> > > > >         VDPA_ATTR_DEV_MAX_VQS,                  /* u32 */
> > > > >         VDPA_ATTR_DEV_MAX_VQ_SIZE,              /* u16 */
> > > > >         VDPA_ATTR_DEV_MIN_VQ_SIZE,              /* u16 */
> > > > > +       VDPA_ATTR_DEV_CTRL_VQ_IDX,              /* u16 */
> > > > >
> > > > >         VDPA_ATTR_DEV_NET_CFG_MACADDR,          /* binary */
> > > > >         VDPA_ATTR_DEV_NET_STATUS,               /* u8 */
> > > > > --
> > > > > 2.33.1
> > > > >
> > > >
> > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
