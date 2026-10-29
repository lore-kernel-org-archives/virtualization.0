Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793258534;
	b=CDancX37uIVx/3XVtVxwZ1kTr8LnlVUc56ZXMp7BL91hgCNoYa4FNtouVQinqFKMqh8J
	 1VoKfBJxTysTW4eb7J2KLCdo8LOAc0s8bhdfHqybr/yZkWOROeLBo5HkK1E8qx6ex9OaE
	 V0ZsXL1z/6MCpwLWdmGrWoe6gMD8s4jPP6WGMbx4i5pAcei9J0AcpNECTYcUA6LKSGH6K
	 zBPvq5ATGB3Lunwdzc52On8xvqnqicpTOGCNFdnys1CuLdOo6GPZHczXZoohmQXG6bTvm
	 V1iKBRS2O1wWfl2fJ0pUHe/Pr3ht0xcnfBZ8kD/J7JsBE5FcMVQm4e3UeEsLaTuXL1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793258534;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=TsAQS4rA4H1iNqLsq84hKblFTfrWhP+kWPfdX+CCGew=;
	b=J+fNAtkZOmUGGmt/mZOFjS/+PTzDl5lwS4/4d90yn2ZJDqgPg/h98vT4n4G7LSHESmIH
	 /hzohoQ9nGVOlVPnYDVJI/7gaxppMpHgCM7kZT9n/olryuFflR0tspEZWTA795dYHRCrr
	 lJkc8yXNh5m8HG3j2YsyPYoi7FiVxJ6WUKthjYuTlK9v82QujoDsMsPXDaCjdbW3Y/jxv
	 +nKbEFNH24c1+fQZq8EMq6dRUTWXLOnMCLe10JxhP5kv48uQvEnA7rbwTaiJ31qwPKmPf
	 jUAN6RCBEMREwUvDbZxiUAKH/FAzBf/28tdwNP3ZPFTkluRHHChbiZ6+1W70msF7Wng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h3nLwMmr;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67445606A31C
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 07:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67445606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h3nLwMmr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793258532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TsAQS4rA4H1iNqLsq84hKblFTfrWhP+kWPfdX+CCGew=;
	b=h3nLwMmrpaKBunfv6J9qj8Mygc+YphlZjqN7N7KR8jR0YGYdb3HGDiZdNYh9KOJ/4qmddq
	RRNQQyJR+L9z3P45u+ls8clcYTthLAPRBQzbL+S0FtIEyCj7Zyo93OrTURPponA7VvqLks
	C/t6yGNVc4bqVyjv10uFS1YdSs5O7l4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-Ks2d3HkRP2OG0sBlMlNFVA-1; Thu, 29 Oct 2026 03:22:10 -0400
X-MC-Unique: Ks2d3HkRP2OG0sBlMlNFVA-1
X-Mimecast-MFC-AGG-ID: Ks2d3HkRP2OG0sBlMlNFVA_1793258530
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e4d1e29f3so1497503f8f.3
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 00:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793258529; x=1793863329;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TsAQS4rA4H1iNqLsq84hKblFTfrWhP+kWPfdX+CCGew=;
        b=rkSvLsTK4Uk+M+0KxFzhTCzpzcNrS6rsT7CXBaKGxOu3U/3oSUNyqzn65Per3pUb+m
         nn9HT1IOyJsMctjdzprBTzXeVNjv9tzzENl7BT1jdw4d2lIfHKBj0cuwvx9CFMVTjG4m
         dO9XCbyEnKpFWM+8OGhXeqAot0JF9Azyoh2J/wpc63eqy82fbaQ717upBj7bbMyBAx1Y
         CghEcFcuPI6XkSzVlFG+UYeIZBX4IPM+UVuC0ImWQZgvjL6tQRnvGmWt5yIqCWInTS1e
         gOXIat+HisbWUyMXuFN7lU5VF7Vrmv29WXIEP5YSIc8JWw3K+VZV5NRmXPL6c0nqAYin
         zPkA==
X-Forwarded-Encrypted: i=1; AKwUvBzB31kOKnem/k9EE1Ou3VNI1TgDjIa2h2R0kt5d8s1aouN4XGPCE2jjNLdIy9G9cc7sWu9rDB+ywKlK9d12dg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLY1750CHcztHU6lA9nXpm2g0lujjcVk703lVQMvKpjTGkMHfT9
	EB/5UXWKAIncVCmgz2BuWGKxFX9vA4bm69R7APnhY2uMrv0ZLbsD9B2nzDqYJpeP7fo7fTOaQdY
	Pp4PjPIc76GlAyxqXpdVCE8BwN9QSTv4Hmd8IeLnhbaIBwLkObt4ws1fyrF3ANBxEQG/I
X-Gm-Gg: AYBFou2f8MVGDDvANup3vb5ItjhnyN3ArMffY474WbLqa4wqZSLFseKSapHazbVhmcW
	kgHVKCW/lwGcvDIreO1cq4wmpwrWDkYEkFX/qjX9kPNvDLlF2k+f4/VDEdqxhhPVpWwziUJe47q
	lKAv4zkYotmeYTbWHcStPKvGNJnTMJp+p9zlICEe09VpHX6UHtuXjv5KkXFrGKcCbcCaeeXr2qB
	mpxXVgVEWdJnXCh5BaWTVyjWCxsNZvf14EoWlH3NmENiIxG7lM6YXJ9S9lXrla9gJeu0IgaEAPd
	amxBJ3h50ySR8Web1JAokU0MwF9u+Pd1j96MdtgGRu5nKfoGZS2k7xMqDeffcJyJ1EZcLVvldKN
	SsFhGUYu+MrlAyRf8PCEi7/RJ2VVQx2Sqmb+DnZZaQqI=
X-Received: by 2002:a05:600c:811b:b0:4a7:462c:6b9e with SMTP id 5b1f17b1804b1-4a967d96eebmr99427695e9.32.1793258529402;
        Thu, 29 Oct 2026 00:22:09 -0700 (PDT)
X-Received: by 2002:a05:600c:811b:b0:4a7:462c:6b9e with SMTP id 5b1f17b1804b1-4a967d96eebmr99427315e9.32.1793258528864;
        Thu, 29 Oct 2026 00:22:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1501:b100:9ea2:fd21:b361:8dab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ece5e4asm31993080f8f.59.2026.10.29.00.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 00:22:06 -0700 (PDT)
Date: Thu, 29 Oct 2026 03:22:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Chris Arges <carges@cloudflare.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH net v6 0/5] more virtio-net csum hardening
Message-ID: <20261029030932-mutt-send-email-mst@kernel.org>
References: <cover.1792768096.git.mst@redhat.com>
 <20261025094449-mutt-send-email-mst@kernel.org>
 <20261028154315.4b9f3077@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261028154315.4b9f3077@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: olIYaovLh9pbw-0hwsgSQDtxAze0vrNfEa4o75R5wLU_1793258530
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 28, 2026 at 03:43:15PM -0700, Jakub Kicinski wrote:
> On Sun, 25 Oct 2026 09:50:24 -0400 Michael S. Tsirkin wrote:
> > > Apologies for reposting so frequently, I know netdev bot will be unhappy
> > > with that.  But Paulos's report made a lot of publicity, there is a lot
> > > of people looking into this, so I feel there's value in defending
> > > against all this class of issues sooner rather than later.
> > > 
> > > The issues were mostly found by code inspection, but all reproduced by
> > > me in a VM.  
> > 
> > Ok, I looked at netdev bot review, and there's another issue.
> > 
> > If a tunnel inner packet happens to have a valid header at
> > inner_nh_offset, it will pass all checks, but the transport header can
> > in fact overlap e.g. the real TCP header and checksum will overwrite
> > that.
> 
> Sorry for boring process stuff but FWIW the last patch also does not
> apply?
> -- 
> pw-bot: cr

I guess I need to rebase. Still don't have an idea what to do though.

-- 
MST

