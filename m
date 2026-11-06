Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793953000;
	b=aeCnAd17s9TTkFUjDNGm/pSiD2GMwmPM7/uVbWZNg68Q0X9bC/KB675h6ADNFTJU6Jsy
	 KC0SV6u6s0J+HFy3g69AJdync9f3vqa0ysrhSgYOhVoreuY205QX9nnLILgXNMJkeqMfw
	 vxztWBGmqBD67JxW+lYIbONzSqpy7K0vMzo6Wieum2aA70RodkONBCH2Cg0qwdNlAj4Mi
	 LddxBXBq2olKmTTG1h8OoQTL+dGcsHJ6GYJHqN/Deq2VULRBPilLAoKj0xv2u7ZgEcT8k
	 PbWWspEcE11Dud9yJLLOked3KP6ClJ35YSx7sb9QoOEK7S4IXB1yFpKLZ4pzrnuxMGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953000;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YEy2zH2WxqtAiu5yCjvYYuAa2Jrbvlm6eQd7P1mbqW8=;
	b=WNKMydQ+uCZjC+ZqDfsW6BrJiVPrfwNxnJZ44rVuMF72RlLmShZeBGTWAIcDMI/OEcD6
	 TWU741v0FytBJdOAaXFcVNl3/aPz5WDgr+U0Sa0vtc7f677bHJ3epBu+Ke4PI/FLWximK
	 HoTeG65eZpjz8KuWEYFbjvrEHf4HnTPGSNuM5IkQXQY/5GvuyXT3tdA58MnS6xOSqTSZx
	 eSVfL6fUTom+pUOa8x+UQTlymWZxiEEMi0EFo5B/1Ibl4aT+/7aWik0t1KPRgznXHlq+y
	 AD9TUKBQJW/paV5pxpkl6m5UzO4BnE/Oy0pgMFnP1JxtKLXSqnEV2Ypp/pOzadph1vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZ2T1Jsi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90683606A32D
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 08:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZ2T1Jsi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2171F0089F;
	Fri,  6 Nov 2026 08:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793953000;
	bh=YEy2zH2WxqtAiu5yCjvYYuAa2Jrbvlm6eQd7P1mbqW8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VZ2T1JsiIB2kx0k4HovPE4XHSr2FLZ4UWzx9pA4NVV2uaiP6pcsKGFsgedg3CP4Dv
	 5iKiw+7MLG2MZcN+ezeoA7edxogF1Zj1KGPh8TJKPtUNw2z/HIbjoHVKdTCnnmxK1H
	 Cr2MeZA3TmyXivzF2n3cKKpPQ1OBLMYwWE/bUnKqPrZIujV3TJT932e88owGxFI5U3
	 LrWbXPZ+j1yWV2P3l/e/XMG9OGmg+Rq9zBRk1ET1mtqZLiXtAauebdshTdBOq1vqni
	 sbGz1cq9WTvUJzH4cwdFyjf9dWBee58GpGlwRHcQSUvdY+0+oQRSLWC1e35a9QXl2U
	 gj/7PPpxkfKbg==
Message-ID: <sashiko-outbox-201038@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 1/8] net: virtio: validate outer protocol of UDP
 tunnel GSO packets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Dumazet" <edumazet@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105115715.1466924-2-edumazet@kernel.org>
References: <20261105115715.1466924-1-edumazet@kernel.org>
 <20261105115715.1466924-2-edumazet@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 08:16:39 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> virtio_net_hdr_tnl_to_skb() trusts the virtio header to describe a
> UDP tunnel over IPv4 or IPv6, but never checks that the frame actually
> carries such outer headers. Because VIRTIO_NET_HDR_F_NEEDS_CSUM is
> mandatory for tunnel GSO, __virtio_net_hdr_to_skb() skips the flow
> dissector, so virtio_net_hdr_match_proto() is never applied either.
>=20
> A guest (or a tap writer) can then inject a frame with an arbitrary
> outer ethertype, for example ETH_P_NSH, with SKB_GSO_UDP_TUNNEL set.
> The GSO stack then runs nsh_gso_segment() on top of the UDP tunnel
> segmentation, which assumes a different header layout. The result is
> segments with skb->data before skb->head, and a host crash in
> skb_under_panic() as soon as a later layer pushes a header:
>=20
>   skbuff: skb_under_panic: ... put:4 ... dev:gretap1
>   kernel BUG at net/core/skbuff.c:215!
> [ ... ]
> Co-developed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105115715.1466=
924-1-edumazet@kernel.org?part=3D1

