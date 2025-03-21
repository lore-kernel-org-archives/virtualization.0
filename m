Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC80222582
	for <virtualization@lists.linux.dev>; Fri, 21 Mar 2025 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581631; cv=none; b=p1xjtZb4HqFSX4G1LWBgvNmd4FfUGn5b2St5i+SY0bAJj9Lhoc0kC9XulUb/+BfEUmKOSR/3McShPVKsVAMxX6KctnteWwDboeqgEn7ueAzGo0HxNWZDrbX0HdANWShRiINibBqD4ZY7lZ1M8rvwSp0egfjD0rbXcW57z9Xx3Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581631; c=relaxed/simple;
	bh=bTQZl+jKYwsLzl4vfj4ptDXiTWI3OAMPApOYg8CTBCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DmaFtctN5HQ4IIu5Xyx5Vg5dkvz3vlCtQebEAc5N3rQW4TM+Tf97JHwgTCPUmlYKNiV/QC/6LLHD1h4x4jRcvKIeb1dxMvaqNWEuQO2qBwB3kg7xkCzhN9/mq8g6LBagImbWyXmZkQznBgobzk6TA+rK1X89ByYIsE4N2Pj8Ht4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eAxy/fYc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAxy/fYc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742581628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CBvAZI44TSwYckHNoPIjidtJUdEM1gfFKOJZR81EuoM=;
	b=eAxy/fYcv1uI6yp2ZVhJYjHcw71zxa5Q/uxmLU3aOfHj7t4F5BW0AiVmd7LmRHDdPpPXjr
	UmIefqwb8Np0Ep6oYgpSnijf840d8n+mh/+HkxNTnx/mO6PP4JbttBDFddDwOcPXNDom15
	frEPDPt90JSfFmb3RhcX89CynrMUQ6w=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-BRrfnYo5MQyw44JttZdhjg-1; Fri, 21 Mar 2025 14:27:07 -0400
X-MC-Unique: BRrfnYo5MQyw44JttZdhjg-1
X-Mimecast-MFC-AGG-ID: BRrfnYo5MQyw44JttZdhjg_1742581626
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22647ff3cf5so30513585ad.0
        for <virtualization@lists.linux.dev>; Fri, 21 Mar 2025 11:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742581626; x=1743186426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBvAZI44TSwYckHNoPIjidtJUdEM1gfFKOJZR81EuoM=;
        b=Pb3Vy1MTSZYaFeu7pZu6WvMlZO8VGPlRN36uLTn/BjVQwOtx6AB0EE48XmzDcHVydb
         lrqEiyhc0BmoiLDYQUQxXJvFuDZJ9iXfwnCno05sZKHLtzqjn69OXQva8t8ruqqzpIny
         WLE9C5p4PzW/4LEV18AkrDSE4MYRQ8Wx2s0hokuHCaivs/NPR3Q5bEbXcowrX3ygynfm
         kBRLGPdD2HhZUkJJQY3bsSho4azMBlprdJ1myARb1kCFAo4EbgaQ+6IzoZ2iATSKkt8l
         Wfpv44HWiPNbC23RcIie+sUljB9s79aGsuIIRuwAsuAH+QB85GnCypgLJm2fxcB3yGom
         A5mw==
X-Forwarded-Encrypted: i=1; AJvYcCXjt+Jpe5k7UMnMfCvqMgklEWcu0MIIJYMYcU5zXYr7xoWdEfsv0HltuqH6EANISxpmwMz2i0UL34bSi+u+TA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWp/A3DCuNvucPZDBewP6JBaiV9C3r89icREyKePyL+AOFIdGj
	3hqBefq2TiyMoCI6XHNSooRYyFdiJU7ChkRBQDI8u3V/ka9MTDUGIT/xqxoEac7QCOaj6Na8SVe
	fsm6lm1cc7P9umsyORfkNBrGl7tsS3G2jJYleR+Q1HF+rsMirpk1iHQbqKgvFhoV5
X-Gm-Gg: ASbGnct2v9OgUY31acxk0ff8t8DmVAXXHiPYCz565EDSdK7OwXnOIOySpYyJudtGlAc
	8xyPoIFaTuxOY/uMLTm4zdkUxGSyODYtPRSBrU3SknyjiZifjRgfqOgPiF5988Bg8GMFVYJMMLv
	whOpz0VQTSlmdLioDAHSeqa1NiGlw20UlFL2LiDLh2EXK6gEa7VhlVkuEXJVhbDni6xaaPDZksI
	7PTZptexs2srYEe1vrdinPZkoHcUJn63aSAW85gz0glEr4Qulg/jPaXrJShbqUBmsEtnbj7z+FD
	QXXGbgoZ
X-Received: by 2002:a17:902:d4c5:b0:224:e2a:9ff5 with SMTP id d9443c01a7336-22780c68927mr63231065ad.9.1742581626018;
        Fri, 21 Mar 2025 11:27:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHESOlmKUv4omuiIQXNajC9s1OooXjFczUMnufBWcD/XHD7P+eP9u2TgzZG1Ni8l4wIF+1XA==
X-Received: by 2002:a17:902:d4c5:b0:224:e2a:9ff5 with SMTP id d9443c01a7336-22780c68927mr63230655ad.9.1742581625648;
        Fri, 21 Mar 2025 11:27:05 -0700 (PDT)
Received: from redhat.com ([195.133.138.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3b242sm20686155ad.41.2025.03.21.11.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 11:27:04 -0700 (PDT)
Date: Fri, 21 Mar 2025 14:26:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Joe Damato <jdamato@fastly.com>, Philo Lu <lulie@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devel@daynix.com,
	Lei Yang <leiyang@redhat.com>
Subject: Re: [PATCH net-next v2 0/4] virtio_net: Fixes and improvements
Message-ID: <20250321142648-mutt-send-email-mst@kernel.org>
References: <20250321-virtio-v2-0-33afb8f4640b@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250321-virtio-v2-0-33afb8f4640b@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ooNE2uqsjdplIaPrK9FCfRpgLh0CxYEYeYZ67gSmjJQ_1742581626
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 21, 2025 at 03:48:31PM +0900, Akihiko Odaki wrote:
> Jason Wang recently proposed an improvement to struct
> virtio_net_rss_config:
> https://lore.kernel.org/r/CACGkMEud0Ki8p=z299Q7b4qEDONpYDzbVqhHxCNVk_vo-KdP9A@mail.gmail.com
> 
> This patch series implements it and also fixes a few minor bugs I found
> when writing patches.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Changes in v2:
> - Replaced kmalloc() with kzalloc() to initialize the reserved fields.
> - Link to v1: https://lore.kernel.org/r/20250318-virtio-v1-0-344caf336ddd@daynix.com
> 
> ---
> Akihiko Odaki (4):
>       virtio_net: Split struct virtio_net_rss_config
>       virtio_net: Fix endian with virtio_net_ctrl_rss
>       virtio_net: Use new RSS config structs
>       virtio_net: Allocate rss_hdr with devres
> 
>  drivers/net/virtio_net.c        | 119 +++++++++++++++-------------------------
>  include/uapi/linux/virtio_net.h |  13 +++++
>  2 files changed, 56 insertions(+), 76 deletions(-)
> ---
> base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
> change-id: 20250318-virtio-6559d69187db
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>

