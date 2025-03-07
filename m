Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31762213229
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Mar 2025 11:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345319; cv=none; b=srcy9bDCkgxfDBvA+JSZBASIuPuICQ5rLGjN0fm8uqiXy714fMitEWxJwnwrEuAY+u6nxyYY6H1fNaW+/abPUo0IIW/P4Fl1kCsMoUUMUgSOumCgqlCTyq5KUdovsfU1OBLT+Q6F28KiikuVCBXyB1ye6i8pKsDqFJFuSVJ/aks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345319; c=relaxed/simple;
	bh=l0j9792/xprRDyqQ5vGaOT0IcUNGmsCkmjGv84fkI2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=JLL43JJLGpN4cFLKpxa6QtFlDLhgB18JG9390WLq+ID9hps7E4IgPhtiS+gaUY6pqArcSbW7ovJpOLX+457jf9/p4mobFPIPcqcGhThcnQJ5oLJAtze4Gh/oJA2i7BbRM28mKNeMbIzYjaZyLUn/zEsGl3CfNA+74eqzt37L4hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=BsdTNri/; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="BsdTNri/"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B86BF404F5
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Mar 2025 11:01:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gf1s3pgezU_6 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Mar 2025 11:01:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CE090403C7
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CE090403C7
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=BsdTNri/
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CE090403C7
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Mar 2025 11:01:56 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-224341bbc1dso1391195ad.3
        for <virtualization@lists.linux-foundation.org>; Fri, 07 Mar 2025 03:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741345316; x=1741950116; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gARYsHMNOA21b7LAy/uTvYtGV6sZQsjc9PX6HaN/qGk=;
        b=BsdTNri/l5bfn2liaw750wP9/RoJooKAhAm0w4w/ho+sey4Uwt42XMET0bQIb04468
         s3huIDCPPUJXwRtTzTmoKGrAz+zea3t3fBQXpOTrOLxN7hp3E0VPAPnrXw+9gGqO6FBZ
         KgbLWP35sLlFAYFQnqykFwpnMhm4xJb5FUj0kTL4pp1HYLZOiY/ZcUQYwnMXUSTtsKGb
         jKi9ZC4F9hGeUQT41byGN51jFQgeujUuF2pzGEGaWxHP55e2quK1Uk0tD7MMbiW9nLFi
         Vr803vAugeGLiTqqN35nW57c8Jk0OlmSV4E6JVzs/l2JC6/07YsXzTEBVB/R928Qjfuk
         oE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741345316; x=1741950116;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gARYsHMNOA21b7LAy/uTvYtGV6sZQsjc9PX6HaN/qGk=;
        b=kSxT1tv4XvoHB1Bo0bJ8JHWN3//5RvcTr47PkDmbnBKVv/uNfoJPw1JLAEeGbuj5ws
         Z4se2XdwEGAa7w4DibQuIHYTIiS50Sr+Tjum8QJQufuLPAv9H9OctSX9pXD21td0GkP1
         mgcX+KK9PfN5rNfeh+MwujakMJrvHqIRKZJ+xVSydshJVZxRv1xjpa3XryrY9u+E86Df
         mO0ZBoqsIiMNCxGebBlxaSJ+uLn+97TEUofXKHbHleaBDe0by6G3jwiMfaOpLl4vJGGN
         VFG0xf+GcO2aSygSK2+DLQoEY4rY8QOvWqaJkMpeH0kdJjSegChB1DH3Jz5aI0DKYWi8
         Ux1g==
X-Forwarded-Encrypted: i=1; AJvYcCVGTd8tt6LS8GFYdxjAF0KLzsYP23ACF+SsCk4jvUzvt48HbISdI21iTMIy4SCeII4gZu6PItVZuLGivjeLLg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yzvt+BoXeaGymJRry/KYC134L11hTIaAUB2j8lmESsSz5rqKb4G
	AjJkgs5+R0ELIeQX0OMCN/VjJ4AK3b5TF0jcO0IXS9nzYcQEr1vsUSq2AxsLfYE=
X-Gm-Gg: ASbGncvzJLi1jgyYLuc/kqDWQBh3w6EUtigWyJqlHqkV5VBw4x1yJ7aAd+k0CFlQ1Z6
	Sj5K43P4cWLwpC1AOy57FY2GsFF+o44Va4UdPEXMqvELCwDmcEHjZW8GY/GmY/JNFJUzh0I/T/9
	ozEIaGeoS9udU9vF6N7Bhr8Jp3nbERLi6nV5vWNN/y2KP10OgubUAMW6XgICyYtf8Sr8/UJgb20
	FDBMKYZvxvUnFNpmO+GPOSBlTCIkf/rZw+T8DVWYaTWv5nAeaIMs6ANRosSK6PmjnYgNqOredCH
	ptkesnoWkq37TmcnR0dDyL1RkmpqyGya69HhSp86t28I/6NF
X-Google-Smtp-Source: AGHT+IH6Rro8mN+N9sKA5KMUIdPn0sx3wUoBP7bD6XVcDcfe1R7X1FzMRycZ2IlvjtAva2HNtTHX/A==
X-Received: by 2002:a17:902:cf01:b0:223:5645:8e26 with SMTP id d9443c01a7336-22428887bbdmr46153055ad.20.1741345316095;
        Fri, 07 Mar 2025 03:01:56 -0800 (PST)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-224109df225sm27431015ad.47.2025.03.07.03.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 03:01:55 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 07 Mar 2025 20:01:20 +0900
Subject: [PATCH net-next v9 4/6] selftest: tun: Test vnet ioctls without
 device
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-rss-v9-4-df76624025eb@daynix.com>
References: <20250307-rss-v9-0-df76624025eb@daynix.com>
In-Reply-To: <20250307-rss-v9-0-df76624025eb@daynix.com>
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
X-Mailer: b4 0.14.2

Ensure that vnet ioctls result in EBADFD when the underlying device is
deleted.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 tools/testing/selftests/net/tun.c | 74 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index fa83918b62d1be1c93adcd6c2f07654893cf97f8..463dd98f2b80b1bdcb398cee43c834e7dc5cf784 100644
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
2.48.1

