Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93364221FC4
	for <virtualization@lists.linux-foundation.org>; Fri, 30 May 2025 04:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748580668; cv=none; b=cv+UUO3eqAMXqQYSnC2RM6+GtBtBMOGI6sg0c5PvTPrx9o8C6hqINFJ+9PZn7sN5In25wO9be0HkDFg8m7Vd4hk/uvND+FQzZYnVbYNZi6O39SUhycYLqGJkLniyHde+5fehleDej3Qy8sdOP4w3RlKtugBHEzO3kLdZXqCcy70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748580668; c=relaxed/simple;
	bh=8QZ3Y17huIwvFuKYxGqjjNV9gzRi3SV/EMTE+e4j/s4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=SMaYiENhmcC0xjnVzir0VcSM/FB8Ial3bOZDK16FL6a1HdGa90uHg/06U/ygYcCtvMvnDMdSm9dAZltH4kf4tlZZqFJpXiwt9rw7JU6jhalSQP+2WFpWh1ODysRqhWtQlyITvdP9lJwRYaTClvh1YnizVVph4dlfzCKdwBeOsUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=p6n8+ZBq; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="p6n8+ZBq"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3321E409D4
	for <virtualization@lists.linux-foundation.org>; Fri, 30 May 2025 04:51:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ijCfj3J6NNmp for <virtualization@lists.linux-foundation.org>;
 Fri, 30 May 2025 04:51:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8FBBC409CF
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8FBBC409CF
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=p6n8+ZBq
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8FBBC409CF
	for <virtualization@lists.linux-foundation.org>; Fri, 30 May 2025 04:51:05 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-74019695377so985395b3a.3
        for <virtualization@lists.linux-foundation.org>; Thu, 29 May 2025 21:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748580665; x=1749185465; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6kg49tLaS0z1IHYonGafIguL3mgiSEk4xR/nFylD2io=;
        b=p6n8+ZBq+BhF6/EqLm3TvEaMg2IW7tOIi9YbGmRjb3xiq4JethwDISa5HRmMt+Zvoy
         YnWPV7NujErDO2/i3J5SjPrLGJof6hmxwgaC5ynDi5a7+XaE0oCPOYOppN5OJD/BpRD1
         0Qb3+nAQBNAlTeFNo6uSb+mxaOiw+0Cv68gT2xy/GC24o4ReUAN68jnj95Z3QpYNCyKy
         IAR1GGOaOCTHMUZBLp3wPp/Aq2inyL4BNx7YfBrHqhj5jaolxRZJJCmCEgOC+L4S5Kcr
         uUBWi0yKhquaatBK0gQFBUuD+xBxaTSIJWbE/sgNxruFTZSXi/7npuX3dI90jZm+LZxH
         95ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748580665; x=1749185465;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kg49tLaS0z1IHYonGafIguL3mgiSEk4xR/nFylD2io=;
        b=lC60ebHeNDXLwNhsmCS4BWYnBvu1f3O0hC/LCqhplOst2LHo3OzQu2UiuE5tNYZ3Ji
         B4gVfQptZYVTYET5g8Z9+Dhz1ZppHqmx4MB0AuemainhCbbgRo4nL37Bt33f9B/p2QLF
         eXGlKSJEb3Ier6OItUk3irWdramGMdPtIIooPsDjtT+CcaJHF7rXEpyC/mNXmjiEkMSc
         mKvKzobq+nOVINMZo14RnIch3NVyNbnmK6UiI2Ls7zJ7dSdsFKnwPKZ2Cc+gwu0yKWN0
         dBt/u2V1EG9OJUlIHXW6lKLNA/zRFQIApuLzq2qEh7puWkRSaTDTuXF+10LrmDTArYG1
         ePdg==
X-Forwarded-Encrypted: i=1; AJvYcCX/k2K2dFNg6oQGAHttAvkSRLpOR5zdmFVzCUnxxg+m/cQvA3VTyCj5hrrqG03mKdtLmeHynRHc7bZ9UvzxNg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwPYMeMsmAVS11c188gRHi+vuyIa0nNZTcAmU5HnWXN6MTSuIpJ
	Nke4MPbMrnThiE6Pxap/olh+lgU7McFPKPxbL7MVwRUdwsiliSiEcThMK+psfxfdUQY=
X-Gm-Gg: ASbGnct5VfpE/qRvtQlAqq3DMf7rXLPeM0U1hXE4Az4XG45m4V+zqnARHYE9ejFnnBa
	TkcZ2swcsqIrMO6LZJEAk00WES6LQ2u1nDPjnATM8xnfKb2DGgXGvrQ9JOV9vEihY6XrldiZfzf
	EebIHSThGz4AIiYVjR+YFmLstGcbmTw1JYtTghyS2iNPrmaiBxV68Kv9YeRZ8Yx7PA9IUAkcMIi
	QEwXvlDAXHOl2g4IKTlsGDLZ1m5phvtDsYkkh7ryYdaCug9n8cNLIHKYkmTF+hsqokyY0iP98sH
	cNleIcjd1pcPU5K7vK10XYfgd7uLm2PHkFQ1zxYOmiI3s3hFisazWpDj1wrIpRo=
X-Google-Smtp-Source: AGHT+IH9+BHJNIoXbgVGyUoI7SrCOCtJTbLtcbCTAW+31fagg/7EMzO3Z6Fm63/CoKEr+0ydoICMHQ==
X-Received: by 2002:a05:6a00:2389:b0:740:9abe:4d94 with SMTP id d2e1a72fcca58-747bda192e1mr2706018b3a.21.1748580664899;
        Thu, 29 May 2025 21:51:04 -0700 (PDT)
Received: from localhost ([157.82.128.1])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-747afff71eesm2159761b3a.159.2025.05.29.21.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 21:51:04 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 30 May 2025 13:50:13 +0900
Subject: [PATCH net-next v12 09/10] selftest: tap: Add tests for virtio-net
 ioctls
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-rss-v12-9-95d8b348de91@daynix.com>
References: <20250530-rss-v12-0-95d8b348de91@daynix.com>
In-Reply-To: <20250530-rss-v12-0-95d8b348de91@daynix.com>
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
 tools/testing/selftests/net/config |   1 +
 tools/testing/selftests/net/tap.c  | 131 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 129 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 61e5116987f3..00cb1e65b392 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -99,6 +99,7 @@ CONFIG_IPV6_IOAM6_LWTUNNEL=y
 CONFIG_CRYPTO_SM4_GENERIC=y
 CONFIG_AMT=m
 CONFIG_TUN=y
+CONFIG_TUN_VNET_CROSS_LE=y
 CONFIG_VXLAN=m
 CONFIG_IP_SCTP=m
 CONFIG_NETFILTER_XT_MATCH_POLICY=m
diff --git a/tools/testing/selftests/net/tap.c b/tools/testing/selftests/net/tap.c
index 247c3b3ac1c9..0decbc338965 100644
--- a/tools/testing/selftests/net/tap.c
+++ b/tools/testing/selftests/net/tap.c
@@ -387,9 +387,6 @@ FIXTURE_TEARDOWN(tap)
 	if (self->fd != -1)
 		close(self->fd);
 
-	ret = dev_delete(param_dev_tap_name);
-	EXPECT_EQ(ret, 0);
-
 	ret = dev_delete(param_dev_dummy_name);
 	EXPECT_EQ(ret, 0);
 }
@@ -431,4 +428,132 @@ TEST_F(tap, test_packet_crash_tap_invalid_eth_proto)
 	ASSERT_EQ(errno, EINVAL);
 }
 
+TEST_F(tap, test_vnethdrsz)
+{
+	int sz = sizeof(struct virtio_net_hdr_v1_hash);
+
+	ASSERT_FALSE(dev_delete(param_dev_tap_name));
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
+TEST_F(tap, test_getvnethashtypes)
+{
+	uint32_t hash_types;
+	int ret;
+
+	ASSERT_FALSE(dev_delete(param_dev_tap_name));
+
+	ret = ioctl(self->fd, TUNGETVNETHASHTYPES, &hash_types);
+	if (ret == -1 && errno == EINVAL)
+		SKIP(return, "TUNGETVNETHASHTYPES not supported");
+
+	EXPECT_FALSE(ret);
+}
+
+FIXTURE(tap_setvnethash)
+{
+	int fd;
+};
+
+FIXTURE_VARIANT(tap_setvnethash)
+{
+	unsigned int cmd;
+};
+
+FIXTURE_VARIANT_ADD(tap_setvnethash, reportingautomq)
+{
+	.cmd = TUNSETVNETREPORTINGAUTOMQ
+};
+
+FIXTURE_VARIANT_ADD(tap_setvnethash, reportingrss)
+{
+	.cmd = TUNSETVNETREPORTINGRSS
+};
+
+FIXTURE_VARIANT_ADD(tap_setvnethash, rss)
+{
+	.cmd = TUNSETVNETRSS
+};
+
+FIXTURE_SETUP(tap_setvnethash)
+{
+	int ret;
+
+	ret = dev_create(param_dev_dummy_name, "dummy", NULL, NULL);
+	ASSERT_FALSE(ret);
+
+	ret = dev_create(param_dev_tap_name, "macvtap", macvtap_fill_rtattr,
+			 NULL);
+	ASSERT_FALSE(ret)
+		EXPECT_FALSE(dev_delete(param_dev_dummy_name));
+
+	self->fd = opentap(param_dev_tap_name);
+	ASSERT_LT(0, self->fd)
+		EXPECT_FALSE(dev_delete(param_dev_dummy_name));
+}
+
+FIXTURE_TEARDOWN(tap_setvnethash)
+{
+	EXPECT_FALSE(close(self->fd));
+	EXPECT_FALSE(dev_delete(param_dev_dummy_name));
+}
+
+TEST_F(tap_setvnethash, test_alive)
+{
+	struct tun_vnet_rss rss = { .hash_types = 0 };
+	int ret;
+
+	ret = ioctl(self->fd, variant->cmd, &rss);
+
+	if (ret == -1 && errno == EINVAL)
+		SKIP(return, "not supported");
+
+	EXPECT_FALSE(ret);
+}
+
+TEST_F(tap_setvnethash, test_deleted)
+{
+	ASSERT_FALSE(dev_delete(param_dev_tap_name));
+
+	ASSERT_EQ(-1, ioctl(self->fd, variant->cmd));
+
+	if (errno == EINVAL)
+		SKIP(return, "not supported");
+
+	EXPECT_EQ(EBADFD, errno);
+}
+
 TEST_HARNESS_MAIN

-- 
2.49.0

