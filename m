Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6BD221275
	for <virtualization@lists.linux.dev>; Mon,  3 Nov 2025 03:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762139884; cv=none; b=KWZcqaNNMUXGGzr3aksHsYUaW0LaKafNCOJUcPEXCUeeeGdcTnoYXx3ocwCFAH4Es9IimFSFqOPHUNTM9xTUWtIwcbFDGOraTqCQ6+2Bzy8Jy52z2xkcqhopsm5FI+KhtbWRZkS2KNNiJIAXMP85W/NHHoXoSpBZO/PuA+NEVRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762139884; c=relaxed/simple;
	bh=AFqPKiKYeflG3qycLFqVvJWo9iEpnS2vpmROtlPK5HQ=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=Hhcvp/kWiqpPr8Dh+KDLT4ctoVE3f9wBSCGblFIOrIaGvreT8MQIEAME372W9infCRZ7BeSRY0wV2IHTdwgBFbnoQroZVR4MjUXX5hiW6EkX4xL56kcOf4uTwS34uVhu7gUwUEDh7SCDuQw8FO1yYBZNMeBg87RKYqKpBhqktX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qzVPtegk; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qzVPtegk"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762139879; h=Message-ID:Subject:Date:From:To;
	bh=kYJXIqFb4TlJzit+iSeFvOg1zFTGkHzCb+ov6vRb4hU=;
	b=qzVPtegkwixj7FddartPDAZPMzcBJWap+2sL076jf3NMAEfQH0+jN8biB0mfsIBSfg3iIK1pxzGJjwX85jQHbvb9NV149ykMF8Ft3geOukQ0BVzt5aIX7FLOZ8fouykG3H6aCeGoFWaEpxzcUyIA5QsrWpLEFnVy25PRFbS1ZGs=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WrVn66g_1762139878 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 03 Nov 2025 11:17:58 +0800
Message-ID: <1762139870.9630344-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 12/12] virtio_net: Add get ethtool flow rules ops
Date: Mon, 3 Nov 2025 11:17:50 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: <virtualization@lists.linux.dev>,
 <parav@nvidia.com>,
 <shshitrit@nvidia.com>,
 <yohadt@nvidia.com>,
 <xuanzhuo@linux.alibaba.com>,
 <eperezma@redhat.com>,
 <shameerali.kolothum.thodi@huawei.com>,
 <jgg@ziepe.ca>,
 <kevin.tian@intel.com>,
 <kuba@kernel.org>,
 <andrew+netdev@lunn.ch>,
 <edumazet@google.com>,
 Daniel Jurgens <danielj@nvidia.com>,
 <netdev@vger.kernel.org>,
 <mst@redhat.com>,
 <jasowang@redhat.com>,
 <alex.williamson@redhat.com>,
 <pabeni@redhat.com>
References: <20251027173957.2334-1-danielj@nvidia.com>
 <20251027173957.2334-13-danielj@nvidia.com>
In-Reply-To: <20251027173957.2334-13-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Mon, 27 Oct 2025 12:39:57 -0500, Daniel Jurgens <danielj@nvidia.com> wrote:
> - Get total number of rules. There's no user interface for this. It is
>   used to allocate an appropriately sized buffer for getting all the
>   rules.
>
> - Get specific rule
> $ ethtool -u ens9 rule 0
> 	Filter: 0
> 		Rule Type: UDP over IPv4
> 		Src IP addr: 0.0.0.0 mask: 255.255.255.255
> 		Dest IP addr: 192.168.5.2 mask: 0.0.0.0
> 		TOS: 0x0 mask: 0xff
> 		Src port: 0 mask: 0xffff
> 		Dest port: 4321 mask: 0x0
> 		Action: Direct to queue 16
>
> - Get all rules:
> $ ethtool -u ens9
> 31 RX rings available
> Total 2 rules
>
> Filter: 0
>         Rule Type: UDP over IPv4
>         Src IP addr: 0.0.0.0 mask: 255.255.255.255
>         Dest IP addr: 192.168.5.2 mask: 0.0.0.0
> ...
>
> Filter: 1
>         Flow Type: Raw Ethernet
>         Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
>         Dest MAC addr: 08:11:22:33:44:54 mask: 00:00:00:00:00:00
>
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
> v4: Answered questions about rules_limit overflow with no changes.
> ---
>  drivers/net/virtio_net.c | 78 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 2a24fb601cc1..e01febca8b75 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -307,6 +307,13 @@ static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
>  				       struct ethtool_rx_flow_spec *fs,
>  				       u16 curr_queue_pairs);
>  static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location);
> +static int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
> +					  struct ethtool_rxnfc *info);
> +static int virtnet_ethtool_get_flow(struct virtnet_ff *ff,
> +				    struct ethtool_rxnfc *info);
> +static int
> +virtnet_ethtool_get_all_flows(struct virtnet_ff *ff,
> +			      struct ethtool_rxnfc *info, u32 *rule_locs);
>
>  #define VIRTNET_Q_TYPE_RX 0
>  #define VIRTNET_Q_TYPE_TX 1
> @@ -5645,6 +5652,28 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
>  	return vi->curr_queue_pairs;
>  }
>
> +static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info, u32 *rule_locs)
> +{
> +	struct virtnet_info *vi = netdev_priv(dev);
> +	int rc = 0;
> +
> +	switch (info->cmd) {
> +	case ETHTOOL_GRXCLSRLCNT:
> +		rc = virtnet_ethtool_get_flow_count(&vi->ff, info);
> +		break;
> +	case ETHTOOL_GRXCLSRULE:
> +		rc = virtnet_ethtool_get_flow(&vi->ff, info);
> +		break;
> +	case ETHTOOL_GRXCLSRLALL:
> +		rc = virtnet_ethtool_get_all_flows(&vi->ff, info, rule_locs);
> +		break;
> +	default:
> +		rc = -EOPNOTSUPP;
> +	}
> +
> +	return rc;
> +}
> +
>  static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> @@ -5686,6 +5715,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
>  	.get_rxfh_fields = virtnet_get_hashflow,
>  	.set_rxfh_fields = virtnet_set_hashflow,
>  	.get_rx_ring_count = virtnet_get_rx_ring_count,
> +	.get_rxnfc = virtnet_get_rxnfc,
>  	.set_rxnfc = virtnet_set_rxnfc,
>  };
>
> @@ -7605,6 +7635,54 @@ static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
>  	return err;
>  }
>
> +static int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
> +					  struct ethtool_rxnfc *info)
> +{
> +	if (!ff->ff_supported)
> +		return -EOPNOTSUPP;
> +
> +	info->rule_cnt = ff->ethtool.num_rules;
> +	info->data = le32_to_cpu(ff->ff_caps->rules_limit) | RX_CLS_LOC_SPECIAL;
> +
> +	return 0;
> +}
> +
> +static int virtnet_ethtool_get_flow(struct virtnet_ff *ff,
> +				    struct ethtool_rxnfc *info)
> +{
> +	struct virtnet_ethtool_rule *eth_rule;
> +
> +	if (!ff->ff_supported)
> +		return -EOPNOTSUPP;
> +
> +	eth_rule = xa_load(&ff->ethtool.rules, info->fs.location);
> +	if (!eth_rule)
> +		return -ENOENT;
> +
> +	info->fs = eth_rule->flow_spec;
> +
> +	return 0;
> +}
> +
> +static int
> +virtnet_ethtool_get_all_flows(struct virtnet_ff *ff,
> +			      struct ethtool_rxnfc *info, u32 *rule_locs)
> +{
> +	struct virtnet_ethtool_rule *eth_rule;
> +	unsigned long i = 0;
> +	int idx = 0;
> +
> +	if (!ff->ff_supported)
> +		return -EOPNOTSUPP;
> +
> +	xa_for_each(&ff->ethtool.rules, i, eth_rule)
> +		rule_locs[idx++] = i;
> +
> +	info->data = le32_to_cpu(ff->ff_caps->rules_limit);
> +
> +	return 0;
> +}
> +
>  static size_t get_mask_size(u16 type)
>  {
>  	switch (type) {
> --
> 2.50.1
>
