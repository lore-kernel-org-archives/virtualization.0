Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C601CA699
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Sep 2024 19:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726429721; cv=none; b=XCWl7d7ofdlNtcvn3DgRnecAhTwnTrHT1wrJUIR9VBjfKu7ZPdTXD8BgMY2Rd8lZaav+BxJwtgOAWKI1xolV2olJKnvPjyyNhnNwfSYGu1QIUWaHDUQLjUZP+oH600ONFuvXPkuSv/OsywZ3C7sDpNXD3fHYzkTE6xBA/nlDFRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726429721; c=relaxed/simple;
	bh=MRhzl9kpuCHu74clIdzWjSROzs8qD6POOF2vur5Iqeg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UaVA1wojyh4kuWIoH8PBUyyKullbFE/mKcmIT2EwNoG6PmBbUHXPXYn4fawGBzpQEnHlevEZvT8oU87LuJZKSF0UeRvO9Xqzp6IGZ2Zr+MGRk9wWHAkH7fACvAc6xZo7agqMtNELQ8Z7d8viGABKqzXyZipRZNrVdY2qSdiJj/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=R8d0jMRC; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="R8d0jMRC"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C25028114B
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Sep 2024 19:48:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fKawuU2VJL0g for <virtualization@lists.linux-foundation.org>;
 Sun, 15 Sep 2024 19:48:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=stephen@networkplumber.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 93BA981133
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 93BA981133
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=R8d0jMRC
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 93BA981133
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Sep 2024 19:48:38 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2053525bd90so21619105ad.0
        for <virtualization@lists.linux-foundation.org>; Sun, 15 Sep 2024 12:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1726429717; x=1727034517; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNp5/hnkOy9FrJ592XEPwxvQOfrqTwTwJ+m8OyrqXK0=;
        b=R8d0jMRCyDBoON+ICZlt34ssO2Fm9kGqIblGs+xRVawao8BAI17aVbSb76cJCONaTW
         OogwPkSZP16xWnxYShboo3R4akc1LUxZBPkSuxQFv1y+sVYp9yzN+3YwQi77+eVx9L6g
         8d8RjCCkznX3sUrGJqOOPqlOoWA0XqvVUKib1XyvlSNP6q8KfEeOJHS5fGkE4UpFHUH9
         HedfJ1/tCvtEkVFqbAyGK7mT4EQbBj71vGmuZZJ+K48pwZkwP2Ffxs5WNAaUmJ26L4V5
         CVBtwPh07VkYWwiPRt+izw64e/ybhBNFyUzvcu99SmfMzZz4X9uAvY0qlGHyQIaNJyah
         /J4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726429718; x=1727034518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNp5/hnkOy9FrJ592XEPwxvQOfrqTwTwJ+m8OyrqXK0=;
        b=h8EJX8MoWf4/8XGakEtzd5KWbQENVXGNN2FHNSnecnTMBVLZ7+bBf8FB6b2ZGaY+jG
         r6l5o17kyrVoEctbeRfUQ4Wb7O560N2nnltGWht4QDZ7rFeMgLw99xP/eR47Pq3dRjf7
         iV+DwI+XEe0oxIgHzez2/45/Z0u7P/E27NiCesEXiThMLj4iMqYNSxBLNdn3RExoRdpm
         ZX6V2TzjvvBZIKFeoCSnJVQIue8kkuSI0jSNJqwPutVLmDu10Dmke8GjuSp+/0EGaU+P
         tUGTbZ2V1/f3e3ktTt+7Jler4gt6DOMlC9JWuytZCENvXRJcdDrxS7sA1UIFoCNk7giP
         G77A==
X-Forwarded-Encrypted: i=1; AJvYcCVGfIAujUmJkcCggBtEA/ghfB7bkcQwMPFPAx+pKZVrS9LN6x8hBkJSj7QQHuNxM7zDlISkA/igNDT4hdTW+Q==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YysKNuNAg+Ayhy3L+8f5Q5tOtNlqwZKZXUcx6DC5lJ/5p7lxt1/
	1X5vfJ1ID9TaPPQFK/bUGWB+mK1KRBvD6nGBHzv+sbgCOhotReLoIrHXEeW40Yc=
X-Google-Smtp-Source: AGHT+IEIwQjnGlDPb3oEceDakpD1b1PWW6LbBCx4i0kZt1Rli+HqyHRriIrHVS++Yfgo5DfOZzymmg==
X-Received: by 2002:a17:903:32c9:b0:206:ae39:9f4 with SMTP id d9443c01a7336-20781d5f6fcmr138044405ad.20.1726429717591;
        Sun, 15 Sep 2024 12:48:37 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794735719sm24738385ad.275.2024.09.15.12.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 12:48:37 -0700 (PDT)
Date: Sun, 15 Sep 2024 12:48:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah
 Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko
 <andrew@daynix.com>
Subject: Re: [PATCH RFC v3 0/9] tun: Introduce virtio-net hashing feature
Message-ID: <20240915124835.456676f0@hermes.local>
In-Reply-To: <20240915-rss-v3-0-c630015db082@daynix.com>
References: <20240915-rss-v3-0-c630015db082@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Sep 2024 10:17:39 +0900
Akihiko Odaki <akihiko.odaki@daynix.com> wrote:

> virtio-net have two usage of hashes: one is RSS and another is hash
> reporting. Conventionally the hash calculation was done by the VMM.
> However, computing the hash after the queue was chosen defeats the
> purpose of RSS.
> 
> Another approach is to use eBPF steering program. This approach has
> another downside: it cannot report the calculated hash due to the
> restrictive nature of eBPF.
> 
> Introduce the code to compute hashes to the kernel in order to overcome
> thse challenges.
> 
> An alternative solution is to extend the eBPF steering program so that it
> will be able to report to the userspace, but it is based on context
> rewrites, which is in feature freeze. We can adopt kfuncs, but they will
> not be UAPIs. We opt to ioctl to align with other relevant UAPIs (KVM
> and vhost_net).

This will be useful for DPDK. But there still are cases where custom
flow rules are needed. I.e the RSS happens after other TC rules.
It would be a good if skbedit supported RSS as an option.
