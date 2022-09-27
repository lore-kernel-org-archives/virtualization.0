Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEAD3C54EE9
	for <virtualization@archiver.kernel.org>; Tue, 27 Sep 2022 04:36:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 734B582A0B;
	Tue, 27 Sep 2022 04:36:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 734B582A0B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EoYU1GTl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b-9YpTR8-5gd; Tue, 27 Sep 2022 04:36:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D8CA18295A;
	Tue, 27 Sep 2022 04:36:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D8CA18295A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7E21C0032;
	Tue, 27 Sep 2022 04:36:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACD56C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:36:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 81FBE60F95
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:36:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 81FBE60F95
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EoYU1GTl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VbkpdYOYW7h0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:36:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6A26F60B27
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6A26F60B27
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664253384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cevU8AGgg8wT6F+JiTBLVu2Cozz4uni7iYpojx9WbgM=;
 b=EoYU1GTlf+iu+k2K6RogSnvbsrGm76NO8RB+qcw1y4xLc7IMxs8AQfIfP6wDEPDS98399k
 UdlgNeh3dRI+gptos9dpoU8I2OwnBh+lrkrfKQuxWbC/wdz5ig8fUy7+goT1d9fB1azGg0
 OMzDQ5FkXJ1jsa+aYLIMkIZf0smRSsg=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-296-whlFRcZ4O5ybhllkePP8oQ-1; Tue, 27 Sep 2022 00:36:21 -0400
X-MC-Unique: whlFRcZ4O5ybhllkePP8oQ-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-126bb355560so3100444fac.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 21:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=cevU8AGgg8wT6F+JiTBLVu2Cozz4uni7iYpojx9WbgM=;
 b=2qO549l+yQrq8KvHbDWwHDY/DFpZnmPjAKXjb4sik3nrSFzzMWqXMBJ7NW4PEQ3DWa
 QPMWnW/621drWsY14BzmSlcXbAU58GswvGmSoM46F+pBbTImkFmTMCmiho4UOcw2VjLu
 xmdmzfYwIdBu82z3OKf3Mwh7gqE1hJxPy8unqFeo9tywyZEU+KbrEjHY+icO9WOsnlzE
 LmqlyGQqZbXYcb93aUBm7je9Mpp4toHdYMDk7YUautfwenpHe5l74AJDPbwcN8+1Buv2
 2emL1JxZyS3RONDeLnhQd5SORjCk6NaDv/mLOUjkTUit8OHAy7aXUxVVvdBmUbPAa1yO
 LtOA==
X-Gm-Message-State: ACrzQf3E/G92SobI24BiwfBtyIbyQ1j1H5RT6hYOauz4RRjt2KcOJGlH
 51rxQMyHku2GFTSCZe8sOZOEJclDNbxbzqZqhkFstR/ZxCECAk8nbHXE8qfWQiDQ7P+Tv5nvYQd
 0XSWhTT8Zd0i87eh1BV6Y2rM/uaxJIh55izd6MsJF7O8JQXe0HYdueyBntw==
X-Received: by 2002:a05:6808:1304:b0:350:649b:f8a1 with SMTP id
 y4-20020a056808130400b00350649bf8a1mr925952oiv.280.1664253380085; 
 Mon, 26 Sep 2022 21:36:20 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6eScg1+ZuTPxQSBddzJb4AcPvIc4CSkxqEX+Sr+/R6Jx4TE1Ey4SK8L/pA9rZ+wxr44DnmzkArFrc2KBjWw74=
X-Received: by 2002:a05:6808:1304:b0:350:649b:f8a1 with SMTP id
 y4-20020a056808130400b00350649bf8a1mr925940oiv.280.1664253379747; Mon, 26 Sep
 2022 21:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220927030117.5635-1-lingshan.zhu@intel.com>
 <20220927030117.5635-2-lingshan.zhu@intel.com>
In-Reply-To: <20220927030117.5635-2-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Sep 2022 12:36:08 +0800
Message-ID: <CACGkMEtDmG=YvcVcvO1c371sk5wvz+UO1i4keZXA2f4PrXzXBg@mail.gmail.com>
Subject: Re: [PATCH V2 RESEND 1/6] vDPA: allow userspace to query features of
 a vDPA device
To: Zhu Lingshan <lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 kvm@vger.kernel.org, mst@redhat.com
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

On Tue, Sep 27, 2022 at 11:09 AM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>
> This commit adds a new vDPA netlink attribution
> VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES. Userspace can query
> features of vDPA devices through this new attr.
>
> This commit invokes vdpa_config_ops.get_config()
> rather than vdpa_get_config_unlocked() to read
> the device config spcae, so no races in
> vdpa_set_features_unlocked()
>
> Userspace tool iproute2 example:
> $ vdpa dev config show vdpa0
> vdpa0: mac 00:e8:ca:11:be:05 link up link_announce false max_vq_pairs 4 mtu 1500
>   negotiated_features MRG_RXBUF CTRL_VQ MQ VERSION_1 ACCESS_PLATFORM
>   dev_features MTU MAC MRG_RXBUF CTRL_VQ MQ ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  drivers/vdpa/vdpa.c       | 17 ++++++++++++-----
>  include/uapi/linux/vdpa.h |  4 ++++
>  2 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index c06c02704461..2035700d6fc8 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -491,6 +491,7 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *m
>                 err = -EMSGSIZE;
>                 goto msg_err;
>         }
> +

Nit: Unnecessary changes.

>         if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_SUPPORTED_FEATURES,
>                               mdev->supported_features, VDPA_ATTR_PAD)) {
>                 err = -EMSGSIZE;
> @@ -815,10 +816,10 @@ static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
>  static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *msg)
>  {
>         struct virtio_net_config config = {};
> -       u64 features;
> +       u64 features_device, features_driver;
>         u16 val_u16;
>
> -       vdpa_get_config_unlocked(vdev, 0, &config, sizeof(config));
> +       vdev->config->get_config(vdev, 0, &config, sizeof(config));
>
>         if (nla_put(msg, VDPA_ATTR_DEV_NET_CFG_MACADDR, sizeof(config.mac),
>                     config.mac))
> @@ -832,12 +833,18 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>         if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
>                 return -EMSGSIZE;
>
> -       features = vdev->config->get_driver_features(vdev);
> -       if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features,
> +       features_driver = vdev->config->get_driver_features(vdev);
> +       if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features_driver,
> +                             VDPA_ATTR_PAD))
> +               return -EMSGSIZE;

It looks to me that those parts were removed in patch 2. I wonder if
it's better to reorder the patch to let patch 2 come first?

Thanks

> +
> +       features_device = vdev->config->get_device_features(vdev);
> +
> +       if (nla_put_u64_64bit(msg, VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES, features_device,
>                               VDPA_ATTR_PAD))
>                 return -EMSGSIZE;
>
> -       return vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
> +       return vdpa_dev_net_mq_config_fill(vdev, msg, features_driver, &config);
>  }
>
>  static int
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 25c55cab3d7c..07474183fdb3 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -46,12 +46,16 @@ enum vdpa_attr {
>
>         VDPA_ATTR_DEV_NEGOTIATED_FEATURES,      /* u64 */
>         VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,          /* u32 */
> +       /* virtio features that are supported by the vDPA management device */
>         VDPA_ATTR_DEV_SUPPORTED_FEATURES,       /* u64 */
>
>         VDPA_ATTR_DEV_QUEUE_INDEX,              /* u32 */
>         VDPA_ATTR_DEV_VENDOR_ATTR_NAME,         /* string */
>         VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
>
> +       /* virtio features that are supported by the vDPA device */
> +       VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES,  /* u64 */
> +
>         /* new attributes must be added above here */
>         VDPA_ATTR_MAX,
>  };
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
