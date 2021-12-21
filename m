Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34ADAC433EF
	for <virtualization@archiver.kernel.org>; Tue, 21 Dec 2021 05:53:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D78D040400;
	Tue, 21 Dec 2021 05:53:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5_27nsmipOtO; Tue, 21 Dec 2021 05:53:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 91F1B403EC;
	Tue, 21 Dec 2021 05:53:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C1FFC001E;
	Tue, 21 Dec 2021 05:53:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8BFCC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 05:53:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CA3B240400
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 05:53:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id puWc4uYSDGJh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 05:53:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1B998403EC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 05:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640065992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qtQmPR8nU3digIvG8OZ8NEyjEIZwWv0pSM98PWjRurU=;
 b=BSH4SABQ5dwy163hN4wionCGL94Kd9X6Ivg3DFXYoVXxvmfd7wlT1mOeU6iBnaYSHe8tWk
 RhBgFLr2c1f+QHt8w/q6L+6CRxpmNa6DlYnbNTt34e632rZ8Wvsi2/7FBlQtaXmvE72Fe1
 qYuxcUJyywk1Z89CZFtSW2X0ojuI2y0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-leN96wwwPfKO7rnnHO2glg-1; Tue, 21 Dec 2021 00:53:10 -0500
X-MC-Unique: leN96wwwPfKO7rnnHO2glg-1
Received: by mail-lf1-f70.google.com with SMTP id
 h7-20020ac24da7000000b0042521f16f1fso5704738lfe.21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 21:53:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qtQmPR8nU3digIvG8OZ8NEyjEIZwWv0pSM98PWjRurU=;
 b=kHfqTSd3CLj84VmGRQKfJemgX4tJds7RezglRhHlhoiWcXST2MWVfm7IJ8fLPiiVBK
 H0HW/GR6CNazf/5WdeXgCbgpT54Jehu1d3twuGIiNNFudexqJ6ZLL08q5YejVNPlE4Pr
 Zn2utH6vvw1sPawPt6Jeu5BiYmXYn+pyY/b2frCxZPIScWwXLhMorlELIy2wAP+J4CnJ
 gcA592FuOwkbML9+fjy54JaJW+72gyL1dRIgZUMvXAFYb9kNEd6E4J3r8xX6r7B3zM+T
 1rhaDucauHNnmHZrugAWRJJj1UP61Qy3H6LWijfGgmqTd4GzJgOlfJKMYSQE56mjrxUo
 NOTw==
X-Gm-Message-State: AOAM531eEW0uFcsCbzlTEoZKo+uk8/epzEMSdPlR9QndOTt9Wrsp8ye8
 pDXfDfg66NZNae9DGipUfY3SfZ2TB66pb8Rse1n3tznQvPO9pxOPbcTW7L7egxHlNccDZ7iYO+Q
 tYNSdKN8x7G7QScq95cr5DaLAkANtcfcHLQtqqbsfbIiyE8y63ghysLKdlg==
X-Received: by 2002:a2e:915a:: with SMTP id q26mr1274217ljg.277.1640065988846; 
 Mon, 20 Dec 2021 21:53:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxwIWzCQN1Uq4ZK9ScW4g+280i0wbMa6Tkm+d+3aUICvvF23PbjOG6sCrXKWt6oiCr0KfVBoHWTyYc1Di0shXA=
X-Received: by 2002:a2e:915a:: with SMTP id q26mr1274199ljg.277.1640065988660; 
 Mon, 20 Dec 2021 21:53:08 -0800 (PST)
MIME-Version: 1.0
References: <20211219140236.27479-1-elic@nvidia.com>
 <20211219140236.27479-5-elic@nvidia.com>
In-Reply-To: <20211219140236.27479-5-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Dec 2021 13:52:57 +0800
Message-ID: <CACGkMEv-ffpkfZdTc+xiniy0Qn_KDZi6bdp_Nv1Dv8V+PU0SYQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] vdpa: Allow to configure max data virtqueues
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

On Sun, Dec 19, 2021 at 10:03 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Add netlink support to configure the max virtqueue pairs for a device.
> At least one pair is required. The maximum is dictated by the device.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

>
> ---
> V2 -> V3:
> Fix error flow
>
>  drivers/vdpa/vdpa.c  | 13 ++++++++++++-
>  include/linux/vdpa.h |  1 +
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 5749cf0a1500..83730713c7d0 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -555,7 +555,8 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
>  }
>
>  #define VDPA_DEV_NET_ATTRS_MASK ((1 << VDPA_ATTR_DEV_NET_CFG_MACADDR) | \
> -                                (1 << VDPA_ATTR_DEV_NET_CFG_MTU))
> +                                (1 << VDPA_ATTR_DEV_NET_CFG_MTU) | \
> +                                (1 << VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
>
>  static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> @@ -581,6 +582,16 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>                         nla_get_u16(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]);
>                 config.mask |= (1 << VDPA_ATTR_DEV_NET_CFG_MTU);
>         }
> +       if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MAX_VQP]) {
> +               config.net.max_vq_pairs =
> +                       nla_get_u16(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MAX_VQP]);
> +               if (!config.net.max_vq_pairs) {
> +                       NL_SET_ERR_MSG_MOD(info->extack,
> +                                          "At least one pair of VQs is required");
> +                       return -EINVAL;
> +               }
> +               config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
> +       }
>
>         /* Skip checking capability if user didn't prefer to configure any
>          * device networking attributes. It is likely that user might have used
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 9cc4291a79b3..9245dfbf1b08 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -101,6 +101,7 @@ struct vdpa_dev_set_config {
>         struct {
>                 u8 mac[ETH_ALEN];
>                 u16 mtu;
> +               u16 max_vq_pairs;
>         } net;
>         u64 mask;
>  };
> --
> 2.34.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
