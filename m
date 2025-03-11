Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F16C1E8359
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Mar 2025 05:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741672173; cv=none; b=oWzM0y9yXZkwlqOSX87SmrigItkWyDQNMtsbmuGMB3ZtqyGgWCFoD7jnk9x87y8UqXFRxk/kouv7ONrmguEiV3POtth26LAOT1KZQC9Km74LrAZGaA4idiFCRAGes1TmdwgcgQR4Rh+H9XliVUYQ//Lip/ckIbEEqlqdVFw4etc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741672173; c=relaxed/simple;
	bh=F0Rf3FYUQ4Wxm8G4IbbPPXs7ZUEyikrp1sTNtvxY1TE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G3qIgwfWk4ye3VTFozc9RxmgYq9+STH769bJa8hy1pq9IKtIPHUXzfrzIEiHW8LsjBnFjcpbRjkujHeLfPl6K8AQYu6X/pbPuq9eogYEqNmrKC5bd/wbSyhIVl2pEz3Dv+q+wxjYMKXpELkP44GgQBP46k9ilX/MURI9jTLyR84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=QHntytg3; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="QHntytg3"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED782605B7
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Mar 2025 05:49:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q5CZXfl95Nwy for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Mar 2025 05:49:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5B4EB6058D
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5B4EB6058D
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=QHntytg3
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5B4EB6058D
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Mar 2025 05:49:29 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-22403cbb47fso96118855ad.0
        for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 22:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741672168; x=1742276968; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xv/1UMDvxFGMa83/OozIAgX6ye/3HLjoIobJiWrJB+0=;
        b=QHntytg37kFVxlb2uFB8vNxEx/DULc5LXdxAWIFwa+w4ocpiP9sd9Sl079JtBZAo8r
         qTd3lhK5SfejJj12UAbbiBhvKSNc9zQppthisGFPzEf5Pqj6AodAyUOuuUNag7wDflmV
         G5F6+GoF1KgeTWVI7waErNuf0cI9gG7PhS3/RgrPwMM0fT3k8BXvxPkXBJDT9g2kMsCs
         EzjDbS+3VKLEuzqjalmV6Cm6wiWW/Wai/lTyVoXp1jnehLcFY5piqCe5i6ShrsptNAXZ
         YIK41YfEXa+EN7KbI8+XDxmNbi+eIFYOpqMycxARxK4qav5KtMLVznLw9+OVyJqA9tA7
         mgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741672168; x=1742276968;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xv/1UMDvxFGMa83/OozIAgX6ye/3HLjoIobJiWrJB+0=;
        b=wkP4RmOH2GIbxiCz6wLQRYvssXdcGummNYupgkH0OPDVmZJ59OMsSDxqYAfp5NHiLR
         oXTmnt/AsW9/gOY+k/pOJN8qcU8GtU+MY9UHjYg4cyx9YHyKlUvRJJ4GqWcjLlU5VvHJ
         dGexiTcA1j1LSAZ2QuAQuX8BHCMRJ0FR7jE5vW4emlmd9v6brpgs1uxCj0rSNjUEgv59
         WkdpkY9e3ianj7BRTpGHediP4mn9Du0fdspKjtUIpDKUpaPtBn3mBDZoB4Sa7noczvy6
         K5jyF25Oku9lh0U7ZQoRrBOKA09IXmIa93bXsXAiQK/qAq7WLwtfJpz2NTxi6eyUKyd1
         LY+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUj5tIQMJovH65adjmqOo2MrYfnyUKytRy9HixoAUqgxOzEB7oRTBUIK/CZRadbppZCGyI/Dpp/C01cymV9Fw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yzv4Z+wXnNBybWB38pxsj1SIBNPXi7UIlHbJmiL9HdlT6KyTmnK
	7uRUmA6qgLX6u645h91ZvkEAqTf5WBgb5hSD4BGEhCei4ky3AjZ0uBg3QO0zhl0=
X-Gm-Gg: ASbGnctZSz9NiTddy2bRcLnXZOYYEL298pc9sskjDXxheHytHVwr92dbRlNEH9q2WEq
	+ab3bnqQpNEB7qtt2Ft/Va1bnLcVhDh0UiS0uzSX8HRZIpxHh26tBfq7MG6ElR3R5tlcu27ZAke
	G5o6+v4ahxawvDw5vWtfC3Ad1DvX7wDyQDnY66nwQTAlGl/GiDyUMa4cl16ag3SSG1esNY0nsNT
	mMkl5SXrB/2IVNrggswthQh0tgoIiwYmwHAFx+JNyDNd23UVVHnps4cdzDjF9y8LmTQ5rlx0U1a
	7nkUoSoYTN3J/rzf2QA/+L0gmbAenEP7kgJVwXhd3R88YTy7Ul1/SnPzFA==
X-Google-Smtp-Source: AGHT+IFuMVZsqL3GM6lkFEYs2nSoWXK5nAJqtoL5n+wXoTsRqEscx8eUNzKeTyS2qcid35nO5n+Mtw==
X-Received: by 2002:a17:903:2405:b0:223:47b4:aaf8 with SMTP id d9443c01a7336-22428bf3ac4mr265245865ad.52.1741672168519;
        Mon, 10 Mar 2025 22:49:28 -0700 (PDT)
Received: from [157.82.205.237] ([157.82.205.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ff204sm88876015ad.104.2025.03.10.22.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 22:49:28 -0700 (PDT)
Message-ID: <26592324-c1f0-4ff5-918b-7a9366c4cf71@daynix.com>
Date: Tue, 11 Mar 2025 14:49:23 +0900
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
 <2e27f18b-1fc9-433d-92e9-8b2e3b1b65dc@daynix.com>
 <CACGkMEssbh0-BKJq7M=T1z9seMu==4OJzmDPU+HEx4OA95E3ng@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEssbh0-BKJq7M=T1z9seMu==4OJzmDPU+HEx4OA95E3ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/03/11 9:47, Jason Wang wrote:
> On Mon, Mar 10, 2025 at 2:53 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/03/10 12:55, Jason Wang wrote:
>>> On Fri, Mar 7, 2025 at 7:01 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> They are useful to implement VIRTIO_NET_F_RSS and
>>>> VIRTIO_NET_F_HASH_REPORT.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> Tested-by: Lei Yang <leiyang@redhat.com>
>>>> ---
>>>>    include/linux/virtio_net.h | 188 +++++++++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 188 insertions(+)
>>>>
>>>> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
>>>> index 02a9f4dc594d02372a6c1850cd600eff9d000d8d..426f33b4b82440d61b2af9fdc4c0b0d4c571b2c5 100644
>>>> --- a/include/linux/virtio_net.h
>>>> +++ b/include/linux/virtio_net.h
>>>> @@ -9,6 +9,194 @@
>>>>    #include <uapi/linux/tcp.h>
>>>>    #include <uapi/linux/virtio_net.h>
>>>>
>>>> +struct virtio_net_hash {
>>>> +       u32 value;
>>>> +       u16 report;
>>>> +};
>>>> +
>>>> +struct virtio_net_toeplitz_state {
>>>> +       u32 hash;
>>>> +       const u32 *key;
>>>> +};
>>>> +
>>>> +#define VIRTIO_NET_SUPPORTED_HASH_TYPES (VIRTIO_NET_RSS_HASH_TYPE_IPv4 | \
>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_TCPv4 | \
>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_UDPv4 | \
>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_IPv6 | \
>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_TCPv6 | \
>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_UDPv6)
>>>
>>> Let's explain why
>>>
>>> #define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
>>> #define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
>>> #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
>>>
>>> are missed here.
>>
>> Because they require parsing IPv6 options and I'm not sure how many we
>> need to parse. QEMU's eBPF program has a hard-coded limit of 30 options;
>> it has some explanation for this limit, but it does not seem definitive
>> either:
>> https://gitlab.com/qemu-project/qemu/-/commit/f3fa412de28ae3cb31d38811d30a77e4e20456cc#6ec48fc8af2f802e92f5127425e845c4c213ff60_0_165
>>
> 
> How about the usersapce datapath RSS in Qemu? (We probably don't need
> to align with eBPF RSS as it's just a reference implementation)

The userspace datapath RSS has no limit.

The reference implementation is the userspace datapath. The eBPF program 
  is intended to bring real performance benefit to Windows guests in 
contrary.

The userspace implementation does its best to provide defined RSS 
capabilities but may not be performant. Parsing all IPv6 options have a 
performance implication, but it is fine because it is not intended to be 
performant in the first place.

The performance problem is inherent to the userspace implementation, 
which adds an extra overhead to the datapath. The eBPF program on the 
other hand does not incur such overhead because it replaces the existing 
steering algorithm (automq) instead of adding another layer. Hence the 
eBPF program can be practical.

That said, it is not that important to align with the userspace and eBPF 
RSS in QEMU because they are still experimental anyway; the eBPF RSS has 
potential to become a practical implementation but it is still in 
development. The libvirt integration for the eBPF RSS is still not 
complete, and we occasionally add fixes for RSS and hash reporting 
without backporting to the stable branch.

I'm adding interfaces to negotiate hash types rather for the future 
extensibility. The specification may gain more hash types in the future 
and other vhost backends may have a different set of hash types 
supported. Figuring out how to deal with different sets of supported 
hash typs is essential for both the kernel and QEMU.

> 
>> In this patch series, I add an ioctl to query capability instead; it
>> allows me leaving those hash types unimplemented and is crucial to
>> assure extensibility for future additions of hash types anyway. Anyone
>> who find these hash types useful can implement in the future.
> 
> Yes, but we need to make sure no userspace visible behaviour changes
> after migration.

Indeed, the goal is to make extensibility and migration compatible.

> 
>>
>>>
>>> And explain how we could maintain migration compatibility
>>>
>>> 1) Does those three work for userspace datapath in Qemu? If yes,
>>> migration will be broken.
>>
>> They work for userspace datapath so my RFC patch series for QEMU uses
>> TUNGETVNETHASHCAP to prevent breaking migration:
>> https://patchew.org/QEMU/20240915-hash-v3-0-79cb08d28647@daynix.com/
>>
> 
> Ok, let's mention this in the cover letter. Another interesting thing
> is the migration from 10.0 to 9.0.

The patch series is already mentioned in the cover letter. A description 
of the intended use case of TUNGETVNETHASHCAP will be a good addition. 
I'll add it to this patch so that it will be kept in tree after it gets 
merged.

Migration between two different QEMU versions should be handled with 
versioned machine types.

When a machine created in 9.0 is being migrated to 10.0, the machine 
must set the hash type properties to match with the hash types supported 
by the existing implementations, which means it sets the property for 
VIRTIO_NET_HASH_REPORT_IPv6_EX to true, for example. Because this hash 
type is currently not included in TUNGETVNETHASHCAP, the machine will 
keep using the implementation used previously. The machine can be also 
migrated back to 9.0 again.

A machine type with version 10.0 cannot be migrated to 9.0 by design so 
there is no new problem.

> 
>> This patch series first adds configuration options for users to choose
>> hash types. QEMU then automatically picks one implementation from the
>> following (the earlier one is the more preferred):
>> 1) The hash capability of vhost hardware
>> 2) The hash capability I'm proposing here
>> 3) The eBPF program
>> 4) The pure userspace implementation
>>
>> This decision depends on the following:
>> - The required hash types; supported ones are queried for 1) and 2)
>> - Whether vhost is enabled or not and what vhost backend is used
>> - Whether hash reporting is enabled; 3) is incompatible with this
>>
>> The network device will not be realized if no implementation satisfies
>> the requirements.
> 
> This makes sense, let's add this in the cover letter.

I'll add it to the QEMU patch as it's more about details of QEMU.
The message of this patch will explain how TUNGETVNETHASHCAP and 
TUNSETVNETHASH makes extensibility and migrattion compatible in general.

Regards,
Akihiko Odaki

> 
>>
>>> 2) once we support those three in the future. For example, is the qemu
>>> expected to probe this via TUNGETVNETHASHCAP in the destination and
>>> fail the migration?
>>
>> QEMU is expected to use TUNGETVNETHASHCAP, but it can selectively enable
>> hash types with TUNSETVNETHASH to keep migration working.
>>
>> In summary, this patch series provides a sufficient facility for the
>> userspace to make extensibility and migration compatible;
>> TUNGETVNETHASHCAP exposes all of the kernel capabilities and
>> TUNSETVNETHASH allows the userspace to limit them.
>>
>> Regards,
>> Akihiko Odaki
> 
> Fine.
> 
> Thanks
> 
>>
>>>
>>> Thanks
>>>
>>>
>>>
>>>> +
>>>> +#define VIRTIO_NET_RSS_MAX_KEY_SIZE 40
>>>> +
>>>> +static inline void virtio_net_toeplitz_convert_key(u32 *input, size_t len)
>>>> +{
>>>> +       while (len >= sizeof(*input)) {
>>>> +               *input = be32_to_cpu((__force __be32)*input);
>>>> +               input++;
>>>> +               len -= sizeof(*input);
>>>> +       }
>>>> +}
>>>> +
>>>> +static inline void virtio_net_toeplitz_calc(struct virtio_net_toeplitz_state *state,
>>>> +                                           const __be32 *input, size_t len)
>>>> +{
>>>> +       while (len >= sizeof(*input)) {
>>>> +               for (u32 map = be32_to_cpu(*input); map; map &= (map - 1)) {
>>>> +                       u32 i = ffs(map);
>>>> +
>>>> +                       state->hash ^= state->key[0] << (32 - i) |
>>>> +                                      (u32)((u64)state->key[1] >> i);
>>>> +               }
>>>> +
>>>> +               state->key++;
>>>> +               input++;
>>>> +               len -= sizeof(*input);
>>>> +       }
>>>> +}
>>>> +
>>>> +static inline u8 virtio_net_hash_key_length(u32 types)
>>>> +{
>>>> +       size_t len = 0;
>>>> +
>>>> +       if (types & VIRTIO_NET_HASH_REPORT_IPv4)
>>>> +               len = max(len,
>>>> +                         sizeof(struct flow_dissector_key_ipv4_addrs));
>>>> +
>>>> +       if (types &
>>>> +           (VIRTIO_NET_HASH_REPORT_TCPv4 | VIRTIO_NET_HASH_REPORT_UDPv4))
>>>> +               len = max(len,
>>>> +                         sizeof(struct flow_dissector_key_ipv4_addrs) +
>>>> +                         sizeof(struct flow_dissector_key_ports));
>>>> +
>>>> +       if (types & VIRTIO_NET_HASH_REPORT_IPv6)
>>>> +               len = max(len,
>>>> +                         sizeof(struct flow_dissector_key_ipv6_addrs));
>>>> +
>>>> +       if (types &
>>>> +           (VIRTIO_NET_HASH_REPORT_TCPv6 | VIRTIO_NET_HASH_REPORT_UDPv6))
>>>> +               len = max(len,
>>>> +                         sizeof(struct flow_dissector_key_ipv6_addrs) +
>>>> +                         sizeof(struct flow_dissector_key_ports));
>>>> +
>>>> +       return len + sizeof(u32);
>>>> +}
>>>> +
>>>> +static inline u32 virtio_net_hash_report(u32 types,
>>>> +                                        const struct flow_keys_basic *keys)
>>>> +{
>>>> +       switch (keys->basic.n_proto) {
>>>> +       case cpu_to_be16(ETH_P_IP):
>>>> +               if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT)) {
>>>> +                       if (keys->basic.ip_proto == IPPROTO_TCP &&
>>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv4))
>>>> +                               return VIRTIO_NET_HASH_REPORT_TCPv4;
>>>> +
>>>> +                       if (keys->basic.ip_proto == IPPROTO_UDP &&
>>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv4))
>>>> +                               return VIRTIO_NET_HASH_REPORT_UDPv4;
>>>> +               }
>>>> +
>>>> +               if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv4)
>>>> +                       return VIRTIO_NET_HASH_REPORT_IPv4;
>>>> +
>>>> +               return VIRTIO_NET_HASH_REPORT_NONE;
>>>> +
>>>> +       case cpu_to_be16(ETH_P_IPV6):
>>>> +               if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT)) {
>>>> +                       if (keys->basic.ip_proto == IPPROTO_TCP &&
>>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv6))
>>>> +                               return VIRTIO_NET_HASH_REPORT_TCPv6;
>>>> +
>>>> +                       if (keys->basic.ip_proto == IPPROTO_UDP &&
>>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv6))
>>>> +                               return VIRTIO_NET_HASH_REPORT_UDPv6;
>>>> +               }
>>>> +
>>>> +               if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv6)
>>>> +                       return VIRTIO_NET_HASH_REPORT_IPv6;
>>>> +
>>>> +               return VIRTIO_NET_HASH_REPORT_NONE;
>>>> +
>>>> +       default:
>>>> +               return VIRTIO_NET_HASH_REPORT_NONE;
>>>> +       }
>>>> +}
>>>> +
>>>> +static inline void virtio_net_hash_rss(const struct sk_buff *skb,
>>>> +                                      u32 types, const u32 *key,
>>>> +                                      struct virtio_net_hash *hash)
>>>> +{
>>>> +       struct virtio_net_toeplitz_state toeplitz_state = { .key = key };
>>>> +       struct flow_keys flow;
>>>> +       struct flow_keys_basic flow_basic;
>>>> +       u16 report;
>>>> +
>>>> +       if (!skb_flow_dissect_flow_keys(skb, &flow, 0)) {
>>>> +               hash->report = VIRTIO_NET_HASH_REPORT_NONE;
>>>> +               return;
>>>> +       }
>>>> +
>>>> +       flow_basic = (struct flow_keys_basic) {
>>>> +               .control = flow.control,
>>>> +               .basic = flow.basic
>>>> +       };
>>>> +
>>>> +       report = virtio_net_hash_report(types, &flow_basic);
>>>> +
>>>> +       switch (report) {
>>>> +       case VIRTIO_NET_HASH_REPORT_IPv4:
>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>>>> +                                        (__be32 *)&flow.addrs.v4addrs,
>>>> +                                        sizeof(flow.addrs.v4addrs));
>>>> +               break;
>>>> +
>>>> +       case VIRTIO_NET_HASH_REPORT_TCPv4:
>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>>>> +                                        (__be32 *)&flow.addrs.v4addrs,
>>>> +                                        sizeof(flow.addrs.v4addrs));
>>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
>>>> +                                        sizeof(flow.ports.ports));
>>>> +               break;
>>>> +
>>>> +       case VIRTIO_NET_HASH_REPORT_UDPv4:
>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>>>> +                                        (__be32 *)&flow.addrs.v4addrs,
>>>> +                                        sizeof(flow.addrs.v4addrs));
>>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
>>>> +                                        sizeof(flow.ports.ports));
>>>> +               break;
>>>> +
>>>> +       case VIRTIO_NET_HASH_REPORT_IPv6:
>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>>>> +                                        (__be32 *)&flow.addrs.v6addrs,
>>>> +                                        sizeof(flow.addrs.v6addrs));
>>>> +               break;
>>>> +
>>>> +       case VIRTIO_NET_HASH_REPORT_TCPv6:
>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>>>> +                                        (__be32 *)&flow.addrs.v6addrs,
>>>> +                                        sizeof(flow.addrs.v6addrs));
>>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
>>>> +                                        sizeof(flow.ports.ports));
>>>> +               break;
>>>> +
>>>> +       case VIRTIO_NET_HASH_REPORT_UDPv6:
>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>>>> +                                        (__be32 *)&flow.addrs.v6addrs,
>>>> +                                        sizeof(flow.addrs.v6addrs));
>>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
>>>> +                                        sizeof(flow.ports.ports));
>>>> +               break;
>>>> +
>>>> +       default:
>>>> +               hash->report = VIRTIO_NET_HASH_REPORT_NONE;
>>>> +               return;
>>>> +       }
>>>> +
>>>> +       hash->value = toeplitz_state.hash;
>>>> +       hash->report = report;
>>>> +}
>>>> +
>>>>    static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
>>>>    {
>>>>           switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
>>>>
>>>> --
>>>> 2.48.1
>>>>
>>>
>>
> 

