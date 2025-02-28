Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0D21D61BC
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Feb 2025 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729571; cv=none; b=gGAI7e6LJIPJqoARDJfGmB3xQheQXNlTTjhRp2GH1/vpzTA3+xGJKYwDSxpbXZuIozS+pYM6QSU7N+9rZk7iZ0TWGe21VV3SSiTIk8nZauim2nM9WaLL1gR/fyzAqd9JdMbeXQgK1lNuPUcpFpiZMzsFU+1TZi6z1lkgn4u30Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729571; c=relaxed/simple;
	bh=nEE2/C77oF+j3LxMBPOVoqrwqXRBAnjdJN3gCt7XvfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=V1y2KC/d5CdbWMfZ8aT6LVQ9uneFmssX6psfAD7YggpjyrjiB5QryIPnZ9ucpTax4Oo33tmRD4ssyPmON2wHyO7dLDZFVwXVaY9+zCb+F/zwEgEDCc00wh7H9G0xZBf63xhfAJrlz7XOi7fLOS7avX9tskZhPIqthBhlU2zBDpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=ADkMuE51; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="ADkMuE51"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 18D9140D7D
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Feb 2025 07:59:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cSGM-QWlunDe for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Feb 2025 07:59:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 255C84000B
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 255C84000B
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=ADkMuE51
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 255C84000B
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Feb 2025 07:59:29 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2fea8d8c322so2887296a91.2
        for <virtualization@lists.linux-foundation.org>; Thu, 27 Feb 2025 23:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1740729568; x=1741334368; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/24Tf2dJCQDhe+eHaFoVGEomrBLp8dkxojt6Qs+7G8=;
        b=ADkMuE51EXGBBrN+600ln8Pk0ItCg/buAiGe5YVOKmp8EbYYXBy3BKP4xjUD+yegdh
         wdovTIGuWqjEm4ByfhTNzB4I5+m0YT9MpwgTmRc8ZrwCTzIeA5nOC/Yi8Fty0LksSx4K
         i/2JTMc11Ha08lW6TbcAFdmXhQLGQ2HwDMfhtKkS+tMpf2VFhEE/P1B8jt4/QvrfSeVC
         Yy6vRgyl9SiqamGtyUR+ZQ8QUKXlJZtYxzsMe5wmqpwomOAHAdhCZjKfOkYbGCShFcY1
         JqP/rXaATS6MuGaanIFt95Gz+wtVxeeeoCw7tL/wUoa63trGclGddmkK2PV3Hkiu5WPi
         gFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740729568; x=1741334368;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/24Tf2dJCQDhe+eHaFoVGEomrBLp8dkxojt6Qs+7G8=;
        b=OXvtfi4/yUQuFP/xxTG1CQeMk4k7eOu6DjFwX5LB9mXRS0cb4sPl/ikDLfQzFHCXBl
         P47lVbxU/0IG/qG2XmrxT39P7nFW+AUf7RV9QBq+d5UowjOynilfh2V2E7TVIrFhJPsW
         wzYcu4Ul+S27gGuwrlo21ewX58iDIO0pNOOfZ9jP+BCzM8eDIpRc86BFY048M3TeW7Z9
         99WOIekZnTN5G3iuNfpmsv94xW0l3tIyGwfjV29jJNp36guXvBxgn+KIRuZMm6eRP2WZ
         jfhb5n78C1gUK4scwtpKhJ1t4BU1ebxLBGJv9nNEa+RxCKZOGg++44/E1ImAP0MBRVnH
         ZY5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7aKozknMy8iEBnlRxmmdDSF9UUY1jkpdf7aVR+SUQqDxMR7CBgJYWLTODSM4nIEdJqmD9A7279kW5kNeKtQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzghxDXlEep4S0/A9cveh8VuWvUOqLtqAr9FDboI5NkxSJ0qxbj
	iLl1vMxqNhH32VlRhbPBvajxWk/djdLtLzWy1ThHpLlq8xbQq/MFV4nQGYj3GT92MVpZEz3MnRD
	XkMY=
X-Gm-Gg: ASbGnctZqm1JB694rE3yzbHIQN04CMwi0/g8MV7U/PDEOzsFJ6JB4PEE7mipfkiri0H
	viyk5DZcQKkTxS0oYkZMf3ny2FgM/AzoLBd8qCvG18m8EACaQeDxIuo3x42UWwY4A3p676UzakM
	hRTF3nffb3awBBmDveuaY8heduy96yXYcjbRQRLkJtYjwatf/fVQ7IfTqcUQlmcDnqzt7OiGK2t
	V0FwAUL5TDkcxZlBGSzzHq3j6kTPPQOz2zUbwPwCoE2ZVvo/qvgnq+r4dfSz0U1gwKlZALEXWIB
	nca7QnOxQ7I3Bvn4H+LGbk+bT4XIbQ==
X-Google-Smtp-Source: AGHT+IGakArRWPozSXDLt1J/ZIr5ZW8i64CgVAq8BmJe2fBTFkpotPO0s0B4850yKyMXjttbX+FZIQ==
X-Received: by 2002:a17:90b:3845:b0:2ee:c9b6:c267 with SMTP id 98e67ed59e1d1-2febab403a5mr4261783a91.9.1740729568382;
        Thu, 27 Feb 2025 23:59:28 -0800 (PST)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fe825a9681sm5223275a91.9.2025.02.27.23.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 23:59:28 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 28 Feb 2025 16:58:50 +0900
Subject: [PATCH net-next v7 4/6] selftest: tun: Test vnet ioctls without
 device
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-rss-v7-4-844205cbbdd6@daynix.com>
References: <20250228-rss-v7-0-844205cbbdd6@daynix.com>
In-Reply-To: <20250228-rss-v7-0-844205cbbdd6@daynix.com>
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
 Lei Yang <leiyang@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2

Ensure that vnet ioctls result in EBADFD when the underlying device is
deleted.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
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

