Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A193D313267
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 07:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538929; cv=none; b=sVNPedaAHYAZD03PIXEZK+sIp/tGZ/Kl3padiLongSZaD1XzABCHLA4xJDFIXpweHyWKCIZAUh65jC5iP69HevWiA60aQKpe3GQPizPNlor/Fe8hBQkE+D1ttkwgkCERWPUBay7EPGYv7aOkXGzhOdwkLdE6Hxi2nTunNg+N6yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538929; c=relaxed/simple;
	bh=lgBjLI8m9ms1izIzzAa9bQR9euWWL9lpEKsMBynI9yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BuOnV4c7EV2DiBop9DfzUNBOesC0Be8BIZLfBnYvxB+5aaSfCxrkfkL61nKj/sVrGE1NM51KRYYOPleUv/fxxq50Xley8wDTsWq01owOO2L3TYxQtr3dTFYn7nYogh0anKVIqFKu6k7x31jxK22OheWelIkpxJoSc8j8xvsmdAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EglCYgsM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EglCYgsM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763538924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SR56Js+oycTgnA9YQo5Mfd0UB5A6sCWtJq2NsOrtgwg=;
	b=EglCYgsMzr0RlrQ7141bYtSmlQuYWadntk8p6xjFja0fD+VLZRakv2J6iJhWsUqZjKtWQl
	TLQxBvk5tF7idYZJVetuN3QxQ5WMPYacvVI+VtoppiHuxiGxqC02NCJ6gd63m3zCnqwPKV
	0n+kN/gUU207iRgINrC/2QRsR92Ix0Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-Iez7h6NjPFK1zu3KvmNFcA-1; Wed, 19 Nov 2025 02:55:23 -0500
X-MC-Unique: Iez7h6NjPFK1zu3KvmNFcA-1
X-Mimecast-MFC-AGG-ID: Iez7h6NjPFK1zu3KvmNFcA_1763538922
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b30184be7so1017292f8f.2
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 23:55:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763538922; x=1764143722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SR56Js+oycTgnA9YQo5Mfd0UB5A6sCWtJq2NsOrtgwg=;
        b=Yzqs+Uct+GvtJcsGG9Y5in+np97/dJ9yzERJHKuC+k3CGhD6ryN7bcNuIDCkV09cb2
         gZXhtMcp6XeuTnOaEl6SYig2qOh21z3/q2z5GkzQAmzKRCMiYQg7BnVgBq9WxNIF+0mv
         fSfFGz2gUZ2Dmm+cw7hhRHoRHY09lWvP+hDgYlJZup3kmyFRg0M8znwU3KwpsNg2aKNr
         GRIOaiqvEvz6e0wPiwinkUn+vDxeB9mDKT+ZN683zujwuYVjsHLlNy/f1pEFJDVCFErD
         DQP3j0EQsYqwLlNDFLOlYNT6hQNrKEozVaQV1KpqmO1VbL+dfA+d2tD4i9VoBDE+22x3
         +nuw==
X-Forwarded-Encrypted: i=1; AJvYcCU2XwLXLN3a1TvEBGf+bvvWJd8vS7ZPxUtaORqgdUdAgnb8aO1ms7loZUQfJWqvoLG5MobNZl5TsOmStJ9R3g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1c+iL72htpApLNHu+xGTJwVjzNBWAfiJ2LbQ9I68TqUlzy4d1
	FOUW8kpAG0B3eM2y2stdyZjSY0yZGoukKRXYDKGk30yFGJtM2Uq6/6nsKNFI4GwBj+YikxiFOsR
	jHmMt40exhpcddQgDkfApV+0+4y1GY9UiLaEfPuWYbBYoXiIKZ12YeKlY9G+s1ufIMVJg
X-Gm-Gg: ASbGncteKyVIE8FaFN0RbvEmhH9eRwrYsWPdDPMHuT2Uuwwis2ARaHVLG9sonrZtjrP
	s0eatawrvjU3pmU9p6Y5XDMBFLOMEGjzci4/IN0kyhKfDtj8GSAsicGi97QCJftag3A3k+I5K4W
	SYvpeDEL1gdb99nzmSUxiPu2ckAc3tgzYpzcT0N6brxq8qoitooVYIBCEPgdWnZAg9B+GPXUxWC
	mvZLETncGDUJAljJEDOeFQWxzcStvWKsgcw5HVsecL8HAqV8Ww+p0/+mNKqHdAFn6hsiwJsS9qW
	HtbHs3uysjRFdpnUYlZF+wwbrqd/mB+AK97lVOrSGu1kV7CF3xTU/jVyXvU9qBLeeTHW/DPQ3/G
	oLGLyci2PyjFolkOgsJoCFNyx267KOA==
X-Received: by 2002:a05:6000:2087:b0:42b:3ab7:b8b8 with SMTP id ffacd0b85a97d-42cb1f5d859mr1624246f8f.25.1763538922219;
        Tue, 18 Nov 2025 23:55:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAXZsZPpb6BnPnIDeZJ0idKcRG+zh5V+FkCL+0HBpxBjeSdEP6UJHLaM1iOkf6YKPLjuop1Q==
X-Received: by 2002:a05:6000:2087:b0:42b:3ab7:b8b8 with SMTP id ffacd0b85a97d-42cb1f5d859mr1624208f8f.25.1763538921625;
        Tue, 18 Nov 2025 23:55:21 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b62dsm36457979f8f.24.2025.11.18.23.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:55:21 -0800 (PST)
Date: Wed, 19 Nov 2025 02:55:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 05/12] virtio_net: Query and set flow filter
 caps
Message-ID: <20251119025445-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-6-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251118143903.958844-6-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OsfzmYXo8OP8RzXQ-4XyVPeDla6pgHVZGRVDPvuEjmg_1763538922
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 18, 2025 at 08:38:55AM -0600, Daniel Jurgens wrote:
> + * @selectors: array of supported selector descriptors

I would document their actual structure here.

> + */
> +struct virtio_net_ff_cap_mask_data {
> +	__u8 count;
> +	__u8 reserved[7];
> +	__u8 selectors[];
> +};

