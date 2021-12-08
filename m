Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56285C433EF
	for <virtualization@archiver.kernel.org>; Wed,  8 Dec 2021 03:25:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE62160F00;
	Wed,  8 Dec 2021 03:25:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4qNulJycZoyU; Wed,  8 Dec 2021 03:25:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6687160EFC;
	Wed,  8 Dec 2021 03:25:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38339C001E;
	Wed,  8 Dec 2021 03:25:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9689FC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 03:25:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 74A9E60EFF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 03:25:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RR5epkzWfBEX
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 03:25:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8161D60EFC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 03:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638933917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FLk/SLZ4XkN/sh6l6jSWQ/ThYUO74xLtMRBcYzQ1oJE=;
 b=Bzz6v/oi6k+KQ87sICs/6JmJqOfkoreAWGoR49f6/PKJxIM3+pEUm8fCBuGPhoncZ9e6+L
 AWY94BW4d+kemAIMFEkIenxsp1lEquizHYEZwd4mNl/d3BdFG7iUTUgd1RjoxKIKve8kma
 i97C//zX5ZVcUoQiPVbuwjrUQDPbJ98=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-bP5UKmtjMrixF5VfACpvdA-1; Tue, 07 Dec 2021 22:25:14 -0500
X-MC-Unique: bP5UKmtjMrixF5VfACpvdA-1
Received: by mail-lf1-f71.google.com with SMTP id
 k32-20020a0565123da000b0041643c6a467so482664lfv.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Dec 2021 19:25:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FLk/SLZ4XkN/sh6l6jSWQ/ThYUO74xLtMRBcYzQ1oJE=;
 b=xjQ8ehgzYwKPo+lbi8Hi1Z8Iwvo2QUH7gi7eWzuyHQZtE0DehMVtpuT1+i1+QRw8de
 SuIW6YLoLCLlD2z8nWUJWnxhqv+I1WcanVmjb1Yoso4tTWhMADVKCPZ8ekFffsapeIyn
 h9h8IKsYWs2Xp3pHmLjCWixoxDqMzb8Szos5xzqXfJwAma4pNVcOSxz8PYkwEOT2j+LL
 HrjJ4ACC/z5haJ6zrTd3s7YTsmzqepIm03ntUGHBt5PWTwQ+pDQ3055C49EV+Fy4OXVd
 NbxRWNrXHHTep1h8YdGW/jHziDAOxnEgH+MTktif1gdZ3HyW2y9/IsEnFpOPgoa+1Pgi
 4xMA==
X-Gm-Message-State: AOAM532+EKu0yxMvtnCV8CvYca4nDcDOC0KuKlqwOOTyf1Tv9+hFYkr1
 XHxW8r0L+4i50+5QhFAjVEm/G6d+3/oSR8NMsvVKM6WnlvnWxSlL/CE/5IeUI5/8nsjd236emxi
 GIMhfVPeoF8YMgCoYSSx39ZQ1mmbuhnkgickep8FJW0w3Qv6A0uXPSpdQaQ==
X-Received: by 2002:ac2:518b:: with SMTP id u11mr44884494lfi.498.1638933912729; 
 Tue, 07 Dec 2021 19:25:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxFHJW6mSapw+xcDg6iZUena//TXTXhrDYHxApXikhfMXjzSzPB5AvrRAGbth/MxGFV82BSl9EZwPt0TX1foH8=
X-Received: by 2002:ac2:518b:: with SMTP id u11mr44884470lfi.498.1638933912501; 
 Tue, 07 Dec 2021 19:25:12 -0800 (PST)
MIME-Version: 1.0
References: <20211201195724.17503-1-elic@nvidia.com>
 <20211201195724.17503-6-elic@nvidia.com>
 <CACGkMEsB2x2tX_bPdZRSFMU+pOAB6g3eYNeGerSGasVOu-8wrw@mail.gmail.com>
 <20211207075732.GC15767@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20211207075732.GC15767@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Dec 2021 11:25:01 +0800
Message-ID: <CACGkMEs0cKfiQjRf=dFcS81shECHDeXb5rzsjJQJu3Dx+H0Ptw@mail.gmail.com>
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

On Tue, Dec 7, 2021 at 3:57 PM Eli Cohen <elic@nvidia.com> wrote:
>
> On Fri, Dec 03, 2021 at 10:35:30AM +0800, Jason Wang wrote:
> > On Thu, Dec 2, 2021 at 3:58 AM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > > Add netlink attribute and callback function to query the control VQ
> > > index of a device.
> >
> > It's better to explain the motivation of this. Actually we can deduce
> > it from the max_virtqueue_paris if I was not wrong.
> Right, we can deduce it. But I think, let's let the kernel deduce it.
> e.g., we can avoid the new get_ctrl_vq_idx() callback, but still return
> the value to userspace with VDPA_ATTR_DEV_CTRL_VQ_IDX.
>
> > So it means the
> > value varies depending on if VIRTIO_NET_F_MQ
> I guest you meant VIRTIO_NET_F_CTRL_VQ
> > is negotiated which can
> > be changed after a query. This may probably confuse the userspace
> > sometime.
>
> No sure I follow you on this. The CVQ index is dictated after the call
> to _vdpa_register_device() and cannot change. Whether there is a CVQ or
> isn't depends on VIRTIO_NET_F_CTRL_VQ but the index doesn't change.

Looks not, according to the spec, consider we have a device with 2
queue pairs plus cvq.

When MQ is negotiated, cvq index is 4.
When MQ is not negotiated, cvq index is 2.

Thanks

>
> >
> > Thanks
> >
> > >
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > ---
> > >  drivers/vdpa/vdpa.c       | 18 ++++++++++++++++++
> > >  include/linux/vdpa.h      |  1 +
> > >  include/uapi/linux/vdpa.h |  1 +
> > >  3 files changed, 20 insertions(+)
> > >
> > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > index f06f949d5fa1..ca3ab0f46188 100644
> > > --- a/drivers/vdpa/vdpa.c
> > > +++ b/drivers/vdpa/vdpa.c
> > > @@ -712,6 +712,20 @@ static int vdpa_nl_cmd_dev_get_dumpit(struct sk_buff *msg, struct netlink_callba
> > >         return msg->len;
> > >  }
> > >
> > > +static int vdpa_dev_net_ctrl_vq_fill(struct vdpa_device *vdev,
> > > +                                    struct sk_buff *msg, u64 features)
> > > +{
> > > +       u16 val_u16 = 0;
> > > +
> > > +       if (features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ) &&
> > > +           vdev->config->get_ctrl_vq_idx) {
> > > +               val_u16 = vdev->config->get_ctrl_vq_idx(vdev);
> > > +               return nla_put_u16(msg, VDPA_ATTR_DEV_CTRL_VQ_IDX, val_u16);
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
> > >                                        struct sk_buff *msg, u64 features,
> > >                                        const struct virtio_net_config *config)
> > > @@ -730,6 +744,7 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
> > >         struct virtio_net_config config = {};
> > >         u64 features;
> > >         u16 val_u16;
> > > +       int err;
> > >
> > >         vdpa_get_config(vdev, 0, &config, sizeof(config));
> > >
> > > @@ -746,6 +761,9 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
> > >                 return -EMSGSIZE;
> > >
> > >         features = vdev->config->get_features(vdev);
> > > +       err = vdpa_dev_net_ctrl_vq_fill(vdev, msg, features);
> > > +       if (err)
> > > +               return err;
> > >
> > >         return vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
> > >  }
> > > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > > index 820621c59365..fca9bfeed9ba 100644
> > > --- a/include/linux/vdpa.h
> > > +++ b/include/linux/vdpa.h
> > > @@ -274,6 +274,7 @@ struct vdpa_config_ops {
> > >         (*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
> > >         /* vq irq is not expected to be changed once DRIVER_OK is set */
> > >         int (*get_vq_irq)(struct vdpa_device *vdev, u16 idx);
> > > +       u16 (*get_ctrl_vq_idx)(struct vdpa_device *vdev);
> > >
> > >         /* Device ops */
> > >         u32 (*get_vq_align)(struct vdpa_device *vdev);
> > > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > > index a252f06f9dfd..2e3a7f89f42d 100644
> > > --- a/include/uapi/linux/vdpa.h
> > > +++ b/include/uapi/linux/vdpa.h
> > > @@ -34,6 +34,7 @@ enum vdpa_attr {
> > >         VDPA_ATTR_DEV_MAX_VQS,                  /* u32 */
> > >         VDPA_ATTR_DEV_MAX_VQ_SIZE,              /* u16 */
> > >         VDPA_ATTR_DEV_MIN_VQ_SIZE,              /* u16 */
> > > +       VDPA_ATTR_DEV_CTRL_VQ_IDX,              /* u16 */
> > >
> > >         VDPA_ATTR_DEV_NET_CFG_MACADDR,          /* binary */
> > >         VDPA_ATTR_DEV_NET_STATUS,               /* u8 */
> > > --
> > > 2.33.1
> > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
