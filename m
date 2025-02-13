Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B57207E01
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Feb 2025 06:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739429659; cv=none; b=eHv+w+8Av/FIj+MKIX2hUpQCzNrsrZN22pB/cwcY/q25GHE8ri4pajXjHJ5b0M2y1FlDjAtcjHLtUdc7pehbniCPQtop/AM9Xy3ZEGDj0NY1NaYmjCTCjwLvZ5cTnnt2HuGKFHtzc+DqYZVfHqcI9xIBzjglMlPj0xrcaqrpXzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739429659; c=relaxed/simple;
	bh=/yzdYtH4YY0bjMwJcW3eRmS8j75+nWXBCn9ujfFhxSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bic0/gXAg5l5wZJYo8Hh+ZXF4EWChNIrkLoBggRoLNSAmn1XtvR07+O9Sw1iPRfnqROwcS3I7rZN8fdWTNy2R4cntT8smaMiMGGCATbYWRKogDDXdViAVnnhBMUXmBQgwCAlm9LJtKbDO9iH2z353fq4Pd8Eq8pphYbTtLlbJv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=UIvJSk+Q; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="UIvJSk+Q"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 314046116A
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Feb 2025 06:54:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jqPQmY-LT8cm for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Feb 2025 06:54:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D5CC1617B8
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D5CC1617B8
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=UIvJSk+Q
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D5CC1617B8
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Feb 2025 06:54:15 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-220c92c857aso8516885ad.0
        for <virtualization@lists.linux-foundation.org>; Wed, 12 Feb 2025 22:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1739429655; x=1740034455; darn=lists.linux-foundation.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pVRbFgdW3C2VjPS6glvqhPThuCYMsgRY+pw4xzl9/Z0=;
        b=UIvJSk+QobA6UAQtEwIFUVicjvhcc3FSnRkU2FDwT5kycHZsh5AvjCj9Wkvl662t3R
         Agi5bdZ4dL0GbAlQAn0FJgXdD4prrZM73UPGyGTWXNwEZPZD+WLB0I7V9YtZaz7ugD92
         Bz8kOhCM8l/qY6/eDkWNE2UUeeBFuPgwPOc9m0cTtDk7qVF6BvkxG4svRZGb88qZqAK0
         PTcy5YVSxFkDWkOulZHtQv1MoVZVt2NXsg4VspMmZ7KU0aedO2VFc8JEg0jqKuwjGVa5
         Is63OrHWkpdE4Nga9UIXDnCrXU9xB1BJRwYJMcvvYt3F9HlxBdvWxAL7nHgSmlnFuFqo
         ur8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739429655; x=1740034455;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVRbFgdW3C2VjPS6glvqhPThuCYMsgRY+pw4xzl9/Z0=;
        b=JJ+wECxeWQ+28ENJBQRVNWBNP834332elC6fsAa63/qwzRQp+kq1OZdOWWKh/yKDhO
         c8BF+g6NJSTL0gHJy+jsnldnWJXf1AlRtxPr4XxqWX+2fd98RO5TT+WdjiVjgDcxpkv+
         4NSy6oHoYSRxH52a56+ZQQwcw9K9ewxnt0E92+2WiOPw7YVouMEWKHvCv8Y+xCkDI89+
         vwBE2EwTWkyg8UEiO0HR2Fl/JSIGGRDbxsOvizLrkoEKxfiSKfDz6+uGR6dOYHnMDeNg
         uu7+ZVENpnVxvScNd1XR6tGf0nkg+u+0ulo7J9rgY3DBq/v61BqUzzOPucioAbh+6Yrz
         BQHg==
X-Forwarded-Encrypted: i=1; AJvYcCWFVygvohH9F7S/a6FsNJBlSYNK4JKsfzRCWG4aTvInRZk9iTKf9OYU4gpBjZS3RIsvmrkEnxrz4OVvLfoMDQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyylKpNtOaFAYB1vgSkN3Z0JWtPYJErd1aAaW/rJkleVegMxusL
	Wou158QpMZ4RoTpfCUSwnKPx/TQgsBNn1uO70C/sO1LuqsdNnhNYIc3wdNr9ESU=
X-Gm-Gg: ASbGncsSz+SJpUUZP8lndqEycvqsOw1Jy85pUyt68FSCuRliaNb6R0rr+LZyskNehOA
	SXzAxBPgA157H0k+2tmA4Utni+zKGrqWc2TvZ3g+kypXr8FQfKQ40YgzDo8JNFhMI4yZTqU7uN2
	UxmHMTHjw8kAKBD1Hy+fEQKc1U2SBSYLQJYlAzeDO2WKaWmXXuWtQud0gYYUy5Y+ey7HspHdTHD
	1Fi/TrTAitNTM85KFqtS+y5F/I+xyENq6mKrzMVZGN8ojYBrwBCOCE0xVY6R8HnYwUPRKrBUuv2
	3HFh2alQ2C7RKXu4Sjs=
X-Google-Smtp-Source: AGHT+IHM0So4p/83DwxmEtYjGdBS7+MraFx0suhYHvvs65nwUSgOl1qYUwzLV/IIAGbVQphJY2u2vg==
X-Received: by 2002:a05:6a20:7351:b0:1ee:5cf2:9c01 with SMTP id adf61e73a8af0-1ee6c61abe9mr2996634637.5.1739429654761;
        Wed, 12 Feb 2025 22:54:14 -0800 (PST)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-adb57d542f1sm516772a12.2.2025.02.12.22.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 22:54:14 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Feb 2025 15:54:06 +0900
Subject: [PATCH net-next] tun: Pad virtio headers
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-buffers-v1-1-ec4a0821957a@daynix.com>
X-B4-Tracking: v=1; b=H4sIAA2XrWcC/z3MywrCMBCF4VcJszYwSWOkeRXpookTzSZqLqVQ+
 u4dVFwe/sO3QaWSqIITGxRaUk3PzEOdBITHnO8k0403aNRnVMpK32OkUuVoSRkfUQ8xAL9fhWJ
 aP9IVMjWZaW0wfUuhd2e6/fJfdoJdo/SAsvUsLZs4m9FjuLjFwrTvB//iwYOhAAAA
X-Change-ID: 20250116-buffers-96e14bf023fc
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
 devel@daynix.com
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2

tun used to simply advance iov_iter when it needs to pad virtio header,
which leaves the garbage in the buffer as is. This is especially
problematic when tun starts to allow enabling the hash reporting
feature; even if the feature is enabled, the packet may lack a hash
value and may contain a hole in the virtio header because the packet
arrived before the feature gets enabled or does not contain the
header fields to be hashed. If the hole is not filled with zero, it is
impossible to tell if the packet lacks a hash value.

In theory, a user of tun can fill the buffer with zero before calling
read() to avoid such a problem, but leaving the garbage in the buffer is
awkward anyway so fill the buffer in tun.

The specification also says the device MUST set num_buffers to 1 when
the field is present so set it when the specified header size is big
enough to contain the field.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tap.c      |  2 +-
 drivers/net/tun.c      |  6 ++++--
 drivers/net/tun_vnet.h | 14 +++++++++-----
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 1287e241f4454fb8ec4975bbaded5fbaa88e3cc8..d96009153c316f669e626d95002e5fe8add3a1b2 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -711,7 +711,7 @@ static ssize_t tap_put_user(struct tap_queue *q,
 	int total;
 
 	if (q->flags & IFF_VNET_HDR) {
-		struct virtio_net_hdr vnet_hdr;
+		struct virtio_net_hdr_v1 vnet_hdr;
 
 		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
 
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index b14231a743915c2851eaae49d757b763ec4a8841..a3aed7e42c63d8b8f523c0141c7d970ab185178c 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1987,7 +1987,9 @@ static ssize_t tun_put_user_xdp(struct tun_struct *tun,
 	ssize_t ret;
 
 	if (tun->flags & IFF_VNET_HDR) {
-		struct virtio_net_hdr gso = { 0 };
+		struct virtio_net_hdr_v1 gso = {
+			.num_buffers = cpu_to_tun_vnet16(tun->flags, 1)
+		};
 
 		vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
 		ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
@@ -2040,7 +2042,7 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	}
 
 	if (vnet_hdr_sz) {
-		struct virtio_net_hdr gso;
+		struct virtio_net_hdr_v1 gso;
 
 		ret = tun_vnet_hdr_from_skb(tun->flags, tun->dev, skb, &gso);
 		if (ret)
diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
index fd7411c4447ffb180e032fe3e22f6709c30da8e9..b4f406f522728f92266898969831c26a87930f6a 100644
--- a/drivers/net/tun_vnet.h
+++ b/drivers/net/tun_vnet.h
@@ -135,15 +135,17 @@ static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
 }
 
 static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
-				   const struct virtio_net_hdr *hdr)
+				   const struct virtio_net_hdr_v1 *hdr)
 {
+	int content_sz = MIN(sizeof(*hdr), sz);
+
 	if (unlikely(iov_iter_count(iter) < sz))
 		return -EINVAL;
 
-	if (unlikely(copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr)))
+	if (unlikely(copy_to_iter(hdr, content_sz, iter) != content_sz))
 		return -EFAULT;
 
-	iov_iter_advance(iter, sz - sizeof(*hdr));
+	iov_iter_zero(sz - content_sz, iter);
 
 	return 0;
 }
@@ -157,11 +159,11 @@ static inline int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
 static inline int tun_vnet_hdr_from_skb(unsigned int flags,
 					const struct net_device *dev,
 					const struct sk_buff *skb,
-					struct virtio_net_hdr *hdr)
+					struct virtio_net_hdr_v1 *hdr)
 {
 	int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
 
-	if (virtio_net_hdr_from_skb(skb, hdr,
+	if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)hdr,
 				    tun_vnet_is_little_endian(flags), true,
 				    vlan_hlen)) {
 		struct skb_shared_info *sinfo = skb_shinfo(skb);
@@ -179,6 +181,8 @@ static inline int tun_vnet_hdr_from_skb(unsigned int flags,
 		return -EINVAL;
 	}
 
+	hdr->num_buffers = cpu_to_tun_vnet16(flags, 1);
+
 	return 0;
 }
 

---
base-commit: f54eab84fc17ef79b701e29364b7d08ca3a1d2f6
change-id: 20250116-buffers-96e14bf023fc
prerequisite-change-id: 20241230-tun-66e10a49b0c7:v6
prerequisite-patch-id: 871dc5f146fb6b0e3ec8612971a8e8190472c0fb
prerequisite-patch-id: 2797ed249d32590321f088373d4055ff3f430a0e
prerequisite-patch-id: ea3370c72d4904e2f0536ec76ba5d26784c0cede
prerequisite-patch-id: 837e4cf5d6b451424f9b1639455e83a260c4440d
prerequisite-patch-id: ea701076f57819e844f5a35efe5cbc5712d3080d
prerequisite-patch-id: 701646fb43ad04cc64dd2bf13c150ccbe6f828ce
prerequisite-patch-id: 53176dae0c003f5b6c114d43f936cf7140d31bb5

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>

