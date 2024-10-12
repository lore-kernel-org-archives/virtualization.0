Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23512288D1
	for <virtualization@lists.linux-foundation.org>; Sat, 12 Oct 2024 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728754988; cv=none; b=FJu+xgLcpbbcEne2lTtzXX3Snug0LaUyn+VXINv5f0tr6QScwsEzuZFypPd2Ujuux1ieS09FuG+j1RyOHdh3GklVsMuuMNnudh1RFr/Y3lr/mLEuHGXhJtS6xcJ1D6M9lNZAs8CWlZhL/FXOWSiqb01loVcR7lIWh2lYD2USlO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728754988; c=relaxed/simple;
	bh=5vxHfxZTSTMr7CN7Egb8q5PbRkCrqQ/rHWP7s43dbOU=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hXgcdz1TEfB12Ud1Fn3vz08SxwwsdYch3BjoKRiXosZcLRk/zcALOvl1oeDzsWq8PEtl0Rvl+jFd/xaFPUdPM2XBIf729E9ImhirUpEyoclpPZyX15NShFAVX5EnTebG/sYY4j+Fb0Bn3R5E51BPRlH+glmvZhfJTXjJL6HCn5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdiEzwfX; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdiEzwfX"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DCD304072F
	for <virtualization@lists.linux-foundation.org>; Sat, 12 Oct 2024 17:43:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id titXObPr00tG for <virtualization@lists.linux-foundation.org>;
 Sat, 12 Oct 2024 17:43:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f2c; helo=mail-qv1-xf2c.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D111C406DF
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D111C406DF
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=UdiEzwfX
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D111C406DF
	for <virtualization@lists.linux-foundation.org>; Sat, 12 Oct 2024 17:43:05 +0000 (UTC)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-6cbf693d794so11690836d6.0
        for <virtualization@lists.linux-foundation.org>; Sat, 12 Oct 2024 10:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728754984; x=1729359784; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AzUJHAgi6gs5kZYag+VCdUP/bZ1QS6+6Bi2y+ZtpR4=;
        b=UdiEzwfXbD98fp7ncAdLvV151fF0tGj79BNobg3zFh0xmfemQ3p/KDLh3+pj0EdSdt
         hbPNT7Ll2W0yjp/zRoJKibxMdwt3jbuOrW+BID8WMBNK9FAKn4rWZ6oDnza2NXTF8/hK
         EmqLvBPGIRGgXxjm8Sx+nuhu6W9M5o2189B1hdQtVxM4Ov4uBRgw+Y/bsvsdKCqpEaSH
         i8qNLnMLdFYP8waw9LDYFTzX2bCCNDZzCLozmWdaOexnCtHz7/LYNF9vOydSilkLsiMY
         s0smE35KUCKwRBhYvouvGAdhMT8elxiQJS1oEGSgRjt7DNCDH4RK1kaCTLs7xF83Tf6T
         36SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728754984; x=1729359784;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AzUJHAgi6gs5kZYag+VCdUP/bZ1QS6+6Bi2y+ZtpR4=;
        b=ECXCRbULqYHH8Ktwis/SiSzhsYPfn33ljmbLV1elvP7x4fFTH7A3pXtov6WaVKWSsz
         G8bV/h0ulNMLE223XxGhO2nGds5MiWTgHt37T+gKut31/SYXTKxqJkgB2go4mMDnC4j5
         FuUuTQCYBCkpTX4lLaLMG2gnNtVlDbOTz9NKYNP4G2VuLk2zUMTqcrMpPXRaCz8fUwZz
         qwVV2oO1a9CJapSIClXkgtPdiQC+XWti2LfZ23pw/4GDO5x+0W4tr+KV92dlYfdZrUHI
         caVqEXklQnpgjEi05m2ozdgN36idhowGunr8Tv5UH3fX2dUegLcUKNBFWyMA5vNDPFZ2
         scPA==
X-Forwarded-Encrypted: i=1; AJvYcCWqpiMTjTits52/tEM1/2ee5xJzkbfAACF75Q0zkO7+MayOE2xlC42ouqrRNEO2aDSBThLwYSeREFgSdxAMyA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyYdpIFBYCiz6H4WJidH+wArir+Jlq/Lv7TTTSQWkU1eeqid5ZG
	kYmy628C8nt1yGiQnO+frOd/s21uoJbiSH6NfAXR+IXlQOu59Akv
X-Google-Smtp-Source: AGHT+IHAHXd8vAzcKkZ8geRl6Uqm1cetC8ltFNNIgXPCMaNQNaiyG1VJw/W9ZIuFbryIz9Ld3ZaETg==
X-Received: by 2002:a05:6214:4a0a:b0:6cc:2f3:e637 with SMTP id 6a1803df08f44-6cc02f3e7a6mr17756766d6.26.1728754984406;
        Sat, 12 Oct 2024 10:43:04 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85bab0csm27174956d6.48.2024.10.12.10.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 10:43:03 -0700 (PDT)
Date: Sat, 12 Oct 2024 13:43:03 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
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
 gur.stavi@huawei.com
Message-ID: <670ab5278077a_2737bf294ad@willemb.c.googlers.com.notmuch>
In-Reply-To: <f4501f54-875a-4c46-9e77-802bd81f4230@daynix.com>
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
 <20241008-rss-v5-4-f3cf68df005d@daynix.com>
 <67068b632d2d2_1cca3129484@willemb.c.googlers.com.notmuch>
 <f4501f54-875a-4c46-9e77-802bd81f4230@daynix.com>
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
> On 2024/10/09 22:55, Willem de Bruijn wrote:
> > Akihiko Odaki wrote:
> >> Both tun and tap exposes the same set of virtio-net-related features.
> >> Unify their implementations to ease future changes.
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> ---
> >>   MAINTAINERS            |   1 +
> >>   drivers/net/tap.c      | 172 ++++++----------------------------------
> >>   drivers/net/tun.c      | 208 ++++++++-----------------------------------------
> >>   drivers/net/tun_vnet.h | 181 ++++++++++++++++++++++++++++++++++++++++++
> > 
> > Same point: should not be in a header.
> > 
> > Also: I've looked into deduplicating code between the various tun, tap
> > and packet socket code as well.
> > 
> > In general it's a good idea. The main counter arguments is that such a
> > break in continuity also breaks backporting fixes to stable. So the
> > benefit must outweight that cost.
> > 
> > In this case, the benefits in terms of LoC are rather modest. Not sure
> > it's worth it.
> > 
> > Even more importantly: are the two code paths that you deduplicate
> > exactly identical? Often in the past the two subtly diverged over
> > time, e.g., due to new features added only to one of the two.
> 
> I find extracting the virtio_net-related code into functions is 
> beneficial.

I understand the benefits. But as I pointed out, it is a trade-off,
not an unconditional good.

> For example, tun_get_user() is a big function and extracting 
> the virtio_net-related code into tun_vnet_hdr_get() will ease 
> understanding tun_get_user() when you are not interested in virtio_net. 
> If virtio_net is your interest, you can look at this group of functions 
> to figure out how they interact with each other.
> 
> Currently, the extracted code is almost identical for tun and tap so 

Almost here is the scary part. Any code that is not exactly identical
must be called out in the commit message.

What often happened is that one of the two got an improvement, whether
fix or feature extension. Then it is likely acceptable to extend this
to the other, too. But we have to review each case.

> they can share it. We can copy the code back (but keep functions as 
> semantic units) if they diverge in the future.

There hopefully is no need to diverge in the future. I suspect that
all previous divergences are accidental.

> > 
> > If so, call out any behavioral changes to either as a result of
> > deduplicating explicitly.
> 
> This adds an error message for GSO failure, which was missing for tap. I 
> will note that in the next version.


