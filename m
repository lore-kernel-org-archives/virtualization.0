Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4B13AEF42
	for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022304; cv=none; b=dd9u8R0hdutJ/aw6qOC4CTwzXXT/i+sTPUmPOC+JfruyJ6HT6ojDyJlXhqoxgM1Mm8fRhHd8daXxUOWJYxcmQRT6VFDDQzRWYSp9atiibm/jUn7F4PC+SALYNZBWdOpOIYPJg0yRvLNmMgi7ekOThnDH0+Y8NlvFiAu864vZ+UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022304; c=relaxed/simple;
	bh=KpzWjtfsWv3qhAGhWyvVbyhPwgnmWZ3Fr4zjNZr3GdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Kl23lQvqmYHV4cd1Q/NrARRX/aomXLKwkWZO0FypSmxrUJP1vdifU1jQl0V3KNZXrJyyzXeKMsR1n8+lq9HzfaZTZ6oz3BUGPFlZbH5spotD9RCsaV93L4g4KWa4KBMW0i+j0AOr2lEz/BXPNjg7deFs3e/OF0IQXetwK/mS+/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UYZIKKo7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYZIKKo7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772022302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LMzUQOTDOi7UoTOS/hJ+EQEdYM7FgK5Sbr9EcZoRwiY=;
	b=UYZIKKo79psuCtgoz3gbRTuov8qK59BLTRELMmi6ivTA7krI4F4Rzyt7wzFMUZpgxI9iHZ
	EnGhRuV7sbnFfT37Gcw6L+pPscQ3rzDPVD6IKj/o0bAMnuWdzy9JnI8T2xJVTtvE1xdJ9x
	RKQox9ovBYsDe+8onEFRgPU/XstLNIw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-FzQGkpcwMeeu8StcvfKRPA-1; Wed, 25 Feb 2026 07:25:01 -0500
X-MC-Unique: FzQGkpcwMeeu8StcvfKRPA-1
X-Mimecast-MFC-AGG-ID: FzQGkpcwMeeu8StcvfKRPA_1772022300
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4837cee2e9bso34103455e9.3
        for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 04:25:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772022300; x=1772627100;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LMzUQOTDOi7UoTOS/hJ+EQEdYM7FgK5Sbr9EcZoRwiY=;
        b=fVQwb459UTuAMWEHgvERod/qFHpfWG8mYnMZH8oGYCpED+mehQEhB2wNWfo8gY7VHm
         ZHoJTLAiRTWjscEa0gZDQYurij7WnQYFk72jV6ghH0cOnglvoTVfV9Ix39kR47aA4sKb
         AoByNtLVoeVbFvQ93R5GSzvl4lzd6zWhheZ87y/h7sihCpfDq5uP9y1rncsS5Is2dO49
         00S+BeRtrF6fTn+Lw2Lt7SEOnyOH2+vc6KlFn0WILTkGkSfHeYTDi5ZyHe6b22pziebG
         dB7/cEnUO9mGfCzUMOLOfojUX+xsiS7GrVEqiAB91JE3lhJ///Ol69YBnDwrmMoKpXfx
         yJQw==
X-Forwarded-Encrypted: i=1; AJvYcCVyASLAmnLgBzvrCfQur6s+IUHN9h7cR4ZHlBwdgMHBJOIF5sJBHw9AQgdvljK9+nL4KbC1mkGEoGmoEXa0TQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzlr303dPHH4z4zpg3JCq6TmCoCxlJJdaqQDSzTZLsdMcok9TyO
	+8b+7xFVq/p32gw5cHrt4Udp+ZQ/YdGMuXAH9055eQfa+E/d9Wi+9lkUU7UgG8KIAJRnR8eZltE
	rwFZU0eODUP392smwd2uMklcJIgWHCeAUp2zuIHg6Nae7AQTKTOkgz93OPXG3ZF9V+bIU
X-Gm-Gg: ATEYQzzVO8+EOnA7vg8ofGdvfYGmHLoSoDGXgFzhFl/MOmXRrrT+9ukHxf6k248n5SW
	nq6iZ+4qgUq2CwbpPToyLh1lkXY5ZKstuIWcbkOblwh6of8t20exQijSPTNwk1f0CqzA0keO+Ti
	w4OHtOGAv5Ad1mSxYj7RbovqoADw0Am8ljEuhu4P5q/jzOYPUSNoNxvo/VTEfU0/bn2H2TbIM9k
	b+ypRgYNBuEWPqspgQTms1NTOsqO2V4Q0lkD+fqDjPVh8LZFRLSTUFF389CR9C628kNFPO2zIMo
	KCd2X0mYzbs0XQFstUlPumyXhnXCJGEr2Z/8bR5Iq2cVUYWHsngGNWrYJ7HLUs4OLoNK9JoD19g
	BWfF3OIB1hqIMJGU2+KTd9kOnOj8IQ5WPUv/3qdw1nbjNIg==
X-Received: by 2002:a05:600c:3e0b:b0:480:1c85:88bf with SMTP id 5b1f17b1804b1-483c21a57aemr2858095e9.27.1772022299471;
        Wed, 25 Feb 2026 04:24:59 -0800 (PST)
X-Received: by 2002:a05:600c:3e0b:b0:480:1c85:88bf with SMTP id 5b1f17b1804b1-483c21a57aemr2857655e9.27.1772022299002;
        Wed, 25 Feb 2026 04:24:59 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd70e692sm61847325e9.7.2026.02.25.04.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 04:24:58 -0800 (PST)
Date: Wed, 25 Feb 2026 07:24:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Shiva Shankar Kommula <kshankar@marvell.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH net,v4,1/2] virtio_net: Improve RSS key
 size validation and use NETDEV_RSS_KEY_LEN
Message-ID: <20260225072355-mutt-send-email-mst@kernel.org>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260225050154-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63744FC9F4786AB2F617AC4CA075A@BY1PR18MB6374.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <BY1PR18MB63744FC9F4786AB2F617AC4CA075A@BY1PR18MB6374.namprd18.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FqpBqAMsLa4klxiSaPGUyrcvsNIubCggYiKy407QjSI_1772022300
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Feb 25, 2026 at 12:22:50PM +0000, Srujana Challa wrote:
> > On Tue, Feb 24, 2026 at 12:28:49PM +0530, Srujana Challa wrote:
> > > Replace hardcoded RSS max key size limit with NETDEV_RSS_KEY_LEN to
> > > align with kernel's standard RSS key length. Add validation for RSS
> > > key size against spec minimum (40 bytes) and driver maximum. When
> > > validation fails, gracefully disable RSS features and continue
> > > initialization rather than failing completely.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 3f7d9c1964fc ("virtio_net: Add hash_key_length check")
> > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > 
> > --- should come here before changelog.
> > 
> > > v3:
> > > - Moved RSS key validation checks to virtnet_validate.
> > > - Add fixes: tag and CC -stable
> > > v4:
> > > - Use NETDEV_RSS_KEY_LEN instead of type_max for the maximum rss key
> > size.
> > > ---
> > >  drivers/net/virtio_net.c | 34 ++++++++++++++++++++++++----------
> > >  1 file changed, 24 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
> > > db88dcaefb20..eeefe8abc122 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -381,8 +381,6 @@ struct receive_queue {
> > >  	struct xdp_buff **xsk_buffs;
> > >  };
> > >
> > > -#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> > > -
> > >  /* Control VQ buffers: protected by the rtnl lock */  struct
> > > control_buf {
> > >  	struct virtio_net_ctrl_hdr hdr;
> > > @@ -486,7 +484,7 @@ struct virtnet_info {
> > >
> > >  	/* Must be last as it ends in a flexible-array member. */
> > >  	TRAILING_OVERLAP(struct virtio_net_rss_config_trailer, rss_trailer,
> > hash_key_data,
> > > -		u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> > > +		u8 rss_hash_key_data[NETDEV_RSS_KEY_LEN];
> > >  	);
> > >  };
> > >  static_assert(offsetof(struct virtnet_info,
> > > rss_trailer.hash_key_data) == @@ -6627,6 +6625,29 @@ static int
> > virtnet_validate(struct virtio_device *vdev)
> > >  		__virtio_clear_bit(vdev, VIRTIO_NET_F_STANDBY);
> > >  	}
> > >
> > > +	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS) ||
> > > +	    virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT)) {
> > > +		u8 key_sz = virtio_cread8(vdev,
> > > +					  offsetof(struct virtio_net_config,
> > > +						   rss_max_key_size));
> > > +		/* Spec requires at least 40 bytes */ #define
> > > +VIRTIO_NET_RSS_MIN_KEY_SIZE 40
> > > +		if (key_sz < VIRTIO_NET_RSS_MIN_KEY_SIZE) {
> > > +			dev_warn(&vdev->dev,
> > > +				 "rss_max_key_size=%u is less than spec
> > minimum %u, disabling RSS\n",
> > > +				 key_sz, VIRTIO_NET_RSS_MIN_KEY_SIZE);
> > > +			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > +			__virtio_clear_bit(vdev,
> > VIRTIO_NET_F_HASH_REPORT);
> > > +		}
> > > +		if (key_sz > NETDEV_RSS_KEY_LEN) {
> > > +			dev_warn(&vdev->dev,
> > > +				 "rss_max_key_size=%u exceeds driver limit
> > %u, disabling RSS\n",
> > > +				 key_sz, NETDEV_RSS_KEY_LEN);
> > > +			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > +			__virtio_clear_bit(vdev,
> > VIRTIO_NET_F_HASH_REPORT);
> > 
> > you flipped the logic here and it makes no sense now.
> > 
> > Did you test this path?
> Yes, tested with Marvell's Octeon device.
> > 
> > 
> > So if device is powerful and supports a very big key size then...
> > we disable the feature? how does this make sense?
> The intent isn’t to disable the feature on capable devices, but to ensure the driver never advertises
> support for RSS key sizes larger than what the net device can actually handle. Even if a device reports
> a very large key size, the driver is constrained by NETDEV_RSS_KEY_LEN, since netdev_rss_key_fill() enforces:
> BUG_ON(len > sizeof(netdev_rss_key));

so cap it to NETDEV_RSS_KEY_LEN. Why is that a reason to clear the feature?

> > 
> > 
> > > +		}
> > > +	}
> > > +
> > >  	return 0;
> > >  }
> > >
> > > @@ -6839,13 +6860,6 @@ static int virtnet_probe(struct virtio_device
> > *vdev)
> > >  	if (vi->has_rss || vi->has_rss_hash_report) {
> > >  		vi->rss_key_size =
> > >  			virtio_cread8(vdev, offsetof(struct virtio_net_config,
> > rss_max_key_size));
> > > -		if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
> > > -			dev_err(&vdev->dev, "rss_max_key_size=%u exceeds
> > the limit %u.\n",
> > > -				vi->rss_key_size,
> > VIRTIO_NET_RSS_MAX_KEY_SIZE);
> > > -			err = -EINVAL;
> > > -			goto free;
> > > -		}
> > > -
> > >  		vi->rss_hash_types_supported =
> > >  		    virtio_cread32(vdev, offsetof(struct virtio_net_config,
> > supported_hash_types));
> > >  		vi->rss_hash_types_supported &=
> > > --
> > > 2.25.1
> 

