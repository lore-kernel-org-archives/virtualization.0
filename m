Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30EB4C433FE
	for <virtualization@archiver.kernel.org>; Tue, 14 Dec 2021 08:56:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C258860B8A;
	Tue, 14 Dec 2021 08:56:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6ivfwMwkWpi5; Tue, 14 Dec 2021 08:56:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5A11C60797;
	Tue, 14 Dec 2021 08:56:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3977AC001E;
	Tue, 14 Dec 2021 08:56:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7FEF8C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 08:56:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5D2084025F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 08:56:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wfytiYvFeH-9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 08:56:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5F73240143
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 08:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639472196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YmDRLpBJs4q4cxy4prp52SmUhvjWrMXUMhOtIrTRw2s=;
 b=EkU+vllKfepqGLgn3I9g90VZP2GaNvSuVWgulbA5qnnOMr+qmhVp5fXRg5gDznKUxARTj9
 WDhtiy6GXJ+fhnPJ2w1lnmeMVXNe+omKxoqtP4OoMlaVl1HZJxqirjEfC0SLs5lGvUtYay
 JWJdrnEXydpG9JRcjCaa90C/cuz2tAo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-f4zWoZe3O4-DAnUdLT6tVw-1; Tue, 14 Dec 2021 03:56:34 -0500
X-MC-Unique: f4zWoZe3O4-DAnUdLT6tVw-1
Received: by mail-lj1-f197.google.com with SMTP id
 bn28-20020a05651c179c00b002222b4cc6d8so4451448ljb.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 00:56:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YmDRLpBJs4q4cxy4prp52SmUhvjWrMXUMhOtIrTRw2s=;
 b=LsjUJEAwD7WfPvMtN4F8wjEsNJS5HJZdWeSjpkyWlQkOR8pA4KZeLTpsKrKb0tNkKx
 IjAnoB92ZIlUlkZ/uZYUujjJsUQYU7H9LHiw/ZUyE0S3Q2sCVVqJ4iphCN/Yc0b1UXXJ
 iEHUgYOvcit4VP8uJ3B5YJDob+fDtjfxlCFc+Kpqq2hfCgKnITfepfaM+mdCajP1RIKn
 KtNgGfJHlZFzQ9p6PtWdOV7Dgf3Ickfm9f/BchH5vCfCAPSJk1Ho8Bj9+rLAWFSO5l1P
 xzlbGpgfTITnc/i2vDeJRVfziZoU5OnSzuuP2nzvuVKLyuS+l9ggNO3A9ZHQanskJ16j
 EtIA==
X-Gm-Message-State: AOAM532QlApDvEUr5KlvfFtudN/FB7Boin+JtHO43cawJ7i5FH79NAHq
 DeB6XENL3u1Y3NcqpvEbXnuoAqZRYAHmfO20gC2aIKbllAzWtGQE8dwjvYy0uZUy7wFz+Il7o2v
 aYhiMgSbGBqsaKq3dSQSb6nF9X9wTTx7QwD9k5jTpVYV+BDE9OjkbBb/dNQ==
X-Received: by 2002:a05:6512:3987:: with SMTP id
 j7mr3519751lfu.199.1639472193436; 
 Tue, 14 Dec 2021 00:56:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx7YLg7agiqKLaZ+u9wsEsrAW8C5//en/ChkWAqOGB+4w+Fv40nL1NQIHs/RTFQ7r6la1/0slUXxw0o610a0zU=
X-Received: by 2002:a05:6512:3987:: with SMTP id
 j7mr3519737lfu.199.1639472193220; 
 Tue, 14 Dec 2021 00:56:33 -0800 (PST)
MIME-Version: 1.0
References: <20211213144258.179984-1-elic@nvidia.com>
 <20211213144258.179984-8-elic@nvidia.com>
 <CACGkMEvwt0+hOHu9eHUnV-CL5WgcF+kiD86gGwvU13XwtH_i2w@mail.gmail.com>
 <20211214071713.GB89087@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20211214071713.GB89087@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Dec 2021 16:56:22 +0800
Message-ID: <CACGkMEvL_3R-9ps1mFX7KpMEG3hevSzGMA5PDT+v4+VZ=gnnwQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] vdpa: Add support for returning device
 configuration information
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

On Tue, Dec 14, 2021 at 3:17 PM Eli Cohen <elic@nvidia.com> wrote:
>
> On Tue, Dec 14, 2021 at 12:05:38PM +0800, Jason Wang wrote:
> > On Mon, Dec 13, 2021 at 10:43 PM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > > Add netlink attribute to store flags indicating current state of the
> > > device.
> > > In addition, introduce a flag to indicate whether control virtqueue is
> > > used.
> > >
> > > This indication can be retrieved by:
> > >
> > > vdpa dev config show vdpa-a
> > > vdpa-a: mac 00:00:00:00:88:88 link up link_announce false max_vq_pairs 1
> > >         mtu 1500 ctrl_vq yes
> >
> > I think the cvq is kind of duplicated with the driver features?
>
> We don't pass to userspace the driver features. The availablity of CVQ
> is passed trough a new bit mask field that encodes (currently) just the
> availablity of CVQ.
>
> Are you suggesting the return the entire set of negotiated features and
> let user space decode that?

Yes, I think that can simplify things and save a lot of effort.

Thanks

>
> >
> > Thanks
> >
> > >
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > >
> > > ----
> > > V1 -> V2
> > > Patch was changed to return only an indication of ctrl VQ
> > > ---
> > >  drivers/vdpa/vdpa.c       | 17 +++++++++++++++++
> > >  include/uapi/linux/vdpa.h |  8 ++++++++
> > >  2 files changed, 25 insertions(+)
> > >
> > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > index 7b7bef7673b4..130a8d4aeaed 100644
> > > --- a/drivers/vdpa/vdpa.c
> > > +++ b/drivers/vdpa/vdpa.c
> > > @@ -787,6 +787,19 @@ static int vdpa_nl_cmd_dev_get_dumpit(struct sk_buff *msg, struct netlink_callba
> > >         return msg->len;
> > >  }
> > >
> > > +static int vdpa_dev_net_ctrl_vq_fill(struct vdpa_device *vdev,
> > > +                                    struct sk_buff *msg,
> > > +                                    struct virtio_net_config *config,
> > > +                                    u64 features)
> > > +{
> > > +       if (!(features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> > > +               return 0;
> > > +
> > > +       /* currently the only flag can be returned */
> > > +       return nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FLAGS,
> > > +                                BIT_ULL(VDPA_DEV_ATTR_CVQ), VDPA_ATTR_PAD);
> > > +}
> > > +
> > >  static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
> > >                                        struct sk_buff *msg, u64 features,
> > >                                        const struct virtio_net_config *config)
> > > @@ -805,6 +818,7 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
> > >         struct virtio_net_config config = {};
> > >         u64 features;
> > >         u16 val_u16;
> > > +       int err;
> > >
> > >         vdpa_get_config(vdev, 0, &config, sizeof(config));
> > >
> > > @@ -821,6 +835,9 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
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
> > > index a252f06f9dfd..23b854e3e5e2 100644
> > > --- a/include/uapi/linux/vdpa.h
> > > +++ b/include/uapi/linux/vdpa.h
> > > @@ -20,9 +20,16 @@ enum vdpa_command {
> > >         VDPA_CMD_DEV_CONFIG_GET,        /* can dump */
> > >  };
> > >
> > > +enum {
> > > +       VDPA_DEV_ATTR_CVQ,
> > > +};
> > > +
> > >  enum vdpa_attr {
> > >         VDPA_ATTR_UNSPEC,
> > >
> > > +       /* Pad attribute for 64b alignment */
> > > +       VDPA_ATTR_PAD = VDPA_ATTR_UNSPEC,
> > > +
> > >         /* bus name (optional) + dev name together make the parent device handle */
> > >         VDPA_ATTR_MGMTDEV_BUS_NAME,             /* string */
> > >         VDPA_ATTR_MGMTDEV_DEV_NAME,             /* string */
> > > @@ -34,6 +41,7 @@ enum vdpa_attr {
> > >         VDPA_ATTR_DEV_MAX_VQS,                  /* u32 */
> > >         VDPA_ATTR_DEV_MAX_VQ_SIZE,              /* u16 */
> > >         VDPA_ATTR_DEV_MIN_VQ_SIZE,              /* u16 */
> > > +       VDPA_ATTR_DEV_FLAGS,                    /* u64 */
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
