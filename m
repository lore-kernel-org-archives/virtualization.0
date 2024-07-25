Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D6F19D892
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jul 2024 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721928574; cv=none; b=P7DLRCa62NpvoVyDhAm12vcKiJ4081k3uzaDBLGBwx7MzfEw3gXGxA4sJ80tEdvhXiFqq2DfD1bmLRabPa+Hpwak4rDTu/pdDsNttn3OxfyOp9M5EZyGSxDn15EfLCiBrZYobHYhrMtUl/ZKTJ2MFoMg08PBVe6f2AyKd5067hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721928574; c=relaxed/simple;
	bh=N3FzGEoCIhOX3MFBjpVcDtNufAAiuEhtt2RKSDcX/g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8obIqdv2QGjBm05b8H8gZvixwlr3rCf3TVdIh7hgfU8Ayn10Cw1uu7mV3yHvMYWlz/+1jMK1josCo+nOdHxoIcl7H5BlG2f4jJ/xrifYXLzlFG2Hgj8yMjG5gUU8V7s74GibyOViEZmPZHZmkpOKm11UKMV9PNOOlla6QybRY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=w/Kwpsid; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="w/Kwpsid"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1E0C40306
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jul 2024 17:29:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SJfJW63imgmX for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Jul 2024 17:29:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=jdamato@fastly.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B974340098
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B974340098
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.a=rsa-sha256 header.s=google header.b=w/Kwpsid
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B974340098
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jul 2024 17:29:30 +0000 (UTC)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-7a0e8b76813so67598a12.3
        for <virtualization@lists.linux-foundation.org>; Thu, 25 Jul 2024 10:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1721928570; x=1722533370; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCayIjNrRvGhZM69uiC4OvAIpmWWFpkBAk0aaq4aSUc=;
        b=w/KwpsidLCMlL4QnYV8962VmIAAIgjo40zYBonYo2dkni7KVUczw1ycmjnjWIY6t9D
         NYE8GuRpXxdl0VR0GkSGCSpgTaTnkqhnmorlvFTVpurLPkpNVWGgfxmLTlLhhsLGMYA6
         Qn3dKGUkmlDZ26jp/oizhitGMoKIHKZJpm7Sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721928570; x=1722533370;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NCayIjNrRvGhZM69uiC4OvAIpmWWFpkBAk0aaq4aSUc=;
        b=fTU8t7V63acqAwcylGMxfpiqP961WJ4G1G0oJms0d8kMtKuhtCuU89uNLcrRU+oI8z
         n6sEtKs1fhBiaYHGNCBWkoVMbhI4RR3bwQIXlpxaWsovYKgXefLKvsaNiR4gcQ2dP45j
         jDziliqFt+ntt5jqVOtrww5uqaqDOLVg7shq3U9aPNu1KLDi1DCsom8diwzYRn+mUuJQ
         ef3Yqo8MaScJikn64GVt/CtcUXX1pGph0EKdzFQdQjVuoSeXZ6yKbeEuY/jN+CRuWMVB
         CxdaKGiSsswiRDvyP2xO7A7LAvNzHZr/IPkObMCW+2ccB1tNFwX7n+Fn6/JeKwqwATSG
         O0LA==
X-Forwarded-Encrypted: i=1; AJvYcCV4US6tnq9n+P/WcJih6Zm/UvGJJBfCJ/oCZMp5/JsODJZo1Asw5D+Z4ZK3N4dtLaxxLHHowO7Vp2rqFvDqpjErNSV05+BbqWnY2vlzv5BReuVPoJMXr+Uz0A==
X-Gm-Message-State: AOJu0YzSdBenJPlni39g6aPrUNc+GEfElyss4yxqKos0SOI2i24JCxks
	vcBrcpOD4OtL9odVsLvrTgTd8WIDjyA1cFjal/ntK+pAaKWW1R+swD3SXhFtQ8k=
X-Google-Smtp-Source: AGHT+IECBP9wZR8j26b0macyKUl4ggCAjT7AsfbXpSQ5VAO6+8FmebHqn7MrPbu8eT1i5p5fen8o5A==
X-Received: by 2002:a05:6a21:a4c1:b0:1c0:ede4:9a73 with SMTP id adf61e73a8af0-1c47b144bcemr3103021637.7.1721928570204;
        Thu, 25 Jul 2024 10:29:30 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead81168csm1376517b3a.112.2024.07.25.10.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 10:29:29 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:29:27 -0700
From: Joe Damato <jdamato@fastly.com>
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com,
	parav@nvidia.com, sgarzare@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATH v6 1/3] vdpa: support set mac address from vdpa tool
Message-ID: <ZqKLd9ZIJ4l5tAL8@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Cindy Lu <lulu@redhat.com>, dtatulea@nvidia.com, mst@redhat.com,
	jasowang@redhat.com, parav@nvidia.com, sgarzare@redhat.com,
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
References: <20240725013217.1124704-1-lulu@redhat.com>
 <20240725013217.1124704-2-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725013217.1124704-2-lulu@redhat.com>

On Thu, Jul 25, 2024 at 09:31:02AM +0800, Cindy Lu wrote:
[...]
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 8d391947eb8d..532cf3b52b26 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -1361,6 +1361,81 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
>  	return err;
>  }
>  
> +static int vdpa_dev_net_device_attr_set(struct vdpa_device *vdev,
> +					struct genl_info *info)
> +{
> +	struct vdpa_dev_set_config set_config = {};
> +	const u8 *macaddr;
> +	struct vdpa_mgmt_dev *mdev = vdev->mdev;
> +	struct nlattr **nl_attrs = info->attrs;
> +	int err = -EINVAL;

Nit: IIRC networking code prefers reverse-xmas tree style and
macaddr above needs to be moved.

> +	down_write(&vdev->cf_lock);
> +	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
> +		set_config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
> +		macaddr = nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
> +
> +		if (is_valid_ether_addr(macaddr)) {
> +			ether_addr_copy(set_config.net.mac, macaddr);
> +			memcpy(set_config.net.mac, macaddr, ETH_ALEN);
> +			if (mdev->ops->dev_set_attr) {
> +				err = mdev->ops->dev_set_attr(mdev, vdev,
> +							      &set_config);
> +			} else {
> +				NL_SET_ERR_MSG_FMT_MOD(
> +					info->extack,
> +					"device does not support changing the MAC address");
> +			}
> +		} else {
> +			NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +					       "Invalid MAC address");
> +		}
> +	}
> +	up_write(&vdev->cf_lock);
> +	return err;
> +}

Nit: other code in this file has line breaks separating functions.
Probably good to add one here?


> +static int vdpa_nl_cmd_dev_attr_set_doit(struct sk_buff *skb,
> +					 struct genl_info *info)

Nit: Does the above pass ./scripts/checkpatch.pl --strict ? I am asking
because it seems like the alignment might be off?

> +{
> +	const char *name;
> +	int err = 0;
> +	struct device *dev;
> +	struct vdpa_device *vdev;
> +	u64 classes;

Nit: Same as above; I believe networking code is supposed to follow
reverse xmas tree order so these variables should be rearranged.

> +	if (!info->attrs[VDPA_ATTR_DEV_NAME])
> +		return -EINVAL;
> +
> +	name = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
> +
> +	down_write(&vdpa_dev_lock);
> +	dev = bus_find_device(&vdpa_bus, NULL, name, vdpa_name_match);
> +	if (!dev) {
> +		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> +		err = -ENODEV;
> +		goto dev_err;
> +	}
> +	vdev = container_of(dev, struct vdpa_device, dev);
> +	if (!vdev->mdev) {
> +		NL_SET_ERR_MSG_MOD(info->extack, "unmanaged vdpa device");
> +		err = -EINVAL;
> +		goto mdev_err;
> +	}
> +	classes = vdpa_mgmtdev_get_classes(vdev->mdev, NULL);
> +	if (classes & BIT_ULL(VIRTIO_ID_NET)) {
> +		err = vdpa_dev_net_device_attr_set(vdev, info);
> +	} else {
> +		NL_SET_ERR_MSG_FMT_MOD(info->extack, "%s device not supported",
> +				       name);
> +	}
> +
> +mdev_err:
> +	put_device(dev);
> +dev_err:
> +	up_write(&vdpa_dev_lock);
> +	return err;
> +}

[...]
