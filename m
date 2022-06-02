Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF03DC43334
	for <virtualization@archiver.kernel.org>; Thu,  2 Jun 2022 07:11:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4071C40025;
	Thu,  2 Jun 2022 07:11:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MlshHIibT8WV; Thu,  2 Jun 2022 07:11:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DED4C40526;
	Thu,  2 Jun 2022 07:11:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE682C0039;
	Thu,  2 Jun 2022 07:11:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1D68C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 07:11:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B939D410E6
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 07:11:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7ihvCAZMnDF1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 07:11:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 60D7A4097D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 07:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654153882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LQg4+c50YvWCQtzqLAPVbSBhXMgvtlCDtHeV4wCuhWA=;
 b=IPnbga4SZ5xm6QvihvzsH1BYuu5p66p1RkSyGueiCKGyPwkvVnr3HEqc4XI8nu0TU8iT1e
 zjkN1LDMpx1oVPbmrHpQISDEGraTS/gBCLhEGsc8DySkBi3w95hYHvo5ogT+RmvV1ieq40
 +3t36lLjLqBUrV1zM85EkDkwrCFEbh4=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-WCeNxzFIODGLapiTy_OkKA-1; Thu, 02 Jun 2022 03:11:21 -0400
X-MC-Unique: WCeNxzFIODGLapiTy_OkKA-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-30026cf9af8so36138197b3.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Jun 2022 00:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LQg4+c50YvWCQtzqLAPVbSBhXMgvtlCDtHeV4wCuhWA=;
 b=yH0D5po1eLYEyOsJpMGSiWZuXGNECcmCn+dea8qLbZ2zo70spF339Vz6GVYOkGu93P
 P5sJ82hdzk9nZ5R3yoJZ1iymR3tHnjbrIOoIEyvHGsRdg2EE/HwSvVT45TJ/Yc5mYuxB
 jx9mCWQyaLp6iAlKj3V6m/80+00zuzBqXNpUzLd6Xg45jM5zYXERitfEv0kBmdH9P4u0
 uAzR1ZpWdBBgl45RFHND3ZRfHvMIqgduUKawzlPVi7q1qN0dSq9H01BYBbHFie+x0x27
 HlnsrKOVmGTmGwBADUbV02f1zCTYypqu0P64aRFNt/2OtY6biQYsbXwp3LZ/ZeqonRF4
 V7MQ==
X-Gm-Message-State: AOAM5331FYBSE8wudB8wrIsXtxFPTI/OFGDZTn8SlEz67KlDfpANKN2P
 hXUmMU2N56a++oi2PhGw/gnKfMkHDtlfjoTK/OH+HgjuL7COS9J1G98xkOlwPgsqwo1ER857cMK
 OuLPVlw2ydmd//jTpwP5C4O7xj4FVyI5xoXp32rve9Wh+eQ7hp+YvkYjmmQ==
X-Received: by 2002:a25:2256:0:b0:65d:4d94:17c7 with SMTP id
 i83-20020a252256000000b0065d4d9417c7mr3660445ybi.173.1654153880495; 
 Thu, 02 Jun 2022 00:11:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbq8mjNNskHu3ozeHpHlg+DaZHTBjyfJsEZXunCVoF4eQaVmhhytLgz9Ko+0MwYH/GiB6jkyIDuIrxlLkS4i8=
X-Received: by 2002:a25:2256:0:b0:65d:4d94:17c7 with SMTP id
 i83-20020a252256000000b0065d4d9417c7mr3660430ybi.173.1654153880277; Thu, 02
 Jun 2022 00:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220602023845.2596397-1-lingshan.zhu@intel.com>
 <20220602023845.2596397-2-lingshan.zhu@intel.com>
In-Reply-To: <20220602023845.2596397-2-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Jun 2022 15:11:09 +0800
Message-ID: <CACGkMEsdKaWjmOncpLo1MO1DM2KDpE61KbH8uKBrnCqCxFubvw@mail.gmail.com>
Subject: Re: [PATCH 1/6] vDPA/ifcvf: get_config_size should return a value no
 greater than dev implementation
To: Zhu Lingshan <lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>,
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
> ifcvf_get_config_size() should return a virtio device type specific value,
> however the ret_value should not be greater than the onboard size of
> the device implementation. E.g., for virtio_net, config_size should be
> the minimum value of sizeof(struct virtio_net_config) and the onboard
> cap size.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  drivers/vdpa/ifcvf/ifcvf_base.c | 8 ++++++--
>  drivers/vdpa/ifcvf/ifcvf_base.h | 2 ++
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
> index 48c4dadb0c7c..6bccc8291c26 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_base.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_base.c
> @@ -128,6 +128,7 @@ int ifcvf_init_hw(struct ifcvf_hw *hw, struct pci_dev *pdev)
>                         break;
>                 case VIRTIO_PCI_CAP_DEVICE_CFG:
>                         hw->dev_cfg = get_cap_addr(hw, &cap);
> +                       hw->cap_dev_config_size = le32_to_cpu(cap.length);

One possible issue here is that, if the hardware have more size than
spec, we may end up with a migration compatibility issue.

It looks to me we'd better build the config size based on the
features, e.g it looks to me for net, we should probably use

offset_of(struct virtio_net_config, mtu)?

>                         IFCVF_DBG(pdev, "hw->dev_cfg = %p\n", hw->dev_cfg);
>                         break;
>                 }
> @@ -233,15 +234,18 @@ int ifcvf_verify_min_features(struct ifcvf_hw *hw, u64 features)
>  u32 ifcvf_get_config_size(struct ifcvf_hw *hw)
>  {
>         struct ifcvf_adapter *adapter;
> +       u32 net_config_size = sizeof(struct virtio_net_config);
> +       u32 blk_config_size = sizeof(struct virtio_blk_config);
> +       u32 cap_size = hw->cap_dev_config_size;
>         u32 config_size;
>
>         adapter = vf_to_adapter(hw);
>         switch (hw->dev_type) {
>         case VIRTIO_ID_NET:
> -               config_size = sizeof(struct virtio_net_config);
> +               config_size = cap_size >= net_config_size ? net_config_size : cap_size;

I don't get the code here, any chance that net_config_size could be zero?

Thanks

>                 break;
>         case VIRTIO_ID_BLOCK:
> -               config_size = sizeof(struct virtio_blk_config);
> +               config_size = cap_size >= blk_config_size ? blk_config_size : cap_size;
>                 break;
>         default:
>                 config_size = 0;
> diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
> index 115b61f4924b..f5563f665cc6 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_base.h
> +++ b/drivers/vdpa/ifcvf/ifcvf_base.h
> @@ -87,6 +87,8 @@ struct ifcvf_hw {
>         int config_irq;
>         int vqs_reused_irq;
>         u16 nr_vring;
> +       /* VIRTIO_PCI_CAP_DEVICE_CFG size */
> +       u32 cap_dev_config_size;
>  };
>
>  struct ifcvf_adapter {
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
