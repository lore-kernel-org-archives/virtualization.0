Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9930F1EABC0
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Oct 2024 06:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370525; cv=none; b=Sv7ynKjmqy/GMESuAGH/01Lq6Q3s80yiGSlljRV7Pfdm3+yIzITER64OqkRbpgdFjNDHHqHrs3Zg4sBSEi760qctR22deNuAdUtL+HdJJSuWZPD6HG3mLu9fZS8sDkzUOQ08ots8FBLYho5PaS63WSmCHEH9gGmUfiY0ZTrZ934=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370525; c=relaxed/simple;
	bh=aMMcGMlIvM+5vysEFQY82Ld7Vd0lkGqNTVfE62GAxgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=od45wVy8AvyE+l1uf696kvm8c5hzlefNvqvokbUQObkFCi3d50x3VmtdOsQuC8FXRRLOB3rUhU63OoE/Szwx/yUGVGBTLICdYUg2tM0W3KixWi8yNlFGHoyMW7In3K2NaYxZSmM6xOMiLv2UdYA1xkoTHCWfzUYDrf/hASW+3+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=luEaf6M+; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="luEaf6M+"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45A1E40315
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Oct 2024 06:55:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UimOg0PvnQzF for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Oct 2024 06:55:23 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 527B140313
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 527B140313
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=luEaf6M+
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 527B140313
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Oct 2024 06:55:23 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-71df2b0a2f7so2336655b3a.3
        for <virtualization@lists.linux-foundation.org>; Mon, 07 Oct 2024 23:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728370522; x=1728975322; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+uKsejVxLmGPlZDZ2YAoWDts+QfkdC5shkCFnDsQphM=;
        b=luEaf6M+m9keP3RTC5IQwmiFwDLIsZwoh1cLx2GW6wsQ3QoVuLXziFdrPq5gjm/Aq/
         3B4jranJDTPK9TDXgEv+QI8TYt5ajnGiQ6MEtb034oUhGomQNPVpGe4o0+3cL0IV3mtT
         dLmt9bmt4ADgVl4RAHfKGyuxIwGwW13l1CHQkZvwiDORqoCJSURtwIKe7kR2rNP5rdrD
         2YzevKfc3E5kGK6gc2/HFUpLG1rkULN9TSmauRXJ0aHteS/6LigWuWSlbSFc2FcpkT+o
         +NKT/pPCopahsuzpiNJHTf/10pkqls0Rx/uqtaA3+gfOARBVqfNnHWlTl0clvYw9TnTT
         ExJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728370522; x=1728975322;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+uKsejVxLmGPlZDZ2YAoWDts+QfkdC5shkCFnDsQphM=;
        b=SVhQKiDxKXWH2ZVx4q28GMs29ZggbYQG9gevFduFnXY1uFj1B1JNviQXjkhu7RMEKb
         dhx8OuCZQFmdcv8WH6h66Fnk7/OTnH2zsE1iz6jFJ+d3bnggXrFDacl+R2VSvpgr/yDa
         /81MjPo3H4U1ZvhfREhxaPtTMKyOWqua0n+7zC0Nc+8uoa8jSdol/8KdM1PtWGAW2Wzz
         xVwibnFiBNYMMyAbTQMnpJi3LO44oAkTrJAdrvbKA4CZTtHOY5Y/VzA75rnmTNtcDY9q
         RAtYTDnvsINUl+20MGFz+oyyG8GOJjx7tJy1jwh87NomvURwuUiBJlTJqO1ALBtq9r8s
         wy/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVI4FYMXwj48xQLxo/fMevE3LF6XzPY3JkKBoYaxDVugKBVvz8PAulOzr+HkBkXaPaH0u4sDa/uDIdooroS5g==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwKG3W7w13ctXrCtIHz3WY4ffrPt8AHCBUKtMRq59TdjnqA4y3V
	//2z8jIolyQpxsvhMY3mQBMSC50J3VG7FOurKr9mw39f1VTF4t6FPiWOfzghVjI=
X-Google-Smtp-Source: AGHT+IHpl6coI+ZO3xm7Go5SLIOAf4hTK2yXXSof1uFkX8umSQONLP1U9ZQGcbX4LKYOwCaQ5jp55w==
X-Received: by 2002:a05:6a00:84b:b0:71e:183d:6e74 with SMTP id d2e1a72fcca58-71e183d789bmr246332b3a.4.1728370522610;
        Mon, 07 Oct 2024 23:55:22 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-71df0d65246sm5463299b3a.169.2024.10.07.23.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 23:55:22 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 08 Oct 2024 15:54:28 +0900
Subject: [PATCH RFC v5 08/10] selftest: tun: Test vnet ioctls without
 device
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-rss-v5-8-f3cf68df005d@daynix.com>
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
In-Reply-To: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
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
2.46.2

