Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7268635F19C
	for <virtualization@lists.linux.dev>; Fri, 20 Mar 2026 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774002512; cv=none; b=JsgWzyfetNurut6iFx5LcqE2nFVKapx6vH/nAitoE+ulpl6RdrTQ/Q19YjP6UkgkOM331dKHpkeJX89OdKh4CO4Om9FY53xLSlfJExGxsxQWJDmio8lLzi6r2c1iNejK2/VBn6uKPw3j3AeE7bLHuKlUtjIQY6Ldp4EcGs2aOpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774002512; c=relaxed/simple;
	bh=KyJKK5isZ64xOnxxGEaZ5VV7iYtLlVlKAJxcAORDKgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pvYWjImaYx8FLJyzTaISLMmNatvml/G2ANhwEOCxCx/A8wBeyoCqYslbqlRis1FSXSm32AWgVlOA3suBYzh0f3Pa4Gx4McX9L1y3MxVGCOA2t90prS6G4VoCtCM2C65PiUON6/mVg51Ud+BiLQDm+fn0IIz/oiBYd0+5EKGdn1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YuXUAk7Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YuXUAk7Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774002509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ETcinoc+Iu6TM4nD/QE43KJ6uJXP6/02M2IBKPvEmHw=;
	b=YuXUAk7Q3Jg0i4Jmyf4QML7ae2gisjMgjocC/GDtjIwbYFN7lg6u70k3bjcJl7R0eLuNqx
	aQiaCBjvAUhOUtyl/q9Obrxcjff5MgVnCidrOMGQLSEuPF9Lk4sRyN8V+t5NgmnEccQLk5
	9cOPEfzzfMPRo4KjArRmnY/q3HDdobY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-5Ln-7wCRNASnFK36WrbDLw-1; Fri, 20 Mar 2026 06:28:28 -0400
X-MC-Unique: 5Ln-7wCRNASnFK36WrbDLw-1
X-Mimecast-MFC-AGG-ID: 5Ln-7wCRNASnFK36WrbDLw_1774002507
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48531e6012bso32926595e9.1
        for <virtualization@lists.linux.dev>; Fri, 20 Mar 2026 03:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774002507; x=1774607307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETcinoc+Iu6TM4nD/QE43KJ6uJXP6/02M2IBKPvEmHw=;
        b=etASanoKZT23yrdZH2SaOveEJMP9c6mwbeWDn6HCgZ3bFoZxw/60wtZxJal1jiF8UC
         pIJcod5pFRofz4KBQ6X2qgvYgzLpZoN8aXYh7+QBQ4GiYEBNrzLsUL+woanA/co8Fy3/
         B5raxlj4TG+Cts0+fQJLeRpPz1CC+Y8Wgdvioty9zTVqwEF624W/p44BsE0mtlHe56DF
         HLNLys+UjvYIP7YGwLcFD9gmMolNExOPPOEmRyg8LiBv0d26u3qbXA6EaGHZVl3QrmFV
         twKH5v1CEICHcybCsPKx/vXcY3G+ivDWCjWaN4+AQAA2TWv33hezUMJ3dKA4FY/dSUou
         7TeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT/WnzyQM0MKZiEYXRg9c6MHVHUQ40HI4c++kWQGS9ebzDK2YIv5Va1MHoQNEXAYyPvK5hrnh5yMb0TYKDXA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyD/9tIyi2bUQN4ZhIlXPq74n9EJcBnD0g3Uw8CCADHGK9JZbvh
	glBFzxniQbhwbtknHPO/y8dpa8S8k0qe5L9424Ph2Eu+b0F7yHM6mHTENk5Xc8nKnsZAMVCIAwU
	sgh9S35Vvf6DVaVMJjR8jr1p1TMjavice69zIlJUt0KLP0e3IXBodvbDyXfEFyUH9q1ea
X-Gm-Gg: ATEYQzyDVq0kkQNjliMnSYHpi3LidKWTDBfczF5/2Bufrw9eskYnviHxe6Hb/jA4owc
	VpXw90Adjx5v7wKbPFIoIBreVLwJi7btvSj+M0+R3mcE81T7JA5Jj+eCYLjwBK10IL0/DH3EQV6
	adz59wVnw5REQhDarrRa1ycEfeFSzArqPVZeSkcy2fgEsBBFdVtxsoFmmZSDiGCGfuCwQxOnGBN
	AIhXsknZmp+kE2UFn2/cExjmGXcOnmKueo4wweHlTSQGeWV0LgapOo8S912hZIxnwKLYeze72Cr
	1DVKowUV7jjGUbk2VrEdBXxVJt51ZirrO8VkQZozmLxN6KPIlVyqxR5bXLQr048mPkmDpD84hTD
	ea8RkuvRSMhopaExV
X-Received: by 2002:a05:600c:c84:b0:485:3812:36f6 with SMTP id 5b1f17b1804b1-486fee0bcc1mr34021625e9.21.1774002507007;
        Fri, 20 Mar 2026 03:28:27 -0700 (PDT)
X-Received: by 2002:a05:600c:c84:b0:485:3812:36f6 with SMTP id 5b1f17b1804b1-486fee0bcc1mr34021275e9.21.1774002506531;
        Fri, 20 Mar 2026 03:28:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe7e3a94sm59954255e9.7.2026.03.20.03.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 03:28:25 -0700 (PDT)
Date: Fri, 20 Mar 2026 06:28:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net v11 0/2] virtio-net: fix for VIRTIO_NET_F_GUEST_HDRLEN
Message-ID: <20260320062811-mutt-send-email-mst@kernel.org>
References: <20260320021818.111741-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260320021818.111741-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eIsgbDI9wtdIEXUH8WBTZ58-kPi16nCSlX2FVwulTQo_1774002507
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 20, 2026 at 10:18:16AM +0800, Xuan Zhuo wrote:
> v11:
>   1. rename virtio_net_set_hdrlen() to __virtio_net_set_hdrlen(),
>   virtio_net_set_tnl_hdrlen() to __virtio_net_set_tnl_hdrlen(), and add
>   explicitly mention in a comment that such functions must be invoked only after
>   virtio_net_hdr_from_skb()
> 
> v10:
>   1. fix http://lore.kernel.org/all/202603122214.8Anoxrmq-lkp@intel.com
> 
> v9:
>   1. Introduce new helpers to set hdr len, and virtio_net_hdr_tnl_from_skb
>   calls them directly.
> 
> v8:
>   1. move changes of virtio_net_hdr_from_skb for udp tunnel to #2
>   2. remove change for num_sg
> 
> v7:
>   1. fix bug reported by robot
>   2. Still splitting into two commits, as the issues fixed originate from
>      different commits. This separation makes it easier to selectively revert to
>      previous versions.
> 
> v6:
>   1. rename to guest_hdrlen
>   2. introduce a function virtio_net_set_hdrlen to set the hdrlen
> 
> The commit be50da3e9d4a ("net: virtio_net: implement exact header length
> guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> feature in virtio-net.
> 
> This feature requires virtio-net to set hdr_len to the actual header
> length of the packet when transmitting, the number of
> bytes from the start of the packet to the beginning of the
> transport-layer payload.
> 
> However, in practice, hdr_len was being set using skb_headlen(skb),
> which is clearly incorrect. This path set fixes that issue.
> 
> As discussed in [0], this version checks the VIRTIO_NET_F_GUEST_HDRLEN is
> negotiated.
> 
> 
> [0]: http://lore.kernel.org/all/20251029030913.20423-1-xuanzhuo@linux.alibaba.com
> 



Acked-by: Michael S. Tsirkin <mst@redhat.com>

> 
> 
> 
> 
> 
> Xuan Zhuo (2):
>   virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
>   virtio-net: correct hdr_len handling for tunnel gso
> 
>  drivers/net/tun_vnet.h     |  2 +-
>  drivers/net/virtio_net.c   |  6 ++++-
>  include/linux/virtio_net.h | 53 +++++++++++++++++++++++++++++++++++---
>  3 files changed, 55 insertions(+), 6 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f

