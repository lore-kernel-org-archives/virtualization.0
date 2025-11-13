Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A942F5316
	for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 15:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049566; cv=none; b=hg/VBtk1mnx8Bm0ZS7TNvoNuTF0hVfwT62C22sOSgTj4DvR+hiA9WUs6MBmifcYJfjaLRVMZvJsko9IXfMVezk6jOIdimmOo1CyRywIMFePsmTh9wiRZ+9Kc0yTl/iAU2qCX2bZ0FWf0HNHrzeDqFPpcobXZdm3MzeD3+DMSvzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049566; c=relaxed/simple;
	bh=3EmHzVlItT664raVKqR3ocJIvAjfrVhTn17yw4jaaDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=I8p++wJzl0DLWERkRCSYLZhmaCWR2b6J/hQX+RW2w3zCU+7/pOpqsZA9TEFMzNhdNIV0Sdu163c0m5SdJHuxtz9BRtx9cNNeqjECmFD9vZIOEyYZrtOUEgYyZzDFJ8Mheax9WcAjUNRcQcJG4iiGY0ArGo7UYdHy4Ir1ny4HXpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NqDjKf5a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqDjKf5a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763049564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uxRT5z3+ifPoZ0211AWdMWgnKEBvwJ3HVrBmgq2vp/0=;
	b=NqDjKf5ar7c3kjH48HV3lW9yhW72yqX9gMR9hDbafz3nhzKc3uC8gpjSb+OvCyoH9K1N8i
	Jpr7AMLmh/o6POrCyV0GHxBCWbERRYrr99w6TQxRmJUm+u6cDoIsJL1eqUKvigh08Ft5bI
	QeBB+HfkiKTGNtKYEIXlyQlj+sujj4g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-3YkIj4vbOBaa8MOWdm8phw-1; Thu, 13 Nov 2025 10:59:22 -0500
X-MC-Unique: 3YkIj4vbOBaa8MOWdm8phw-1
X-Mimecast-MFC-AGG-ID: 3YkIj4vbOBaa8MOWdm8phw_1763049561
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477212937eeso6395755e9.2
        for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 07:59:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763049561; x=1763654361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxRT5z3+ifPoZ0211AWdMWgnKEBvwJ3HVrBmgq2vp/0=;
        b=WPVo5uqaK6PSEQEfMKfUzJwa8WNWDUyAqSKWHzzz/DW29qtZHn53BwbfiqTuO26BlW
         LFj7wb9LsOrwsO/zcyUm2Y0UAn6p3emwD1Zq2sEP+yQEtc97iFMRv24BSlTjYr32Jbuz
         JsU3/SfNXZvniaPuhmSKae5bGrIXDdAV3Ekztc9WHH6d5kS72H4iXjlJumd6iBLC94ht
         EDQeXdsyXnbI3Yr5M3zEDfKETeon9IPXLaAx13WxabBSqE7eRESoFWkE85x0XHKFw8Dd
         6+5QFKLWDmAAH2+Ke/mw4Jn+6q2Hmtr3VfkO6Ya+iDy39czTLa1+F7gSn91SwEGXMuz+
         O9Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUwfmeikWJvb9GRn1paUYAEebW6k2G/Qy1LSj2IIhbPUSA3xBXHdl/PqyBO6mmoETsj/tXY3Db7UjLMBBLmqQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4rLUmRCOM0CPnLuN2qXrbaUlqLpvZEbyhfJJa+f2bCB5j87aG
	8doNhb0V65PfXG34AgLixNuaYdTZUbsLW92CIYe5YokOQn+/gvwGPqUdwdI01eYczkwVtwYxQS2
	Ey6rKw6JO+m45sQICSDsAm/AmJG/JPXsW2t1LQ7cu0oNWhlSQK4RQ+/6BGVGsPmCae0bc
X-Gm-Gg: ASbGncuJvZs84MJvOztW6aLSLfq9fpnJeonAn3SF3LFHe7lrf/2dZ6FjcqfKiCsKzTB
	KDcUduwkhP/6y2fFf1MEgx/VNF5QVffsZwv3mBPeEC8yqWp/RmJw8oc/BxYwEENjkIASLqlu/AK
	CQlfC7NMqHQz6f405BJ5WBzkOUMfdTJ4y1Kf4G1con0WE6/kVBjjZxGNw+oI1bvI3WnlrZlptHl
	qERORoGM1vhxmy4tNaQSx2i6XQeoU/y0OZEmoGmDxq42vpIqYe5O2NA+yzFtCDs0I3TeJZ2p3xk
	t+d+R4hQjrtoqlZdja4SrUkgTsdgqigkgB7F7OPq3KO1s7Z3E+Lz646+lugqfq2P+OTDsQXLdYv
	gpXr7chOXJ3yUV0Xajrc=
X-Received: by 2002:a05:600c:a44:b0:477:832c:86ae with SMTP id 5b1f17b1804b1-4778707ca20mr71013735e9.12.1763049561294;
        Thu, 13 Nov 2025 07:59:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHofPBYTP8F88iDpWUsKc8RAorynWUsDJxAs3/eKa1LXdZTVcuI1g6r5czDqfHcNjC7gedDcw==
X-Received: by 2002:a05:600c:a44:b0:477:832c:86ae with SMTP id 5b1f17b1804b1-4778707ca20mr71013415e9.12.1763049560788;
        Thu, 13 Nov 2025 07:59:20 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bb30e3asm24606075e9.1.2025.11.13.07.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 07:59:20 -0800 (PST)
Date: Thu, 13 Nov 2025 10:59:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	linux-um@lists.infradead.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net v5 1/2] virtio-net: correct hdr_len handling for
 VIRTIO_NET_F_GUEST_HDRLEN
Message-ID: <20251113105844-mutt-send-email-mst@kernel.org>
References: <20251111111212.102083-1-xuanzhuo@linux.alibaba.com>
 <20251111111212.102083-2-xuanzhuo@linux.alibaba.com>
 <25b05194-63cd-4265-8d2c-e174d801fc3a@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <25b05194-63cd-4265-8d2c-e174d801fc3a@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _D1WitAI6QLnV3ZFzPC_rCD2aHpsY6fCTa-H5Ds4rNw_1763049561
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 13, 2025 at 03:39:35PM +0100, Paolo Abeni wrote:
> On 11/11/25 12:12 PM, Xuan Zhuo wrote:
> > The commit be50da3e9d4a ("net: virtio_net: implement exact header length
> > guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> > feature in virtio-net.
> > 
> > This feature requires virtio-net to set hdr_len to the actual header
> > length of the packet when transmitting, the number of
> > bytes from the start of the packet to the beginning of the
> > transport-layer payload.
> > 
> > However, in practice, hdr_len was being set using skb_headlen(skb),
> > which is clearly incorrect. This commit fixes that issue.
> > 
> > Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length guest feature")
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> 
> IMHO this looks like more a new feature - namely,
> VIRTIO_NET_F_GUEST_HDRLEN support - than a fix.


I mean if guest negotiates VIRTIO_NET_F_GUEST_HDRLEN but the header
length is wrong then yes it is broken and this is a fix.


> [...]
> > @@ -2361,7 +2362,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
> >  	if (vnet_hdr_sz &&
> >  	    virtio_net_hdr_from_skb(skb, h.raw + macoff -
> >  				    sizeof(struct virtio_net_hdr),
> > -				    vio_le(), true, 0)) {
> > +				    vio_le(), true, false, 0)) {
> >  		if (po->tp_version == TPACKET_V3)
> >  			prb_clear_blk_fill_status(&po->rx_ring);
> >  		goto drop_n_account;
> To reduce the diffstat, what about creating a __virtio_net_hdr_from_skb()
> variant (please find a better name) allowing the extra `hdrlen_negotiated`
> argument, define virtio_net_hdr_from_skb() as a wrapper of such helper
> withthe extra arg == false, and use the helper in the few places that
> really could use hdrlen?

