Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CD9C433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 02:40:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0886261074
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 02:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0886261074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF43580F6B;
	Tue, 26 Oct 2021 02:40:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gAScOM79WFWH; Tue, 26 Oct 2021 02:40:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0F8D480F33;
	Tue, 26 Oct 2021 02:40:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA25DC0019;
	Tue, 26 Oct 2021 02:40:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51730C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 02:40:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3F0D94036A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 02:40:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id og2XWjcC6Co6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 02:40:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 415EE40368
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 02:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635216051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q1z0ZW8UUBWhFcepwVuM97sswsfWNaHcL/LH/nOUnvI=;
 b=RkfVFxmb04OhU7uiBCBY6iFpSvPQOJGC7veryz/cuADSZqPAgd8139xmYaz0V+iEEKKsNv
 5p62ePgmYShFFxvFTdMpSNbzR5suCatuUXGNNHgqbX2OUg8UNYTfvVhXMLHUZ8eMGcpqfp
 EfPBXZMADajWmGERiGUDZfUGQhif9lM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-Cfo0jcfaOCOfrRDXmpExAA-1; Mon, 25 Oct 2021 22:40:48 -0400
X-MC-Unique: Cfo0jcfaOCOfrRDXmpExAA-1
Received: by mail-pj1-f69.google.com with SMTP id
 om2-20020a17090b3a8200b001a069b140ffso390705pjb.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 19:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Q1z0ZW8UUBWhFcepwVuM97sswsfWNaHcL/LH/nOUnvI=;
 b=y/KfMtu5v9RpAslbWczmzELZ2oxaXZ4/P7QfANLtgTGkpUwBgcvGUsIQwnzK2Ie5cx
 Mo5FrJ2nJxmfuEP+GpTda5Y6XTv7zbmYSEHUGzo06aFcxKCj04EPV+sUhh1BpRN4QZ+T
 MEGYCDZMSGqvBKvPhSmj7GPX9qZHpmJCIPJ7eEC/CmkLPcpvSxbGMr1wF9+s6iYI+ulE
 S9jNBPTgYCIlCkaA/TbNFzprcW/O7dBSFabRBMbhr+8H4x8CP4WjE8biYCgisDJfrQtq
 zw8OPoGF7mMvUBbauMxfoQHAT9xGXgbfP88rhcCWoAMP7O5jZHmjcEYmm+SxQ3iiNgcM
 tvWw==
X-Gm-Message-State: AOAM531kp8o6lE/KPN1esPP5TDZnv6LDQuMJpRJwEjntlkustTiP/soC
 DRXkrsjYZiW8FMc8OZPsun68o0rle+pdAbRq8saYGR6InsY/CYJrKCa9/tTFQjtGyq3Ft8d++IP
 aV9fmJXdXIv6rGpzWOTx8zeOzBBlHI0IPMeG7TlE3eA==
X-Received: by 2002:a63:b04c:: with SMTP id z12mr16691691pgo.363.1635216047358; 
 Mon, 25 Oct 2021 19:40:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrXr85zKPoGrgw6i1W0AkbD1TItUmZZjE95edYtgXIb1iq1dxmZ/YZ7FHPkNht25qqzGFdpg==
X-Received: by 2002:a63:b04c:: with SMTP id z12mr16691680pgo.363.1635216047011; 
 Mon, 25 Oct 2021 19:40:47 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id qe7sm16999164pjb.1.2021.10.25.19.40.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Oct 2021 19:40:46 -0700 (PDT)
Subject: Re: [PATCH linux-next v4 4/8] vdpa: Enable user to set mac and mtu of
 vdpa device
To: Parav Pandit <parav@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
References: <20211021163509.6978-1-parav@nvidia.com>
 <20211021163509.6978-5-parav@nvidia.com>
 <b6f5c0e9-e3e0-0f7f-d3b6-d20d9c01d27d@redhat.com>
 <PH0PR12MB54817652E2E49FD6A4F58F1BDC839@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1beeedf9-9509-a58e-5c7a-98ad14a2dbb5@redhat.com>
Date: Tue, 26 Oct 2021 10:40:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54817652E2E49FD6A4F58F1BDC839@PH0PR12MB5481.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="iso-2022-jp"; Format="flowed"; DelSp="yes"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


在 2021/10/25 下午3:06, Parav Pandit 写道:
>
>> From: Jason Wang <jasowang@redhat.com>
>> Sent: Monday, October 25, 2021 12:31 PM
>>
>> 在 2021/10/22 上午12:35, Parav Pandit 写道:
>>> $ vdpa dev add name bar mgmtdev vdpasim_net mac 00:11:22:33:44:55 mtu
>>> 9000
>>>
>>> $ vdpa dev config show
>>> bar: mac 00:11:22:33:44:55 link up link_announce false mtu 9000
>>>
>>> $ vdpa dev config show -jp
>>> {
>>>       "config": {
>>>           "bar": {
>>>               "mac": "00:11:22:33:44:55",
>>>               "link ": "up",
>>>               "link_announce ": false,
>>>               "mtu": 9000,
>>>           }
>>>       }
>>> }
>>>
>>> Signed-off-by: Parav Pandit <parav@nvidia.com>
>>> Reviewed-by: Eli Cohen <elic@nvidia.com>
>>> ---
>>> changelog:
>>> v3->v4:
>>>    - provide config attributes during device addition time
>>> ---
>>>    drivers/vdpa/ifcvf/ifcvf_main.c      |  3 ++-
>>>    drivers/vdpa/mlx5/net/mlx5_vnet.c    |  3 ++-
>>>    drivers/vdpa/vdpa.c                  | 33 ++++++++++++++++++++++++++--
>>>    drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  3 ++-
>>>    drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  3 ++-
>>>    drivers/vdpa/vdpa_user/vduse_dev.c   |  3 ++-
>>>    include/linux/vdpa.h                 | 17 +++++++++++++-
>>>    7 files changed, 57 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c
>>> b/drivers/vdpa/ifcvf/ifcvf_main.c index dcd648e1f7e7..6dc75ca70b37
>>> 100644
>>> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
>>> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
>>> @@ -499,7 +499,8 @@ static u32 get_dev_type(struct pci_dev *pdev)
>>>    	return dev_type;
>>>    }
>>>
>>> -static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char
>>> *name)
>>> +static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char
>> *name,
>>> +			      const struct vdpa_dev_set_config *config)
>>>    {
>>>    	struct ifcvf_vdpa_mgmt_dev *ifcvf_mgmt_dev;
>>>    	struct ifcvf_adapter *adapter;
>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> index bd56de7484dc..ca05f69054b6 100644
>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> @@ -2404,7 +2404,8 @@ struct mlx5_vdpa_mgmtdev {
>>>    	struct mlx5_vdpa_net *ndev;
>>>    };
>>>
>>> -static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char
>>> *name)
>>> +static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char
>> *name,
>>> +			     const struct vdpa_dev_set_config *add_config)
>>>    {
>>>    	struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct
>> mlx5_vdpa_mgmtdev, mgtdev);
>>>    	struct virtio_net_config *config;
>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
>>> a50a6aa1cfc4..daa34a61c898 100644
>>> --- a/drivers/vdpa/vdpa.c
>>> +++ b/drivers/vdpa/vdpa.c
>>> @@ -14,7 +14,6 @@
>>>    #include <uapi/linux/vdpa.h>
>>>    #include <net/genetlink.h>
>>>    #include <linux/mod_devicetable.h>
>>> -#include <linux/virtio_net.h>
>>>    #include <linux/virtio_ids.h>
>>>
>>>    static LIST_HEAD(mdev_head);
>>> @@ -472,9 +471,15 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff
>> *msg, struct netlink_callback *cb)
>>>    	return msg->len;
>>>    }
>>>
>>> +#define VDPA_DEV_NET_ATTRS_MASK ((1 <<
>> VDPA_ATTR_DEV_NET_CFG_MACADDR) | \
>>> +				 (1 << VDPA_ATTR_DEV_NET_CFG_MTU))
>>> +
>>>    static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct
>> genl_info *info)
>>>    {
>>> +	struct vdpa_dev_set_config config = {};
>>> +	struct nlattr **nl_attrs = info->attrs;
>>>    	struct vdpa_mgmt_dev *mdev;
>>> +	const u8 *macaddr;
>>>    	const char *name;
>>>    	int err = 0;
>>>
>>> @@ -483,6 +488,21 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct
>>> sk_buff *skb, struct genl_info *i
>>>
>>>    	name = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
>>>
>>> +	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
>>> +		macaddr =
>> nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
>>> +		memcpy(config.net.mac, macaddr, sizeof(config.net.mac));
>>> +		config.mask |= (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR);
>>> +	}
>>> +	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]) {
>>> +		config.net.mtu =
>>> +
>> 	nla_get_u16(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]);
>>> +		config.mask |= (1 << VDPA_ATTR_DEV_NET_CFG_MTU);
>>> +	}
>>> +
>>> +	if ((config.mask & VDPA_DEV_NET_ATTRS_MASK) &&
>>> +	    !netlink_capable(skb, CAP_NET_ADMIN))
>>> +		return -EPERM;
>>
>> This deserves a independent patch. And do we need backport it to stable?
> This patch is adding the ability to configure mac and mtu. Hence, it is in this patch.
> It cannot be a different patch after this.
>
>> Another question is that, do need the cap if not attrs were specified?
> I am not sure. A user is adding the vpda device anchored on the bus.
> We likely need different capability check than the NET_ADMIN.


Yes, that is what I meant. It looks to me currently we allow  
unprivileged user to add vDPA device? If not, we are probably fine.

Thanks


>
>>
>>> +
>>>    	mutex_lock(&vdpa_dev_mutex);
>>>    	mdev = vdpa_mgmtdev_get_from_attr(info->attrs);
>>>    	if (IS_ERR(mdev)) {
>>> @@ -490,8 +510,14 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct
>> sk_buff *skb, struct genl_info *i
>>>    		err = PTR_ERR(mdev);
>>>    		goto err;
>>>    	}
>>> +	if ((config.mask & mdev->config_attr_mask) != config.mask) {
>>> +		NL_SET_ERR_MSG_MOD(info->extack,
>>> +				   "All provided attributes are not supported");
>>> +		err = -EOPNOTSUPP;
>>> +		goto err;
>>> +	}
>>>
>>> -	err = mdev->ops->dev_add(mdev, name);
>>> +	err = mdev->ops->dev_add(mdev, name, &config);
>>>    err:
>>>    	mutex_unlock(&vdpa_dev_mutex);
>>>    	return err;
>>> @@ -822,6 +848,9 @@ static const struct nla_policy
>> vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>>>    	[VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type = NLA_NUL_STRING },
>>>    	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
>>>    	[VDPA_ATTR_DEV_NAME] = { .type = NLA_STRING },
>>> +	[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
>>> +	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
>>> +	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
>>>    };
>>>
>>>    static const struct genl_ops vdpa_nl_ops[] = { diff --git
>>> a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>>> b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>>> index a790903f243e..42d401d43911 100644
>>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>>> @@ -248,7 +248,8 @@ static struct device vdpasim_blk_mgmtdev = {
>>>    	.release = vdpasim_blk_mgmtdev_release,
>>>    };
>>>
>>> -static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char
>>> *name)
>>> +static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char
>> *name,
>>> +			       const struct vdpa_dev_set_config *config)
>>>    {
>>>    	struct vdpasim_dev_attr dev_attr = {};
>>>    	struct vdpasim *simdev;
>>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>>> b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>>> index a1ab6163f7d1..d681e423e64f 100644
>>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>>> @@ -126,7 +126,8 @@ static struct device vdpasim_net_mgmtdev = {
>>>    	.release = vdpasim_net_mgmtdev_release,
>>>    };
>>>
>>> -static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char
>>> *name)
>>> +static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char
>> *name,
>>> +			       const struct vdpa_dev_set_config *config)
>>>    {
>>>    	struct vdpasim_dev_attr dev_attr = {};
>>>    	struct vdpasim *simdev;
>>> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c
>>> b/drivers/vdpa/vdpa_user/vduse_dev.c
>>> index 841667a896dd..c9204c62f339 100644
>>> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
>>> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
>>> @@ -1503,7 +1503,8 @@ static int vduse_dev_init_vdpa(struct vduse_dev
>> *dev, const char *name)
>>>    	return 0;
>>>    }
>>>
>>> -static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name)
>>> +static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>>> +			const struct vdpa_dev_set_config *config)
>>>    {
>>>    	struct vduse_dev *dev;
>>>    	int ret;
>>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h index
>>> 111153c9ee71..315da5f918dc 100644
>>> --- a/include/linux/vdpa.h
>>> +++ b/include/linux/vdpa.h
>>> @@ -6,6 +6,8 @@
>>>    #include <linux/device.h>
>>>    #include <linux/interrupt.h>
>>>    #include <linux/vhost_iotlb.h>
>>> +#include <linux/virtio_net.h>
>>> +#include <linux/if_ether.h>
>>>
>>>    /**
>>>     * struct vdpa_calllback - vDPA callback definition.
>>> @@ -93,6 +95,14 @@ struct vdpa_iova_range {
>>>    	u64 last;
>>>    };
>>>
>>> +struct vdpa_dev_set_config {
>>> +	struct {
>>> +		u8 mac[ETH_ALEN];
>>> +		u16 mtu;
>>> +	} net;
>>
>> If we want to add block device, I guess we need a union as a container?
> Right. When that occurs in future, there will be union to contain both.
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
