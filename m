Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0D5C433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 13:17:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B7C060E96
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 13:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4B7C060E96
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04FD34036E;
	Tue, 26 Oct 2021 13:17:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vSrzohs8aTaG; Tue, 26 Oct 2021 13:17:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 664034030B;
	Tue, 26 Oct 2021 13:17:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 397B0C0019;
	Tue, 26 Oct 2021 13:17:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B7D9C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 13:17:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 04BD160904
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 13:17:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XsL-A6T7Mscl
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 13:17:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9B922606EB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 13:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635254226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G5TtCg9D0USOiIW375/HKNZzKhi7NBmPkq4iGa0QgNQ=;
 b=OK3vpXBfVnbHxGOTLWNzWPboRYC5keV1qaUsFr2K7eZI/W3m37J7ROhK+Xo5EAL7/O0vnH
 oqdkI7b6ktEEPlUpg9e7DcVrH8uQpLvU575gVtMkOo3p/Lh4sA8F5X+UbGYF9ldV3BF1E+
 biF9Sg29DCu8IuabTOP6iX5utGkrJyQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-ncFrQdEaNTWjD78fYMbB-Q-1; Tue, 26 Oct 2021 09:17:05 -0400
X-MC-Unique: ncFrQdEaNTWjD78fYMbB-Q-1
Received: by mail-ed1-f71.google.com with SMTP id
 g6-20020a056402424600b003dd2b85563bso10306181edb.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 06:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=G5TtCg9D0USOiIW375/HKNZzKhi7NBmPkq4iGa0QgNQ=;
 b=MfiRd/zdpuo08HWurE0u9aaZLz7qZ9R1uM2D/SP2gmRRH6kRsTNGoXTdEm4QU/AE0W
 NQ8vWS6fvkD9kVpC1QClAt1pY826UMNKDK7gyTjnc/suKc0+OQr5SInzugCGjkuYkEfB
 E1XHhpfnpI2jsmOHQ+iUxwgvmACdVyEzyAlNn/0f8YpmutS2CMjM53fnquKqxAlDxvAr
 aOxE8hAQTeacN3WMeFUqx+t04wJWWC921hcFZn3v9lESeNGeS5K6+jbJXSwv3EvEkCm7
 eJuAILk2/38sDHE711YnOOKYsN00mpr+yd0cwujbJqFLDfqHnuJHAIVYFXkOENbuU5/e
 0QLQ==
X-Gm-Message-State: AOAM531GFKaA6DxmICIrTpYggO6MtFXvUM5yK3bxwkEwDM9ayLcV7xXf
 5lq3NbG9VUrhmSaxyJbpifSFEMulHLwG/70glijkroQuyoRm9PZ8XSrYSUX5U+xG6TM2Xg2MdZY
 rxNcc0n/CbPGgSiL+vNmwU3HVhwZhL/KhoEB9/vJodA==
X-Received: by 2002:a17:906:646:: with SMTP id
 t6mr30007300ejb.197.1635254223818; 
 Tue, 26 Oct 2021 06:17:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8NDTha7cg9TXoSUYb8urJxc2TE2tjUcrTFssZvgXGKvU+fCr9quxSxwhTy/eVZCLfLT+1gQ==
X-Received: by 2002:a17:906:646:: with SMTP id
 t6mr30007267ejb.197.1635254223497; 
 Tue, 26 Oct 2021 06:17:03 -0700 (PDT)
Received: from steredhat (host-79-30-88-77.retail.telecomitalia.it.
 [79.30.88.77])
 by smtp.gmail.com with ESMTPSA id kw5sm9186342ejc.110.2021.10.26.06.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Oct 2021 06:17:03 -0700 (PDT)
Date: Tue, 26 Oct 2021 15:17:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH linux-next v6 4/8] vdpa: Enable user to set mac and mtu
 of vdpa device
Message-ID: <20211026131700.vcc3bqsjyxvtu5qm@steredhat>
References: <20211026040243.79005-1-parav@nvidia.com>
 <20211026040243.79005-5-parav@nvidia.com>
 <20211026130125.pxdg7w473xjuftz4@steredhat>
 <PH0PR12MB54810B7BE5EDCA0934F88612DC849@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211026090803-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481893A5314B3952CAE6FA1DC849@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481893A5314B3952CAE6FA1DC849@PH0PR12MB5481.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Oct 26, 2021 at 01:11:51PM +0000, Parav Pandit wrote:
>
>
>> From: Michael S. Tsirkin <mst@redhat.com>
>> Sent: Tuesday, October 26, 2021 6:38 PM
>>
>> On Tue, Oct 26, 2021 at 01:03:41PM +0000, Parav Pandit wrote:
>> >
>> >
>> > > From: Stefano Garzarella <sgarzare@redhat.com>
>> > > Sent: Tuesday, October 26, 2021 6:31 PM
>> > >
>> > > On Tue, Oct 26, 2021 at 07:02:39AM +0300, Parav Pandit via
>> > > Virtualization
>> > > wrote:
>> > > >$ vdpa dev add name bar mgmtdev vdpasim_net mac 00:11:22:33:44:55
>> > > >mtu
>> > > >9000
>> > > >
>> > > >$ vdpa dev config show
>> > > >bar: mac 00:11:22:33:44:55 link up link_announce false mtu 9000
>> > > >
>> > > >$ vdpa dev config show -jp
>> > > >{
>> > > >    "config": {
>> > > >        "bar": {
>> > > >            "mac": "00:11:22:33:44:55",
>> > > >            "link ": "up",
>> > > >            "link_announce ": false,
>> > > >            "mtu": 9000,
>> > > >        }
>> > > >    }
>> > > >}
>> > > >
>> > > >Signed-off-by: Parav Pandit <parav@nvidia.com>
>> > > >Reviewed-by: Eli Cohen <elic@nvidia.com>
>> > > >Acked-by: Jason Wang <jasowang@redhat.com>
>> > > >
>> > > >---
>> > > >changelog:
>> > > >v4->v5:
>> > > > - added comment for checking device capabilities
>> > > >v3->v4:
>> > > > - provide config attributes during device addition time
>> > > >---
>> > > > drivers/vdpa/ifcvf/ifcvf_main.c      |  3 ++-
>> > > > drivers/vdpa/mlx5/net/mlx5_vnet.c    |  3 ++-
>> > > > drivers/vdpa/vdpa.c                  | 38 ++++++++++++++++++++++++++--
>> > > > drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  3 ++-
>> > > >drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  3 ++-
>> > > > drivers/vdpa/vdpa_user/vduse_dev.c   |  3 ++-
>> > > > include/linux/vdpa.h                 | 17 ++++++++++++-
>> > > > 7 files changed, 62 insertions(+), 8 deletions(-)
>> > > >
>> > > >diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c
>> > > >b/drivers/vdpa/ifcvf/ifcvf_main.c index dcd648e1f7e7..6dc75ca70b37
>> > > >100644
>> > > >--- a/drivers/vdpa/ifcvf/ifcvf_main.c
>> > > >+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
>> > > >@@ -499,7 +499,8 @@ static u32 get_dev_type(struct pci_dev *pdev)
>> > > > 	return dev_type;
>> > > > }
>> > > >
>> > > >-static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const
>> > > >char
>> > > >*name)
>> > > >+static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const
>> > > >+char
>> > > *name,
>> > > >+			      const struct vdpa_dev_set_config *config)
>> > > > {
>> > > > 	struct ifcvf_vdpa_mgmt_dev *ifcvf_mgmt_dev;
>> > > > 	struct ifcvf_adapter *adapter;
>> > > >diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> > > >b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> > > >index b5bd1a553256..6bbdc0ece707 100644
>> > > >--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> > > >+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> > > >@@ -2482,7 +2482,8 @@ static int event_handler(struct
>> > > >notifier_block *nb,
>> > > unsigned long event, void *p
>> > > > 	return ret;
>> > > > }
>> > > >
>> > > >-static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const
>> > > >char
>> > > >*name)
>> > > >+static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const
>> > > >+char
>> > > *name,
>> > > >+			     const struct vdpa_dev_set_config
>> > > >*add_config)
>> > > > {
>> > > > 	struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct
>> > > > 	mlx5_vdpa_mgmtdev, mgtdev);
>> > > > 	struct virtio_net_config *config; diff --git
>> > > >a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
>> > > >973c56fb60b9..a1168a7fa8b8 100644
>> > > >--- a/drivers/vdpa/vdpa.c
>> > > >+++ b/drivers/vdpa/vdpa.c
>> > > >@@ -14,7 +14,6 @@
>> > > > #include <uapi/linux/vdpa.h>
>> > > > #include <net/genetlink.h>
>> > > > #include <linux/mod_devicetable.h> -#include <linux/virtio_net.h>
>> > > >#include <linux/virtio_ids.h>
>> > > >
>> > > > static LIST_HEAD(mdev_head);
>> > > >@@ -480,9 +479,15 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct
>> sk_buff
>> > > >*msg, struct netlink_callback *cb)
>> > > > 	return msg->len;
>> > > > }
>> > > >
>> > > >+#define VDPA_DEV_NET_ATTRS_MASK ((1 <<
>> > > VDPA_ATTR_DEV_NET_CFG_MACADDR) | \
>> > > >+				 (1 << VDPA_ATTR_DEV_NET_CFG_MTU))
>> > > >+
>> > > > static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb,
>> > > > struct genl_info *info) {
>> > > >+	struct vdpa_dev_set_config config = {};
>> > > >+	struct nlattr **nl_attrs = info->attrs;
>> > > > 	struct vdpa_mgmt_dev *mdev;
>> > > >+	const u8 *macaddr;
>> > > > 	const char *name;
>> > > > 	int err = 0;
>> > > >
>> > > >@@ -491,6 +496,26 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct
>> > > >sk_buff *skb, struct genl_info *i
>> > > >
>> > > > 	name = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
>> > > >
>> > > >+	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
>> > > >+		macaddr =
>> > > nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
>> > > >+		memcpy(config.net.mac, macaddr, sizeof(config.net.mac));
>> > > >+		config.mask |= (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR);
>> > > >+	}
>> > > >+	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]) {
>> > > >+		config.net.mtu =
>> > > >+
>> > > 	nla_get_u16(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]);
>> > > >+		config.mask |= (1 << VDPA_ATTR_DEV_NET_CFG_MTU);
>> > > >+	}
>> > > >+
>> > > >+	/* Skip checking capability if user didn't prefer to configure any
>> > > >+	 * device networking attributes. It is likely that user might have used
>> > > >+	 * a device specific method to configure such attributes or using device
>> > > >+	 * default attributes.
>> > > >+	 */
>> > > >+	if ((config.mask & VDPA_DEV_NET_ATTRS_MASK) &&
>> > > >+	    !netlink_capable(skb, CAP_NET_ADMIN))
>> > > >+		return -EPERM;
>> > > >+
>> > > > 	mutex_lock(&vdpa_dev_mutex);
>> > > > 	mdev = vdpa_mgmtdev_get_from_attr(info->attrs);
>> > > > 	if (IS_ERR(mdev)) {
>> > > >@@ -498,8 +523,14 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct
>> > > sk_buff *skb, struct genl_info *i
>> > > > 		err = PTR_ERR(mdev);
>> > > > 		goto err;
>> > > > 	}
>> > > >+	if ((config.mask & mdev->config_attr_mask) != config.mask) {
>> > > >+		NL_SET_ERR_MSG_MOD(info->extack,
>> > > >+				   "All provided attributes are not supported");
>> > > >+		err = -EOPNOTSUPP;
>> > > >+		goto err;
>> > > >+	}
>> > > >
>> > > >-	err = mdev->ops->dev_add(mdev, name);
>> > > >+	err = mdev->ops->dev_add(mdev, name, &config);
>> > > > err:
>> > > > 	mutex_unlock(&vdpa_dev_mutex);
>> > > > 	return err;
>> > > >@@ -835,6 +866,9 @@ static const struct nla_policy
>> > > vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>> > > > 	[VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type = NLA_NUL_STRING },
>> > > > 	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
>> > > > 	[VDPA_ATTR_DEV_NAME] = { .type = NLA_STRING },
>> > > >+	[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
>> > > >+	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
>> > > >+	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
>> > > > };
>> > > >
>> > > > static const struct genl_ops vdpa_nl_ops[] = { diff --git
>> > > >a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>> > > >b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>> > > >index a790903f243e..42d401d43911 100644
>> > > >--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>> > > >+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>> > > >@@ -248,7 +248,8 @@ static struct device vdpasim_blk_mgmtdev = {
>> > > > 	.release = vdpasim_blk_mgmtdev_release,  };
>> > > >
>> > > >-static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const
>> > > >char
>> > > >*name)
>> > > >+static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const
>> > > >+char
>> > > *name,
>> > > >+			       const struct vdpa_dev_set_config *config)
>> > > > {
>> > > > 	struct vdpasim_dev_attr dev_attr = {};
>> > > > 	struct vdpasim *simdev;
>> > > >diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>> > > >b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>> > > >index a1ab6163f7d1..d681e423e64f 100644
>> > > >--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>> > > >+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>> > > >@@ -126,7 +126,8 @@ static struct device vdpasim_net_mgmtdev = {
>> > > > 	.release = vdpasim_net_mgmtdev_release,  };
>> > > >
>> > > >-static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const
>> > > >char
>> > > >*name)
>> > > >+static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const
>> > > >+char
>> > > *name,
>> > > >+			       const struct vdpa_dev_set_config *config)
>> > > > {
>> > > > 	struct vdpasim_dev_attr dev_attr = {};
>> > > > 	struct vdpasim *simdev;
>> > > >diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c
>> > > >b/drivers/vdpa/vdpa_user/vduse_dev.c
>> > > >index 841667a896dd..c9204c62f339 100644
>> > > >--- a/drivers/vdpa/vdpa_user/vduse_dev.c
>> > > >+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
>> > > >@@ -1503,7 +1503,8 @@ static int vduse_dev_init_vdpa(struct
>> > > >vduse_dev
>> > > *dev, const char *name)
>> > > > 	return 0;
>> > > > }
>> > > >
>> > > >-static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char
>> > > >*name)
>> > > >+static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char
>> *name,
>> > > >+			const struct vdpa_dev_set_config *config)
>> > > > {
>> > > > 	struct vduse_dev *dev;
>> > > > 	int ret;
>> > > >diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h index
>> > > >fafb7202482c..bf9ddf743e2f 100644
>> > > >--- a/include/linux/vdpa.h
>> > > >+++ b/include/linux/vdpa.h
>> > > >@@ -6,6 +6,8 @@
>> > > > #include <linux/device.h>
>> > > > #include <linux/interrupt.h>
>> > > > #include <linux/vhost_iotlb.h>
>> > > >+#include <linux/virtio_net.h>
>> > > >+#include <linux/if_ether.h>
>> > > >
>> > > > /**
>> > > >  * struct vdpa_calllback - vDPA callback definition.
>> > > >@@ -93,6 +95,14 @@ struct vdpa_iova_range {
>> > > > 	u64 last;
>> > > > };
>> > > >
>> > > >+struct vdpa_dev_set_config {
>> > > >+	struct {
>> > > >+		u8 mac[ETH_ALEN];
>> > > >+		u16 mtu;
>> > > >+	} net;
>> > > >+	u64 mask;
>> > > >+};
>> > > >+
>> > > > /**
>> > > >  * Corresponding file area for device memory mapping
>> > > >  * @file: vma->vm_file for the mapping @@ -397,6 +407,7 @@ void
>> > > >vdpa_set_config(struct vdpa_device *dev, unsigned int offset,
>> > > >  * @dev_add: Add a vdpa device using alloc and register
>> > > >  *	     @mdev: parent device to use for device addition
>> > > >  *	     @name: name of the new vdpa device
>> > > >+ *	     @config: config attributes to apply to the device under
>> creation
>> > > >  *	     Driver need to add a new device using _vdpa_register_device()
>> > > >  *	     after fully initializing the vdpa device. Driver must return 0
>> > > >  *	     on success or appropriate error code.
>> > > >@@ -407,7 +418,8 @@ void vdpa_set_config(struct vdpa_device *dev,
>> > > unsigned int offset,
>> > > >  *	     _vdpa_unregister_device().
>> > > >  */
>> > > > struct vdpa_mgmtdev_ops {
>> > > >-	int (*dev_add)(struct vdpa_mgmt_dev *mdev, const char *name);
>> > > >+	int (*dev_add)(struct vdpa_mgmt_dev *mdev, const char *name,
>> > > >+		       const struct vdpa_dev_set_config *config);
>> > > > 	void (*dev_del)(struct vdpa_mgmt_dev *mdev, struct vdpa_device
>> > > *dev);
>> > > > };
>> > > >
>> > > >@@ -416,12 +428,15 @@ struct vdpa_mgmtdev_ops {
>> > > >  * @device: Management parent device
>> > > >  * @ops: operations supported by management device
>> > > >  * @id_table: Pointer to device id table of supported ids
>> > > >+ * @config_attr_mask: bit mask of attributes of type enum
>> > > >+ vdpa_attr
>> > > >that
>> > > >+ *		      management devie support during dev_add
>> callback
>> > >
>> > > s/devie/divice
>> >
>> > I ran checkpatch.pl and also codespell for extra check. None catch it.
>> > good catch :-) Do you use any tool or its your sharp eyes?

No, I did not use tools. I was reading the comments, but these are typos 
that happen to everyone :-) I always mistake vdpa with vpda...

>>
>> OK so v7?
>If you prefer v7 for this small change, I will do it.
>Will wait for little more before sending v7 if Stefano has any more 
>comments in rest of the patches.
>

I reviewed the patches that touch the code I know, but the rest seems 
okay.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
