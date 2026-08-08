Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347203382F7
	for <virtualization@lists.linux.dev>; Sat,  8 Aug 2026 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786177970; cv=none; b=CUlLtTEIarGQiiNLgftW0n9p3UkgE45pyyQAzq81bGo1fuW9NZm6U6uMU61gs3dMAFiO2P1F5ZTKX0txy6YXEJCaXE6VqXsOYVK5nESb82jBPbVQYB6jFPi0mE9vWOQ3O3789vgFm61JfbRaoLq31zdUYApZr8JKFl6cShyrHa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786177970; c=relaxed/simple;
	bh=erfPTrBfMbY4b/aNL7QZiThmkR/g3Qs7RE3mV3lPFzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=AzrhaTPDa3Ql0jDmtB1xnoTBsqn23EzkNLDVrEhaRiWbmEj8EnFc/92l4mS8LCDGm3CXJrJVW8vnGZRssD+XQuvDgs9s8gr1NFLZ3DeFDY57p1yquuKkacIeQHjszZ+Xd1nWF1ZYWO9rIejDsyQo/jztefZQwxxmmW05eqIz5Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RbjGWk8v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RbjGWk8v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786177967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qJODVPjCODu+Iox4eT9aAOb7RYJ/0RkXxsjTuZ6pISo=;
	b=RbjGWk8v8mfuddI4AcETXjpDnhedXGnBE8RQA51LSoGw3tDbjhpEd8UQkaMzoVSCYXNdHC
	6MHXUNPzb61FaeTgHIs6wWDDVIqejxEyLsaDhJz6ySDkFHNeeE6mMXJNrvGyznVtoX53nf
	Acrih7bIZFR8J7F9uL3uqLipBCPCyNc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-_2gmcBiXPpWbC2xjmzsiLw-1; Sat, 08 Aug 2026 04:32:45 -0400
X-MC-Unique: _2gmcBiXPpWbC2xjmzsiLw-1
X-Mimecast-MFC-AGG-ID: _2gmcBiXPpWbC2xjmzsiLw_1786177964
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f8f8fde2dso189400f8f.0
        for <virtualization@lists.linux.dev>; Sat, 08 Aug 2026 01:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786177964; x=1786782764;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qJODVPjCODu+Iox4eT9aAOb7RYJ/0RkXxsjTuZ6pISo=;
        b=NwjE+vuSWpGspXIeGZDLNVhi+dMEJNEZFqmAXdtnYSLjOqCRgNuDYYbeZ4v0LenW/3
         uI8gG8dpB83FyiNtkKez6SI8BMQyAFjM64sgiT5GQorXfczDStoft2Eo5fu5RvibUaH6
         oM/VjXAyxOJ923hWRa2VgTCjsm6/viQIijzI1dQhidHFaTqfDMa8PYBpEfWBxJvdqrw8
         n4fvOZQO0lVDc9dJZ2ZF2TEy630tPZ663ki56iGgUyn/mM71M7+vb1EaN0go89bcud90
         o7tU9myI0sf93qxaryqxqADkz7a7qTlYHhbRnvMXJjFjw1+uMeqibTaGy+JqVtm55gnb
         kzhw==
X-Forwarded-Encrypted: i=1; AHgh+RpMlwzwCLgL9ZCVTv0VSbhMRcCE05JQetBlhqQMibL2BLet0EB1yc8cr3lqzzUnL7rcPiQkb79eRkUByq7MpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPXbVNMxOrr+6sr1pKfQ6v/oQHVmdeSrfagKIpzEqB+E7PHbLL
	TKfRRqhURrT1n4Maxq0qlTs6H8mZYWolH42YNzwjsveMqAUqBvy6KZpU0qR5v056N/A9fJom5KV
	GBzj44ic+JRl09kaiz4q693U2qSRgxhRMf11QmsX+hvbGC29azz+wxlZaEwyOlrouYz3v
X-Gm-Gg: AR+sD10GcGYkUGoh02eM2nSkJpX6oTHzoWv1vejdJjYMC/sisoWVIFn0QXXCpQwOTBo
	UowNGdGDPumikULEkuw0X4fCvaEErP6j3D7gKuMeP2yi7JwQjppI6UDlYXJDKkI6zbqO95FUm2g
	CAy8h6Px+g3I7/He2b0Y+iWc0IwjPLOcIyPc/o30GwV+Vrh55WukSbIhXw2Wu93vg3hoUJiE4hg
	D9mkLSMQz4mR89QpX8fmIApbUTY9FljRhdHge6ijdfdwvHQLjeNn9nFWBUT7WgWUAgT1r4289GK
	zVG2YZoV34cAC8/KUHgRJmBoYlyrbpvcX/j+XbD8FUV5dhqUPZwQY1Gk+wwiU04f6mpIS9TPnRb
	ACbwDCTkl02T3GTuN1aqNA/pVmjktZPA=
X-Received: by 2002:a05:600c:3ba2:b0:496:c0f6:78d6 with SMTP id 5b1f17b1804b1-4995e07f525mr128342415e9.2.1786177964336;
        Sat, 08 Aug 2026 01:32:44 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba2:b0:496:c0f6:78d6 with SMTP id 5b1f17b1804b1-4995e07f525mr128341815e9.2.1786177963849;
        Sat, 08 Aug 2026 01:32:43 -0700 (PDT)
Received: from redhat.com (bzq-79-177-145-168.red.bezeqint.net. [79.177.145.168])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021506cbsm13744768f8f.14.2026.08.08.01.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 01:32:43 -0700 (PDT)
Date: Sat, 8 Aug 2026 04:32:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Xiong Weimin <xiongweimin@kylinos.cn>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_net: roll back RSS state on control failure
Message-ID: <20260808042344-mutt-send-email-mst@kernel.org>
References: <20260804073654.1293243-1-xiongweimin@kylinos.cn>
 <20260807181916.63395d4f@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260807181916.63395d4f@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QzyOrcS6xUTkzkYvlycjrurra3iYj_5wToiZxp14IUY_1786177964
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 07, 2026 at 06:19:16PM -0700, Jakub Kicinski wrote:
> On Tue,  4 Aug 2026 15:36:54 +0800 Xiong Weimin wrote:
> > The ethtool RSS and RXHASH paths update the driver's cached RSS state
> > before committing the change to the device.  If the control virtqueue
> > command fails, the cached hash types, key or indirection table can then
> > report a configuration that the device did not accept.
> > 
> > Preserve the previous local state around RSS/hash control commands and
> > restore it when the device update fails, while propagating the error to
> > the caller.
> 
> I guess.. saving the data and then copying it back doesn't seem super
> clean but I guess since we DMA directly from the info struct..
> 
> Michael, Jason, looks okay? 
> 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 3e2a5876c..ccd96315a 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -4295,6 +4295,7 @@ static int virtnet_set_hashflow(struct net_device *dev,
> >  				struct netlink_ext_ack *extack)
> >  {
> >  	struct virtnet_info *vi = netdev_priv(dev);
> > +	u32 old_hashtypes = vi->rss_hash_types_saved;
> >  	u32 new_hashtypes = vi->rss_hash_types_saved;
> >  	bool is_disable = info->data & RXH_DISCARD;
> >  	bool is_l4 = info->data == (RXH_IP_SRC | RXH_IP_DST | RXH_L4_B_0_1 | RXH_L4_B_2_3);
> > @@ -4350,9 +4351,13 @@ static int virtnet_set_hashflow(struct net_device *dev,
> >  	if (new_hashtypes != vi->rss_hash_types_saved) {
> >  		vi->rss_hash_types_saved = new_hashtypes;
> >  		vi->rss_hdr->hash_types = cpu_to_le32(vi->rss_hash_types_saved);
> > -		if (vi->dev->features & NETIF_F_RXHASH)
> > -			if (!virtnet_commit_rss_command(vi))
> > +		if (vi->dev->features & NETIF_F_RXHASH) {
> > +			if (!virtnet_commit_rss_command(vi)) {
> > +				vi->rss_hash_types_saved = old_hashtypes;
> > +				vi->rss_hdr->hash_types = cpu_to_le32(old_hashtypes);
> >  				return -EINVAL;
> > +			}
> > +		}
> >  	}
> >  
> >  	return 0;
> > @@ -5546,6 +5551,8 @@ static int virtnet_set_rxfh(struct net_device *dev,
> >  			    struct netlink_ext_ack *extack)
> >  {
> >  	struct virtnet_info *vi = netdev_priv(dev);
> > +	struct virtio_net_rss_config_hdr *old_rss_hdr = NULL;
> > +	u8 old_rss_key[NETDEV_RSS_KEY_LEN];
> >  	bool update = false;
> >  	int i;
> >  
> > @@ -5553,14 +5560,8 @@ static int virtnet_set_rxfh(struct net_device *dev,
> >  	    rxfh->hfunc != ETH_RSS_HASH_TOP)
> >  		return -EOPNOTSUPP;
> >  
> > -	if (rxfh->indir) {
> > -		if (!vi->has_rss)
> > -			return -EOPNOTSUPP;
> > -
> > -		for (i = 0; i < vi->rss_indir_table_size; ++i)
> > -			vi->rss_hdr->indirection_table[i] = cpu_to_le16(rxfh->indir[i]);
> > -		update = true;
> > -	}
> > +	if (rxfh->indir && !vi->has_rss)
> > +		return -EOPNOTSUPP;
> >  
> >  	if (rxfh->key) {
> >  		/* If either _F_HASH_REPORT or _F_RSS are negotiated, the
> > @@ -5569,13 +5570,36 @@ static int virtnet_set_rxfh(struct net_device *dev,
> >  		 */
> >  		if (!vi->has_rss && !vi->has_rss_hash_report)
> >  			return -EOPNOTSUPP;
> > +	}
> > +
> > +	if (rxfh->indir) {
> > +		old_rss_hdr = kmemdup(vi->rss_hdr, virtnet_rss_hdr_size(vi),
> > +				      GFP_KERNEL);

kvmemdup maybe, just in case - I think it can get as high as 128k after all.

> > +		if (!old_rss_hdr)
> > +			return -ENOMEM;
> > +
> > +		for (i = 0; i < vi->rss_indir_table_size; ++i)
> > +			vi->rss_hdr->indirection_table[i] =
> > +				cpu_to_le16(rxfh->indir[i]);
> > +		update = true;
> > +	}
> >  
> > +	if (rxfh->key) {
> > +		memcpy(old_rss_key, vi->rss_hash_key_data, vi->rss_key_size);
> >  		memcpy(vi->rss_hash_key_data, rxfh->key, vi->rss_key_size);
> >  		update = true;
> >  	}
> >  
> > -	if (update)
> > -		virtnet_commit_rss_command(vi);
> > +	if (update && !virtnet_commit_rss_command(vi)) {
> > +		if (old_rss_hdr)
> > +			memcpy(vi->rss_hdr, old_rss_hdr, virtnet_rss_hdr_size(vi));
> > +		if (rxfh->key)
> > +			memcpy(vi->rss_hash_key_data, old_rss_key, vi->rss_key_size);
> > +		kfree(old_rss_hdr);
> > +		return -EINVAL;
> > +	}
> > +
> > +	kfree(old_rss_hdr);
> >  
> >  	return 0;
> >  }
> > @@ -6171,13 +6195,17 @@ static int virtnet_set_features(struct net_device *dev,
> >  	}
> >  
> >  	if ((dev->features ^ features) & NETIF_F_RXHASH) {
> > +		__le32 hash_types = vi->rss_hdr->hash_types;
> > +
> >  		if (features & NETIF_F_RXHASH)
> >  			vi->rss_hdr->hash_types = cpu_to_le32(vi->rss_hash_types_saved);
> >  		else
> >  			vi->rss_hdr->hash_types = cpu_to_le32(VIRTIO_NET_HASH_REPORT_NONE);
> >  
> > -		if (!virtnet_commit_rss_command(vi))
> > +		if (!virtnet_commit_rss_command(vi)) {
> > +			vi->rss_hdr->hash_types = hash_types;
> >  			return -EINVAL;
> > +		}
> >  	}
> >  
> >  	return 0;

