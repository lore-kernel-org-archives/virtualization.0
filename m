Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04F5C54EE9
	for <virtualization@archiver.kernel.org>; Tue, 20 Sep 2022 02:18:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3EF5382438;
	Tue, 20 Sep 2022 02:18:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3EF5382438
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RdsQu1qG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id REKgOEiEZ-25; Tue, 20 Sep 2022 02:18:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AF7B982437;
	Tue, 20 Sep 2022 02:18:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AF7B982437
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A00BC0032;
	Tue, 20 Sep 2022 02:18:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58293C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 02:18:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3257860B6E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 02:18:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3257860B6E
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RdsQu1qG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1nfvl6H_HEot
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 02:18:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7460C60B69
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7460C60B69
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 02:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663640288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FEUHTADoR8KlD4DD+fhNieYTMG22Ao1FKlWpqZYIFa0=;
 b=RdsQu1qGBM0NCZhkbgksP2Dq6xgfv6MSCRIzMeWpizm4uCNj+pCZPfP9UKYrTA8p/lnUBU
 vCGaAAMsZqmb1ayPlwF2123LwrEilfeiL1hHSRo7oQpU0Md5EsBisFOPkWfVcyHe5bm/hh
 AAq01wPIHJbi7mRsUv61SeWGZYhjrDE=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-539-QdaxrCcrPf-BB8fnO7lITw-1; Mon, 19 Sep 2022 22:18:07 -0400
X-MC-Unique: QdaxrCcrPf-BB8fnO7lITw-1
Received: by mail-vs1-f71.google.com with SMTP id
 b7-20020a676707000000b0039837174b29so318833vsc.20
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Sep 2022 19:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=FEUHTADoR8KlD4DD+fhNieYTMG22Ao1FKlWpqZYIFa0=;
 b=pv22yZke03DAzZFzpe6qpoleFLaannYXRuR9kRNjNd4SD4FmS+vPObHu+AhRX/9QlL
 QxeVX19tlW02L/xkPPlXxDx7Osj+/ndd/Zs723h6DlrkIvRSpX6P8v42X+cYyfvuA+KU
 +1c8xNxUK1AgXAz/yVXtM+PXSP/ardynkBaY3+kG0YnUkY/SXHHKreCxJYlnPRHMQooU
 /uhRfj14Iu3fgYZPwA89oqsw8RIwueGgUILownohJM7m2UFpmzzQrfxolnW9XVZUZ3cd
 68C/vv2yjpR2zVepQhcgdNK5E6UHCKH/zH/5obBz8q+SOmVVt5CTwT5EODwgOKQr78Hv
 TIaw==
X-Gm-Message-State: ACrzQf2T+RHOz1wgvI6j6gGL17HLmQqGrhRHIw6Qch026+OqRewkps/k
 yQAIhOByRgNNgRp6mGgh5D1YyH3ckX+oIWjoj6xDSKsnY4fncbLiZ2lDUJ+AMd9CzarQCzVbMO/
 KuhIrn2l+RCXA4cD4b0uvUe3lQ+DyeZljaal2m4iCOjcApvWJzUN3cvOweQ==
X-Received: by 2002:a05:6102:1341:b0:398:889e:7f28 with SMTP id
 j1-20020a056102134100b00398889e7f28mr7927484vsl.21.1663640286469; 
 Mon, 19 Sep 2022 19:18:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4aFZxat3rBDo+ydZBqX3GNyuERyeXan0fOqLbRyeIGO/Vie0sDsAXF13Gh5Xuw8CK/4MrpmzAl1kTy+h7rnkM=
X-Received: by 2002:a05:6102:1341:b0:398:889e:7f28 with SMTP id
 j1-20020a056102134100b00398889e7f28mr7927479vsl.21.1663640286262; Mon, 19 Sep
 2022 19:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220909085712.46006-1-lingshan.zhu@intel.com>
 <20220909085712.46006-5-lingshan.zhu@intel.com>
In-Reply-To: <20220909085712.46006-5-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 20 Sep 2022 10:17:55 +0800
Message-ID: <CACGkMEtqi4AZ8ZOv=U9TjswOwVpr32mbi2S7Z6DcayaUrfUeyg@mail.gmail.com>
Subject: Re: [PATCH 4/4] vDPA: Conditionally read MTU and MAC in dev cfg space
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
> The spec says:
> mtu only exists if VIRTIO_NET_F_MTU is set
> The mac address field always exists (though
> is only valid if VIRTIO_NET_F_MAC is set)
>
> So vdpa_dev_net_config_fill() should read MTU and MAC
> conditionally on the feature bits.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>

Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>  drivers/vdpa/vdpa.c | 37 +++++++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index f8ff61232421..b332388d3375 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -815,6 +815,29 @@ static int vdpa_dev_net_mq_config_fill(struct sk_buff *msg, u64 features,
>         return nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, val_u16);
>  }
>
> +static int vdpa_dev_net_mtu_config_fill(struct sk_buff *msg, u64 features,
> +                                       const struct virtio_net_config *config)
> +{
> +       u16 val_u16;
> +
> +       if ((features & BIT_ULL(VIRTIO_NET_F_MTU)) == 0)
> +               return 0;
> +
> +       val_u16 = __virtio16_to_cpu(true, config->mtu);
> +
> +       return nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16);
> +}
> +
> +static int vdpa_dev_net_mac_config_fill(struct sk_buff *msg, u64 features,
> +                                       const struct virtio_net_config *config)
> +{
> +       if ((features & BIT_ULL(VIRTIO_NET_F_MAC)) == 0)
> +               return 0;
> +
> +       return  nla_put(msg, VDPA_ATTR_DEV_NET_CFG_MACADDR,
> +                       sizeof(config->mac), config->mac);
> +}
> +
>  static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *msg)
>  {
>         struct virtio_net_config config = {};
> @@ -824,18 +847,10 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>
>         vdev->config->get_config(vdev, 0, &config, sizeof(config));
>
> -       if (nla_put(msg, VDPA_ATTR_DEV_NET_CFG_MACADDR, sizeof(config.mac),
> -                   config.mac))
> -               return -EMSGSIZE;
> -
>         val_u16 = __virtio16_to_cpu(true, config.status);
>         if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16))
>                 return -EMSGSIZE;
>
> -       val_u16 = __virtio16_to_cpu(true, config.mtu);
> -       if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
> -               return -EMSGSIZE;
> -
>         /* only read driver features after the feature negotiation is done */
>         status = vdev->config->get_status(vdev);
>         if (status & VIRTIO_CONFIG_S_FEATURES_OK) {
> @@ -852,6 +867,12 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>                               VDPA_ATTR_PAD))
>                 return -EMSGSIZE;
>
> +       if (vdpa_dev_net_mtu_config_fill(msg, features_device, &config))
> +               return -EMSGSIZE;
> +
> +       if (vdpa_dev_net_mac_config_fill(msg, features_device, &config))
> +               return -EMSGSIZE;
> +
>         return vdpa_dev_net_mq_config_fill(msg, features_device, &config);
>  }
>
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
