Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025A7C43334
	for <virtualization@archiver.kernel.org>; Wed, 13 Jul 2022 05:31:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C9AD6132C;
	Wed, 13 Jul 2022 05:31:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6C9AD6132C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I2Zc07Xc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X8bAvpoFaoY9; Wed, 13 Jul 2022 05:31:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D10856132A;
	Wed, 13 Jul 2022 05:31:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D10856132A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2E0BC0033;
	Wed, 13 Jul 2022 05:31:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67A24C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 05:31:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3B24641146
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 05:31:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3B24641146
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=I2Zc07Xc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3cxe9vN9_esy
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 05:31:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 713534010C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 713534010C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 05:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657690294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jy/furYsDwrNodw4Nu9ZNCwDIYPw0par1/S1mi+rDBY=;
 b=I2Zc07Xc8Mf0VAWBP61NKV0wfgzC5NDyN+192d0/Amm8cCjNC45LtLqgMcaND+pwRDF3B3
 w5CHwgT8J9hgROvoBS7c7MsUUASl6vFKp1RDXv9lYPwnDmSToZAHWQHoWVLoK3vsNKPRLz
 /c6HW7b4GDZ8xKeG5k/tHIZXg6S16gE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-UP8pY_prMrqze2Et63ldPA-1; Wed, 13 Jul 2022 01:31:31 -0400
X-MC-Unique: UP8pY_prMrqze2Et63ldPA-1
Received: by mail-wm1-f69.google.com with SMTP id
 r206-20020a1c44d7000000b003a2cfab0839so4720197wma.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 22:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Jy/furYsDwrNodw4Nu9ZNCwDIYPw0par1/S1mi+rDBY=;
 b=lfFjBtkF/fjXIRZ9TVhBcmJiXZPbnRDNTnqUwZGpgU3zIIRGKR1bDcKgE1SMWxIHix
 /AJuldWsTmns1S/VT0/uSCVtJvTQ/N7qUX0px5w5WWBf/yfDUoGL1/jxf4CHNVvMTkF3
 GYWinjIf5Dh3N91p3F3sfSlXnRfA4BZ5ijpy7vsGxcc2eCixetRH4JoMOqmliYO1Ornb
 DDRdVI8dIu52bZvQxT0waS5cTOcBnI74se26YBpLYwKZikU6BOZ3kcxjT+qL3IvjdR3b
 xe+vqyO3VcQlYHm0PjrdgWlPJ0nVdE5EKXEjCfZuDQq166fb7qefHbxgZZc7wI93z6dL
 d1xw==
X-Gm-Message-State: AJIora8ojMa4sSKiAvcmddJeKEUskE47spFhLe/UbGmD/JlhBan1Wfq9
 dI/w5bFP67tQlVULuAiMGZX4+khg+d2JQBZ3py0ggvfUqFU9+/iR81kt23xvKokcma6Erb0NJRA
 NYamtlJkfz63Ur5EyG8bbZDnCNv5SnThH8kMxwGTX1Q==
X-Received: by 2002:a5d:5d88:0:b0:21d:9ba5:d2c5 with SMTP id
 ci8-20020a5d5d88000000b0021d9ba5d2c5mr1297537wrb.717.1657690289918; 
 Tue, 12 Jul 2022 22:31:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vYcXqU7V7hxYQX03o3NQqUyIgbpwEqM9ueULOltT2Jq1yq1UPTP2N90oNm6slLYomX9gDv7w==
X-Received: by 2002:a5d:5d88:0:b0:21d:9ba5:d2c5 with SMTP id
 ci8-20020a5d5d88000000b0021d9ba5d2c5mr1297524wrb.717.1657690289660; 
 Tue, 12 Jul 2022 22:31:29 -0700 (PDT)
Received: from redhat.com ([2.52.24.42]) by smtp.gmail.com with ESMTPSA id
 r18-20020a05600c35d200b003a2d0f0ccaesm927840wmq.34.2022.07.12.22.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Jul 2022 22:31:29 -0700 (PDT)
Date: Wed, 13 Jul 2022 01:31:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH V3 1/6] vDPA/ifcvf: get_config_size should return a value
 no greater than dev implementation
Message-ID: <20220713012944-mutt-send-email-mst@kernel.org>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-2-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20220701132826.8132-2-lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, gautam.dawar@amd.com
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

On Fri, Jul 01, 2022 at 09:28:21PM +0800, Zhu Lingshan wrote:
> ifcvf_get_config_size() should return a virtio device type specific value,
> however the ret_value should not be greater than the onboard size of
> the device implementation. E.g., for virtio_net, config_size should be
> the minimum value of sizeof(struct virtio_net_config) and the onboard
> cap size.
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
>  			break;
>  		case VIRTIO_PCI_CAP_DEVICE_CFG:
>  			hw->dev_cfg = get_cap_addr(hw, &cap);
> +			hw->cap_dev_config_size = le32_to_cpu(cap.length);
>  			IFCVF_DBG(pdev, "hw->dev_cfg = %p\n", hw->dev_cfg);
>  			break;
>  		}
> @@ -233,15 +234,23 @@ int ifcvf_verify_min_features(struct ifcvf_hw *hw, u64 features)
>  u32 ifcvf_get_config_size(struct ifcvf_hw *hw)
>  {
>  	struct ifcvf_adapter *adapter;
> +	u32 net_config_size = sizeof(struct virtio_net_config);
> +	u32 blk_config_size = sizeof(struct virtio_blk_config);
> +	u32 cap_size = hw->cap_dev_config_size;
>  	u32 config_size;
>  
>  	adapter = vf_to_adapter(hw);
> +	/* If the onboard device config space size is greater than
> +	 * the size of struct virtio_net/blk_config, only the spec
> +	 * implementing contents size is returned, this is very
> +	 * unlikely, defensive programming.
> +	 */
>  	switch (hw->dev_type) {
>  	case VIRTIO_ID_NET:
> -		config_size = sizeof(struct virtio_net_config);
> +		config_size = cap_size >= net_config_size ? net_config_size : cap_size;
>  		break;
>  	case VIRTIO_ID_BLOCK:
> -		config_size = sizeof(struct virtio_blk_config);
> +		config_size = cap_size >= blk_config_size ? blk_config_size : cap_size;
>  		break;
>  	default:
>  		config_size = 0;

There's a min macro for this.

> diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
> index 115b61f4924b..f5563f665cc6 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_base.h
> +++ b/drivers/vdpa/ifcvf/ifcvf_base.h
> @@ -87,6 +87,8 @@ struct ifcvf_hw {
>  	int config_irq;
>  	int vqs_reused_irq;
>  	u16 nr_vring;
> +	/* VIRTIO_PCI_CAP_DEVICE_CFG size */
> +	u32 cap_dev_config_size;
>  };
>  
>  struct ifcvf_adapter {
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
