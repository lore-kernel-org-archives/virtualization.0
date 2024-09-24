Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B632615539F
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 09:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168484; cv=none; b=k2JNGmg7MHpx/O9wieKnGwDCvDl6G5idkcA+YHe5AkzOKNtNEjTBTWg8RRpzlp+R6D++UeHjST/hghCSYuoEuyRkB6BmR1KhoSqBdPJG1nuc5hrNezqLRNjbvYBrY4GkPX5YR/6XX2S44oCbL9It0SxWXmvCj1fsmUMISO4EDu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168484; c=relaxed/simple;
	bh=sOAXGGuPxVhRSBMMLtZjJhQOr2JtLUlri/1Ey3yMBnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=mMmFjHeLezzJJw+WPHNrnfqIcK395KUauvuR+A+YDzIReZ0Of/KnCXgi+/hoTYYlYa7GKYBpIQYWh/Dze5i12vEnQmAtmmMqZwZ+A0nQqle9hTVb7aVatsLb22FlklyPPabLshCJHUok7o7ixcGdI1dOzDavLEOgagk5K/Colj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=gJ4RF3uD; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="gJ4RF3uD"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8AD5C60A62
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 09:01:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pOn0C2IXWiBY for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Sep 2024 09:01:20 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 888B460A40
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 888B460A40
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=gJ4RF3uD
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 888B460A40
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 09:01:20 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a8d2b4a5bf1so752806066b.2
        for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 02:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1727168478; x=1727773278; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ov2zUxVwXGroWMKfnwaYR/rA1EzTscWc/86yRpml0UI=;
        b=gJ4RF3uDIl8od5MgbDI4dGb9+t+/zxf+RwvT3fA1d6/ZEZgGC/+yzRjRno1tj+uH+1
         aKOSXQfWkZNl0mmZh7xZaqThqZ35/ALxO5N91j2LOD8pSLF7rvwzB/sFprme+5+5YjR5
         0n0mhntsDRxLGRusib5l2zj+NG4ji87YWvxMslWMjXJ4gfeUWYEwwiMcFRx0Gzv9+yyG
         ikiSPXgh3qEur4vAZ3JDG/dRGqy2G5m0KNtGzmZBwfRaog82HDsEUfu2gPUCjoKPP01r
         OaPRb7aqO4I7sj5L36Z5RZHM7w8g5Itg9yhv7tAmqp3ZNJe8lA+jcdr5JIndRSpmtTuO
         F1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727168478; x=1727773278;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ov2zUxVwXGroWMKfnwaYR/rA1EzTscWc/86yRpml0UI=;
        b=QlsNVvA3Vaqoc08lHu8glqZj1JaXdWlj1GwN3mZMg4QL425nc7eHL2i9q4Dqd/3qwx
         pbjECG3CvFAmaDLSLoYmPtgzT8X8dTHf+d8CLf20wp4IhbHlIUyrHElRUMC1UGqa0ez1
         Jbotes+rzZGyC46KRO7Z9jjCCKtlozNAW0IAIVSTnJGtvmMevdoGmeS55/EL8H9+JrWb
         wgBzotnjvq8w11EK1DAH9qvMQRhpr3jrhoCQgzkxyVUdElu1siqViaPvEp/SAfwAH7LV
         0QYoRgfocMxdWcGyeQdzijwHpJtcXUgLMqvG9sg5K31b+g1R1rZKPohDOyCYlb6PdqWf
         WKXw==
X-Forwarded-Encrypted: i=1; AJvYcCWzKLcgpBG2tiCkOlknmyWZIJTYmRYT9XMvvZRJAgREueIapKbHpmtJZpNonk6FcqF/zv1kfXPwGeTQf87/og==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yz/7llZ5Yay//2CDtU6oodigol0SRww27NId0JrZRn+vQfPVm5v
	VkLr9uxAViTOWFMdAvijghUsOR+6K2+qQOoIOBl1xqAE88dGRXpKUDfjeWKaG64=
X-Google-Smtp-Source: AGHT+IFWAkqffQdJf6+ooG5u5r4ZbQRITl2L+f/622eMMHM38TeEo3AkjhjZ7Qd4F4SO1RqijO7WQw==
X-Received: by 2002:a17:907:9348:b0:a8d:3998:2d2 with SMTP id a640c23a62f3a-a90d518718fmr1921620866b.58.1727168478186;
        Tue, 24 Sep 2024 02:01:18 -0700 (PDT)
Received: from localhost ([193.32.29.227])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a9393134bd2sm58552866b.214.2024.09.24.02.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 02:01:17 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 24 Sep 2024 11:01:07 +0200
Subject: [PATCH RFC v4 2/9] virtio_net: Add functions for hashing
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240924-rss-v4-2-84e932ec0e6c@daynix.com>
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
In-Reply-To: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

They are useful to implement VIRTIO_NET_F_RSS and
VIRTIO_NET_F_HASH_REPORT.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/linux/virtio_net.h | 174 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 174 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 276ca543ef44..f7a4149efb3e 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -9,6 +9,180 @@
 #include <uapi/linux/tcp.h>
 #include <uapi/linux/virtio_net.h>
 
+struct virtio_net_hash {
+	u32 value;
+	u16 report;
+};
+
+struct virtio_net_toeplitz_state {
+	u32 hash;
+	u32 key_buffer;
+	const __be32 *key;
+};
+
+#define VIRTIO_NET_SUPPORTED_HASH_TYPES (VIRTIO_NET_RSS_HASH_TYPE_IPv4 | \
+					 VIRTIO_NET_RSS_HASH_TYPE_TCPv4 | \
+					 VIRTIO_NET_RSS_HASH_TYPE_UDPv4 | \
+					 VIRTIO_NET_RSS_HASH_TYPE_IPv6 | \
+					 VIRTIO_NET_RSS_HASH_TYPE_TCPv6 | \
+					 VIRTIO_NET_RSS_HASH_TYPE_UDPv6)
+
+#define VIRTIO_NET_RSS_MAX_KEY_SIZE 40
+
+static inline void virtio_net_toeplitz_calc(struct virtio_net_toeplitz_state *state,
+					    const __be32 *input, size_t len)
+{
+	u32 key;
+
+	while (len) {
+		state->key++;
+		key = be32_to_cpu(*state->key);
+
+		for (u32 bit = BIT(31); bit; bit >>= 1) {
+			if (be32_to_cpu(*input) & bit)
+				state->hash ^= state->key_buffer;
+
+			state->key_buffer =
+				(state->key_buffer << 1) | !!(key & bit);
+		}
+
+		input++;
+		len--;
+	}
+}
+
+static inline u8 virtio_net_hash_key_length(u32 types)
+{
+	size_t len = 0;
+
+	if (types & VIRTIO_NET_HASH_REPORT_IPv4)
+		len = max(len,
+			  sizeof(struct flow_dissector_key_ipv4_addrs));
+
+	if (types &
+	    (VIRTIO_NET_HASH_REPORT_TCPv4 | VIRTIO_NET_HASH_REPORT_UDPv4))
+		len = max(len,
+			  sizeof(struct flow_dissector_key_ipv4_addrs) +
+			  sizeof(struct flow_dissector_key_ports));
+
+	if (types & VIRTIO_NET_HASH_REPORT_IPv6)
+		len = max(len,
+			  sizeof(struct flow_dissector_key_ipv6_addrs));
+
+	if (types &
+	    (VIRTIO_NET_HASH_REPORT_TCPv6 | VIRTIO_NET_HASH_REPORT_UDPv6))
+		len = max(len,
+			  sizeof(struct flow_dissector_key_ipv6_addrs) +
+			  sizeof(struct flow_dissector_key_ports));
+
+	return sizeof_field(struct virtio_net_toeplitz_state, key_buffer) + len;
+}
+
+static inline u32 virtio_net_hash_report(u32 types,
+					 struct flow_dissector_key_basic key)
+{
+	switch (key.n_proto) {
+	case cpu_to_be16(ETH_P_IP):
+		if (key.ip_proto == IPPROTO_TCP &&
+		    (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv4))
+			return VIRTIO_NET_HASH_REPORT_TCPv4;
+
+		if (key.ip_proto == IPPROTO_UDP &&
+		    (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv4))
+			return VIRTIO_NET_HASH_REPORT_UDPv4;
+
+		if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv4)
+			return VIRTIO_NET_HASH_REPORT_IPv4;
+
+		return VIRTIO_NET_HASH_REPORT_NONE;
+
+	case cpu_to_be16(ETH_P_IPV6):
+		if (key.ip_proto == IPPROTO_TCP &&
+		    (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv6))
+			return VIRTIO_NET_HASH_REPORT_TCPv6;
+
+		if (key.ip_proto == IPPROTO_UDP &&
+		    (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv6))
+			return VIRTIO_NET_HASH_REPORT_UDPv6;
+
+		if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv6)
+			return VIRTIO_NET_HASH_REPORT_IPv6;
+
+		return VIRTIO_NET_HASH_REPORT_NONE;
+
+	default:
+		return VIRTIO_NET_HASH_REPORT_NONE;
+	}
+}
+
+static inline void virtio_net_hash_rss(const struct sk_buff *skb,
+				       u32 types, const __be32 *key,
+				       struct virtio_net_hash *hash)
+{
+	struct virtio_net_toeplitz_state toeplitz_state = {
+		.key_buffer = be32_to_cpu(*key),
+		.key = key
+	};
+	struct flow_keys flow;
+	u16 report;
+
+	if (!skb_flow_dissect_flow_keys(skb, &flow, 0)) {
+		hash->report = VIRTIO_NET_HASH_REPORT_NONE;
+		return;
+	}
+
+	report = virtio_net_hash_report(types, flow.basic);
+
+	switch (report) {
+	case VIRTIO_NET_HASH_REPORT_IPv4:
+		virtio_net_toeplitz_calc(&toeplitz_state,
+					 (__be32 *)&flow.addrs.v4addrs,
+					 sizeof(flow.addrs.v4addrs) / 4);
+		break;
+
+	case VIRTIO_NET_HASH_REPORT_TCPv4:
+		virtio_net_toeplitz_calc(&toeplitz_state,
+					 (__be32 *)&flow.addrs.v4addrs,
+					 sizeof(flow.addrs.v4addrs) / 4);
+		virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports, 1);
+		break;
+
+	case VIRTIO_NET_HASH_REPORT_UDPv4:
+		virtio_net_toeplitz_calc(&toeplitz_state,
+					 (__be32 *)&flow.addrs.v4addrs,
+					 sizeof(flow.addrs.v4addrs) / 4);
+		virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports, 1);
+		break;
+
+	case VIRTIO_NET_HASH_REPORT_IPv6:
+		virtio_net_toeplitz_calc(&toeplitz_state,
+					 (__be32 *)&flow.addrs.v6addrs,
+					 sizeof(flow.addrs.v6addrs) / 4);
+		break;
+
+	case VIRTIO_NET_HASH_REPORT_TCPv6:
+		virtio_net_toeplitz_calc(&toeplitz_state,
+					 (__be32 *)&flow.addrs.v6addrs,
+					 sizeof(flow.addrs.v6addrs) / 4);
+		virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports, 1);
+		break;
+
+	case VIRTIO_NET_HASH_REPORT_UDPv6:
+		virtio_net_toeplitz_calc(&toeplitz_state,
+					 (__be32 *)&flow.addrs.v6addrs,
+					 sizeof(flow.addrs.v6addrs) / 4);
+		virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports, 1);
+		break;
+
+	default:
+		hash->report = VIRTIO_NET_HASH_REPORT_NONE;
+		return;
+	}
+
+	hash->value = toeplitz_state.hash;
+	hash->report = report;
+}
+
 static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
 {
 	switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {

-- 
2.46.0

