Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EE720CCF0
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Mar 2025 09:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741255047; cv=none; b=bx73NG8N6Y3Fr1ZR/Sfumr9NtV7V/w3TdVIDKrnttPRJB+mfRBhrGYYptbOP0bsWU/oBSANSJD6OpXLSoQvfhsPckjss8P0PUkas5sXbAAia38I4VnMO0jVts4KBEWAZTATeTPR4eNeNRpAUjMc9vrKAtuh3EWrZGco9aXqurTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741255047; c=relaxed/simple;
	bh=nEE2/C77oF+j3LxMBPOVoqrwqXRBAnjdJN3gCt7XvfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=tKqwXGj4AoWY/KBp+ZdYOF5WJ8g7Zf9mZOeNy64aA5JxfT+Hg7XraerXiee8H+/+YqWz27TSWw/hnHpT5Mfg1HM7V0N6/XVuLzU/7xEkY8Uv74o4ehNmJPFkZ3JjLvxVkbHKWK/n9scZbTL3bYQH1QCbgo9ItVfuXauwIzihous=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=NgtsuDtm; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="NgtsuDtm"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 844E44048A
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Mar 2025 09:57:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wf4Bdg3d4tn7 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Mar 2025 09:57:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8A13E40443
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8A13E40443
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=NgtsuDtm
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8A13E40443
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Mar 2025 09:57:24 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2235189adaeso7078995ad.0
        for <virtualization@lists.linux-foundation.org>; Thu, 06 Mar 2025 01:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741255044; x=1741859844; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/24Tf2dJCQDhe+eHaFoVGEomrBLp8dkxojt6Qs+7G8=;
        b=NgtsuDtmWAbnYdhrAyZh+/aR3bfRhr0QPZ7XGPIhyWjEFdTXuH9VphHDh2Qg1hygQl
         VqsOVMgY3DN4Sr4McGwGTbPc1axZtSCATAf1Z3HheeUGUSAKg234YGPSM98IIaxlgDA+
         VlpGycZTgoHHQzZYTz3tNBD0IDQgAWM2kBxfakMz8Tc0Lm/8mPWEdetU8kC+sGi8+jui
         B3Ow/0BEu+6V4awPb/lk2apHGT5yCQxYmBYwildhjbcQW6CqOBEuD+PECtdBAFNLf4PC
         VoDSM5QH/ILo/Ns1hAXGH76+6A7S+QxuG4yDonCM3UgGMKQxy9iQrqGjMf/ivUSqFsIT
         qeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741255044; x=1741859844;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/24Tf2dJCQDhe+eHaFoVGEomrBLp8dkxojt6Qs+7G8=;
        b=gSYKFOZ6HSsu956J8dxH1mYyAp/Ujt2ZMJS0B+JCTf0Z71E7CrJKFHNwES9t2yWxjQ
         b5qQhrn91jlAc8+n4TAMqABrjT3kB4RY0hHLxwk2Mnb7GGidf7jUgL/R76UHMMrGUHvy
         cMwe0IpeBglO4xbWQRBQr2iRA1GeDlbkt2aBbpCvVIM84FOhrvI5ULWYZ2IiGDxFijdX
         dHIH1a1o+vOgl7aiD2F7iUU6pikV7/AfV9LgKt3g7eRn/5UpfLx3HBb1/OwwVsPlghob
         rhBle4X5G8JaxqIaQL9ACgpyEK+NC4ul9/+llws6tcEgc6ocC3o50x2bThs5IYaETuJq
         Z/RQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2qTiOTXlKKYMYEnyD4AtVzhE8xZ88WXVqA3wtl1Azx00vwDTmdFIKq8LruqulA0wvhiSi2udVqFvsh7LzYA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yxr2CzCj5XGWfJ7PeO9K4cEkaue7Cd7O0RcThyqqrfFpMAVtKsC
	CNf7mZAsjUzQpnvx/DouavZYKdczoaTRJaeOM712YP2nFbcQ81HtDsD8d4n3Q1o=
X-Gm-Gg: ASbGncvlIyaQ0Pz2qNftGU6TexjysiTR+JjcC5aWI//nChpcVinZLpkpNibtr1JHOAV
	+DSjISuPbFSHwZCO9ciqqt/Bvp2hzGwIuY3CGq5FKNybzHQZqXsiZ+bgdZjv4CRgf93xBzWuN+s
	2YvsnsTZ5EBRhTlT+/ZEcuDVWgYJPAfZff9FCTp3fBumK042r2MohvP2M5SXPGGsenJxUOvQPfm
	By3FUIRw54fJpNj9wSSwQSSWYHpgHOTIVjV1yvBHPffSbO8l1E9KcGnLzt3YWohEwxcRgNoRsif
	Uc2eaXoGU6RmBDaV67f/YLw6TE6tgvpadvDU7gs0Ri77evNv
X-Google-Smtp-Source: AGHT+IF8DbatJk1Q6ANosIF8NkNqX8HFE0PqKk+dfYmnjOrPC/QDLXisFNDJhmMcDSA8YlhDXsU1RQ==
X-Received: by 2002:a17:902:ea03:b0:220:ff82:1c60 with SMTP id d9443c01a7336-22409426beemr42036455ad.14.1741255043950;
        Thu, 06 Mar 2025 01:57:23 -0800 (PST)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-736985387d3sm943032b3a.172.2025.03.06.01.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 01:57:23 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 06 Mar 2025 18:56:34 +0900
Subject: [PATCH net-next v8 4/6] selftest: tun: Test vnet ioctls without
 device
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-rss-v8-4-7ab4f56ff423@daynix.com>
References: <20250306-rss-v8-0-7ab4f56ff423@daynix.com>
In-Reply-To: <20250306-rss-v8-0-7ab4f56ff423@daynix.com>
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

