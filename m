Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806622;
	b=cQdYcOFf8tTfQpSoobXHtWUvUxQGulTF11+mxWLbolVJfkhxjXtEQkhBkqsLE48YPU9a
	 RI2Ssazw3Gi7yH3cFBQtXZyJyJ5EpoLoVEnYeeLt0e5h2A3xNCfshjOZ/+Pao9fkaKpqG
	 C+4i0LVd+7JbLHS1eXrJDXLwIY9jwcLfYt76tE4/Htu3290f7LRMzS7NaweXOHcFlFwf9
	 /RCS7SQxZbE99UUbdzPiHyVMlK26TbBriScriaUEmNRIuRr9TftbWnu8Qx/GHvKPnPCTT
	 iKpiFQFJFRxkta+yJQqAz5AYqnmlDMotT8KCV2liNCPFEwZLfkr+3qYv5btKWOf1iKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806622;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hVIa3swhsbmrrYjC4G+lOwvdapL/nqbZUw7IU7FT/vo=;
	b=yJ1EVOE70Rj7vG8Whn70FxqNKft3WX2/BsIGnZ132JcljsoFXAG6Ii8PykaI/lQ1zvpY
	 fl4UwI9ph0f9LOJbrwA2inBRGZa2d+I8j24XqXFFMM0MBzryJqPJfs6YVaf0xMRmaCBhu
	 G0tVsCASlSQ2gzZq0PHd311a079P+9xNpP9oLDEqTxEmTFUyMN5tLN/CltLaQ0F6I470d
	 zajsh8fQ8koghqvDjFSh9z/7a9zgAzs4KYLlSPyzKOBrLNpdJYbbk58nOcMrtJjjZgU3O
	 FT8lDD/XIviXs2ehaPor6UqiiZrgNN33+BVbvpknvqxLyRW+1LWiO3SQePPHQ2zTpSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LgdYpm7g;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23C2606D831
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 15:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A23C2606D831
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LgdYpm7g
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5eaefe5b523so544042e0c.0
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 07:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793806620; x=1794411420; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hVIa3swhsbmrrYjC4G+lOwvdapL/nqbZUw7IU7FT/vo=;
        b=LgdYpm7gILENQdkdEgIezV8joSSgsNEJTDDyDilFRWDkfsG7RGcxI9Gynyy0pen8/Q
         H8tFAW1KAb9i41EMre5Q7c7WUtnXqKIMDHyQog/1fOhPoZlw2ltgqegtE8SLuzjJe9cX
         Fhs9Ai6wkMYgLywoR7z/v+zuq98zSEHjH8wWwAVpY5QEuV0W2tyvAF3BK29bF8oK57Qd
         eSIQ2LPje0Q+GYX5xU4r+mpXGtKjr5qjswK5/V1uPQRGCySICU0Z38vwcOYCQpd5K/X6
         5dHhK79VCaEcsE6Q0ewYNEBxnIWFm7TEgQoRMmTc+RFyuTHLF/cmvlAwBdDH0wja37C2
         qe1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793806620; x=1794411420;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hVIa3swhsbmrrYjC4G+lOwvdapL/nqbZUw7IU7FT/vo=;
        b=fKgy+gzDSK6GduGBCGH1fM4WqM1EVVjcxLMuWPSxqS9Ry4zE+9uPsD7bSAi0cGWww6
         ssGX+e6JD28PkbWQ+zn9+IL0Uu3r9Y5C+IdO+mE36VtmD52OFsZFtj715SokYhD9veDH
         YSAQVuUv/WIWzFlFhOAVC7cWrOy2zLY1AWJp4fE68IP5fazkEXyi9GVcSeZIsd0vChZP
         lN/KmfWVy3bmY1lBKZYUjHmZnj0Iwa4C7HPCeSONyhgLheS7vE8OSGn/rox8ZPcO43HN
         Js3ORaGKz83a6bTk3MCzFmWfZWzLBeG2kuaih/iZWjDM9wIsEU7WLXnLO8TcxO5EiAIW
         xUYA==
X-Forwarded-Encrypted: i=1; AKwUvBwqu8CoQPr8CfLOQRyTEvrNz650edLMqVKLr7UPbHnqZPIz4euRXI59macAxvZUg5aJkvxCXLbS26kz1mpitw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9WLkCVC9kbPyn/qt/8nJImxKZLiSZAvxhupXjFdkqcPzv6frUo
	uSvTEvIPOOXlaavqyEOBUHdGHvAdxgYLoHoYq8L3j0TnPSTCssDmKHXy
X-Gm-Gg: AYBFou2xdphSXrV89QPHdYFkdppFlcU+BM56waBXnGI5hvHuW/MX/1OTxTHU8TKl96X
	tP7jN8YrKGYQt/Jf85rQOmt/JkaozhzUg4iVQZ7XwubtWJxe/rdvRytbFiO8YTPpws+EfNhkiKm
	ChksTlvtnNDBHm174RRWth+Wcq8txPxBh6TkU44o1XmCjvVFk4VeTVLH1TC2SutYldUSQsA3Evz
	pAUhuCfOJzrhzQtIQ2O5dYcR01TGe4o13GOFdLuab/Ggl1nNTQEN8IWJobnaWojuAPw4gVXiOgT
	+cmjsciSX5Vmc5NUQu1HFLsoan34FHBHgHNpib+UghFgtT3RGjEKtHkIdxE669tAgpPJNlJnChN
	bPDW2wN2VIMDFIjZrGiA+lrbzWC2A6uCzFSRL4H5Bo/F90wxxvB+keUsQnzgDtmKAYMp8obtYdM
	r/iw/EM+RV0AjDQWwtpmdiVLG+qQ8cfKVJNIzI8nNaKoNFNixMG1A3qEv1NKUJ+zbd1+JnHSJQP
	QnvjiG9uocoOFmUVm0exIkLQWzyU+ZVRyNoCMbao6JLntaRvnCelEm7mEWtWEPMLBKP0ay3H9MK
	fpbh85pJVJwdONcobUjeK9GeSlJc9xktCNZVfD5C8I2gAmVsHbzuETilaA6xqZB2WeAaWxRdTXS
	6nDmC2YOo89m7pQ/L/xAFRYrOTHdINWx2laPYXnSola9Im38ykasx7IgMdO4lHoDpNryRf3jPg+
	rm1NfRL0bkf1pUhWtR8w==
X-Received: by 2002:a05:6122:4d86:b0:5ea:aedd:6087 with SMTP id 71dfb90a1353d-5ec6871d3d2mr7672956e0c.4.1793806620530;
        Wed, 04 Nov 2026 07:37:00 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8d774dcsm1927819e0c.5.2026.11.04.07.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:36:59 -0800 (PST)
Date: Wed, 04 Nov 2026 10:36:58 -0500
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
Message-ID: <willemdebruijn.kernel.394adf46ec48d@gmail.com>
In-Reply-To: <20261104050131.629967-4-edumazet@kernel.org>
References: <20261104050131.629967-1-edumazet@kernel.org>
 <20261104050131.629967-4-edumazet@kernel.org>
Subject: Re: [PATCH net v2 3/3] selftests: net: tun: test outer protocol of
 UDP tunnel GSO packets
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
> Add tests writing single 4in4 Geneve GSO frames to tun devices with
> UDP tunnel offloads enabled.
> 
> tun_vnet_udptnl_proto uses a tap device:
> 
> - outer_proto_ok: an outer IPv4 header, with or without an 802.1Q tag,
>   is accepted.
> - outer_proto_bad: an outer ethertype that does not match the declared
>   tunnel type (IPv6 on an IPv4 tunnel, or NSH, with or without a VLAN
>   tag) is rejected with EINVAL.
> 
> tun_vnet_udptnl_proto_l3 uses an IFF_TUN device with a tun_pi header,
> so skb->protocol comes from userspace and there is no Ethernet header.
> The outer IPv4 header carries options, as virtio_net_hdr_tnl_to_skb()
> expects room for an Ethernet header before the outer transport header.
> 
> - outer_proto_ok: tun_pi and the frame agree on IPv4, accepted.
> - outer_proto_bad: tun_pi claims IPv6, or the IP version of the frame
>   is not 4 while tun_pi claims IPv4: rejected with EINVAL.
> 
> Without the first patch of this series, both outer_proto_bad tests fail
> because the kernel accepts the frames.
> 
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>
