Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FF41993AE
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Oct 2024 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482151; cv=none; b=PnRud0jG/hd8LX2goQ1/5xvSo20zIsshW4GAQ9+xpIMQpg7C8ufuExaRHSGxFKIS/+bB8O9HQAcE0HSSemxuxXarVZbeVQHmvltZHtB67u5Xoztm99aBjFdjWloRb4n19V3KxsVwe9aHSOJ7425NdBcbRfr1lKXAeBBMf4mtTEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482151; c=relaxed/simple;
	bh=ZmiVMK6ztxb9hHv41yV8uT13LIdkutdZjhOKK9Mbmuc=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=V9GbyI7ScsHF/P9YE1Y3IAQ1X0b6sUOlVl1DH/R6rEKHeAFxYeinNuz5oIp8SwsovqTSqVqacuOa7eqEPRpzD4XsdqD6/Pmd4Yvo6wDMVrZKs4bENzEVT93v+Wt4zbJK/FexvPzd8RCLkFzE7omv1epu25BxQfQl3CDJ/LRd7rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njVo47HF; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njVo47HF"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DECF781264
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Oct 2024 13:55:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9lZAwprHZVAZ for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Oct 2024 13:55:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f35; helo=mail-qv1-xf35.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2C15481211
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C15481211
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=njVo47HF
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2C15481211
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Oct 2024 13:55:49 +0000 (UTC)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-6cbd550b648so2209766d6.0
        for <virtualization@lists.linux-foundation.org>; Wed, 09 Oct 2024 06:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728482148; x=1729086948; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXe51mvGhfEwWJHFEltEwZF8MBYYvVcNp5ZwNgaG/kc=;
        b=njVo47HF5BuCK3xN3fjGeDEN9bXA/Zse0Jpcnw4JxRgBTiYXQE2gLRqpNMukQUXqpl
         30rLKLaBh+7VSLRidSiGM+W9hJy39mBOHj3caGvO6ThF71rz9jgdbM8gZEPZNI4ehQ7c
         slwCX5ZBK+dc1Wcb7f8zsxF+JgIk1NZE1JjqFL2gr82gLO5dNaKsIkLSDtQG7hkYXrM9
         Gnq1Jz7r+8yw6OjoNe8s0whCAFQrOH8GITe5oSyag+VbKvgP9RaXxslscVqNmb/jwS3s
         SUO8VGXm70VGoRTMjiVM+qa3/WJf0OCMotzu2R/q+9c1VwQOCNM86tDJy1P7Nz2V+Uef
         SmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728482148; x=1729086948;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXe51mvGhfEwWJHFEltEwZF8MBYYvVcNp5ZwNgaG/kc=;
        b=A9C5pByb9YEyUhrSdXE7wNfaLJr12uBW1/rAnKZ/FRmIsVxRBpBlN7S7zGJglQwN2p
         TXYCjVfF9oNhsvDwXxL4bJgL96EZmKQ3nuCfbzsewgOwT/EDkkYr4HvEH52eEqKj3aaJ
         5piItf1+B00m45xFMGzWa+p8ijRC/cZkvGC68BMm2AHTOICe+3hxvObhxrsuWU3c7psC
         71J6dLWbF859LFPU+AQkcmelbOcXWL+ICwCeaP8IYadu2wpnbJ/33MJc99p0T7FfgoGY
         hq80G4iawBWzH2b6nY91f3rYwNifuXI1njH5+9yW8TFP2tZQ7niFhMu0MTgRRNpIKISQ
         0XvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg/j9+iikhmq0bcMY02+IB0uIdPQRpc+spsr+6BIhUcs6Z/Cg20GWVhyVJSoWPREW64xrfEtnIgDtcMYgK5g==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwaB6IFXIExAFLwDmmuVVTy+KzF/obH/EqN5SDkMNDyuis+uyM2
	+U2ERt7vOP6vr0m5UjpkUb/FkmO2WFHzQuB5d126/wkPrmikbn1s
X-Google-Smtp-Source: AGHT+IHmYx3bfmg/RlYhB/KBBRbGOAep6vvua+Aei8GWXcm7XpACan6FRH/ojiSHoStLQfx//viWDw==
X-Received: by 2002:a05:6214:2b86:b0:6cb:22ea:5e07 with SMTP id 6a1803df08f44-6cbc943269amr41560246d6.30.1728482147816;
        Wed, 09 Oct 2024 06:55:47 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba4760436sm46098496d6.124.2024.10.09.06.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 06:55:47 -0700 (PDT)
Date: Wed, 09 Oct 2024 09:55:47 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 gur.stavi@huawei.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <67068b632d2d2_1cca3129484@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241008-rss-v5-4-f3cf68df005d@daynix.com>
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
 <20241008-rss-v5-4-f3cf68df005d@daynix.com>
Subject: Re: [PATCH RFC v5 04/10] tun: Unify vnet implementation
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Akihiko Odaki wrote:
> Both tun and tap exposes the same set of virtio-net-related features.
> Unify their implementations to ease future changes.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  MAINTAINERS            |   1 +
>  drivers/net/tap.c      | 172 ++++++----------------------------------
>  drivers/net/tun.c      | 208 ++++++++-----------------------------------------
>  drivers/net/tun_vnet.h | 181 ++++++++++++++++++++++++++++++++++++++++++

Same point: should not be in a header.

Also: I've looked into deduplicating code between the various tun, tap
and packet socket code as well.

In general it's a good idea. The main counter arguments is that such a
break in continuity also breaks backporting fixes to stable. So the
benefit must outweight that cost.

In this case, the benefits in terms of LoC are rather modest. Not sure
it's worth it.

Even more importantly: are the two code paths that you deduplicate
exactly identical? Often in the past the two subtly diverged over
time, e.g., due to new features added only to one of the two.

If so, call out any behavioral changes to either as a result of
deduplicating explicitly.
