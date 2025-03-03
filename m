Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5259E1E5714
	for <virtualization@lists.linux-foundation.org>; Mon,  3 Mar 2025 06:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740982843; cv=none; b=sgfam+eLH8xDalYsKw7RLXqrG/P5GYKBRxqSiv1gRHqt0FzdbSnoAiPvuWyQlhOpIyvFYCcHoAcc8TnIlK0DnrmN4IiF1R0z9KcwguQSpKZXqCwqK6agYxdRQ6QXSEXLDkl+xLwArH/fq148nElKFssxKgCjs4rcAZxMMqAWNWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740982843; c=relaxed/simple;
	bh=xnkf9dHEY/bxJnJp3UuspjIPE+0ejwYLRa1u2I2pWLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+UruYX6kVA2KuGhHc4ZeN0rNjWF5CEhq0Z71r02qmK7x7GtzVo+SdwvQeDHqQcqjy+qla4SeS+o9PjmJ5DcgcYEI2QVDP4OrrS8x31wlHPPpi4+8MJwVzup2I+cEXBeEdNdQCNPKX0WeEFYvSgvxj73SVjqYNsLWx6OQMS/8O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=s7hWuK7r; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="s7hWuK7r"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF9F240DEE
	for <virtualization@lists.linux-foundation.org>; Mon,  3 Mar 2025 06:20:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ts85hwS8ZAkJ for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Mar 2025 06:20:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A1F9240DE9
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A1F9240DE9
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=s7hWuK7r
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A1F9240DE9
	for <virtualization@lists.linux-foundation.org>; Mon,  3 Mar 2025 06:20:40 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-22185cddbffso83992745ad.1
        for <virtualization@lists.linux-foundation.org>; Sun, 02 Mar 2025 22:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1740982840; x=1741587640; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dyr2GA3li0orAMv11T62PbEJr2SsMfqcDoVbAywiFjQ=;
        b=s7hWuK7rgDmVoIhXB4tFu0Q0fLtqv7AUvanidMepjHZ4C5UPjcF3VNWjdjbZEnvo7b
         lNKCeBDw1SsjvzeyEcVpD+09AdvZuKQJq8gXP/a7sunt87wBpr51dVyetx/bq+j5reEr
         Mg+cpRLM4ALPhs23UOAhQIo0ukRXjhy4Y3mHD8FRS7VtHTS6xpzhoObxsQIv2sVZe1af
         Q84QPE4DqWT4MDBTzHmbGyr/crEoiafjACQ5L6VUHccIwFqFpaiMNNfZwQfdMPAbLbl/
         vB6ZPubcHeMySigK5FIdTrS0q0WeJK+vGs2N4xJN0ZoB4s2fjOPWm6oOAZSeFd42KReB
         KONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740982840; x=1741587640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dyr2GA3li0orAMv11T62PbEJr2SsMfqcDoVbAywiFjQ=;
        b=STdGq6KAR0zkFYtpXx1NaH5PHCCDTmYaBGgBvpEirJCQD7xVPVsp2qzBzPHrwKRuYx
         jjtzYz4CK5INBAn7HMP+mg46QPU2GB08+NnetvHdmXxr8Fl+BSuoyw3pLjSlwHqKMgu2
         0MtZM9iZCg0aT9r1S4A9bRBMQgICXyb6E1kfTTN+jRWKi7pith2JVNgIGYRNOnEdiBYz
         RuMwYNQdqJb0/gfoMuPMF1o7xNGfU5XArUAyEqInHRDVTDuUU0C7o6xDYWMWuectP19F
         wkYTR9RaHiIjzxKppfkxMuU6yp4Z//fEl6xn//sYnapU2EnGLikcgC48m8Y4+ibMv2DU
         iV5w==
X-Forwarded-Encrypted: i=1; AJvYcCWwNLzqG0eWRaNdCvZrROaW2/J5cN+m0px5BxFeX0ew0M1s5eGMIqthRGVYI3WX5nC3csyA6UKwl/qcESTOuA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxBy2Q4N+EkPc5Y/5GT1YtKYp42uuWQ/ywQLUmOSNJke4r0ofZW
	MC2dsOIqoqzFMaw9CHBJEidA5lqnvGge7KAqN2+7vWrssgugrPrp2VJYS/GfuWU=
X-Gm-Gg: ASbGncsIAGYTA02Nk7ffnvski6DlHlttek3GFBunTofq7Ms9MYEwyQBiR2/i/tTV7bT
	Y0jn5TbCVPbnDLLxtY64b1z3tYgn0wsSuD6148+ynB6yVR+PIKPVsZMFOL0tTbGtT6HC0KndrBC
	VFPXCOhwsBVSR8mkB8uphdsr32EDpklzJP4QqeHHQopcxC3kDVBvsEcigAVIML9eEEM0PXL537c
	ILp0DLT1zgWWKg8DnHlrh0ZVkGs+ZdtZC0Pv0r7vI8iicZtoxRyY86em8fV9LYapTq7Zkg25OC3
	0ycv4hfLOW1czshw++ozzYBE/ArF90uIciXVkR86/EUkr3PxQGYuqZG7XQ==
X-Google-Smtp-Source: AGHT+IEieq/BD1K+cE8LpIHguGq+X9OAmHwKGwyKh2uFq+hVqj0tth75vrcZnQUypyq8Bcdl5DillA==
X-Received: by 2002:aa7:8207:0:b0:734:26c6:26d3 with SMTP id d2e1a72fcca58-7349d1ec1a1mr23805966b3a.5.1740982838260;
        Sun, 02 Mar 2025 22:20:38 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736614c13dcsm414807b3a.42.2025.03.02.22.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 22:20:37 -0800 (PST)
Message-ID: <0ec77558-bdfb-4471-a44b-0a37a9422f72@daynix.com>
Date: Mon, 3 Mar 2025 15:20:33 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 5/6] selftest: tun: Add tests for virtio-net
 hashing
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 Lei Yang <leiyang@redhat.com>
References: <20250228-rss-v7-0-844205cbbdd6@daynix.com>
 <20250228-rss-v7-5-844205cbbdd6@daynix.com>
 <20250228062947.7864a59c@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250228062947.7864a59c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/02/28 23:29, Jakub Kicinski wrote:
> On Fri, 28 Feb 2025 16:58:51 +0900 Akihiko Odaki wrote:
>> The added tests confirm tun can perform RSS and hash reporting, and
>> reject invalid configurations for them.
> 
> The tests may benefit from using FIXTURE_VARIANT(), up to you.

I took a look at it after seeing your suggestion, but it is 
unfortunately not straightfoward to use FIXTURE_VARIANT() for them
so I'll leave it as is. The problem is that a packet for each test has a 
different type and requires different functions to construct.

Tests added in "[PATCH net-next v7 4/6] selftest: tun: Test vnet ioctls 
without device" are easier to adopt FIXTURE_VARIANT(), but one 
exceptional test case, which is for TUNGETVNETHASHCAP, does not fit well 
so I also keep the current form.

Thank you for your suggestion anyway.

> 
> The IPv4 tests fail reliably on a VM with a debug kernel
> (kernel/configs/debug.config included in the config):
> 
> # 5.90 [+0.00] ok 14 tun_vnet_hash.unclassified
> # 5.90 [+0.00] #  RUN           tun_vnet_hash.ipv4 ...
> # 6.18 [+0.28] # tun.c:669:ipv4:Expected 0 (0) != tun_vnet_hash_check(self->source_fd, self->dest_fds, &packet, sizeof(packet), 0, VIRTIO_NET_HASH_REPORT_IPv4, 0x6e45d952) (0)
> # 15.09 [+8.92] # ipv4: Test failed
> # 15.10 [+0.00] #          FAIL  tun_vnet_hash.ipv4
> # 15.10 [+0.00] not ok 15 tun_vnet_hash.ipv4
> # 15.10 [+0.00] #  RUN           tun_vnet_hash.tcpv4 ...
> # 15.36 [+0.26] # tun.c:689:tcpv4:Expected 0 (0) != tun_vnet_hash_check(self->source_fd, self->dest_fds, &packet, sizeof(packet), VIRTIO_NET_HDR_F_DATA_VALID, VIRTIO_NET_HASH_REPORT_TCPv4, 0xfb63539a) (0)
> # 24.76 [+9.40] # tcpv4: Test failed
> # 24.76 [+0.00] #          FAIL  tun_vnet_hash.tcpv4
> # 24.76 [+0.00] not ok 16 tun_vnet_hash.tcpv4
> # 24.77 [+0.00] #  RUN           tun_vnet_hash.udpv4 ...
> # 25.05 [+0.28] # tun.c:710:udpv4:Expected 0 (0) != tun_vnet_hash_check(self->source_fd, self->dest_fds, &packet, sizeof(packet), VIRTIO_NET_HDR_F_DATA_VALID, VIRTIO_NET_HASH_REPORT_UDPv4, 0xfb63539a) (0)
> # 32.11 [+7.06] # udpv4: Test failed
> # 32.11 [+0.00] #          FAIL  tun_vnet_hash.udpv4
> # 32.11 [+0.00] not ok 17 tun_vnet_hash.udpv4

I cannot reproduce the failure. What commit did you apply this patch 
series on? What architecture did the kernel run on?
