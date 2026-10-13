Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F6B4DEC26
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791889119; cv=none; b=DVffi98K23leK69Wg3xKSbBu1gTPlGABFMir0aCPmRpx28XdbEmCtIKOrOuha43pI/3EZcuvg/29xO2q/AyHllV5L6pXJU9uWM8orJcde/Vln7ar1T6F6PCIRdj0G3bfmJbE39N7UqVoUYQgFVkyqbd0jamuyLWvdTm4s4nEgb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791889119; c=relaxed/simple;
	bh=TaE9Ly6M6reX40WUzo4n5oZ5FLX4vQyvLdUI7s12ZkU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LtwGgt3PXIEJesvwhvmK/4OS28J+t50OpG0ro2qqUgZNpMj8pDRaOpz0XH8i4NVcgWeZUk6WhAF+uyC0V+t0H+ro8s4egLD1HwZ97U+KJsWsZc8F5tbRL97t0I6jWJb1uhL080anxdzrJL7j+wE2TEuh4D/gKYMcu9BLQXH+DHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PHjlXyf6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHjlXyf6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791889113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=YIXLaYbJVEJiIPKxdajUtKwRlZKZGxRdqRquRKPiCJk=;
	b=PHjlXyf6CDXfmkyArGvW6ZhzKtTlNaykgpCKM+gv6bF+GN44Yl2b6Ehng0NWYgZtEz+tIU
	8XNRiPOTPgltdSPs3EKG3gpi3CpMQqN1WUgtkMsdvqmHS3cU5Ti5us95n8ZYRLrELFssAE
	Q0OVwyLHF5Nxds/E8hurh5bcjqGbV5g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-XZji4fSuNDq4xk7BzzibYg-1; Tue, 13 Oct 2026 10:58:30 +0000
X-MC-Unique: XZji4fSuNDq4xk7BzzibYg-1
X-Mimecast-MFC-AGG-ID: XZji4fSuNDq4xk7BzzibYg_1791889109
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a170fa0879so22168085e9.3
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 03:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791889109; x=1792493909;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YIXLaYbJVEJiIPKxdajUtKwRlZKZGxRdqRquRKPiCJk=;
        b=WC1eEFqFh9U3XfRDWKM+0nMWRlWhXGcoF/CTB3pxktzndG6MXS05GTqBaYOTOQUHXh
         npiTVUf98KMpbeSSaw4qbEcQbIZHcVp2Ki1a6NOMn1N+w6ta3i741vhxupaYYYrYQYdZ
         G298GN1q0WRLOi7tucf3OKzU6+qXscheaXnhfr1Ig7NgbMYLuzv0Z8pvznTEQPHa9+eF
         OMAuhhlg4qpGiKt0Vi5YmJMJHj1qu05q3m45dS6PVI0K/BwnKDgEVWYBRAGNaIMS6xVR
         fvubD10WAeMEXeERwwO4+EkupRLkHd+7Qy7jcJ//oAuL2qEiLnOhjSR1LpmBnNgrsoEV
         qHUQ==
X-Forwarded-Encrypted: i=1; AKwUvByImV4ux4k3xyMkl5KcUOqhyI8XyY2LnRF7q72rK20EO6Y51L0VAViK3484/3JahZuNRlrn0K3XVKu2Pn5VFQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLOhhV0fQH5n+fiy/X+RMjytsGlwCqCzJno9HdKGRQqoT4nyUHW
	f2oFT5zXOXrtVPXJfhXrw4H5+7Tcs99MhtbKXin8xMW2pz7v1mno0D2tx4la6eI4iO3TwM+GTAE
	pwtEV+4NQLO0ov47I0Mu5ripG76wZ3hSkc55YFUXRHf0JksmwR8rh9JyfAuVcebOltuaU
X-Gm-Gg: AYBFou2uqBhWAhnD7C4Ky+qogBvgzz+67M8Xx/kLRjyozbHcdTRwEMbHj6xh2m9N/Ty
	dPINLVlubj75UEtSMEhdUVE4WSvPptUkTBt9OACwCVohpDNfz0prlf777fAl028Gdr5hT2bJM0O
	Kumdqa8A5cpZlnz7hrHv1Xm4DljN51w+w4S6F0ruJcYBakcSpRPFTMW4t4qpNw2RjztSfg8XX2B
	mUorg/jlutqacD97EpUMoDShpBBF4U80hQxOIeenyFxen6gbBeRJZBEs3B/sBUp0aQObFpir80P
	rM7Vu84Q+jATFT95QZ1CtEe3xaefnD8eoI9HyLvcTh/BIXFGK0rXtMRqoRTXOLlB/chZ9A==
X-Received: by 2002:a05:600c:3541:b0:4a0:2488:71cc with SMTP id 5b1f17b1804b1-4a18e4e9ee8mr222632555e9.32.1791889109037;
        Tue, 13 Oct 2026 03:58:29 -0700 (PDT)
X-Received: by 2002:a05:600c:3541:b0:4a0:2488:71cc with SMTP id 5b1f17b1804b1-4a18e4e9ee8mr222632035e9.32.1791889108394;
        Tue, 13 Oct 2026 03:58:28 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc6b82sm4518508f8f.51.2026.10.13.03.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:58:27 -0700 (PDT)
Date: Tue, 13 Oct 2026 06:58:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>
Subject: [PATCH net-next 0/4] more virtio-net csum hardening
Message-ID: <cover.1791887415.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y41M1hZNFOx74BcmsJXdPkUwB7pzOYd7o10iU3v02kY_1791889109
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Allowing untrusted hardware to specify csum start/offset for
CHECKSUM_PARTIAL was not a good idea, because, if it edits the packet
outside the actual checksum, and depending on the setup, the networking
stack could be looking at the packet both before and after the edit, and
seeing different results.

Previously, commit 6785011f8b16 ("ipv4: validate checksum_start before
completing checksum") validated all known instances where this
causes the most grief, but the real fix is to make sure
that either only actual checksum fields are ever edited,
or the checksum is completed before the net stack looks at it,
so it is always consistent.

This basically does this: checksum at ingress, except in a narrow list
of specified known good cases.

Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")

Michael S. Tsirkin (4):
  net: add ip4_parse()
  net: use ip4_parse() in receive validation
  net: resolve uncommon partial checksums at ingress
  net: account for ingress-resolved virtio net hdr state

 drivers/net/tap.c                   |   4 +-
 drivers/net/tun.c                   |  44 +++++++-
 drivers/net/virtio_net.c            |   2 +-
 include/linux/ip.h                  |  24 +++++
 include/linux/virtio_net.h          | 161 ++++++++++++++++++++++++----
 net/bridge/br_netfilter_hooks.c     |  15 +--
 net/ipv4/ip_input.c                 |  13 +--
 net/ipv4/netfilter/nf_reject_ipv4.c |  13 +--
 net/packet/af_packet.c              |   4 +-
 9 files changed, 228 insertions(+), 52 deletions(-)

-- 
MST

