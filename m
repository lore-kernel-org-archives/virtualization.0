Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792538025;
	b=5stC8RsbNrwlkiFAJghZKhXXrs2lGSk7DWdQuBb1vdDKf6mf16pZq4tCE8BYKYeT/5lH
	 rnN0wLGoVJ60LW0okc+r04Z0dmJZjujU64/kwN+1RKDdhZ62KDtWbA1agiToaDhlA6k8O
	 OMlIJ0cr5+2VlZftFAn8Afb2vYI6NIEKNezG2TrZTaos35dJoWyL8p90S1ltnRAKnYB5h
	 b7OwYGRndLf0pQnM6P58Bn2ef28nV/Pqm6ZrFK2zuRaE82UKzGKk/4X0P3/N4+7XgKAnD
	 ii2Vi+VIYaj8ABEq3gZ/giFwpR/BQaHs31Wg/mRmfATasrETXnBQcTQsLI+hOcnTHqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792538025;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=rJ15NYGDexAwiy4HWGRqahFWgTYhKLwbhvNqgPq1/FI=;
	b=JRf97RiQOFSes2iaIfMWtHPvo5hFVmEmO17KnoNzerU/49AASCr80lqoVOXwyrYzNc34
	 LdrqGdPkar8AQf1KOPmuOEMfGK/ecM6/qIW7M+2i98G+lehPxayub8p/TinNtjlQVxPWv
	 J3ZHZu22L8l3sKNdiLHcSxhFNVnBm5BEsMBHHSNu5tvWbgU4B+aggpCXqRgkpZmmjX8/a
	 qLKkWAhd3N0PpoRDVglnQKyJNDP1TpD8Ns32JrsXe51A52fDafibX1WLZQS3xXIUNMmqx
	 vELBrFlMuE3cZjSootFVbMezId5cVtUzrHBhMfHqeCXsFukjtsJz7DAC+pRRJPypNCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sFco3ZR4;
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CCD606A31B
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 23:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8CCD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sFco3ZR4
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7c4818e4165so128841137.0
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 16:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792538024; x=1793142824; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rJ15NYGDexAwiy4HWGRqahFWgTYhKLwbhvNqgPq1/FI=;
        b=sFco3ZR4gglW9dbaTO7wN0i4rYYADLCrRVH147IieplykUX8myp9u4lGvV9xpETByi
         hRu52wgS2e2qBvhmPFJnYn7PrfbvTHDKAHlDXljpd7RKqKqhmpl3Vl/a9AW25bbQVjp9
         A4rL/XPoKWPmmdC0ZYg9f32O5MXIo/aNuuMKBz8BXAIzmafv2NKAzmU7mAI8XTOBEtxu
         3YsiILuOTVm4wuyvSAtl9kKztaclW/MwAcC8ay5tYh8V8Nj03537LY2nT/YXa2hn//dg
         X7Z4B0r7u9fc+oTVtFMXORv+dHsivBct7ab2eloXBlF7trdV0P99zmzezzFi2lxkJpQy
         Fl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792538024; x=1793142824;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rJ15NYGDexAwiy4HWGRqahFWgTYhKLwbhvNqgPq1/FI=;
        b=mk8eXxLcJ95+5g6yI+7HvXRJgAM3Ii4Q5w2L+NcIYU50W+crZ7q3BkHKqTLOr+Tfsn
         NICB4VbXK7yJZttg3gQ/dti42xp4hxaEyRTF8ojVyqVgDHX7d+JD6OlrQ4IyAr/aaPDm
         XEe0nLE5LeTO8dlGJ83ASGg/gB95oTlQqa6mCmThlWIE7zxvQOopch8nVui+ERja4CPK
         LELWrU0Lbr6FPjiUpUf9NvInpTGw8v/vC5+KjO2sBLrqIQzwsxP5o8CdJArnM0FNqPC/
         7s3JFaEYu9aWW78/Kiu8ylViBSrSeymUKyZd2RemOs0EMMT1KBBYR7TLuJ9ooe2jWi8p
         BhOA==
X-Forwarded-Encrypted: i=1; AKwUvBxmMhTIC4DC5UpJ9hZvrodn0k8X8ValJOqRGSL+Km9UVrVh5Ld9JWuFC5jTschYfLFJWhL6ducaCzng7D59Fw==@lists.linux.dev
X-Gm-Message-State: AFq9FYIeCya6+Myr90No8cK33/SSQkWYtdoF8xW4zZ4S6b6gxBE1fOGe
	OOul4dOeJtYuHnqpdtZ/9YZLmKRU5TFHO+6092O9fbZpJPVRMqVf4LUk
X-Gm-Gg: AYBFou2zB+JGi8Y9IKXJmPaO1Tnqbk7QcfhGlj33AaHz17Ga2/pb8RuAH+CVyP6a2JY
	ZlJ7RGtsiyjZjaA0SmeWtLoVbfBD8RonEQICy/ESyxlqwNz4MiSQMGrGkl7/dXvY1Xgcx0r0u9Z
	hrXXOVd9AhfS3RxID6G1sQzPNYeRJ0MvsMz1zUBuf09PopOj0QkjxqrOWt4It0I7mDN9hGJCQ0K
	nSZBNyxf8Il50KXALj6kRASbyAFol+RbdGvVKZMdZ34h/oGA3ss6rKNfMSk48QNJyjhXHMISd6V
	4uhFtnCYkVr3hP4bbw+LcruUNA0p0caS0Sur0jRYKf6exQepQmexv/nm7h1lYTsCW6kiilKPweg
	YZH1zdijyQIjbdt0/2tZHYbjLjdKFlGON7DTaeaUvhm4xhYmJ5HG+ILIUxMemsFoLiF/0dqFcJF
	5ma3Vt4B0UlPHPCJlaAHL+wCmgoxOtIfrKmyaRMCKT6jurlPljCIf/3RsfGCRpbswKWvAqQ8QfI
	UYyglcdv2bIyZDiQZYrQAsz/i15cDL6dns3lO9VVsliSsZi2leZJm+KYnzwiOVvedB5KrqyM7t5
	svFB4zkPzO7K52uF96Ln24OThD8dd6G433R0Xg==
X-Received: by 2002:a05:6102:291f:b0:7bb:64cc:1362 with SMTP id ada2fe7eead31-7cc926d26a9mr190460137.6.1792538023910;
        Tue, 20 Oct 2026 16:13:43 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cc9236f63csm803396137.5.2026.10.20.16.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 16:13:43 -0700 (PDT)
Date: Tue, 20 Oct 2026 19:13:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
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
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Simon Horman <horms@kernel.org>, 
 linux-doc@vger.kernel.org
Message-ID: <willemdebruijn.kernel.34b42ddc625c5@gmail.com>
In-Reply-To: <20261020165610-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <6f23c55c6eba3e3ec6b2c7e3a80728a326ed58af.1792411304.git.mst@redhat.com>
 <willemdebruijn.kernel.187d58ff2bce5@gmail.com>
 <20261020165610-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH net v3 6/8] net: add a sysctl to opt out of virtio net hdr
 checksum validation
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
> On Tue, Oct 20, 2026 at 03:54:23PM -0400, Willem de Bruijn wrote:
> > > +/*
> > > + * Protects changes to virtio_net_hdr_csum_check_disabled_key and each
> > > + * net->core.sysctl_virtio_net_hdr_csum_check. Readers don't use a lock.
> > 
> > it appears that they take the mutex_lock below
> 
> Some of them? But
> virtio_net_hdr_csum_check_disabled doesn't, that's the point, right?
> 
Yes, but the statement is then too absolute:
_some_ (or most) readers don't use a lock.

