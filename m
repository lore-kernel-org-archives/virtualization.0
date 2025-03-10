Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A422E1CD210
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 06:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741589632; cv=none; b=dXnKFwsWIh8OKh7m7wcP42FiJORPQLcikMAmwSrxsiI4C/Q1FSKaLsEmTSuC+msJ3mqlRZ8k6+Jz/H9czTe+BxYpjTkYxVFKeQHhdbRBFFqjka5FBXjijlGnWNnHMeeobtGgdlI1kZPYoH0mb5fD9Xkwu+tTdwkYIVAE9UWEpJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741589632; c=relaxed/simple;
	bh=+Mvd1cqrRnj2UJawDWZ/FNcD407yz19JVojDG3LwICQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVsN8n1aE7ba3c4T7C9AdzYS8n0JSYnyk8X164ksfsPTUD2buTJr/fzuIhqh9ZlF3Vk9yaaWNBD1R3gyLzTM0It/c6Rf71FMWE9kX+Gr5rN4b2Ib2XnURX8n9nF6WGL/G0W5r5Caz1K0uPAmgwg21jPrECJLcIsXJ/4e/zm1/pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=A/DTCe0c; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="A/DTCe0c"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26DF8608AD
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 06:53:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nLXFywWb8ODD for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Mar 2025 06:53:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org AED1F60887
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AED1F60887
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=A/DTCe0c
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AED1F60887
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 06:53:48 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2243803b776so53804495ad.0
        for <virtualization@lists.linux-foundation.org>; Sun, 09 Mar 2025 23:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741589628; x=1742194428; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V+lae8KNUZmIk784QUfpfzALekpSGimeXh+iOI8RB4k=;
        b=A/DTCe0cASmBRhGzu47y9Lm0Klf8u/OOFBwKZ0hUXKiJiWRgljaVaOrxs0D7nmMtSE
         /LP82c8TcVQNrzO9saTYtUm7/H6yTNMC7noYZcfBrZ8MuDBgJGrvhOY1obkzFgEJ7Aef
         4qxsSEQ6+Mr+45Vyspbnc1qqei8IScuKzparnyyR0qWhbkN/cCmN83tDX3qsnGigjfkC
         HrERORHLQEACNQpMUcpsfBKYIx2z4rRTE7pI21NB5p5LukGDr6pqPKZ+BcLgalfIs6is
         fNcBMKuxgUiVTMcHTwsidNtWLpsEs7fzBNzLR1TmCBdMWNHZ8lug8quy0lrxuzeFgx3f
         4WzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741589628; x=1742194428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+lae8KNUZmIk784QUfpfzALekpSGimeXh+iOI8RB4k=;
        b=Bg2UW9aAPq1wZDHttvf72dRA3Yzmxevoo/DEWjSF2sDYx3YZDbKhi5fTBq8ZdBpbbm
         whs75Q/fILL+uv1wCZwuFDGEI7n0GJ6eeA68cVmuKyZIXZUgbItBLzB545+WdpV3vSsE
         34k2TZQLXiaWplNkuq7uzhXg54D/ZJe2pSaq/Dx2pJkS8UznJTovVXk6lulSnLRGegk8
         txKG1r/ax5NpoLjWOZuEQAPVINgc2QXIY/2xGKowPbNQa+osy/fIYT8CGO08KT0OT6Tu
         oP/9Rh/kW8HhKFvtWswOyiesT03/KfKIqAsav16M2l6r59Db/zITjHIEpTnwP3KUm0cD
         uXEw==
X-Forwarded-Encrypted: i=1; AJvYcCVzgro/h6UQ8VDVSPKuCuT04iU1YAMcF5fdXioesBG1HPai9WHy8s3eGAzvbYWN874+bYp2ZQGtGI6H7rn7xA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyHr/mGE+MQRtRUtfFwSKw0TNKBKHWU2M+1mwwgwON4F0WhFzij
	hzPV6JMfNXeLHsIOQ60rQuKsozZBLvrKNG01rfQCTpeJhFr7FBBum5NN8ebLbm4=
X-Gm-Gg: ASbGncuf1M0X7BvkzvQ/tZaROQ8T1wMAj71ChngxkAlzicsx8tcM3nFmETbdI6bqM3K
	qsyGIiGt1mNGSOYCX1u7FU1GXLoRw0fDb1LzFhKNpoHHsOnjR8xUPzvEJaBrzE82tPx+8SBTZGu
	BWhMXpJVXKFvagQSNLDD3ynCEa0MhLKCGAWBeexMLZyW2d2MM8EPq6fTy6F3YONFekR7dRBk9RA
	zP2cMJ1/YC7FvW2w5xGFc5aSTKWaJ/n97WIggx2teJ14YvRCfCSDDrvvEdrr4ZlPABlNVRdMTUa
	8TUK/xDsIRgsYO+OXCKT+1YXElWVfHb3nSxbXa7eSg6LcDAy4eavnbbpx8S3uGTxXrGC
X-Google-Smtp-Source: AGHT+IGAt/lRGqcYffem3GLpt+BRgwl1EoyO59vlTzdj5PmOKfs6JEHAncR5g/o3gnY8IK7o4uVdYA==
X-Received: by 2002:a05:6a00:4b4a:b0:736:a8db:93b8 with SMTP id d2e1a72fcca58-736aa9b3970mr21535017b3a.3.1741589627912;
        Sun, 09 Mar 2025 23:53:47 -0700 (PDT)
Received: from [157.82.205.237] ([157.82.205.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736d6f48c17sm1428809b3a.3.2025.03.09.23.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Mar 2025 23:53:47 -0700 (PDT)
Message-ID: <2e27f18b-1fc9-433d-92e9-8b2e3b1b65dc@daynix.com>
Date: Mon, 10 Mar 2025 15:53:42 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 1/6] virtio_net: Add functions for hashing
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
 <20250307-rss-v9-1-df76624025eb@daynix.com>
 <CACGkMEvxkwe9OJRZPb7zz-sRfVpeuoYSz4c2kh9_jjtGbkb_qA@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEvxkwe9OJRZPb7zz-sRfVpeuoYSz4c2kh9_jjtGbkb_qA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/03/10 12:55, Jason Wang wrote:
> On Fri, Mar 7, 2025 at 7:01 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
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
>> index 02a9f4dc594d02372a6c1850cd600eff9d000d8d..426f33b4b82440d61b2af9fdc4c0b0d4c571b2c5 100644
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
> 
> Let's explain why
> 
> #define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
> #define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
> #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
> 
> are missed here.

Because they require parsing IPv6 options and I'm not sure how many we 
need to parse. QEMU's eBPF program has a hard-coded limit of 30 options; 
it has some explanation for this limit, but it does not seem definitive 
either:
https://gitlab.com/qemu-project/qemu/-/commit/f3fa412de28ae3cb31d38811d30a77e4e20456cc#6ec48fc8af2f802e92f5127425e845c4c213ff60_0_165

In this patch series, I add an ioctl to query capability instead; it 
allows me leaving those hash types unimplemented and is crucial to 
assure extensibility for future additions of hash types anyway. Anyone 
who find these hash types useful can implement in the future.

> 
> And explain how we could maintain migration compatibility
> 
> 1) Does those three work for userspace datapath in Qemu? If yes,
> migration will be broken.

They work for userspace datapath so my RFC patch series for QEMU uses 
TUNGETVNETHASHCAP to prevent breaking migration:
https://patchew.org/QEMU/20240915-hash-v3-0-79cb08d28647@daynix.com/

This patch series first adds configuration options for users to choose 
hash types. QEMU then automatically picks one implementation from the 
following (the earlier one is the more preferred):
1) The hash capability of vhost hardware
2) The hash capability I'm proposing here
3) The eBPF program
4) The pure userspace implementation

This decision depends on the following:
- The required hash types; supported ones are queried for 1) and 2)
- Whether vhost is enabled or not and what vhost backend is used
- Whether hash reporting is enabled; 3) is incompatible with this

The network device will not be realized if no implementation satisfies 
the requirements.

> 2) once we support those three in the future. For example, is the qemu
> expected to probe this via TUNGETVNETHASHCAP in the destination and
> fail the migration?

QEMU is expected to use TUNGETVNETHASHCAP, but it can selectively enable 
hash types with TUNSETVNETHASH to keep migration working.

In summary, this patch series provides a sufficient facility for the 
userspace to make extensibility and migration compatible; 
TUNGETVNETHASHCAP exposes all of the kernel capabilities and 
TUNSETVNETHASH allows the userspace to limit them.

Regards,
Akihiko Odaki

> 
> Thanks
> 
> 
> 
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
>> +       }
>> +
>> +       hash->value = toeplitz_state.hash;
>> +       hash->report = report;
>> +}
>> +
>>   static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
>>   {
>>          switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
>>
>> --
>> 2.48.1
>>
> 

