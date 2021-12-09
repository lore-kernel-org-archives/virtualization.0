Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33939C433F5
	for <virtualization@archiver.kernel.org>; Thu,  9 Dec 2021 05:45:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E20DB40375;
	Thu,  9 Dec 2021 05:45:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0brhK-ohCuUx; Thu,  9 Dec 2021 05:45:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 207D1400B5;
	Thu,  9 Dec 2021 05:45:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9FAEC001E;
	Thu,  9 Dec 2021 05:45:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A140C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 05:45:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 282A4408F5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 05:45:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vqzVGJtm4ron
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 05:45:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5B26B408F2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 05:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639028713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aCRmDkt6sxb7/iSqnv+t+ve+Exqgja8coxzgTva5o8Y=;
 b=dkOrABoWUmXOVAWRszkl4NbHuDicZXkK6B1/QyT00y8cZ8Z/ZsszVYyB4+jts1rPo/bPJP
 eJOTjWwXTHGm2E6Yy3OSAMWVDM9dlhLb8K26gaMr5PA6QPOkpkd+x6Yn8OIoPRCdqHINj/
 na57F9ihV83g0UJdeBcvbxEP3zIQnsE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-JjxjSPmqNvOTJ6V5dghQtA-1; Thu, 09 Dec 2021 00:45:09 -0500
X-MC-Unique: JjxjSPmqNvOTJ6V5dghQtA-1
Received: by mail-lj1-f200.google.com with SMTP id
 bn28-20020a05651c179c00b002222b4cc6d8so711601ljb.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Dec 2021 21:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aCRmDkt6sxb7/iSqnv+t+ve+Exqgja8coxzgTva5o8Y=;
 b=rlJfKMnM+rl8CKg2DGu/mJotE2C60YocziVeN4aFQ1FmxX31uhi1kaiqkZpMK4aHRW
 UqQcu1wuYWUVbrZrMGSQ2viXTRrsXAwUS2+pYUf7kYYg2D3+5JLR5GUeRGUHbUc5sPTq
 AZR+Oi+nh01c3/oCJnUzw2wQ9BlgHTsXgoHwy1+riTp3qF/iBRXXQ8W5/Q/FoKXIQ1+F
 YAq6gE5BAWmvcTzoqkQcxzhG9rpQmFaUxTcUTh/NJAhEswV0me+6sXdwf8ebk4llOeT1
 csJ90nQzmeJ1Z7z+0pqyVRprX1eDDEQrSxYVH2z4Yr/BjKv3Zugcr6pGXCUKDxNOsqRc
 2yOQ==
X-Gm-Message-State: AOAM531Mib4yAp5uzzmuhcOGobe3ovoIysPimuQWu9T5lYhm2Kf/upKO
 VnftNkaywaE93jJbFoQkPeLtx99YHLtJLSCEJ1VbK1r4vW7GzeZAKVUnw8aQjH7T9+aIbrKqhJ/
 entiKGRdqZyhMeVf9H9WglVtsCzNBwHqCTHaP03Kj8/SlHFgrfADGDP1quQ==
X-Received: by 2002:a2e:9f55:: with SMTP id v21mr4137561ljk.420.1639028707451; 
 Wed, 08 Dec 2021 21:45:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwIhQpS11lb6nnc6RF5n6zn4179P0Dp9cgJCkW9FcDaRMLWb/xDBG5ju+7O0quocUGdASYoePmC6e0RHmCFeMs=
X-Received: by 2002:a2e:9f55:: with SMTP id v21mr4137529ljk.420.1639028707221; 
 Wed, 08 Dec 2021 21:45:07 -0800 (PST)
MIME-Version: 1.0
References: <20211208201430.73720-1-elic@nvidia.com>
 <20211208201430.73720-7-elic@nvidia.com>
In-Reply-To: <20211208201430.73720-7-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Dec 2021 13:44:56 +0800
Message-ID: <CACGkMEvgiT8wCmBdyapdu+G04ceRzpG+witM0MPrVbErFiSLkg@mail.gmail.com>
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

On Thu, Dec 9, 2021 at 4:15 AM Eli Cohen <elic@nvidia.com> wrote:
>
> Add netlink attribute and callback function to query the control VQ
> index of a device.
>
> Example:
>
> $ vdpa dev config show vdpa-a
>   vdpa-a: mac 00:00:00:00:88:88 link up link_announce false max_vq_pairs 5 \
>   mtu 9000 ctrl_vq_idx 10


I still wonder about the motivation for this. And as discussed, the
ctrl_vq_idx varies depending on whether MQ is negotiated.

Thanks

>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
> v0 -> v1:
> 1. Use logic defined in the spec to deduce virtqueue index.
>
>  drivers/vdpa/vdpa.c       | 25 +++++++++++++++++++++++++
>  include/uapi/linux/vdpa.h |  1 +
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 3bf016e03512..b4d4b8a7ca4e 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -712,6 +712,27 @@ static int vdpa_nl_cmd_dev_get_dumpit(struct sk_buff *msg, struct netlink_callba
>         return msg->len;
>  }
>
> +static int vdpa_dev_net_ctrl_vq_fill(struct vdpa_device *vdev,
> +                                    struct sk_buff *msg,
> +                                    struct virtio_net_config *config,
> +                                    u64 features)
> +{
> +       u16 N;
> +
> +       /* control VQ index, if available, is deduced according to the logic
> +        * described in the virtio spec in section 5.1.2
> +        */
> +       if (!(features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> +               return 0;
> +
> +       if (features & BIT_ULL(VIRTIO_NET_F_MQ))
> +               N = le16_to_cpu(config->max_virtqueue_pairs);
> +       else
> +               N = 1;
> +
> +       return nla_put_u16(msg, VDPA_ATTR_DEV_CTRL_VQ_IDX, 2 * N);
> +}
> +
>  static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
>                                        struct sk_buff *msg, u64 features,
>                                        const struct virtio_net_config *config)
> @@ -730,6 +751,7 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>         struct virtio_net_config config = {};
>         u64 features;
>         u16 val_u16;
> +       int err;
>
>         vdpa_get_config(vdev, 0, &config, sizeof(config));
>
> @@ -746,6 +768,9 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
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
