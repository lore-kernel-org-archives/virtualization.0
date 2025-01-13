Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEA71F8EFB
	for <virtualization@lists.linux.dev>; Mon, 13 Jan 2025 22:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736807042; cv=none; b=pymdq5EjvNy4/hhsi4rDXwNY9xLhBWD5fREDngq7B2yUhAA8O35qiccvHbPlR/vqf/F6xYVL1Yj6Nwita36MBsDuRdwJot8rjcJfMNzUUWCC+EcJBlCmoxYcWJ+UdJzY6Kwv++USVzmHm3gdyKSGnwd756HXS78u2Qz4wrJMVYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736807042; c=relaxed/simple;
	bh=jraBJYaNKuM4ks66r89Q9Cssxz1SfOAZy8ZJzGHSuiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFE97+XOnU/1TeRMgh6Sjh+ekWEH9N8dX7WWeiRk+jB5hdPHngYJQ8AYX41kjCLb1R4jjxUjmxMOYZNgueM+o/JHV1PNq35BQKZNwm04eNbHCF9r4Z5534z5ITvEpZStee9yDSOT9xKSn6nlrP1ZjYCQqcTlIyH4h0iarIVDkkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LLqSTeeB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LLqSTeeB"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-216401de828so79485585ad.3
        for <virtualization@lists.linux.dev>; Mon, 13 Jan 2025 14:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736807040; x=1737411840; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OWEGafjI92owQD2zGRSWReNV8vxv3omjYwC2PJyLuQg=;
        b=LLqSTeeBwW5zLdtwZ+3v5IFVfQVgQD92eiHI0EWhCqfG4EGLwPPayCiKXA+s44YUU/
         dzhVeAp8JVkrsC/sAeiW1FeCOSOHG6PyxBs6VUBTO6FO5oqHOGoQ+LEcuaFWVMja7ZIp
         YTwmGgbWQOR4qHMFHjaRqhipqg9dt1epR7aAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736807040; x=1737411840;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OWEGafjI92owQD2zGRSWReNV8vxv3omjYwC2PJyLuQg=;
        b=oMrT0U6cAxYvijg3CGAOlNBcvdFFr0mAWhj3zCjdDrWnMjCm0mDsngwHrz9AIv2FHu
         2/Fz3Y3ur6sRMCVyz50XV4G/7v/C5gQQf/OUe1sHTDrXtPEn4aBepJZS/eVOfsozgK4W
         zxO+oalZugt4QoEAQ/eZ5s1KApMUci7CWkNwdogjVVoSQMhl1tvkWQ0we9POcIw8Xse2
         7DkGpDOSgAvgCo89famf1j+Pqt36pwBHulvJqSzXl9uX6zfrOsmTqVQR87kSxQir4H1x
         WYBwMlxBPn0Ad1YVaF+fWNIFYhBbU9tBpjfIor5ZWG/+jkT5RgqBHfdkMsEdDyKvtwzW
         /rww==
X-Forwarded-Encrypted: i=1; AJvYcCVWs6j9XkV1bzJcUKoFD17m6XoeZlv/X+nLHRl0ncZrjG+Bz0Z3+pwdWRdHq2cRB5XoOI4f6ccAvmC0lynlHg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwK1gefMihxW+Net9Xj6qGRVorOVbLVxvmRx15wzAQFXfuxUkhf
	omyUCCyyOIokeQuuhWj5ICaQnRj9tAx8vYPsf+hhNRWdvK7g3bJUnq1m+DEAVZQ=
X-Gm-Gg: ASbGncuAzqnlvcBPLq/AYo7eIxLoPwZOoVIXzn7GPr6jKBk5xqNsnyfpGKPptX0CoYP
	wy9Mng3crxV6YgZBfLnW1LAZ9/IJWVfHuOyhgkc8XY5pONkXLzwqQJ2LTOHrN3Ym2XwViGyYN1o
	thrV/4YgbvHVDwM+97J4lLKUfAUoisQVA6iu9GfCbwt5dwEPorW/r649DtNdqr9klt1eJqgizwv
	spELCKy58qIsq8OCnXWC8Xkb6Vq2RZY/2/4TASMmpbqQc9VWWXsSbuqkzN3FZD2oJD2Bph/xbHG
	2rLUXEfiW4bJtWKss3I0wyA=
X-Google-Smtp-Source: AGHT+IGRopay+m4MXKSpsww/HEMIYf2K6aGjf/90wlXRRh/leJG1vGjE3JADPcrdleil3GS6FrlG/Q==
X-Received: by 2002:a05:6a20:2594:b0:1e1:94a2:275c with SMTP id adf61e73a8af0-1e88cfa740amr33957317637.18.1736807040166;
        Mon, 13 Jan 2025 14:24:00 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a61f7sm6511552b3a.175.2025.01.13.14.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 14:23:59 -0800 (PST)
Date: Mon, 13 Jan 2025 14:23:56 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, "Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 3/3] virtio_net: Map NAPIs to queues
Message-ID: <Z4WSfER6O6n3hxXh@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
References: <20250110202605.429475-1-jdamato@fastly.com>
 <20250110202605.429475-4-jdamato@fastly.com>
 <CACGkMEtjERF72zkLzDn2OKz3OGkJOQ+FCJS3MRscJqakEz9FYA@mail.gmail.com>
 <Z4VNrAI794LixEXt@LQ3V64L9R2>
 <20250113140446.12d7b7d3@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113140446.12d7b7d3@kernel.org>

On Mon, Jan 13, 2025 at 02:04:46PM -0800, Jakub Kicinski wrote:
> On Mon, 13 Jan 2025 09:30:20 -0800 Joe Damato wrote:
> > > >  static void virtnet_napi_enable_lock(struct virtqueue *vq,
> > > > -                                    struct napi_struct *napi)
> > > > +                                    struct napi_struct *napi,
> > > > +                                    bool need_rtnl)
> > > >  {
> > > > +       struct virtnet_info *vi = vq->vdev->priv;
> > > > +       int q = vq2rxq(vq);
> > > > +
> > > >         virtnet_napi_do_enable(vq, napi);
> > > > +
> > > > +       if (q < vi->curr_queue_pairs) {
> > > > +               if (need_rtnl)
> > > > +                       rtnl_lock();  
> > > 
> > > Can we tweak the caller to call rtnl_lock() instead to avoid this trick?  
> > 
> > The major problem is that if the caller calls rtnl_lock() before
> > calling virtnet_napi_enable_lock, then virtnet_napi_do_enable (and
> > thus napi_enable) happen under the lock.
> > 
> > Jakub mentioned in a recent change [1] that napi_enable may soon
> > need to sleep.
> > 
> > Given the above constraints, the only way to avoid the "need_rtnl"
> > would be to refactor the code much more, placing calls (or wrappers)
> > to netif_queue_set_napi in many locations.
> > 
> > IMHO: This implementation seemed cleaner than putting calls to
> > netif_queue_set_napi throughout the driver.
> > 
> > Please let me know how you'd like to proceed on this.
> > 
> > [1]: https://lore.kernel.org/netdev/20250111024742.3680902-1-kuba@kernel.org/
> 
> I'm going to make netif_queue_set_napi() take netdev->lock, and remove
> the rtnl_lock requirement ~this week. If we need conditional locking
> perhaps we're better off waiting?

That seems reasonable to me and I can wait.

Please CC me on that series so I can take a look and I'll adjust the
v2 of this series to avoid the locking once your series is merged.

Thanks!
