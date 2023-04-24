Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC96BC77B61
	for <virtualization@archiver.kernel.org>; Mon, 24 Apr 2023 04:50:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 27B064061C;
	Mon, 24 Apr 2023 04:50:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 27B064061C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KuC3XS5C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wjGLyWlZlJWS; Mon, 24 Apr 2023 04:50:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 021AE40156;
	Mon, 24 Apr 2023 04:50:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 021AE40156
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BABD0C0036;
	Mon, 24 Apr 2023 04:50:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9453BC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 04:50:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 682A981E69
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 04:50:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 682A981E69
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KuC3XS5C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tPw8q-FzLYuU
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 04:50:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD8E381E67
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CD8E381E67
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 04:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682311845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v2KW6ALnrKziBymlq5HY7eIcLgfsLxfxp5q46NVvhuY=;
 b=KuC3XS5COUsQkNgypGd/83JnS9zRz+xDNeqUzGVs0Ny6l4377PDyttPr4ptqx+62+GcQhJ
 ocr6iFJArXkENaqko1wvW1tHuzNxCNeHk9+IvKu2vyzD2BbWNz4fgO2mgIU5YDW1Up1+eF
 JOPIcRkqqnL7Jr2dMPUZRglAqtMCHOA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-filJbx2POkKYyppDe8hS7w-1; Mon, 24 Apr 2023 00:50:43 -0400
X-MC-Unique: filJbx2POkKYyppDe8hS7w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f1912ed0daso10110165e9.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 21:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682311842; x=1684903842;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v2KW6ALnrKziBymlq5HY7eIcLgfsLxfxp5q46NVvhuY=;
 b=RFIt1q2q0TRjJXLSPcAKVXtdoSTQFXuZExYtROHkCU1635R/2j9cs6yWGWZ4oTYFXZ
 THqlPrAAM05ZH/SHtaG6VBEZdXxEut5zzhjILXT2WgwatouXt+zNxl9n8TKH2uFi5tQU
 4uMclZrd9aMsnDvGX4sbjXmyCLrcvDM08jXDNclVTgv2OY2INOxz5F5fWCYlUKfGzDfy
 jxl8NQX3+CHl+NN+N8yunzPbBf/gbRv/ZC1tz1HZLe4wibLdiAAdAvlytq7DtK6NQuhW
 qPa2ymTNJaXw1G7HXYdUVOWRQzl5EywQj/szq/GW2zY0SNTvY89ztBBlSnIAaHR7mTLB
 9Oyg==
X-Gm-Message-State: AAQBX9c/BGdcr1m35djOi1IDQT4+KBsC0NGtnLWAp+iZDlkzNkmtj4j6
 lUW75DsvrozBq5+X6SzQJnY+8XWaJ/neuIp2b0qMXL21HvZ+J5tI9Bs3iuROoFX6akpOMYULvnl
 YkFeRDA2oKrI+VDsP/cEc5e8xpunmwFprv2JxJP3IbQ==
X-Received: by 2002:a05:600c:230b:b0:3f1:738f:d3d1 with SMTP id
 11-20020a05600c230b00b003f1738fd3d1mr6176326wmo.4.1682311842751; 
 Sun, 23 Apr 2023 21:50:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350bc54d8stoEUWzAjd4J3FBudclyWsZ0fB5A8O0K4XfYYf0GJYI3OZt2RpqxIsSCHDqhSRJ0bA==
X-Received: by 2002:a05:600c:230b:b0:3f1:738f:d3d1 with SMTP id
 11-20020a05600c230b00b003f1738fd3d1mr6176320wmo.4.1682311842438; 
 Sun, 23 Apr 2023 21:50:42 -0700 (PDT)
Received: from redhat.com ([2.55.17.255]) by smtp.gmail.com with ESMTPSA id
 n3-20020a7bcbc3000000b003f175b360e5sm11261861wmi.0.2023.04.23.21.50.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Apr 2023 21:50:41 -0700 (PDT)
Date: Mon, 24 Apr 2023 00:50:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH 2/5] get_driver_features from virito registers
Message-ID: <20230424005019-mutt-send-email-mst@kernel.org>
References: <20230331204854.20082-1-lingshan.zhu@intel.com>
 <20230331204854.20082-3-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20230331204854.20082-3-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

subj typo: virtio

On Sat, Apr 01, 2023 at 04:48:51AM +0800, Zhu Lingshan wrote:
> This commit implements a new function ifcvf_get_driver_feature()
> which read driver_features from virtio registers.
> 
> To be less ambiguous, ifcvf_set_features() is renamed to
> ifcvf_set_driver_features(), and ifcvf_get_features()
> is renamed to ifcvf_get_dev_features() which returns
> the provisioned vDPA device features.
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  drivers/vdpa/ifcvf/ifcvf_base.c | 38 +++++++++++++++++----------------
>  drivers/vdpa/ifcvf/ifcvf_base.h |  5 +++--
>  drivers/vdpa/ifcvf/ifcvf_main.c |  9 +++++---
>  3 files changed, 29 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
> index 6c5650f73007..546e923bcd16 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_base.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_base.c
> @@ -204,11 +204,29 @@ u64 ifcvf_get_hw_features(struct ifcvf_hw *hw)
>  	return features;
>  }
>  
> -u64 ifcvf_get_features(struct ifcvf_hw *hw)
> +/* return provisioned vDPA dev features */
> +u64 ifcvf_get_dev_features(struct ifcvf_hw *hw)
>  {
>  	return hw->dev_features;
>  }
>  
> +u64 ifcvf_get_driver_features(struct ifcvf_hw *hw)
> +{
> +	struct virtio_pci_common_cfg __iomem *cfg = hw->common_cfg;
> +	u32 features_lo, features_hi;
> +	u64 features;
> +
> +	vp_iowrite32(0, &cfg->device_feature_select);
> +	features_lo = vp_ioread32(&cfg->guest_feature);
> +
> +	vp_iowrite32(1, &cfg->device_feature_select);
> +	features_hi = vp_ioread32(&cfg->guest_feature);
> +
> +	features = ((u64)features_hi << 32) | features_lo;
> +
> +	return features;
> +}
> +
>  int ifcvf_verify_min_features(struct ifcvf_hw *hw, u64 features)
>  {
>  	if (!(features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)) && features) {
> @@ -275,7 +293,7 @@ void ifcvf_write_dev_config(struct ifcvf_hw *hw, u64 offset,
>  		vp_iowrite8(*p++, hw->dev_cfg + offset + i);
>  }
>  
> -static void ifcvf_set_features(struct ifcvf_hw *hw, u64 features)
> +void ifcvf_set_driver_features(struct ifcvf_hw *hw, u64 features)
>  {
>  	struct virtio_pci_common_cfg __iomem *cfg = hw->common_cfg;
>  
> @@ -286,19 +304,6 @@ static void ifcvf_set_features(struct ifcvf_hw *hw, u64 features)
>  	vp_iowrite32(features >> 32, &cfg->guest_feature);
>  }
>  
> -static int ifcvf_config_features(struct ifcvf_hw *hw)
> -{
> -	ifcvf_set_features(hw, hw->req_features);
> -	ifcvf_add_status(hw, VIRTIO_CONFIG_S_FEATURES_OK);
> -
> -	if (!(ifcvf_get_status(hw) & VIRTIO_CONFIG_S_FEATURES_OK)) {
> -		IFCVF_ERR(hw->pdev, "Failed to set FEATURES_OK status\n");
> -		return -EIO;
> -	}
> -
> -	return 0;
> -}
> -
>  u16 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid)
>  {
>  	struct ifcvf_lm_cfg __iomem *ifcvf_lm;
> @@ -387,9 +392,6 @@ int ifcvf_start_hw(struct ifcvf_hw *hw)
>  	ifcvf_add_status(hw, VIRTIO_CONFIG_S_ACKNOWLEDGE);
>  	ifcvf_add_status(hw, VIRTIO_CONFIG_S_DRIVER);
>  
> -	if (ifcvf_config_features(hw) < 0)
> -		return -EINVAL;
> -
>  	ifcvf_add_status(hw, VIRTIO_CONFIG_S_DRIVER_OK);
>  
>  	return 0;
> diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
> index d545a9411143..cb19196c3ece 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_base.h
> +++ b/drivers/vdpa/ifcvf/ifcvf_base.h
> @@ -69,7 +69,6 @@ struct ifcvf_hw {
>  	phys_addr_t notify_base_pa;
>  	u32 notify_off_multiplier;
>  	u32 dev_type;
> -	u64 req_features;
>  	u64 hw_features;
>  	/* provisioned device features */
>  	u64 dev_features;
> @@ -122,7 +121,7 @@ u8 ifcvf_get_status(struct ifcvf_hw *hw);
>  void ifcvf_set_status(struct ifcvf_hw *hw, u8 status);
>  void io_write64_twopart(u64 val, u32 *lo, u32 *hi);
>  void ifcvf_reset(struct ifcvf_hw *hw);
> -u64 ifcvf_get_features(struct ifcvf_hw *hw);
> +u64 ifcvf_get_dev_features(struct ifcvf_hw *hw);
>  u64 ifcvf_get_hw_features(struct ifcvf_hw *hw);
>  int ifcvf_verify_min_features(struct ifcvf_hw *hw, u64 features);
>  u16 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid);
> @@ -137,4 +136,6 @@ int ifcvf_set_vq_address(struct ifcvf_hw *hw, u16 qid, u64 desc_area,
>  			 u64 driver_area, u64 device_area);
>  bool ifcvf_get_vq_ready(struct ifcvf_hw *hw, u16 qid);
>  void ifcvf_set_vq_ready(struct ifcvf_hw *hw, u16 qid, bool ready);
> +void ifcvf_set_driver_features(struct ifcvf_hw *hw, u64 features);
> +u64 ifcvf_get_driver_features(struct ifcvf_hw *hw);
>  #endif /* _IFCVF_H_ */
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index 1357c67014ab..4588484bd53d 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -410,7 +410,7 @@ static u64 ifcvf_vdpa_get_device_features(struct vdpa_device *vdpa_dev)
>  	u64 features;
>  
>  	if (type == VIRTIO_ID_NET || type == VIRTIO_ID_BLOCK)
> -		features = ifcvf_get_features(vf);
> +		features = ifcvf_get_dev_features(vf);
>  	else {
>  		features = 0;
>  		IFCVF_ERR(pdev, "VIRTIO ID %u not supported\n", vf->dev_type);
> @@ -428,7 +428,7 @@ static int ifcvf_vdpa_set_driver_features(struct vdpa_device *vdpa_dev, u64 feat
>  	if (ret)
>  		return ret;
>  
> -	vf->req_features = features;
> +	ifcvf_set_driver_features(vf, features);
>  
>  	return 0;
>  }
> @@ -436,8 +436,11 @@ static int ifcvf_vdpa_set_driver_features(struct vdpa_device *vdpa_dev, u64 feat
>  static u64 ifcvf_vdpa_get_driver_features(struct vdpa_device *vdpa_dev)
>  {
>  	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
> +	u64 features;
> +
> +	features = ifcvf_get_driver_features(vf);
>  
> -	return vf->req_features;
> +	return features;
>  }
>  
>  static u8 ifcvf_vdpa_get_status(struct vdpa_device *vdpa_dev)
> -- 
> 2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
