Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D33F137C25
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 06:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718261982; cv=none; b=E15BLpB76vqwEA27Us2Hruvxr9az+rXB+W+r1/rcVPMyNfd9JTDpNfhE6R1zCWTBWQjvx5ENuBbkXIspN2zsV94NcFA01CvZOvkwnOk1WeisNUP4gMc7euQH56IP3xNa5MvhWr90OiNMRVI5f4J9LTFzyNstOrlAu5OnQWii+gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718261982; c=relaxed/simple;
	bh=pJwjntH5QMkuPUwNOFSmpR3KkB6NULCVjIIWybM6pWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Y4UJLZJvU80ctoNKELAgy9e/LrLSEcmTeT1nrxPdH+7TG6fJHPQqca5Z4i4Y65qs5XAPdFl30k4i2PpOqswKn3zhK7PDJNjD0Pd3nGz7ToNDAJOADAky9RdNTEsZFTPu/EQIcSJLzHwnLJSKQd8WDbzzQn6TvR6TFcmDvbawYX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P7jNLZKM; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7jNLZKM"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A100F40894
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 06:59:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PqhCjECStcPT for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jun 2024 06:59:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 13AEB4059B
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 13AEB4059B
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P7jNLZKM
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 13AEB4059B
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 06:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718261977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=drA76IDECayT317ZaKBjGX9PcBu+0gorkvMz8yjsoxU=;
	b=P7jNLZKMTCuGmu/EM5gKsLH7vtT5doD+3OeZmJdp7DhRu0cNVtjSlkYmYXBUVRjnYB3XYS
	6lO/Vl0UBwqbOCTXNj0HTWuUoRODMuS23/XVOU/LKDnTuxwGSeJqOLCrhehO/SEyKFqg7U
	2Rta/EY8AH6oQECIDjBSfALva11Q8GA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-VwFqf3OJPkmMQwX5KA-n1g-1; Thu, 13 Jun 2024 02:59:35 -0400
X-MC-Unique: VwFqf3OJPkmMQwX5KA-n1g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-35f1d5f1e3cso548039f8f.1
        for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 23:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718261974; x=1718866774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drA76IDECayT317ZaKBjGX9PcBu+0gorkvMz8yjsoxU=;
        b=mHQACa6dlTlE10XpgFxBTFASqmIqbhAhl64ZOuTgcfSSwsLzCUdb6iRXbh55h0/GVR
         e3PwL6CA6F9BjWAmQhJ55N2nefB7LJLzlZxwGgQ3lUO5eubZ3Nk9PkAsPM6ZpnxTK6Sv
         bR7ImXO8rTDjG7XCtlGpKKmUQgQE6T5QeSttgybGs/fVpk1Vz6MKue4sb4ZQ/a2M8Q7t
         ljNDaXLlnlzgwClcesn5O1mrNfrQ7ULnjXs6h8CtD3R3h/OW+LXlwunLibwzkDSdDALq
         iWAj0WXq3Hvt7StgaeUjg4I9YPgcED/rlXOiAA2EeFxNgc/cCZ9RnKqWFz08OK0xCPgN
         BR8g==
X-Forwarded-Encrypted: i=1; AJvYcCXlOKESQ2vEx3uAXbYSxx6acda/1i4vnu9st+zGo8hyZTLr1cySc9cAEy+eWGCwbrV8ANr/DsdaEhaA0xKdCh7yMoJqkLLjqkRDAhVoZwHjHevJcuB6PHwkCw==
X-Gm-Message-State: AOJu0YzT+Z3SiZwJEwi8B28PkyUtYcVKXPVtJcyWoncUsAfLFsM8/2sX
	Ivvp8+mYzgtgb6NCFMxWl2LNEQGCdovxhTg0VMQ5sFRQE3EvFVXcTOtsx13RPrq6KexBC183KQW
	P1zeDowDhbU9jLP5djOCyHzxx/xk1RlI69Dsnq81cX432AyvrXmkBUZhPO7T7/Rs1K7fn1OQvAL
	gA84Q=
X-Received: by 2002:adf:fc4a:0:b0:35f:1c26:b68d with SMTP id ffacd0b85a97d-35fe89433c6mr2681767f8f.60.1718261973684;
        Wed, 12 Jun 2024 23:59:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTGddEYi8s6Uj9O8LtEdStBWBMju/uoZiQ7uYD8Sqxu92RawWDLo3ZDwPwDowpIYg8Keq/wg==
X-Received: by 2002:adf:fc4a:0:b0:35f:1c26:b68d with SMTP id ffacd0b85a97d-35fe89433c6mr2681752f8f.60.1718261973066;
        Wed, 12 Jun 2024 23:59:33 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:341:5539:9b1a:2e49:4aac:204e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f22e8sm779696f8f.80.2024.06.12.23.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 23:59:32 -0700 (PDT)
Date: Thu, 13 Jun 2024 02:59:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, jasowang@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <20240613025548-mutt-send-email-mst@kernel.org>
References: <20240611053239.516996-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240611053239.516996-1-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 11, 2024 at 01:32:32PM +0800, Cindy Lu wrote:
> Add new UAPI to support the mac address from vdpa tool
> Function vdpa_nl_cmd_dev_config_set_doit() will get the
> MAC address from the vdpa tool and then set it to the device.
> 
> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
> 
> Here is sample:
> root@L1# vdpa -jp dev config show vdpa0
> {
>     "config": {
>         "vdpa0": {
>             "mac": "82:4d:e9:5d:d7:e6",
>             "link ": "up",
>             "link_announce ": false,
>             "mtu": 1500
>         }
>     }
> }
> 
> root@L1# vdpa dev set name vdpa0 mac 00:11:22:33:44:55
> 
> root@L1# vdpa -jp dev config show vdpa0
> {
>     "config": {
>         "vdpa0": {
>             "mac": "00:11:22:33:44:55",
>             "link ": "up",
>             "link_announce ": false,
>             "mtu": 1500
>         }
>     }
> }
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>



I think actually the idea of allowing provisioning
by specifying config of the device is actually valid.
However
- the name SET_CONFIG makes people think this allows
  writing even when e.g. device is assigned to guest
- having the internal api be mac specific is weird

Shouldn't config be an attribute maybe, not a new command?


> ---
>  drivers/vdpa/vdpa.c       | 71 +++++++++++++++++++++++++++++++++++++++
>  include/linux/vdpa.h      |  2 ++
>  include/uapi/linux/vdpa.h |  1 +
>  3 files changed, 74 insertions(+)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index a7612e0783b3..347ae6e7749d 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -1149,6 +1149,72 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
>  	return err;
>  }
>  
> +static int vdpa_nl_cmd_dev_config_set_doit(struct sk_buff *skb,
> +					   struct genl_info *info)
> +{
> +	struct vdpa_dev_set_config set_config = {};
> +	struct nlattr **nl_attrs = info->attrs;
> +	struct vdpa_mgmt_dev *mdev;
> +	const u8 *macaddr;
> +	const char *name;
> +	int err = 0;
> +	struct device *dev;
> +	struct vdpa_device *vdev;
> +
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
> +		NL_SET_ERR_MSG_MOD(
> +			info->extack,
> +			"Fail to find the specified management device");
> +		err = -EINVAL;
> +		goto mdev_err;
> +	}
> +	mdev = vdev->mdev;
> +	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
> +		if (!(mdev->supported_features & BIT_ULL(VIRTIO_NET_F_MAC))) {
> +			NL_SET_ERR_MSG_FMT_MOD(
> +				info->extack,
> +				"Missing features 0x%llx for provided attributes",
> +				BIT_ULL(VIRTIO_NET_F_MAC));
> +			err = -EINVAL;
> +			goto mdev_err;
> +		}
> +		macaddr = nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
> +		memcpy(set_config.net.mac, macaddr, ETH_ALEN);
> +		set_config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
> +		if (mdev->ops->set_mac) {
> +			err = mdev->ops->set_mac(mdev, vdev, &set_config);
> +		} else {
> +			NL_SET_ERR_MSG_FMT_MOD(
> +				info->extack,
> +				"%s device not support set mac address ", name);
> +		}
> +
> +	} else {
> +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +				       "%s device not support this config ",
> +				       name);
> +	}
> +
> +mdev_err:
> +	put_device(dev);
> +dev_err:
> +	up_write(&vdpa_dev_lock);
> +	return err;
> +}
> +
>  static int vdpa_dev_config_dump(struct device *dev, void *data)
>  {
>  	struct vdpa_device *vdev = container_of(dev, struct vdpa_device, dev);
> @@ -1285,6 +1351,11 @@ static const struct genl_ops vdpa_nl_ops[] = {
>  		.doit = vdpa_nl_cmd_dev_stats_get_doit,
>  		.flags = GENL_ADMIN_PERM,
>  	},
> +	{
> +		.cmd = VDPA_CMD_DEV_CONFIG_SET,
> +		.doit = vdpa_nl_cmd_dev_config_set_doit,
> +		.flags = GENL_ADMIN_PERM,
> +	},
>  };
>  
>  static struct genl_family vdpa_nl_family __ro_after_init = {
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index db15ac07f8a6..c97f4f1da753 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -581,6 +581,8 @@ struct vdpa_mgmtdev_ops {
>  	int (*dev_add)(struct vdpa_mgmt_dev *mdev, const char *name,
>  		       const struct vdpa_dev_set_config *config);
>  	void (*dev_del)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev);
> +	int (*set_mac)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev,
> +		       const struct vdpa_dev_set_config *config);
>  };
>  
>  /**
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 54b649ab0f22..53f249fb26bc 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -19,6 +19,7 @@ enum vdpa_command {
>  	VDPA_CMD_DEV_GET,		/* can dump */
>  	VDPA_CMD_DEV_CONFIG_GET,	/* can dump */
>  	VDPA_CMD_DEV_VSTATS_GET,
> +	VDPA_CMD_DEV_CONFIG_SET,
>  };
>  
>  enum vdpa_attr {
> -- 
> 2.45.0

