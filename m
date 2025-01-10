Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BD220CCC7
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502492; cv=none; b=Um92LCb4Npj2NFk6OrHLi6A1GWGvkLe2VLaJoAEqyVS2nDSEFaPhqq0e70lZ4LoSFrXkDvcgTC9hs2qEGhTLLNnFMFB9Anxx+23uwgjk+SUGfvmx8jHpcXS8c3ZYSkW7qSxxLNyAsNTpy4e0hHc/1BFRbkIwpsFsyHtC5T1g7/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502492; c=relaxed/simple;
	bh=kVRbfJjqPGz8mIX7HYr5rAjUJTIc7wg/ASHsghAXszw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HGCaK7kv9dM6lPYrV4GtEdDREnnS1D/lbCD5nzXuSltZ1U1/E2PrffUxBaWLVtnZQYng61a/ZJwtDx5OWSJCPjoAnvJU5oJTlNj6XDfhu8/1MkZIjULpXD+P5iLQEdo2iTTQ+RBsdRNdUfZKH9SkqvDkNsBKWyg5P+b7CJdAedI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=zMDKcr9O; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="zMDKcr9O"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92C7460B57
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 09:48:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RABjoOELSix8 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Jan 2025 09:48:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 974506067A
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 974506067A
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=zMDKcr9O
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 974506067A
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 09:48:03 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2f13acbe29bso4485788a91.1
        for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 01:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736502483; x=1737107283; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=32Vr4Gt1G1myfrpAERq6AqxVOpF64+scMP61EbgQiWY=;
        b=zMDKcr9OFoAM+NMVuEsJaIia0Z5xOlwveJdgYybsLranWbeDsZG+9Ry+U28+4Pk+s8
         5Wkl+Ee+gwe9Aa2UNvyMZSKBLkPIzzaJPV65SeCgPzYfmuo0KpS7jm3HzkL4q/3hwE01
         ksR/DJoX9zav9UqN0Jd1Y72su30WeXEv68D8m0tiX8JhkcQ+8mDtyefymAt/mKReQjud
         0/LsBfNqpWSR2TqfGX4xAIdU+la99uizAELGE9+rAxCZRdxzuCM5zAw7BRI5He7Ku8qj
         kfxuoDcGXfM2iNugRb/8X8pHlZPqTzL6C0Jr2CmHoUBQz76QI0An1sftbYGXBJReR9cd
         RwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736502483; x=1737107283;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=32Vr4Gt1G1myfrpAERq6AqxVOpF64+scMP61EbgQiWY=;
        b=bqd2IT/+/C0W6qoDQDHJjMUwbjNuJhPd9/K7kipFiz7YqCGS91/proARMHMpQiMC2A
         MrBXLeszKGdRu1ugtNvE7twnPAMICntEcsOWc+YO8UsMW/O5/OXF6l6JxZsSo5/4XDB8
         kvQ4eY/uxvBZzfARtqjnnY7tDkVN7WrKFDIrfk0jnyB27hVv9cauU2/OX1rKT+RY8pQv
         UvL9TTKK6SZWVWe7qQTelXe23F9i8xN4cPkZyTsEyGfaKne1sTaigfCRMMNt6zlzBfuH
         JnbFNu9r6eqXtWDHdURRwRpEyxmqMG+VCkJ+CaxivcpeQWgUZBLCnsxd33YUsjYDB9s2
         eA+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1NZ3pP44yNp6BkFqcrNvjkHY3ANXd+/JR5TwxFl3gnNzzUvSatZ19v+xTrziCjaZ8dPbskaF6pVXb6/cJrQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxFYfDmgq8LvS3/5lWmzGz+oBa4UhGVBy485NszfXStlkVNaKcc
	fKg3UbnNC+e8B23Efn2xHXuAYtQkWIoq/sGs/4MYxHcrz2AYwHaV6CjPR8r7qsg=
X-Gm-Gg: ASbGncuFK/pHg8R/49Lz7TsNp90N8UlesITXt3GLeygDfz890Mm/LUnNEKojHeKsk6p
	IrjNXfOTp9Uo8YG3HASCft5BvECa+hLXekjkCuvmp4fZkfVl7pXJXB6y57/880s46WBgTJXDE8h
	GaNywhoAxHeWwu7CqvE4h3cUw2ee0UeWvXz6vUWBiwmCXgpwIeR37/QPLcPghe8jXyTJH9DJ8Lm
	HafzSoazuyQQK9T6LvpnkxOJZBR0iPNXAGAkN+UFjYNmTgdpTMDd/axeMO1BkmOuwM=
X-Google-Smtp-Source: AGHT+IG4bZICCGUJL8IFrqqswdhSk8TqvGQUJNKkxBrtJDASy/wZzUeIl0i4xzyDL1lhN+MfLWTweA==
X-Received: by 2002:a17:90a:d448:b0:2ee:c30f:33c9 with SMTP id 98e67ed59e1d1-2f55838d0eamr8537569a91.14.1736502482736;
        Fri, 10 Jan 2025 01:48:02 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f12f94asm10822555ad.72.2025.01.10.01.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 01:48:02 -0800 (PST)
Message-ID: <b645e3e3-b42a-4d7a-b5f1-8f8fd9eff0ee@daynix.com>
Date: Fri, 10 Jan 2025 18:47:56 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] selftest: tun: Add tests for virtio-net hashing
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com
References: <20250109-rss-v6-0-b1c90ad708f6@daynix.com>
 <20250109-rss-v6-5-b1c90ad708f6@daynix.com>
 <677fdee2b56d_362bc129446@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <677fdee2b56d_362bc129446@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/01/09 23:36, Willem de Bruijn wrote:
> Akihiko Odaki wrote:
>> The added tests confirm tun can perform RSS and hash reporting, and
>> reject invalid configurations for them.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   tools/testing/selftests/net/Makefile |   2 +-
>>   tools/testing/selftests/net/tun.c    | 558 ++++++++++++++++++++++++++++++++++-
>>   2 files changed, 551 insertions(+), 9 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
>> index cb2fc601de66..92762ce3ebd4 100644
>> --- a/tools/testing/selftests/net/Makefile
>> +++ b/tools/testing/selftests/net/Makefile
>> @@ -121,6 +121,6 @@ $(OUTPUT)/reuseport_bpf_numa: LDLIBS += -lnuma
>>   $(OUTPUT)/tcp_mmap: LDLIBS += -lpthread -lcrypto
>>   $(OUTPUT)/tcp_inq: LDLIBS += -lpthread
>>   $(OUTPUT)/bind_bhash: LDLIBS += -lpthread
>> -$(OUTPUT)/io_uring_zerocopy_tx: CFLAGS += -I../../../include/
>> +$(OUTPUT)/io_uring_zerocopy_tx $(OUTPUT)/tun: CFLAGS += -I../../../include/
>>   
>>   include bpf.mk
>> diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
>> index 463dd98f2b80..9424d897e341 100644
>> --- a/tools/testing/selftests/net/tun.c
>> +++ b/tools/testing/selftests/net/tun.c
>> @@ -2,21 +2,37 @@
>>   
>>   #define _GNU_SOURCE
>>   
>> +#include <endian.h>
>>   #include <errno.h>
>>   #include <fcntl.h>
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
> 
> Are all these include changes strictly needed? Iff so, might as well
> fix ordering to be alphabetical (lexicographic).
>    

Yes. I placed header files in linux/ after the other header files 
because include/uapi/linux/libc-compat.h requires libc header files to 
be placed before linux/ ones.
