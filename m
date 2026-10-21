Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598935;
	b=ZpyJiQnEXqlimib9Mibl77Me/Wlpf6K4lF7pan5/QdBZwqjy0UbkY566Ge8S1Y/FzdWL
	 SzIwHjNVeiJCQrvMxsEF/injzSx1fA4H3+nIF7dlEWILiKD2bMlagTaq69GR5JjwO2Lej
	 Hob79Nz2BE8PGuLplCeV6ri/acDTKKFM1GsuRPoYzUO9QpTRo9rSUJoAaDg0SCOLYs/l3
	 ejmOyMxI01sqvzB93K857vypFpFjlfUOZm/pTJCDMQzil2F5GRdBB4mgZ8UWsxIp0D47k
	 3k4f18ztupvNexM5rJifUPXw2DDcnDkBEjVVvm+5Meuzl4UfnqD7U+WPAYNFLMGo/lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598935;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xlUjPkBFZR5E69M180zZ7SvybteIZBcwvq7YyxzDeRI=;
	b=oWJ5pCq0CAsoXrLsHF9kjNVDwM4CRx+f3IXvu5NukGyCf3jXLqPWIWNej0OtGE6vi1Gl
	 tkfOa+LBAi89ISE23ckAkh53R507GAsynSC/hLM+Hv2WLawtAr30h+lTS6iTYWH5W39wx
	 QYUWXQwpd7V5u/gmeGNJq/bM8dblWxIDthDQ9qVoPpfQqhrzJZ4LE6bXWcp1s+bEOSiCk
	 j5uw+MLjnr0Rm7bTKSOv8S8sUPhprSwlq274men6rBYgHh1adP0kx8NhgpHwfaLT9OwNa
	 IvX76/1BZ+3pcdgtqYBVNVOcLGj2pIWXYJV7kaC5JOEFKsBQqrBAgJ83VkpKLzzIGVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TEHLlBpQ;
	arc=none smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58152606A31D
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 16:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58152606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TEHLlBpQ
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7c4818e4165so59202137.0
        for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 09:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792598934; x=1793203734; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xlUjPkBFZR5E69M180zZ7SvybteIZBcwvq7YyxzDeRI=;
        b=TEHLlBpQ6Wuj0wLfIMCl1Fee80sGepqZtjVEvCFtn0dQw5hbZkQg/BSs8AdOhZEQW9
         7bCcW+bCEYlCPo4uqpLV5VEoMeVcE/x7ClXBDX3vw8tKzvjlTl2MtvYV9DuFrvV2yv4R
         nqhHhAbHHjJ9UVF3bEkE81rObHRyqfbAo3yc7xx+0rUsWLjIslCNC7qrg3JVGStuL2oE
         bIBayOHV59aVIQpxrdMpZHUKkAkSK/WxDkfmeuus9ldTc01HqNqp5CLkzE00CQRNPJfC
         B3JoNlHwI/pydajBdoyEZkfXUjl5+yLfGkZQVIdKgR4+GGIG6KjOxqvDmWD/7bJsjldh
         2ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598934; x=1793203734;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xlUjPkBFZR5E69M180zZ7SvybteIZBcwvq7YyxzDeRI=;
        b=j0LBa3UPozCNbmRUTeWIYrJEOim8QUwEQ6imMuIHQZ4b5xluuzefqKNP/5cE7gH6uh
         IrnhbF1lWwzrXydlvUqlHCtYh0OZinOwyWjEUsjBW6Hxs8035FQcq1qVGP2+gB0qMj9r
         XbMqkmiQGnt+zlfPrpETHBejgzHvqk8rj6eM5tBo2/30IhCjr8rnzvnsdQLBgA2hk0uH
         36Tku22H4wxf5Gfg8CoQPlGkftrdoNYbDvpS2yOydIhmWGsgQ3LOd5myMVND1GAvIMES
         fa2941g9VOSq/DhbC4v2Yy069w/3eZRFu114jx2zNdfx4qzy43huTyC3u01kTkCtH2S+
         cYAA==
X-Forwarded-Encrypted: i=1; AKwUvBya52K+cJsB1mSVQUKEMIO+6vykOWh0ZiV1Nm+Gp+1t3JEmM8B90AcEURZKhHgyhUvoWtwYfuYC484hn932wg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJf7+Q1VlESo19cjQNVr2HjFnPcJOlME73yTilGMnDDXZv8PIjD
	Z/wQnFHWVwrAOQxLy47Uje/L1ZwlwCyglC5GSIFdMSsfzr6HPwsHcIYq
X-Gm-Gg: AYBFou3pEdqta0zGtvxCUa/uA3XBjPr5A/gLCJfDKkEgp77A576wxnjr5ILPqEEz664
	3Wym/lGkipNzlXGh7IGLWyZ4X0YStpeMTDdxZz/37PTTnTUvnsRuaMIAvsSTfvZPvipVE1Ce5pr
	FjmTMque/Osn/nZ8BD3pqYMM8Qgy8LCy7siv6yEe+qFwU4+2tEQ5IoF7SLCGU9BXsFSLp5VVPAt
	TAGxrXbxl1i6eXk0gQxMkFwCePi9an02iZsCLXuYxJ89LNx9KK+qKAJWf00abveiYfb3a9APclp
	Iggof/9e6jqjbTrCMIxvZcPOB9X8qSghO3mpp/rT5O6uIYYajeSq6FCwMxa13h3HzTV0l09fPTP
	VKgS00fBJ9kn6rmpqCadkUeU8AaipJtspSu6AkgEzHinpX7DGBGqrCXPoaMrGic5juo+tm58Qst
	ZsiqfqBlnRbf7C6fhoH1v4vcMJdHutr7G662/jmAjprEPRIJweRE4dtG8H87QGnZFD8RzpNbCrA
	4D7wBH5CB+FAvptghrjNe4arr4eubBeQZffOR8lVpk06XYDhjN3/75hL66oDroF08dGdihtfq1w
	BZWPULi5IcJJBc64EFDe6wQgJU9Z0J1sFrxPtZI8Qtwj057LK5vahwuWRNwjz5J5JC7B2rkvk1C
	Zr/ugViDglVtPe+fQt2c=
X-Received: by 2002:a05:6102:21cd:b0:7ca:9674:a58f with SMTP id ada2fe7eead31-7cc7bcdf51amr1136476137.32.1792598934205;
        Wed, 21 Oct 2026 09:08:54 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990d0e0ba56sm3638029241.1.2026.10.21.09.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:08:52 -0700 (PDT)
Date: Wed, 21 Oct 2026 12:08:52 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Chris Arges <carges@cloudflare.com>, 
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 Phil Sutter <phil@nwl.cc>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 Max Krasnyansky <maxk@qualcomm.com>, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 linux-um@lists.infradead.org
Message-ID: <willemdebruijn.kernel.186235776c7fc@gmail.com>
In-Reply-To: <26741a9a64c28e8de6d13e04972d296d89e1c95d.1792565282.git.mst@redhat.com>
References: <be251d104f881a309cfef150455efa128ebb101d.1792565282.git.mst@redhat.com>
 <26741a9a64c28e8de6d13e04972d296d89e1c95d.1792565282.git.mst@redhat.com>
Subject: Re: [PATCH net v4 2/7] um: vector: trim skbs before verifying the
 header
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

Michael S. Tsirkin wrote:
> The vector receive path over-allocates the skb and only trims it
> to the received length after the transport header is verified.
> 
> A follow up patch will complete the packet checksum in software within
> virtio_net_hdr_to_skb so we need the packet trimmed (otherwise the
> checksum would be computed incorrectly over the unreceived tail of the
> buffer).
> 
> Trim first, so the import sees the packet as it was received.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
