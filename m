Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EC2C433DB
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 06:56:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF6064EC3
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 06:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF6064EC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B42E4EBD2;
	Wed, 24 Feb 2021 06:56:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v5UaSfMlfvqX; Wed, 24 Feb 2021 06:56:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9323E4EBC1;
	Wed, 24 Feb 2021 06:56:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E578C000C;
	Wed, 24 Feb 2021 06:56:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CDDFFC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:56:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ADA8D83C86
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:56:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qikWgoMRQAv4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:56:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CFCFC83C85
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614149809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yhu7c6cPqMN8aZBwXgAxaswy9Q0j9opnB0eeTexLisY=;
 b=c2jay39/8fNfjcCXB8s9VrZXihKlbl9jryb1rt2OTGu60YlGb6CMkM9SWuUomJPRwoLt16
 enesl6O4U+I8zg6pIV3h2gtSSCrfRyNkU48fnos+xoM0PS56+wz3gEEWMlMg+yLSzOlAn6
 +lV6GhSfdA/JalN6jqW09c9yu+MQGBc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-hQGiBY0DMxKDVdVC3NYAaQ-1; Wed, 24 Feb 2021 01:56:47 -0500
X-MC-Unique: hQGiBY0DMxKDVdVC3NYAaQ-1
Received: by mail-wm1-f71.google.com with SMTP id p8so156966wmq.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 22:56:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yhu7c6cPqMN8aZBwXgAxaswy9Q0j9opnB0eeTexLisY=;
 b=ciugMskLMo5weXSh8R0aGBrjGv41xkOB5gtZ9PK+Hxe+zBzU+vdtNpS7aijI4sz1gD
 1K/eyDuXdUwI9YuOThJnByuln5aIdfxRwZjtCUAX5ztHu/YLpQfgDBXnZCPGF4er5Dcp
 nAuEypqyGFAkdEnAKIcgItdVXXIU4r/3nBYreURM5W566KSzlpVRnfLqSU8zjvAueVG6
 kJCWgYkAOcYDH57/IjyQqk6FBJGoUN9hph4ylNgGmct0bDYtkGDBMUnGOEIWKqzmcBtf
 dy6UaqECeJKgUr2HOvWvfDufHndWWDVDuEAHjLY9WDM3Hb76vHUInnrf3aWNxPvtEv3v
 uSbw==
X-Gm-Message-State: AOAM532/b0USrhkrxKz18GTwkuLr/DfOnlhzK7NK4kO5mly9p/ACHjHb
 +vuJ32b7c4kUj0UvN0S51i/RPY45rWArlBUDJiPRpWTeUWBVJl967WsWW9CwG7HaKTy6HoQQKQ0
 628Ce3KJ3oxFjO5nsN5T/VwauD/GdckMp+4pl1hNOcg==
X-Received: by 2002:a1c:f604:: with SMTP id w4mr2249427wmc.39.1614149806084;
 Tue, 23 Feb 2021 22:56:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzF8E+6oGRE+YN9U8j3/DzDZ72N9QN8ULoQgGtOzuKaRRxic6r76aLaVznOwdvLg6ywn/QQDg==
X-Received: by 2002:a1c:f604:: with SMTP id w4mr2249410wmc.39.1614149805885;
 Tue, 23 Feb 2021 22:56:45 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id q15sm1749202wrr.58.2021.02.23.22.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 22:56:45 -0800 (PST)
Date: Wed, 24 Feb 2021 01:56:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH linux-next 4/9] vdpa_sim_net: Enable user to set mac
 address and mtu
Message-ID: <20210224015220-mutt-send-email-mst@kernel.org>
References: <20210224061844.137776-1-parav@nvidia.com>
 <20210224061844.137776-5-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210224061844.137776-5-parav@nvidia.com>
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

On Wed, Feb 24, 2021 at 08:18:39AM +0200, Parav Pandit wrote:
> Enable user to set the mac address and mtu so that each vdpa device
> can have its own user specified mac address and mtu.
> This is done by implementing the management device's configuration
> layout fields setting callback routine.
> 
> Now that user is enabled to set the mac address, remove the module
> parameter for same.

Will likely break some testing setups ...
Not too hard to keep it around, is it?

> 
> And example of setting mac addr and mtu:
> $ vdpa mgmtdev show
> 
> $ vdpa dev add name bar mgmtdev vdpasim_net
> $ vdpa dev config set bar mac 00:11:22:33:44:55 mtu 9000
> 
> View the config after setting:
> $ vdpa dev config show
> bar: mac 00:11:22:33:44:55 link up link_announce false mtu 9000 speed 0 duplex 0
> 
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 39 ++++++++++++++++------------
>  1 file changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> index 240a5f1306b5..6e941b0e7935 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -29,12 +29,6 @@
>  
>  #define VDPASIM_NET_VQ_NUM	2
>  
> -static char *macaddr;
> -module_param(macaddr, charp, 0);
> -MODULE_PARM_DESC(macaddr, "Ethernet MAC address");
> -
> -static u8 macaddr_buf[ETH_ALEN];
> -
>  static void vdpasim_net_work(struct work_struct *work)
>  {
>  	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
> @@ -113,9 +107,7 @@ static void vdpasim_net_get_config(struct vdpasim *vdpasim, void *config)
>  	struct virtio_net_config *net_config =
>  		(struct virtio_net_config *)config;
>  
> -	net_config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
>  	net_config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
> -	memcpy(net_config->mac, macaddr_buf, ETH_ALEN);
>  }
>  
>  static void vdpasim_net_mgmtdev_release(struct device *dev)
> @@ -134,6 +126,7 @@ static struct device vdpasim_net_mgmtdev_dummy = {
>  
>  static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name)
>  {
> +	struct virtio_net_config *cfg;
>  	struct vdpasim_dev_attr dev_attr = {};
>  	struct vdpasim *simdev;
>  	int ret;
> @@ -152,6 +145,10 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name)
>  	if (IS_ERR(simdev))
>  		return PTR_ERR(simdev);
>  
> +	cfg = simdev->config;
> +	eth_random_addr(cfg->mac);
> +	cfg->mtu = cpu_to_vdpasim16(simdev, 1500);
> +
>  	ret = _vdpa_register_device(&simdev->vdpa);
>  	if (ret)
>  		goto reg_err;

Hmm moving it here is problematic:
this part happens before set_features so I suspect
endian-ness will be wrong for BE hosts ...


> @@ -171,9 +168,25 @@ static void vdpasim_net_dev_del(struct vdpa_mgmt_dev *mdev,
>  	_vdpa_unregister_device(&simdev->vdpa);
>  }
>  
> +static int
> +vdpasim_net_dev_config_set(struct vdpa_mgmt_dev *mdev,
> +			   struct vdpa_device *dev,
> +			   const struct vdpa_dev_config_set_attr *attrs)
> +{
> +	struct vdpasim *simdev = container_of(dev, struct vdpasim, vdpa);
> +	struct virtio_net_config *dev_cfg = simdev->config;
> +
> +	if (attrs->mask.mac_valid)
> +		memcpy(dev_cfg->mac, attrs->cfg.mac, sizeof(dev_cfg->mac));
> +	if (attrs->mask.mtu_valid)
> +		dev_cfg->mtu = cpu_to_vdpasim16(simdev, attrs->cfg.mtu);
> +	return 0;
> +}
> +
>  static const struct vdpa_mgmtdev_ops vdpasim_net_mgmtdev_ops = {
>  	.dev_add = vdpasim_net_dev_add,
> -	.dev_del = vdpasim_net_dev_del
> +	.dev_del = vdpasim_net_dev_del,
> +	.dev_config_set = vdpasim_net_dev_config_set,
>  };
>  
>  static struct virtio_device_id id_table[] = {
> @@ -198,14 +211,6 @@ static int __init vdpasim_net_init(void)
>  {
>  	int ret;
>  
> -	if (macaddr) {
> -		mac_pton(macaddr, macaddr_buf);
> -		if (!is_valid_ether_addr(macaddr_buf))
> -			return -EADDRNOTAVAIL;
> -	} else {
> -		eth_random_addr(macaddr_buf);
> -	}
> -
>  	ret = device_register(&vdpasim_net_mgmtdev);
>  	if (ret)
>  		return ret;
> -- 
> 2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
