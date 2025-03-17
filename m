Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F5D23FC6B
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742209147; cv=none; b=O5TcXAVcEcUcNND8IOtNMpVkxxqhEBVqqPvKgfGOktOxiEcy2LWhL3b93/eRwOkm/Nvdq4v7bhk9GzRbjT0yoY1LT7T58MTuogJAbwIS8j82NygdZxRFY4J8tw/U+NRGkK++tXWiBYUJSg+SxwLKeLIZy2qweW+zOg0YpjALezQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742209147; c=relaxed/simple;
	bh=ccfXZvxiSAaG5MPb2w/JWrekNXtLfO8PT1kfNykthKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=tmVhiSl/qYOjfzI08WtRXT33TSIVpyrIn3VJlCq2Vi5Cix1YBNBKBHFOO2RTyN4zjdwPzgd3jKb1RhNTY4x5GjIii+iBqRV07o6JEteRH6AubX/Sat6khM/Y234Atx60SYAYR0UFu/HXebvuAITY6lKXUm1t1QOz82GRUa2CWf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=JThic+vQ; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="JThic+vQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9FA48215B
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 10:59:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QtF8SvvIc6VH for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Mar 2025 10:59:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DEE918215A
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DEE918215A
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=JThic+vQ
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DEE918215A
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 10:59:03 +0000 (UTC)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-224341bbc1dso75070875ad.3
        for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 03:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742209143; x=1742813943; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e3BkVPEmJoa+6yr2vocUy5kvhLH0cmr2yCWFD5W/C7U=;
        b=JThic+vQuNhpgdVvmly/IqAn2YjNnDMhS48TeC2NLBa/twgnpAczxS2TOn322lF5Zg
         mimZ2vge+sm2ELrJipxBWSL0t38lPENZ0X5LTsnynZDdjdyr9COfuvovYDbtrwabqwad
         xfDDEy07b9C6OhBh9vkV3ztFfuOBXnDUYF25lkroF36ZZL1+G4qDW7jJT+oZOin7Kuxd
         lxVytBQ6F3Qc0xY0YRKEr42VOqKhiNL2tDeibqSRgfofTccY1fOn0QVti/O2/R0gC+vY
         TNXIaCp9EEaN3q4/gWgdVqQSUMil+KEjqxdntL26DswNPI9V/eTPq9R8KRkOC5KmJAGK
         AeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742209143; x=1742813943;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3BkVPEmJoa+6yr2vocUy5kvhLH0cmr2yCWFD5W/C7U=;
        b=vsjw8qoQwopht3gmziNvQk6+wbT28LL9iIBmj164JxJa2H+tPP23Ijs4k3lhvx8OIO
         nZ/ZRubDPZ6S3Xi9SFkERyOm90FXG/0TJQGtVDsbCV1ANggTKQtIg8g/U3IDcnZBcdW7
         0QX+YJcjny7ZM6iXJF/54EcSEC3epru7SFcSQ+uoACWKQKKZ2sJZUuqcgR/7GdVkM1yG
         afZ3qiFRGz5CUH5FhMK2ecow53HSaQR2pTlKRBWcPUHskfjhnM58lW81LYZdFtosfF2L
         x+sRdpHd531sczbt1Sx4Ohidsg7WC83l5lcOyfggvh8W4+GcxZ4jOWzo8FGLaVf91KCp
         rHKw==
X-Forwarded-Encrypted: i=1; AJvYcCXp56WevKWZDFfxQftjGEVV7wRPWUG5wPgl+21lXUXBfQtiYbOB8nMghTwIUBerEoYCSQwVMf5vx81bH3n+EQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yxb1O5OAMb2HJqNMLjGQP24nqyIA+SxtcKmp/q123q9C4X89B+j
	wPSbM39SxJ9+ZIJo7ahIPDPxsy7SLTJvaa2VR9wUVOlNLBUkOaA66Je2tbEEWHw=
X-Gm-Gg: ASbGncturYGK1o5MDfGySOWC48OjjAgYHaL4TEGWFt4GufC8ViQD4rVZHEZBNYwk6SD
	PBr1Xl15GAdAkNGcfc+K+F+hwZZoyWf1P3wfhOBo4ZgBD32k88KV/RYtFMupgOzljUojunhLhjt
	/Y2b1t7O7x523CWtYU/xoeNtDWoac7uvDSNH/HqgMrfQ4vuvIDbgKRkxGw8N6IbIP8gstjr1O/0
	auGTDi/eiVPLOIIx0qQ88GjFqvvO1+Ju2u0cy+19x1Q3c/QbUIt1swvkCB0al1w4DLGqfjM4chE
	Eo5nVyZo/ZSDw1w3/aaWU9HIVQlkKD6Xf+UeUPf+dcnRCB3L
X-Google-Smtp-Source: AGHT+IGOao21bnQoF8f7GMJyK43XLi/BXMCK2hiBw4ypcEkYOkj5BsLms/4g5Wmz+GYI5JTnjSMvyg==
X-Received: by 2002:a17:902:dac3:b0:224:1ec0:8a0c with SMTP id d9443c01a7336-225e0a79f54mr144040315ad.29.1742209143268;
        Mon, 17 Mar 2025 03:59:03 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c6bbcd4asm72044005ad.164.2025.03.17.03.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 03:59:03 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 17 Mar 2025 19:57:59 +0900
Subject: [PATCH net-next v11 09/10] selftest: tap: Add tests for virtio-net
 ioctls
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-rss-v11-9-4cacca92f31f@daynix.com>
References: <20250317-rss-v11-0-4cacca92f31f@daynix.com>
In-Reply-To: <20250317-rss-v11-0-4cacca92f31f@daynix.com>
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

