Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F87F8120C
	for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713525688; cv=none; b=Rn6f5ujWDVyylUusWyoXuD0GChHZl3v0JEfyGUYyD2fkgi/BC0xLPzOelXBE5dOWdCnGbPLwdnlmQmMZ0QAq7YBl+w/TDvLFzvM3HIeiR0ux488RLjIyaFh1x8OWMZlWgLSM3cK9lcv1ZS7zufO4HbXJkoutDplhaKwhMshCVQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713525688; c=relaxed/simple;
	bh=k9VcYFgyShcG1dhWPBt43rKEUHdDgANKGFJsHKd2Uok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fN8sNM5ZFuEYXlXkd2+D9lSPDrAL+BAg+w7Gv6dbOxxTfCsLzFNoucNUmiJdm5URsfaLdauqqft84NN2qf/U5CY9FC9IuKlpPIjL8VSDU3CzBHRAOzzG3llR7g1b8U9xCf+ToFxmtHABGAHuU+WWvxB0VwVdWQGTl/5iVDhasuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rx5bNxEN; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rx5bNxEN"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516d4d80d00so2402262e87.0
        for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 04:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713525685; x=1714130485; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oo5xMgK7A43edaSEKnYiqm0AuchtwStkZ/R1A6SoZFQ=;
        b=Rx5bNxEN9kwxMeNyJdrwdAbtCW2oArdQv53wK+evxGJrS7sD1PD74BtdxSrK8he5GW
         xuCHS460V/+u5yxZFxIFP1lR4eqxpc7ibgt1oo0dO0xPlCwjL/q9KDgNPTFfSSaUgDAT
         YDnCnvsxEa9CqdHGx5DpqodLzSg+2YQ+en7qG4diAarSTiJj3659KquUt58u92I/Z2Hh
         +lFRknfRnOSj2UwrnrzStNocqOIVbXksTH6y9C2x4wq8wFweOdnEtfb+ncqosij0Io3K
         LpaD/p2fcKj04vH9PfwnYQNBg8wuoe4SB9To7JLCljraYp61/EIILHtUTgAK6YmXTPFg
         kCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713525685; x=1714130485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oo5xMgK7A43edaSEKnYiqm0AuchtwStkZ/R1A6SoZFQ=;
        b=IAtynjJ+pGgbKa1AwP4afFVu/Y9F0RgI9UVnU0lMZMtdlQLV+THB+twPnhNx4YowPw
         GJ+5kiyXk7kH9C5f2Prnflv2BkOHre+hkKLS1pPme39hN0zIz0NTXLDMXjstvqi1e/V6
         6D0KrUYnaJ0obwUGarfrnM2CFTQQc1oqxdBznd2sP78i4vStwfni08BZxbXFNPFZPKoc
         h+lcA06Te+tzo5aNz2CaVGVUIru9ZZd2hjgyAgWWflyfw1aNIIJi9jOSiJvXD6DsHKnJ
         P/4rWGKhUyaAU/UlaE3FrjVoEmEHsV4LJZhJTdHnsxs+SV19/J82Ox+7fSFFK/owLUr5
         FD4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvOVCi/g07nY2EiPtbIcB2EVTSkztB9O+VWxru0EbHS9Z+Rt1sE92NVjuUF/DJOkja+gk0P0VLqMDZC3gdt0I9e4bTcgYvf6q4RDA3U5M=
X-Gm-Message-State: AOJu0YxCAwnZ9MlFCxbGQhpxo8iRaQjSBJaIObBcXViYzxux6jUhsTjA
	Wuj/+2ZyeUeZfsrDyEYPao/woMsMJb+zN/DN0OOinAYy4/l5TCvm
X-Google-Smtp-Source: AGHT+IEFY1gjmCiW7j8xVLYIyr8i8P2p4D1KfDmvOJjtfOhFv2qZUrBCLs8x/0cxV2+TI3RJGn8Yug==
X-Received: by 2002:a05:6512:ba0:b0:51a:b955:4014 with SMTP id b32-20020a0565120ba000b0051ab9554014mr1557073lfv.18.1713525685086;
        Fri, 19 Apr 2024 04:21:25 -0700 (PDT)
Received: from [192.168.42.27] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id hx11-20020a170906846b00b00a46d2e9fd73sm2076372ejc.222.2024.04.19.04.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 04:21:24 -0700 (PDT)
Message-ID: <0f6355d6-b563-458e-9671-ea7e047073e1@gmail.com>
Date: Fri, 19 Apr 2024 12:21:30 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH io_uring-next/net-next v2 0/4] implement io_uring
 notification (ubuf_info) stacking
To: io-uring@vger.kernel.org, netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org,
 "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev,
 kvm@vger.kernel.org
References: <cover.1713369317.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <cover.1713369317.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/19/24 12:08, Pavel Begunkov wrote:
> Please, don't take directly, conflicts with io_uring.

When everyone is happy with the patches, Jens and Jakub will hopefully
help to merge them. E.g. first staging net/ specific changes [1] and then
handling all conflicts on the io_uring side.

[1] https://github.com/isilence/linux.git iou-sendzc/notif-stacking-v2-netonly


> To have per request buffer notifications each zerocopy io_uring send
> request allocates a new ubuf_info. However, as an skb can carry only
> one uarg, it may force the stack to create many small skbs hurting
> performance in many ways.
> 
> The patchset implements notification, i.e. an io_uring's ubuf_info
> extension, stacking. It attempts to link ubuf_info's into a list,
> allowing to have multiple of them per skb.
> 
> liburing/examples/send-zerocopy shows up 6 times performance improvement
> for TCP with 4KB bytes per send, and levels it with MSG_ZEROCOPY. Without
> the patchset it requires much larger sends to utilise all potential.
> 
> bytes  | before | after (Kqps)
> 1200   | 195    | 1023
> 4000   | 193    | 1386
> 8000   | 154    | 1058
> 
> The patches are on top of net-next + io_uring-next:
> 
> https://github.com/isilence/linux.git iou-sendzc/notif-stacking-v2
> 
> First two patches based on net-next:
> 
> https://github.com/isilence/linux.git iou-sendzc/notif-stacking-v2-netonly
> 
> v2: convert xen-netback to ubuf_info_ops (patch 1)
>      drop two separately merged io_uring patches
> 
> Pavel Begunkov (4):
>    net: extend ubuf_info callback to ops structure
>    net: add callback for setting a ubuf_info to skb
>    io_uring/notif: simplify io_notif_flush()
>    io_uring/notif: implement notification stacking
> 
>   drivers/net/tap.c                   |  2 +-
>   drivers/net/tun.c                   |  2 +-
>   drivers/net/xen-netback/common.h    |  5 +-
>   drivers/net/xen-netback/interface.c |  2 +-
>   drivers/net/xen-netback/netback.c   | 11 ++--
>   drivers/vhost/net.c                 |  8 ++-
>   include/linux/skbuff.h              | 21 +++++---
>   io_uring/notif.c                    | 83 +++++++++++++++++++++++++----
>   io_uring/notif.h                    | 12 ++---
>   net/core/skbuff.c                   | 36 ++++++++-----
>   10 files changed, 134 insertions(+), 48 deletions(-)
> 

-- 
Pavel Begunkov
