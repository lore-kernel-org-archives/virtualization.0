Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728F5C77B6E
	for <virtualization@archiver.kernel.org>; Thu, 13 Apr 2023 16:25:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F2E7A840FD;
	Thu, 13 Apr 2023 16:25:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F2E7A840FD
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P5LM2TYV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pxht4n4KCotM; Thu, 13 Apr 2023 16:25:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 51B9D840F3;
	Thu, 13 Apr 2023 16:25:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 51B9D840F3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 247EAC0037;
	Thu, 13 Apr 2023 16:25:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D367FC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 16:25:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B5195429BB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 16:25:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B5195429BB
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=P5LM2TYV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LacYWw5q0Jya
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 16:25:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 184ED405D3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 184ED405D3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 16:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681403149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QzP5Sz/J0tccGFdHhbGs5sOUHhnm1xuab76oclPkBc0=;
 b=P5LM2TYVRiDQdOLCemZBH5QnCPtivUvE5M1WpBIo9/M6PnnnLA5GxGYwM/eP16HR0K94SA
 QxTkTA2SYoKRd+cfWTZutxD5phgVoKAIYPpzjpvXetCUVT6lz++fp7wCJKr1nKVsLeXTbV
 //am39SlSlUAx6DmeRBNztxMKMx+NvE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-XNq-fahtO42_dFJTZjyb1Q-1; Thu, 13 Apr 2023 12:25:48 -0400
X-MC-Unique: XNq-fahtO42_dFJTZjyb1Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 t30-20020adfa2de000000b002f575ad4a7cso728571wra.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 09:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681403147; x=1683995147;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QzP5Sz/J0tccGFdHhbGs5sOUHhnm1xuab76oclPkBc0=;
 b=HRkMj7Bex+AzzIgEq1hzQuMx+JUbd5Q8h6vCsq/5MeVIk5a9Z58x5cxj8eQ6FqjFyA
 bkdNSkh9Q/bLQW1FYOexZwIPcmLUHmEt704acg1iVptlJBs9SqOt7WQR4h3l0YigbaS3
 RRRXYxNBKB1d8HpgOHON8vbtkD2VZqtZWssPkrdSsC0SQ/iB23yQR4mrFq6E+DxE+RUa
 H98rEMxp7GfXiJA/hJWl5NN1pn4fc4Jho3onxatqJl3aIa60pu9T5NVwywAGqXTuV0aU
 mSzUGyTXr+gm5zAASz0fPgtZMroal6xOK7X1ruu/WhM4nmSPAYVcPe3Olt0axDSG7yEK
 MQVQ==
X-Gm-Message-State: AAQBX9caBhE9457tHVqtuDdCkz9L4e7mSfxTRn1Jz5tXrZcCLhNfl1c5
 wUUlsrDcxueESndPci5zin2ITcWJE/MFQniAmYZKjqZ6USMHFcE3w0Q1x1NLUsZk3NnHEERo4Mw
 hs01EJuvCdcpgUVlTrMvGvEbfUEnvPkomTTCRBFVuFg==
X-Received: by 2002:a5d:4405:0:b0:2f0:2dbd:dc3f with SMTP id
 z5-20020a5d4405000000b002f02dbddc3fmr2133720wrq.43.1681403146968; 
 Thu, 13 Apr 2023 09:25:46 -0700 (PDT)
X-Google-Smtp-Source: AKy350YakkiXnmsXJr1wAXgIivtlifVtfsJyDI97sZ1EviUV7E6q3QirS5z2K5iJFaxhGOyNCnBQkg==
X-Received: by 2002:a5d:4405:0:b0:2f0:2dbd:dc3f with SMTP id
 z5-20020a5d4405000000b002f02dbddc3fmr2133696wrq.43.1681403146604; 
 Thu, 13 Apr 2023 09:25:46 -0700 (PDT)
Received: from redhat.com ([2a06:c701:742d:fd00:c847:221d:9254:f7ce])
 by smtp.gmail.com with ESMTPSA id
 k1-20020a056000004100b002f5925c7cabsm1597332wrx.75.2023.04.13.09.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Apr 2023 09:25:46 -0700 (PDT)
Date: Thu, 13 Apr 2023 12:25:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next V2 1/2] virtio-net: convert rx mode setting to
 use workqueue
Message-ID: <20230413121525-mutt-send-email-mst@kernel.org>
References: <20230413064027.13267-1-jasowang@redhat.com>
 <20230413064027.13267-2-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230413064027.13267-2-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, david.marchand@redhat.com, davem@davemloft.net
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

On Thu, Apr 13, 2023 at 02:40:26PM +0800, Jason Wang wrote:
> This patch convert rx mode setting to be done in a workqueue, this is
> a must for allow to sleep when waiting for the cvq command to
> response since current code is executed under addr spin lock.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

I don't like this frankly. This means that setting RX mode which would
previously be reliable, now becomes unreliable.
- first of all configuration is no longer immediate
  and there is no way for driver to find out when
  it actually took effect
- second, if device fails command, this is also not
  propagated to driver, again no way for driver to find out 

VDUSE needs to be fixed to do tricks to fix this
without breaking normal drivers.


> ---
> Changes since V1:
> - use RTNL to synchronize rx mode worker
> ---
>  drivers/net/virtio_net.c | 55 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 52 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e2560b6f7980..2e56bbf86894 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -265,6 +265,12 @@ struct virtnet_info {
>  	/* Work struct for config space updates */
>  	struct work_struct config_work;
>  
> +	/* Work struct for config rx mode */
> +	struct work_struct rx_mode_work;
> +
> +	/* Is rx mode work enabled? */
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
> @@ -2310,9 +2330,11 @@ static int virtnet_close(struct net_device *dev)
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
> @@ -2325,6 +2347,8 @@ static void virtnet_set_rx_mode(struct net_device *dev)
>  	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
>  		return;
>  
> +	rtnl_lock();
> +
>  	vi->ctrl->promisc = ((dev->flags & IFF_PROMISC) != 0);
>  	vi->ctrl->allmulti = ((dev->flags & IFF_ALLMULTI) != 0);
>  
> @@ -2342,14 +2366,19 @@ static void virtnet_set_rx_mode(struct net_device *dev)
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
> @@ -2370,6 +2399,8 @@ static void virtnet_set_rx_mode(struct net_device *dev)
>  	netdev_for_each_mc_addr(ha, dev)
>  		memcpy(&mac_data->macs[i++][0], ha->addr, ETH_ALEN);
>  
> +	netif_addr_unlock_bh(dev);
> +
>  	sg_set_buf(&sg[1], mac_data,
>  		   sizeof(mac_data->entries) + (mc_count * ETH_ALEN));
>  
> @@ -2377,9 +2408,19 @@ static void virtnet_set_rx_mode(struct net_device *dev)
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
> @@ -3150,6 +3191,8 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
>  
>  	/* Make sure no work handler is accessing the device */
>  	flush_work(&vi->config_work);
> +	disable_rx_mode_work(vi);
> +	flush_work(&vi->rx_mode_work);
>  
>  	netif_tx_lock_bh(vi->dev);
>  	netif_device_detach(vi->dev);

So now configuration is not propagated to device.
Won't device later wake up in wrong state?


> @@ -3172,6 +3215,7 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>  	virtio_device_ready(vdev);
>  
>  	enable_delayed_refill(vi);
> +	enable_rx_mode_work(vi);
>  
>  	if (netif_running(vi->dev)) {
>  		err = virtnet_open(vi->dev);
> @@ -3969,6 +4013,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	vdev->priv = vi;
>  
>  	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
> +	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
>  	spin_lock_init(&vi->refill_lock);
>  
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
> @@ -4077,6 +4122,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (vi->has_rss || vi->has_rss_hash_report)
>  		virtnet_init_default_rss(vi);
>  
> +	enable_rx_mode_work(vi);
> +
>  	/* serialize netdev register + virtio_device_ready() with ndo_open() */
>  	rtnl_lock();
>  
> @@ -4174,6 +4221,8 @@ static void virtnet_remove(struct virtio_device *vdev)
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
