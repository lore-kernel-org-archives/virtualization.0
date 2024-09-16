Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C064B49624
	for <virtualization@lists.linux-foundation.org>; Mon, 16 Sep 2024 07:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726470801; cv=none; b=ArGBg+FllAIVVkPDZHyDN5o3+85Rk679gEmEVXZ7JPX7wjc0EN4Jt0R3EnPpmh9ISunwfRFakrJQkU3Nr4VaX6mtv3uejnC+VDsNoNKKX8ylp1b8Bvd9gkLyaEJm0l/TcIPM9clEJVA3rnLJ9IqZ1akhJvxgbEPG7n89N/0f97g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726470801; c=relaxed/simple;
	bh=ZaE3JPjtRaAYCYIkE3022YmPKGJtBMPOLnJUVzEdaQc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VPurwtk2C+PFgvlPk8mbmIi08Vc17Okido9442IJ6B7KZwycnoUHiS1+2ZHep3mhgNTJJQKoBMFfVSxg9VHBDvAbafyy8VWKIV3Z5vNyOpTLvkq6rDJRIyPKg3u4imUwTii8xt9w9HtmT8fdzbo03GjW+YpJgmornMou7yWx1l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0DD51403D1
	for <virtualization@lists.linux-foundation.org>; Mon, 16 Sep 2024 07:13:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.393
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MwINeRp9Iegz for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Sep 2024 07:13:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.176.79.56; helo=frasgout.his.huawei.com; envelope-from=gur.stavi@huawei.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9F2C8403CF
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9F2C8403CF
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9F2C8403CF
	for <virtualization@lists.linux-foundation.org>; Mon, 16 Sep 2024 07:13:15 +0000 (UTC)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6bd32w2Wz6L78S;
	Mon, 16 Sep 2024 15:09:27 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id C16E0140516;
	Mon, 16 Sep 2024 15:13:11 +0800 (CST)
Received: from china (10.221.233.88) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Sep
 2024 09:13:03 +0200
From: <gur.stavi@huawei.com>
To: <akihiko.odaki@daynix.com>
CC: <andrew@daynix.com>, <corbet@lwn.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <jasowang@redhat.com>, <kuba@kernel.org>,
	<kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<mst@redhat.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<shuah@kernel.org>, <virtualization@lists.linux-foundation.org>,
	<willemdebruijn.kernel@gmail.com>, <xuanzhuo@linux.alibaba.com>,
	<yuri.benditovich@daynix.com>
Subject: [PATCH RFC v3 2/9] virtio_net: Add functions for hashing
Date: Mon, 16 Sep 2024 10:12:53 +0300
Message-ID: <20240916071253.462-1-gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240915-rss-v3-2-c630015db082@daynix.com>
References: <20240915-rss-v3-2-c630015db082@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 frapeml500005.china.huawei.com (7.182.85.13)

+
+static inline void virtio_net_toeplitz(struct virtio_net_toeplitz_state *state,
+				       const __be32 *input, size_t len)

The function calculates a hash value but its name does not make it
clear. Consider adding a 'calc'.

+{
+	u32 key;
+
+	while (len) {
+		state->key++;
+		key = be32_to_cpu(*state->key);

You perform be32_to_cpu to support both CPU endianities.
If you will follow with an unconditional swab32, you could run the
following loop on a more natural 0 to 31 always referring to bit 0
and avoiding !!(key & bit):

key = swab32(be32_to_cpu(*state->key));
for (i = 0; i < 32; i++, key >>= 1) {
	if (be32_to_cpu(*input) & 1)
		state->hash ^= state->key_buffer;
	state->key_buffer = (state->key_buffer << 1) | (key & 1);
}


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
+static inline u32 virtio_net_hash_report(u32 types,
+					 struct flow_dissector_key_basic key)
+{
+	switch (key.n_proto) {
+	case htons(ETH_P_IP):

Other parts of the code use be_to_cpu and cpu_to_be, Why use legacy
htons here?

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
 #endif /* _LINUX_VIRTIO_NET_H */

-- 
2.46.0

