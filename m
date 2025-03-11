Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEF61E7C2F
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Mar 2025 06:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741673995; cv=none; b=sUKjVoFhoao/KxA/M8Hdk60vLbpmGE44rJDHsogg92o7C6Dh0fH/EY9hzdBR1nM8tGqVSlwVvb1aK2vC2nm5A5l/2VShd2QR5pjSN+FejfrW9BhTuMRbef2z/lzTt/f89yQ6657kHxAEPadsLrEvjZeZdgtkcLOZ6y/T+DCu8cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741673995; c=relaxed/simple;
	bh=ZP4EaVCBU43ETX1tsWfetopJ677SR8acZVhOJLrcrw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XWZh5loYjQPxUju5NmAYBM3zaCLyEaBZycwsYoD/sOjkXJeXkiEqk5r+M914t1aQ8P16EoCuZBU6czij2k12BeONEMPEJMQXIJVRlzO5PmbtFiT/w+b/ooqybjrKZq4235P8G8upAgl9rmsh2hz6EKMAHJPF/ZJYCBLInRYOLDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=qUfoHDcN; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="qUfoHDcN"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 20FEE81B17
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Mar 2025 06:19:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wTbvOEIFZA8k for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Mar 2025 06:19:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3786181325
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3786181325
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=qUfoHDcN
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3786181325
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Mar 2025 06:19:53 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2254e0b4b79so2243845ad.2
        for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 23:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741673992; x=1742278792; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EbcW5/eDAGhdpWi7HyX3jjOdHbLTgrUim/DP0OQGuWo=;
        b=qUfoHDcNDU0BL+dCQANFE5Ri9KXIG+7Er8l4eyY3N+NcEjgUt9WHRdct4wRO84weqR
         B9ZpfuL7gf6XMbR8TsLkHy+OLNT/TEZg+bVZsVLkF4mePSeVxmCg1cE63/5Ul2ai/9tu
         ytVaV7ufKOViIgoyRd4cdzgvgdvd35IFmLsb1nNiGXK35cAk9SJBEh+KeNLQ8bimGHuc
         ts0K6d+cOzqPBk5N/c9l8zjvjhbl5etW8A5tZk1+k4Tf//vGoJ9ZpE/hL+RFDHXmcjAH
         A7pZ7EFmxxEk2GtBDDmSgezVWzVoxXxV7+Z4w++eC4nAJUbk3L8wEvraWskp9GbthKbD
         jC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741673992; x=1742278792;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EbcW5/eDAGhdpWi7HyX3jjOdHbLTgrUim/DP0OQGuWo=;
        b=rRDy+cTNzHotm/1AWPtJxa4mfDryZX6oXpFJ/YYdXH2R6cZtyzf58NKtv1vNReX7Xo
         aDRoHxQK8MtgDYuyczLdOCdv67eaZlkzYzIJoH2zxPq/btH5kL56p1vinZD7zJ250rfn
         k23vHF5dz/IpmOOh0WyBghNhkZdAjXJEC3/4tO0mFpGKf5jxrJh7uv7QCnfndtEZjFWQ
         F9ahnEZv4dZlvTQrZKxL3YnIyucyS1WczgdfqLdDlfcsA8y3o6ZXftYCYaqR/s3YB+pR
         RbpmyikFFKcrqoNOh01CHgxiK8AdujmdarssT95cLRAVV3qHZ9dE5rlfFNL1pCBkXdk3
         hEzg==
X-Forwarded-Encrypted: i=1; AJvYcCVjTroTHq27o/NYoScYuPgsmfFzMtC3dTsGSrv9+7k+4eAlJQ4Tr7HFws5Hnz9Cc2aM8DmXRpREDYjPx3MQaA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yz5NTPtQM48t5rsO+iTl7vM6Nskj8MkG6qb0tedJnr5RMT5Q3zC
	JAoG57+WyovQsNnQ8XPzDxrCwX9Db84cf9cYrRQM9MPbUKtxCoXoLLQlyeNq3N4=
X-Gm-Gg: ASbGncuYSwwgPCuDf87uhA8Nb4lCNsn6zGsNop8ZwVsKZC2m9cofnbiCF72p3RDdh8Q
	Xf4Uc3w+/2w5tJoOHcgmVBzkEGf21+pCYdeQHQKeyHTVtAgp/nVCfEb90BNdhRj1mrW5k5itmrZ
	uB31d3Vlot2fbjUiKnjEwuhSt796k3RIVhrj+o9xi1lLUHKYsR8D+fIY0+/aYdc0ZbrQkk+oeYF
	55Dpn3Y2OY9ADJwWv+SW25jJw552ugXU4uy2fdY1DG+0XbaFwV0STF1/U94NCE1X8/ZPOcS5hPm
	dLEH7ra+nFNNJerdAjQG9oZL1TagOvit945XRfhIxw1TSDNFytauKAYmrw==
X-Google-Smtp-Source: AGHT+IEO1Addst46ofGtxfDAcyJAfRa7cWyZNqzRhdZXtyiIrODFKfx6qBjS5jqvhrfaOM+pKspNkg==
X-Received: by 2002:a17:902:e802:b0:223:26da:4b6f with SMTP id d9443c01a7336-22428895abfmr268969215ad.14.1741673992501;
        Mon, 10 Mar 2025 23:19:52 -0700 (PDT)
Received: from [157.82.205.237] ([157.82.205.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f5dasm89029115ad.137.2025.03.10.23.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 23:19:52 -0700 (PDT)
Message-ID: <217fb3ef-336d-4141-b47e-3236f2c22ec3@daynix.com>
Date: Tue, 11 Mar 2025 15:19:47 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 5/6] selftest: tun: Add tests for virtio-net
 hashing
To: Jason Wang <jasowang@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
References: <20250307-rss-v9-0-df76624025eb@daynix.com>
 <20250307-rss-v9-5-df76624025eb@daynix.com>
 <CACGkMEuTwd4+DP1Cb+ZgJtxTiJj4N_NMPHiKusd8a4Tn3+B_3A@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEuTwd4+DP1Cb+ZgJtxTiJj4N_NMPHiKusd8a4Tn3+B_3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/03/10 13:03, Jason Wang wrote:
> On Fri, Mar 7, 2025 at 7:02 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> The added tests confirm tun can perform RSS and hash reporting, and
>> reject invalid configurations for them.
> 
> Let's be more verbose here. E.g what's the network topology used here.

The network topology doesn't matter because this only tests the rx of 
one device.

I can still add more details; it tests all supported hash types, and 
tests both the queue selection and reported hash values.

And this message is wrong in terms that it does not test validation of 
configuration so it also needs correction.

> 
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Tested-by: Lei Yang <leiyang@redhat.com>
>> ---
>>   tools/testing/selftests/net/Makefile |   2 +-
>>   tools/testing/selftests/net/tun.c    | 584 ++++++++++++++++++++++++++++++++++-
>>   2 files changed, 576 insertions(+), 10 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
>> index 73ee88d6b043004be23b444de667a1d99a6045de..9772f691a9a011d99212df32463cdb930cf0a1a0 100644
>> --- a/tools/testing/selftests/net/Makefile
>> +++ b/tools/testing/selftests/net/Makefile
>> @@ -123,6 +123,6 @@ $(OUTPUT)/reuseport_bpf_numa: LDLIBS += -lnuma
>>   $(OUTPUT)/tcp_mmap: LDLIBS += -lpthread -lcrypto
>>   $(OUTPUT)/tcp_inq: LDLIBS += -lpthread
>>   $(OUTPUT)/bind_bhash: LDLIBS += -lpthread
>> -$(OUTPUT)/io_uring_zerocopy_tx: CFLAGS += -I../../../include/
>> +$(OUTPUT)/io_uring_zerocopy_tx $(OUTPUT)/tun: CFLAGS += -I../../../include/
>>
>>   include bpf.mk
>> diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
>> index 463dd98f2b80b1bdcb398cee43c834e7dc5cf784..acadeea7194eaea9416a605b47f99f7a5f1f80cd 100644
>> --- a/tools/testing/selftests/net/tun.c
>> +++ b/tools/testing/selftests/net/tun.c
>> @@ -2,21 +2,38 @@
>>
>>   #define _GNU_SOURCE
>>
>> +#include <endian.h>
>>   #include <errno.h>
>>   #include <fcntl.h>
>> +#include <sched.h>
> 
> Is this needed?

Yes, it is for unshare().

> 
>> +#include <stddef.h>
>>   #include <stdio.h>
>>   #include <stdlib.h>
>>   #include <string.h>
>>   #include <unistd.h>
>> -#include <linux/if.h>
>> +#include <net/if.h>
>> +#include <netinet/ip.h>
>> +#include <sys/ioctl.h>
>> +#include <sys/socket.h>
>> +#include <linux/compiler.h>
>> +#include <linux/icmp.h>
>> +#include <linux/if_arp.h>
>>   #include <linux/if_tun.h>
>> +#include <linux/ipv6.h>
>>   #include <linux/netlink.h>
>>   #include <linux/rtnetlink.h>
>> -#include <sys/ioctl.h>
>> -#include <sys/socket.h>
>> +#include <linux/sockios.h>
>> +#include <linux/tcp.h>
>> +#include <linux/udp.h>
>> +#include <linux/virtio_net.h>
>>
>>   #include "../kselftest_harness.h"
>>
>> +#define TUN_HWADDR_SOURCE { 0x02, 0x00, 0x00, 0x00, 0x00, 0x00 }
>> +#define TUN_HWADDR_DEST { 0x02, 0x00, 0x00, 0x00, 0x00, 0x01 }
>> +#define TUN_IPADDR_SOURCE htonl((172 << 24) | (17 << 16) | 0)
>> +#define TUN_IPADDR_DEST htonl((172 << 24) | (17 << 16) | 1)
>> +
>>   static int tun_attach(int fd, char *dev)
>>   {
>>          struct ifreq ifr;
>> @@ -39,7 +56,7 @@ static int tun_detach(int fd, char *dev)
>>          return ioctl(fd, TUNSETQUEUE, (void *) &ifr);
>>   }
>>
>> -static int tun_alloc(char *dev)
>> +static int tun_alloc(char *dev, short flags)
>>   {
>>          struct ifreq ifr;
>>          int fd, err;
>> @@ -52,7 +69,8 @@ static int tun_alloc(char *dev)
>>
>>          memset(&ifr, 0, sizeof(ifr));
>>          strcpy(ifr.ifr_name, dev);
>> -       ifr.ifr_flags = IFF_TAP | IFF_NAPI | IFF_MULTI_QUEUE;
>> +       ifr.ifr_flags = flags | IFF_TAP | IFF_NAPI | IFF_NO_PI |
>> +                       IFF_MULTI_QUEUE;
>>
>>          err = ioctl(fd, TUNSETIFF, (void *) &ifr);
>>          if (err < 0) {
>> @@ -64,6 +82,40 @@ static int tun_alloc(char *dev)
>>          return fd;
>>   }
>>
>> +static bool tun_add_to_bridge(int local_fd, const char *name)
>> +{
> 
> I wonder if a packet socket is more convenient here.

I'll try it. Thanks for suggestion.

Regards,
Akihiko Odaki

> 
> Thanks
> 

