Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C796BC61DA4
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 08:09:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4A29D40150;
	Fri,  3 Feb 2023 08:09:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4A29D40150
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xcjp6ETU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VuGeXVQU9dP9; Fri,  3 Feb 2023 08:09:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A290B400CB;
	Fri,  3 Feb 2023 08:09:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A290B400CB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65D6DC0032;
	Fri,  3 Feb 2023 08:09:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DD4CC002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:09:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4EB0160B8C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:09:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4EB0160B8C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xcjp6ETU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2E5cPoSBvjDz
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:09:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0A59060AE4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0A59060AE4
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675411755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I4jp0pd7nTd2IokMgM4q5yjP1Mu7SicarJFLgTsenx8=;
 b=Xcjp6ETUpczsGu5XGPBoJT3dcbONhU/WiQB7NZ2Jt/Vuh+koe8sGs+x2TD7D6ZzmCJ+dfO
 /cDvP8i12BfVFbGxJnEM2gLlIDH+1V/a6fFraUmzm9qiPxJIWrTMlqsH5X2zOnhWl15mPn
 GnKt+35+zGuY9LNHEYXFxmpkyuw+FEE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-336-Pc58aKyvN_mXeuuSonRWog-1; Fri, 03 Feb 2023 03:09:14 -0500
X-MC-Unique: Pc58aKyvN_mXeuuSonRWog-1
Received: by mail-ej1-f72.google.com with SMTP id
 d14-20020a170906c20e00b00889f989d8deso3353441ejz.15
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Feb 2023 00:09:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I4jp0pd7nTd2IokMgM4q5yjP1Mu7SicarJFLgTsenx8=;
 b=J7SYIva5589lcjiJo+fIUhNr/Axi/F/m2Ys8tL448cxUZ0boQziisDP7AqoIo8Dn1P
 mnH1i+HDoOh340RtQo/bImGYtt37Lpgc2Pg+tuUy7dMrqjiS/kzVyd2k+fxRU4jkmVeG
 poL8psph4ISWSb+II4BGYQIanwDE5m3o08uVgFzrXeCzJPDLnY3IlpyFbXs7MFjhAXvw
 6VkzfhDl22FFATglinMq2G1csICL3/fhSqrgIHsk09ktrEYYH+pKuYHV5j57+gpm5+zh
 uFfFUOacQBEELhXQ+vucuK8fS9R6ZZ+do5LboFwvSCVMFxYn6EyWHyHjKVwny+An0ore
 LlFA==
X-Gm-Message-State: AO0yUKUBhCgMAgcjsw+DMLYwz9i1LtbT962qcLfdI6xHBYcTmPop5iuV
 Rrj7ECdJPfAVeqfBENN8yi4m5RQxYOnI4XpEWvBgyiORiPk5Miro3o4a5F4clVZH2BBrbbhmKJ2
 j+0fJr9Kt2YV1BNFnkMsTpDgzHi1AD5ERdZREbJfWNQ==
X-Received: by 2002:aa7:d84d:0:b0:49c:96f9:417e with SMTP id
 f13-20020aa7d84d000000b0049c96f9417emr9623171eds.2.1675411753298; 
 Fri, 03 Feb 2023 00:09:13 -0800 (PST)
X-Google-Smtp-Source: AK7set+Fq1e3LQCYUMQ4JqNsvVTMReZl/rmJ4045vTiSRljk5PQQqakOY3FlB8VmZndAcRaI3SwG4Q==
X-Received: by 2002:aa7:d84d:0:b0:49c:96f9:417e with SMTP id
 f13-20020aa7d84d000000b0049c96f9417emr9623159eds.2.1675411753050; 
 Fri, 03 Feb 2023 00:09:13 -0800 (PST)
Received: from redhat.com ([2.52.156.122]) by smtp.gmail.com with ESMTPSA id
 cn13-20020a0564020cad00b0049eea46c909sm744733edb.37.2023.02.03.00.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Feb 2023 00:09:12 -0800 (PST)
Date: Fri, 3 Feb 2023 03:09:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH v2 5/7] vdpa: validate device feature provisioning
 against supported class
Message-ID: <20230203025523-mutt-send-email-mst@kernel.org>
References: <1675207345-22328-1-git-send-email-si-wei.liu@oracle.com>
 <1675207345-22328-6-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1675207345-22328-6-git-send-email-si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, elic@nvidia.com,
 virtualization@lists.linux-foundation.org
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

On Tue, Jan 31, 2023 at 03:22:23PM -0800, Si-Wei Liu wrote:
> Today when device features are explicitly provisioned, the features
> user supplied may contain device class specific features that are
> not supported by the parent managment device. On the other hand,
> when parent managment device supports more than one class, the
> device features to provision may be ambiguous if none of the class
> specific attributes is provided at the same time. Validate these
> cases and prompt appropriate user errors accordingly.
> 
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  drivers/vdpa/vdpa.c | 51 ++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 42 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 1eba978..35a72d6 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -460,12 +460,30 @@ static int vdpa_nl_mgmtdev_handle_fill(struct sk_buff *msg, const struct vdpa_mg
>  	return 0;
>  }
>  
> +static u64 vdpa_mgmtdev_get_classes(const struct vdpa_mgmt_dev *mdev,
> +				    unsigned int *nclasses)

given max value is apparently 64 how important is it that it's unsigned?
Just make it an int.

Also I'd return u64 through a pointer too for consistency.

> +{
> +	u64 supported_classes = 0;
> +	unsigned int n = 0;
> +	int i = 0;
> +
> +	while (mdev->id_table[i].device) {
> +		if (mdev->id_table[i].device <= 63) {
> +			supported_classes |= BIT_ULL(mdev->id_table[i].device);
> +			n++;
> +		}
> +		i++;
> +	}


Better as a for loop. I know you are just moving code if you
want to make it very clear it's a refactoring split
as a separate patch, but ok anyway.

> +	if (nclasses)
> +		*nclasses = n;
> +
> +	return supported_classes;
> +}
> +
>  static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *msg,
>  			     u32 portid, u32 seq, int flags)
>  {
> -	u64 supported_classes = 0;
>  	void *hdr;
> -	int i = 0;
>  	int err;
>  
>  	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags, VDPA_CMD_MGMTDEV_NEW);
> @@ -475,14 +493,9 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *m
>  	if (err)
>  		goto msg_err;
>  
> -	while (mdev->id_table[i].device) {
> -		if (mdev->id_table[i].device <= 63)
> -			supported_classes |= BIT_ULL(mdev->id_table[i].device);
> -		i++;
> -	}
> -
>  	if (nla_put_u64_64bit(msg, VDPA_ATTR_MGMTDEV_SUPPORTED_CLASSES,
> -			      supported_classes, VDPA_ATTR_UNSPEC)) {
> +			      vdpa_mgmtdev_get_classes(mdev, NULL),
> +			      VDPA_ATTR_UNSPEC)) {
>  		err = -EMSGSIZE;
>  		goto msg_err;
>  	}
> @@ -571,8 +584,10 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>  	struct vdpa_dev_set_config config = {};
>  	struct nlattr **nl_attrs = info->attrs;
>  	struct vdpa_mgmt_dev *mdev;
> +	unsigned int ncls = 0;
>  	const u8 *macaddr;
>  	const char *name;
> +	u64 classes;
>  	int err = 0;
>  
>  	if (!info->attrs[VDPA_ATTR_DEV_NAME])
> @@ -649,6 +664,24 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>  		goto err;
>  	}
>  
> +	classes = vdpa_mgmtdev_get_classes(mdev, &ncls);
> +	if (config.mask & VDPA_DEV_NET_ATTRS_MASK &&
> +	    !(classes & BIT_ULL(VIRTIO_ID_NET))) {
> +		NL_SET_ERR_MSG_MOD(info->extack,
> +				   "Network class attributes provided on unsupported management device");
> +		err = -EINVAL;
> +		goto err;
> +	}
> +	if (!(config.mask & VDPA_DEV_NET_ATTRS_MASK) &&
> +	    config.mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES) &&
> +	    classes & BIT_ULL(VIRTIO_ID_NET) && ncls > 1 &&
> +	    config.device_features & VIRTIO_DEVICE_F_MASK) {
> +		NL_SET_ERR_MSG_MOD(info->extack,
> +				   "Management device supports multi-class while device features specified are ambiguous");
> +		err = -EINVAL;
> +		goto err;
> +	}
> +
>  	err = mdev->ops->dev_add(mdev, name, &config);
>  err:
>  	up_write(&vdpa_dev_lock);
> -- 
> 1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
