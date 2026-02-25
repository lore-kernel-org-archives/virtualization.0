Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70E83B5317
	for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772023038; cv=none; b=c4jrmKQMNWGEiEqOVUiOKTL3JatI+iVliroThjo/Vi4S4XpjmG5n09jbH+YQ98kNonLq6AJ2JGXu2+CvSiNY4ek0eEmrivAv+e3RQcNhWTaJ0uNZG4uJG1gF6sInNkxliV2dL1nvEkzGT2fUhAeH3vl1ZgIMVstSX5ypeU1CPXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772023038; c=relaxed/simple;
	bh=6ESDdsRpQPQ0SeOTN/fV7zbAnEXELUkFgRiXWYOxcoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MnZ/32sO9a6/Bm3CYCBeEXUngchlf2pb6t4Lh5YyKuVsnNTYspF6unsd6TecKsFY45Or1zfudGaPttCRFQcxrar39PN0dhd5bP5eyFK1ETUtWXQOugtI+Kag9lIit4Z1vhto5boOAjIWoy/XeZZRS2uaElRH4qvq5AWlyV8vMYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UuqX4oWe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UuqX4oWe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772023033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sKkynTuixvnYJo7kGdPVE541D6F3mGdAP62FmXJoy8Y=;
	b=UuqX4oWeanlpbvSgWCfDm11HO1nIYPHcfPPG/cE60u69PYxGaYpXGE63u6hbSjw//XvOMy
	FRZOzrShEwjGDCpkYrw8zk3XYlNcy0lEaA+lM3yqAL06z3Ba/xFv5ES7fqpnaPeRTgZWK+
	Yv8qh+HnYuNar/7S+r3bPvrIIWou3CM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-34fod4BjOn2ZErrj9Ng-dA-1; Wed, 25 Feb 2026 07:37:12 -0500
X-MC-Unique: 34fod4BjOn2ZErrj9Ng-dA-1
X-Mimecast-MFC-AGG-ID: 34fod4BjOn2ZErrj9Ng-dA_1772023031
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4806cfffca6so60345455e9.2
        for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 04:37:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772023031; x=1772627831;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sKkynTuixvnYJo7kGdPVE541D6F3mGdAP62FmXJoy8Y=;
        b=ooV8vnsE0DstD6wfgPicphTdLksRR/bJipKZr4/I6Zg2XWU8+57/Um3o3yUhnT8JPJ
         rfEGacY7dKqMADd4VyHYGo0vxSkAzbbBEhZX83U+dv73RR45HY2d6eLJp/xEgTvifBMF
         Kt7dJ0H/48ihNVWePwd9g7A5P5pWPnV1Uq+Z57cwMmYIevXMC3VZq0Q/mUDFE7I0oc75
         A++ClvCFxucH1PpINmQ8cNYL+KEkMIDP3LT729ERhI7euNdLgrinnpUzy1sF4hZMxElM
         Br1puCLtFbpOfy0lcT4Ey1TZPNC6XrvDO4wWpnumSC/mLXRHdgnQDvhl4ET7XSUGZWZn
         Koxg==
X-Forwarded-Encrypted: i=1; AJvYcCUJBTibQn1t7PqXOVlpFw/MFfvPCx1huCWKVXKPiiT7Tx2S0E7JgXvFAnuEZvYjhRD/u1hcqtaBfbP9ghhv5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwlL77gn+yr6k2mZ6k2z5U+N33TVMgQ0YcFt8WpmOqiZDoywApo
	xfXc/XCv0fNxTa+gah6dlzwUFA01EvNvf017NvyDogtlG+OwA2jmrezV2y4L+w7YcaitQx3j2bw
	8UGVemPqn3ib3rlMq0w7z0PozquZMi/T6Ra9PMQofXhbtISHepUe7/YvAfKIqx9OWUOZ19y0VvB
	YI
X-Gm-Gg: ATEYQzy+azGgMSApuRKB5sFHyCe/elOpcTQW9D5Im6zMi+T5S5m5VRC0UghrUP4yKDa
	PfAv5vquSxbMgoufJFkmMezGoDl6sXuLTjr54UoEFwsR720CdY/1/nWHPtJ2WyWpEbc90G3Exlm
	/UKBd3dGHYGGt6P0WOgf250wI6Rr/p1tiGhNMDmze8pM7W2dal5aYjHUT1hRiCkY5xHGsf35rm5
	NEbIpZUXsVo2KCllDwDtuoQeQCvlDSAOl9Wu6yc2cWqW0HDi62g3gGIumVZBR/wTan8BJ8IsiiZ
	zf2FyjZK+ZVLqsh8fU9VrMeBfd8fwLXnnmYb08QSyg0W6tD74eE91HaeK+NOWykXxlmZrsbiJrM
	jHnTxI1xTRo9TEAcAchoJ4Jm+m/4UCe8hpaA4E0+EGHl1kQ==
X-Received: by 2002:a05:600c:3105:b0:477:7bca:8b2b with SMTP id 5b1f17b1804b1-483c12c7d04mr19503045e9.15.1772023030976;
        Wed, 25 Feb 2026 04:37:10 -0800 (PST)
X-Received: by 2002:a05:600c:3105:b0:477:7bca:8b2b with SMTP id 5b1f17b1804b1-483c12c7d04mr19502495e9.15.1772023030473;
        Wed, 25 Feb 2026 04:37:10 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd73ea7esm60009925e9.15.2026.02.25.04.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 04:37:09 -0800 (PST)
Date: Wed, 25 Feb 2026 07:37:06 -0500
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
Message-ID: <20260225073537-mutt-send-email-mst@kernel.org>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260225050154-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63744FC9F4786AB2F617AC4CA075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225072355-mutt-send-email-mst@kernel.org>
 <BY1PR18MB6374C4D43F9BD88443A8B067A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <BY1PR18MB6374C4D43F9BD88443A8B067A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0iOgrDo5HvDDtyqiPOTQHqEqTWTvJjy5_83OXz9lpbk_1772023031
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Feb 25, 2026 at 12:34:28PM +0000, Srujana Challa wrote:
> > > > On Tue, Feb 24, 2026 at 12:28:49PM +0530, Srujana Challa wrote:
> > > > > Replace hardcoded RSS max key size limit with NETDEV_RSS_KEY_LEN
> > > > > to align with kernel's standard RSS key length. Add validation for
> > > > > RSS key size against spec minimum (40 bytes) and driver maximum.
> > > > > When validation fails, gracefully disable RSS features and
> > > > > continue initialization rather than failing completely.
> > > > >
> > > > > Cc: stable@vger.kernel.org
> > > > > Fixes: 3f7d9c1964fc ("virtio_net: Add hash_key_length check")
> > > > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > >
> > > > --- should come here before changelog.
> > > >
> > > > > v3:
> > > > > - Moved RSS key validation checks to virtnet_validate.
> > > > > - Add fixes: tag and CC -stable
> > > > > v4:
> > > > > - Use NETDEV_RSS_KEY_LEN instead of type_max for the maximum rss
> > > > > key
> > > > size.
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 34 ++++++++++++++++++++++++----------
> > > > >  1 file changed, 24 insertions(+), 10 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index
> > > > > db88dcaefb20..eeefe8abc122 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -381,8 +381,6 @@ struct receive_queue {
> > > > >  	struct xdp_buff **xsk_buffs;
> > > > >  };
> > > > >
> > > > > -#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> > > > > -
> > > > >  /* Control VQ buffers: protected by the rtnl lock */  struct
> > > > > control_buf {
> > > > >  	struct virtio_net_ctrl_hdr hdr;
> > > > > @@ -486,7 +484,7 @@ struct virtnet_info {
> > > > >
> > > > >  	/* Must be last as it ends in a flexible-array member. */
> > > > >  	TRAILING_OVERLAP(struct virtio_net_rss_config_trailer,
> > > > > rss_trailer,
> > > > hash_key_data,
> > > > > -		u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> > > > > +		u8 rss_hash_key_data[NETDEV_RSS_KEY_LEN];
> > > > >  	);
> > > > >  };
> > > > >  static_assert(offsetof(struct virtnet_info,
> > > > > rss_trailer.hash_key_data) == @@ -6627,6 +6625,29 @@ static int
> > > > virtnet_validate(struct virtio_device *vdev)
> > > > >  		__virtio_clear_bit(vdev, VIRTIO_NET_F_STANDBY);
> > > > >  	}
> > > > >
> > > > > +	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS) ||
> > > > > +	    virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT)) {
> > > > > +		u8 key_sz = virtio_cread8(vdev,
> > > > > +					  offsetof(struct virtio_net_config,
> > > > > +						   rss_max_key_size));
> > > > > +		/* Spec requires at least 40 bytes */ #define
> > > > > +VIRTIO_NET_RSS_MIN_KEY_SIZE 40
> > > > > +		if (key_sz < VIRTIO_NET_RSS_MIN_KEY_SIZE) {
> > > > > +			dev_warn(&vdev->dev,
> > > > > +				 "rss_max_key_size=%u is less than spec
> > > > minimum %u, disabling RSS\n",
> > > > > +				 key_sz, VIRTIO_NET_RSS_MIN_KEY_SIZE);
> > > > > +			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > > > +			__virtio_clear_bit(vdev,
> > > > VIRTIO_NET_F_HASH_REPORT);
> > > > > +		}
> > > > > +		if (key_sz > NETDEV_RSS_KEY_LEN) {
> > > > > +			dev_warn(&vdev->dev,
> > > > > +				 "rss_max_key_size=%u exceeds driver limit
> > > > %u, disabling RSS\n",
> > > > > +				 key_sz, NETDEV_RSS_KEY_LEN);
> > > > > +			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > > > +			__virtio_clear_bit(vdev,
> > > > VIRTIO_NET_F_HASH_REPORT);
> > > >
> > > > you flipped the logic here and it makes no sense now.
> > > >
> > > > Did you test this path?
> > > Yes, tested with Marvell's Octeon device.
> > > >
> > > >
> > > > So if device is powerful and supports a very big key size then...
> > > > we disable the feature? how does this make sense?
> > > The intent isn’t to disable the feature on capable devices, but to
> > > ensure the driver never advertises support for RSS key sizes larger
> > > than what the net device can actually handle. Even if a device reports a very
> > large key size, the driver is constrained by NETDEV_RSS_KEY_LEN, since
> > netdev_rss_key_fill() enforces:
> > > BUG_ON(len > sizeof(netdev_rss_key));
> > 
> > so cap it to NETDEV_RSS_KEY_LEN. Why is that a reason to clear the feature?
> Our device mandates that hash_key_length must be identical to rss_max_key_size
> to guarantee symmetric bidirectional flow hashing. If rss_max_key_size is larger than
> VIRTIO_NET_RSS_MAX_KEY_SIZE, clamping the value is not feasible.

I don't know what to tell you. rss_max_key_size is just the max device
supports. driver should be free to use a smaller size.


> > 
> > > >
> > > >
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > >  	return 0;
> > > > >  }
> > > > >
> > > > > @@ -6839,13 +6860,6 @@ static int virtnet_probe(struct
> > > > > virtio_device
> > > > *vdev)
> > > > >  	if (vi->has_rss || vi->has_rss_hash_report) {
> > > > >  		vi->rss_key_size =
> > > > >  			virtio_cread8(vdev, offsetof(struct virtio_net_config,
> > > > rss_max_key_size));
> > > > > -		if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
> > > > > -			dev_err(&vdev->dev, "rss_max_key_size=%u exceeds
> > > > the limit %u.\n",
> > > > > -				vi->rss_key_size,
> > > > VIRTIO_NET_RSS_MAX_KEY_SIZE);
> > > > > -			err = -EINVAL;
> > > > > -			goto free;
> > > > > -		}
> > > > > -
> > > > >  		vi->rss_hash_types_supported =
> > > > >  		    virtio_cread32(vdev, offsetof(struct virtio_net_config,
> > > > supported_hash_types));
> > > > >  		vi->rss_hash_types_supported &=
> > > > > --
> > > > > 2.25.1
> > >
> 

