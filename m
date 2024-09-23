Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CA717548
	for <virtualization@lists.linux-foundation.org>; Mon, 23 Sep 2024 18:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727115354; cv=none; b=s5C91ZdhqBfXPs1I054EbI9B15sgYWYNZxMv0oshTaLLIlyPCDiNMmJrWoWRzyOsAZx389CWNugDr+jTkfwyuEhD9rqXIFrLG5gOXvJORgbvnIFnsxH8dfXZ7J1YtlWNUq4amFKbD0uXy6YID5ijzl3A3N7395spUbCztY8lsjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727115354; c=relaxed/simple;
	bh=sNv/aIqFNREWgvs0aF9POrMHph9hCDRCFllngZHkEsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mq3nb1yjtl6mEiys60J6gQ1Ge2PTAvDVAzWU+RGM+/LH1ky8VYawfaaDbb4XD40URtd+6WIiN/3iSS8rzTtozS44CHOyXLIVC0mNNjJc6OjVKSxEBLY6O4usA3cEccVMGEF5xCF9Giqdg+W+HLEBhU2L7W0Dzr/8nyLq9FLIu8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=2IzxZw7q; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="2IzxZw7q"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BFC7A80DDA
	for <virtualization@lists.linux-foundation.org>; Mon, 23 Sep 2024 18:15:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GBTjh4ceeaxa for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Sep 2024 18:15:52 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7092A80A8E
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7092A80A8E
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=2IzxZw7q
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7092A80A8E
	for <virtualization@lists.linux-foundation.org>; Mon, 23 Sep 2024 18:15:51 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a8a6d1766a7so662124266b.3
        for <virtualization@lists.linux-foundation.org>; Mon, 23 Sep 2024 11:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1727115349; x=1727720149; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LTpGY2HdjmD+19e8xZx45f/sOO4XJ/Cgbhm21X2+09E=;
        b=2IzxZw7qeehWHFTa5xRjY5IFclH+uIcnhzXCtNivxUKY+YdP4mg5PZuSrxSHHO7MXe
         k1/+5oEiTrfb0tM3xC3tZMsBdYZSAuwLEGDupOvWTqKd3rwE80Vx6yY+b5NdOvW1dbEB
         xahx3AaHoG8TBBms8ZxyonF6t8TF6ZZ41kbCA1Np3kALUaS5ASDOFJ+LOTmF0w7FXzPV
         PbnIcY6g+AAXIdhhzIUQx1tHERRun0x5nRQfbhEfhRMe1MB6FyJybRez8xgIlO9034wY
         /v1TtXmRF2Bm7AYu4o5tZmrvHJgpgHELn6frSIq4CB704K8cUfD65Neq5lkLE9Q2CpFa
         7ULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727115349; x=1727720149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LTpGY2HdjmD+19e8xZx45f/sOO4XJ/Cgbhm21X2+09E=;
        b=Tiry1Pqm0xWzy+eKzqnMIxYVl84wM5Zr7hTJI3OxfRGKYHbiSVcn9sV4cKiuKwQfXb
         TiSnWVAMoPzMhZjQY2L6Jd7lpEvNDuSEmrrl+zf7U5+VsjvB05kI2yf7r6D57wUFoXI6
         iXeJsb9yV5+l+FmNaigcVCgbjTtv2blfIoAsVoEASMmeaquUWTdQEcthpjlEsxwVU5Al
         /Ptw3j3Wb5YfOMlrSwiAvAIFgNkYGVNglKcr0t06aaANeffiz47anBzyzuymvEowcIgs
         n9l2lF2EmY4FBJlHwwIMvP0dXrfb4o+42QJSv0jDOMtQV31Zlv7U737QFif3dmkTOGei
         Jhpw==
X-Forwarded-Encrypted: i=1; AJvYcCXeZtjA+RgbPxPj6xUW0ii+LX2VtR4yPJKKSEaBxoxikmyffTgKgmQgAXxjlIa9wZ5nK72D77aIxcbUsqsupQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yy5HETulgLJiqNd+fcrlen/9UOZWDScJI0NOEKSxeD2GJwfP/e1
	/ogC3sfUphbd8UGJkPi7reWajxCMyNVOb2vChuh3sl2/cC4NW51E4xkPl54Lnqo=
X-Google-Smtp-Source: AGHT+IGpPI7fG4a4LTiKNkQuTwrb55WXPx6z+ZBeEe2uiGzK1oNL853fNzKzHMtEKbZf6pa6A0zTtQ==
X-Received: by 2002:a17:907:3fa6:b0:a8d:55ce:fb7f with SMTP id a640c23a62f3a-a90d5163099mr1378220166b.62.1727115349136;
        Mon, 23 Sep 2024 11:15:49 -0700 (PDT)
Received: from [10.102.105.220] (brn-rj-tbond07.sa.cz. [185.94.55.136])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061330c2asm1250099866b.204.2024.09.23.11.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 11:15:48 -0700 (PDT)
Message-ID: <6efc6937-2da7-4eb1-a2de-c9e5146d10ea@daynix.com>
Date: Mon, 23 Sep 2024 20:15:44 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 2/9] virtio_net: Add functions for hashing
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
 Andrew Melnychenko <andrew@daynix.com>
References: <20240915-rss-v3-0-c630015db082@daynix.com>
 <20240915-rss-v3-2-c630015db082@daynix.com>
 <66eacca7de803_29b986294ac@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <66eacca7de803_29b986294ac@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/09/18 14:50, Willem de Bruijn wrote:
> Akihiko Odaki wrote:
>> They are useful to implement VIRTIO_NET_F_RSS and
>> VIRTIO_NET_F_HASH_REPORT.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   include/linux/virtio_net.h | 198 +++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 198 insertions(+)
>>
>> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
>> index 6c395a2600e8..7ee2e2f2625a 100644
>> --- a/include/linux/virtio_net.h
>> +++ b/include/linux/virtio_net.h
>> @@ -9,6 +9,183 @@
>>   #include <uapi/linux/tcp.h>
>>   #include <uapi/linux/virtio_net.h>
>>   
>> +struct virtio_net_hash {
>> +	u32 value;
>> +	u16 report;
>> +};
>> +
>> +struct virtio_net_toeplitz_state {
>> +	u32 hash;
>> +	u32 key_buffer;
>> +	const __be32 *key;
>> +};
>> +
>> +#define VIRTIO_NET_SUPPORTED_HASH_TYPES (VIRTIO_NET_RSS_HASH_TYPE_IPv4 | \
>> +					 VIRTIO_NET_RSS_HASH_TYPE_TCPv4 | \
>> +					 VIRTIO_NET_RSS_HASH_TYPE_UDPv4 | \
>> +					 VIRTIO_NET_RSS_HASH_TYPE_IPv6 | \
>> +					 VIRTIO_NET_RSS_HASH_TYPE_TCPv6 | \
>> +					 VIRTIO_NET_RSS_HASH_TYPE_UDPv6)
>> +
>> +#define VIRTIO_NET_RSS_MAX_KEY_SIZE 40
>> +
>> +static inline void virtio_net_toeplitz(struct virtio_net_toeplitz_state *state,
>> +				       const __be32 *input, size_t len)
>> +{
>> +	u32 key;
>> +
>> +	while (len) {
>> +		state->key++;
>> +		key = be32_to_cpu(*state->key);
>> +
>> +		for (u32 bit = BIT(31); bit; bit >>= 1) {
>> +			if (be32_to_cpu(*input) & bit)
>> +				state->hash ^= state->key_buffer;
>> +
>> +			state->key_buffer =
>> +				(state->key_buffer << 1) | !!(key & bit);
>> +		}
>> +
>> +		input++;
>> +		len--;
>> +	}
>> +}
>> +
>> +static inline u8 virtio_net_hash_key_length(u32 types)
>> +{
>> +	size_t len = 0;
>> +
>> +	if (types & VIRTIO_NET_HASH_REPORT_IPv4)
>> +		len = max(len,
>> +			  sizeof(struct flow_dissector_key_ipv4_addrs));
>> +
>> +	if (types &
>> +	    (VIRTIO_NET_HASH_REPORT_TCPv4 | VIRTIO_NET_HASH_REPORT_UDPv4))
>> +		len = max(len,
>> +			  sizeof(struct flow_dissector_key_ipv4_addrs) +
>> +			  sizeof(struct flow_dissector_key_ports));
>> +
>> +	if (types & VIRTIO_NET_HASH_REPORT_IPv6)
>> +		len = max(len,
>> +			  sizeof(struct flow_dissector_key_ipv6_addrs));
>> +
>> +	if (types &
>> +	    (VIRTIO_NET_HASH_REPORT_TCPv6 | VIRTIO_NET_HASH_REPORT_UDPv6))
>> +		len = max(len,
>> +			  sizeof(struct flow_dissector_key_ipv6_addrs) +
>> +			  sizeof(struct flow_dissector_key_ports));
>> +
>> +	return 4 + len;
> 
> Avoid raw constants like this 4. What field does it capture?

It is: sizeof_field(struct virtio_net_toeplitz_state, key_buffer)
I'll replace it with v4.

> 
> Instead of working from shortest to longest and using max, how about
> the inverse and return as soon as a match is found.

I think it is less error-prone to use max() as it does not require to 
sort the numbers. The compiler should properly optimize it in the way 
you suggested.

> 
>> +}
>> +
>> +static inline u32 virtio_net_hash_report(u32 types,
>> +					 struct flow_dissector_key_basic key)
>> +{
>> +	switch (key.n_proto) {
>> +	case htons(ETH_P_IP):
>> +		if (key.ip_proto == IPPROTO_TCP &&
>> +		    (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv4))
>> +			return VIRTIO_NET_HASH_REPORT_TCPv4;
>> +
>> +		if (key.ip_proto == IPPROTO_UDP &&
>> +		    (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv4))
>> +			return VIRTIO_NET_HASH_REPORT_UDPv4;
>> +
>> +		if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv4)
>> +			return VIRTIO_NET_HASH_REPORT_IPv4;
>> +
>> +		return VIRTIO_NET_HASH_REPORT_NONE;
>> +
>> +	case htons(ETH_P_IPV6):
>> +		if (key.ip_proto == IPPROTO_TCP &&
>> +		    (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv6))
>> +			return VIRTIO_NET_HASH_REPORT_TCPv6;
>> +
>> +		if (key.ip_proto == IPPROTO_UDP &&
>> +		    (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv6))
>> +			return VIRTIO_NET_HASH_REPORT_UDPv6;
>> +
>> +		if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv6)
>> +			return VIRTIO_NET_HASH_REPORT_IPv6;
>> +
>> +		return VIRTIO_NET_HASH_REPORT_NONE;
>> +
>> +	default:
>> +		return VIRTIO_NET_HASH_REPORT_NONE;
>> +	}
>> +}
>> +
>> +static inline bool virtio_net_hash_rss(const struct sk_buff *skb,
>> +				       u32 types, const __be32 *key,
>> +				       struct virtio_net_hash *hash)
>> +{
>> +	u16 report;
> 
> nit: move below the struct declarations.

I'll change accordingly with v4.

> 
>> +	struct virtio_net_toeplitz_state toeplitz_state = {
>> +		.key_buffer = be32_to_cpu(*key),
>> +		.key = key
>> +	};
>> +	struct flow_keys flow;
>> +
>> +	if (!skb_flow_dissect_flow_keys(skb, &flow, 0))
>> +		return false;
>> +
>> +	report = virtio_net_hash_report(types, flow.basic);
>> +
>> +	switch (report) {
>> +	case VIRTIO_NET_HASH_REPORT_IPv4:
>> +		virtio_net_toeplitz(&toeplitz_state,
>> +				    (__be32 *)&flow.addrs.v4addrs,
>> +				    sizeof(flow.addrs.v4addrs) / 4);
>> +		break;
>> +
>> +	case VIRTIO_NET_HASH_REPORT_TCPv4:
>> +		virtio_net_toeplitz(&toeplitz_state,
>> +				    (__be32 *)&flow.addrs.v4addrs,
>> +				    sizeof(flow.addrs.v4addrs) / 4);
>> +		virtio_net_toeplitz(&toeplitz_state, &flow.ports.ports,
>> +				    1);
>> +		break;
>> +
>> +	case VIRTIO_NET_HASH_REPORT_UDPv4:
>> +		virtio_net_toeplitz(&toeplitz_state,
>> +				    (__be32 *)&flow.addrs.v4addrs,
>> +				    sizeof(flow.addrs.v4addrs) / 4);
>> +		virtio_net_toeplitz(&toeplitz_state, &flow.ports.ports,
>> +				    1);
>> +		break;
>> +
>> +	case VIRTIO_NET_HASH_REPORT_IPv6:
>> +		virtio_net_toeplitz(&toeplitz_state,
>> +				    (__be32 *)&flow.addrs.v6addrs,
>> +				    sizeof(flow.addrs.v6addrs) / 4);
>> +		break;
>> +
>> +	case VIRTIO_NET_HASH_REPORT_TCPv6:
>> +		virtio_net_toeplitz(&toeplitz_state,
>> +				    (__be32 *)&flow.addrs.v6addrs,
>> +				    sizeof(flow.addrs.v6addrs) / 4);
>> +		virtio_net_toeplitz(&toeplitz_state, &flow.ports.ports,
>> +				    1);
>> +		break;
>> +
>> +	case VIRTIO_NET_HASH_REPORT_UDPv6:
>> +		virtio_net_toeplitz(&toeplitz_state,
>> +				    (__be32 *)&flow.addrs.v6addrs,
>> +				    sizeof(flow.addrs.v6addrs) / 4);
>> +		virtio_net_toeplitz(&toeplitz_state, &flow.ports.ports,
>> +				    1);
>> +		break;
>> +
>> +	default:
>> +		return false;
>> +	}
>> +
>> +	hash->value = toeplitz_state.hash;
>> +	hash->report = report;
>> +
>> +	return true;
>> +}
>> +
>>   static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
>>   {
>>   	switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
>> @@ -239,4 +416,25 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>>   	return 0;
>>   }
>>   
>> +static inline int virtio_net_hdr_v1_hash_from_skb(const struct sk_buff *skb,
>> +						  struct virtio_net_hdr_v1_hash *hdr,
>> +						  bool has_data_valid,
>> +						  int vlan_hlen,
>> +						  const struct virtio_net_hash *hash)
>> +{
>> +	int ret;
>> +
>> +	memset(hdr, 0, sizeof(*hdr));
>> +
>> +	ret = virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)hdr,
>> +				      true, has_data_valid, vlan_hlen);
>> +	if (!ret) {
>> +		hdr->hdr.num_buffers = cpu_to_le16(1);
>> +		hdr->hash_value = cpu_to_le32(hash->value);
>> +		hdr->hash_report = cpu_to_le16(hash->report);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
> 
> I don't think that this helper is very helpful, as all the information
> it sets are first passed in. Just set the hdr fields directy in the
> caller. It is easier to follow the control flow.

I'll remove it in v4.

Regards,
Akihiko Odaki
