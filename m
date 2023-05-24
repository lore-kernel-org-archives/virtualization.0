Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE70C77B73
	for <virtualization@archiver.kernel.org>; Wed, 24 May 2023 09:15:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9588E409B5;
	Wed, 24 May 2023 09:15:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9588E409B5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PEfSeky7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id to275ynmsu20; Wed, 24 May 2023 09:15:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C4F25402E8;
	Wed, 24 May 2023 09:15:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C4F25402E8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A03B0C0035;
	Wed, 24 May 2023 09:15:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F969C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 May 2023 09:15:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6A63461143
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 May 2023 09:15:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6A63461143
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PEfSeky7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KofTloP5nrQw
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 May 2023 09:15:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 54EC1607D0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 54EC1607D0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 May 2023 09:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684919710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3hkGvluokZd4WakcwJ7QYs3rVKN2R+Qvo5TsPCzHhJ8=;
 b=PEfSeky7qeBRY8Qu9y0Oati4mrKZ1Ego50VGBScn9SVtqLSYKdW7MWmL5y+MRk3RwIh2S4
 N/f9pv8a63vM0zHxOrkf7r0kbDf4QCZgZUDjl0tl3cRUcqX6p9v4s8//QvQyn7XwfesGUv
 wR492k2d3uLkFPJyPncOLOnnj2SgsNo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-xRAzGifHPaiFDJj4M8br9Q-1; Wed, 24 May 2023 05:15:08 -0400
X-MC-Unique: xRAzGifHPaiFDJj4M8br9Q-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-307897bc279so362153f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 May 2023 02:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684919708; x=1687511708;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3hkGvluokZd4WakcwJ7QYs3rVKN2R+Qvo5TsPCzHhJ8=;
 b=USz334yezrhNJXRSQQNcAuMv1LGyM8i8xrDvnA+Im8XvMjE1R6T/zEFsOP/bNlR/Ed
 zilIbWR5GvoW/FekO2UCL+S5meLJytXzNUDiEU9f7L7Do0Yso9gr86jZaMxWkgdhDneo
 Hd02aIWz9QpZYBWu7cixm/khLQsOLSdr2t4Ai6eYh3ozzQlCvYVaGK1JY8+Y3AjkEkqY
 UKg4yx1o2ufNq6au0qmJWA0AlL4mWYslZ7IdpyW6ftwIoglNh/f5igqr7MADowVllIVi
 hx860q7CApp/p56GZl5/BaXC9Npl3j6Osy5SxakB7IUEOY234XZ0hasLMhZJDeMX6tSe
 iB6g==
X-Gm-Message-State: AC+VfDwZM1fKMMq6/hIA2y+ossaRMB2CqQM9/4MiXASkbP1EMVIg+Dmg
 u9CrKBW5v+wV33R+GFuA1uT7uL01oyGVWOwj3PiUS4d9/e38Jg98It9pDHQ8L7kdX5nkIIXM+sk
 u6bVbdU6YmAEC+3URr2J17CqyYeXD/1YPbNcmP/gPlQ==
X-Received: by 2002:a5d:6145:0:b0:309:4df9:fa19 with SMTP id
 y5-20020a5d6145000000b003094df9fa19mr11480028wrt.23.1684919707861; 
 Wed, 24 May 2023 02:15:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ72mwklu7Hok3zzBwPfcLf9xSxlN8mmEOsWMqCqoghOrOhOz5L7HNzKD5hCSRcShSWlZBWcxQ==
X-Received: by 2002:a5d:6145:0:b0:309:4df9:fa19 with SMTP id
 y5-20020a5d6145000000b003094df9fa19mr11480005wrt.23.1684919707505; 
 Wed, 24 May 2023 02:15:07 -0700 (PDT)
Received: from redhat.com ([2.52.29.218]) by smtp.gmail.com with ESMTPSA id
 q3-20020adff783000000b002e61e002943sm13685876wrp.116.2023.05.24.02.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 02:15:06 -0700 (PDT)
Date: Wed, 24 May 2023 05:15:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 net-next 1/2] virtio-net: convert rx mode setting to
 use workqueue
Message-ID: <20230524050604-mutt-send-email-mst@kernel.org>
References: <20230524081842.3060-1-jasowang@redhat.com>
 <20230524081842.3060-2-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230524081842.3060-2-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Wed, May 24, 2023 at 04:18:41PM +0800, Jason Wang wrote:
> This patch convert rx mode setting to be done in a workqueue, this is
> a must for allow to sleep when waiting for the cvq command to
> response since current code is executed under addr spin lock.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes since V1:
> - use RTNL to synchronize rx mode worker
> ---
>  drivers/net/virtio_net.c | 55 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 52 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 56ca1d270304..5d2f1da4eaa0 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -265,6 +265,12 @@ struct virtnet_info {
>  	/* Work struct for config space updates */
>  	struct work_struct config_work;
>  
> +	/* Work struct for config rx mode */

With a bit less abbreviation maybe? setting rx mode?

> +	struct work_struct rx_mode_work;
> +
> +	/* Is rx mode work enabled? */

Ugh not a great comment.

> +	bool rx_mode_work_enabled;
> +



>  	/* Does the affinity hint is set for virtqueues? */
>  	bool affinity_hint_set;
>  
> @@ -388,6 +394,20 @@ static void disable_delayed_refill(struct virtnet_info *vi)
>  	spin_unlock_bh(&vi->refill_lock);
>  }
>  
> +static void enable_rx_mode_work(struct virtnet_info *vi)
> +{
> +	rtnl_lock();
> +	vi->rx_mode_work_enabled = true;
> +	rtnl_unlock();
> +}
> +
> +static void disable_rx_mode_work(struct virtnet_info *vi)
> +{
> +	rtnl_lock();
> +	vi->rx_mode_work_enabled = false;
> +	rtnl_unlock();
> +}
> +
>  static void virtqueue_napi_schedule(struct napi_struct *napi,
>  				    struct virtqueue *vq)
>  {
> @@ -2341,9 +2361,11 @@ static int virtnet_close(struct net_device *dev)
>  	return 0;
>  }
>  
> -static void virtnet_set_rx_mode(struct net_device *dev)
> +static void virtnet_rx_mode_work(struct work_struct *work)
>  {
> -	struct virtnet_info *vi = netdev_priv(dev);
> +	struct virtnet_info *vi =
> +		container_of(work, struct virtnet_info, rx_mode_work);
> +	struct net_device *dev = vi->dev;
>  	struct scatterlist sg[2];
>  	struct virtio_net_ctrl_mac *mac_data;
>  	struct netdev_hw_addr *ha;
> @@ -2356,6 +2378,8 @@ static void virtnet_set_rx_mode(struct net_device *dev)
>  	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
>  		return;
>  
> +	rtnl_lock();
> +
>  	vi->ctrl->promisc = ((dev->flags & IFF_PROMISC) != 0);
>  	vi->ctrl->allmulti = ((dev->flags & IFF_ALLMULTI) != 0);
>  
> @@ -2373,14 +2397,19 @@ static void virtnet_set_rx_mode(struct net_device *dev)
>  		dev_warn(&dev->dev, "Failed to %sable allmulti mode.\n",
>  			 vi->ctrl->allmulti ? "en" : "dis");
>  
> +	netif_addr_lock_bh(dev);
> +
>  	uc_count = netdev_uc_count(dev);
>  	mc_count = netdev_mc_count(dev);
>  	/* MAC filter - use one buffer for both lists */
>  	buf = kzalloc(((uc_count + mc_count) * ETH_ALEN) +
>  		      (2 * sizeof(mac_data->entries)), GFP_ATOMIC);
>  	mac_data = buf;
> -	if (!buf)
> +	if (!buf) {
> +		netif_addr_unlock_bh(dev);
> +		rtnl_unlock();
>  		return;
> +	}
>  
>  	sg_init_table(sg, 2);
>  
> @@ -2401,6 +2430,8 @@ static void virtnet_set_rx_mode(struct net_device *dev)
>  	netdev_for_each_mc_addr(ha, dev)
>  		memcpy(&mac_data->macs[i++][0], ha->addr, ETH_ALEN);
>  
> +	netif_addr_unlock_bh(dev);
> +
>  	sg_set_buf(&sg[1], mac_data,
>  		   sizeof(mac_data->entries) + (mc_count * ETH_ALEN));
>  
> @@ -2408,9 +2439,19 @@ static void virtnet_set_rx_mode(struct net_device *dev)
>  				  VIRTIO_NET_CTRL_MAC_TABLE_SET, sg))
>  		dev_warn(&dev->dev, "Failed to set MAC filter table.\n");
>  
> +	rtnl_unlock();
> +
>  	kfree(buf);
>  }
>  
> +static void virtnet_set_rx_mode(struct net_device *dev)
> +{
> +	struct virtnet_info *vi = netdev_priv(dev);
> +
> +	if (vi->rx_mode_work_enabled)
> +		schedule_work(&vi->rx_mode_work);
> +}
> +

>  static int virtnet_vlan_rx_add_vid(struct net_device *dev,
>  				   __be16 proto, u16 vid)
>  {
> @@ -3181,6 +3222,8 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
>  
>  	/* Make sure no work handler is accessing the device */
>  	flush_work(&vi->config_work);
> +	disable_rx_mode_work(vi);
> +	flush_work(&vi->rx_mode_work);
>  
>  	netif_tx_lock_bh(vi->dev);
>  	netif_device_detach(vi->dev);

Hmm so queued rx mode work will just get skipped
and on restore we get a wrong rx mode.
Any way to make this more robust?


> @@ -3203,6 +3246,7 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>  	virtio_device_ready(vdev);
>  
>  	enable_delayed_refill(vi);
> +	enable_rx_mode_work(vi);
>  
>  	if (netif_running(vi->dev)) {
>  		err = virtnet_open(vi->dev);
> @@ -4002,6 +4046,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	vdev->priv = vi;
>  
>  	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
> +	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
>  	spin_lock_init(&vi->refill_lock);
>  
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
> @@ -4110,6 +4155,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (vi->has_rss || vi->has_rss_hash_report)
>  		virtnet_init_default_rss(vi);
>  
> +	enable_rx_mode_work(vi);
> +
>  	/* serialize netdev register + virtio_device_ready() with ndo_open() */
>  	rtnl_lock();
>  
> @@ -4207,6 +4254,8 @@ static void virtnet_remove(struct virtio_device *vdev)
>  
>  	/* Make sure no work handler is accessing the device. */
>  	flush_work(&vi->config_work);
> +	disable_rx_mode_work(vi);
> +	flush_work(&vi->rx_mode_work);
>  
>  	unregister_netdev(vi->dev);
>  
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
