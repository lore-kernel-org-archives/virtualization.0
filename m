Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436911;
	b=wXrKmy7OMGz1FQnaeqsAT5QMH+GqTR/6tDhwd3/6zidY+0bahB38nfhM0ZDS/3iprcJZ
	 k14sgWiL6hgqNhhzIsgCMM2i6H5dlYrCIn58cjl2YqgW6mCHuSCrXlUddIOCn1LAV5C45
	 iFKcN+KIcZWiBSD1im0sk6YS//1mAB6TwDMCW+hqm2Fg5LqSbu4e4wn6FzG0/eRrPy3FU
	 cKL6BakiLlT/XgFJwwhlUGzsgJ8vRHnNw4f1Ngc1ij9r47x3VPpOvIU2xvP1WhIWPtDhp
	 B+ue85Jj0JuCAgbBQu5fvEiGGHxLjKeBJxnVGPwnSBhdfnwyCqtEt1ab2Kl8vghl4Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436911;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=xIIn3V9P0kvomPcqYmph69rmh1CiZzPmlRG5882C640=;
	b=AQA8jFacD9dYyyOExQZgt3ExIX6+EfbkNDy+61x06EKl/4A2kcUsj0Kxrgcj35lXFzUS
	 xexvDbqrVzP5gWYYnRTvJZWqlw8LIK+B3IS+OolM8YykT/lgalCw2K899TacPnkWaV0Jt
	 qkV4V7JyyaOnftM1Bgf1oZYoooayNfVm063JHB0EBUBAreobJtXeR3+we5dQoiFuGtdNj
	 mFOCLK/QOqe285CFBL5YIL0o59x7BjCWMbGyEMBxdo55lrnDsiIHfydEnSN1/jRViWgpi
	 ln7dfpnzNkS1ZtDPj1oAt1zKpwQC2nVyBkq/kVo6z8c8JW4MRY6XJUHSd08Ak6PyyVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="St6nQ/0F";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD071606A88B;
	Wed, 11 Nov 2026 22:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=St6nQ/0F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42131F00A05;
	Wed, 11 Nov 2026 22:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794436911;
	bh=xIIn3V9P0kvomPcqYmph69rmh1CiZzPmlRG5882C640=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=St6nQ/0Fpg8GjtI3V195lQd0hmTrcEiQt9GelJFtAshaHLqFftxmdx4tyJ9Hs4WVc
	 qxRc7l+cfudfne7Xb4GUV0FNcohNSZtRlcQz43HN4zVTt7A11rstEkF2zThclZyURf
	 vCIWcnm4PXf+fAHOoxtz+tPHcoXDMdyaAUDjA3FIPCw+Cy9ZG2abWOBv40b+wFBgh+
	 90phhu2QPtJinrSIPq4lMUqzgrfxhjb7gjItn6+YxlZCb7SLxJ91sxI2+Bb2zLBvN3
	 Y2rvf+jGI2rvZTlyPm/S1Haku/LKz2CE4/2mEjsZZV458von1OtksD+XD6SNNMs4rV
	 DH55pX9XMpktg==
Subject:
 Re: [PATCH net v6 2/3] tun: clear stale skb->protocol of NAPI frags skbs
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, willemb@google.com, horms@kernel.org, mst@redhat.com,
 jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 hassansultan@google.com, virtualization@lists.linux.dev
Date: Wed, 11 Nov 2026 22:41:50 +0000
Message-ID: <179443691047.2199510.8260837937494054513@kernel.org>
In-Reply-To: <20261110213628.3476051-3-edumazet@kernel.org>
References: <20261110213628.3476051-3-edumazet@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message understates what the bug does in the tree as
  it stands.

--

tun: clear stale skb->protocol of NAPI frags skbs

This commit clears skb->protocol in tun_napi_alloc_frags(). After a
GRO_MERGED_FREE merge, the skb recycled by napi_reuse_skb() still holds
the previous frame's ethertype. The virtio header checks in tun_get_user()
run before eth_type_trans(), so without this change they see that stale
value.

Closes: https://lore.kernel.org/netdev/179386753589.488856.11455181721004759454@kernel.org/

> tun_get_user() calls tun_vnet_hdr_tnl_to_skb() before eth_type_trans(),
> so the virtio header checks see the protocol of the previous frame:
> GSO packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are dissected with the
> wrong protocol. A following change checks the outer protocol of UDP
> tunnel GSO packets, which would then reject a valid frame when the two
> ethertypes differ.

[Severity: Low]
This isn't a bug, but could the commit message say more about the impact
in the current tree? As written, the visible failure seems to depend on
the follow-up change. The stale protocol looks like it already causes
problems without that change.

In __virtio_net_hdr_to_skb(), the GSO branch without NEEDS_CSUM only
parses the real ethertype when skb->protocol is zero:

include/linux/virtio_net.h:__virtio_net_hdr_to_skb() {
    ...
	} else if (gso_type) {
		...
		if (!skb->protocol) {
			skb->protocol = dev_parse_header_protocol(skb);
			if (!skb->protocol)
				virtio_net_hdr_set_proto(skb, hdr);
		}
retry:
		if (!skb_flow_dissect_flow_keys_basic(NULL, skb, &keys,
    ...
}

When napi_frags_skb() has left a non-zero value from the previous frame,
the dissector starts at the network offset and uses the previous frame's
ethertype.

After that, the only check is virtio_net_hdr_match_proto() on the
dissected n_proto. Nothing compares it with the frame's real ethertype.

Two outcomes seem possible today:

  - A valid frame is rejected with -EINVAL. For example, a TCPV4 GSO
    frame arrives after an IPv6 frame was merged. The IPv4 header is then
    parsed as IPv6, and either ip_proto or n_proto fails to match.

  - A GSO frame whose real ethertype does not match its GSO type is
    accepted, because the stale ethertype makes the payload parse as the
    expected protocol. eth_type_trans() then sets an skb->protocol that
    disagrees with gso_type.

Could these effects be mentioned in the message? That would show stable
backporters that the fix matters on its own, not only once the follow-up
change lands.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110213628.3476051-1-edumazet%40kernel.org
