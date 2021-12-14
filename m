Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE5BC433EF
	for <virtualization@archiver.kernel.org>; Tue, 14 Dec 2021 04:05:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 222CD405AA;
	Tue, 14 Dec 2021 04:05:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oIxw3Cu9Mv-7; Tue, 14 Dec 2021 04:05:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 25DC240361;
	Tue, 14 Dec 2021 04:05:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE8E9C002F;
	Tue, 14 Dec 2021 04:05:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F5F5C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 04:05:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0CF3460B68
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 04:05:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qjoXZJo6LCTS
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 04:05:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3A846600BA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 04:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639454751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9nBr30y6ejpX6kIXn4bRXI4xkvCLOfF9wCOwihgjClY=;
 b=RQffI0DIUjgq9VXHm6L449EXQRicMVvLMnZ5QOfUYJLviD3cS0VdYqPOGKx78+2xCKanhe
 kZDf1jMGhlL549dgcjAIWt2D2QzAXzmYoFON/l7wFqj5t5WgpGf9nKjjw3cBKMCFxf3aOO
 HEKqzutnmIfrVDyzDxUvsmLRAG2nrK4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-466-6fhiRZmtPR2zPaZncNobAA-1; Mon, 13 Dec 2021 23:05:50 -0500
X-MC-Unique: 6fhiRZmtPR2zPaZncNobAA-1
Received: by mail-lf1-f71.google.com with SMTP id
 w11-20020a05651234cb00b0041f93ca5812so6455070lfr.21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 20:05:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9nBr30y6ejpX6kIXn4bRXI4xkvCLOfF9wCOwihgjClY=;
 b=mgrhaDGpd3NINlQ5ZrWrBJapYOwqhF9hB3pTmJY7AA0EfYtezp9p/0Sk0wLE1Sq/Uj
 5V8Z3v0etX7OGHS5IixzG+flaJJcTD8pC4C65scU31JOfavpJgM8OMhou4ilFDcla09b
 MnkBnAyJC+lnHbpNlYnVRVFbGYqXFTp3ouyDPJx4xgxDcpFwVOtFE0T0BkjK+pivNlBn
 YxVPU+1PbaerUv1IGBqVDdka6F58hg3NikHr/qhSpDPMJz0HEjFENwoXvgO+0IZPZhtL
 WPy5ceUkg3/CPndsD30TFp0NaZFfvRGDGbYkHtjt2MT7SNGbr+fk8Au0gxvtcwJk260f
 L2qw==
X-Gm-Message-State: AOAM5336FPCmQkxFIt9fFOv176KLsB4EMloWlLh8TTe+qnaQU3e+cdFf
 SEDrrqrs6TqvsKim/c7SNUmCJGJdzwI+UK4NJR5OmAg2BheqaC5eyWtGWqcLRhkhu5vx+SiAnFt
 33q3hu5wsJwCTTCQC/f0bLK9+1/mpv8DLTIsL3dyeaT9KQL11EXfxbHx9Ww==
X-Received: by 2002:a05:6512:3b2b:: with SMTP id
 f43mr2481558lfv.629.1639454749381; 
 Mon, 13 Dec 2021 20:05:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5UDd/stq3iPWi9+PgvwesvfTIe4hXUplFCZ4PnDrkGWtv2NGSulXmWhRVzBVgi/65SQ5EDqBGcAKGZx3ZFyE=
X-Received: by 2002:a05:6512:3b2b:: with SMTP id
 f43mr2481529lfv.629.1639454749101; 
 Mon, 13 Dec 2021 20:05:49 -0800 (PST)
MIME-Version: 1.0
References: <20211213144258.179984-1-elic@nvidia.com>
 <20211213144258.179984-8-elic@nvidia.com>
In-Reply-To: <20211213144258.179984-8-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Dec 2021 12:05:38 +0800
Message-ID: <CACGkMEvwt0+hOHu9eHUnV-CL5WgcF+kiD86gGwvU13XwtH_i2w@mail.gmail.com>
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

On Mon, Dec 13, 2021 at 10:43 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Add netlink attribute to store flags indicating current state of the
> device.
> In addition, introduce a flag to indicate whether control virtqueue is
> used.
>
> This indication can be retrieved by:
>
> vdpa dev config show vdpa-a
> vdpa-a: mac 00:00:00:00:88:88 link up link_announce false max_vq_pairs 1
>         mtu 1500 ctrl_vq yes

I think the cvq is kind of duplicated with the driver features?

Thanks

>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
>
> ----
> V1 -> V2
> Patch was changed to return only an indication of ctrl VQ
> ---
>  drivers/vdpa/vdpa.c       | 17 +++++++++++++++++
>  include/uapi/linux/vdpa.h |  8 ++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 7b7bef7673b4..130a8d4aeaed 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -787,6 +787,19 @@ static int vdpa_nl_cmd_dev_get_dumpit(struct sk_buff *msg, struct netlink_callba
>         return msg->len;
>  }
>
> +static int vdpa_dev_net_ctrl_vq_fill(struct vdpa_device *vdev,
> +                                    struct sk_buff *msg,
> +                                    struct virtio_net_config *config,
> +                                    u64 features)
> +{
> +       if (!(features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> +               return 0;
> +
> +       /* currently the only flag can be returned */
> +       return nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FLAGS,
> +                                BIT_ULL(VDPA_DEV_ATTR_CVQ), VDPA_ATTR_PAD);
> +}
> +
>  static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
>                                        struct sk_buff *msg, u64 features,
>                                        const struct virtio_net_config *config)
> @@ -805,6 +818,7 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>         struct virtio_net_config config = {};
>         u64 features;
>         u16 val_u16;
> +       int err;
>
>         vdpa_get_config(vdev, 0, &config, sizeof(config));
>
> @@ -821,6 +835,9 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>                 return -EMSGSIZE;
>
>         features = vdev->config->get_driver_features(vdev);
> +       err = vdpa_dev_net_ctrl_vq_fill(vdev, msg, &config, features);
> +       if (err)
> +               return err;
>
>         return vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
>  }
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index a252f06f9dfd..23b854e3e5e2 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -20,9 +20,16 @@ enum vdpa_command {
>         VDPA_CMD_DEV_CONFIG_GET,        /* can dump */
>  };
>
> +enum {
> +       VDPA_DEV_ATTR_CVQ,
> +};
> +
>  enum vdpa_attr {
>         VDPA_ATTR_UNSPEC,
>
> +       /* Pad attribute for 64b alignment */
> +       VDPA_ATTR_PAD = VDPA_ATTR_UNSPEC,
> +
>         /* bus name (optional) + dev name together make the parent device handle */
>         VDPA_ATTR_MGMTDEV_BUS_NAME,             /* string */
>         VDPA_ATTR_MGMTDEV_DEV_NAME,             /* string */
> @@ -34,6 +41,7 @@ enum vdpa_attr {
>         VDPA_ATTR_DEV_MAX_VQS,                  /* u32 */
>         VDPA_ATTR_DEV_MAX_VQ_SIZE,              /* u16 */
>         VDPA_ATTR_DEV_MIN_VQ_SIZE,              /* u16 */
> +       VDPA_ATTR_DEV_FLAGS,                    /* u64 */
>
>         VDPA_ATTR_DEV_NET_CFG_MACADDR,          /* binary */
>         VDPA_ATTR_DEV_NET_STATUS,               /* u8 */
> --
> 2.33.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
