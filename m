Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D621C54EE9
	for <virtualization@archiver.kernel.org>; Tue, 27 Sep 2022 04:37:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1184B418A4;
	Tue, 27 Sep 2022 04:37:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1184B418A4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cHAs0XKz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wjVea-vmXfN4; Tue, 27 Sep 2022 04:37:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 313614188A;
	Tue, 27 Sep 2022 04:37:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 313614188A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13D51C0032;
	Tue, 27 Sep 2022 04:37:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95326C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:37:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6DEC2405FA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:37:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6DEC2405FA
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cHAs0XKz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3p_h_TFCr_GN
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:37:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ADC64400C6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ADC64400C6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664253467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sofFyJdbvbK1Y4hSW2SV/YKhYdmhwl/R+C1JaEp10aY=;
 b=cHAs0XKzcz794RcVrq+kVpXxM52nmwJTCJ+ohrfjlV0YfZGKq+5XMOXt5v91wGbtSDjy/K
 NvOiBtY47igOeKKnHfq2MaSCyagc8V8Cv72dKxz7M5eG0I7AjGo+MpBP4QBtnwgXh4HM0J
 s6C/zu4VFC2TnQzwgka0sZfr9URdMnw=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-371-EKswiQq4M2C4lbEKQZWwOA-1; Tue, 27 Sep 2022 00:37:44 -0400
X-MC-Unique: EKswiQq4M2C4lbEKQZWwOA-1
Received: by mail-oi1-f199.google.com with SMTP id
 q184-20020acaf2c1000000b003432f020449so2827942oih.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 21:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=sofFyJdbvbK1Y4hSW2SV/YKhYdmhwl/R+C1JaEp10aY=;
 b=hJNJV4Bjt39D3yBgc9nwFw1CPeREEk3eQvn/0BuvzTQiYUTy80pXxTdrxHpywYVwjE
 yp1UtxY67FW/UTir2gqAxwOYEQPZie0TSz9UIo50Fp1B425QrvO9/X4D2HHq4ZXSM7di
 vmqi99T3DbNiZql9JuuZ9NsAuLD8xV99asH+CyMjxXg0QOHuglaGz+kwHDoTWuFA+ljD
 QJgToj7DQPYg86Ow4pTsZbPqwz66M3NmeWWWsVCpS0infwvDr8FlRCFotNnylHipZaKu
 y7a0iA+vxZ+tEwYaIltJKSvgfeSgjexoIPogUv8/chWC+BiT2pvp2/Sm4QHHOj97BXNm
 bkCA==
X-Gm-Message-State: ACrzQf0Xl71/SujxTWub/ThUHfbBbBc5QYK9ujj8dkAaSV6u38yySf9i
 H31N8uuySWAS/6iBfPHFdi8cthPHx4r7Ds95RBNDyLn8baZ/B7w/PdV7+MRYqNlvrjpy/q+dZmF
 at46cv0rfrYM3M+CO4PybMiAn4QmGrHEXFwqKABJjgWiO4FsSerjgIQBYQQ==
X-Received: by 2002:a05:6808:1b22:b0:350:c0f6:70ff with SMTP id
 bx34-20020a0568081b2200b00350c0f670ffmr947204oib.35.1664253463347; 
 Mon, 26 Sep 2022 21:37:43 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5NQ5K7xZtBDHnh4CyOgOgqK3Ra+fOLEtOeFx402OqNNCn9xWF7xqyeiAntmL+PTACBi+4aqvMfh1lSBTp+AsI=
X-Received: by 2002:a05:6808:1b22:b0:350:c0f6:70ff with SMTP id
 bx34-20020a0568081b2200b00350c0f670ffmr947197oib.35.1664253463161; Mon, 26
 Sep 2022 21:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220927030117.5635-1-lingshan.zhu@intel.com>
 <20220927030117.5635-3-lingshan.zhu@intel.com>
In-Reply-To: <20220927030117.5635-3-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Sep 2022 12:37:32 +0800
Message-ID: <CACGkMEsioquc=hVe0D87UjZkaZ1m3B-g1hXAAyq6bHD=Fc0uFQ@mail.gmail.com>
Subject: Re: [PATCH V2 RESEND 2/6] vDPA: only report driver features if
 FEATURES_OK is set
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
> This commit reports driver features to user space
> only after FEATURES_OK is features negotiation is done.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  drivers/vdpa/vdpa.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 2035700d6fc8..e7765953307f 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -816,7 +816,7 @@ static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
>  static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *msg)
>  {
>         struct virtio_net_config config = {};
> -       u64 features_device, features_driver;
> +       u64 features_device;
>         u16 val_u16;
>
>         vdev->config->get_config(vdev, 0, &config, sizeof(config));
> @@ -833,11 +833,6 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>         if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
>                 return -EMSGSIZE;
>
> -       features_driver = vdev->config->get_driver_features(vdev);
> -       if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features_driver,
> -                             VDPA_ATTR_PAD))
> -               return -EMSGSIZE;
> -
>         features_device = vdev->config->get_device_features(vdev);
>
>         if (nla_put_u64_64bit(msg, VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES, features_device,
> @@ -851,6 +846,8 @@ static int
>  vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq,
>                      int flags, struct netlink_ext_ack *extack)
>  {
> +       u64 features_driver;
> +       u8 status = 0;
>         u32 device_id;
>         void *hdr;
>         int err;
> @@ -874,6 +871,19 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
>                 goto msg_err;
>         }
>
> +       /* only read driver features after the feature negotiation is done */
> +       if (vdev->config->get_status)
> +               status = vdev->config->get_status(vdev);

get_status is mandatory, so I think we can remove this check.

Or if you want a strict check on the config operations, we need to do
that in __vdpa_alloc_device().

Thanks

> +
> +       if (status & VIRTIO_CONFIG_S_FEATURES_OK) {
> +               features_driver = vdev->config->get_driver_features(vdev);
> +               if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features_driver,
> +                                     VDPA_ATTR_PAD)) {
> +                       err = -EMSGSIZE;
> +                       goto msg_err;
> +               }
> +       }
> +
>         switch (device_id) {
>         case VIRTIO_ID_NET:
>                 err = vdpa_dev_net_config_fill(vdev, msg);
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
