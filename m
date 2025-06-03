Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D56913B293
	for <virtualization@lists.linux-foundation.org>; Tue,  3 Jun 2025 05:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748928694; cv=none; b=dLA5onNJ89EfNySL6KxrC8NviIWzYpDPgnKWbgjOSYlf5qbNwdhKFJHuaM606A+x7NnYEYtrbaltEBlHpvqTScBrgWoFJJc7oU7E0wkCisG7+dD7AWFUEms7NWzi/hHKNvaEJqDVPBnhJ30kswdmr9ZXQcMGLXeU0NzwUCN/lVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748928694; c=relaxed/simple;
	bh=ned500yeZ+fotJTle6hKqUkOI4+MtDNWmZ73eMxCpM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UwGVjektd0BEJPYHJz67bRV5X1BGcqOp+frnLHfBX3KflJ4USQd3m+Rln3rdfaG0KFaFRyNGbr3CRnZeeNnsRDZwgTUVbq6QJuV1LZWt4BW8Lrh2y9EllSwiISxgu4ty6A3KigPNA0k/5Lp6vsbbe4lsFjF4CzJpuX4uos8AZuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=OOUaEHhM; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="OOUaEHhM"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9961B40790
	for <virtualization@lists.linux-foundation.org>; Tue,  3 Jun 2025 05:31:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EgmLJtFq3coY for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Jun 2025 05:31:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 59E2440777
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 59E2440777
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=OOUaEHhM
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 59E2440777
	for <virtualization@lists.linux-foundation.org>; Tue,  3 Jun 2025 05:31:31 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-22c33677183so40915475ad.2
        for <virtualization@lists.linux-foundation.org>; Mon, 02 Jun 2025 22:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748928690; x=1749533490; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Th/HvjGvwZaAq8NqcJZl3dUrBp6q2rEKCyly2o0Sv+A=;
        b=OOUaEHhM27trpXaODHL4JtPe9v0ljbgGAUg4Kz4tUGjvGqUBCdhrSIs8C1Oi3oQQzU
         g8E7uIOFliM0QCUUFO0IVAzr/v3vLpYwB7Eq7W/3sSp/g0ZASDm862oE0KwFOnkC7XrK
         l3gDosonjqO+mwRrRUQXvXpecWj8OkeJzCaVaWGmorRg63Tky7r8eqoTKxNwVG1N/JTk
         Kzp7kEW8HlxgyeYJII0RIJIXpB/Y9/cCReclwVYUw0aPUdyRXrAExI2wwe4h2H6XHKxn
         R4d1WqrOU8eDQfUT576eGb7oszqJZ/kPPTQeUOLfHw7U5Nn3xfpykGkBi6mTtHV/8em/
         eNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748928690; x=1749533490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Th/HvjGvwZaAq8NqcJZl3dUrBp6q2rEKCyly2o0Sv+A=;
        b=MNKyQtlCelHtBnnqG9DaewMNKdXEDJ2J9aPQjKuidDv+WXcujRmpkMqdVhNqcjB23R
         YMgQ5ukKIfpNLYDVIUIXo26V1OXLEvjo16gxZF1LKix3EIa8wsgdR7nWvDqEB/NgkEwL
         mT2sg4S4HnE7tHNdJfe9v0YlMBYk3j8ZIUJ+B1aVRHjuS+i+GIZNzA0iupaLhTru1Dpx
         84BSFyLBZs9ZDlDZymdhsKmdKHHRpCxLdGOixeL1wgaYOmBpRbJT7aUCxc6svkq8Mdai
         HequIcLwoUtofOMKbhSUDLWzixQSBv23LUn/Rc4OhlRfbGUX5p18qN9IiFLmOMNedhgB
         QqGA==
X-Forwarded-Encrypted: i=1; AJvYcCUbTN9yR1UxaU88T8380HgK3QFE653Qtty7wD2e8O2bUCgttZv0DUjp6tgFYNzqA7T6uhXw7L0raPfIuMXqsA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxIuMUf352szW/9s2n3WKKsSPj8Xv/U0NJ/W1nk4QDWTmBKwlte
	mVuFTQtUUrEh5pa37/t8XuwR1CpCo2Jno35JMMkA51KmgCGBzZ4ZFa2Quk3i/NrkLfs=
X-Gm-Gg: ASbGnctl9IF3KKiemn9g+1cOGi4bp2dZnQk+vke4t6z/7QIbEvM6ElopNl6t12BBvIa
	4HSus1Zv7u1GPNX/JAWbWFyDdDBArGL1KSQgAp0qXRAtFwtjvcJBsSPbv/pyFUIZgFbpLH7ZpND
	AjMWqsTTSbwjvpHBcfM1JrwrCq2Ouw3g/GMfZPXaY+JmS/TkxNE9rtNNbj3Or5EzLMwBqbSjHTp
	3icHGcy8bZsy9vwXjwBVlQ2NNvnN793puhsUHZP8z18x2cmNnNaPZleC/JQL/5kuolMzf+52uhg
	BYZRBi8QCyyQbju5fLNNW9wPBiHqreSxyfBe2HZmlCv9/yjkWngfBrGPuOCvBA==
X-Google-Smtp-Source: AGHT+IHQJUSAAIT0Fv7mF4IgGNvQJWS+3RmfojKIUZALdSibOD1WAD0IIfhREMwYdds3jC/NKwKN/Q==
X-Received: by 2002:a17:903:60b:b0:234:f580:9fe with SMTP id d9443c01a7336-23539647997mr154749915ad.49.1748928690493;
        Mon, 02 Jun 2025 22:31:30 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-235c99ea09esm5054615ad.226.2025.06.02.22.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 22:31:30 -0700 (PDT)
Message-ID: <95cb2640-570d-4f51-8775-af5248c6bc5a@daynix.com>
Date: Tue, 3 Jun 2025 14:31:24 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 01/10] virtio_net: Add functions for hashing
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
References: <20250530-rss-v12-0-95d8b348de91@daynix.com>
 <20250530-rss-v12-1-95d8b348de91@daynix.com>
 <CACGkMEufffSj1GQMqwf598__-JgNtXRpyvsLtjSbr3angLmJXg@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEufffSj1GQMqwf598__-JgNtXRpyvsLtjSbr3angLmJXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/06/03 12:19, Jason Wang wrote:
> On Fri, May 30, 2025 at 12:50 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> They are useful to implement VIRTIO_NET_F_RSS and
>> VIRTIO_NET_F_HASH_REPORT.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Tested-by: Lei Yang <leiyang@redhat.com>
>> ---
>>   include/linux/virtio_net.h | 188 +++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 188 insertions(+)
>>
>> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
>> index 02a9f4dc594d..426f33b4b824 100644
>> --- a/include/linux/virtio_net.h
>> +++ b/include/linux/virtio_net.h
>> @@ -9,6 +9,194 @@
>>   #include <uapi/linux/tcp.h>
>>   #include <uapi/linux/virtio_net.h>
>>
>> +struct virtio_net_hash {
>> +       u32 value;
>> +       u16 report;
>> +};
>> +
>> +struct virtio_net_toeplitz_state {
>> +       u32 hash;
>> +       const u32 *key;
>> +};
>> +
>> +#define VIRTIO_NET_SUPPORTED_HASH_TYPES (VIRTIO_NET_RSS_HASH_TYPE_IPv4 | \
>> +                                        VIRTIO_NET_RSS_HASH_TYPE_TCPv4 | \
>> +                                        VIRTIO_NET_RSS_HASH_TYPE_UDPv4 | \
>> +                                        VIRTIO_NET_RSS_HASH_TYPE_IPv6 | \
>> +                                        VIRTIO_NET_RSS_HASH_TYPE_TCPv6 | \
>> +                                        VIRTIO_NET_RSS_HASH_TYPE_UDPv6)
>> +
>> +#define VIRTIO_NET_RSS_MAX_KEY_SIZE 40
>> +
>> +static inline void virtio_net_toeplitz_convert_key(u32 *input, size_t len)
>> +{
>> +       while (len >= sizeof(*input)) {
>> +               *input = be32_to_cpu((__force __be32)*input);
>> +               input++;
>> +               len -= sizeof(*input);
>> +       }
>> +}
>> +
>> +static inline void virtio_net_toeplitz_calc(struct virtio_net_toeplitz_state *state,
>> +                                           const __be32 *input, size_t len)
>> +{
>> +       while (len >= sizeof(*input)) {
>> +               for (u32 map = be32_to_cpu(*input); map; map &= (map - 1)) {
>> +                       u32 i = ffs(map);
>> +
>> +                       state->hash ^= state->key[0] << (32 - i) |
>> +                                      (u32)((u64)state->key[1] >> i);
>> +               }
>> +
>> +               state->key++;
>> +               input++;
>> +               len -= sizeof(*input);
>> +       }
>> +}
>> +
>> +static inline u8 virtio_net_hash_key_length(u32 types)
>> +{
>> +       size_t len = 0;
>> +
>> +       if (types & VIRTIO_NET_HASH_REPORT_IPv4)
>> +               len = max(len,
>> +                         sizeof(struct flow_dissector_key_ipv4_addrs));
>> +
>> +       if (types &
>> +           (VIRTIO_NET_HASH_REPORT_TCPv4 | VIRTIO_NET_HASH_REPORT_UDPv4))
>> +               len = max(len,
>> +                         sizeof(struct flow_dissector_key_ipv4_addrs) +
>> +                         sizeof(struct flow_dissector_key_ports));
>> +
>> +       if (types & VIRTIO_NET_HASH_REPORT_IPv6)
>> +               len = max(len,
>> +                         sizeof(struct flow_dissector_key_ipv6_addrs));
>> +
>> +       if (types &
>> +           (VIRTIO_NET_HASH_REPORT_TCPv6 | VIRTIO_NET_HASH_REPORT_UDPv6))
>> +               len = max(len,
>> +                         sizeof(struct flow_dissector_key_ipv6_addrs) +
>> +                         sizeof(struct flow_dissector_key_ports));
>> +
>> +       return len + sizeof(u32);
>> +}
>> +
>> +static inline u32 virtio_net_hash_report(u32 types,
>> +                                        const struct flow_keys_basic *keys)
>> +{
>> +       switch (keys->basic.n_proto) {
>> +       case cpu_to_be16(ETH_P_IP):
>> +               if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT)) {
>> +                       if (keys->basic.ip_proto == IPPROTO_TCP &&
>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv4))
>> +                               return VIRTIO_NET_HASH_REPORT_TCPv4;
>> +
>> +                       if (keys->basic.ip_proto == IPPROTO_UDP &&
>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv4))
>> +                               return VIRTIO_NET_HASH_REPORT_UDPv4;
>> +               }
>> +
>> +               if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv4)
>> +                       return VIRTIO_NET_HASH_REPORT_IPv4;
>> +
>> +               return VIRTIO_NET_HASH_REPORT_NONE;
>> +
>> +       case cpu_to_be16(ETH_P_IPV6):
>> +               if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT)) {
>> +                       if (keys->basic.ip_proto == IPPROTO_TCP &&
>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv6))
>> +                               return VIRTIO_NET_HASH_REPORT_TCPv6;
>> +
>> +                       if (keys->basic.ip_proto == IPPROTO_UDP &&
>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv6))
>> +                               return VIRTIO_NET_HASH_REPORT_UDPv6;
>> +               }
>> +
>> +               if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv6)
>> +                       return VIRTIO_NET_HASH_REPORT_IPv6;
>> +
>> +               return VIRTIO_NET_HASH_REPORT_NONE;
>> +
>> +       default:
>> +               return VIRTIO_NET_HASH_REPORT_NONE;
>> +       }
>> +}
>> +
>> +static inline void virtio_net_hash_rss(const struct sk_buff *skb,
>> +                                      u32 types, const u32 *key,
>> +                                      struct virtio_net_hash *hash)
>> +{
>> +       struct virtio_net_toeplitz_state toeplitz_state = { .key = key };
>> +       struct flow_keys flow;
>> +       struct flow_keys_basic flow_basic;
>> +       u16 report;
>> +
>> +       if (!skb_flow_dissect_flow_keys(skb, &flow, 0)) {
>> +               hash->report = VIRTIO_NET_HASH_REPORT_NONE;
>> +               return;
>> +       }
>> +
>> +       flow_basic = (struct flow_keys_basic) {
>> +               .control = flow.control,
>> +               .basic = flow.basic
>> +       };
>> +
>> +       report = virtio_net_hash_report(types, &flow_basic);
>> +
>> +       switch (report) {
>> +       case VIRTIO_NET_HASH_REPORT_IPv4:
>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>> +                                        (__be32 *)&flow.addrs.v4addrs,
>> +                                        sizeof(flow.addrs.v4addrs));
>> +               break;
>> +
>> +       case VIRTIO_NET_HASH_REPORT_TCPv4:
>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>> +                                        (__be32 *)&flow.addrs.v4addrs,
>> +                                        sizeof(flow.addrs.v4addrs));
>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
>> +                                        sizeof(flow.ports.ports));
>> +               break;
>> +
>> +       case VIRTIO_NET_HASH_REPORT_UDPv4:
>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>> +                                        (__be32 *)&flow.addrs.v4addrs,
>> +                                        sizeof(flow.addrs.v4addrs));
>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
>> +                                        sizeof(flow.ports.ports));
>> +               break;
>> +
>> +       case VIRTIO_NET_HASH_REPORT_IPv6:
>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>> +                                        (__be32 *)&flow.addrs.v6addrs,
>> +                                        sizeof(flow.addrs.v6addrs));
>> +               break;
>> +
>> +       case VIRTIO_NET_HASH_REPORT_TCPv6:
>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>> +                                        (__be32 *)&flow.addrs.v6addrs,
>> +                                        sizeof(flow.addrs.v6addrs));
>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
>> +                                        sizeof(flow.ports.ports));
>> +               break;
>> +
>> +       case VIRTIO_NET_HASH_REPORT_UDPv6:
>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>> +                                        (__be32 *)&flow.addrs.v6addrs,
>> +                                        sizeof(flow.addrs.v6addrs));
>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
>> +                                        sizeof(flow.ports.ports));
>> +               break;
>> +
>> +       default:
>> +               hash->report = VIRTIO_NET_HASH_REPORT_NONE;
>> +               return;
> 
> So I still think we need a comment here to explain why this is not an
> issue if the device can report HASH_XXX_EX. Or we need to add the
> support, since this is the code from the driver side, I don't think we
> need to worry about the device implementation issues.

This is on the device side, and don't report HASH_TYPE_XXX_EX.

> 
> For the issue of the number of options, does the spec forbid fallback
> to VIRTIO_NET_HASH_REPORT_NONE? If not, we can do that.

5.1.6.4.3.4 "IPv6 packets with extension header" says:
 > If VIRTIO_NET_HASH_TYPE_TCP_EX is set and the packet has a TCPv6
 > header, the hash is calculated over the following fields:
 > - Home address from the home address option in the IPv6 destination
 >   options header. If the extension header is not present, use the
 >   Source IPv6 address.
 > - IPv6 address that is contained in the Routing-Header-Type-2 from the
 >   associated extension header. If the extension header is not present,
 >   use the Destination IPv6 address.
 > - Source TCP port
 > - Destination TCP port

Therefore, if VIRTIO_NET_HASH_TYPE_TCP_EX is set, the packet has a TCPv6 
and an home address option in the IPv6 destination options header is 
present, the hash is calculated over the home address. If the hash is 
not calculated over the home address in such a case, the device is 
contradicting with this section and violating the spec. The same goes 
for the other HASH_TYPE_XXX_EX types and Routing-Header-Type-2.

Regards,
Akihiko Odaki
