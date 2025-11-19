Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0588633C535
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763544376; cv=none; b=uUPPcpn9b1DZdEsB97sJ/gsiJK2YXwaS91Z/7eXJE6I+TMMg+WF+MTjwGNUc1L9Jxq5Cs64m5qTcQuy2JiTl1MTXud8cdhVfSjzQ0pC0Aq/PrVQvNQeKAYingJMxH6H53bzLptBNXqWr7EUcSGBMFqREIAXkNWH/wngSTQjg1tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763544376; c=relaxed/simple;
	bh=JJcwz0bx1oxIm6FGLUg4rtPr6fl26Ggcd1mLYOQFhcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ags51U9VLpt2hCQtZRRl0zCp2gM3nYD0ANeTC2V5mW+opOIPlBGX5Z2E6TFuBRxU8kyry/cSMbUZh/bkmgZD7ABDD5j7n4Gbyls6FWT/mfxOX9IwVviSxc4L2296kguDMoq/16gI37y8M0wxtJ4xMvyHeyRHm5RgFcsJM16i3XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gDYZmjeP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDYZmjeP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763544371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kg6w3iuKZwh3LTVuqvZ2tolattLonAtduv2bEj/k2Dk=;
	b=gDYZmjeP5cxxkkcv6BTKC8IB0yqefAjS3klyPPwxXZhtQ9awQkGMrIdtGIgrOYSgW+p9Ka
	zKX+eY71heFf0SiUxeeQrgERFdmdmdOrQvFURUaGjUp7rt4zF3DhyRXno97yUjW9dfCdlX
	XquXgKz8fWQKn48RCt1+2UFCQ3uIbug=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-jza-hSl1PcWgJcTEjMphTw-1; Wed, 19 Nov 2025 04:26:09 -0500
X-MC-Unique: jza-hSl1PcWgJcTEjMphTw-1
X-Mimecast-MFC-AGG-ID: jza-hSl1PcWgJcTEjMphTw_1763544369
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b2b9c7ab6so2967560f8f.2
        for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 01:26:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763544368; x=1764149168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kg6w3iuKZwh3LTVuqvZ2tolattLonAtduv2bEj/k2Dk=;
        b=ScY0mLI4xEUkL0EO2cTQLDi0MTdHLJr1yDon+lVrPPYQgjwE+Z+QbW1QiFhBkGbzX3
         z6AhtA/6t15lariuqQ+IhX6UTky8VGvwIQ3rgJnNuEqZ0dVycjzDRPJumvxInZ5CXIk8
         bY2iE9TApSEZZKJu/AHJMgIpJKTIyLOXMm/1pEicYjLBdPofOQh+ILX4JNlcskAapkYe
         wVHhGP4ME4gvFV0rOiA9jpdCqzb+akpBvFR0QBwSbmmJSdDcRoct2oY/0R4ryoK7rBp2
         /e5gkDifL4CJPaKBNO9aAM4G97eGzEPijs9SPKxjRzBTGjmAVaF9FzcE3dDxGz9PNX1d
         a2Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUgYT9lChwrE9eqKtnH8l8UAqG4Zc4PuLAvzeLEnmTwkEN72AXuXlgtYHMaVXUGLUiDyPK6b/vbIy9TYEGAtQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzluWMKWy13nwn/OHWcdKV/ZtEBNWXb7en6QqNGu8LFtW7O2Du6
	YJjzCzCgBdloBgdnneEqwsvGFH0P1hbBKx7po9mzM9+D9kIIUbbEikFSOeRmwuo3G+495eHeuVS
	+p5IdSsBeR6feBg9oseho2Mm8jnRcQHLMzi/vZc4avt5OHHwqBmd+Vza9KKx/W6BxhdFU
X-Gm-Gg: ASbGncsxT66YN5xzoxJRg4+yGJheOkS89cYXNHfP/0bpMg6OHwBqYIQWBtwyNk9GhUJ
	a7x/L+I/C0OyORNnUAYlWPU/vIve/tiVUZpCEFFGRvVtdNOcuQBvFkxVNyqGZOhVP6D9YTnSHyY
	+goqZbHFJjSiUsTCQ3Zl6vrTu/331Cb3BWpHxlOV2rNE7DK5X+Z4G24WNmLrDL7n1hiiyrE0viB
	ja0aPpL/3ej0qrf9PMKPWiZ8sgNPN5LntvAYDwCHotkV0MpTkw7sb5tGxliZQkSpMcYO65EBPQP
	ynXn2IhJ0/0ughSr2AdJvNX+FhYpUDRHtFO8S0fILBQ/kyyhsQACFqQl/d1DMjMYFyYqDxUwZaY
	tvooBaDIwPWYCACz/f2KsQLWIaXkxrQ==
X-Received: by 2002:a05:6000:1ace:b0:3eb:d906:e553 with SMTP id ffacd0b85a97d-42b595bb7f6mr19172427f8f.55.1763544368496;
        Wed, 19 Nov 2025 01:26:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVomqmKlWReLQMuWyS3MbD3ynvl2oZ2FTnd3twDk8bXDcAPeBlrnIcm3c30fp1inxoAhVROQ==
X-Received: by 2002:a05:6000:1ace:b0:3eb:d906:e553 with SMTP id ffacd0b85a97d-42b595bb7f6mr19172400f8f.55.1763544368034;
        Wed, 19 Nov 2025 01:26:08 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7b12asm36639012f8f.10.2025.11.19.01.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 01:26:07 -0800 (PST)
Date: Wed, 19 Nov 2025 04:26:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 07/12] virtio_net: Implement layer 2 ethtool
 flow rules
Message-ID: <20251119042245-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-8-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251118143903.958844-8-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mZmBxqbq7uAa8yoUTe_HzA9Eg-PntS7yCrkom2VXLhs_1763544369
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 18, 2025 at 08:38:57AM -0600, Daniel Jurgens wrote:

...

> +static int insert_rule(struct virtnet_ff *ff,
> +		       struct virtnet_ethtool_rule *eth_rule,
> +		       u32 classifier_id,
> +		       const u8 *key,
> +		       size_t key_size)
> +{
> +	struct ethtool_rx_flow_spec *fs = &eth_rule->flow_spec;
> +	struct virtio_net_resource_obj_ff_rule *ff_rule;
> +	int err;
> +
> +	ff_rule = kzalloc(sizeof(*ff_rule) + key_size, GFP_KERNEL);
> +	if (!ff_rule)
> +		return -ENOMEM;
> +
> +	/* Intentionally leave the priority as 0. All rules have the same
> +	 * priority.
> +	 */
> +	ff_rule->group_id = cpu_to_le32(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
> +	ff_rule->classifier_id = cpu_to_le32(classifier_id);
> +	ff_rule->key_length = (u8)key_size;
> +	ff_rule->action = fs->ring_cookie == RX_CLS_FLOW_DISC ?
> +					     VIRTIO_NET_FF_ACTION_DROP :
> +					     VIRTIO_NET_FF_ACTION_RX_VQ;
> +	ff_rule->vq_index = fs->ring_cookie != RX_CLS_FLOW_DISC ?
> +					       cpu_to_le16(fs->ring_cookie) : 0;
> +	memcpy(&ff_rule->keys, key, key_size);
> +
> +	err = virtio_admin_obj_create(ff->vdev,
> +				      VIRTIO_NET_RESOURCE_OBJ_FF_RULE,
> +				      fs->location,
> +				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
> +				      0,
> +				      ff_rule,
> +				      sizeof(*ff_rule) + key_size);
> +	if (err)
> +		goto err_ff_rule;
> +
> +	eth_rule->classifier_id = classifier_id;
> +	ff->ethtool.num_rules++;
> +	kfree(ff_rule);
> +
> +	return 0;
> +
> +err_ff_rule:
> +	kfree(ff_rule);
> +
> +	return err;
> +}


...

> +static int build_and_insert(struct virtnet_ff *ff,
> +			    struct virtnet_ethtool_rule *eth_rule)
> +{
> +	struct virtio_net_resource_obj_ff_classifier *classifier;
> +	struct ethtool_rx_flow_spec *fs = &eth_rule->flow_spec;
> +	struct virtio_net_ff_selector *selector;
> +	struct virtnet_classifier *c;
> +	size_t classifier_size;
> +	size_t key_size;
> +	int num_hdrs;
> +	u8 *key;
> +	int err;
> +
> +	calculate_flow_sizes(fs, &key_size, &classifier_size, &num_hdrs);
> +
> +	key = kzalloc(key_size, GFP_KERNEL);
> +	if (!key)
> +		return -ENOMEM;

So key is allocated here ...


> +
> +	/*
> +	 * virtio_net_ff_obj_ff_classifier is already included in the
> +	 * classifier_size.
> +	 */
> +	c = kzalloc(classifier_size +
> +		    sizeof(struct virtnet_classifier) -
> +		    sizeof(struct virtio_net_resource_obj_ff_classifier),
> +		    GFP_KERNEL);
> +	if (!c) {
> +		kfree(key);
> +		return -ENOMEM;
> +	}
> +
> +	c->size = classifier_size;
> +	classifier = &c->classifier;
> +	classifier->count = num_hdrs;
> +	selector = (void *)&classifier->selectors[0];
> +
> +	setup_eth_hdr_key_mask(selector, key, fs);
> +
> +	err = validate_classifier_selectors(ff, classifier, num_hdrs);
> +	if (err)
> +		goto err_key;
> +
> +	err = setup_classifier(ff, c);
> +	if (err)
> +		goto err_classifier;
> +
> +	err = insert_rule(ff, eth_rule, c->id, key, key_size);


... copied by insert_rule


> +	if (err) {
> +		/* destroy_classifier will free the classifier */
> +		destroy_classifier(ff, c->id);
> +		goto err_key;
> +	}
> +


... and apparently never freed?


I think it's because the API of insert_rule is confusing...

> +	return 0;
> +
> +err_classifier:
> +	kfree(c);
> +err_key:
> +	kfree(key);
> +
> +	return err;
> +}
> +

-- 
MST

