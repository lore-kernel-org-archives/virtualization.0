Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F954332623
	for <virtualization@lists.linux.dev>; Mon,  3 Aug 2026 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785772273; cv=none; b=GX2Ryf2h5qu07Xah0qkdmVleE2EGYTuCwlPKxDhd6pLctn3ThohmJEy3s+5MQk3vhnT+szaTgeBclHd/6cBy/Bcr2OaN430x+oknVlKx5qkBeG9ZI0+KA0pRbmtEpYmFCUe/95fhwzlX2TpKWMOoGpEZLrQnUnQxnOBeonUpMsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785772273; c=relaxed/simple;
	bh=5UVMqz9ifbUcVmfoiJVWCbJshAAjsO99SAdP3jQDmR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=e+uasN/3bn4Kb3/atZx3m6DnghP/MkiErqTiz30sGp8T2s2BrcAJLraUn38KffJ8dO9KmgFpEUlmtRTtHcXY3ite1lZVw9L9wG1RJ3jwaxFRF/f1GakMRUpH3A/xsCb1IZMwct4JAKTarHyLKiPVsDe0DLQ/0Q747sSM9oIaqXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZA/c/iLL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZA/c/iLL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785772270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XFUzp4dc+/cQvvo30PRAIxZxQ2fHhdOz96PJlHT4h/8=;
	b=ZA/c/iLLPl1Dtym/m4WfFuvYivGB3akkAM7RKl2DYjLdC10RzMp0sGMpwzk8CjJMYu27wP
	dtVGh7sSsRdPc1VpCCfGxLpw3q1yi08YIh0li6aeWeb7U9w7NUCneKZpezzb5DXvEfUug1
	sGru5ljrBwn/JyrVz/D+Z4+4JSqyIKw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-iEFJh4ZRO_a5PGUcaKUkrg-1; Mon, 03 Aug 2026 11:51:08 -0400
X-MC-Unique: iEFJh4ZRO_a5PGUcaKUkrg-1
X-Mimecast-MFC-AGG-ID: iEFJh4ZRO_a5PGUcaKUkrg_1785772268
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-475e540a0ffso2315954f8f.3
        for <virtualization@lists.linux.dev>; Mon, 03 Aug 2026 08:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785772267; x=1786377067;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XFUzp4dc+/cQvvo30PRAIxZxQ2fHhdOz96PJlHT4h/8=;
        b=TE89zVU1gHj8B/0LU3/QTHWJfv1ETdvPYN1Ek9SO7wnYWj2zMk78fWemEYpN+FtV5x
         QZ9atIYQyV2WMeBDF5tn8ZIgWEP1Od/SHUuEErcpE0QyKe+bumk381U2szy7ys4tndqA
         EHgEIG+CUtwPkiz0RnLGscYseITgGZiDrstKvIwyzXGHowSa9OuLbBP20lwAnQ8Sl97p
         dOxStH0frTDF+lAPUSLEpLYPOHELR0Xe2fJmeRejGAR6Yr/8SzcUMyaYE/TWwZVNwmGf
         TVxCs+Tg3khE+5GvY3hho7TDm9ZmHP1pfzLpT/SFd9z4dqOUPkcir4faDXkEluQ43I2l
         Sv4w==
X-Forwarded-Encrypted: i=1; AHgh+Rqr1rYkRYbCjgv357ocs0J6bz98k95DB/WBmqa715G25BBowFB2Qe9W+puhaaQxCSWsHFYlw0w6NnJlE2+J2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy46FpDRlZV7t7zrVxIwCP8rUtIPw6PX9iV4Sbm0l7km3GZZKju
	fGZOeinK/oPNdb4zjcAjlFasmPCXEPagwSWx2cJ6qMD7eKdUPAajLuKee3ETSqIs3GeyKxw4xGY
	JyKEXQ5yCaFAadn/N4L7p7o+/tc5ZqC9wtBvnNnytedyHk2syO/SviKEQmlAhaU9JCo1X90t1q8
	M9
X-Gm-Gg: AR+sD11yEjA4ei8N91E5l3AgmRkQB1nM6unbTRRzQJz6SUaoeR5C2bxr/KelmINxihd
	TFo/CPfmHm8CUJDN/hSvrad8t1MxoLpJiR5M6TqsntNimT5aX1l7ocT6VVpd5RrkdKaRfihxVFW
	d/GaNRiOnZaGGEywynZy2KC4aVMQFOoCTMjsSE5AWRIzr70DOaPdtWLOtR2DZbRx5FEzUvsZYIL
	3YMNXTU3Y5HcU8vPrJldK3dBgnNaAz7U2boXsDT9zSVwPgk2DGdT2hh/iCL4n3C2ytGzLEnWagM
	DZM1AVFAPGpP1Fu2XAKQfbll0Sh2M8qBmwFKNey9HekxkokAoV4jbnjH0zmCyXsp9mOEUtGRet3
	MTEfWdxeAmC661X3xjaYHfQ==
X-Received: by 2002:a05:6000:184b:b0:47f:9171:bca2 with SMTP id ffacd0b85a97d-47fd72e9a25mr26624609f8f.27.1785772267534;
        Mon, 03 Aug 2026 08:51:07 -0700 (PDT)
X-Received: by 2002:a05:6000:184b:b0:47f:9171:bca2 with SMTP id ffacd0b85a97d-47fd72e9a25mr26624518f8f.27.1785772266917;
        Mon, 03 Aug 2026 08:51:06 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd64eef60sm29191583f8f.16.2026.08.03.08.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 08:51:06 -0700 (PDT)
Date: Mon, 3 Aug 2026 11:51:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shahar Shitrit <shshitrit@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com, yohadt@nvidia.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgg@ziepe.ca,
	kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	edumazet@google.com, danielj@nvidia.com
Subject: Re: [PATCH net-next v21 05/13] virtio_net: Query and set flow filter
 caps
Message-ID: <20260803114115-mutt-send-email-mst@kernel.org>
References: <20260803140721.1871678-1-shshitrit@nvidia.com>
 <20260803140721.1871678-6-shshitrit@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260803140721.1871678-6-shshitrit@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nfvDhqI2ps8-Qs8Xj1KVTEvlNXYd9AlB9vpEl7figg8_1785772268
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 03, 2026 at 05:07:13PM +0300, Shahar Shitrit wrote:
> When probing a virtnet device, attempt to read the flow filter
> capabilities. In order to use the feature the caps must also
> be set. For now setting what was read is sufficient.
> 
> This patch adds uapi definitions virtio_net flow filters define in
> version 1.4 of the VirtIO spec.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
> ---
>  drivers/net/virtio_net.c           | 239 +++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_net_ff.h |  91 +++++++++++
>  2 files changed, 330 insertions(+)
>  create mode 100644 include/uapi/linux/virtio_net_ff.h
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 3e2a5876c6c8..0d1f5a6cfd12 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -27,6 +27,11 @@
>  #include <net/netdev_queues.h>
>  #include <net/xdp_sock_drv.h>
>  #include <net/page_pool/helpers.h>
> +#include <linux/virtio_admin.h>
> +#include <net/ipv6.h>
> +#include <net/ip.h>
> +#include <uapi/linux/virtio_pci.h>

why would virtio net need pci macros?

> +#include <uapi/linux/virtio_net_ff.h>
>  
>  static int napi_weight = NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
> @@ -282,6 +287,14 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
>  	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
>  };
>  
> +struct virtnet_ff {
> +	struct virtio_device *vdev;
> +	bool ff_supported;
> +	struct virtio_net_ff_cap_data *ff_caps;
> +	struct virtio_net_ff_cap_mask_data *ff_mask;
> +	struct virtio_net_ff_actions *ff_actions;
> +};
> +
>  #define VIRTNET_Q_TYPE_RX 0
>  #define VIRTNET_Q_TYPE_TX 1
>  #define VIRTNET_Q_TYPE_CQ 2
> @@ -474,6 +487,8 @@ struct virtnet_info {
>  
>  	struct virtio_net_rss_config_hdr *rss_hdr;
>  
> +	struct virtnet_ff ff;
> +
>  	/* Must be last as it ends in a flexible-array member. */
>  	TRAILING_OVERLAP(struct virtio_net_rss_config_trailer, rss_trailer, hash_key_data,
>  		u8 rss_hash_key_data[NETDEV_RSS_KEY_LEN];
> @@ -519,6 +534,7 @@ static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
>  static void virtnet_xsk_completed(struct send_queue *sq, int num);
>  static void free_unused_bufs(struct virtnet_info *vi);
>  static void virtnet_del_vqs(struct virtnet_info *vi);
> +static void remove_vq_common(struct virtnet_info *vi);
>  
>  enum virtnet_xmit_type {
>  	VIRTNET_XMIT_TYPE_SKB,
> @@ -5710,6 +5726,199 @@ static const struct netdev_stat_ops virtnet_stat_ops = {
>  	.get_base_stats		= virtnet_get_base_stats,
>  };
>  
> +static size_t get_mask_size(u16 type)
> +{
> +	switch (type) {
> +	case VIRTIO_NET_FF_MASK_TYPE_ETH:
> +		return sizeof(struct ethhdr);
> +	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
> +		return sizeof(struct iphdr);
> +	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
> +		return sizeof(struct ipv6hdr);
> +	case VIRTIO_NET_FF_MASK_TYPE_TCP:
> +		return sizeof(struct tcphdr);
> +	case VIRTIO_NET_FF_MASK_TYPE_UDP:
> +		return sizeof(struct udphdr);
> +	}
> +
> +	return 0;
> +}
> +
> +static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
> +{
> +	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
> +			      sizeof(struct virtio_net_ff_selector) *
> +			      VIRTIO_NET_FF_MASK_TYPE_MAX;
> +	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
> +	struct virtio_net_ff_selector *sel;
> +	unsigned long sel_types = 0;
> +	size_t real_ff_mask_size;
> +	int err;
> +	int i;
> +
> +	if (!vdev->config->admin_cmd_exec)
> +		return -EOPNOTSUPP;
> +
> +	cap_id_list = kzalloc(sizeof(*cap_id_list), GFP_KERNEL);
> +	if (!cap_id_list)
> +		return -ENOMEM;
> +
> +	err = virtio_admin_cap_id_list_query(vdev, cap_id_list);
> +	if (err)
> +		goto err_cap_list;
> +
> +	if (!(VIRTIO_CAP_IN_LIST(cap_id_list,
> +				 VIRTIO_NET_FF_RESOURCE_CAP) &&
> +	      VIRTIO_CAP_IN_LIST(cap_id_list,
> +				 VIRTIO_NET_FF_SELECTOR_CAP) &&
> +	      VIRTIO_CAP_IN_LIST(cap_id_list,
> +				 VIRTIO_NET_FF_ACTION_CAP))) {
> +		err = -EOPNOTSUPP;
> +		goto err_cap_list;
> +	}
> +
> +	ff->ff_caps = kzalloc(sizeof(*ff->ff_caps), GFP_KERNEL);
> +	if (!ff->ff_caps) {
> +		err = -ENOMEM;
> +		goto err_cap_list;
> +	}
> +
> +	err = virtio_admin_cap_get(vdev,
> +				   VIRTIO_NET_FF_RESOURCE_CAP,
> +				   ff->ff_caps,
> +				   sizeof(*ff->ff_caps));
> +
> +	if (err)
> +		goto err_ff;
> +
> +	if (!le32_to_cpu(ff->ff_caps->groups_limit) ||
> +	    !le32_to_cpu(ff->ff_caps->classifiers_limit) ||
> +	    !le32_to_cpu(ff->ff_caps->rules_limit) ||
> +	    !le32_to_cpu(ff->ff_caps->rules_per_group_limit)) {

I am not sure why do we validate these specifically.

Should we then validate selectors_per_classifier_limit too?

> +		err = -EINVAL;
> +		goto err_ff;
> +	}
> +
> +	/* VIRTIO_NET_FF_MASK_TYPE start at 1 */
> +	for (i = 1; i <= VIRTIO_NET_FF_MASK_TYPE_MAX; i++)
> +		ff_mask_size += get_mask_size(i);
> +
> +	ff->ff_mask = kzalloc(ff_mask_size, GFP_KERNEL);
> +	if (!ff->ff_mask) {
> +		err = -ENOMEM;
> +		goto err_ff;
> +	}
> +
> +	err = virtio_admin_cap_get(vdev,
> +				   VIRTIO_NET_FF_SELECTOR_CAP,
> +				   ff->ff_mask,
> +				   ff_mask_size);
> +
> +	if (err)
> +		goto err_ff_mask;
> +
> +	ff->ff_mask->count = min_t(u8, ff->ff_mask->count,
> +				   VIRTIO_NET_FF_MASK_TYPE_MAX);
> +
> +	ff->ff_actions = kzalloc(sizeof(*ff->ff_actions) +
> +					VIRTIO_NET_FF_ACTION_MAX,
> +					GFP_KERNEL);
> +	if (!ff->ff_actions) {
> +		err = -ENOMEM;
> +		goto err_ff_mask;
> +	}
> +
> +	err = virtio_admin_cap_get(vdev,
> +				   VIRTIO_NET_FF_ACTION_CAP,
> +				   ff->ff_actions,
> +				   sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
> +
> +	if (err)
> +		goto err_ff_action;
> +
> +	ff->ff_actions->count = min_t(u8, ff->ff_actions->count,
> +				      VIRTIO_NET_FF_ACTION_MAX);

and here, do we validate count != 0?


> +	err = virtio_admin_cap_set(vdev,
> +				   VIRTIO_NET_FF_RESOURCE_CAP,
> +				   ff->ff_caps,
> +				   sizeof(*ff->ff_caps));
> +	if (err)
> +		goto err_ff_action;
> +
> +	real_ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data);
> +	sel = (void *)&ff->ff_mask->selectors;
> +
> +	for (i = 0; i < ff->ff_mask->count; i++) {
> +		/* If the selector type is unknown it may indicate the spec
> +		 * has been revised to include new types of selectors
> +		 */
> +		if (!sel->type || sel->type > VIRTIO_NET_FF_MASK_TYPE_MAX)
> +			break;
> +
> +		if (sel->length != get_mask_size(sel->type) ||
> +		    test_and_set_bit(sel->type, &sel_types)) {
> +			WARN_ON_ONCE(true);

given we gracefully fail, I'm not sure WARN is justified,
since we don't warn in other validation steps.
However


> +			err = -EINVAL;


the error here is on the device side, not user side, right?
maybe a distinct error to indicate this.

> +			goto err_ff_action;
> +		}
> +		real_ff_mask_size += sizeof(*sel) + sel->length;
> +		if (real_ff_mask_size > ff_mask_size) {
> +			WARN_ON_ONCE(true);
> +			err = -EINVAL;
> +			goto err_ff_action;
> +		}
> +		sel = (void *)sel + sizeof(*sel) + sel->length;
> +	}
> +	ff->ff_mask->count = i;
> +
> +	err = virtio_admin_cap_set(vdev,
> +				   VIRTIO_NET_FF_SELECTOR_CAP,
> +				   ff->ff_mask,
> +				   real_ff_mask_size);
> +	if (err)
> +		goto err_ff_action;
> +
> +	err = virtio_admin_cap_set(vdev,
> +				   VIRTIO_NET_FF_ACTION_CAP,
> +				   ff->ff_actions,
> +				   sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);


why not ff->ff_mask->count? this is all we initialized...

> +	if (err)
> +		goto err_ff_action;
> +
> +	ff->vdev = vdev;
> +	ff->ff_supported = true;
> +
> +	kfree(cap_id_list);
> +
> +	return 0;
> +
> +err_ff_action:
> +	kfree(ff->ff_actions);
> +	ff->ff_actions = NULL;
> +err_ff_mask:
> +	kfree(ff->ff_mask);
> +	ff->ff_mask = NULL;
> +err_ff:
> +	kfree(ff->ff_caps);
> +	ff->ff_caps = NULL;
> +err_cap_list:
> +	kfree(cap_id_list);
> +
> +	return err;
> +}
> +
> +static void virtnet_ff_cleanup(struct virtnet_ff *ff)
> +{
> +	if (!ff->ff_supported)
> +		return;
> +
> +	kfree(ff->ff_actions);
> +	kfree(ff->ff_mask);
> +	kfree(ff->ff_caps);
> +	ff->ff_supported = false;
> +}
> +
>  static void virtnet_freeze_down(struct virtio_device *vdev)
>  {
>  	struct virtnet_info *vi = vdev->priv;
> @@ -5728,6 +5937,10 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
>  	netif_tx_lock_bh(vi->dev);
>  	netif_device_detach(vi->dev);
>  	netif_tx_unlock_bh(vi->dev);
> +
> +	rtnl_lock();
> +	virtnet_ff_cleanup(&vi->ff);
> +	rtnl_unlock();
>  }
>  
>  static int init_vqs(struct virtnet_info *vi);
> @@ -5757,9 +5970,24 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>  			goto err_destroy_pools;
>  	}
>  
> +	/*
> +	 * Initialize flow filters. Not supported is an acceptable and common
> +	 * return code
> +	 */
> +	rtnl_lock();
> +	err = virtnet_ff_init(&vi->ff, vi->vdev);
> +	if (err && err != -EOPNOTSUPP) {
> +		rtnl_unlock();
> +		virtnet_freeze_down(vi->vdev);
> +		remove_vq_common(vi);
> +		return err;
> +	}
> +	rtnl_unlock();
> +
>  	netif_tx_lock_bh(vi->dev);
>  	netif_device_attach(vi->dev);
>  	netif_tx_unlock_bh(vi->dev);
> +
>  	return 0;
>  
>  err_destroy_pools:
> @@ -7043,6 +7271,15 @@ static int virtnet_probe(struct virtio_device *vdev)
>  
>  	virtio_device_ready(vdev);
>  
> +	/* Initialize flow filters. Not supported is an acceptable and common
> +	 * return code
> +	 */
> +	err = virtnet_ff_init(&vi->ff, vi->vdev);
> +	if (err && err != -EOPNOTSUPP) {
> +		rtnl_unlock();
> +		goto free_unregister_netdev;
> +	}
> +
>  	if (vi->has_rss || vi->has_rss_hash_report) {
>  		if (!virtnet_commit_rss_command(vi)) {
>  			dev_warn(&vdev->dev, "RSS disabled because committing failed.\n");
> @@ -7125,6 +7362,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  
>  free_unregister_netdev:
>  	unregister_netdev(dev);
> +	virtnet_ff_cleanup(&vi->ff);
>  free_failover:
>  	net_failover_destroy(vi->failover);
>  free_page_pools:
> @@ -7175,6 +7413,7 @@ static void virtnet_remove(struct virtio_device *vdev)
>  	virtnet_free_irq_moder(vi);
>  
>  	unregister_netdev(vi->dev);
> +	virtnet_ff_cleanup(&vi->ff);
>  
>  	net_failover_destroy(vi->failover);
>  
> diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
> new file mode 100644
> index 000000000000..f9e771a0baff
> --- /dev/null
> +++ b/include/uapi/linux/virtio_net_ff.h
> @@ -0,0 +1,91 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
> + *
> + * Header file for virtio_net flow filters
> + */
> +#ifndef _LINUX_VIRTIO_NET_FF_H
> +#define _LINUX_VIRTIO_NET_FF_H
> +
> +#include <linux/types.h>
> +#include <linux/stddef.h>
> +
> +#define VIRTIO_NET_FF_RESOURCE_CAP 0x800
> +#define VIRTIO_NET_FF_SELECTOR_CAP 0x801
> +#define VIRTIO_NET_FF_ACTION_CAP 0x802
> +
> +/**
> + * struct virtio_net_ff_cap_data - Flow filter resource capability limits
> + * @groups_limit: maximum number of flow filter groups supported by the device
> + * @classifiers_limit: maximum number of classifiers supported by the device
> + * @rules_limit: maximum number of rules supported device-wide across all groups
> + * @rules_per_group_limit: maximum number of rules allowed in a single group
> + * @last_rule_priority: priority value associated with the lowest-priority rule
> + * @selectors_per_classifier_limit: maximum selectors allowed in one classifier
> + */
> +struct virtio_net_ff_cap_data {
> +	__le32 groups_limit;
> +	__le32 classifiers_limit;
> +	__le32 rules_limit;
> +	__le32 rules_per_group_limit;
> +	__u8 last_rule_priority;
> +	__u8 selectors_per_classifier_limit;
> +	/* private: */
> +	__u8 reserved[2];
> +};
> +
> +/**
> + * struct virtio_net_ff_selector - Selector mask descriptor
> + * @type: selector type, one of VIRTIO_NET_FF_MASK_TYPE_* constants
> + * @flags: selector flags, see VIRTIO_NET_FF_MASK_F_* constants
> + * @reserved: must be set to 0 by the driver and ignored by the device
> + * @length: size in bytes of @mask
> + * @reserved1: must be set to 0 by the driver and ignored by the device
> + * @mask: variable-length mask payload for @type, length given by @length
> + *
> + * A selector describes a header mask that a classifier can apply. The format
> + * of @mask depends on @type.
> + */
> +struct virtio_net_ff_selector {
> +	__u8 type;
> +	__u8 flags;
> +	__u8 reserved[2];
> +	__u8 length;
> +	__u8 reserved1[3];
> +	__u8 mask[] __counted_by(length);
> +};
> +
> +#define VIRTIO_NET_FF_MASK_TYPE_ETH  1
> +#define VIRTIO_NET_FF_MASK_TYPE_IPV4 2
> +#define VIRTIO_NET_FF_MASK_TYPE_IPV6 3
> +#define VIRTIO_NET_FF_MASK_TYPE_TCP  4
> +#define VIRTIO_NET_FF_MASK_TYPE_UDP  5
> +#define VIRTIO_NET_FF_MASK_TYPE_MAX  VIRTIO_NET_FF_MASK_TYPE_UDP
> +
> +/**
> + * struct virtio_net_ff_cap_mask_data - Supported selector mask formats
> + * @count: number of entries in @selectors
> + * @reserved: must be set to 0 by the driver and ignored by the device
> + * @selectors: packed array of struct virtio_net_ff_selector.
> + */
> +struct virtio_net_ff_cap_mask_data {
> +	__u8 count;
> +	__u8 reserved[7];
> +	__u8 selectors[];
> +};
> +
> +#define VIRTIO_NET_FF_MASK_F_PARTIAL_MASK (1 << 0)
> +
> +#define VIRTIO_NET_FF_ACTION_DROP 1
> +#define VIRTIO_NET_FF_ACTION_RX_VQ 2
> +#define VIRTIO_NET_FF_ACTION_MAX  VIRTIO_NET_FF_ACTION_RX_VQ
> +/**
> + * struct virtio_net_ff_actions - Supported flow actions
> + * @count: number of supported actions in @actions
> + * @reserved: must be set to 0 by the driver and ignored by the device
> + * @actions: array of action identifiers (VIRTIO_NET_FF_ACTION_*)
> + */
> +struct virtio_net_ff_actions {
> +	__u8 count;
> +	__u8 reserved[7];
> +	__u8 actions[] __counted_by(count);
> +};
> +#endif
> -- 
> 2.49.0

