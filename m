Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793938730;
	b=YoFjlEnT84mescH//P0x8N9VmNsoOboAAcAaWDd0fUv9McwHkHdg9F/Z4rF+CiO7y+eE
	 yekwRXBrFyfjlbhRpaxoWvw3fs/0dyAsDiddDvCBe99/JTdKgAKLLveV7I8Ryasm4w9pd
	 jrxL9Cg0Ydr6XmVVQ219BxH+epFFN6KJAkR0HZnFFVszn5r9QmFfpZVBFjuCV+POKQM4l
	 9YpyCmnUhO46vHVXAa8HCCMqsyx8b5/50fFTvAylV/UW0Puz1vAs8e4n334GZ4p4ag9Tk
	 ZTsyIhsna8dgICFAYNz4rksJbYsKiW3mB9OH6rI5IZqv6xuzWm1/ROEG5qajB50Tlnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793938730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qkRXBwd9VuNyjRdV31nMFJ+5eNrq3IUMvPVOYqoi14Q=;
	b=VpAcsS9qAbn0T43qG4H2XHsu2q9F2b3jOhbN3RR+NwS4M//K0oQUiJCfZxoNYFXiZNmw
	 K24ozZeDwvRjuozjn70x7Hx20ngsxIxLO4noci+FalKR1PpG0OOo6VEWsvGC0DxBzsO8j
	 WDjwAcQn3RBiUnbQn4Te7Qa3E909EY5ZNc63ztOtLvTCS7d5N7UlG/yNeAchmQU0pPtrs
	 nGmV+ME2WMWdvYnJU2zX/xMEGF1sjjgXAG7/+qfkp7kavBCuvqfRAF639ifeI/4T4r8R/
	 toPqPn4FnoTuNCEw7pWov5bcOsMpGxSqdA5Y1uGnPD46/0buPmsvSY9v/ObtKnnT9uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TZgYuzEG;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDB1606A326
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 04:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBDB1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TZgYuzEG
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5eaa5e03c47so1283301e0c.0
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 20:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793938729; x=1794543529; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qkRXBwd9VuNyjRdV31nMFJ+5eNrq3IUMvPVOYqoi14Q=;
        b=TZgYuzEG/ECzcsTUI+zU83Mn0kj4VC15XdOTK+FcrwcxnofEXSsYTJn9/JxAMMz4nR
         ixDHrWEG/VLAnXCPgp2DoIGPqBEM3oLqBE3Dvy5ihZLfdKGXrkIAZ02Hq9bmHv9HA9kv
         mIA/JX+nig9DI+vKHu2KfaTzqTfEd1GSeAkcHcU89NX3P1OLwr6m1S6yw+kIEMgp+b2B
         rd5FhR1UWlu939M8WlHFBjCadPsBWq/EGLnViRQ+LWB0kGLEeq/Nl83nnLYxGTugNJVf
         edERMg7DqSVHPOQKoc+RzlZlP1TTxYXjy7jbx0egPwtqjwsiHDAtItfc+8o6bURwghzj
         m57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793938729; x=1794543529;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qkRXBwd9VuNyjRdV31nMFJ+5eNrq3IUMvPVOYqoi14Q=;
        b=Ai/eyqhRL/J4raUeGymL/jnrW2hdWl6pLhCkfjzQ+mY8fkgZwfgBAxTnYHvhUpEWEn
         ASUkgKN7Q5HGD6vwgn8eNHnojmjzOdOhnp/4Zj032gVU8lgGBRK5H7G4Wp8HBWAY5eoE
         qSm04OGx86/yL+QOiAGRVc5QLC5ko00mw/4ewcGQd/+eZpfEk7ybXJYW9tH6LxQWUQ+/
         XCeN/ZIaIZp6XKuDqClQLpTt967tHdVVmAOKBMTlOXCYAOIkyTXI7VJ4GuXjqJEGJce7
         rjcRwx4YZ1sKrAxEVxw7q/86dG6Xr8TIG845m46LL9LsMIlY5ydsN02hgZk2DeRtceeq
         8EnA==
X-Forwarded-Encrypted: i=1; AKwUvBzeXcOfzaN4+xWdxnsdkiUg519t3EKNFHSo8JqpEs7gS2ZpSz63AfG0uRPCxm9wC5LtN34i3bP6QqZJb8LAIw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+xboPYmfijj57ikHaHzNX5PL3Rg5VoJMFjJKwvkIV0GJ5zDKMh
	lIQ5xxDBiTNIOt7sUGpeXYkHXwwpzHZ6zkgXO1ml4NKzzlcnjEzmWUIr
X-Gm-Gg: AYBFou1d0ACYWdPbKVL1PFn2m2WhFu4aQi+dIJ7ihkTOM3e5onHr+Pl8UH2/RE0GzH2
	vIS0qBRArwYvMm0zf0pLHaHP0D/mVHIoFsKcLGtDTtPOCNZLOybiU8+a+NNKod6XnpLc4s54LGG
	p0htElh1RfuEshz+iWXmEd2tmx5JD6XjN/nxpTQWsPDOThbAWVTHvVr8UJtItEYEyDFUjWwu3Dk
	B85tybaxJhiegML9qagjqyIYaS51WvnflkkjuBfs+1vv/uok5jT6NgDGqIZYjsT/H5FnoTllw18
	XvDINTpfFhTWXnp7OjQ9VZnbhtXC/hSbTCmPC1XhEn+itcpLaxvykDBPlL7U9EcS5CPSaB/ECuo
	2idp5LG8u8XqLnVO2Rd6J23VcryrgOPjflvOGBUaB7DOVtItQW2euybt5d+G11SIeGTEPi371J7
	dLjtuKplv4TM3fqtG0DODnhPGeuGqvlh9Z67XkDmJU0rwRzEERtpCEVE6PQHkvMuJE7OtU8aTdb
	PL6Nw1/EQor5N4Nti6Zqv1LaoK7dOkETyNclEs5jjOx6TE95o7cHJXB1uLgw7AClV3tY8Jm/T5x
	6AhpvJDCaguNWU8DLLl4iObSt1+TkVJEgTEuOO02Y+vJX+xDBb7ym4ZHm5XmZutkH6P08j63QxI
	5eykOEFJ8rr9zkNyQYyWAh1TewmUAVJ9ByNjkXsfmHBX2eL7QCMIbnX4rQOE18GOG0TRcr/vIgc
	rpwbZil2IzQ8BbZaMh
X-Received: by 2002:a05:6102:9d7:b0:7c3:874d:60bb with SMTP id ada2fe7eead31-7d2a14b652amr651881137.5.1793938728631;
        Thu, 05 Nov 2026 20:18:48 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d2a8b52ca9sm427837137.9.2026.11.05.20.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 20:18:48 -0800 (PST)
Date: Thu, 05 Nov 2026 23:18:47 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Hassan Sultan <hassansultan@google.com>, 
 virtualization@lists.linux.dev
Message-ID: <willemdebruijn.kernel.2494b56c7bdc2@gmail.com>
In-Reply-To: <20261105115715.1466924-3-edumazet@kernel.org>
References: <20261105115715.1466924-1-edumazet@kernel.org>
 <20261105115715.1466924-3-edumazet@kernel.org>
Subject: Re: [PATCH net v3 2/8] net: virtio: do not use dev->type to find the
 outer L3 header
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> virtio_net_l3_start() decides from skb->dev->type whether the frame
> starts with an Ethernet header. tun decides it from the IFF_TAP and
> IFF_TUN flags, and TUNSETLINK can set the type of a down tun device
> to any value, without changing the flags.
> 
> On an IFF_TAP device set to ARPHRD_NONE, the outer protocol checks
> look at the IP header at the network header (ETH_HLEN), and never read
> the Ethernet header. eth_type_trans() then sets skb->protocol from an
> unchecked h_proto, for instance ETH_P_NSH, and the packet can reach
> the skb_under_panic() addressed by the previous patch.
> 
> On an IFF_TUN device set to ARPHRD_ETHER, the checks validate an
> Ethernet header that tun then treats as the start of the L3 header.
> 
> Checking in tun that the device type matches the framing is not
> enough: the type is read again later, and a concurrent TUNSETLINK can
> change it in between, since tun_get_user() only drops packets of a
> down device after these checks.
> 
> Add a has_eth argument to virtio_net_hdr_tnl_to_skb(), passed down to
> virtio_net_l3_start(), so the device type is no longer used:
> 
> - virtio_net always receives Ethernet frames.
> - tun_get_user() passes whether the device is IFF_TAP.
> - tun_xdp_one() always calls eth_type_trans() on its frames.
> 
> Fixes: 288f30435132 ("tun: enable gso over UDP tunnel support.")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/netdev/sashiko-outbox-198573@kernel.org/
> Link: https://lore.kernel.org/netdev/179387332014.488856.9111956413610107951@kernel.org/
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Makes sense, and easier to review stand-alone.

But if having to respin, squash into 1/8?

Also, to avoid having to respin too often could (now that they're
public and archived) leave the self-tests for a later series.
