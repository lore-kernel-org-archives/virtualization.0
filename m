Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7733312B8B
	for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 01:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713836167; cv=none; b=gSDGwnLpFG3MKfXUtJjt2JsPMniMQL7G88ZLqBpo+PNXLmPr8xJjq5A1Uu4SYDsOM8tTNdx3ERkqZlCZKzb0RVHtHXavLUmFm/ZBHLqsSDSVlp4ny17SYsD6XrbWa5IKlmHi/cWo5RDgl5sBgPE1DT8DVqFVfH0xGpAGpfH5mmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713836167; c=relaxed/simple;
	bh=FzHzlKOYZu3jrDJtojwBIp3jG1Z4L84R0ebQ+R2aHlQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qvsUUv6hUwp0/NwMA7RK+i1vI49ej1drnTB6R6PFD+lPuAAsQ9qv5WGNw7ou1OgBE86elrF1akOAywOLE7LFadX+VggNGbofULZfQdapEVJ6avbuwBW+VF6GR2Vn1WmJWsNqu0hWjXnWZpKJCmrbN41LzNP47zcZxpYqMYTKcYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pHt4se/4; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pHt4se/4"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ab48c14332so801516a91.2
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 18:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713836164; x=1714440964; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9oPaH/VV1Sgs6JhGxcg9NL/ZQE2v/wkBZW2pxzw1II=;
        b=pHt4se/4FhiCPrG6Ozkp55cqTUjba4rAvta0qJweA/YsXzjaNwxk7uQiYxc4Pf2U4p
         xdFKmE5JU+4q0abv/UCQrwg0nb3O5RA3PNow5/cq3zgg1GfyoRvpms/u0w1t1Z/TsEZ2
         62+QmXoZh04AdQYkuI38bCpGBzb9eDIr6FDH80VqfAgvnw+uPivIDbbirqfhWgHEqbYH
         z0l7YRXvZuJZbVj4YMHpm9Q/+Hkou5Kq6IbgJ+/80ecRgr1RchUo5I/0n2y7efz5cMFn
         8R/PD3+HSE1By3kRaBnynnMkAJH3s1hwl2ixvZwjKTmuLOE2HXESQ/kHxV0br/Z3jVxH
         Y+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713836164; x=1714440964;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9oPaH/VV1Sgs6JhGxcg9NL/ZQE2v/wkBZW2pxzw1II=;
        b=s3tGODwR9LlPjE2tXQezFZ+DJQSausOcmJbQXksOVVSdMxobJ+Q1kDrLjqW4lPMAKu
         S7ZVkAKsm3b2IRyuudQOQ7Rf8DuXj0TqrtdB+2n0bOh1xfAgEBq5M5JOEsOdrZLKTz44
         gWh+UkIETnL1U4SpdH3pgKtvqQii6VbiSqduqFp7IjD+Hyjke+MuvdqBcXGpUONbgr1t
         fEqvVpRuwRfB0HYSIRf5/JT/OsYJZYx5kOJWhRx0UUBy/EFRBFwysiNIZv7bbhF/QXZf
         Odpb9XtkSpA4Pr2KL5ppi4RkToblDm8Kwxs7mw5Uoism0a8nDUbL+5PoPSAGTunowuUM
         OUmA==
X-Forwarded-Encrypted: i=1; AJvYcCUKi2KmrSWHgT0dveG5PpENCtO5APiH4bi7er4kN5+KBqwQgKZX5BwBkqB19qzfC2BIevbv0f9ywOHI3BsXE/m2aoUF1bijsEUDn9hltAA=
X-Gm-Message-State: AOJu0YxG+pqq3i7vLnRoenWL+6316LKyl/C8BQMXqh664hFPTeMhOJAG
	hH7jKQ+kps0nniTRAUBJbGSH5hjft9b1VdiFwRPMJhaSCFTSHU78o1n77XVk8PQ=
X-Google-Smtp-Source: AGHT+IGzlYpawNDmZcr5CUIaLSVmPzj5i1QCymzAQ8rNfxRGM71jaLD4N1FTIjMDD+MiT7VbGVUzTQ==
X-Received: by 2002:a17:902:ec84:b0:1e8:4063:6ded with SMTP id x4-20020a170902ec8400b001e840636dedmr14042378plg.1.1713836164318;
        Mon, 22 Apr 2024 18:36:04 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id f21-20020a170902ab9500b001e5119c1923sm8777775plr.71.2024.04.22.18.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 18:36:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, netdev@vger.kernel.org, 
 Pavel Begunkov <asml.silence@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, Wei Liu <wei.liu@kernel.org>, 
 Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org, 
 "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
 kvm@vger.kernel.org
In-Reply-To: <cover.1713369317.git.asml.silence@gmail.com>
References: <cover.1713369317.git.asml.silence@gmail.com>
Subject: Re: (subset) [PATCH io_uring-next/net-next v2 0/4] implement
 io_uring notification (ubuf_info) stacking
Message-Id: <171383616279.27114.3831538607187347697.b4-ty@kernel.dk>
Date: Mon, 22 Apr 2024 19:36:02 -0600
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 19 Apr 2024 12:08:38 +0100, Pavel Begunkov wrote:
> Please, don't take directly, conflicts with io_uring.
> 
> To have per request buffer notifications each zerocopy io_uring send
> request allocates a new ubuf_info. However, as an skb can carry only
> one uarg, it may force the stack to create many small skbs hurting
> performance in many ways.
> 
> [...]

Applied, thanks!

[3/4] io_uring/notif: simplify io_notif_flush()
      commit: 5a569469b973cb7a6c58192a37dfb8418686e518
[4/4] io_uring/notif: implement notification stacking
      commit: 6fe4220912d19152a26ce19713ab232f4263018d

Best regards,
-- 
Jens Axboe



