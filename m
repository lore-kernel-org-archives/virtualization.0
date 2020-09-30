Return-Path: <SRS0=Q6Zn=DH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89CDC47420
	for <virtualization@archiver.kernel.org>; Wed, 30 Sep 2020 10:07:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 299962074A
	for <virtualization@archiver.kernel.org>; Wed, 30 Sep 2020 10:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IFP4H0QP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299962074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CB8678638F;
	Wed, 30 Sep 2020 10:07:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o0ypc1P+KiOp; Wed, 30 Sep 2020 10:07:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 317C586133;
	Wed, 30 Sep 2020 10:07:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 167EFC0890;
	Wed, 30 Sep 2020 10:07:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53140C016F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 10:07:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 40DEF86151
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 10:07:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XyibAa8cwv_M
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 10:07:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2DFF28614A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 10:07:02 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601460421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BwVIHLEWodPVOSsatT81+9zezrxEE2RvlRZKZt8C+R0=;
 b=IFP4H0QPKMSi/WidQRXNQO4QlAb30HsR9U0M6BmIBW3hhtklK7Q9iAxN1CQGnqrffUbKlP
 WiTIiEfMIReVHeiQ5t0piLp8W/NYHdVJ3YlGgx5WLWE6MqIAzlteuhD8n/wkP/v6YQ+ZKb
 8Dmh/KWlAxrp8QJCdTUPa83yS2eZU20=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-vLH6-0EfOMeA9hIHFSuBAg-1; Wed, 30 Sep 2020 06:06:59 -0400
X-MC-Unique: vLH6-0EfOMeA9hIHFSuBAg-1
Received: by mail-wr1-f70.google.com with SMTP id 33so420438wrk.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 03:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BwVIHLEWodPVOSsatT81+9zezrxEE2RvlRZKZt8C+R0=;
 b=P9v02+x+fiXeQBfryMHpwbwVY5tPlaXX47LRc4alPchkqPfaerH4GnSJHVjRkvNPXZ
 1IB2VWNNPXW3dSn/sxRwP6E2xHY5cBV+d/9IcmufdHOYjT5BPdiLQQHNAaKF/UPJhJpe
 wMItN64NrizdNhEBthHILyqKYh4LIrsW+7PoInrH+PreDoo6YLuPCibywX06hh5GBZ1X
 BUjbktny0wzG94areIXUfDEPziDTecUcqkJYKIamCxRuIlXc0GGyKhgg2ucIe3WgQBPL
 HxChNvzBKgUbabtw4rhG/Z4XvBKGEaec9h06zUndJLmUxWiC0KfaZsNaOF8NOFUj+8Vp
 FiNA==
X-Gm-Message-State: AOAM532XKfxU91MgWEyY3GgghrY7PgjgiB7QLU1BDpQgTSkYgLcrVrsO
 4446zAz+bhOFCOousfWXUZJqSU4D8m7zniQ4udb6+rQU9Jb9x4jecQkzzLtEw4r6HX46FSUIGct
 qDYZfHpREc5eUEmGPcGMs6TyxjLKs2lCXShYKHecAyw==
X-Received: by 2002:a5d:44cc:: with SMTP id z12mr2293412wrr.189.1601460417953; 
 Wed, 30 Sep 2020 03:06:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXAUnYauOkE1JQ0+HRkYxCraj5fkodDQ5XeZ6e8HpPC6ihFDym5v/2ZUmtyKsepgbZSrnwrQ==
X-Received: by 2002:a5d:44cc:: with SMTP id z12mr2293384wrr.189.1601460417674; 
 Wed, 30 Sep 2020 03:06:57 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id 70sm1974647wme.15.2020.09.30.03.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 03:06:56 -0700 (PDT)
Date: Wed, 30 Sep 2020 06:06:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: xiangxia.m.yue@gmail.com
Subject: Re: [PATCH net-next v2] virtio-net: ethtool configurable RXCSUM
Message-ID: <20200930060625-mutt-send-email-mst@kernel.org>
References: <20200930020300.62245-1-xiangxia.m.yue@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200930020300.62245-1-xiangxia.m.yue@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Wed, Sep 30, 2020 at 10:03:00AM +0800, xiangxia.m.yue@gmail.com wrote:
> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> 
> Allow user configuring RXCSUM separately with ethtool -K,
> reusing the existing virtnet_set_guest_offloads helper
> that configures RXCSUM for XDP. This is conditional on
> VIRTIO_NET_F_CTRL_GUEST_OFFLOADS.
> 
> If Rx checksum is disabled, LRO should also be disabled.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
> v2:
> * LRO depends the rx csum
> * remove the unnecessary check
> ---
>  drivers/net/virtio_net.c | 49 ++++++++++++++++++++++++++++++----------
>  1 file changed, 37 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 21b71148c532..5407a0106771 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -68,6 +68,8 @@ static const unsigned long guest_offloads[] = {
>  				(1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
>  				(1ULL << VIRTIO_NET_F_GUEST_UFO))
>  
> +#define GUEST_OFFLOAD_CSUM_MASK (1ULL << VIRTIO_NET_F_GUEST_CSUM)
> +
>  struct virtnet_stat_desc {
>  	char desc[ETH_GSTRING_LEN];
>  	size_t offset;
> @@ -2522,29 +2524,49 @@ static int virtnet_get_phys_port_name(struct net_device *dev, char *buf,
>  	return 0;
>  }
>  
> +static netdev_features_t virtnet_fix_features(struct net_device *netdev,
> +					      netdev_features_t features)
> +{
> +	/* If Rx checksum is disabled, LRO should also be disabled.
> +	 * That is life. :)
> +	 */
> +	if (!(features & NETIF_F_RXCSUM))
> +		features &= ~NETIF_F_LRO;
> +
> +	return features;
> +}
> +
>  static int virtnet_set_features(struct net_device *dev,
>  				netdev_features_t features)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> -	u64 offloads;
> +	u64 offloads = vi->guest_offloads &
> +		       vi->guest_offloads_capable;
>  	int err;
>  
> -	if ((dev->features ^ features) & NETIF_F_LRO) {
> -		if (vi->xdp_queue_pairs)
> -			return -EBUSY;
> +	/* Don't allow configuration while XDP is active. */
> +	if (vi->xdp_queue_pairs)
> +		return -EBUSY;
>  
> +	if ((dev->features ^ features) & NETIF_F_LRO) {
>  		if (features & NETIF_F_LRO)
> -			offloads = vi->guest_offloads_capable;
> +			offloads |= GUEST_OFFLOAD_LRO_MASK;
>  		else
> -			offloads = vi->guest_offloads_capable &
> -				   ~GUEST_OFFLOAD_LRO_MASK;
> +			offloads &= ~GUEST_OFFLOAD_LRO_MASK;
> +	}
>  
> -		err = virtnet_set_guest_offloads(vi, offloads);
> -		if (err)
> -			return err;
> -		vi->guest_offloads = offloads;
> +	if ((dev->features ^ features) & NETIF_F_RXCSUM) {
> +		if (features & NETIF_F_RXCSUM)
> +			offloads |= GUEST_OFFLOAD_CSUM_MASK;
> +		else
> +			offloads &= ~GUEST_OFFLOAD_CSUM_MASK;
>  	}
>  
> +	err = virtnet_set_guest_offloads(vi, offloads);
> +	if (err)
> +		return err;
> +
> +	vi->guest_offloads = offloads;
>  	return 0;
>  }
>  
> @@ -2563,6 +2585,7 @@ static const struct net_device_ops virtnet_netdev = {
>  	.ndo_features_check	= passthru_features_check,
>  	.ndo_get_phys_port_name	= virtnet_get_phys_port_name,
>  	.ndo_set_features	= virtnet_set_features,
> +	.ndo_fix_features	= virtnet_fix_features,
>  };
>  
>  static void virtnet_config_changed_work(struct work_struct *work)
> @@ -3013,8 +3036,10 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
>  	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
>  		dev->features |= NETIF_F_LRO;
> -	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)) {
> +		dev->hw_features |= NETIF_F_RXCSUM;
>  		dev->hw_features |= NETIF_F_LRO;
> +	}
>  
>  	dev->vlan_features = dev->features;
>  
> -- 
> 2.23.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
