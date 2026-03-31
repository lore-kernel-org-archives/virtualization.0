Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D731936BCCC
	for <virtualization@lists.linux.dev>; Tue, 31 Mar 2026 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774968531; cv=none; b=jvGnPrSbKq6zwRykKTYphVK6YDqK5zZUjZKkUybet/zwQmJYn2pEyLTSdjd3boACI71gZIIZMS2WHcqPosZ0HwZ/QjyPMbVGDc7LLq6WgsfRqc1M48g9x7r4xooGuu5A4+RuyW99fYUvarsAGe+t4HPLujobVa+U5c16BtXLeos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774968531; c=relaxed/simple;
	bh=BJIMrk2MYSv2FDeHUUdOkp6wdcv9uNwI5U0yUBOXYVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TpniCkEW+JZY5fOKJoHBgpcbKSvMdigDwMkrAj40EOqK+z9+mW5VkdEH6N0hKQofX1x+yMnu/0XI1sCx5jmkrapnW+3pI64ToFPuKH7LYA2x6vRWqg67q4UKXIo2RB0opFbI6a1lz30Cj0Zb8+v/ae0ghHJrA24aq7hM1vgqhXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gbw6UUw5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gbw6UUw5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774968528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uO8xgLmSYcxawrJhbHfOO1eOZxDKPmONKgmhbq8TlcY=;
	b=Gbw6UUw5UIaVem2sgIUZv7kq8qOu7s+3iYX95U6fAXT+i+bZ3FINpWloRlm4BClzSevXlK
	qRVk9Z0xrX5z50UeYSEN6pjPJjXnVaoyGWKI4s1RnpGjNJpjftKkxwBG9N5QFkeIfFD/vD
	8ZZC0VAcGMdwAO0IRNm90KDPr0TisDo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-BH16XvA1Os-EaM2TBHKQqQ-1; Tue, 31 Mar 2026 10:48:46 -0400
X-MC-Unique: BH16XvA1Os-EaM2TBHKQqQ-1
X-Mimecast-MFC-AGG-ID: BH16XvA1Os-EaM2TBHKQqQ_1774968525
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4853466655dso40103345e9.3
        for <virtualization@lists.linux.dev>; Tue, 31 Mar 2026 07:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774968525; x=1775573325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uO8xgLmSYcxawrJhbHfOO1eOZxDKPmONKgmhbq8TlcY=;
        b=G9PBBDYR+/GESV5efUAEW2ug8mSOYtyIeGmLf5fLa8tcENfy/O+FcsoUXORNjM734R
         y4VKuWZPwyHo1AKrSj3au71gJthMVUT4joJAAswvaonY4TRoDP2eNtcVdVctgKZ7LXRk
         onks7Q8KZyxVKJbEUEeI0kTjban1APtcwaffeTUVWWO3jgldQfkDWOtY6C6Tk5BHD9Pr
         0q1olQTkxPqJ7g/dooH73YHG0qIxY5gF71MMuj53gAlmVb+OAoIkJlGE6lREA/GJlRrT
         QnFC+1dLb0bvoDBDBkv3UHj8ybydwyvh6ANJK1MZXdoXYBrHIqEf536eQLkzAZR7SRK2
         bGig==
X-Forwarded-Encrypted: i=1; AJvYcCU/+VaAsOeylshdVcbWY+7ywqEMzhlGuZs6wagmHIgUbqll10bjpESX2lICxpT01Eb5ClIt97H4HPGHoKdXRw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxz+3s4ITUwXXEVTC5fwEZ6NjMNpiR0CnhwOsBeRK8NRktnja+T
	+6MNt0qy6Nk/uotfgVISl6XVQVomMCJdON0xrLRXXwoqodZFqGk9OIK9k2iVlQXPp2/rsLPCnbP
	iaC90Gmn2V28VFLJuDbtsFFL0O5kCeXDsuqCILBbzSboQb4IMravnJ3aBz9XxaubvcXhM
X-Gm-Gg: ATEYQzxetxjJveorPxKYvAJeupLi7q/LHj+tWEj/WZxOVCYR8wfqasoD4wxhlhX2AHQ
	zOucUpWCglayR1q9VMYWVsuOwLmExXswrN/WNV4xbiospujbojvKuJXT6Hn6bd9j8SifnvqG9hk
	/d0qE15QLqxpD+fqy1UKwQixxLOfxT0bCkEHUL7ygBUX6l8Dr5B8LqJX5IIq4QiPPbqpn86v5rn
	IfguxzoY4dEKlItSMnw+YZjf/7QJC2MT1L5GeK8UPA/+rnZTH8icM/XQ5uPTlwCdpW4Sy+3m+ex
	u6XJ38EwpF4/X285VpXs+7eNYFliPXpsQmaT9ZG6m08Y5MaS9eFf85MKMhSxNg2Tk5JY9M2Wdg1
	PTuo0Y+M6iHENPCUL
X-Received: by 2002:a05:600c:a016:b0:483:64b4:79da with SMTP id 5b1f17b1804b1-48727ef153cmr267996675e9.26.1774968525157;
        Tue, 31 Mar 2026 07:48:45 -0700 (PDT)
X-Received: by 2002:a05:600c:a016:b0:483:64b4:79da with SMTP id 5b1f17b1804b1-48727ef153cmr267995995e9.26.1774968524618;
        Tue, 31 Mar 2026 07:48:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8797ecsm38127025e9.8.2026.03.31.07.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 07:48:44 -0700 (PDT)
Date: Tue, 31 Mar 2026 10:48:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Srujana Challa <schalla@marvell.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Shiva Shankar Kommula <kshankar@marvell.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH net,v5] virtio_net: clamp rss_max_key_size
 to NETDEV_RSS_KEY_LEN
Message-ID: <20260331104737-mutt-send-email-mst@kernel.org>
References: <20260326142344.1171317-1-schalla@marvell.com>
 <ba027306-e5e0-4d4d-8357-f6080441167d@redhat.com>
 <CH3PR18MB6379D39BA068565667CF2B06A053A@CH3PR18MB6379.namprd18.prod.outlook.com>
 <68ca0a8c-27f9-45f1-94cc-7e3c7936181f@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <68ca0a8c-27f9-45f1-94cc-7e3c7936181f@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wlmZUply8zHnzPcyuJig4m9k4HzV22WQHdMIc_iyodM_1774968525
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 31, 2026 at 04:39:02PM +0200, Paolo Abeni wrote:
> On 3/31/26 3:29 PM, Srujana Challa wrote:
> >> On 3/26/26 3:23 PM, Srujana Challa wrote:
> >>> rss_max_key_size in the virtio spec is the maximum key size supported
> >>> by the device, not a mandatory size the driver must use. Also the
> >>> value 40 is a spec minimum, not a spec maximum.
> >>>
> >>> The current code rejects RSS and can fail probe when the device
> >>> reports a larger rss_max_key_size than the driver buffer limit.
> >>> Instead, clamp the effective key length to min(device
> >>> rss_max_key_size, NETDEV_RSS_KEY_LEN) and keep RSS enabled.
> >>>
> >>> This keeps probe working on devices that advertise larger maximum key
> >>> sizes while respecting the netdev RSS key buffer size limit.
> >>>
> >>> Fixes: 3f7d9c1964fc ("virtio_net: Add hash_key_length check")
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Srujana Challa <schalla@marvell.com>
> >>> ---
> >>> v3:
> >>> - Moved RSS key validation checks to virtnet_validate.
> >>> - Add fixes: tag and CC -stable
> >>> v4:
> >>> - Use NETDEV_RSS_KEY_LEN instead of type_max for the maximum rss key
> >> size.
> >>> v5:
> >>> - Interpret rss_max_key_size as a maximum and clamp it to
> >> NETDEV_RSS_KEY_LEN.
> >>> - Do not disable RSS/HASH_REPORT when device rss_max_key_size exceeds
> >> NETDEV_RSS_KEY_LEN.
> >>> - Drop the separate patch that replaced the runtime check with
> >> BUILD_BUG_ON.
> >>>
> >>>  drivers/net/virtio_net.c | 20 +++++++++-----------
> >>>  1 file changed, 9 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
> >>> 022f60728721..b241c8dbb4e1 100644
> >>> --- a/drivers/net/virtio_net.c
> >>> +++ b/drivers/net/virtio_net.c
> >>> @@ -373,8 +373,6 @@ struct receive_queue {
> >>>  	struct xdp_buff **xsk_buffs;
> >>>  };
> >>>
> >>> -#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> >>> -
> >>>  /* Control VQ buffers: protected by the rtnl lock */  struct
> >>> control_buf {
> >>>  	struct virtio_net_ctrl_hdr hdr;
> >>> @@ -478,7 +476,7 @@ struct virtnet_info {
> >>>
> >>>  	/* Must be last as it ends in a flexible-array member. */
> >>>  	TRAILING_OVERLAP(struct virtio_net_rss_config_trailer, rss_trailer,
> >> hash_key_data,
> >>> -		u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> >>> +		u8 rss_hash_key_data[NETDEV_RSS_KEY_LEN];
> >>>  	);
> >>>  };
> >>>  static_assert(offsetof(struct virtnet_info,
> >>> rss_trailer.hash_key_data) == @@ -6717,6 +6715,7 @@ static int
> >> virtnet_probe(struct virtio_device *vdev)
> >>>  	struct virtnet_info *vi;
> >>>  	u16 max_queue_pairs;
> >>>  	int mtu = 0;
> >>> +	u16 key_sz;
> >>>
> >>>  	/* Find if host supports multiqueue/rss virtio_net device */
> >>>  	max_queue_pairs = 1;
> >>> @@ -6851,14 +6850,13 @@ static int virtnet_probe(struct virtio_device
> >> *vdev)
> >>>  	}
> >>>
> >>>  	if (vi->has_rss || vi->has_rss_hash_report) {
> >>> -		vi->rss_key_size =
> >>> -			virtio_cread8(vdev, offsetof(struct virtio_net_config,
> >> rss_max_key_size));
> >>> -		if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
> >>> -			dev_err(&vdev->dev, "rss_max_key_size=%u exceeds
> >> the limit %u.\n",
> >>> -				vi->rss_key_size,
> >> VIRTIO_NET_RSS_MAX_KEY_SIZE);
> >>> -			err = -EINVAL;
> >>> -			goto free;
> >>> -		}
> >>> +		key_sz = virtio_cread8(vdev, offsetof(struct virtio_net_config,
> >>> +rss_max_key_size));
> >>> +
> >>> +		vi->rss_key_size = min_t(u16, key_sz, NETDEV_RSS_KEY_LEN);
> >>> +		if (key_sz > vi->rss_key_size)
> >>> +			dev_warn(&vdev->dev,
> >>> +				 "rss_max_key_size=%u exceeds driver limit
> >> %u, clamping\n",
> >>> +				 key_sz, vi->rss_key_size);
> >>
> >> NETDEV_RSS_KEY_LEN is 256 and virtio_cread8() returns a u8. The check is
> >> not needed, and the warning will never be printed. I think that the
> >> BUILD_BUG_ON() you used in v4 would be better than the above chunk.
> >>
> > Thank you for the feedback. In net-next, NETDEV_RSS_KEY_LEN is 256. This fix is
> > also intended for stable kernels, where NETDEV_RSS_KEY_LEN is 52, and
> > I added the message to make clamping visible in that case.
> > I will remove the check and send the next version.  
> 
> I'm sorry, I haven't looked at the historical context when I wrote my
> previous reply.
> 
> IMHO the additional check does not make sense in the current net tree.
> On the flip side stable trees will need it. I suggest:
> 
> - dropping the check for the 'net' patch
> - also dropping CC: stable tag
> - explicitly sending to stable the fix variant including the size check.
> 
> @Michael: WDYT?
> 
> /P

I was the one who suggested it, the extra check is harmless, I'm
inclined to always have it.  Less work than maintaining two patches.

-- 
MST

