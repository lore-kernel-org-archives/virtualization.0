Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E09C433EF
	for <virtualization@archiver.kernel.org>; Thu,  9 Dec 2021 08:17:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A1BEF60625;
	Thu,  9 Dec 2021 08:17:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XLhLiW9qphNk; Thu,  9 Dec 2021 08:17:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3361F6060D;
	Thu,  9 Dec 2021 08:17:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2593C002F;
	Thu,  9 Dec 2021 08:17:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F0EAC0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 08:17:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 19E7E6060E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 08:17:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KRPFBGf0tqQS
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 08:17:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5661C6060D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 08:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639037856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CoqlXz+XTUYv5ZjNBiCBQeJAtLMf5ExriHqWts5k1Ts=;
 b=UNvfp5bbdT2ByfAVnHSnaoUIIGhXtAe8B6HC9CNGqwOaNpzi/BSn+LFgdq84xpX0wLAOSG
 63fYqkyDR8PAeM149v8Ka2IMZEjGuSlPlpU0dL6tVLlQ4/zR2P8FgV7S98MrA0Yg6MAXLj
 75xGqX4KL7kEJOj72QRo8lZpY796D+o=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-394-h7TOIJugM6eP3Oy_rbNnJg-1; Thu, 09 Dec 2021 03:17:35 -0500
X-MC-Unique: h7TOIJugM6eP3Oy_rbNnJg-1
Received: by mail-lj1-f197.google.com with SMTP id
 t25-20020a2e8e79000000b0021b5c659213so1523962ljk.10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Dec 2021 00:17:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CoqlXz+XTUYv5ZjNBiCBQeJAtLMf5ExriHqWts5k1Ts=;
 b=gWgF0tjMPrtatj2q2ThOA98IL0zP8phOUX1wXxukKHpK6PMYURnBWuS+uaxfHZFhW/
 RmB1+lN8/Fw8tp2yYJFxtEbPhQH3tw/HKHuafphUN4ruWpvp0S7iUrsWluWAY4W8sqjK
 mIVycjbSIPk9kPTISZKJpq1QYtCVpCUsjHF+vwH5d+b7ugqd33AcOqHENkW5NY7n9rid
 gM/x3xhRbS/7vxoSeS1WuVID9+AqycYoT1gVVxoDRT4d/jZCCTY4b9gPapxKZwa+kMq7
 P/zW0UkWapa4rMrFmR8EvhAW+Nesm71d544ujbfpi+N6S1HurlSob3umtBgkkLIyTPfg
 2woQ==
X-Gm-Message-State: AOAM530DsA2bCTlIWkbwDfY5P+6PJG8xsXo8HBtIK9Rd7djqZKiDgS4U
 VOT7ZQEZl7lZQGR/yz/JJHZHe7Ux2WtMOS8v6ApXB+Tk0wpKR3DbGLPz9i3aZBIQPOwj6vBaFwd
 cMWet0Lf/O6zPU7vF9zjzjgiNwKD/Lf7itGr/REp+uc9NAgpoT32r6W4cjw==
X-Received: by 2002:a2e:8507:: with SMTP id j7mr4720221lji.307.1639037853316; 
 Thu, 09 Dec 2021 00:17:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwm18eFUPqsnPZ1BkWzWp/n0sDJAHsregrS0z1QN/WlTURgBlbFLgYuwZcDMQ7yPJczQXErRU3Gbdc9IPq6N+U=
X-Received: by 2002:a2e:8507:: with SMTP id j7mr4720198lji.307.1639037853061; 
 Thu, 09 Dec 2021 00:17:33 -0800 (PST)
MIME-Version: 1.0
References: <20211208201430.73720-1-elic@nvidia.com>
 <20211208201430.73720-7-elic@nvidia.com>
 <CACGkMEvgiT8wCmBdyapdu+G04ceRzpG+witM0MPrVbErFiSLkg@mail.gmail.com>
 <20211209070904.GE108239@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEsy=bS8AWtoLhxG3ddA_egC3pde1yMd2m56GY9nqAp5Jw@mail.gmail.com>
 <20211209080414.GA110931@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20211209080414.GA110931@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Dec 2021 16:17:22 +0800
Message-ID: <CACGkMEuVdP7PTS=Rr+zriBVbWtWgzHa2zHkE1Vfr-CYKSsWjvQ@mail.gmail.com>
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

On Thu, Dec 9, 2021 at 4:04 PM Eli Cohen <elic@nvidia.com> wrote:
>
> On Thu, Dec 09, 2021 at 03:55:48PM +0800, Jason Wang wrote:
> > On Thu, Dec 9, 2021 at 3:09 PM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > > On Thu, Dec 09, 2021 at 01:44:56PM +0800, Jason Wang wrote:
> > > > On Thu, Dec 9, 2021 at 4:15 AM Eli Cohen <elic@nvidia.com> wrote:
> > > > >
> > > > > Add netlink attribute and callback function to query the control VQ
> > > > > index of a device.
> > > > >
> > > > > Example:
> > > > >
> > > > > $ vdpa dev config show vdpa-a
> > > > >   vdpa-a: mac 00:00:00:00:88:88 link up link_announce false max_vq_pairs 5 \
> > > > >   mtu 9000 ctrl_vq_idx 10
> > > >
> > > >
> > > > I still wonder about the motivation for this.
> > > To be able to show the stats for CVQ.
> >
> > Right.
> >
> > >
> > > > And as discussed, the
> > > > ctrl_vq_idx varies depending on whether MQ is negotiated.
> > >
> > > I handle this according to the spec and it depends on MQ.
> >
> > Yes, but there could be a chance that the cvq index changes after the
> > vdpa dev config show.
> >
>
> It depends on:
> VIRTIO_NET_F_CTRL_VQ
> VIRTIO_NET_F_MQ
>
> which can change only if the features are re-negotiated and that happens
> on driver in itialization.
>
> And on max_virtqueue_pairs which is also set at driver initialization.
>
> So I don't see any real issue here. Am I missing something?

No. I meant technically there could be a re-negotiation that happens
in the middle:

1) vdpa dev config show
2) feature renegotiation which change the cvq index
3) getting cvq stats

So the cvq index might be changed. E.g it could be changed from a cvq
to a rx queue. It might be easier to make the get index and stats
atomic.

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
> > > > > v0 -> v1:
> > > > > 1. Use logic defined in the spec to deduce virtqueue index.
> > > > >
> > > > >  drivers/vdpa/vdpa.c       | 25 +++++++++++++++++++++++++
> > > > >  include/uapi/linux/vdpa.h |  1 +
> > > > >  2 files changed, 26 insertions(+)
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > > > index 3bf016e03512..b4d4b8a7ca4e 100644
> > > > > --- a/drivers/vdpa/vdpa.c
> > > > > +++ b/drivers/vdpa/vdpa.c
> > > > > @@ -712,6 +712,27 @@ static int vdpa_nl_cmd_dev_get_dumpit(struct sk_buff *msg, struct netlink_callba
> > > > >         return msg->len;
> > > > >  }
> > > > >
> > > > > +static int vdpa_dev_net_ctrl_vq_fill(struct vdpa_device *vdev,
> > > > > +                                    struct sk_buff *msg,
> > > > > +                                    struct virtio_net_config *config,
> > > > > +                                    u64 features)
> > > > > +{
> > > > > +       u16 N;
> > > > > +
> > > > > +       /* control VQ index, if available, is deduced according to the logic
> > > > > +        * described in the virtio spec in section 5.1.2
> > > > > +        */
> > > > > +       if (!(features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> > > > > +               return 0;
> > > > > +
> > > > > +       if (features & BIT_ULL(VIRTIO_NET_F_MQ))
> > > > > +               N = le16_to_cpu(config->max_virtqueue_pairs);
> > > > > +       else
> > > > > +               N = 1;
> > > > > +
> > > > > +       return nla_put_u16(msg, VDPA_ATTR_DEV_CTRL_VQ_IDX, 2 * N);
> > > > > +}
> > > > > +
> > > > >  static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
> > > > >                                        struct sk_buff *msg, u64 features,
> > > > >                                        const struct virtio_net_config *config)
> > > > > @@ -730,6 +751,7 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
> > > > >         struct virtio_net_config config = {};
> > > > >         u64 features;
> > > > >         u16 val_u16;
> > > > > +       int err;
> > > > >
> > > > >         vdpa_get_config(vdev, 0, &config, sizeof(config));
> > > > >
> > > > > @@ -746,6 +768,9 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
> > > > >                 return -EMSGSIZE;
> > > > >
> > > > >         features = vdev->config->get_driver_features(vdev);
> > > > > +       err = vdpa_dev_net_ctrl_vq_fill(vdev, msg, &config, features);
> > > > > +       if (err)
> > > > > +               return err;
> > > > >
> > > > >         return vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
> > > > >  }
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
