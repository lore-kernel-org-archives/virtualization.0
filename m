Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EC91494C2
	for <virtualization@lists.linux.dev>; Wed,  3 Apr 2024 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148806; cv=none; b=FP23gMKeiupCTDYLQ+KF4j8nV/6iSGzwLOQSkdmjk4mZBHdlbFXKUqmHW9l9umWKKmH2zQY5AZrdG62iU9pRxC7urQB6no98P57gGPd1LifCYDyNtlwDfonR0FgZXvrc+HO+SSkPqjVcoTTyd15m2t6UcrSK4CbPEmbSjL4vck4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148806; c=relaxed/simple;
	bh=UntQTPh+2hrQn/xIlOWJaJgrauzrTj7yswbk+DwsRJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A95FNpqmcXNG1e+AhRokIkx0T79pmZtmoXRwAN/absOaGpZE9zGhmQ/mnVUR0bZIe63IdOZAT+fAy9Zdd8kVwyYSHV9Ct+WPaXCS5ak9kPN6t0oFCH78qEug/wNoq0EFJxGlqW8Pu3OyyM9Ppq0KFr8LDhXnuVzZ16Q6pf+GDpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4e34d138f9so659270466b.2
        for <virtualization@lists.linux.dev>; Wed, 03 Apr 2024 05:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712148803; x=1712753603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4cj6vg+PLMD3bnAnC/7BKVkE+A86qwqaG5PcVTOt18=;
        b=Bp0agPBdzm6dptgopjfpETRqtDelb3iuVr167rO40JhDl6uXAJg5apD0Uo3YEuOzD2
         qCtTvVT64aMWJbdBiaXGP/BkP3Pfvlr98jc/PzReWOEYYMcGAc7DqQtPRrx9ucoJwvQi
         y0hTazHEkFjvdN1XqxiamaQgq2A7amtK+ya0BrOQqfda0USmQP/mKVcLo0RamBbwD3h1
         OR8qrYZqVpOL51D304O8vWtZp5oZ1+EFMIo8IMv6FF6sNoOHqP0Hizh81QJA+n9a2KiG
         Aq6tpfPREpA2/rPHC6ROhdctvL+9svMH9W4Az3AL+HthbcD8ruSZDNs6y6ZgD/b7+Yvd
         mIUg==
X-Forwarded-Encrypted: i=1; AJvYcCVZHRT7NUbSiYpMUxtdNX3l3LrXa8eGcrJtAzjeZwFv+HU6QIUkWDYPWZ7bevYfUi1R6/h5PIQCUaqA8SYQGt/9gn+ruDvuIDHB0JxYiS0=
X-Gm-Message-State: AOJu0YzJyRtSYOiou1UtVD8uymMBgbOhYZ0jARpzqecPMkEnSjCtx+VT
	H1sPIxEVND9Ccjsd7s0lMFyl/sCv2p39eZMNRUyzI/PVQvJSxis9
X-Google-Smtp-Source: AGHT+IG/LZvkvkvKke8uVXcXbrYjZ9FSvr+Pm5+/tdlPUCoe15E1D9VDt24wooC2fGJfQa9Hdwxe2A==
X-Received: by 2002:a17:906:2284:b0:a4e:39f1:6374 with SMTP id p4-20020a170906228400b00a4e39f16374mr1812470eja.24.1712148803105;
        Wed, 03 Apr 2024 05:53:23 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id an3-20020a17090656c300b00a4e7c2b2070sm2694127ejc.8.2024.04.03.05.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 05:53:16 -0700 (PDT)
Date: Wed, 3 Apr 2024 05:53:12 -0700
From: Breno Leitao <leitao@debian.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: hengqi@linux.alibaba.com, xuanzhuo@linux.alibaba.com,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Melnychenko <andrew@daynix.com>, rbc@meta.com,
	riel@surriel.com, stable@vger.kernel.org, qemu-devel@nongnu.org,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3] virtio_net: Do not send RSS key if it is not
 supported
Message-ID: <Zg1ROBmnY0jaKvsf@gmail.com>
References: <20240329171641.366520-1-leitao@debian.org>
 <20240331160618-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240331160618-mutt-send-email-mst@kernel.org>

On Sun, Mar 31, 2024 at 04:20:30PM -0400, Michael S. Tsirkin wrote:
> On Fri, Mar 29, 2024 at 10:16:41AM -0700, Breno Leitao wrote:
> > @@ -3814,13 +3815,24 @@ static int virtnet_set_rxfh(struct net_device *dev,
> >  		return -EOPNOTSUPP;
> >  
> >  	if (rxfh->indir) {
> > +		if (!vi->has_rss)
> > +			return -EOPNOTSUPP;
> > +
> >  		for (i = 0; i < vi->rss_indir_table_size; ++i)
> >  			vi->ctrl->rss.indirection_table[i] = rxfh->indir[i];
> > +		update = true;
> >  	}
> > -	if (rxfh->key)
> > +
> > +	if (rxfh->key) {
> > +		if (!vi->has_rss && !vi->has_rss_hash_report)
> > +			return -EOPNOTSUPP;
> 
> 
> What's the logic here? Is it || or &&? A comment can't hurt.

If txfh carries a key, then the device needs to has either has_rss or
has_rss_hash_report "features".

These are basically virtio features VIRTIO_NET_F_HASH_REPORT and
VIRTIO_NET_F_RSS that are set at virtio_probe.

I will add the comment and respin the series.
