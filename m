Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E488F49
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Sep 2024 01:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726363119; cv=none; b=VvllyXiJ1n+X5R43zzlpla0niBa2vZU2tHYnKtB0gujTI8JnJiuW7Leg/cB99pxBjiOedXF+5REYLliEkMMdJdbo4xAcKBWFiKyJBWzhv6N3LuoL/6RbL78zfPWG02lIMA5lzq2lpQ3jo8rQMSo0ifRATBt6372eppPT88DKZHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726363119; c=relaxed/simple;
	bh=kdVV3nDNT5v+ptxE3cRwUYyMsKrhhxcLbh1wXZFYmsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=WuXg6vBdFjKUFAN8MsD3ax6p+cU43S9jxsP/wDLUzW+9T96Dxg4mPqCmarmtyCGxeRx0fjC4AQtN7zwkeISI83vluIzJm1q0l80yuoYZLJoau9XVm0veg3b6gDKfWy0kByX18dUJbzhTnkxtTKc1fcXKk3tCa8jbOqHQOBEAw8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=orOV1jbQ; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="orOV1jbQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 34EC040204
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Sep 2024 01:18:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L6SWvSjwY-5d for <virtualization@lists.linux-foundation.org>;
 Sun, 15 Sep 2024 01:18:37 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E0C4A400F9
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E0C4A400F9
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=orOV1jbQ
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E0C4A400F9
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Sep 2024 01:18:36 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2d87176316eso3168690a91.0
        for <virtualization@lists.linux-foundation.org>; Sat, 14 Sep 2024 18:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726363116; x=1726967916; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N9RDpJor6M9oo/9F2GZqBqcJrSNYhytOgFsyeiDb1NE=;
        b=orOV1jbQGpWZLqCFHabEzrwbpP1gVYWRLyj2fhcsG4g692z6A1NhVgdunt9dLOsThD
         jhvb4om+wBBuyqLl0ZyRSu0H0QDi4JH3QwzUutSsPZ0nt+kjtLWMbzZBarMXYa0EgCov
         2x8XtlIV8HPoHVQRUidvivzTNFVHQHXFWc7U/2XCvwTRwZIoc5ZOM9IgZjcKrBMuSIHF
         TC6TonbJIYK3ODDA1SgZv8xGVhJijIvoqecrvtYye2l/xsZTX3u/2DX/CnNtJKo5kvlc
         L9bIHA/BLxixORnCE9f6aHyma83V0jWExcyQBlJqUHDkUPKp3jb1rvxQBBLRUd6y4QSy
         gBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726363116; x=1726967916;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9RDpJor6M9oo/9F2GZqBqcJrSNYhytOgFsyeiDb1NE=;
        b=ewH1+WvM1YuT1dqGnj+9APbGi5Vr049AOqrYJEazTkpfhOm02FqHkpYBgsMI86OoMI
         zfmRPnN/yEUxVIn0NWpcSnf6SVi62apKbCjRFWzWblFeaDXnMjZcTtwpeYT144RE9myy
         3dZHVDoWT3AX4T5DK+v8/xipqJdCQ2fGDsY2x4TVyF8mSwl69k7FW+8571PexTGmlbfN
         rY0YH7Mx34wKqnjFtdpLs9qOv+Og1UArvRUIXxnnRKDH5bFp0NUpz9wwmFsrz5V9BBHa
         SWl5ymKkUylmPJBlcdk65UyWZhbRX6LDvvp0kljeBhC49/XUzzBTnMT2a7khp96vP5zQ
         Dkyg==
X-Forwarded-Encrypted: i=1; AJvYcCVHFAFLoNxrFlKt44YJfIw/Kn0N01+rIdD8iVRjIXRKCftdg5hfE9e5CO8trPyhN4inE9pnvmbhtfbOpJK3XA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwmpWaVOrPv8qnSEtipTkGICq3LuCVZzt3js63G5qeLfJIzp4Ex
	/g383yA4AATc/1G6FGTXma1ojXLwuHD/dbJ8E25tPvRGII/h4LJqG7VHtTT31Mc=
X-Google-Smtp-Source: AGHT+IGgXau1gQB1kNbl5uh5JvAFFOilnxwwQRJvrOxybRStwe4qO1aFoNnRjyIm2xo1LYEsGJGWPQ==
X-Received: by 2002:a17:90b:88f:b0:2d8:73ba:9444 with SMTP id 98e67ed59e1d1-2db9fc54271mr17194832a91.5.1726363116022;
        Sat, 14 Sep 2024 18:18:36 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2dbcfcfd015sm2244144a91.17.2024.09.14.18.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 18:18:35 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:17:41 +0900
Subject: [PATCH RFC v3 2/9] virtio_net: Add functions for hashing
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-rss-v3-2-c630015db082@daynix.com>
References: <20240915-rss-v3-0-c630015db082@daynix.com>
In-Reply-To: <20240915-rss-v3-0-c630015db082@daynix.com>
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

They are useful to implement VIRTIO_NET_F_RSS and
VIRTIO_NET_F_HASH_REPORT.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/linux/virtio_net.h | 198 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 198 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 6c395a2600e8..7ee2e2f2625a 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -9,6 +9,183 @@
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
+static inline void virtio_net_toeplitz(struct virtio_net_toeplitz_state *state,
+				       const __be32 *input, size_t len)
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
+	return 4 + len;
+}
+
+static inline u32 virtio_net_hash_report(u32 types,
+					 struct flow_dissector_key_basic key)
+{
+	switch (key.n_proto) {
+	case htons(ETH_P_IP):
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
+	case htons(ETH_P_IPV6):
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
+static inline bool virtio_net_hash_rss(const struct sk_buff *skb,
+				       u32 types, const __be32 *key,
+				       struct virtio_net_hash *hash)
+{
+	u16 report;
+	struct virtio_net_toeplitz_state toeplitz_state = {
+		.key_buffer = be32_to_cpu(*key),
+		.key = key
+	};
+	struct flow_keys flow;
+
+	if (!skb_flow_dissect_flow_keys(skb, &flow, 0))
+		return false;
+
+	report = virtio_net_hash_report(types, flow.basic);
+
+	switch (report) {
+	case VIRTIO_NET_HASH_REPORT_IPv4:
+		virtio_net_toeplitz(&toeplitz_state,
+				    (__be32 *)&flow.addrs.v4addrs,
+				    sizeof(flow.addrs.v4addrs) / 4);
+		break;
+
+	case VIRTIO_NET_HASH_REPORT_TCPv4:
+		virtio_net_toeplitz(&toeplitz_state,
+				    (__be32 *)&flow.addrs.v4addrs,
+				    sizeof(flow.addrs.v4addrs) / 4);
+		virtio_net_toeplitz(&toeplitz_state, &flow.ports.ports,
+				    1);
+		break;
+
+	case VIRTIO_NET_HASH_REPORT_UDPv4:
+		virtio_net_toeplitz(&toeplitz_state,
+				    (__be32 *)&flow.addrs.v4addrs,
+				    sizeof(flow.addrs.v4addrs) / 4);
+		virtio_net_toeplitz(&toeplitz_state, &flow.ports.ports,
+				    1);
+		break;
+
+	case VIRTIO_NET_HASH_REPORT_IPv6:
+		virtio_net_toeplitz(&toeplitz_state,
+				    (__be32 *)&flow.addrs.v6addrs,
+				    sizeof(flow.addrs.v6addrs) / 4);
+		break;
+
+	case VIRTIO_NET_HASH_REPORT_TCPv6:
+		virtio_net_toeplitz(&toeplitz_state,
+				    (__be32 *)&flow.addrs.v6addrs,
+				    sizeof(flow.addrs.v6addrs) / 4);
+		virtio_net_toeplitz(&toeplitz_state, &flow.ports.ports,
+				    1);
+		break;
+
+	case VIRTIO_NET_HASH_REPORT_UDPv6:
+		virtio_net_toeplitz(&toeplitz_state,
+				    (__be32 *)&flow.addrs.v6addrs,
+				    sizeof(flow.addrs.v6addrs) / 4);
+		virtio_net_toeplitz(&toeplitz_state, &flow.ports.ports,
+				    1);
+		break;
+
+	default:
+		return false;
+	}
+
+	hash->value = toeplitz_state.hash;
+	hash->report = report;
+
+	return true;
+}
+
 static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
 {
 	switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
@@ -239,4 +416,25 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 	return 0;
 }
 
+static inline int virtio_net_hdr_v1_hash_from_skb(const struct sk_buff *skb,
+						  struct virtio_net_hdr_v1_hash *hdr,
+						  bool has_data_valid,
+						  int vlan_hlen,
+						  const struct virtio_net_hash *hash)
+{
+	int ret;
+
+	memset(hdr, 0, sizeof(*hdr));
+
+	ret = virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)hdr,
+				      true, has_data_valid, vlan_hlen);
+	if (!ret) {
+		hdr->hdr.num_buffers = cpu_to_le16(1);
+		hdr->hash_value = cpu_to_le32(hash->value);
+		hdr->hash_report = cpu_to_le16(hash->report);
+	}
+
+	return ret;
+}
+
 #endif /* _LINUX_VIRTIO_NET_H */

-- 
2.46.0

