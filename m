Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C9C21E082
	for <virtualization@lists.linux-foundation.org>; Fri, 30 May 2025 04:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748580659; cv=none; b=nQpM3Zn1bRvRnlZH3331xuH7Byr/4L1W0DDwcw2lsDxiG5cZKqVgVO+0oaYZZB5/xAT2Vq70uvJCB5qQoVkXqek9vsoVlvfantQ9KFmrgkXIOFjGafZivTN3zS1i55uFQLUx13az0FNttgxVLGEtmZ5ckBjf9McZDWnQ4OvoIlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748580659; c=relaxed/simple;
	bh=Y+hugblmAxgmRkyn2fxyuMLaQgzvEXZBlnk8Jh/v8UM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=VHKl6SmdLiE0BPTtFvnXVmkt1NZUdYVWaKxYM7NbI4czWyWSjYGcNRX6O1Y219ODzeZNevnRyT/7A++WhDnhZ8Q7k/6Z2FrYhggpoOkZ4N6k9Ez9I7PyiuzojQoyxQsIq/5VXLLSXg3eOMTGBlSRS198lb733KnhROFh1ngh+x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=CzR+OBAw; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="CzR+OBAw"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9328B81E0B
	for <virtualization@lists.linux-foundation.org>; Fri, 30 May 2025 04:50:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PugToKIvc1Hz for <virtualization@lists.linux-foundation.org>;
 Fri, 30 May 2025 04:50:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0B5FA81DE0
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0B5FA81DE0
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=CzR+OBAw
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0B5FA81DE0
	for <virtualization@lists.linux-foundation.org>; Fri, 30 May 2025 04:50:56 +0000 (UTC)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-b2c41acd479so1189925a12.2
        for <virtualization@lists.linux-foundation.org>; Thu, 29 May 2025 21:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748580656; x=1749185456; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/6gL7uu88i7p+1Fmf1z5Sh293hU0sJzRplicMeiOvs=;
        b=CzR+OBAwg8OGeOPUoxdMSL+IffOTZ7WwFEdwAnJPxnJB/BEPVxV8+2vLN0NKlapvCB
         hgFOyBAlaYkRXmgWRsaqWmpbZhtBSkv7CZJQ0mO3JmB/89VH89sryt4lR+64KNZNVKt2
         AlzS+tblbzbcyeYZgC0Cz3unriBPJYIAquEe+aM5OEMrV6EAZklcQBAhaXkPDAktxwA8
         25Ym3I3VnbbsusPEIx2MMMdOC9SnJBZeeyiVA0g8PXewuJvOv68jsQh51G/HdX+U/B9q
         AF1ChHEEr62KEQPrE46GOuudlEfLSzpPrCasMWvVHmFFwdfYZo1Bbs8wn+FHFry9pRa2
         BJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748580656; x=1749185456;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/6gL7uu88i7p+1Fmf1z5Sh293hU0sJzRplicMeiOvs=;
        b=HBCXnEV5x7N0WUXUgbOetv2GAWsCdbvKby4yln3MYp0xX99SU+5TW5R7o+ptMsuFRB
         63yH/L5hI4uWjFqnpZNbXE1bEcIxzQNJBpc6OVumAzuX5idv8jpSDQuj0GN5Xux2aFLE
         VWchmh9KSCOdRYK0P9i2sMnS/66NW8sN7tKyYayWfDJv52Hw1DaQFVtlaim5M58HIu07
         MMyJpZu7QvizA61y69Lmi0+vcgRTyU0bFEXtrFroEmNuiwnO2UXZWXvi3gFlYJKEJNcX
         LiCr6T4023TUviNdU35o9HOW55yfo0h7/953t5IjlMeusACB3LoxiraXA67oq/WbmdpO
         8JDg==
X-Forwarded-Encrypted: i=1; AJvYcCURfsyCmh+pRKTU8YeUlzqHTrXj6M89b9XSAtLemeAaoal2FeulvbBKHCN4hpCDBBsVbGGhXhjqAubgNBH8DA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxyciVgbsfEJDKGlHQ/ndcHyrAcISWvPF5fWPGaQ3n9fQ1pirlN
	WkstkduaAiKUojeax98hP1ztxwKsI1zSVQiN/MQDvgCBHwfoxGm8pR4KSVAKBykfsYE=
X-Gm-Gg: ASbGncvEOJ8IiXmTQ3wXOyXbUkQiULzKreBMAkD4sCO0A52gU9Q1LR6m7bjXLlGRU1M
	WDmt/y6p/zZvsRipleYO4yjRgUTUXTUYdn+VRkJTksmzwLand/cbZhYTIe5uCbvozH43q9PIiL/
	dnEhS6Ha0QU3DQTVyp71ZLlCeFjwGOsgqSS459D4wVcn+7Ebf3IL0GNDAew5EVCb5RZa6tJAVtO
	nFNY2LFRFproF5l+MvDpsr6/P872qZw3MjQFINVSMdKVjaM8QlaY5CKRUSGlPCI3ZyRCLyZVA7Q
	QvSzdYxauz25YkvbaLj23Re+KcQ5+AIO+VeKOsM+IJ8Lv9g38c8i
X-Google-Smtp-Source: AGHT+IEvyG17b9tHV2YruoiWIXuiS1hBS4XsYuWorEH+zYiLpcrIZIgqXit2l5cDU5DJsN67WvzC9g==
X-Received: by 2002:a17:90b:17c8:b0:311:c939:c848 with SMTP id 98e67ed59e1d1-3123efae69fmr3575677a91.0.1748580656408;
        Thu, 29 May 2025 21:50:56 -0700 (PDT)
Received: from localhost ([157.82.128.1])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3124e2b67ffsm426290a91.5.2025.05.29.21.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 21:50:56 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 30 May 2025 13:50:11 +0900
Subject: [PATCH net-next v12 07/10] selftest: tun: Test vnet ioctls without
 device
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-rss-v12-7-95d8b348de91@daynix.com>
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

Ensure that vnet ioctls result in EBADFD when the underlying device is
deleted.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 tools/testing/selftests/net/tun.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index fa83918b62d1..41747e1728a6 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -12,6 +12,7 @@
 #include <linux/if_tun.h>
 #include <linux/netlink.h>
 #include <linux/rtnetlink.h>
+#include <linux/virtio_net.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 
@@ -159,4 +160,42 @@ TEST_F(tun, reattach_close_delete) {
 	EXPECT_EQ(tun_delete(self->ifname), 0);
 }
 
+FIXTURE(tun_deleted)
+{
+	char ifname[IFNAMSIZ];
+	int fd;
+};
+
+FIXTURE_SETUP(tun_deleted)
+{
+	self->ifname[0] = 0;
+	self->fd = tun_alloc(self->ifname);
+	ASSERT_LE(0, self->fd);
+
+	ASSERT_EQ(0, tun_delete(self->ifname))
+		EXPECT_EQ(0, close(self->fd));
+}
+
+FIXTURE_TEARDOWN(tun_deleted)
+{
+	EXPECT_EQ(0, close(self->fd));
+}
+
+TEST_F(tun_deleted, getvnethdrsz)
+{
+	ASSERT_EQ(-1, ioctl(self->fd, TUNGETVNETHDRSZ));
+	EXPECT_EQ(EBADFD, errno);
+}
+
+TEST_F(tun_deleted, getvnethashtypes)
+{
+	uint32_t hash_types;
+	int ret = ioctl(self->fd, TUNGETVNETHASHTYPES, &hash_types);
+
+	if (ret == -1 && errno == EBADFD)
+		SKIP(return, "TUNGETVNETHASHTYPES not supported");
+
+	EXPECT_FALSE(ret);
+}
+
 TEST_HARNESS_MAIN

-- 
2.49.0

