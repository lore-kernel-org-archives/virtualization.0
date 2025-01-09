Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FCC215165
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 07:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736406879; cv=none; b=WfIpiGNk3wLrGMIfy5GUpYeD1Jp2DdMJc+9E2FY3TYOzcqV71wlwG4sZZY2SYP/GYi92lJI2Of95HCv95C+5IjXVuZaTNzKt1vIqmR9lncahyfJL+vC4kn27zSmtEMdYQxW+jnw51tarSHHU6rDvcW4rUj58aJf/jL2/P6bZ66E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736406879; c=relaxed/simple;
	bh=bKMEvJwhH14xg+cNxuCNztQTA+YdMMHjdpgOof+VPTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=VnimvGZ3S595hu+eT6LI3dTJWikcL+EZKrt4R/7HnpxRg3IhaVDYtvur7ErwexqqhSIaFeRccltnwdgtf4P5TVlBfvnxP4NfbQT9kTPz4Tv4po+GbG3sgjo9rL9l0kgAWc0IoanX0L4jACM1vorTC0HLCYXB9YAjTamKsYEzTaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=O91URsBT; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="O91URsBT"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 18CC2402AC
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 07:14:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C9YWCjYh0iTr for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jan 2025 07:14:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 32F9840345
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 32F9840345
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=O91URsBT
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 32F9840345
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 07:14:37 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2eec9b3a1bbso821960a91.3
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Jan 2025 23:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736406876; x=1737011676; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O5JVItUDqWznN3D/qkeD3NuSCrOvt/lnTEOCr915p28=;
        b=O91URsBTSqvk4WGfsUjpVw5CVS5OVRKhbZOsRNQJFSsLVgP5Nkc/KAzagy9k7GNVUp
         W9QKBe8UzOblKL5QHEIf2B6H/a7kF7FDJMHPJa6VqUaRZscp5+MLHMsooZ1FcypVA7g+
         YXLU2V75PqwLEaV4tl0MiumpGSkqHyDP9LJPgN4BurP2SnRg4ZgSYSXHS2ShFNPx+J5b
         36HXDaV9v4WfDj9uEXwMKGzJwD17CyU54C93lKRHsanjRYr6KnzVzKAD7wIoB26+BGVh
         Wpjq+cRXEsA+ihI3tNuViRus6bH8kxsPUPAub1l7HdSNKmz+VXtIt3Efey9JxbbTRKaD
         JtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736406876; x=1737011676;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5JVItUDqWznN3D/qkeD3NuSCrOvt/lnTEOCr915p28=;
        b=NoBXL4gZJg/YEwMXd4cb1+/21+GRQgCCyIvT3XUqiIWalzjAucqGwYxLxLzlyR4XdQ
         8W7Q9pOrFdUcAc1mmtqtt/5vBg1Vv4ceRbcXuSXthYTQAW3EIxTCtwCm8V6iY2D6llJn
         h3EcrGatkqgoE2WeBAa+u1uU1l1sMBd4EalAOgeT6a68FdMycR1reZLasg6NJ2nIljg2
         CWro9e6PwIc9tw9xkMCX6Hz/qZdq1eymoSeXDJ2rWG7QlR1Ukk/sZUQjuQSHzULil3EG
         9ED3KcbBZxPW+yvzHeZkPhBThbMNRIWYM42j6vMx4veiDK86g7ulRLMWLGF8CsLx0nHB
         cIGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBwYsxsAWigftxlmn0L1Gq5C7sIgDQ8SS++6OlcS4fOEmE8nLUwjFyDsjtAxz98MONzZHSU9ayzDZfeqqzWA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxKXpBIOkPsZ4chFBkPMRodo8WQUWzNRXwc4h/AGaE8Obw4nA7O
	Y91j9JXeclCkASEo8B42jLhIBQyacoOke2nt9x0cJaMhGiy20Jkn/zqdmfbTESE=
X-Gm-Gg: ASbGncuplAU9QYvJmIcVCaPgbfTHEdyBR3U4FBzT/tfzkyvJr5ywuxdZhnSJN+KURBp
	NFB2jMI4L2aoqhnX4he7Fhd/NCGmb1pPNNtK3/nKw/JaI8Gwcb2tzkJLOFV2bySUigfVghpzihQ
	9NDkJHSCL0jZ2Vdgl6yTBfGfOU1aYnc7uRHTkfu0ynsTZ8uasY9Xb3/ZfsYB5m4+wb5Uop2sM0A
	3pMjYXDzYiyYqTdb+3aXEu8zKCVxxI9ffyAjvoov+LldNDzkbqu9xrxULo=
X-Google-Smtp-Source: AGHT+IGPJuUGyRRURc1qr4TS/2LI/qWJLc1yL6cIE0cCrjfybxEqzid+tHM9XM8b4Qxi4Ej3H+L8mg==
X-Received: by 2002:a05:6a00:1a89:b0:725:f4c6:6b71 with SMTP id d2e1a72fcca58-72d21fc0b36mr9799011b3a.20.1736406876527;
        Wed, 08 Jan 2025 23:14:36 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-a317a07cce2sm635365a12.4.2025.01.08.23.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 23:14:36 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 09 Jan 2025 16:13:42 +0900
Subject: [PATCH v6 4/6] selftest: tun: Test vnet ioctls without device
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-rss-v6-4-b1c90ad708f6@daynix.com>
References: <20250109-rss-v6-0-b1c90ad708f6@daynix.com>
In-Reply-To: <20250109-rss-v6-0-b1c90ad708f6@daynix.com>
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

Ensure that vnet ioctls result in EBADFD when the underlying device is
deleted.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tools/testing/selftests/net/tun.c | 74 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index fa83918b62d1..463dd98f2b80 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -159,4 +159,78 @@ TEST_F(tun, reattach_close_delete) {
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
+TEST_F(tun_deleted, setvnethdrsz)
+{
+	ASSERT_EQ(-1, ioctl(self->fd, TUNSETVNETHDRSZ));
+	EXPECT_EQ(EBADFD, errno);
+}
+
+TEST_F(tun_deleted, getvnetle)
+{
+	ASSERT_EQ(-1, ioctl(self->fd, TUNGETVNETLE));
+	EXPECT_EQ(EBADFD, errno);
+}
+
+TEST_F(tun_deleted, setvnetle)
+{
+	ASSERT_EQ(-1, ioctl(self->fd, TUNSETVNETLE));
+	EXPECT_EQ(EBADFD, errno);
+}
+
+TEST_F(tun_deleted, getvnetbe)
+{
+	ASSERT_EQ(-1, ioctl(self->fd, TUNGETVNETBE));
+	EXPECT_EQ(EBADFD, errno);
+}
+
+TEST_F(tun_deleted, setvnetbe)
+{
+	ASSERT_EQ(-1, ioctl(self->fd, TUNSETVNETBE));
+	EXPECT_EQ(EBADFD, errno);
+}
+
+TEST_F(tun_deleted, getvnethashcap)
+{
+	struct tun_vnet_hash cap;
+	int i = ioctl(self->fd, TUNGETVNETHASHCAP, &cap);
+
+	if (i == -1 && errno == EBADFD)
+		SKIP(return, "TUNGETVNETHASHCAP not supported");
+
+	EXPECT_EQ(0, i);
+}
+
+TEST_F(tun_deleted, setvnethash)
+{
+	ASSERT_EQ(-1, ioctl(self->fd, TUNSETVNETHASH));
+	EXPECT_EQ(EBADFD, errno);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.1

