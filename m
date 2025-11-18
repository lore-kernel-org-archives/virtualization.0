Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FE313AD26
	for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763491788; cv=none; b=ZNy6wkULigs6WKdcMdIo7JIDdtJniufdtZ28FIvHY6ASs8hGrdFb7If2pLiEwA4w8XIy0nRTOv2Az44a3wXOkBEGYTmFAX34lD5UHZM2wpWsvDq6WwY3eDTm6pmpBdHN4y8JzNUJV9CbM8jTtGpTdQGy7kBMQlO3jrk8W5N2yNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763491788; c=relaxed/simple;
	bh=k/01VW6wSAnS5LXvMXlAe3a52i54rssBpJnkFEM6ttQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KXEpHHLVkxpCVdj3Fkk2cqYEwJDav5TYtDvspVllITCJe78X3tfGDZclfhxRQdgM84KSH6uRqO6SGFZJ7NRqdfvGbqIWJsvHpjOuOc2xrrw2o7wvZKzE7IiLwCZ436PDO9O76FdkpOrNiM1jJt9UWTo5IYIGqAxvgsZHEeERukw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fsW35D2n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fsW35D2n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763491785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sm8E3EsTnKYcy8dOxUUvnQCar1Vy4//572axcWJFxJw=;
	b=fsW35D2nqtrE/4RhqyuU7eYB92s6O8TzlcjLYX3LP0YJCuW3X3wBdUVGEvJ4tnGTMQymZ2
	0nhynKiDLj1wN5ZQIKKf2npOCMT/sw/C592lLmDsvrWFQpe+1wng3Ss4DiA1sFhu6R87Ll
	2V4gS9W6Q16jRhFUzXcenbg+ILjARlY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-iFsu8C7rPrmkWNzw4K7P5w-1; Tue, 18 Nov 2025 13:49:44 -0500
X-MC-Unique: iFsu8C7rPrmkWNzw4K7P5w-1
X-Mimecast-MFC-AGG-ID: iFsu8C7rPrmkWNzw4K7P5w_1763491783
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5958540660bso158779e87.0
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 10:49:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763491782; x=1764096582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sm8E3EsTnKYcy8dOxUUvnQCar1Vy4//572axcWJFxJw=;
        b=Ur7ophrHN2hnsqOVPAlLipq4dJuE0RMkAPNHNFe4R2FU6lBVCeOYzFNrSCnMzSY9Bn
         9TVH6zcaFvmPC3q7rWxRBicEkqIgzZXEJaEY3riTdsvwVq2KZS+eMQLbn6MNg13KO+Ge
         rhKqCNaGdatdTadlrxCKICCEc9MCvhbRKJNpFoAzGBwTBh/5d03vzftDsq4s1+g0FA8l
         rzM9x+R8QRCymNVdlpGKycJOfD9EgJnU2X5hJfnHZtzeCi9os1Ci2xcv7IY3vbGYuFb5
         CFEjTRGCOViXogXlcXBE+KqT9XETDURfwSxCEoQufBwIFJe4oLtV8wBYFW/GhBGUSP4w
         HNLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQg1mYcJ89b4VCtUMBA+i1DNyZ6DMl2vD4nU+w+81QuONaPoBHcpqY4y6IK1vUkeP+XaBvGuZKJxkNKQgUAA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLNLmveluQP9qMKYoPrw3p1tVYYdMS1JQOE7ykQKJK+40s1b7J
	H9dgU+znqN3duhqui8g9V1OtiXxdI9lvRTMOcxJU5XP4aACjQ0HH4i6JM2cNEQikyxpzOcI95+a
	VT+rIjwMxhOA4R6HvDjrD077cCG9hfuC+K/TK2ukSetJPrhSzVSUjLxOaP+gyYqy4hI3KRZ18Km
	55
X-Gm-Gg: ASbGnctDWC4SRVi/jxqmCf2J9goyzRhgZ8gi3dp5P9Q3eZR+ioAEQDM6OS0wBJPbMk8
	/jeefPUGiYBP+dnq1+DD80v1Uyj6wFR3ctKXDa8thPi8re4vzOqgZkQMWhRGGbLJbqdvReE5qjS
	6/i+jBFk2y9pe5lXkEDWmCG3TCeZ4Dsh4L9yaaZtdbMWVtQO9MQbHkPcM4h2rxiuk2XtTZk8vVf
	csgRtJwkzv69xI/eGx5Rth3InBGykYnee9xAqQtxRj97il1pbT3x1BqKKaVWrN+fNS5+uZXNp2s
	YODVp9KPIakm10wzO5yYNjx4atJ7lT82hY/x9h7aV+/vktJxA4dG+rteb0rKfnxB8Q8xGKJh1/J
	ykn7z3gL6UFK5QNoPPA9kLnCLvyx3cQ==
X-Received: by 2002:ac2:51c7:0:b0:595:9923:6fda with SMTP id 2adb3069b0e04-5959da1dc38mr182584e87.25.1763491778521;
        Tue, 18 Nov 2025 10:49:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsrexO0cI8ZHsSH500aol8V/mcze8JmHQE6WbTYUxEzn8EY9TuDWhyJpecadlGPktlWo1TUw==
X-Received: by 2002:ac2:51c7:0:b0:595:9923:6fda with SMTP id 2adb3069b0e04-5959da1dc38mr182559e87.25.1763491777816;
        Tue, 18 Nov 2025 10:49:37 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-595803b305bsm4047096e87.28.2025.11.18.10.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:49:37 -0800 (PST)
Date: Tue, 18 Nov 2025 13:49:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 12/12] virtio_net: Add get ethtool flow
 rules ops
Message-ID: <20251118134544-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-13-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251118143903.958844-13-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C-h-wHYy0RUV51fCmF7VJpAArSQOtSDAxvcRWW3gOH0_1763491783
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 18, 2025 at 08:39:02AM -0600, Daniel Jurgens wrote:
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
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> v4: Answered questions about rules_limit overflow with no changes.
> ---
>  drivers/net/virtio_net.c | 78 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 17e33927f434..5823ba12f1eb 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -306,6 +306,13 @@ static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
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
> @@ -5665,6 +5672,28 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
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
> @@ -5706,6 +5735,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
>  	.get_rxfh_fields = virtnet_get_hashflow,
>  	.set_rxfh_fields = virtnet_set_hashflow,
>  	.get_rx_ring_count = virtnet_get_rx_ring_count,
> +	.get_rxnfc = virtnet_get_rxnfc,
>  	.set_rxnfc = virtnet_set_rxnfc,
>  };
>  
> @@ -7625,6 +7655,54 @@ static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
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

So I see


 * For %ETHTOOL_GRXCLSRLALL, @rule_cnt specifies the array size of the
 * user buffer for @rule_locs on entry.  On return, @data is the size
 * of the rule table, @rule_cnt is the number of defined rules, and
 * @rule_locs contains the locations of the defined rules.  Drivers
 * must use the second parameter to get_rxnfc() instead of @rule_locs.
 *


Should this set @rule_cnt?





> +
>  static size_t get_mask_size(u16 type)
>  {
>  	switch (type) {
> -- 
> 2.50.1

