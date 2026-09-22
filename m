Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902613B2FC7
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 03:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790046853; cv=none; b=OwuxfWtFs1Kh6uqcQyAH7jfjUUkEK7evh/IXVd4qcAXUYSFpw1KHQAf1PFBMy69jOI40+tD9pZOjF0z0bTVPDEGHf3+//Z7c/0oi8vO0SXmIFzh1pF4UQEXIpETTaMz9HZwIyZcpfuk8I4xSr5zVgx8A0cMY6/o9DegPNucbB2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790046853; c=relaxed/simple;
	bh=efDg/QmGwkd8r5ax5yeRqFcgaZDkFqxrQqjbfSaOFsc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m8RnkQdpl+AHzbbt90k9wzUMu1iagw3pgIF5+nJqsLBww1W/8vXFJZJEivjjY4GaHH9M7PP1QNXoAJ7JLENGQKP/dFYMTJNki+R1cJRADqFJRjHfnNLbk480YHH57WZUuiSKAp4+bbb6pnnn4JSwPpc/uevLMVq+RpC2T4oWokg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gH+NB43c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gH+NB43c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140B91F00893;
	Tue, 22 Sep 2026 03:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790046852;
	bh=efDg/QmGwkd8r5ax5yeRqFcgaZDkFqxrQqjbfSaOFsc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gH+NB43cSOfVW0SKrKI+6Zk+0JXRncnpyTTbUXPKPI1eu2cK9FQwOAC+JNrePff33
	 EfXn9TKFZH2naYQkBq3+55Q1Nc4gPxKO7/q946Jwe33ovywICpeZJymNN36L4SEfGU
	 Eo/BAb+PLt5QAceO2hDVcvyCmqdmreHGyMzS1Tk/REXyHRFcr9/LOK12+hwWPGduhJ
	 yIxe8Wz2OghGj8leTGFv9oOHT5k6NX4bGl6wqqxselT3bZuKW1naMmP+SSXB/+v+yf
	 gkG+vqPoNqRxZiM012Ni7a8mlDA8HFpemLS467oRghYjwEavg2cwf/nEHN5SGwdHWw
	 m5zMbkjTj+u4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v6 1/2] net: validate virtio checksum start after
 network header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paulos Yibelo" <habte.yibelo@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260922030310.8684-2-habte.yibelo@gmail.com>
References: <20260922030310.8684-1-habte.yibelo@gmail.com>
 <20260922030310.8684-2-habte.yibelo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 03:14:11 +0000
Message-Id: <20260922031412.140B91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> __virtio_net_hdr_to_skb() checks a minimum network-header length for
> CHECKSUM_PARTIAL packets. Its checksum start is relative to skb->data,
> but some callers have not established skb->network_header when they
> convert the virtio header.
>=20
> Pass the data-relative L3 origin explicitly. Ethernet receive paths
> parse the frame and nested VLAN headers without changing skb state.
> AF_PACKET uses the frame's actual L3 origin even when the socket
> protocol is ETH_P_IP and the raw frame carries VLAN tags. Non-Ethernet
> AF_PACKET devices retain their established skb network offset.
>=20
> Also pass the actual L3 protocol so IPv6 packets use the 40-byte base
> header minimum even without TCPv6 GSO. IFF_TUN obtains that protocol
> from the packet before skb->protocol is set. Name the Ethernet parser
> accordingly, use the same origin for tunnel validation, and propagate
> conversion failures in UML.
>=20
> The bound remains a minimum; fragmentation paths separately validate
> the parsed IPv4 or IPv6 header length before completing a checksum.
>=20
> Fixes: 49d14b54a527 ("net: test for not too small csum_start in virtio_ne=
t_hdr_to_skb()")
> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tun=
neling.")
> Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> Link: https://lore.kernel.org/netdev/20260920004733.6473-2-habte.yibelo@g=
mail.com/
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Paulos Yibelo <habte.yibelo@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922030310.8684=
-1-habte.yibelo@gmail.com?part=3D1

