Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10468C433EF
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 07:57:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0E228142C;
	Tue, 22 Feb 2022 07:57:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uo66bHWRR_pe; Tue, 22 Feb 2022 07:57:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4EBA3812FC;
	Tue, 22 Feb 2022 07:57:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2ECF6C0021;
	Tue, 22 Feb 2022 07:57:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1466C0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 07:57:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D1E4E8142C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 07:57:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1OJEmefazMoM
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 07:57:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 11CDF812FC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 07:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645516630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BynQJzcaV02D/P4XrLZXd/QtdAc8gdMXMoNR19iKPlA=;
 b=eanYSq+Vlwru3NBpyiNT2brBrHOzsULtF24m9u7LOp8g1KRFMVfpMkYXHKnDdM8GxRIIfM
 pdq8HFOyqHYOcomnYp99ZPXi9uHuHeEmF2Z7HCFLrxvn/O1GnRnn/uFWgQk/sObZsRI1BM
 iBdOJGalyrkcU6ESpxNTLxqvRzOXklo=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-s0rQOW4IOLaUHv8X_CtyDg-1; Tue, 22 Feb 2022 02:57:06 -0500
X-MC-Unique: s0rQOW4IOLaUHv8X_CtyDg-1
Received: by mail-lj1-f199.google.com with SMTP id
 k33-20020a05651c062100b002460b0e948dso5328667lje.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 23:57:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BynQJzcaV02D/P4XrLZXd/QtdAc8gdMXMoNR19iKPlA=;
 b=t7BxevbqAhjSzLzIHeXuZ44dLKBN2FJfQp9DhHMXU7Lk7OvVWxRJnxeDYWVfwt3Bwd
 aQP2hTjAEXOqaM7PLYW1MleP0ZX0b6l8VagTU4O9Yh/vLayPmHTFFUy/m+LGJweiRlHU
 z9TDj/27cBPupvvkurhM1tGBdzvh/x/MwLys4oi8x7RZJkUl8jEa28f5BFbgYloQJ5+a
 S9FI5Mq5Xs7eQYdByW1HTJxtEv3ozM0tbH2BHUTLzuTLwhW38juRrH4SA1N1S2anl9dD
 0RgLAUT9P2BBlLfqCFla4Hb3/Pb7dWJ//1AftR55mFWK898SrSjDdwIB2/7N9WDmA27v
 38Zg==
X-Gm-Message-State: AOAM5323CJUyfn+bzgqNG6Xnx0tm1+xbl3uypdFqc8bmMODGZPYzDNkg
 NyivE0zgIGiCerVSOuYL5fqN8YNJkO1bFd+2MWwcXmFmFV4jWZNI7joTT8hN1sJiwcKWNBAPLzN
 bzaJ1YbajnOBQTl4/dEzH9lmP53GUeWzmNduHfD191BafsV+hY4H8SGXrNQ==
X-Received: by 2002:a05:6512:2109:b0:443:b538:b86d with SMTP id
 q9-20020a056512210900b00443b538b86dmr13996851lfr.481.1645516624992; 
 Mon, 21 Feb 2022 23:57:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdiw2wyPpYjjlrfMyue/xkbH/SClvggi/666FER0+OQHv9zAj8LOmI3TOC9lUbQ95PCZ8rnJwhLVDMt2KsI/Q=
X-Received: by 2002:a05:6512:2109:b0:443:b538:b86d with SMTP id
 q9-20020a056512210900b00443b538b86dmr13996843lfr.481.1645516624796; Mon, 21
 Feb 2022 23:57:04 -0800 (PST)
MIME-Version: 1.0
References: <20220221131751.197830-1-elic@nvidia.com>
 <20220221131751.197830-5-elic@nvidia.com>
In-Reply-To: <20220221131751.197830-5-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 22 Feb 2022 15:56:53 +0800
Message-ID: <CACGkMEtB58-NF17XzYK18hYEb1br+6_Y6e+JO_4H1yuSsZYerg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] vdpa: Support reading device features
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

On Mon, Feb 21, 2022 at 9:18 PM Eli Cohen <elic@nvidia.com> wrote:
>
> When showing the available management devices, check if
> VDPA_ATTR_DEV_SUPPORTED_FEATURES feature is available and print the
> supported features for a management device.
>
> Examples:
> $ vdpa mgmtdev show
> auxiliary/mlx5_core.sf.1:
>   supported_classes net
>   max_supported_vqs 257
>   dev_features CSUM GUEST_CSUM MTU HOST_TSO4 HOST_TSO6 STATUS CTRL_VQ MQ \
>                CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM
>
> $ vdpa -jp mgmtdev show
> {
>     "mgmtdev": {
>         "auxiliary/mlx5_core.sf.1": {
>             "supported_classes": [ "net" ],
>             "max_supported_vqs": 257,
>             "dev_features": [
> "CSUM","GUEST_CSUM","MTU","HOST_TSO4","HOST_TSO6","STATUS","CTRL_VQ","MQ",\
> "CTRL_MAC_ADDR","VERSION_1","ACCESS_PLATFORM" ]
>         }
>     }
> }
>
> Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  vdpa/include/uapi/linux/vdpa.h |  1 +
>  vdpa/vdpa.c                    | 15 +++++++++++++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/vdpa/include/uapi/linux/vdpa.h b/vdpa/include/uapi/linux/vdpa.h
> index a3ebf4d4d9b8..96ccbf305d14 100644
> --- a/vdpa/include/uapi/linux/vdpa.h
> +++ b/vdpa/include/uapi/linux/vdpa.h
> @@ -42,6 +42,7 @@ enum vdpa_attr {
>
>         VDPA_ATTR_DEV_NEGOTIATED_FEATURES,      /* u64 */
>         VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,          /* u32 */
> +       VDPA_ATTR_DEV_SUPPORTED_FEATURES,       /* u64 */
>
>         /* new attributes must be added above here */
>         VDPA_ATTR_MAX,
> diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c
> index 22064c755baa..bdc366880ab9 100644
> --- a/vdpa/vdpa.c
> +++ b/vdpa/vdpa.c
> @@ -84,6 +84,7 @@ static const enum mnl_attr_data_type vdpa_policy[VDPA_ATTR_MAX + 1] = {
>         [VDPA_ATTR_DEV_MAX_VQ_SIZE] = MNL_TYPE_U16,
>         [VDPA_ATTR_DEV_NEGOTIATED_FEATURES] = MNL_TYPE_U64,
>         [VDPA_ATTR_DEV_MGMTDEV_MAX_VQS] = MNL_TYPE_U32,
> +       [VDPA_ATTR_DEV_SUPPORTED_FEATURES] = MNL_TYPE_U64,
>  };
>
>  static int attr_cb(const struct nlattr *attr, void *data)
> @@ -494,14 +495,14 @@ static void print_features(struct vdpa *vdpa, uint64_t features, bool mgmtdevf,
>  static void pr_out_mgmtdev_show(struct vdpa *vdpa, const struct nlmsghdr *nlh,
>                                 struct nlattr **tb)
>  {
> +       uint64_t classes = 0;
>         const char *class;
>         unsigned int i;
>
>         pr_out_handle_start(vdpa, tb);
>
>         if (tb[VDPA_ATTR_MGMTDEV_SUPPORTED_CLASSES]) {
> -               uint64_t classes = mnl_attr_get_u64(tb[VDPA_ATTR_MGMTDEV_SUPPORTED_CLASSES]);
> -
> +               classes = mnl_attr_get_u64(tb[VDPA_ATTR_MGMTDEV_SUPPORTED_CLASSES]);
>                 pr_out_array_start(vdpa, "supported_classes");
>
>                 for (i = 1; i < 64; i++) {
> @@ -523,6 +524,16 @@ static void pr_out_mgmtdev_show(struct vdpa *vdpa, const struct nlmsghdr *nlh,
>                 print_uint(PRINT_ANY, "max_supported_vqs", "  max_supported_vqs %d", num_vqs);
>         }
>
> +       if (tb[VDPA_ATTR_DEV_SUPPORTED_FEATURES]) {
> +               uint64_t features;
> +
> +               features  = mnl_attr_get_u64(tb[VDPA_ATTR_DEV_SUPPORTED_FEATURES]);
> +               if (classes & BIT(VIRTIO_ID_NET))
> +                       print_features(vdpa, features, true, VIRTIO_ID_NET);
> +               else
> +                       print_features(vdpa, features, true, 0);
> +       }
> +
>         pr_out_handle_end(vdpa);
>  }
>
> --
> 2.35.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
