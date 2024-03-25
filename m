Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0163A18C7A9
	for <virtualization@lists.linux.dev>; Mon, 25 Mar 2024 11:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711365977; cv=none; b=k+Y8HngV+SAtOQR854g+tHPHu937u9NC6AFHtISmNBHEkhVnzl++qXqDv6K53IbO7vPHozHAPI8trZ03VxzPSxNf1DGnKztcbC+CMIK9OQ71T8KwDB+MRh1BCWJfVNlEA1VbyH4+1jjLXBXvoId9HrTLA9M7sAQ0UROTuI93yCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711365977; c=relaxed/simple;
	bh=wIQT4e0awJT2yByDVLyfiPzz/efu9uxA+/+pjO25oec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHAWTWq9obioX84w+jGKFD/fAnIwfoWcY4Qxo1emCGsNdDuZyqVn4XB5ljRvX8Uv8B9Hl9h/VS1NGG+3IcABFyIKiEReU8iAblGoafdfU2V6rAAuf2peZ5d9lMhbew2U6Q5I8j5vcWaozzT3LBwe/d3eADLX6KVQpgHi6Oz2xJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a46a7208eedso581211066b.0
        for <virtualization@lists.linux.dev>; Mon, 25 Mar 2024 04:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711365974; x=1711970774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8xMo+ECbJhP9I1J07PU9s5GaROGSCtTuRVYRDOh6X4=;
        b=itYcFYgStXZB73nhjScDGGVLTESAXNSGtFwL3unXk6GG9JtYPsAsR8Xr9qUGLM7ghj
         coEjJ/qOU80QoVB5J64fqqHsm2MrPT5iGJliBWiOEmzyxZykYufwh2Ytjw1K2svC3ShL
         GlG7IFxj8U4QxvuV5Gng+Rg5a3fyrpc6zGVGdzA/HrRxnhC3fbAIvSDSAgjdDdQKZMzh
         Pc4EAGT4zkiGG+atQU0k0jq5jAU/MuGLmdJHv8eB1BM/6DR3EWe8r869E6duXW+kle8z
         md/lF8zZClQ0NUJgqQgeO9Zc7597X41GVfhtZnTF2miF4mcuM9RcDS4PCp+2D9l+Y4Fd
         Xvmw==
X-Forwarded-Encrypted: i=1; AJvYcCV1VWM0S/YFRkqE8IMMmSrTQ6R/YMaaPlRMYKB8DeQ9q6RmRJNFARrgMwk0XYkHsrC2bsfOtkT6PAofxMnCCp+H70KJpboPN/uufZ1gB7c=
X-Gm-Message-State: AOJu0YwKDOIJJrIQBt3DyPmpxho1ZyxXYpiOCSz7dsz5y4PRq8749gvI
	4+6MvWjunh+pgxKeX5xH9p6ICmozX1ihmVsCPpoHO3SULNCYJ0ps
X-Google-Smtp-Source: AGHT+IFVtAuh0n4hICbWoDkom2iJ19P3TnM/NDfUNwYKnNpFz8nYX6QB+QDMtptvYVGfEvJDgAjrSQ==
X-Received: by 2002:a17:906:338c:b0:a46:f3cc:ccab with SMTP id v12-20020a170906338c00b00a46f3ccccabmr4396891eja.4.1711365974117;
        Mon, 25 Mar 2024 04:26:14 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id kh12-20020a170906f80c00b00a413d1eda4bsm2928231ejb.87.2024.03.25.04.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 04:26:13 -0700 (PDT)
Date: Mon, 25 Mar 2024 04:26:08 -0700
From: Breno Leitao <leitao@debian.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: rbc@meta.com, riel@surriel.com, stable@vger.kernel.org,
	qemu-devel@nongnu.org,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Melnychenko <andrew@daynix.com>
Subject: Re: [PATCH] virtio_net: Do not send RSS key if it is not supported
Message-ID: <ZgFfUHQhMdAWixqB@gmail.com>
References: <20240321165431.3517868-1-leitao@debian.org>
 <1711072822.882584-1-xuanzhuo@linux.alibaba.com>
 <Zf1bofzE4x0wGEm+@gmail.com>
 <1711346273.5079622-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711346273.5079622-1-xuanzhuo@linux.alibaba.com>

Hello Xuan,

On Mon, Mar 25, 2024 at 01:57:53PM +0800, Xuan Zhuo wrote:
> On Fri, 22 Mar 2024 03:21:21 -0700, Breno Leitao <leitao@debian.org> wrote:
> > Hello Xuan,
> >
> > On Fri, Mar 22, 2024 at 10:00:22AM +0800, Xuan Zhuo wrote:
> > > On Thu, 21 Mar 2024 09:54:30 -0700, Breno Leitao <leitao@debian.org> wrote:
> >
> > > > 4) Since the command above does not have a key, then the last
> > > >    scatter-gatter entry will be zeroed, since rss_key_size == 0.
> > > >     sg_buf_size = vi->rss_key_size;
> > >
> > >
> > >
> > > 	if (vi->has_rss || vi->has_rss_hash_report) {
> > > 		vi->rss_indir_table_size =
> > > 			virtio_cread16(vdev, offsetof(struct virtio_net_config,
> > > 				rss_max_indirection_table_length));
> > > 		vi->rss_key_size =
> > > 			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
> > >
> > > 		vi->rss_hash_types_supported =
> > > 		    virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
> > > 		vi->rss_hash_types_supported &=
> > > 				~(VIRTIO_NET_RSS_HASH_TYPE_IP_EX |
> > > 				  VIRTIO_NET_RSS_HASH_TYPE_TCP_EX |
> > > 				  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
> > >
> > > 		dev->hw_features |= NETIF_F_RXHASH;
> > > 	}
> > >
> > >
> > > vi->rss_key_size is initiated here, I wonder if there is something wrong?
> >
> > Not really, the code above is never executed (in my machines). This is
> > because `vi->has_rss` and `vi->has_rss_hash_report` are both unset.
> >
> > Looking further, vdev does not have the VIRTIO_NET_F_RSS and
> > VIRTIO_NET_F_HASH_REPORT features.
> >
> > Also, when I run `ethtool -x`, I got:
> >
> > 	# ethtool  -x eth0
> > 	RX flow hash indirection table for eth0 with 1 RX ring(s):
> > 	Operation not supported
> > 	RSS hash key:
> > 	Operation not supported
> > 	RSS hash function:
> > 	    toeplitz: on
> > 	    xor: off
> > 	    crc32: off
> 
> 
> The spec saies:
> 	Note that if the device offers VIRTIO_NET_F_HASH_REPORT, even if it
> 	supports only one pair of virtqueues, it MUST support at least one of
> 	commands of VIRTIO_NET_CTRL_MQ class to configure reported hash
> 	parameters:
> 
> 	If the device offers VIRTIO_NET_F_RSS, it MUST support
> 	VIRTIO_NET_CTRL_MQ_RSS_CONFIG command per 5.1.6.5.7.1.
> 
> 	Otherwise the device MUST support VIRTIO_NET_CTRL_MQ_HASH_CONFIG command
> 	per 5.1.6.5.6.4.
> 
> 
> So if we have not anyone of `vi->has_rss` and `vi->has_rss_hash_report`,
> we should return from virtnet_set_rxfh directly.

Makes sense. Although it is not clear to me how vi->has_rss_hash_report
is related here, but, I am convinced that we shouldn't do any RSS
operation if the device doesn't have the RSS feature, i.e, vi->has_rss
is false.

That said, I am thinking about something like this. How does it sound?

	diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
	index 5a7700b103f8..8c1ad7361cf2 100644
	--- a/drivers/net/virtio_net.c
	+++ b/drivers/net/virtio_net.c
	@@ -3780,6 +3780,9 @@ static int virtnet_set_rxfh(struct net_device *dev,
		struct virtnet_info *vi = netdev_priv(dev);
		int i;
	 
	+	if (!vi->has_rss)
	+		return -EOPNOTSUPP;
	+
		if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
		    rxfh->hfunc != ETH_RSS_HASH_TOP)
			return -EOPNOTSUPP;

Thanks!
