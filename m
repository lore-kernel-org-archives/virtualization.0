Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B86E2D322F
	for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 20:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769631603; cv=none; b=u5OGEIsLc+hm6LNu12b1MrAVMR0RlJmGIepQyDR3nWJBOEy0NoRCDo++o8orgfrrkcHhMji3fzy05CPBSi3tKM3XjF81Ca4nl6cfnkBjphPp5tLb4Kt3bxrMdO7X6CB3y3vfNUqbvfEIMqPRuhpvYBmYx7ZLXQOXK6QuOrvNbAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769631603; c=relaxed/simple;
	bh=H8MOGYyVpy4spKBgCPB86YiyYdvqAE0R02Wh7I5HQXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=T7czNpxPVxmkmG83WAg3v0FB9+Ap1VQoOn84IRPRhwNe1t9v9qcveNjfB5HKcHTE9NXqt/e0Gzg5j1grefvcJgaCxTlUtgBDCYljEdzFXyJO0rI5tzzlhvZ3m+Mbx4Y0+fvrxBlY26of96a9Qrm2oo7q1bVYyiys1meoCY1eHJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O8j92tum; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8j92tum"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769631601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Du6Lg6EMjGRVf9Alie1QVsUprTCTw9C8a2HYgbNcUXs=;
	b=O8j92tumgKbt7pz8TuAePVQkYIxnW91vFvnLYoQvAwEhCu66jXMAGwNQeWkHHrqymWtrCe
	xhXtWVtLgvSNqIwUc1BcV39UwnnXFw3hyfazcwhD+kocW1EAcBGBUGcUhzAC5Ibmdb0xt2
	oWQtjd9YCVrhfO6o44bwQGsyAqrwmA4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-W9l7-b4vOjWfnxMd4MsAZQ-1; Wed, 28 Jan 2026 15:19:59 -0500
X-MC-Unique: W9l7-b4vOjWfnxMd4MsAZQ-1
X-Mimecast-MFC-AGG-ID: W9l7-b4vOjWfnxMd4MsAZQ_1769631599
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4325aa61c6bso177444f8f.0
        for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 12:19:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769631598; x=1770236398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Du6Lg6EMjGRVf9Alie1QVsUprTCTw9C8a2HYgbNcUXs=;
        b=NrkWcPTi/aY63oU1NGEiLKk/QqVbRTp8D0yzZy9NktO7UdMVfUA9G9rKIAJcaSq957
         s6y3+MXSy3zi3bVbk+ocbUnrdQaV3G4JAnSfnEdqg9QqqpBqxvr7f6mwYsKyseH9aaMM
         z8iKHTxT1NlactSGphDm6lU/KF9RMEVnsDq7NcQ6R8H0uNOhParQc0qu7aAYGddbnMfP
         Ohs/V4JjOhKdkL0BjT5hfXgfJHhzW5U2AwuqL2gmGqls2RhRuEfi0rHLDTmIOVA/pccV
         FXf+ScHRGRasMxB7V0++I22h9NrT+leUJfoOoghJu0XZWDr87pSGIxzXcNB7JWPwt4C5
         hwoA==
X-Forwarded-Encrypted: i=1; AJvYcCUEGCd9Dzf87gjueU0gDFdYjhmhWBjjAQBWjETVE4eo3ptuPucacCYwLuA6IBUJ/1TW1MOjtupWTw+D6ydCwg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkDiUS411+6TvmttXwsU5An/dEAdJvzYxsTMUe7RL0wf54WxqU
	QkfxVAjpkde4g4DeN5nirs5wPOIcf9KHjGbnhIc8br8g/wy1btlT096QR2rK2LMB1/Zf8rzGzgQ
	wRvdh8UR3q0pwcatUU3/93O9skVugUt9Tqn0z8N1jweeL6Kip+vPwQUO9ubXlXtBuU58b
X-Gm-Gg: AZuq6aKjQ0jmEizqHjLifgj59ZHPm4TTGGoYmA0fxIi5JwmUACnC39ETNvo2EfiLA2P
	DO77OHS+Qngc+M9SfFIfC6p/DBhEh/3NKAMco1lrPnztL+me8vZ6uVT10yloZKtSkdjehVfMscr
	4YdL+uaaayDAUm2f4SGNfY5ODd+En91qzfShFe0Oaa6b+bQDk/sry8sbwSOKFcQBrSJlYhAtz1n
	zC9jdZ5Iwjc1FcOn1JtvRUWoTJqDDYs6bdNQakaEoxqsmHK3dxr2AEVzoLvDTbrLM5UbgphpbEH
	GgGndPMMg+zxGilMKvKjX1GyV2lpqr1/p+o2uBh5zSl6G5gpweGf6CqwdTAPZ4amEANNWh+7oPB
	7MEgyabKFwfnOyvUgto61DWvFb3/Lpsd+Iw==
X-Received: by 2002:a05:6000:2481:b0:431:a50:6e97 with SMTP id ffacd0b85a97d-435dd1bd8bbmr8045516f8f.34.1769631598594;
        Wed, 28 Jan 2026 12:19:58 -0800 (PST)
X-Received: by 2002:a05:6000:2481:b0:431:a50:6e97 with SMTP id ffacd0b85a97d-435dd1bd8bbmr8045486f8f.34.1769631598089;
        Wed, 28 Jan 2026 12:19:58 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1353ac2sm9728183f8f.38.2026.01.28.12.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 12:19:57 -0800 (PST)
Date: Wed, 28 Jan 2026 15:19:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] virtio_net: add page_pool support
Message-ID: <20260128151944-mutt-send-email-mst@kernel.org>
References: <20260106221924.123856-1-vishs@meta.com>
 <20260107032738-mutt-send-email-mst@kernel.org>
 <ecda097e-e3cc-47c4-aad3-61f6af950a71@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ecda097e-e3cc-47c4-aad3-61f6af950a71@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: P0lwUmfZGv4ZM3ZPDsFeoKxSRU9-R0oR28GKd4fjNaA_1769631599
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 07, 2026 at 09:23:46PM -0800, Vishwanath Seshagiri wrote:
> On 1/7/26 12:28 AM, Michael S. Tsirkin wrote:
> > On Tue, Jan 06, 2026 at 02:19:22PM -0800, Vishwanath Seshagiri wrote:
> > > Introduce page_pool support in virtio_net driver in order to recycle
> > > pages in RX buffer allocation and avoid reallocating through the page
> > > allocator. This applies to mergeable and small buffer modes.
> > > 
> > > The patch has been tested using the included selftests and additional
> > > edge case scripts covering device unbind/bind cycles, rapid interface
> > > open/close, traffic during close, ethtool stress with feature toggling,
> > > close with pending refill work, and data integrity verification.
> > 
> > 
> > Yay! thanks for working on this!
> > Could you share perf data please?
> > After all, page pool is an optimization.
> 
> Thanks! I'll add benchmark numbers in v2 of the patch.

This never came, or did I miss it?

> Beyond performance, page pool support is pre requisite for enabling
> memory provider based zero copy implementations in virtio_net such as
> devmem TCP and io-uring ZCRX. These features require the driver to use
> page pools for buffer management. I'll update the cover letter to make
> this motivation clearer.
> 
> > 
> > 
> > > Vishwanath Seshagiri (2):
> > >    virtio_net: add page pool support for buffer allocation
> > >    selftests: virtio_net: add buffer circulation test
> > > 
> > >   drivers/net/virtio_net.c                      | 246 +++++++++++++++---
> > >   .../drivers/net/virtio_net/basic_features.sh  |  70 +++++
> > >   2 files changed, 275 insertions(+), 41 deletions(-)
> > > 
> > > -- 
> > > 2.47.3
> > 

