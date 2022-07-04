Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A23C433EF
	for <virtualization@archiver.kernel.org>; Mon,  4 Jul 2022 04:39:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69021826E7;
	Mon,  4 Jul 2022 04:39:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 69021826E7
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fKWP1eFk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bm6QI9JfKp7z; Mon,  4 Jul 2022 04:39:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C0D1D826C0;
	Mon,  4 Jul 2022 04:39:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C0D1D826C0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92590C0032;
	Mon,  4 Jul 2022 04:39:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CB2DC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 04:39:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B0BC860A80
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 04:39:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B0BC860A80
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fKWP1eFk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xRw3o3wxYc8r
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 04:39:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BA5AB60888
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BA5AB60888
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 04:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656909591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=34NQkLuDu70RYtu7A5zt/ESnLEXxvA0x7SQgJUnytlU=;
 b=fKWP1eFkNvo4NO3XlPf+y5I1ImPLwGF6dsZ4obd0lgIDO47/tlnmIfXgsuTb9ZNycuSYsb
 E/FPBamyia4TWxOt7mCvv900N89imtZXMi8gBcAG37WytGH9XurzaWu8YswmQhA0rl44XM
 47i15M3wmLlHGI9R4lqYcLmdLJtiN6A=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-G7dp3oUDMpKdCtZNmHNicg-1; Mon, 04 Jul 2022 00:39:48 -0400
X-MC-Unique: G7dp3oUDMpKdCtZNmHNicg-1
Received: by mail-lj1-f197.google.com with SMTP id
 m8-20020a2eb6c8000000b0025aa0530107so2385013ljo.6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 03 Jul 2022 21:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=34NQkLuDu70RYtu7A5zt/ESnLEXxvA0x7SQgJUnytlU=;
 b=Z4GEbypqR35SNqvUEYFBzPfnPFoStZ/MdE9pl3LrmLcE9bHw93eDnNO5dxVy6ffTzI
 ja5xOik11Ys+JFYNe2SUO+DuhOUsZPIaHU8/Nx/bvToT9e7f/AdBiv+RvUnsTmkvK/xJ
 MAE5+spmCy4t48PChQ+izO1D26Z+AhWVi3qyJ9SsYC4dE7uPuFoqkW/ZQusMGiTPyZ6J
 szvUfcEdmFsgRIrasutgyiQ7EF/2DmLXUOWhPq2METxklRFs4pFnqCQRDlGtobGq8hpw
 MCMxSgrGPqBI/RaJ5X0qrtbcRoqgnYH2SoEAFTI/pW3SRorP+gChkmeO+vICAeWsqyAD
 4XmA==
X-Gm-Message-State: AJIora9Lpv+cXzU3BbeimQhpKjYiEOyUl9L9c5TuS5wVeOV1uMf4WbLz
 LfcnuAZX9Hq4ncLJ3FR0HxLWQVd5ircsgQg/XU3osvNt0LQV3CJW9xkHwKE7ulduiQxqn2Tl9fn
 UpzV9hwBB7Wi1I4lmcUekoqL8StWVSPCsBObpLbPMqLQWkTOcbYEJTsdhJw==
X-Received: by 2002:a05:6512:b0d:b0:481:5cb4:cf1e with SMTP id
 w13-20020a0565120b0d00b004815cb4cf1emr10153638lfu.442.1656909586924; 
 Sun, 03 Jul 2022 21:39:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sbGuL+fn0YCwy3PFvwHzJchJaTph3jj60D8dfYlVR8XTdiZAzAbGETkaVrvpPHFEGBOLc9W/txx60ltVFAKow=
X-Received: by 2002:a05:6512:b0d:b0:481:5cb4:cf1e with SMTP id
 w13-20020a0565120b0d00b004815cb4cf1emr10153626lfu.442.1656909586743; Sun, 03
 Jul 2022 21:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-2-lingshan.zhu@intel.com>
In-Reply-To: <20220701132826.8132-2-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 4 Jul 2022 12:39:35 +0800
Message-ID: <CACGkMEvGo2urfPriS3f6dCxT+41KJ0E-KUd4-GvUrX81BVy8Og@mail.gmail.com>
Subject: Re: [PATCH V3 1/6] vDPA/ifcvf: get_config_size should return a value
 no greater than dev implementation
To: Zhu Lingshan <lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>, netdev <netdev@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yongji Xie <xieyongji@bytedance.com>, "Dawar, Gautam" <gautam.dawar@amd.com>
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

On Fri, Jul 1, 2022 at 9:36 PM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>
> ifcvf_get_config_size() should return a virtio device type specific value,
> however the ret_value should not be greater than the onboard size of
> the device implementation. E.g., for virtio_net, config_size should be
> the minimum value of sizeof(struct virtio_net_config) and the onboard
> cap size.

Rethink of this, I wonder what's the value of exposing device
implementation details to users? Anyhow the parent is in charge of
"emulating" config space accessing.

If we do this, it's probably a blocker for cross vendor stuff.

Thanks

>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  drivers/vdpa/ifcvf/ifcvf_base.c | 13 +++++++++++--
>  drivers/vdpa/ifcvf/ifcvf_base.h |  2 ++
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
> index 48c4dadb0c7c..fb957b57941e 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_base.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_base.c
> @@ -128,6 +128,7 @@ int ifcvf_init_hw(struct ifcvf_hw *hw, struct pci_dev *pdev)
>                         break;
>                 case VIRTIO_PCI_CAP_DEVICE_CFG:
>                         hw->dev_cfg = get_cap_addr(hw, &cap);
> +                       hw->cap_dev_config_size = le32_to_cpu(cap.length);
>                         IFCVF_DBG(pdev, "hw->dev_cfg = %p\n", hw->dev_cfg);
>                         break;
>                 }
> @@ -233,15 +234,23 @@ int ifcvf_verify_min_features(struct ifcvf_hw *hw, u64 features)
>  u32 ifcvf_get_config_size(struct ifcvf_hw *hw)
>  {
>         struct ifcvf_adapter *adapter;
> +       u32 net_config_size = sizeof(struct virtio_net_config);
> +       u32 blk_config_size = sizeof(struct virtio_blk_config);
> +       u32 cap_size = hw->cap_dev_config_size;
>         u32 config_size;
>
>         adapter = vf_to_adapter(hw);
> +       /* If the onboard device config space size is greater than
> +        * the size of struct virtio_net/blk_config, only the spec
> +        * implementing contents size is returned, this is very
> +        * unlikely, defensive programming.
> +        */
>         switch (hw->dev_type) {
>         case VIRTIO_ID_NET:
> -               config_size = sizeof(struct virtio_net_config);
> +               config_size = cap_size >= net_config_size ? net_config_size : cap_size;
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
