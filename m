Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50070C43334
	for <virtualization@archiver.kernel.org>; Thu,  2 Jun 2022 07:32:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA77583486;
	Thu,  2 Jun 2022 07:32:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sdeMoPBoXiq2; Thu,  2 Jun 2022 07:32:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6735283410;
	Thu,  2 Jun 2022 07:32:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 323E9C0039;
	Thu,  2 Jun 2022 07:32:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D42F5C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 07:32:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AE42840873
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 07:32:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UWPk4EzRhN2a
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 07:32:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 69A7240504
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 07:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654155144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L39d6PlclTccAa5+peBdlcEs7zVdEw6CEB2ogF1cL00=;
 b=d1SdoG3Hq5RJN4adNodj/BBbDu2TQu5Lh57RZr9158gTmdBRZUxQ9JX5LSVc+lPKEFrZ0d
 2QpSOhoVWRo5pD+hiPDn6F7sr5jbL32gKzWp4IaO5CvstHsGQcKP9UzwYdHs/lw5JeglcO
 YeIiie/ZPsrOy9+iHBzBjHPSEoWSHuY=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-RSAvYDopOja3u9l-kEGzeQ-1; Thu, 02 Jun 2022 03:32:20 -0400
X-MC-Unique: RSAvYDopOja3u9l-kEGzeQ-1
Received: by mail-yb1-f197.google.com with SMTP id
 n3-20020a257203000000b0064f867fcfc0so3452409ybc.15
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Jun 2022 00:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L39d6PlclTccAa5+peBdlcEs7zVdEw6CEB2ogF1cL00=;
 b=BzJWDvsGiqMLCMAHoM7NvHqhQt3pIvM1yuc4cUx68mwzJFZYP79u/BQYCti3A0zb1r
 1VKlPbpLGrT+0vd2oCBTDIsXS6bQycWz11Kz2X8Yl/WKEKs5yuyrREY1Rwh4GIAC2urn
 oKeEMTVm8oITsUw0ZG92EIWZWwcKsTEaLZrhsXYXDwNBXjNXY1KKa3vWBsNPDNUl4JZ0
 3FlXhc4m1dLG9y3zI6s618c7738piJYE3+AZKxgJgW8Hrb2AsEEH8tGsWbaAWjJLuok4
 a432hOnDPShcmeEa9hyi4zORIZoQdQkHaQ/rlBSzWK10JnS3KGinbDGwbXEZ8PE+RFP1
 6j/Q==
X-Gm-Message-State: AOAM5326zsXEPbbLzSjOKali/zbCCKLuE3/0Korg0vz4d8DzXcIHngqb
 6Qq34ZNuvmI4F1yo4xq6iwd0Bw9zB6meUPt3MdMUpQI7aIlgVETum1wM7xv20OBvk5NYi2pfN73
 RsjW89Di63UFzUVSna136mpyhQiUuxOVdGxjC1yZnKlza0uIpdRXmLmqUZA==
X-Received: by 2002:a81:980c:0:b0:2f8:be8d:5100 with SMTP id
 p12-20020a81980c000000b002f8be8d5100mr4053291ywg.52.1654155140419; 
 Thu, 02 Jun 2022 00:32:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnmWA3pQQTaG73FhzWf8q7To1mpHUSTp/3C1yHN8ExI89iHTx7nUJpLVL1Rjj16C3YeSiWiIYVSWvIUTzTdQ8=
X-Received: by 2002:a81:980c:0:b0:2f8:be8d:5100 with SMTP id
 p12-20020a81980c000000b002f8be8d5100mr4053284ywg.52.1654155140203; Thu, 02
 Jun 2022 00:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220602023845.2596397-1-lingshan.zhu@intel.com>
 <20220602023845.2596397-4-lingshan.zhu@intel.com>
In-Reply-To: <20220602023845.2596397-4-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Jun 2022 15:32:09 +0800
Message-ID: <CACGkMEv9Vhe0+8DTotmGU1_9DseixTqA4CaYC1sXiNy0XYkBQw@mail.gmail.com>
Subject: Re: [PATCH 3/6] vDPA/ifcvf: support userspace to query device feature
 bits
To: Zhu Lingshan <lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>, Eli Cohen <elic@nvidia.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 mst <mst@redhat.com>
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

On Thu, Jun 2, 2022 at 10:48 AM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>
> This commit supports userspace to query device feature bits
> by filling the relevant netlink attribute.
>
> There are two types of netlink attributes:
> VDPA_ATTR_DEV_XXXX work for virtio devices config space, and
> VDPA_ATTR_MGMTDEV_XXXX work for the management devices.
>
> This commit fixes a misuse of VDPA_ATTR_DEV_SUPPORTED_FEATURES,
> this attr is for a virtio device, not management devices.
>
> Thus VDPA_ATTR_MGMTDEV_SUPPORTED_FEATURES is introduced for
> reporting management device features, and VDPA_ATTR_DEV_SUPPORTED_FEATURES
> for virtio devices feature bits.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  drivers/vdpa/vdpa.c       | 15 ++++++++++-----
>  include/uapi/linux/vdpa.h |  1 +
>  2 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 2b75c00b1005..c820dd2b0307 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -508,7 +508,7 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *m
>                 err = -EMSGSIZE;
>                 goto msg_err;
>         }
> -       if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_SUPPORTED_FEATURES,
> +       if (nla_put_u64_64bit(msg, VDPA_ATTR_MGMTDEV_SUPPORTED_FEATURES,

Adding Eli and Parav.

If I understand correctly, we can't provision virtio features right
now. This means, the vDPA instance should have the same features as
its parent (management device).

And it seems to me if we can do things like this, we need first allow
the features to be provisioned. (And this change breaks uABI)

Thanks


>                               mdev->supported_features, VDPA_ATTR_PAD)) {
>                 err = -EMSGSIZE;
>                 goto msg_err;
> @@ -827,7 +827,7 @@ static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
>  static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *msg)
>  {
>         struct virtio_net_config config = {};
> -       u64 features;
> +       u64 features_device, features_driver;
>         u16 val_u16;
>
>         vdpa_get_config_unlocked(vdev, 0, &config, sizeof(config));
> @@ -844,12 +844,17 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>         if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
>                 return -EMSGSIZE;
>
> -       features = vdev->config->get_driver_features(vdev);
> -       if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features,
> +       features_driver = vdev->config->get_driver_features(vdev);
> +       if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features_driver,
>                               VDPA_ATTR_PAD))
>                 return -EMSGSIZE;
>
> -       return vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
> +       features_device = vdev->config->get_device_features(vdev);
> +       if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_SUPPORTED_FEATURES, features_device,
> +                             VDPA_ATTR_PAD))
> +               return -EMSGSIZE;
> +
> +       return vdpa_dev_net_mq_config_fill(vdev, msg, features_device, &config);
>  }
>
>  static int
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 1061d8d2d09d..70a3672c288f 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -30,6 +30,7 @@ enum vdpa_attr {
>         VDPA_ATTR_MGMTDEV_BUS_NAME,             /* string */
>         VDPA_ATTR_MGMTDEV_DEV_NAME,             /* string */
>         VDPA_ATTR_MGMTDEV_SUPPORTED_CLASSES,    /* u64 */
> +       VDPA_ATTR_MGMTDEV_SUPPORTED_FEATURES,   /* u64 */
>
>         VDPA_ATTR_DEV_NAME,                     /* string */
>         VDPA_ATTR_DEV_ID,                       /* u32 */
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
