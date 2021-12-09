Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD054C433EF
	for <virtualization@archiver.kernel.org>; Thu,  9 Dec 2021 07:56:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 67A964036B;
	Thu,  9 Dec 2021 07:56:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t_Bhfp1fpjHg; Thu,  9 Dec 2021 07:56:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6C6E14012A;
	Thu,  9 Dec 2021 07:56:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A441C001E;
	Thu,  9 Dec 2021 07:56:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3550CC0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 07:56:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 142BC40903
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 07:56:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LZqGVf4-QSiX
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 07:56:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 331E2404CA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 07:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639036562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/54g+GzP2VGYD0GlXsqVbwCsxpFO9+knwIMXmvhG7Zs=;
 b=ArQnOssESFzJJbxheQByaUZL9lUnx32Y1SQ8krXd9qktiBZ/OW8MavyHqpSaM5KKvR7mhp
 oCeVt/jT0IeCUYFe4hwdeoLCxEauxuG/1LMFmhbN3AAL+D42wBD4UXPeQMrn5Mk9+SSKUS
 tvGD4IYJS6WDdI3w+5nqXPTVbvYUurY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-WRqpBIXLPZ--kr-2OXj9oQ-1; Thu, 09 Dec 2021 02:56:00 -0500
X-MC-Unique: WRqpBIXLPZ--kr-2OXj9oQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 b14-20020a05651c0b0e00b0021a1a39c481so1509686ljr.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Dec 2021 23:56:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/54g+GzP2VGYD0GlXsqVbwCsxpFO9+knwIMXmvhG7Zs=;
 b=2d58K2Q5uu4QJ4yl5WObwk7QgdfPO6EtLi1BoVLnadki63+yAr7ZZ8HmW+FJfpjkmQ
 XR1zRS+aff78iiAEV2YpiXmIrhHR81HDTIFjnFMlkw4RtVcsRhLuRhLvjv+owcl40Ue/
 tcY/J2Ke+LN0j2Kj/zEsvnRYOGoXWIvs2knL+faHO9Q5SJVpkyiiy87jtHPdaCU/SnMB
 OD39rx5noauCLDu7uHxINaqGGSrhZ845WZr11bgXG38wwEhdS9Gcgjqk0vb3OnhMnevV
 40mm+lcgAEdZ/o3aGvWX4o8Xv1dd1yC+nG69OxD23rmYdw5pkUp7ck/NYI5J+pmxiGoW
 kiSg==
X-Gm-Message-State: AOAM53367fk9swhnJTU7r+tgMWbdNPlVTt+pAA4BOzfUsW6E4yL2h1TR
 qD/KvZ0jqOrqQ66PP6ZeNsgHbqLD84xmVQFnctVF8HCNvmMoegWQtWT99yp3QkO+WXAGD552obM
 M4s/swjhOBPnbVT8fZXJgszWDhX1yRnFVBgNckagRjTwIrkx/l9JIoO9CdA==
X-Received: by 2002:a2e:915a:: with SMTP id q26mr4457414ljg.277.1639036559294; 
 Wed, 08 Dec 2021 23:55:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwSstTEZHLvpzIb0/Vt8nQP0a2LofihhbG/1it6rdOtJo/fSLMvgxJChCH1u7EpuAh9qX5EI3QGAzl4XU0JRXM=
X-Received: by 2002:a2e:915a:: with SMTP id q26mr4457395ljg.277.1639036559079; 
 Wed, 08 Dec 2021 23:55:59 -0800 (PST)
MIME-Version: 1.0
References: <20211208201430.73720-1-elic@nvidia.com>
 <20211208201430.73720-7-elic@nvidia.com>
 <CACGkMEvgiT8wCmBdyapdu+G04ceRzpG+witM0MPrVbErFiSLkg@mail.gmail.com>
 <20211209070904.GE108239@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20211209070904.GE108239@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Dec 2021 15:55:48 +0800
Message-ID: <CACGkMEsy=bS8AWtoLhxG3ddA_egC3pde1yMd2m56GY9nqAp5Jw@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] vdpa: Add support for querying control virtqueue
 index
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

On Thu, Dec 9, 2021 at 3:09 PM Eli Cohen <elic@nvidia.com> wrote:
>
> On Thu, Dec 09, 2021 at 01:44:56PM +0800, Jason Wang wrote:
> > On Thu, Dec 9, 2021 at 4:15 AM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > > Add netlink attribute and callback function to query the control VQ
> > > index of a device.
> > >
> > > Example:
> > >
> > > $ vdpa dev config show vdpa-a
> > >   vdpa-a: mac 00:00:00:00:88:88 link up link_announce false max_vq_pairs 5 \
> > >   mtu 9000 ctrl_vq_idx 10
> >
> >
> > I still wonder about the motivation for this.
> To be able to show the stats for CVQ.

Right.

>
> > And as discussed, the
> > ctrl_vq_idx varies depending on whether MQ is negotiated.
>
> I handle this according to the spec and it depends on MQ.

Yes, but there could be a chance that the cvq index changes after the
vdpa dev config show.

Thanks

>
> >
> > Thanks
> >
> > >
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > ---
> > > v0 -> v1:
> > > 1. Use logic defined in the spec to deduce virtqueue index.
> > >
> > >  drivers/vdpa/vdpa.c       | 25 +++++++++++++++++++++++++
> > >  include/uapi/linux/vdpa.h |  1 +
> > >  2 files changed, 26 insertions(+)
> > >
> > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > index 3bf016e03512..b4d4b8a7ca4e 100644
> > > --- a/drivers/vdpa/vdpa.c
> > > +++ b/drivers/vdpa/vdpa.c
> > > @@ -712,6 +712,27 @@ static int vdpa_nl_cmd_dev_get_dumpit(struct sk_buff *msg, struct netlink_callba
> > >         return msg->len;
> > >  }
> > >
> > > +static int vdpa_dev_net_ctrl_vq_fill(struct vdpa_device *vdev,
> > > +                                    struct sk_buff *msg,
> > > +                                    struct virtio_net_config *config,
> > > +                                    u64 features)
> > > +{
> > > +       u16 N;
> > > +
> > > +       /* control VQ index, if available, is deduced according to the logic
> > > +        * described in the virtio spec in section 5.1.2
> > > +        */
> > > +       if (!(features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> > > +               return 0;
> > > +
> > > +       if (features & BIT_ULL(VIRTIO_NET_F_MQ))
> > > +               N = le16_to_cpu(config->max_virtqueue_pairs);
> > > +       else
> > > +               N = 1;
> > > +
> > > +       return nla_put_u16(msg, VDPA_ATTR_DEV_CTRL_VQ_IDX, 2 * N);
> > > +}
> > > +
> > >  static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
> > >                                        struct sk_buff *msg, u64 features,
> > >                                        const struct virtio_net_config *config)
> > > @@ -730,6 +751,7 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
> > >         struct virtio_net_config config = {};
> > >         u64 features;
> > >         u16 val_u16;
> > > +       int err;
> > >
> > >         vdpa_get_config(vdev, 0, &config, sizeof(config));
> > >
> > > @@ -746,6 +768,9 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
> > >                 return -EMSGSIZE;
> > >
> > >         features = vdev->config->get_driver_features(vdev);
> > > +       err = vdpa_dev_net_ctrl_vq_fill(vdev, msg, &config, features);
> > > +       if (err)
> > > +               return err;
> > >
> > >         return vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
> > >  }
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
