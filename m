Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806371;
	b=M9W3qexqHOz2s1kGgtVRahzkISIvAEZo6insIGztdd8XEf707vQuOqf2HE9UfJNF6DRj
	 L8Eg9vImqi9EuySar63hjhGPM5py6A0QOHrLU3vNJ0PA3U7UVkwqMS7X1721CVfy/WIrj
	 w9ByM3DHvcsXUKJJdZSwHxahGGRIVxDmLwHkYK2vgVfk0jM0NQ/2RlbDNVae9qSz85RS5
	 2tCt18qcVjPjIAL5cI2OgoKxkcXxjgu67BjXU4qa5Wg/YP3uh4qrtLbsSvWcLxRLJGVON
	 PtqZPN2Zhc5eylr/liAwAj9eFdtT4flPiMIJS6EBnc5TKPKIG5SGsmSzxw5nvxE5KwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806371;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VSl8UTHuzcGlusp9eWKHTaKhrhlwdDdWaRoNG7GwWpE=;
	b=sQ8g5+b0EhtR9onIfvYOyWOKTOdl02iemaDpc+w0ozzYUvyLeZrKgElVFH6mDhBOm1Fc
	 VYwKdR2nEPOIQlVV9Dv1EW7oxwZxqPMWI7RHr5ln1qbiVQ8pslC/oahrtJTpi9xqwsEcb
	 0u35kDBsOXempECweWRQjqrQcYfSB31NTsW2jT/Qbv6KgnNK9IHQV4sUQ2qY/36lL7vTE
	 k8DD1rEek5qiz3aLAsgFaGEAgerY9wzmfhfOlBhIoy3tTkH0LLIPtJEHnmSnRGjR4Zlqa
	 3Zfs18bL3Iqkrz8ghjBYMdH0kP7lppd6VZLS9AAX901wuooZysey6g9c7orJTn0AfRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rnR0bNPS;
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F35606A31B
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 15:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21F35606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rnR0bNPS
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5eadf48fb2dso299184e0c.1
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 07:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793806370; x=1794411170; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VSl8UTHuzcGlusp9eWKHTaKhrhlwdDdWaRoNG7GwWpE=;
        b=rnR0bNPSeGs8tDqZgg4NpfiHavXB8jA9+4D1z+oUcuhqv4HIQcU6+hZdgpwE9RCB4e
         Sies0/XoQ3Tj29qrEc2QHIWdnJgnNuyJFElIhU5qXR7uRk1B7vpHQs4jyW1lhKGA9qmw
         mUpa41w3gl4jNJwOJYRGqE/Mc0yYOcz0xeqQHSZY9Vvqup4PiQXZ/xeUNsuAmEc0bEKH
         bkUiQJsTtfDFAy8h/O6/zMM5KWQ6ECHMbAZ8IcImL6xkqzkRUrDyEi667LldVvw/ITuZ
         iPWd1F/Ivjn1YhmEG2g6EWkvE34fVg85gDrqvlz6hSLbj7NTbRnfKYgenYmDjYtTwfRK
         CUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793806370; x=1794411170;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VSl8UTHuzcGlusp9eWKHTaKhrhlwdDdWaRoNG7GwWpE=;
        b=lnrzNwqZL222Pt9rPvxiKJddUNv2rWvlykicdLilhZKvAFOmZtKjCFedlkkVEx/cxX
         Hk6zRV1bWnAfmYlh7BVrYZNvlh1MyYQhxjaFwt9r1yQfxUpyDPCiKzserO+JbKbG8Kii
         Vep8uhjy+EOk8h7lLes7RsK5xRXsCDgW3x/HzAsqBjdt2UEp8JPd8U+eGw7A0bGaFTGi
         oxOdk4kAdpowyqGuz9HmthKZkCFdvJrl6rOq8N2RYS5K50nXUYkpNTTyX7Hbpy5NqWKm
         giBt+ZkdbrU2jPUk9VmzB2duEjRy9Twncdkco/RiQlIbdaIh2tPd0CRPx1oKNsmm2jMI
         Ik2A==
X-Forwarded-Encrypted: i=1; AKwUvBztO+Mgt0iq/z+jXJGUQAzBKOIYs/D3IurD67e1ds79BRsKXfRUA3RCAylUIQ71cu0U7vHQxeYmDMJVNsH9ug==@lists.linux.dev
X-Gm-Message-State: APuU4Z+Dc6aqzvgOSFJ7L11EGMBXcUIm5TbtvdEx0QILU9o8YJsouobL
	HygqjbqYzahtMinzUA2hlV8yc6DyGSgmVXhw752/085t8BxTToStGCi/
X-Gm-Gg: AYBFou15D1cQg+YDN2wMiWROpIz/rhlXqK5B21vhLqLTrhKnddIGgm84BwvtamLygPH
	m4Z/yUOQtKVSF84EI4tWEVTwD9x/nMVxeyFk6UbmDRsYUIlhciyrG/icvs2fUxioklsVsWK57it
	/oR5p5y0tG+K5SSq9ZQmQ8GvkXTe+hDZCP35eC7ShjaxTNOVovfMeA08rYf1zJDx5yBC6wtdrwo
	2U4ZhVPCqzTGd+mEE26JcKcIqns+qaBQ8WcKw9BCIn/KZsMU8FEzpTNO/Uhn2YQW/bm23tEQbX3
	7hgcgyZ75pD4ibRgT4soh9mtQzJJrS/zRpQRZl4TjX+EnBcutAEc+Kw9SiGucQyL9+xBBKz226V
	VDamUdFc6IAZW4XXBPJr4ov1jg5Z6S3d/Jr/abXLKNR75VQ094WQi518RdXaMQfq6VEs3mNXmB3
	i46kAJIguyWSS+XNWyS5zVggQdNaVaDQuo0rTGCMGQWk4dQaSDThjIFROfVzCTn0m7AFjiG2Vu7
	FoywjnAJSIXrKDGVfmv/2PyXNB2UuR4t4gr+0wIB3+hQ3OPwH2H/217ZdJY8BkiWKXexvMAPT3p
	GSpu0+Hbv8d5WKqlo499ohN/7eBcvc/BjOGhwW5PBOwv1tep3I/50BkQ1wM6xN3wq4Ua8GHP94p
	Sm94YR4HmLHvGhuWqAK1FOAM+Ol0VDy8vgyjHRHMmrtQc3Pdmu54aXYUha8qtEgnFmSOLgsQ=
X-Received: by 2002:a05:6122:3a14:b0:5ea:e324:7c19 with SMTP id 71dfb90a1353d-5ec68528589mr6692053e0c.3.1793806369972;
        Wed, 04 Nov 2026 07:32:49 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca89b81b3sm1906332e0c.2.2026.11.04.07.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:32:48 -0800 (PST)
Date: Wed, 04 Nov 2026 10:32:47 -0500
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
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Hassan Sultan <hassansultan@google.com>, 
 virtualization@lists.linux.dev
Message-ID: <willemdebruijn.kernel.332f86b4be346@gmail.com>
In-Reply-To: <20261104050131.629967-2-edumazet@kernel.org>
References: <20261104050131.629967-1-edumazet@kernel.org>
 <20261104050131.629967-2-edumazet@kernel.org>
Subject: Re: [PATCH net v2 1/3] net: virtio: validate outer protocol of UDP
 tunnel GSO packets
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
> virtio_net_hdr_tnl_to_skb() trusts the virtio header to describe a
> UDP tunnel over IPv4 or IPv6, but never checks that the frame actually
> carries such outer headers. Because VIRTIO_NET_HDR_F_NEEDS_CSUM is
> mandatory for tunnel GSO, __virtio_net_hdr_to_skb() skips the flow
> dissector, so virtio_net_hdr_match_proto() is never applied either.
> 
> A guest (or a tap writer) can then inject a frame with an arbitrary
> outer ethertype, for example ETH_P_NSH, with SKB_GSO_UDP_TUNNEL set.
> The GSO stack then runs nsh_gso_segment() on top of the UDP tunnel
> segmentation, which assumes a different header layout. The result is
> segments with skb->data before skb->head, and a host crash in
> skb_under_panic() as soon as a later layer pushes a header:
> 
>   skbuff: skb_under_panic: ... put:4 ... dev:gretap1
>   kernel BUG at net/core/skbuff.c:215!
>    skb_push
>    __gre_xmit
>    gre_tap_xmit
>    ...
>    tun_get_user
> 
> Validate the outer headers with the parsing helpers from Michael's
> series "net: resolve uncommon partial checksums at ingress":
> 
> - locate the L3 header from the device type: Ethernet with optional
>   VLAN tags, or the network header set by the caller. skb->protocol is
>   not trusted when it disagrees with the frame.
> - require the outer L3 protocol to match the declared tunnel type.
> - require the outer UDP header exactly at outer_th_offset, after IPv4
>   options or IPv6 extension headers, and reject fragments.
> 
> Unlike the original helpers, ipv6_find_hdr() stops at an AH header,
> as Willem suggested in the review of that series.
> 
> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> Reported-by: Hassan Sultan <hassansultan@google.com>
> Suggested-by: Willem de Bruijn <willemb@google.com>
> Link: https://lore.kernel.org/netdev/93d0e37c99711bebdf60c120af03010455c2f2e2.1793276116.git.mst@redhat.com/
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Co-developed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks Eric!


My bot points out a preexisting issue with this udp tunnel feature.
_Not_ reason for changing this patch.

virtio_net_hdr_tnl_to_skb already does not support IFF_TUN, as it has

    outer_l3min = ETH_HLEN + virtio_l3min(outer_isv6);

So the only reachable path with IFF_TUN is L3 with IPV4_OPT_LEN 16
(or greater) as indeed test patch 3/3 introduces.
