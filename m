Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6D7C433DB
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 07:02:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 037E264EC3
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 07:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 037E264EC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 861DE83C1A;
	Wed, 24 Feb 2021 07:02:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o6XBbhPBmxXg; Wed, 24 Feb 2021 07:02:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id D741083C34;
	Wed, 24 Feb 2021 07:02:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68989C000A;
	Wed, 24 Feb 2021 07:02:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F761C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 07:02:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 74C554EBC0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 07:02:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E_CCns1YNa-Q
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 07:02:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3238F4EBC1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 07:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614150166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wn8BJOMkVZgfI0O8oDwNGEniOHhpNqesTfpSDqsQz6g=;
 b=hYe58FNh/YfroLItk5rppkpMCc8bQUUy1e+rBFe71kR/FMekgoDXpo6zCw69m+byDxFU7T
 meX7H2Qra0SPlh80A9RTFh0RnXJ4lFCvdWLgiqJp6D0DxakbjQ3oqKGfMEhDusGYYxsHew
 dXfT/zJDfGzbMWPO/NWk3TlyvFAeQe0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-SAK1VXZBNzy2HcFACmJ0oQ-1; Wed, 24 Feb 2021 02:02:44 -0500
X-MC-Unique: SAK1VXZBNzy2HcFACmJ0oQ-1
Received: by mail-wr1-f70.google.com with SMTP id u15so616958wrn.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 23:02:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Wn8BJOMkVZgfI0O8oDwNGEniOHhpNqesTfpSDqsQz6g=;
 b=lWoh/uOdc6XBtVdU4+CoL8c/Ak1w0BkgC1xjLZcbsbKr0roLYsoxWKt746/kB1Qtmt
 HHx7Q/akEy70cZ4qAHiDfxT9FFKZxMTyWYGnwZsgplkVQGJmkrKdZE95Yhy2o3DDsc2P
 3YTma82CteTdmql5a5+KZzpZFpM2Q4k0TzV4EqSh2cuOY8AWLQUMtqIvxA0ZjkTQYRoR
 aAzdLIph/hJR7cgByrTdDOrGSI9sUSKBewnoF0Lb4m5mhvrk8UCQ38Hpc7fNBYF9OOH+
 ilwVYRRaCYKT2WHlWqD26ZjlCS0iDZS9ts4im+o8vfort78K52NapmZIX9qnnvFwm26+
 tI1A==
X-Gm-Message-State: AOAM531arU60Hyeow/TqoVFbZ8x4lVc0IlQquu8F0PBkHGWcJrmWRzgB
 cVkW5sfO3nFVCnNYfad8uO8PVq3+xVkQN6IpJ+hzK4UyV+QNYS8X94Ip66BSwz5hEXEQwP3Ms9e
 tlYcvHpZXN9qljZeLHWUDIsy8rPEy3cJ8HaY0Ld0zjA==
X-Received: by 2002:a05:6000:100f:: with SMTP id
 a15mr30213515wrx.212.1614150162735; 
 Tue, 23 Feb 2021 23:02:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw60IwTUxuXkZi/WTWBBTeVGVAiWa5t1nqbM8oQjcQfv5KFhjqn3fUk5i6JbkubG6mkzynvSw==
X-Received: by 2002:a05:6000:100f:: with SMTP id
 a15mr30213491wrx.212.1614150162501; 
 Tue, 23 Feb 2021 23:02:42 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id v188sm4481478wme.1.2021.02.23.23.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 23:02:42 -0800 (PST)
Date: Wed, 24 Feb 2021 02:02:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH linux-next 2/9] vdpa: Introduce query of device config
 layout
Message-ID: <20210224015805-mutt-send-email-mst@kernel.org>
References: <20210224061844.137776-1-parav@nvidia.com>
 <20210224061844.137776-3-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210224061844.137776-3-parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eli Cohen <elic@nvidia.com>, virtualization@lists.linux-foundation.org
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

On Wed, Feb 24, 2021 at 08:18:37AM +0200, Parav Pandit wrote:
> Introduce a command to query a device config layout.
> 
> An example query of network vdpa device:
> 
> $ vdpa dev add name bar mgmtdev vdpasim_net
> 
> $ vdpa dev config show
> bar: mac 00:35:09:19:48:05 link up link_announce false mtu 1500 speed 0 duplex 0
> 
> $ vdpa dev config show -jp
> {
>     "config": {
>         "bar": {
>             "mac": "00:35:09:19:48:05",
>             "link ": "up",
>             "link_announce ": false,
>             "mtu": 1500,
>             "speed": 0,
>             "duplex": 0
>         }
>     }
> }
> 
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Eli Cohen <elic@nvidia.com>
> ---
> changelog:
> v1->v2:
>  - read whole net config layout instead of individual fields
>  - added error extack for unmanaged vdpa device
> ---
>  drivers/vdpa/vdpa.c       | 181 ++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/vdpa.h |  11 +++
>  2 files changed, 192 insertions(+)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 3d997b389345..cebbba500638 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -14,6 +14,8 @@
>  #include <uapi/linux/vdpa.h>
>  #include <net/genetlink.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/virtio_net.h>
> +#include <linux/virtio_ids.h>
>  
>  static LIST_HEAD(mdev_head);
>  /* A global mutex that protects vdpa management device and device level operations. */
> @@ -603,6 +605,179 @@ static int vdpa_nl_cmd_dev_get_dumpit(struct sk_buff *msg, struct netlink_callba
>  	return msg->len;
>  }
>  
> +static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
> +				       struct sk_buff *msg,
> +				       const struct virtio_net_config *config)
> +{
> +	u32 hash_types;
> +	u16 rss_field;
> +	u64 features;
> +
> +	features = vdev->config->get_features(vdev);
> +	if ((features & (1ULL << VIRTIO_NET_F_MQ)) == 0)
> +		return 0;
> +
> +	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
> +			config->max_virtqueue_pairs))
> +		return -EMSGSIZE;
> +	if (nla_put_u8(msg, VDPA_ATTR_DEV_NET_CFG_RSS_MAX_KEY_LEN,
> +		       config->rss_max_key_size))

Why is it ok to poke at RSS fields without checking the relevant feature bits?

> +		return -EMSGSIZE;

Did you check this with sparse?
max_virtqueue_pairs is __virtio16.

> +
> +	rss_field = le16_to_cpu(config->rss_max_key_size);
> +	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_RSS_MAX_IT_LEN, rss_field))
> +		return -EMSGSIZE;
> +
> +	hash_types = le32_to_cpu(config->supported_hash_types);

unused variable

> +	if (nla_put_u32(msg, VDPA_ATTR_DEV_NET_CFG_RSS_HASH_TYPES,
> +			config->supported_hash_types))
> +		return -EMSGSIZE;
> +	return 0;
> +}
> +
> +static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *msg)
> +{
> +	struct virtio_net_config config = {};
> +
> +	vdev->config->get_config(vdev, 0, &config, sizeof(config));
> +	if (nla_put(msg, VDPA_ATTR_DEV_NET_CFG_MACADDR, sizeof(config.mac), config.mac))
> +		return -EMSGSIZE;
> +	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, config.status))
> +		return -EMSGSIZE;
> +	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, config.mtu))
> +		return -EMSGSIZE;
> +	if (nla_put_u32(msg, VDPA_ATTR_DEV_NET_CFG_SPEED, config.speed))
> +		return -EMSGSIZE;

looks like a bunch of endian-ness/sparse errors to me, and
a bunch of fields checked without checking the feature bits.

> +	if (nla_put_u8(msg, VDPA_ATTR_DEV_NET_CFG_DUPLEX, config.duplex))
> +		return -EMSGSIZE;
> +
> +	return vdpa_dev_net_mq_config_fill(vdev, msg, &config);
> +}
> +
> +static int
> +vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq,
> +		     int flags, struct netlink_ext_ack *extack)
> +{
> +	u32 device_id;
> +	void *hdr;
> +	int err;
> +
> +	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
> +			  VDPA_CMD_DEV_CONFIG_GET);
> +	if (!hdr)
> +		return -EMSGSIZE;
> +
> +	if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev))) {
> +		err = -EMSGSIZE;
> +		goto msg_err;
> +	}
> +
> +	device_id = vdev->config->get_device_id(vdev);
> +	if (nla_put_u32(msg, VDPA_ATTR_DEV_ID, device_id)) {
> +		err = -EMSGSIZE;
> +		goto msg_err;
> +	}
> +
> +	switch (device_id) {
> +	case VIRTIO_ID_NET:
> +		err = vdpa_dev_net_config_fill(vdev, msg);
> +		break;
> +	default:
> +		err = -EOPNOTSUPP;
> +		break;
> +	}
> +	if (err)
> +		goto msg_err;
> +
> +	genlmsg_end(msg, hdr);
> +	return 0;
> +
> +msg_err:
> +	genlmsg_cancel(msg, hdr);
> +	return err;
> +}
> +
> +static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct vdpa_device *vdev;
> +	struct sk_buff *msg;
> +	const char *devname;
> +	struct device *dev;
> +	int err;
> +
> +	if (!info->attrs[VDPA_ATTR_DEV_NAME])
> +		return -EINVAL;
> +	devname = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
> +	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	mutex_lock(&vdpa_dev_mutex);
> +	dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
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
> +	err = vdpa_dev_config_fill(vdev, msg, info->snd_portid, info->snd_seq,
> +				   0, info->extack);
> +	if (!err)
> +		err = genlmsg_reply(msg, info);
> +
> +mdev_err:
> +	put_device(dev);
> +dev_err:
> +	mutex_unlock(&vdpa_dev_mutex);
> +	if (err)
> +		nlmsg_free(msg);
> +	return err;
> +}
> +
> +static int vdpa_dev_config_dump(struct device *dev, void *data)
> +{
> +	struct vdpa_device *vdev = container_of(dev, struct vdpa_device, dev);
> +	struct vdpa_dev_dump_info *info = data;
> +	int err;
> +
> +	if (!vdev->mdev)
> +		return 0;
> +	if (info->idx < info->start_idx) {
> +		info->idx++;
> +		return 0;
> +	}
> +	err = vdpa_dev_config_fill(vdev, info->msg, NETLINK_CB(info->cb->skb).portid,
> +				   info->cb->nlh->nlmsg_seq, NLM_F_MULTI,
> +				   info->cb->extack);
> +	if (err)
> +		return err;
> +
> +	info->idx++;
> +	return 0;
> +}
> +
> +static int
> +vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
> +{
> +	struct vdpa_dev_dump_info info;
> +
> +	info.msg = msg;
> +	info.cb = cb;
> +	info.start_idx = cb->args[0];
> +	info.idx = 0;
> +
> +	mutex_lock(&vdpa_dev_mutex);
> +	bus_for_each_dev(&vdpa_bus, NULL, &info, vdpa_dev_config_dump);
> +	mutex_unlock(&vdpa_dev_mutex);
> +	cb->args[0] = info.idx;
> +	return msg->len;
> +}
> +
>  static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>  	[VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type = NLA_NUL_STRING },
>  	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
> @@ -634,6 +809,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
>  		.doit = vdpa_nl_cmd_dev_get_doit,
>  		.dumpit = vdpa_nl_cmd_dev_get_dumpit,
>  	},
> +	{
> +		.cmd = VDPA_CMD_DEV_CONFIG_GET,
> +		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
> +		.doit = vdpa_nl_cmd_dev_config_get_doit,
> +		.dumpit = vdpa_nl_cmd_dev_config_get_dumpit,
> +	},
>  };
>  
>  static struct genl_family vdpa_nl_family __ro_after_init = {
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 66a41e4ec163..5c31ecc3b956 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -17,6 +17,7 @@ enum vdpa_command {
>  	VDPA_CMD_DEV_NEW,
>  	VDPA_CMD_DEV_DEL,
>  	VDPA_CMD_DEV_GET,		/* can dump */
> +	VDPA_CMD_DEV_CONFIG_GET,	/* can dump */
>  };
>  
>  enum vdpa_attr {
> @@ -33,6 +34,16 @@ enum vdpa_attr {
>  	VDPA_ATTR_DEV_MAX_VQS,			/* u32 */
>  	VDPA_ATTR_DEV_MAX_VQ_SIZE,		/* u16 */
>  
> +	VDPA_ATTR_DEV_NET_CFG_MACADDR,		/* binary */
> +	VDPA_ATTR_DEV_NET_STATUS,		/* u8 */
> +	VDPA_ATTR_DEV_NET_CFG_MAX_VQP,		/* u16 */
> +	VDPA_ATTR_DEV_NET_CFG_MTU,		/* u16 */
> +	VDPA_ATTR_DEV_NET_CFG_SPEED,		/* u16 */
> +	VDPA_ATTR_DEV_NET_CFG_DUPLEX,		/* u16 */
> +	VDPA_ATTR_DEV_NET_CFG_RSS_MAX_KEY_LEN,	/* u8 */
> +	VDPA_ATTR_DEV_NET_CFG_RSS_MAX_IT_LEN,	/* u16 */
> +	VDPA_ATTR_DEV_NET_CFG_RSS_HASH_TYPES,	/* u32 */
> +
>  	/* new attributes must be added above here */
>  	VDPA_ATTR_MAX,
>  };
> -- 
> 2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
