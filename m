Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F481E766B
	for <virtualization@lists.linux.dev>; Tue,  5 Nov 2024 20:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730838461; cv=none; b=UP92bEuYm3+Gkd7FHl4BK7L3PcmnR+4Y7jhAN59gXromiwdpf3SYd9s3NoF6qMPtikZtCNQCCZ1/Tc8S716Ugimn7hWljOjO2lM56bZNB/g9vc/Awu3mQDufFAG3xc8P08wj0tEJXLq54TZraOfeRFx8XzHl6uLX1uqFjWYnAGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730838461; c=relaxed/simple;
	bh=wUm3UIy+tb9KchoMWqBJeP61zH4wo25cypLXsNzjioI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buo9NBsBInsvtD09rCsrNPnOrBHU+1x/PUGcXF6N/dvhCk52T8ezJYPAC0cyNGMyd853nfrHIMYNilHNC1c53IsQMHc8LySW5ek0QGz+ILgkpM74evcGUxFw6T6fCYOBq2q1O/h4p8zj1Q2qlVx4NmodP+f7wjkB3E10YPkJHSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=PSeUiart; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="PSeUiart"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e60e57a322so3319430b6e.3
        for <virtualization@lists.linux.dev>; Tue, 05 Nov 2024 12:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730838458; x=1731443258; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORlEvUldMxLouCU0sT2UvkB9s0hh4uW8+652o/l7m7A=;
        b=PSeUiartSA0Rq66tK/syXKN0wGPvgoTxQNqQF1Jpu2k2PtEtnMNslMSBkznOvJP+qD
         +xjKc0zvqMq4UcK0YBWMQsqnPk9RiogOawsZoQj7olBXNKb3M/E3rifTRbxk7WdWkqUQ
         N6ptJQoiWOqLN8jC7vnIEDNgeqoS9VzBFUWL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730838458; x=1731443258;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ORlEvUldMxLouCU0sT2UvkB9s0hh4uW8+652o/l7m7A=;
        b=s3Byhe9fTiQbWAWvykGJ2TgV+DZ0YbhMGOYNhYDyxsRKthV67Qb0yAj6/c8aTfrgEa
         9VfkGmLlVmPGNUTF7NZqTVstXcRvzD07S4r1dZEVz77GN5T8IiUgjUzXv6JSXdtyFJjd
         JdqNm5JnGrCd0UoauqSTcQZftyrWpHZsDXxoU99Axe0+xLeZMdrh/aygKI1RJ+oiBOqi
         F3d0Jk9LF4EiMksop3b9uqoyLuofWR5YmzNYflUHrNOPj6Ep2r88Wbn7Dbw6KZpImQpj
         Li9qLoot9P6MqArY30FKdLln8xzg8eN2EcrFEj7foIfXft8NZt0isf+Zt1q42bOBz5VK
         qUrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUo8/DKDgLPl7P7HfdPS91/FQlhRgW5sOVUORWG7q7PQHd2Sw9mFyzUxJ+aX57TvlxJ//NT1blgYtbeAB/FPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwztW9FIImOXYPNUBnt9j21W4rY0hh4m6UZTPP5ZjPsNmRQ/8WX
	khhasF750VLNy4iC9EQ67GdQxKmoIVJBl1l6MSXWce9wjtRUdJ9T07KfYvW4foE=
X-Google-Smtp-Source: AGHT+IEShTsCyJSAvD86FXXBmKQCs3d6LZCjo1Br7OeDr2YgRig+JvDpF4Rs+05Ny+7E45Wr4rrU9w==
X-Received: by 2002:a05:6808:2385:b0:3e3:c446:e5ef with SMTP id 5614622812f47-3e6384c4e2cmr34149241b6e.37.1730838458685;
        Tue, 05 Nov 2024 12:27:38 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee452ac4ffsm9444684a12.25.2024.11.05.12.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 12:27:38 -0800 (PST)
Date: Tue, 5 Nov 2024 12:27:35 -0800
From: Joe Damato <jdamato@fastly.com>
To: Philo Lu <lulie@linux.alibaba.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew@daynix.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/4] virtio_net: Support dynamic rss indirection
 table size
Message-ID: <Zyp_t9MqleySQR3K@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew@daynix.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
References: <20241104085706.13872-1-lulie@linux.alibaba.com>
 <20241104085706.13872-2-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104085706.13872-2-lulie@linux.alibaba.com>

On Mon, Nov 04, 2024 at 04:57:03PM +0800, Philo Lu wrote:
> When reading/writing virtio_net_ctrl_rss, we get the indirection table
> size from vi->rss_indir_table_size, which is initialized in
> virtnet_probe(). However, the actual size of indirection_table was set
> as VIRTIO_NET_RSS_MAX_TABLE_LEN=128. This collision may cause issues if
> the vi->rss_indir_table_size exceeds 128.
> 
> This patch instead uses dynamic indirection table, allocated with
> vi->rss after vi->rss_indir_table_size initialized. And free it in
> virtnet_remove().
> 
> In virtnet_commit_rss_command(), sgs for rss is initialized differently
> with hash_report. So indirection_table is not used if !vi->has_rss, and
> then we don't need to alloc indirection_table for hash_report only uses.
> 
> Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 39 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 869586c17ffd..75c1ff4efd13 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -368,15 +368,16 @@ struct receive_queue {
>   * because table sizes may be differ according to the device configuration.
>   */
>  #define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> -#define VIRTIO_NET_RSS_MAX_TABLE_LEN    128
>  struct virtio_net_ctrl_rss {
>  	u32 hash_types;
>  	u16 indirection_table_mask;
>  	u16 unclassified_queue;
> -	u16 indirection_table[VIRTIO_NET_RSS_MAX_TABLE_LEN];
> +	u16 hash_cfg_reserved; /* for HASH_CONFIG (see virtio_net_hash_config for details) */
>  	u16 max_tx_vq;
>  	u8 hash_key_length;
>  	u8 key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> +
> +	u16 *indirection_table;
>  };
>  
>  /* Control VQ buffers: protected by the rtnl lock */
> @@ -512,6 +513,25 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>  					       struct page *page, void *buf,
>  					       int len, int truesize);
>  
> +static int rss_indirection_table_alloc(struct virtio_net_ctrl_rss *rss, u16 indir_table_size)
> +{
> +	if (!indir_table_size) {
> +		rss->indirection_table = NULL;
> +		return 0;
> +	}
> +
> +	rss->indirection_table = kmalloc_array(indir_table_size, sizeof(u16), GFP_KERNEL);
> +	if (!rss->indirection_table)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static void rss_indirection_table_free(struct virtio_net_ctrl_rss *rss)
> +{
> +	kfree(rss->indirection_table);
> +}
> +
>  static bool is_xdp_frame(void *ptr)
>  {
>  	return (unsigned long)ptr & VIRTIO_XDP_FLAG;
> @@ -3828,11 +3848,15 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
>  	/* prepare sgs */
>  	sg_init_table(sgs, 4);
>  
> -	sg_buf_size = offsetof(struct virtio_net_ctrl_rss, indirection_table);
> +	sg_buf_size = offsetof(struct virtio_net_ctrl_rss, hash_cfg_reserved);
>  	sg_set_buf(&sgs[0], &vi->rss, sg_buf_size);
>  
> -	sg_buf_size = sizeof(uint16_t) * (vi->rss.indirection_table_mask + 1);
> -	sg_set_buf(&sgs[1], vi->rss.indirection_table, sg_buf_size);
> +	if (vi->has_rss) {
> +		sg_buf_size = sizeof(uint16_t) * vi->rss_indir_table_size;
> +		sg_set_buf(&sgs[1], vi->rss.indirection_table, sg_buf_size);
> +	} else {
> +		sg_set_buf(&sgs[1], &vi->rss.hash_cfg_reserved, sizeof(uint16_t));
> +	}
>  
>  	sg_buf_size = offsetof(struct virtio_net_ctrl_rss, key)
>  			- offsetof(struct virtio_net_ctrl_rss, max_tx_vq);
> @@ -6420,6 +6444,9 @@ static int virtnet_probe(struct virtio_device *vdev)
>  			virtio_cread16(vdev, offsetof(struct virtio_net_config,
>  				rss_max_indirection_table_length));
>  	}
> +	err = rss_indirection_table_alloc(&vi->rss, vi->rss_indir_table_size);
> +	if (err)
> +		goto free;
>  
>  	if (vi->has_rss || vi->has_rss_hash_report) {
>  		vi->rss_key_size =
> @@ -6674,6 +6701,8 @@ static void virtnet_remove(struct virtio_device *vdev)
>  
>  	remove_vq_common(vi);
>  
> +	rss_indirection_table_free(&vi->rss);
> +
>  	free_netdev(vi->dev);
>  }
>

I'm not an expert on virtio, so I don't feel comfortable giving a
Reviewed-by, but this does seem to fix a potential out of bounds
access in virtnet_init_default_rss if rss_indir_table_size were
larger than VIRTIO_NET_RSS_MAX_TABLE_LEN (128).

Acked-by: Joe Damato <jdamato@fastly.com>
