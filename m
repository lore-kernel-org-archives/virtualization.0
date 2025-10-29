Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657B623506A
	for <virtualization@lists.linux.dev>; Wed, 29 Oct 2025 03:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761707361; cv=none; b=H7ipo1N+7CWs5k0XWxDaWDFL1247mSvI9S+zqV/uKjCf9IE3RI1p6yGuiPkVlLrqHhTP1ZyZmT8DE2bLFJbhrRE53d/9jNZ0hzO6QWgU+ZMWD2V6FshYwggbrdJCNj+mhYneJpGqoqFL3tQhzDC4WEsAsP3+AQp1oCgnvfQR+DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761707361; c=relaxed/simple;
	bh=oXRTjsdJeztN4LMmWMLRVfhpBuiCVwlkeV/B07OCfCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ilHK0YoTpBLp9E8H1qgZqwDWroLuhmqIbn3ILy853JBFmoYnWu4EEae49zUL+P8SIl0wQS4eMt8D1frrefx9EZiqoFrpUsmn8DfJ5UuFwufsvWnnom07WSn2rbVpf3TpzfpDXlsTkTa40KUK/GgOLiyiW14RGKVb2WjQffQSgKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=klF5Fve2; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="klF5Fve2"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761707356; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=kc1xuU8vS0ibh1UoP8fElxJeRmb8c+gkbLOhc7UVggU=;
	b=klF5Fve22X58rixvxf/xwnD1UMnfWZhm0t3/hrCu1OjE2Ia9zi8B9Rtnzpd2yuhIf7kBsczkxhF9vLBOB16+PpIcW0lqHeqXkGui5hf7CBBa47CSzoosh5r5+NteVIBVVWzXDVS8tX2OEiON0rLEV/9Vy3rZFGWbI0c4VwmzoO8=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WrE9lY._1761707355 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Oct 2025 11:09:15 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heng Qi <hengqi@linux.alibaba.com>,
	Willem de Bruijn <willemb@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v4 2/4] virtio-net: Ensure hdr_len is not set unless the header is forwarded to the device.
Date: Wed, 29 Oct 2025 11:09:11 +0800
Message-Id: <20251029030913.20423-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: eb1fbe1c38ee
Content-Transfer-Encoding: 8bit

Although `virtio_net_hdr_from_skb` is used in several places outside of
`virtio-net.c`, the `hdr_len` field is only utilized by the device
according to the specification. Therefore, we do not need to set
`hdr_len` unless the header is actually passed to the device.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 include/linux/virtio_net.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 4d1780848d0e..710ae0d2d336 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -218,9 +218,14 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *sinfo = skb_shinfo(skb);
 
-		/* This is a hint as to how much should be linear. */
-		hdr->hdr_len = __cpu_to_virtio16(little_endian,
-						 skb_headlen(skb));
+		/* In certain code paths (such as the af_packet.c receive path),
+		 * this function may be called without a transport header.
+		 * In this case, we do not need to set the hdr_len.
+		 */
+		if (skb_transport_header_was_set(skb))
+			hdr->hdr_len = __cpu_to_virtio16(little_endian,
+							 skb_headlen(skb));
+
 		hdr->gso_size = __cpu_to_virtio16(little_endian,
 						  sinfo->gso_size);
 		if (sinfo->gso_type & SKB_GSO_TCPV4)
-- 
2.32.0.3.g01195cf9f

