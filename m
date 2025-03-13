Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504E8204845
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Mar 2025 07:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849343; cv=none; b=PVYob47/JNl91DG2akQoF/7LjaLGYfKiXr1H7CW80AzjpSmnVCdggWEVZ+BxR42qv5swCZBiCzmyyImMZNy8TiyNxSI+YxRDkZ+8Y3zCdFkeLtQusJbuDfiDAiIKLSBgdvYJS6wBhGO/1/UIL69xu/vpAEDWutQ/GdMg6iNib38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849343; c=relaxed/simple;
	bh=ccfXZvxiSAaG5MPb2w/JWrekNXtLfO8PT1kfNykthKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=pfSDrSaZc11ld6wd4jY7m0P3/0W6weoQRUxHk819PxBjeuZgLiOC8jXgc7xc1HX3+vVmGbgSE/HM5STraX4JELJK2OmNqQ+J9zKdKdc2/ZxLFar4MjmoZwCvwC9yUliG8vj4ThVp+0+NkS6TnS+sOdTsqR6hds4p44IZ6owPPkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=sppyZXYm; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="sppyZXYm"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F017880B16
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Mar 2025 07:02:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OotQtpgNfGx4 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Mar 2025 07:02:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 323EC801E4
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 323EC801E4
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=sppyZXYm
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 323EC801E4
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Mar 2025 07:02:21 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-219f8263ae0so11269235ad.0
        for <virtualization@lists.linux-foundation.org>; Thu, 13 Mar 2025 00:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741849340; x=1742454140; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e3BkVPEmJoa+6yr2vocUy5kvhLH0cmr2yCWFD5W/C7U=;
        b=sppyZXYmc3kzotjwm/mm0/coGroNeoU5xLH6GmiCggIH6QOJi+QXyR0DEqo/gXqu4C
         jkwJ7ABydB8ZAtEEA8MSQKQd55EPzAxeSLWAvkhmQydvaearPKej/utUN7gXn5LLdzf2
         TmRYASAgGzp0xsCJ3NQRrXFc2IWof1oZWGMmeQMs+L7fo/WAt5aQvDGhdGGObOqCU20n
         upSWWoVmecZSijElX6v5FvxhRam0MrHTfVqLKPwGG5+ryapU9rtK1X+OXEZhATcUQVLM
         gJwiU8zSGb/RkLGI0/5PpmoQy4QI9L5EzO9vcWTYGcAXR3urnPIagn6Zq/uqPPi4DnbJ
         Ij7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741849340; x=1742454140;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3BkVPEmJoa+6yr2vocUy5kvhLH0cmr2yCWFD5W/C7U=;
        b=OHpCoKI758le7aE8iI3YDMqFd8RYRVjtBD8lxcSza8kYDvJmpCAJ8C4nadVRxpQKKz
         P0ilwIiXUoZZ5MeDaQAxXt7vtiD2CKvO50rJruXCataRs07Ybkb1GlcPcaAQtfgYmSvh
         kLDbJVDFPKjasmHTPdIlX1XYzIGUM9hESDfQiq9EXl7oVFMQcvSOc21YTQ9026phzndT
         UJCD8M1ZgqTr/gKVQvIwqDiuwyFAEha4pD67miKlanTCsT3/W8CL1Q+5YlwvryE+/X2q
         GGf6PTVyDaL2z7ouCQhNMRyOJn/03vsKxMCX397Wj0311dfv2SFbmtOWnFwQp+nbQsqc
         T04A==
X-Forwarded-Encrypted: i=1; AJvYcCWSWBd13RzEmAWHg9RfZUbBk52Pr3t6ZlJXX13bbGYqH3TiPFaximl8OMMQVa8Ct1fJyVUTFRuCjznGyiSkCQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yzv/sYOjo/BIGpzjy3hiHmbCFGDlDCHhU91o8EGeaeCAXR+Tod1
	4+t2Klbs1VlB60JqJ6iSCF8aiNlCpTVXdwlbXgNVxBhsioBHgcoQ19RJvRUC6TQ=
X-Gm-Gg: ASbGncsCjlUwjETkl8eSsYDHfhIcrnPlM2prskCgjmv3ELtoYoDCNQxQ8ngjHgZ/Eh5
	qOm36+KFRnX9eyux1m5qz5Ye8HA+MtRklrmLDwDKfKS6nL/XP6+MN+iHvM0B64Ioi+Qq+JpJ0Ez
	KRI81ynBZTss3123hUdokKyFqEcBiFpQC3byE4S+7xjyVCXwfWeJuUc8OwEgwkAchixal9Mg9Nn
	l1pd39YlFP9HRgRiuWVhgmBCkRMrSEZ1fyCam1aWNvJ2W9VzGs7v4nBgyf82HNBcVHZVVLw+TGv
	Zy9LqIQ4fOIYmWZSpwTjqk/NMsyjY1/dUoR2kyRL2KG4PxVS
X-Google-Smtp-Source: AGHT+IFaX1olq5WQi+7fcP4HReHGKVkvSZ9sg15FYUug/XHg7z4NmpOMBbEE1p5tCvq05aXsAHzDQQ==
X-Received: by 2002:a05:6a00:2d83:b0:736:a7ec:a366 with SMTP id d2e1a72fcca58-736eb7d882bmr12600967b3a.9.1741849340468;
        Thu, 13 Mar 2025 00:02:20 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73711695ee8sm632427b3a.154.2025.03.13.00.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 00:02:20 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 16:01:12 +0900
Subject: [PATCH net-next v10 09/10] selftest: tap: Add tests for virtio-net
 ioctls
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-rss-v10-9-3185d73a9af0@daynix.com>
References: <20250313-rss-v10-0-3185d73a9af0@daynix.com>
In-Reply-To: <20250313-rss-v10-0-3185d73a9af0@daynix.com>
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
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

They only test the ioctls are wired up to the implementation common with
tun as it is already tested for tun.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tools/testing/selftests/net/tap.c | 97 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/tap.c b/tools/testing/selftests/net/tap.c
index 247c3b3ac1c9..fbd38b08fdfa 100644
--- a/tools/testing/selftests/net/tap.c
+++ b/tools/testing/selftests/net/tap.c
@@ -363,6 +363,7 @@ size_t build_test_packet_crash_tap_invalid_eth_proto(uint8_t *buf,
 FIXTURE(tap)
 {
 	int fd;
+	bool deleted;
 };
 
 FIXTURE_SETUP(tap)
@@ -387,8 +388,10 @@ FIXTURE_TEARDOWN(tap)
 	if (self->fd != -1)
 		close(self->fd);
 
-	ret = dev_delete(param_dev_tap_name);
-	EXPECT_EQ(ret, 0);
+	if (!self->deleted) {
+		ret = dev_delete(param_dev_tap_name);
+		EXPECT_EQ(ret, 0);
+	}
 
 	ret = dev_delete(param_dev_dummy_name);
 	EXPECT_EQ(ret, 0);
@@ -431,4 +434,94 @@ TEST_F(tap, test_packet_crash_tap_invalid_eth_proto)
 	ASSERT_EQ(errno, EINVAL);
 }
 
+TEST_F(tap, test_vnethdrsz)
+{
+	int sz = sizeof(struct virtio_net_hdr_v1_hash);
+
+	ASSERT_FALSE(dev_delete(param_dev_tap_name));
+	self->deleted = true;
+
+	ASSERT_FALSE(ioctl(self->fd, TUNSETVNETHDRSZ, &sz));
+	sz = 0;
+	ASSERT_FALSE(ioctl(self->fd, TUNGETVNETHDRSZ, &sz));
+	EXPECT_EQ(sizeof(struct virtio_net_hdr_v1_hash), sz);
+}
+
+TEST_F(tap, test_vnetle)
+{
+	int le = 1;
+
+	ASSERT_FALSE(dev_delete(param_dev_tap_name));
+	self->deleted = true;
+
+	ASSERT_FALSE(ioctl(self->fd, TUNSETVNETLE, &le));
+	le = 0;
+	ASSERT_FALSE(ioctl(self->fd, TUNGETVNETLE, &le));
+	EXPECT_EQ(1, le);
+}
+
+TEST_F(tap, test_vnetbe)
+{
+	int be = 1;
+	int ret;
+
+	ASSERT_FALSE(dev_delete(param_dev_tap_name));
+	self->deleted = true;
+
+	ret = ioctl(self->fd, TUNSETVNETBE, &be);
+	if (ret == -1 && errno == EINVAL)
+		SKIP(return, "TUNSETVNETBE not supported");
+
+	ASSERT_FALSE(ret);
+	be = 0;
+	ASSERT_FALSE(ioctl(self->fd, TUNGETVNETBE, &be));
+	EXPECT_EQ(1, be);
+}
+
+TEST_F(tap, test_getvnethashcap)
+{
+	static const struct tun_vnet_hash expected = {
+		.flags = TUN_VNET_HASH_REPORT | TUN_VNET_HASH_RSS,
+		.types = VIRTIO_NET_RSS_HASH_TYPE_IPv4 |
+			 VIRTIO_NET_RSS_HASH_TYPE_TCPv4 |
+			 VIRTIO_NET_RSS_HASH_TYPE_UDPv4 |
+			 VIRTIO_NET_RSS_HASH_TYPE_IPv6 |
+			 VIRTIO_NET_RSS_HASH_TYPE_TCPv6 |
+			 VIRTIO_NET_RSS_HASH_TYPE_UDPv6
+	};
+	struct tun_vnet_hash seen;
+	int ret;
+
+	ASSERT_FALSE(dev_delete(param_dev_tap_name));
+	self->deleted = true;
+
+	ret = ioctl(self->fd, TUNGETVNETHASHCAP, &seen);
+
+	if (ret == -1 && errno == EINVAL)
+		SKIP(return, "TUNGETVNETHASHCAP not supported");
+
+	EXPECT_FALSE(ret);
+	EXPECT_FALSE(memcmp(&expected, &seen, sizeof(expected)));
+}
+
+TEST_F(tap, test_setvnethash_alive)
+{
+	struct tun_vnet_hash hash = { .flags = 0 };
+
+	EXPECT_FALSE(ioctl(self->fd, TUNSETVNETHASH, &hash));
+}
+
+TEST_F(tap, test_setvnethash_deleted)
+{
+	ASSERT_FALSE(dev_delete(param_dev_tap_name));
+	self->deleted = true;
+
+	ASSERT_EQ(-1, ioctl(self->fd, TUNSETVNETHASH));
+
+	if (errno == EINVAL)
+		SKIP(return, "TUNSETVNETHASH not supported");
+
+	EXPECT_EQ(EBADFD, errno);
+}
+
 TEST_HARNESS_MAIN

-- 
2.48.1

