Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D8C4BD373
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 11:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791889544; cv=none; b=PuQHcqEEC750fsdoqEvLFVLQ0X6lM6RuI7sIN8ZUwdrzj8VSmBHFcLAQyqdVsua2mTuVz9Caz82ZAQdydgDH5a4h+ThZsMVVFde/2EoQygzhyxeyXZVPOssBxV3v8j9MiyoMjr2ApHHGKc9RSHhoNzwdgyVjzZWBLRttpFMRnS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791889544; c=relaxed/simple;
	bh=KCvmW2gkawrOwrsfGgGaOaal5YLOj9U1cr31ee+/jNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pfv9kzbRdVwXdyK6xnJbWkKqvO4iv5O6SK94AcpGmy9bXqL6klWZnPEAVEHxiceOmn+gvaMEMgGwhdURbvWKnFGzjG0OM9CZlUeIHeasMPjVCfixZj3iKLuVB/NOZbcDOIaPpAIujUq/lHKal3RCDZKju2hpaicuMkMdgDHKfYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BBwQLjTU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BBwQLjTU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791889542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1fqSmGGq4xZz7TtpMoBw/I0gc3DOkgjRVuZqWTSTZfw=;
	b=BBwQLjTUg1ePmAWF7wsp4O5a8v37/36g4F80lp3ChkT0FuhV2XKfbSYbtBuUTK6Id6p+NT
	sniL8p2LyjvTvzppta0B1gmZPtwMSZ9/6dbX6K6jsrCd/Va5PlIpyB6iSOSUiL2TT2mBk8
	0HcVXf3onn75O9Jg3mBkbTTeq4D+/Tw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-DVF35B1-PZOyLqtF8di0oA-1; Tue, 13 Oct 2026 11:05:41 +0000
X-MC-Unique: DVF35B1-PZOyLqtF8di0oA-1
X-Mimecast-MFC-AGG-ID: DVF35B1-PZOyLqtF8di0oA_1791889540
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a028616bebso19575145e9.1
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 04:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791889540; x=1792494340;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1fqSmGGq4xZz7TtpMoBw/I0gc3DOkgjRVuZqWTSTZfw=;
        b=k34WwXTr1y/ENWGWlT7ScJ62hJndy/oVXneSSlQhiZPuKgfENYwPpwtQ4MbGWRVEu/
         T4ZPvqaRpI+QFnwifjWShECb+LA+NU/phVV2WqGemHxTQ/j3VQEytmvdgpSeYNPBGl7A
         +LWK317oB1TTWRXIZnWLup8ecG+UmEHkLr9qcXL1y24JCe1SDp+gpAHXEdlBBff5+1A5
         x/b+xfwKWmt6Oem7J3aNFlwJbKEXBK7geXrJXXnHY/NpwfpHPzGvtF0eIqCip41swzrV
         01i82luTqJ6srtpdSaOl6LelGPm317mPhOzPK/x2jUnAgll/vSc4tR1PAzPFD7TasdSB
         upDA==
X-Forwarded-Encrypted: i=1; AKwUvBw1y9CWjI+LXkTUYWpQc2MFqBi0fwSEceNuGuE3ZmvgXiczju/Y0gF6hAXdv7JxE9wp436bikMDNxzgrsWZlA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKnbIDfCXcnriZmy8mVSUyX0Hc+tzehmCQGhFDSNOT40L6+tIrq
	3dSWLSp6TEuWti285WgwNc6EOGYZ1B6YTSRJTONwHax09Cu0rp+K+WRo5QdpITpn4BcGuEid2YH
	vjrkHJVxzba64/3O0pV3fUIULop5iaUS2fRDZlUvPoEa9CYvwXklPlRkRVQi8Hm/OSFHU
X-Gm-Gg: AYBFou1g7Rarto9FBxV5YXMma8+NpU+WQy4JpM1d7N4BD8jf5kFfP3PGF2n6c2vb1L0
	G+CIgdne9IgYCzzEO+gvxZQ7VtO1I7ou3T72CLXhbmskKzW5w5vaNJI2kzLQyevapGvHK7RQjpB
	8TZrn+wWoRx28RmUiIiWF4jzOZuZTEh3IAIEktpqF7Jcgq4Q0mRQq6ftqaCJun1RyP416jtjp80
	57a0gaQE64krE8R2HiYsaPppYjGdqRPFMM2bOYlN1symkfZc8TrW7GZ5e9vSgdQbrYbv/bbUWSr
	4lPCpcJ6puXtHyLTy8Z1yYsW0JAjixdEYjMOzZiCnKuLyj4/DhiDBPbVPQm3L7PbpvA5Rw==
X-Received: by 2002:a05:600c:8518:b0:49f:cbf3:551c with SMTP id 5b1f17b1804b1-4a18e4a8ca6mr220181015e9.12.1791889539525;
        Tue, 13 Oct 2026 04:05:39 -0700 (PDT)
X-Received: by 2002:a05:600c:8518:b0:49f:cbf3:551c with SMTP id 5b1f17b1804b1-4a18e4a8ca6mr220180275e9.12.1791889538853;
        Tue, 13 Oct 2026 04:05:38 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18e48db03sm510740965e9.3.2026.10.13.04.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 04:05:37 -0700 (PDT)
Date: Tue, 13 Oct 2026 07:05:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Paulos Yibelo <habte.yibelo@gmail.com>,
	Chris Arges <carges@cloudflare.com>
Subject: Re: [PATCH net-next 0/4] more virtio-net csum hardening
Message-ID: <20261013070259-mutt-send-email-mst@kernel.org>
References: <cover.1791887415.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1791887415.git.mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qntqnQQwKydTCYDu6ZWoMtffusbALnP_AjnfyRnrGTU_1791889540
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 13, 2026 at 06:58:28AM -0400, Michael S. Tsirkin wrote:
> Allowing untrusted hardware to specify csum start/offset for
> CHECKSUM_PARTIAL was not a good idea, because, if it edits the packet
> outside the actual checksum, and depending on the setup, the networking
> stack could be looking at the packet both before and after the edit, and
> seeing different results.
> 
> Previously, commit 6785011f8b16 ("ipv4: validate checksum_start before
> completing checksum") validated all known instances where this
> causes the most grief, but the real fix is to make sure
> that either only actual checksum fields are ever edited,
> or the checksum is completed before the net stack looks at it,
> so it is always consistent.
> 
> This basically does this: checksum at ingress, except in a narrow list
> of specified known good cases.
> 
> Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")


I forgot.

Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
Reported-by: Chris Arges <carges@cloudflare.com>


> Michael S. Tsirkin (4):
>   net: add ip4_parse()
>   net: use ip4_parse() in receive validation
>   net: resolve uncommon partial checksums at ingress
>   net: account for ingress-resolved virtio net hdr state
> 
>  drivers/net/tap.c                   |   4 +-
>  drivers/net/tun.c                   |  44 +++++++-
>  drivers/net/virtio_net.c            |   2 +-
>  include/linux/ip.h                  |  24 +++++
>  include/linux/virtio_net.h          | 161 ++++++++++++++++++++++++----
>  net/bridge/br_netfilter_hooks.c     |  15 +--
>  net/ipv4/ip_input.c                 |  13 +--
>  net/ipv4/netfilter/nf_reject_ipv4.c |  13 +--
>  net/packet/af_packet.c              |   4 +-
>  9 files changed, 228 insertions(+), 52 deletions(-)
> 
> -- 
> MST
> 

