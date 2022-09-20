Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B32DC54EE9
	for <virtualization@archiver.kernel.org>; Tue, 20 Sep 2022 02:03:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BFA1C8242D;
	Tue, 20 Sep 2022 02:03:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BFA1C8242D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dAFUvV2R
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kuLZhTM0snI4; Tue, 20 Sep 2022 02:02:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 96F3B82422;
	Tue, 20 Sep 2022 02:02:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 96F3B82422
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69713C0033;
	Tue, 20 Sep 2022 02:02:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5336C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 02:02:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7BAD040438
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 02:02:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7BAD040438
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dAFUvV2R
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KchPJOZsp64v
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 02:02:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B77BD4041C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B77BD4041C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 02:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663639371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=faCU162X+wI3VyF2nQiop7OG+mfYJ3C8OshE48krBU4=;
 b=dAFUvV2RlyKOopgHtCjvRaAbzSM+QQA7JfwxIPO3S1Uu8ux3VCY5pO4lyon/EELLnQrTIP
 l9Lmz9TSwclU+BtBD7S9QDRfnWZwTQb9QKUC5E1AKrvTtkM+p2q1CDwy9KWmhlKUjvjzo6
 VPDxdsh8gR3t1nNIhNw8n2hdk5XrXr0=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-113-_0-LQLLqMjushE7FpnRlYg-1; Mon, 19 Sep 2022 22:02:50 -0400
X-MC-Unique: _0-LQLLqMjushE7FpnRlYg-1
Received: by mail-vs1-f70.google.com with SMTP id
 m186-20020a6726c3000000b0039b2e2e040dso96017vsm.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Sep 2022 19:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=faCU162X+wI3VyF2nQiop7OG+mfYJ3C8OshE48krBU4=;
 b=yKC8i+CW7LAwjmSE0MsnvDEh9t2MJV5E192W852sjA5TqARthXfo9eXqZfJ8piinRJ
 /uUO4sSTePojo89ne1LDlwT8jyWUyzCWj0joGauExyxA7EM2/67WHl9AeTRvKmiGJcNY
 Y7+ZYhPRyFKyDTFrKBX2gaNckTCW2NglSNVoWVZKb+o7JEDYZevO9mwbKnpm2uenWx52
 hqfaNbMCJrRCMHz5LD0aGn+rIbn8aCThaL9OO1IHELGtsilTyJf0/dty6qnjAZoSocVF
 Dmdc7Es27lSH8GwXAoP99q7g5sNSqjJsEcwoPmZ104EA5psgKfifEedVIleVaMYfZdti
 x7IQ==
X-Gm-Message-State: ACrzQf1FTu+I65E218dwDRwWKsMpiuDyrO6YCLvPvIVhkut/zSYeg8uC
 zi8cRC1PtLNs0Mdv0LblZe7IUSvajo1DbHEElYBVMeDrDDY+PdIAuhctkmgaG/RrQaISzW0nqLR
 9zGj4LkTLkQRpcj5EY7Mh45nG3UF7DSnDWKwlp+PqYe6cqraSWYnk8bhamQ==
X-Received: by 2002:a05:6102:1341:b0:398:889e:7f28 with SMTP id
 j1-20020a056102134100b00398889e7f28mr7912781vsl.21.1663639369324; 
 Mon, 19 Sep 2022 19:02:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7hWThMWApXIHlTE15FM2qB/Cbva+CwsqGmij2/DXcHfy6l4xVdBSPLV7e1pSscJ8wm1BTYnWg+1OnoMnHQnnc=
X-Received: by 2002:a05:6102:1341:b0:398:889e:7f28 with SMTP id
 j1-20020a056102134100b00398889e7f28mr7912778vsl.21.1663639369049; Mon, 19 Sep
 2022 19:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220909085712.46006-1-lingshan.zhu@intel.com>
 <20220909085712.46006-2-lingshan.zhu@intel.com>
In-Reply-To: <20220909085712.46006-2-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 20 Sep 2022 10:02:37 +0800
Message-ID: <CACGkMEsq+weeO7i8KtNNAPhXGwN=cTwWt3RWfTtML-Xwj3K5Qg@mail.gmail.com>
Subject: Re: [PATCH 1/4] vDPA: allow userspace to query features of a vDPA
 device
To: Zhu Lingshan <lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 kvm <kvm@vger.kernel.org>, mst <mst@redhat.com>
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

On Fri, Sep 9, 2022 at 5:05 PM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>
> This commit adds a new vDPA netlink attribution
> VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES. Userspace can query
> features of vDPA devices through this new attr.
>
> This commit invokes vdpa_config_ops.get_config() than
> vdpa_get_config_unlocked() to read the device config
> spcae, so no raeces in vdpa_set_features_unlocked()
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>

It's better to share the userspace code as well.

> ---
>  drivers/vdpa/vdpa.c       | 19 ++++++++++++++-----
>  include/uapi/linux/vdpa.h |  4 ++++
>  2 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index c06c02704461..798a02c7aa94 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -491,6 +491,8 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *m
>                 err = -EMSGSIZE;
>                 goto msg_err;
>         }
> +
> +       /* report features of a vDPA management device through VDPA_ATTR_DEV_SUPPORTED_FEATURES */

The code explains itself, there's no need for the comment.

>         if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_SUPPORTED_FEATURES,
>                               mdev->supported_features, VDPA_ATTR_PAD)) {
>                 err = -EMSGSIZE;
> @@ -815,10 +817,10 @@ static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
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
> @@ -832,12 +834,19 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>         if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
>                 return -EMSGSIZE;
>
> -       features = vdev->config->get_driver_features(vdev);
> -       if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features,
> +       features_driver = vdev->config->get_driver_features(vdev);
> +       if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features_driver,
> +                             VDPA_ATTR_PAD))
> +               return -EMSGSIZE;
> +
> +       features_device = vdev->config->get_device_features(vdev);
> +
> +       /* report features of a vDPA device through VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES */
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
> index 25c55cab3d7c..97531b52dcbe 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -46,12 +46,16 @@ enum vdpa_attr {
>
>         VDPA_ATTR_DEV_NEGOTIATED_FEATURES,      /* u64 */
>         VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,          /* u32 */
> +       /* features of a vDPA management device */
>         VDPA_ATTR_DEV_SUPPORTED_FEATURES,       /* u64 */
>
>         VDPA_ATTR_DEV_QUEUE_INDEX,              /* u32 */
>         VDPA_ATTR_DEV_VENDOR_ATTR_NAME,         /* string */
>         VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
>
> +       /* features of a vDPA device, e.g., /dev/vhost-vdpa0 */
> +       VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES,  /* u64 */

What's the difference between this and VDPA_ATTR_DEV_SUPPORTED_FEATURES?

Thanks

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
