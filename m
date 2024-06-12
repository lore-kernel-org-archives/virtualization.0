Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C79A16B755
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 07:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176379; cv=none; b=dHzcmNLpUvk/kfdXyhZGyc25Zdoz1hbhmhxw1QQrC2BKmI9ROvAG8yuevh1M6SQyCOS5y15lPC/haOcOTcWSzg/Jm9adLwnsxZCopPErxaR34HwosrhCa439rrGOcnCq53VNcxF8xPs9aWq9B5hY79Kxzzimgs7xuPCqW3+tlNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176379; c=relaxed/simple;
	bh=FJ9BTeEbejPctTmHZIUK+28zrcodhwdsqUv2ldy1WOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CQeLJhqiF+KB39AWs4E08Uxb0L45frzZq8HpwpS+O5CYYut2bfY7PSi/eVKDJ4eGJklX55PJeo7gv6VlBCfdUTHJd0zuxjmpS0kmzqcNOlf9eFEGaIUBV09RcC66rgx3rkP4rtk1cCMmo99jES0lVgOWV5x3S25ECckkrz1yMGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UmtWoIxV; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmtWoIxV"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D62D1821DB
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 07:12:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XAF4j3GyUeRw for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jun 2024 07:12:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E3A18821D5
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E3A18821D5
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UmtWoIxV
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E3A18821D5
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 07:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718176375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0AdGqhESB7FcgdEdVmtQDKt7grmbOEq0F0SyTtNx6No=;
	b=UmtWoIxVF1/JS1X2UzSDurRwRpp/e65Zxu9bfvdaViq8pNfwxS03wf1hUGiUf/S0UNlSp9
	3u3FoQzFtI31UPcfMIld/SJ9yyWqaZX68QX/FuZqF+HWIJjTw/62VnKyHYZHoPUKGnin8r
	YEQiXrz0yFxcNBcIfUhqPoRDzWDMHy8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-3owFxsKTP9SZHI8lUfV9Mw-1; Wed, 12 Jun 2024 03:12:53 -0400
X-MC-Unique: 3owFxsKTP9SZHI8lUfV9Mw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4217a6a00d8so31576965e9.0
        for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 00:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718176372; x=1718781172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AdGqhESB7FcgdEdVmtQDKt7grmbOEq0F0SyTtNx6No=;
        b=Og7ZALohKHYExXSn+ms7FWg5Y3mw7XlcSH5ZM8uF2gWPYdpVGLt9pSOQUdHCXOTo9I
         PrBXoZh0CgAwyPznLSwVZ/mKQ8blWK3HBjcl2NMOwHFcmoR0zVRcz7H+Mw8Q7VQueEbn
         WG5ZGgE7lOYEbhFxXJOCeIh2r0nU0CtjoAsbrdXJAjrUL8tg3U5KlcGn6rJGT7yXHfJ2
         AmywLeManP3iwTANW1hiC1lHemwBwGmbq52mJQUGZQqDbyKETSk5DPGJ0a8DywoSt+3v
         obTF88GzvTDLseH2XwTJhEfGLq3JB7Dv5o0iVTu+evWw6agyoy053M2TrfkoQ4v5ECOa
         Jukw==
X-Forwarded-Encrypted: i=1; AJvYcCVTf010OZQ5AdqQ6OqokuMCbtJMyXcoIEKD5MJCG2YCtI5zdEnMbrjQYBeoEvg6NyCb2TsyX6BGE70Yny0vcxZ9WROZRGNS7kFy63F0K5Sy2ipMaJ5wTpPvxA==
X-Gm-Message-State: AOJu0YxurobtNhHx0wjyPDGVNCn/pBWQnWFRwrgkBPVxjKjPgPXagNuM
	NKhB8bYOC0YsK4Cjp183Ggm1PjdpKmbyj2gFH1zhUkrGqveViIw9JvBWP79pEeC++QYn1ruTtqZ
	hHULE1kZZOCt1KMfsLntA6gTd/xjAImk4OImYJ0wMtPlqDCfJxfppZwdPpIwcbbbKqVBPKtRmMc
	7ZLho=
X-Received: by 2002:a05:600c:3552:b0:421:7be5:f318 with SMTP id 5b1f17b1804b1-422867c0408mr7204615e9.33.1718176371642;
        Wed, 12 Jun 2024 00:12:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGphusi1X4I6zrV9eu6daKqPEPomJK6FFUdfburgBDZrRG2/0lanC4F2ufq6sccZD88eQM6rQ==
X-Received: by 2002:a05:600c:3552:b0:421:7be5:f318 with SMTP id 5b1f17b1804b1-422867c0408mr7204415e9.33.1718176371029;
        Wed, 12 Jun 2024 00:12:51 -0700 (PDT)
Received: from redhat.com ([2a02:14f:178:39eb:4161:d39d:43e6:41f8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de5d5sm13703115e9.33.2024.06.12.00.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 00:12:50 -0700 (PDT)
Date: Wed, 12 Jun 2024 03:12:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, jasowang@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <20240612014143-mutt-send-email-mst@kernel.org>
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

The patch does not do what commit log says.
Instead there's an internal API to set mac and
a UAPI to write into config space.

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


Seems to poke at a device without even making sure it's a network
device.

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


Well, now vdpa_mgmtdev_ops which was completely generic is growing
a net specific interface. Which begs a question - how is this
going to work with other device types?

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

