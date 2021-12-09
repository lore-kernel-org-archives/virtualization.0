Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE62C433EF
	for <virtualization@archiver.kernel.org>; Thu,  9 Dec 2021 09:12:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 06836607F7;
	Thu,  9 Dec 2021 09:12:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T34YErBIDoub; Thu,  9 Dec 2021 09:12:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 39217607F0;
	Thu,  9 Dec 2021 09:12:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0AADAC001E;
	Thu,  9 Dec 2021 09:12:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31B89C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 09:12:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A350409ED
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 09:12:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xp142ikEt6OL
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 09:12:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BCFA2409EB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 09:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639041135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XY/fvvxgKevmWQOok6+30OYXnsl0EWDjbtTl3w5YbhU=;
 b=UsksUmVB+ueR5L/EQGlnG1hOPjHRmiwzPZ0nKoliLXnfV7P/l1ULaIMN2gcqdgCD/6E8s5
 aA4pYQHEM0VqI30sc+cEdpbTbLK6wouVHusKKTxJTLe+lRYrd3YRuVo0mqb3nQrIOuEw+c
 MrYFGhfc3c7XOCSraYvL7J9gWQrXEho=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-566-Z_Ul9pVCNEaaCu_6CrZABw-1; Thu, 09 Dec 2021 04:12:14 -0500
X-MC-Unique: Z_Ul9pVCNEaaCu_6CrZABw-1
Received: by mail-lj1-f197.google.com with SMTP id
 s16-20020a2ea710000000b0021b674e9347so1581507lje.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Dec 2021 01:12:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XY/fvvxgKevmWQOok6+30OYXnsl0EWDjbtTl3w5YbhU=;
 b=rCVf1wcrIAFgPEXyq213b6huewpR68gLZCIbAKfh/optbqF+Qk8qQ8QC3uXCDh9z3f
 3yp+WC/KJsl9lf1ZNHcUUKiVvx+sxA0tFPpL/DbowgVd/6dyMujRK6wTbj8VvuKdvRv8
 +rkcylhqhE/4/vWFDhpuoFbjghtZLwTb2ba20wksdg8+JkkldETDm2fMWLKWoNAS5JYX
 E3WkBq5Sbq3vrKQgE7g9dPCCAR48kXnV8641OwPREqvPha8MnBnqYbFQcysHzMolz32v
 1Ll43MuJvfIttzFYT+LEGl4J5sBxm4OzX/l1Y43tBVRka+YWEREFQweyB/WFNlCCnP6u
 nOow==
X-Gm-Message-State: AOAM530hnCdSpknt2qlkizxm6/5sAO8Wb+wH3CuOiGt8WJipd2e0AqDA
 yyw8A4R4kAlOFziJVKaK3RhhEPkd2EUd+WC0sIVIxL2zIiFi7xTcR28istRYxraCxdQFFm08Zih
 MMZPdd7FvFf7CLiXoOUrp2AXr16rXLRJV2LGRqxODi7weeVQCB374L3z6uw==
X-Received: by 2002:a2e:9f55:: with SMTP id v21mr5006970ljk.420.1639041133034; 
 Thu, 09 Dec 2021 01:12:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzgtHyAGKYsoEqyEhiZUPfHNFgd5BpwYzU6HEOevRlilowCuq2EhBsnTpxn8XjtzJ7ybSCAtFf1LoS5eESX+bg=
X-Received: by 2002:a2e:9f55:: with SMTP id v21mr5006945ljk.420.1639041132781; 
 Thu, 09 Dec 2021 01:12:12 -0800 (PST)
MIME-Version: 1.0
References: <20211208201430.73720-1-elic@nvidia.com>
 <20211208201430.73720-7-elic@nvidia.com>
 <CACGkMEvgiT8wCmBdyapdu+G04ceRzpG+witM0MPrVbErFiSLkg@mail.gmail.com>
 <20211209070904.GE108239@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEsy=bS8AWtoLhxG3ddA_egC3pde1yMd2m56GY9nqAp5Jw@mail.gmail.com>
 <20211209080414.GA110931@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEuVdP7PTS=Rr+zriBVbWtWgzHa2zHkE1Vfr-CYKSsWjvQ@mail.gmail.com>
 <20211209082618.GA111658@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20211209082618.GA111658@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Dec 2021 17:12:01 +0800
Message-ID: <CACGkMEsVcwigqqFysm1NFJsR=X50kR0Bj_XKdDRu6gYDNRzxAA@mail.gmail.com>
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

On Thu, Dec 9, 2021 at 4:26 PM Eli Cohen <elic@nvidia.com> wrote:
>
> On Thu, Dec 09, 2021 at 04:17:22PM +0800, Jason Wang wrote:
> > On Thu, Dec 9, 2021 at 4:04 PM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > > On Thu, Dec 09, 2021 at 03:55:48PM +0800, Jason Wang wrote:
> > > > On Thu, Dec 9, 2021 at 3:09 PM Eli Cohen <elic@nvidia.com> wrote:
> > > > >
> > > > > On Thu, Dec 09, 2021 at 01:44:56PM +0800, Jason Wang wrote:
> > > > > > On Thu, Dec 9, 2021 at 4:15 AM Eli Cohen <elic@nvidia.com> wrote:
> > > > > > >
> > > > > > > Add netlink attribute and callback function to query the control VQ
> > > > > > > index of a device.
> > > > > > >
> > > > > > > Example:
> > > > > > >
> > > > > > > $ vdpa dev config show vdpa-a
> > > > > > >   vdpa-a: mac 00:00:00:00:88:88 link up link_announce false max_vq_pairs 5 \
> > > > > > >   mtu 9000 ctrl_vq_idx 10
> > > > > >
> > > > > >
> > > > > > I still wonder about the motivation for this.
> > > > > To be able to show the stats for CVQ.
> > > >
> > > > Right.
> > > >
> > > > >
> > > > > > And as discussed, the
> > > > > > ctrl_vq_idx varies depending on whether MQ is negotiated.
> > > > >
> > > > > I handle this according to the spec and it depends on MQ.
> > > >
> > > > Yes, but there could be a chance that the cvq index changes after the
> > > > vdpa dev config show.
> > > >
> > >
> > > It depends on:
> > > VIRTIO_NET_F_CTRL_VQ
> > > VIRTIO_NET_F_MQ
> > >
> > > which can change only if the features are re-negotiated and that happens
> > > on driver in itialization.
> > >
> > > And on max_virtqueue_pairs which is also set at driver initialization.
> > >
> > > So I don't see any real issue here. Am I missing something?
> >
> > No. I meant technically there could be a re-negotiation that happens
> > in the middle:
> >
> > 1) vdpa dev config show
> > 2) feature renegotiation which change the cvq index
> > 3) getting cvq stats
> >
> > So the cvq index might be changed. E.g it could be changed from a cvq
> > to a rx queue. It might be easier to make the get index and stats
> > atomic.
> >
>
> The interface to read VQ stats is based on the user providing the index
> and getting the statistics.
>
> If we want to follow your suggestion then we need maybe to use a
> slightly modified command:
>
> For regular VQ:
> dpa dev vstats show vdpa-a qidx 0
>
> For CVQ:
> vdpa dev vstats show vdpa-a cvq

This might be better, but we need to make sure cvq only works for the
device that has a cvq.

>
> And that raises another question. Do we want to report the CVQ index in
> config show?

If we go with stats show vdpa-a cvq, we don't need to report the cvq index.

Thanks

>
> > Thanks
> >
> > >
> > > > Thanks
> > > >
> > > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > > > ---
> > > > > > > v0 -> v1:
> > > > > > > 1. Use logic defined in the spec to deduce virtqueue index.
> > > > > > >
> > > > > > >  drivers/vdpa/vdpa.c       | 25 +++++++++++++++++++++++++
> > > > > > >  include/uapi/linux/vdpa.h |  1 +
> > > > > > >  2 files changed, 26 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > > > > > index 3bf016e03512..b4d4b8a7ca4e 100644
> > > > > > > --- a/drivers/vdpa/vdpa.c
> > > > > > > +++ b/drivers/vdpa/vdpa.c
> > > > > > > @@ -712,6 +712,27 @@ static int vdpa_nl_cmd_dev_get_dumpit(struct sk_buff *msg, struct netlink_callba
> > > > > > >         return msg->len;
> > > > > > >  }
> > > > > > >
> > > > > > > +static int vdpa_dev_net_ctrl_vq_fill(struct vdpa_device *vdev,
> > > > > > > +                                    struct sk_buff *msg,
> > > > > > > +                                    struct virtio_net_config *config,
> > > > > > > +                                    u64 features)
> > > > > > > +{
> > > > > > > +       u16 N;
> > > > > > > +
> > > > > > > +       /* control VQ index, if available, is deduced according to the logic
> > > > > > > +        * described in the virtio spec in section 5.1.2
> > > > > > > +        */
> > > > > > > +       if (!(features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> > > > > > > +               return 0;
> > > > > > > +
> > > > > > > +       if (features & BIT_ULL(VIRTIO_NET_F_MQ))
> > > > > > > +               N = le16_to_cpu(config->max_virtqueue_pairs);
> > > > > > > +       else
> > > > > > > +               N = 1;
> > > > > > > +
> > > > > > > +       return nla_put_u16(msg, VDPA_ATTR_DEV_CTRL_VQ_IDX, 2 * N);
> > > > > > > +}
> > > > > > > +
> > > > > > >  static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
> > > > > > >                                        struct sk_buff *msg, u64 features,
> > > > > > >                                        const struct virtio_net_config *config)
> > > > > > > @@ -730,6 +751,7 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
> > > > > > >         struct virtio_net_config config = {};
> > > > > > >         u64 features;
> > > > > > >         u16 val_u16;
> > > > > > > +       int err;
> > > > > > >
> > > > > > >         vdpa_get_config(vdev, 0, &config, sizeof(config));
> > > > > > >
> > > > > > > @@ -746,6 +768,9 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
> > > > > > >                 return -EMSGSIZE;
> > > > > > >
> > > > > > >         features = vdev->config->get_driver_features(vdev);
> > > > > > > +       err = vdpa_dev_net_ctrl_vq_fill(vdev, msg, &config, features);
> > > > > > > +       if (err)
> > > > > > > +               return err;
> > > > > > >
> > > > > > >         return vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
> > > > > > >  }
> > > > > > > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > > > > > > index a252f06f9dfd..2e3a7f89f42d 100644
> > > > > > > --- a/include/uapi/linux/vdpa.h
> > > > > > > +++ b/include/uapi/linux/vdpa.h
> > > > > > > @@ -34,6 +34,7 @@ enum vdpa_attr {
> > > > > > >         VDPA_ATTR_DEV_MAX_VQS,                  /* u32 */
> > > > > > >         VDPA_ATTR_DEV_MAX_VQ_SIZE,              /* u16 */
> > > > > > >         VDPA_ATTR_DEV_MIN_VQ_SIZE,              /* u16 */
> > > > > > > +       VDPA_ATTR_DEV_CTRL_VQ_IDX,              /* u16 */
> > > > > > >
> > > > > > >         VDPA_ATTR_DEV_NET_CFG_MACADDR,          /* binary */
> > > > > > >         VDPA_ATTR_DEV_NET_STATUS,               /* u8 */
> > > > > > > --
> > > > > > > 2.33.1
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
