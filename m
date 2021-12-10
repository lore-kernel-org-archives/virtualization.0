Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDA0C433F5
	for <virtualization@archiver.kernel.org>; Fri, 10 Dec 2021 02:29:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3112241FB9;
	Fri, 10 Dec 2021 02:29:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uFVbn9ek3YzS; Fri, 10 Dec 2021 02:29:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7815841F59;
	Fri, 10 Dec 2021 02:29:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57041C002F;
	Fri, 10 Dec 2021 02:29:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19FD6C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 02:29:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0250880DFD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 02:29:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hk66ExpUIcN9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 02:29:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E4BB680DB8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 02:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639103340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S9tY/Vp96+WPWCbhhV4hvsGPCNFeFHG8BczqcaqqYKo=;
 b=I5Z2c5kh9iuj33VW7I+j3xusR2yUUACuzDD91OvpAzqisKOvw4XFVXv9O4BFo5maTz/U3V
 NCSkSDx0FReLAw3syRtP31aURQ3K2kc/G9ssyy1hTK4Tsel7YJBmLdFyMpmFWPX0XQDguI
 7yljCcuKsAYFteyggRersiEzSwSBLb4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-gcpZ_fB1MqWEMQfn7u1Itg-1; Thu, 09 Dec 2021 21:27:23 -0500
X-MC-Unique: gcpZ_fB1MqWEMQfn7u1Itg-1
Received: by mail-lf1-f71.google.com with SMTP id
 k32-20020a0565123da000b0041643c6a467so3487708lfv.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Dec 2021 18:27:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S9tY/Vp96+WPWCbhhV4hvsGPCNFeFHG8BczqcaqqYKo=;
 b=trVR3ZFijeCzn7nuc8DPPcZYDmqumpHF6Yc1jnfaDqLPqXPaHRszaoLSWaj3qrxaf9
 ZJcamfTEAxYKG4R5kXfHv5KTvhte0kPL9hZQ/sw+EPfbMzt8VUDynUkfSPE0/Hp5DsiD
 SGV9BuFjsMDTMRW8Yi4fN6nWGNEkpJOsuQ2vnOU7nKyVVjdTY6VALOLXNMTVPVCfCONa
 +hTxTMIS9Q+PK3i0zn3vL9ihWhqkIph6OXwPi6Sgg4cC12xK8403EM6e0wd4rBMZWASV
 PDU+FE03ubtFmKVB2cISZd/vPeqz88AHkxlI0ANcfHp5REmdQ6BYk95ceVQHl7PGgN8i
 xicw==
X-Gm-Message-State: AOAM530K8wyUWJlA2lT0olEybRqDu3ap9wAOPZXX+T8/JmT6ZknsmEfT
 SJEieSzY1C7KuoriZ0LO5OL75WYC88PgTIqv1ztXO3jG0ArGCVO7Yirlr6u5whcJ1JwlUivBmW7
 XZ4OV1xkQ9koj08edoUCCTQvbPJZvLvbjtwu05aCJJyhyffKagKNqDtQqKw==
X-Received: by 2002:a05:6512:3d09:: with SMTP id
 d9mr10016798lfv.481.1639103242381; 
 Thu, 09 Dec 2021 18:27:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzklsAG1ULwnEbByEGsXochCky8iYyqO4dGGzm30CIKZanpTBTBTJY8atMfJhGtIZGDkl97D4c7IAac2tiW+n8=
X-Received: by 2002:a05:6512:3d09:: with SMTP id
 d9mr10016764lfv.481.1639103242090; 
 Thu, 09 Dec 2021 18:27:22 -0800 (PST)
MIME-Version: 1.0
References: <20211208201430.73720-1-elic@nvidia.com>
 <20211208201430.73720-7-elic@nvidia.com>
 <CACGkMEvgiT8wCmBdyapdu+G04ceRzpG+witM0MPrVbErFiSLkg@mail.gmail.com>
 <20211209070904.GE108239@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEsy=bS8AWtoLhxG3ddA_egC3pde1yMd2m56GY9nqAp5Jw@mail.gmail.com>
 <20211209080414.GA110931@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEuVdP7PTS=Rr+zriBVbWtWgzHa2zHkE1Vfr-CYKSsWjvQ@mail.gmail.com>
 <20211209082618.GA111658@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEsVcwigqqFysm1NFJsR=X50kR0Bj_XKdDRu6gYDNRzxAA@mail.gmail.com>
 <20211209092053.GA113385@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20211209092053.GA113385@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 10 Dec 2021 10:27:11 +0800
Message-ID: <CACGkMEs8dW3QVcUmtG6qkU2h0R6tKtZWFow=Yf1GGPZ3O4spOQ@mail.gmail.com>
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

On Thu, Dec 9, 2021 at 5:21 PM Eli Cohen <elic@nvidia.com> wrote:
>
> On Thu, Dec 09, 2021 at 05:12:01PM +0800, Jason Wang wrote:
> > On Thu, Dec 9, 2021 at 4:26 PM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > > On Thu, Dec 09, 2021 at 04:17:22PM +0800, Jason Wang wrote:
> > > > On Thu, Dec 9, 2021 at 4:04 PM Eli Cohen <elic@nvidia.com> wrote:
> > > > >
> > > > > On Thu, Dec 09, 2021 at 03:55:48PM +0800, Jason Wang wrote:
> > > > > > On Thu, Dec 9, 2021 at 3:09 PM Eli Cohen <elic@nvidia.com> wrote:
> > > > > > >
> > > > > > > On Thu, Dec 09, 2021 at 01:44:56PM +0800, Jason Wang wrote:
> > > > > > > > On Thu, Dec 9, 2021 at 4:15 AM Eli Cohen <elic@nvidia.com> wrote:
> > > > > > > > >
> > > > > > > > > Add netlink attribute and callback function to query the control VQ
> > > > > > > > > index of a device.
> > > > > > > > >
> > > > > > > > > Example:
> > > > > > > > >
> > > > > > > > > $ vdpa dev config show vdpa-a
> > > > > > > > >   vdpa-a: mac 00:00:00:00:88:88 link up link_announce false max_vq_pairs 5 \
> > > > > > > > >   mtu 9000 ctrl_vq_idx 10
> > > > > > > >
> > > > > > > >
> > > > > > > > I still wonder about the motivation for this.
> > > > > > > To be able to show the stats for CVQ.
> > > > > >
> > > > > > Right.
> > > > > >
> > > > > > >
> > > > > > > > And as discussed, the
> > > > > > > > ctrl_vq_idx varies depending on whether MQ is negotiated.
> > > > > > >
> > > > > > > I handle this according to the spec and it depends on MQ.
> > > > > >
> > > > > > Yes, but there could be a chance that the cvq index changes after the
> > > > > > vdpa dev config show.
> > > > > >
> > > > >
> > > > > It depends on:
> > > > > VIRTIO_NET_F_CTRL_VQ
> > > > > VIRTIO_NET_F_MQ
> > > > >
> > > > > which can change only if the features are re-negotiated and that happens
> > > > > on driver in itialization.
> > > > >
> > > > > And on max_virtqueue_pairs which is also set at driver initialization.
> > > > >
> > > > > So I don't see any real issue here. Am I missing something?
> > > >
> > > > No. I meant technically there could be a re-negotiation that happens
> > > > in the middle:
> > > >
> > > > 1) vdpa dev config show
> > > > 2) feature renegotiation which change the cvq index
> > > > 3) getting cvq stats
> > > >
> > > > So the cvq index might be changed. E.g it could be changed from a cvq
> > > > to a rx queue. It might be easier to make the get index and stats
> > > > atomic.
> > > >
> > >
> > > The interface to read VQ stats is based on the user providing the index
> > > and getting the statistics.
> > >
> > > If we want to follow your suggestion then we need maybe to use a
> > > slightly modified command:
> > >
> > > For regular VQ:
> > > dpa dev vstats show vdpa-a qidx 0
> > >
> > > For CVQ:
> > > vdpa dev vstats show vdpa-a cvq
> >
> > This might be better, but we need to make sure cvq only works for the
> > device that has a cvq.
> >
>
> OK.
>
> > >
> > > And that raises another question. Do we want to report the CVQ index in
> > > config show?
> >
> > If we go with stats show vdpa-a cvq, we don't need to report the cvq index.
> >
>
> Maybe we should leave some kind of indication as to whether there is a
> CVQ. Maybe not the index itself by just "CVQ" so a user will know if
> it's worth trying to read cvq stats.
>
> Otherwise, the user will attempt to read and fail.
> What do you think?

I agree.

Thanks

>
> > Thanks
> >
> > >
> > > > Thanks
> > > >
> > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > > > > > ---
> > > > > > > > > v0 -> v1:
> > > > > > > > > 1. Use logic defined in the spec to deduce virtqueue index.
> > > > > > > > >
> > > > > > > > >  drivers/vdpa/vdpa.c       | 25 +++++++++++++++++++++++++
> > > > > > > > >  include/uapi/linux/vdpa.h |  1 +
> > > > > > > > >  2 files changed, 26 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > > > > > > > index 3bf016e03512..b4d4b8a7ca4e 100644
> > > > > > > > > --- a/drivers/vdpa/vdpa.c
> > > > > > > > > +++ b/drivers/vdpa/vdpa.c
> > > > > > > > > @@ -712,6 +712,27 @@ static int vdpa_nl_cmd_dev_get_dumpit(struct sk_buff *msg, struct netlink_callba
> > > > > > > > >         return msg->len;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +static int vdpa_dev_net_ctrl_vq_fill(struct vdpa_device *vdev,
> > > > > > > > > +                                    struct sk_buff *msg,
> > > > > > > > > +                                    struct virtio_net_config *config,
> > > > > > > > > +                                    u64 features)
> > > > > > > > > +{
> > > > > > > > > +       u16 N;
> > > > > > > > > +
> > > > > > > > > +       /* control VQ index, if available, is deduced according to the logic
> > > > > > > > > +        * described in the virtio spec in section 5.1.2
> > > > > > > > > +        */
> > > > > > > > > +       if (!(features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> > > > > > > > > +               return 0;
> > > > > > > > > +
> > > > > > > > > +       if (features & BIT_ULL(VIRTIO_NET_F_MQ))
> > > > > > > > > +               N = le16_to_cpu(config->max_virtqueue_pairs);
> > > > > > > > > +       else
> > > > > > > > > +               N = 1;
> > > > > > > > > +
> > > > > > > > > +       return nla_put_u16(msg, VDPA_ATTR_DEV_CTRL_VQ_IDX, 2 * N);
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
> > > > > > > > >                                        struct sk_buff *msg, u64 features,
> > > > > > > > >                                        const struct virtio_net_config *config)
> > > > > > > > > @@ -730,6 +751,7 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
> > > > > > > > >         struct virtio_net_config config = {};
> > > > > > > > >         u64 features;
> > > > > > > > >         u16 val_u16;
> > > > > > > > > +       int err;
> > > > > > > > >
> > > > > > > > >         vdpa_get_config(vdev, 0, &config, sizeof(config));
> > > > > > > > >
> > > > > > > > > @@ -746,6 +768,9 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
> > > > > > > > >                 return -EMSGSIZE;
> > > > > > > > >
> > > > > > > > >         features = vdev->config->get_driver_features(vdev);
> > > > > > > > > +       err = vdpa_dev_net_ctrl_vq_fill(vdev, msg, &config, features);
> > > > > > > > > +       if (err)
> > > > > > > > > +               return err;
> > > > > > > > >
> > > > > > > > >         return vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
> > > > > > > > >  }
> > > > > > > > > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > > > > > > > > index a252f06f9dfd..2e3a7f89f42d 100644
> > > > > > > > > --- a/include/uapi/linux/vdpa.h
> > > > > > > > > +++ b/include/uapi/linux/vdpa.h
> > > > > > > > > @@ -34,6 +34,7 @@ enum vdpa_attr {
> > > > > > > > >         VDPA_ATTR_DEV_MAX_VQS,                  /* u32 */
> > > > > > > > >         VDPA_ATTR_DEV_MAX_VQ_SIZE,              /* u16 */
> > > > > > > > >         VDPA_ATTR_DEV_MIN_VQ_SIZE,              /* u16 */
> > > > > > > > > +       VDPA_ATTR_DEV_CTRL_VQ_IDX,              /* u16 */
> > > > > > > > >
> > > > > > > > >         VDPA_ATTR_DEV_NET_CFG_MACADDR,          /* binary */
> > > > > > > > >         VDPA_ATTR_DEV_NET_STATUS,               /* u8 */
> > > > > > > > > --
> > > > > > > > > 2.33.1
> > > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
