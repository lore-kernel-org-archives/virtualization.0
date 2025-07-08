Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E683D2E06EA
	for <virtualization@lists.linux.dev>; Tue,  8 Jul 2025 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985744; cv=none; b=NjY3SGdF0EdUCRcO2+v2ZG9Ur6R8abz5FVPs3FlxQCvcljGnptG8tJ2VE71FpBRTbqOWyF6PYvjZh9LVUpciPh/ukGjCo8pt4SeVRZyWC7zSSwEZra9+OqmEQsXml3JEnB8UbAclRQ01H8LKBNzNc5PEjMW9Lsavba1bqqd9kUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985744; c=relaxed/simple;
	bh=IFH/gTrs9FaiWA1Bh44A1FAet3DfzeFB+jW6pttiIiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nHrOiRcEK6H1TU1KiHdQ0SbnVPP4JqLXeiMuvRg34Z/4S2DqCzS4CGnOBG9IgirnocQUGt7C3vRhYZksIqlciUQGK0SbxjAdd1MQ9OQqrG5jk3UwEXl0Z3N3knh3Qt0vuRjrTB3fWQWVZsPjTYTckkW+QRMW2V9XNtI8OClys/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTB3Erne; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTB3Erne"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235e1d710d8so58816645ad.1
        for <virtualization@lists.linux.dev>; Tue, 08 Jul 2025 07:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751985742; x=1752590542; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eb4SCLyW8aPTvGZMV/AD0x8iJb7grZBVH4VOwlfaNVc=;
        b=bTB3ErneVwOs/YrHOPcR4rm6puduXObCtaIlQ4QTfWX8tq0FZujZzR1IgOspOYiBwV
         LeA42kvH9lN04+ROW7Fsp9kg5lMtTRYKfzN64wlTbZ9znf8NSUBQbaX7O+0jBn4a9U7+
         hlqX6E1G2ruBR1N5hWPBFjlSmh0ND9PXEfYuBafwf8eV3TdTrlkErhbdDQoBgQU86sQW
         Pa4QKutai6WOMxiia1W1OVJ729VjydcKUEg0Q8j5u0IPCJCOpiwndtOPk9pI6AeNo6C0
         9+/E2GBZRMJjJjNCESCfOO9fSnxYz/hLGnntFA2g35wxcOA4/S0cJ/QRpSxgE+ye3kbZ
         vypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751985742; x=1752590542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eb4SCLyW8aPTvGZMV/AD0x8iJb7grZBVH4VOwlfaNVc=;
        b=HbRZh6S9nhasC7k5h96tyTRaLvcYUEnElUmQjR2mwz/nqXmddTixBSKuo8EqLSYFB9
         vQNrKLgbhL2+Gga613P/F41R6mndovmXV10zG7DnxFwD+vVtitMRxzlVmI2kQk2rlISa
         OQUG+bYNet8a5FpWZaQIdLLB+bZo/xk7JcNWMm811NW8iWZTrqVItcOvQ0wpwvfWMah2
         pjiaL23cpksESFXiIOs1atC9ORj/XZf7cHXIsoxo8Zvt1P3oGyy9hdZ1G2szn/oGnSii
         sM6PkqkkpvgZM8VA/ZwePH4PF5pUQwSEgOnezFxB394yOpxa4AhwGLvvQSIQdwx/lxxD
         Fx5A==
X-Forwarded-Encrypted: i=1; AJvYcCUo/tpMPCVtGL+63/Aynzd+GEwlfUflllBvI73xF0VmtFBGq6BI1yvpYJEhTSKzwsT0ZBSEkDYKctHP5AzhNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYO8hjjNHvqQaNu0QVNW7uAfxX40DuBrAsRy8xlBnpUeiC+Xws
	j6om4Li1gQKGT/kk/oFaBtkex1G4eQZF4JkgjTzXiy+Som6orLbZYLh3xkEOeQ==
X-Gm-Gg: ASbGncu7Fim4yW9Apk6AKp4wbkEudRLMDKi19wsEK2pQjRIz88Mfp3oXw69FCTiPTyl
	aUHxTUJF0TWfffmuU6vK5yT6KJCSkdh5te+RCMzBcrIuUY1zr/OJunJ8LjieFrM7f2uXBtqOMia
	EXd5beLcedXHI1BLp6szvPJcx1W/HNSsc1aWcd130c9sRwE/Zd9wOxsvCA8B8yMKQfUL8Gt8CJz
	bJKzPGdeTHDe0QjntAvIuIASjsb3JCAKtuRwlr/e6l1fixtrBDPrUJKkzKEeAFAlwt6/LXhMKRu
	stXozM/PYWJ8bv2pagiMSDodnYPhcxe7tzGXimKMAZhZyR0J7wExnmOs/y7aHDw1RxzDVGD8hq+
	0OLy8dZPxd7vL
X-Google-Smtp-Source: AGHT+IH4sb/aC/QjC8Tg4KB/qPw7RdDAtp0xh3aetEQCl3CP8ba0jcWTkWAXh4nikC7m1hLrstXLWg==
X-Received: by 2002:a17:903:28f:b0:234:986c:66d4 with SMTP id d9443c01a7336-23dd1d3024emr38937115ad.26.1751985742188;
        Tue, 08 Jul 2025 07:42:22 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:37c0:6356:b7b4:119a])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23c8457e673sm120061945ad.174.2025.07.08.07.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 07:42:21 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
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
	Gavin Li <gavinl@nvidia.com>,
	Gavi Teitz <gavi@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net v2] virtio-net: fix received length check in big packets
Date: Tue,  8 Jul 2025 21:42:06 +0700
Message-ID: <20250708144206.95091-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
for big packets"), the allocated size for big packets is not
MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on negotiated MTU. The
number of allocated frags for big packets is stored in
vi->big_packets_num_skbfrags. This commit fixes the received length
check corresponding to that change. The current incorrect check can lead
to NULL page pointer dereference in the below while loop when erroneous
length is received.

Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big packets")
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
Changes in v2:
- Remove incorrect give_pages call
---
 drivers/net/virtio_net.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 5d674eb9a0f2..3a7f435c95ae 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -823,7 +823,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 {
 	struct sk_buff *skb;
 	struct virtio_net_common_hdr *hdr;
-	unsigned int copy, hdr_len, hdr_padded_len;
+	unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
 	struct page *page_to_free = NULL;
 	int tailroom, shinfo_size;
 	char *p, *hdr_p, *buf;
@@ -887,12 +887,15 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 	 * tries to receive more than is possible. This is usually
 	 * the case of a broken device.
 	 */
-	if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
+	BUG_ON(offset >= PAGE_SIZE);
+	max_remaining_len = (unsigned int)PAGE_SIZE - offset;
+	max_remaining_len += vi->big_packets_num_skbfrags * PAGE_SIZE;
+	if (unlikely(len > max_remaining_len)) {
 		net_dbg_ratelimited("%s: too much data\n", skb->dev->name);
 		dev_kfree_skb(skb);
 		return NULL;
 	}
-	BUG_ON(offset >= PAGE_SIZE);
+
 	while (len) {
 		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
-- 
2.43.0

