Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E2E38399C
	for <virtualization@lists.linux.dev>; Mon,  3 Aug 2026 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785775079; cv=none; b=pQNthaFVcb0Ts7kbEyPEwACQxFsprHS1bOpw+W7tTKjvC4Vhwu9B522YroVfBnu/Gj+7pg33HSUMVodIdrCFdGeuS7BOfBqk+tiQhhJg2iVbbqCHpGLJpHrLD73ydfpY4X+aJd8RbOoRkBzTgAJjC2E/2Uzciyg3TggHGC/yRB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785775079; c=relaxed/simple;
	bh=jX3Az3+fX99ZWH+Ur9rGdltR5hWBIyl4+x/apMK8G+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WA6zQUFPZkfLPwbPgxkdrjM0VYUzuvVreS3n7gbmnowPhk/tFx9KWZDOxz/5aNHGIU7rMl/5kOfOfk1iaK+0p0OubrV2Ray27W4NyCzlEVVPU97XBewUeGgZVHJO2jZ2IJ7nEE7euJOeBUbnGx4ECOCnWECIBa6bSeI+71qzti0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GzKVfFIS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GzKVfFIS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785775076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x8FCHZBZLrk/TMZLPtJVaBIhiotGy01B8YQOZQmpfV4=;
	b=GzKVfFISokBjJ2DYzGvr/6lcsbn984P5pZ9haDgQ27CgxNDCc26UnsPjJnJncQANm0RPAT
	v1eTie4XQubjjszZXHCm2Ao8XpCBR4EnCHXMCMr5jEY4ZQOUxU064QUBiIPvpxjlqr08ai
	SPqL06zS9GjHHNUUxE5rNY1doTFv4Qc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-q6NHFar7NyG8v0U5tXBWKA-1; Mon, 03 Aug 2026 12:37:55 -0400
X-MC-Unique: q6NHFar7NyG8v0U5tXBWKA-1
X-Mimecast-MFC-AGG-ID: q6NHFar7NyG8v0U5tXBWKA_1785775074
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-473ac08a6a4so2860509f8f.0
        for <virtualization@lists.linux.dev>; Mon, 03 Aug 2026 09:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785775074; x=1786379874;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x8FCHZBZLrk/TMZLPtJVaBIhiotGy01B8YQOZQmpfV4=;
        b=hxSzkPjgsyfKWzk0lR7/lGtAzt2HmDkiUK1uKSh4MCFeoTa7+mdaNbcuMEKmrn5TwL
         iId1AV4ajR3CCrt4+9yII6ctmEYVKwoSl4eTOXbTMZ07HTxxG+7liTufV9h5S+M3REm+
         B/oONkdnTZ9ZkUnd+0ABAp503RIzzKGmR2cIn+kivOglce+pRx83fdAHgQ5BPje0BwLO
         notBxeibiCkTcmdhFGVvUUE15IqKqixc5sjfRdIuOChaEmpXIcnvkGXHr9ZTgTfKTMvO
         Lbns2v/nrk8eZLoC8GKBrHMJ7OQlFofvT7Co/L1M7CvmkWYW4z/yeA5/GIXcFwAdU67H
         BD/w==
X-Forwarded-Encrypted: i=1; AHgh+RrHYuwcGPZydwcQtYkyA5h2le3qQvhcYR74Bs6yHFWOJ4xwf28G1Tk1N6W/HtgLONmMmi6brN0dBw3YKYql9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwliFQha2PTNerSbZMNxpcIb3l9VH4GhQC5T7qwboHkGoV5V3iU
	CY0eGVJ5fX6feYbHraZAmwciZL22zFutKy27q4aQPjuPQ8ro9vfu6rgKoHGBSjVZiYO+Lp5fugS
	7F+9w9M7UbSyGHFeiRBbSGgJ3gFchaSkUNCqUTzDwOjqL2mu7NFJqKjby1eR0ptcA5f/B
X-Gm-Gg: AR+sD12Dk2Lzu/edM/pY0PqYRdDsM/x/UTyRU0LzVS2SMs6kFhZXnNHqjCSUJDV08Xj
	hBmehdM8dQ7UoYy8FSgup1NA1Gl319o/gQE75m8hRFVT2tyRwBUeiGET0Q/kkbLKdfdXDU41vHI
	CYGNItCVq7pIqzViE9VSMd9jsuaF07KtSg3SmqzxJUJRXkM1qNImqBYia3hAbYtn8/dRlwmjuWG
	zOIrqsn+V/UQHzinHt+Oyxf2MdN9EYGAQdULGoV1IpXjee/Ikyyb6fwg+HjkFZsiZNbgGQkCanE
	slpLWxKcDAKjV/9VjwOJ8gU27jKx75CN6ac6N1VN7LcK0jQlIXsoh6Fs5inpyUz4Fm9Az5RVkS4
	jTjy8UFwHyXfInxrFnXx91Q==
X-Received: by 2002:a05:600c:4e89:b0:495:5e3d:15e1 with SMTP id 5b1f17b1804b1-4980c6788f8mr221835775e9.16.1785775074240;
        Mon, 03 Aug 2026 09:37:54 -0700 (PDT)
X-Received: by 2002:a05:600c:4e89:b0:495:5e3d:15e1 with SMTP id 5b1f17b1804b1-4980c6788f8mr221835075e9.16.1785775073758;
        Mon, 03 Aug 2026 09:37:53 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949f68f95sm6288115e9.0.2026.08.03.09.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 09:37:53 -0700 (PDT)
Date: Mon, 3 Aug 2026 12:37:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shahar Shitrit <shshitrit@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com, yohadt@nvidia.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgg@ziepe.ca,
	kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	edumazet@google.com, danielj@nvidia.com
Subject: Re: [PATCH net-next v21 13/13] virtio_net: Add get ethtool flow
 rules ops
Message-ID: <20260803123507-mutt-send-email-mst@kernel.org>
References: <20260803140721.1871678-1-shshitrit@nvidia.com>
 <20260803140721.1871678-14-shshitrit@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260803140721.1871678-14-shshitrit@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uA-czdak2UHF2gnbfUbvYvniAHIQK-9Emv7uCAgcShs_1785775074
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 03, 2026 at 05:07:21PM +0300, Shahar Shitrit wrote:
> From: Daniel Jurgens <danielj@nvidia.com>
> 
> - Get total number of rules. There's no user interface for this.

For what? Isn't this ETHTOOL_GRXCLSRLCNT ?


> It is
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
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
> ---
>  drivers/net/virtio_net.c | 75 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 236887c7976d..3d5eb716361a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6552,6 +6552,58 @@ static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
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

maybe check rules_per_group_limit too? they are all in 1 group ..

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
> +	xa_for_each(&ff->ethtool.rules, i, eth_rule) {
> +		if (idx == info->rule_cnt)
> +			return -EMSGSIZE;
> +		rule_locs[idx++] = i;
> +	}
> +
> +	info->data = le32_to_cpu(ff->ff_caps->rules_limit);
> +	info->rule_cnt = idx;
> +
> +	return 0;
> +}
> +
>  static size_t get_mask_size(u16 type)
>  {
>  	switch (type) {
> @@ -6570,6 +6622,28 @@ static size_t get_mask_size(u16 type)
>  	return 0;
>  }
>  
> +static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info, u32 *rule_locs)
> +{
> +	struct virtnet_info *vi = netdev_priv(dev);
> +	int rc;
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
> @@ -6611,6 +6685,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
>  	.get_rxfh_fields = virtnet_get_hashflow,
>  	.set_rxfh_fields = virtnet_set_hashflow,
>  	.get_rx_ring_count = virtnet_get_rx_ring_count,
> +	.get_rxnfc = virtnet_get_rxnfc,
>  	.set_rxnfc = virtnet_set_rxnfc,
>  };
>  
> -- 
> 2.49.0

