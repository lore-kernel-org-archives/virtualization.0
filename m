Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795D65DF0E
	for <virtualization@lists.linux.dev>; Thu, 14 Mar 2024 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710413264; cv=none; b=Ih5Rz1ksEtutFcOppXOBNop6yR2uE23AsRKOvz/S/u2HOAey0Kkuh2uf2UMlI8CsE0+CD46m8EsQUJS3gxS1T3mpJzcEaG1Q5jm2eY5UDpmuhxKV6J/nHpZ4e6iNzV11qvjkf5mM9RDNR0/ixFdNDeJxHtXMLTmyrgCmAahTcBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710413264; c=relaxed/simple;
	bh=6Po0In9YmIuctZOXLOYLv8QLlYCc93cdX/TK6r2QqeQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MTz9z9VAocBAYkXzAkq1XFmUV/F0x65nvfyG8NyCdTFeiHDI42tVeWGOwl8QskNrxFEicAmu7o8FWd2uunEfFPev1sBLMMEiMVbRKTY9R8XVq8dK6KJI697SzzGWW7eQSNNKGW1ger5ePFCiEVKgNOT/ry2CsU1Bg9+QwEOjXtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EuS0nYjo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EuS0nYjo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710413261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2ekNITLZLI+/FItVgxKmR+OcdubtrpAn0YlMN33y/mc=;
	b=EuS0nYjoH/dnOrmLztpVxH8dJPfeLhCBaHLSVSZJvK8DvrC+TGkomzXnSmZaObHaRXHXoo
	f0AGMlp3Hx2oDKAR3od8OtskgjXxGGWSBqwSs5MY1NC+Zz+TDNzYNCDRGAJXBshqBa8j4H
	vsavX2xP+k7taeY32oT/tDr5kk517Zk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-mzWsQ0SNMAOuiYkoXqpXYQ-1; Thu, 14 Mar 2024 06:47:39 -0400
X-MC-Unique: mzWsQ0SNMAOuiYkoXqpXYQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-412efff3b54so92555e9.1
        for <virtualization@lists.linux.dev>; Thu, 14 Mar 2024 03:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710413259; x=1711018059;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ekNITLZLI+/FItVgxKmR+OcdubtrpAn0YlMN33y/mc=;
        b=wzPAq0TPzrlO38xTOvA00yLWgAugugXsQIgA8hj+o9YJBjeKx+IJIXHcRhYLe4MnUw
         /l1ZN1kLqXDvkrr4QIeBN4Vyx91EvhFlhe7MMW83C9FlkuN/eULWcu+d5Z01c6HOO4Mw
         jgfsQAAfNatYz+QLAP0WvPw/c3IVfUOAExoK8KlUJehxESyTUVtGUkEJPZVSo/5Jgi90
         BFCQcePxrdXt7yiGVD8fXRSpoAfvHO1MF3r44YewVxJxLT9FIbVMmnbEXFWU3z2Bhu4V
         FW7pivpMgz7H5KzM12m1BIkj96Jfb6qk/f9a50yy6iye5YKcdP8c/pp7kL/M3ZoEVR7s
         K2Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUeQJ6VcZm3oA7TubZXL/UXYZMNrn5ZunZVEVJtvHjjfTyzqN9v63lGh+Q/ROhk9eKpuppJbhcnc45LFz3tt4QV5LkxtTYagUUVHjgU2S4=
X-Gm-Message-State: AOJu0YyRee14gWuGUd2dwPIrZevQk1z5cmwCgLmu2fh5HAfBQE7K1xYn
	vsQB5JYq2+25d8G00e8oWINSBUAC2bD8GlTFHiiveBW7VaFykauENpEF7bW0pMGkwBhIjyNyCJB
	0Gocct4D/STr2z2j1z6tbKDbwcStE6fVAigONHfeWHSkcJXtdqszr00eMzYDDymFc
X-Received: by 2002:a05:600c:5120:b0:413:7c2:6639 with SMTP id o32-20020a05600c512000b0041307c26639mr1081503wms.4.1710413258864;
        Thu, 14 Mar 2024 03:47:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTODlyYjah5I54/X6T6UJJ1Wro06knJ3eNyIpymT4A3vga2+fkz+648AYKo9AA7gbWzO5H6Q==
X-Received: by 2002:a05:600c:5120:b0:413:7c2:6639 with SMTP id o32-20020a05600c512000b0041307c26639mr1081486wms.4.1710413258487;
        Thu, 14 Mar 2024 03:47:38 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-230-217.dyn.eolo.it. [146.241.230.217])
        by smtp.gmail.com with ESMTPSA id p22-20020a05600c1d9600b00413ea933aafsm2061854wms.26.2024.03.14.03.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 03:47:37 -0700 (PDT)
Message-ID: <3f6099777f59bc2db28bebffb2710e12ccba9489.camel@redhat.com>
Subject: Re: [PATCH net-next v4 0/8] virtio-net: support device stats
From: Paolo Abeni <pabeni@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@google.com>, Amritha
 Nambiar <amritha.nambiar@intel.com>, Larysa Zaremba
 <larysa.zaremba@intel.com>,  Sridhar Samudrala
 <sridhar.samudrala@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>,  virtualization@lists.linux.dev,
 bpf@vger.kernel.org
Date: Thu, 14 Mar 2024 11:47:36 +0100
In-Reply-To: <20240314085459.115933-1-xuanzhuo@linux.alibaba.com>
References: <20240314085459.115933-1-xuanzhuo@linux.alibaba.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2024-03-14 at 16:54 +0800, Xuan Zhuo wrote:
> As the spec:
>=20
> https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd=
243291ab0064f82
>=20
> The virtio net supports to get device stats.
>=20
> Please review.
>=20
> Thanks.
>=20
>=20
> v4:
>     1. Support per-queue statistics API
>     2. Fix some small problems in last version
>=20
> v3:
>     1. rebase net-next
>=20
> v2:
>     1. fix the usage of the leXX_to_cpu()
>     2. add comment to the structure virtnet_stats_map
>=20
> v1:
>     1. fix some definitions of the marco and the struct

## Form letter - net-next-closed

The merge window for v6.9 has begun and we have already posted our pull
request. Therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes
only.

Please repost when net-next reopens after March 25th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#develop=
ment-cycle

--
pw-bot: defer

