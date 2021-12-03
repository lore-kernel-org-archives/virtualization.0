Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F42DC433EF
	for <virtualization@archiver.kernel.org>; Fri,  3 Dec 2021 02:35:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0A1B8345D;
	Fri,  3 Dec 2021 02:35:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id maxybQ40Hy76; Fri,  3 Dec 2021 02:35:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3DEAF83459;
	Fri,  3 Dec 2021 02:35:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B17EC0012;
	Fri,  3 Dec 2021 02:35:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68290C000A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 02:35:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 515A7405E3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 02:35:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ntx6owpiXPwh
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 02:35:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9D0FD405D6
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 02:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638498943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T7VseKTimwQHNWhBfxu2ZOMK/16Pra4OO7JxZOb8yVA=;
 b=PevOlUm7TtG4VgVqr3nZfhXcIxL2sXrR4OrCP83v+dDfNwE3aGBTw0fcAsvxMM9uUadFLJ
 6MBbj4PYj6p0GKaTSuvJDtw32n6OiGcJgwflhAnTVXKhdq386/lm7j5lnCjNTXWCYERELS
 rXrptEGh5tVls02XRx9i19ExaDGvbt8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-34-aPiepCSvNBiI1jVug48mPg-1; Thu, 02 Dec 2021 21:35:42 -0500
X-MC-Unique: aPiepCSvNBiI1jVug48mPg-1
Received: by mail-lj1-f200.google.com with SMTP id
 t25-20020a2e8e79000000b0021b5c659213so609082ljk.10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Dec 2021 18:35:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T7VseKTimwQHNWhBfxu2ZOMK/16Pra4OO7JxZOb8yVA=;
 b=doPsAev2I5E6fG/MKDHJVbYNXW4QCK0kUg3qw6wL0E6/u4vxCJ4rMKxKOuo07zGoPy
 ne3TEIqx3Agu5bSGcvwu0iIth/nPFAd3y3PhFnVLv116i3KVsJQVaoa7zoI/C3WKz6oV
 eyXgxrskIjHDCp2qDdlnvDMYeopGEq0hrgMvxvsTo9ir8YR5oPB/hCTD7ZrWWYW1EAhK
 JWsp2dfSF767NtD9OWGtYYWH6tu8m18I4Xx2qGeQkVNEDSt+3IsfPaHRR8ld1+Q3CL60
 +m2OOGY3MHWz7OIIkOfJ5IF2ivV7wl5cG2Z40ex1in37R+AlM7YcTSeHNVfm8WMMD+tg
 k29w==
X-Gm-Message-State: AOAM532EhbHhNSgViTPvFs6ascBPfxFXsg/jeYe3B3B/jgJm41BMi8Cr
 uzxWXMHR4yYkGDzVbKXRu+XH8LmdhuXvadstPcX/wY8M74fMr+EDIMeawcOoMpfdS1cdnuBCH+Q
 SNKZwsaQpFMTWiLmjwUsHlEh2okxpC32NaHzjMSVPOZPRp8zxiEdywFT7sw==
X-Received: by 2002:a2e:915a:: with SMTP id q26mr14925065ljg.277.1638498940975; 
 Thu, 02 Dec 2021 18:35:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz0pA+yhUSoK9CJBz/XAyhbWNCPAWfEv/5mxRcvzZ1iO1DqP0Ux8d8gQ8ZonFsjr957Xwqdk2a9O3mGh97bJYI=
X-Received: by 2002:a2e:915a:: with SMTP id q26mr14925049ljg.277.1638498940766; 
 Thu, 02 Dec 2021 18:35:40 -0800 (PST)
MIME-Version: 1.0
References: <20211201195724.17503-1-elic@nvidia.com>
 <20211201195724.17503-6-elic@nvidia.com>
In-Reply-To: <20211201195724.17503-6-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 3 Dec 2021 10:35:30 +0800
Message-ID: <CACGkMEsB2x2tX_bPdZRSFMU+pOAB6g3eYNeGerSGasVOu-8wrw@mail.gmail.com>
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

On Thu, Dec 2, 2021 at 3:58 AM Eli Cohen <elic@nvidia.com> wrote:
>
> Add netlink attribute and callback function to query the control VQ
> index of a device.

It's better to explain the motivation of this. Actually we can deduce
it from the max_virtqueue_paris if I was not wrong. So it means the
value varies depending on if VIRTIO_NET_F_MQ is negotiated which can
be changed after a query. This may probably confuse the userspace
sometime.

Thanks

>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/vdpa.c       | 18 ++++++++++++++++++
>  include/linux/vdpa.h      |  1 +
>  include/uapi/linux/vdpa.h |  1 +
>  3 files changed, 20 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index f06f949d5fa1..ca3ab0f46188 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -712,6 +712,20 @@ static int vdpa_nl_cmd_dev_get_dumpit(struct sk_buff *msg, struct netlink_callba
>         return msg->len;
>  }
>
> +static int vdpa_dev_net_ctrl_vq_fill(struct vdpa_device *vdev,
> +                                    struct sk_buff *msg, u64 features)
> +{
> +       u16 val_u16 = 0;
> +
> +       if (features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ) &&
> +           vdev->config->get_ctrl_vq_idx) {
> +               val_u16 = vdev->config->get_ctrl_vq_idx(vdev);
> +               return nla_put_u16(msg, VDPA_ATTR_DEV_CTRL_VQ_IDX, val_u16);
> +       }
> +
> +       return 0;
> +}
> +
>  static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
>                                        struct sk_buff *msg, u64 features,
>                                        const struct virtio_net_config *config)
> @@ -730,6 +744,7 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>         struct virtio_net_config config = {};
>         u64 features;
>         u16 val_u16;
> +       int err;
>
>         vdpa_get_config(vdev, 0, &config, sizeof(config));
>
> @@ -746,6 +761,9 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>                 return -EMSGSIZE;
>
>         features = vdev->config->get_features(vdev);
> +       err = vdpa_dev_net_ctrl_vq_fill(vdev, msg, features);
> +       if (err)
> +               return err;
>
>         return vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
>  }
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 820621c59365..fca9bfeed9ba 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -274,6 +274,7 @@ struct vdpa_config_ops {
>         (*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
>         /* vq irq is not expected to be changed once DRIVER_OK is set */
>         int (*get_vq_irq)(struct vdpa_device *vdev, u16 idx);
> +       u16 (*get_ctrl_vq_idx)(struct vdpa_device *vdev);
>
>         /* Device ops */
>         u32 (*get_vq_align)(struct vdpa_device *vdev);
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index a252f06f9dfd..2e3a7f89f42d 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -34,6 +34,7 @@ enum vdpa_attr {
>         VDPA_ATTR_DEV_MAX_VQS,                  /* u32 */
>         VDPA_ATTR_DEV_MAX_VQ_SIZE,              /* u16 */
>         VDPA_ATTR_DEV_MIN_VQ_SIZE,              /* u16 */
> +       VDPA_ATTR_DEV_CTRL_VQ_IDX,              /* u16 */
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
