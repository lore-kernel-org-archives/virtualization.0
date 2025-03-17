Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBEE23ED7B
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742209135; cv=none; b=MBrppp6HSrFs/bKsEHzvH7R03yqu9BbEWY+cu9fw++FWoH8B9DyyN8raZy+7JHBZvk2MdF5vf/TFL3Tktwgn42DnOCy/jbM8qaISONnGe5I/amswIar//2gzKeQZ+TIo9eRaRQYW6jhHDGvpvC5q/t4cNVPXefk/XzjMpKVflXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742209135; c=relaxed/simple;
	bh=GneHmk/qL//iBdk3HQU3hkToakkrBvwUGgglHdEvMAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=mKE0ro1ou0ti2QyJo3TvJFLBTLnrsdX1mopDvEKgdUxhybsWbzW8Spd7pTE+XZtUg3aEo5ZEwBkhfNZnTncvXZ3Z1lv8cC8bvvITKYSJuaqrj+Pos8mJKC4FUyuoo8d4QpqklUBnjOF/4sBM3PuKq3yev1XWAV06rE8hWaZzwEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=uztwHrkI; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="uztwHrkI"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B529960AFE
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 10:58:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pEPdLyUgCp73 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Mar 2025 10:58:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 17D8B60737
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 17D8B60737
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=uztwHrkI
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 17D8B60737
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 10:58:51 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-225e3002dffso36559285ad.1
        for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 03:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742209131; x=1742813931; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tr9XV/m9Yn0vfZS8el5Q1nXWgm/+NfgkMX4LFmMiC1g=;
        b=uztwHrkIBOavV5aFr/NWyA53FA+V+otHcBpZUdHY4CELHHxeLU4DvmKl8nB/D8gfIA
         OdazO9jWmvragDd0QY++Ynd/PuSp06ck3Ixf9PINuqFNaoAHgcXQ9GvknPAod2bZDPuz
         ti4JyEC5KgjbwvH3MWfm0ylAVOQHYrGS+c8RiZ5rSXvbGxfpJ32ehTrZGepmCOwh4MVT
         MbufW2uFAfByP97wR+BjSAm2F7PI63KZ3nfrVtJV/JTZEq97HCcDXt3rQiOJKfsyLvDW
         Ydu9XFjXQlouCVvPJQIDfNHoI2EargH215i3D6fnusdB0RELVHw5QOyZ5LWXE4lNKQ7T
         VIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742209131; x=1742813931;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tr9XV/m9Yn0vfZS8el5Q1nXWgm/+NfgkMX4LFmMiC1g=;
        b=t/cJQRdjEdFXf9o3D9nXOH84DfHUKAFuKVdNzVSxAjSHYbN5DqaopV122axvGRM/of
         GWAUGQHzarBl84d3kt4o3qey8q+c6yO92FqGfeAvgV2PH6BLduKeyRyinLOb0M/X0BQY
         97PPzEQ4s56M9ol/0Zol7UAwpDG7LCwoGh0TmcZSNj4kwB+585UQJvd5GyhGt5itkyyA
         pF9dHu+5hXB2YfDRJLjFr/DL3K7UgdCFSW9180qKl9cJSJHETUsnwHOIMEXqMHwty0hp
         +Hucv7ql/Ewl+pBkLAvbK2aWMtg0XjWvsQeiveCdHRerVkS2hzxTHB2/CAO2xJi62XEh
         IxPw==
X-Forwarded-Encrypted: i=1; AJvYcCXueHhl9XLLPaL9D7e9T4xfQHqSoPFeEOLRdceIt+nWgNigbjt7jI3B7Ivpjg/q0J6iN/IizBjy6vBBrzy6vQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwQIIdsw3W/tRMv/sozykGUp/IaTvZdGahv500plR8s3IJYTDd+
	f0p7bG7j0VjIJUKc2P4MDP0TeOc5iga1Tm6rrEsJKSulRVkl+2RI7YrzWY0eogU=
X-Gm-Gg: ASbGncsS0dPeyAnTF1HQVBqVOZWvIOac9ufdMpQQGfv37BtzIsCyeIfsnb5W4JqJb00
	hmyfGUte2r2XZnA671kYAqkD+pXCjUk8VMppiFJeRhSRP8SibQuU7UoDVxe/DhrDhiXglkcEayE
	vnQ2xcU0U3X+Ljq2NhZ5kKdRNXIu3tauTYRJlSofjdZ7796Qcojppog2JF+K1H0aqTrKCVVPzy7
	iWf50H+yCy+gprIopX4htazU5WMMcJPynRmqlTvkSptjuuvi/T4Db/Zg5qWB9tEwotmxS0YPTBN
	lbxvyjJ/SKr1P1jwhGoXiXTeUGtFlsNowwQQeSsjj4+C66Fs
X-Google-Smtp-Source: AGHT+IG+ei/lg8cM5wfrSZJXqZa9osmFd7Sc/z8/9LCogmJrZABRCUzflnBMKqILkfW838r3yRiXfA==
X-Received: by 2002:a05:6a00:2e25:b0:730:9801:d3e2 with SMTP id d2e1a72fcca58-7372238e7d9mr16744723b3a.8.1742209131380;
        Mon, 17 Mar 2025 03:58:51 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7371167dfa2sm7533712b3a.107.2025.03.17.03.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 03:58:51 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 17 Mar 2025 19:57:57 +0900
Subject: [PATCH net-next v11 07/10] selftest: tun: Test vnet ioctls without
 device
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-rss-v11-7-4cacca92f31f@daynix.com>
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

Ensure that vnet ioctls result in EBADFD when the underlying device is
deleted.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 tools/testing/selftests/net/tun.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index fa83918b62d1..ad168c15c02d 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -159,4 +159,42 @@ TEST_F(tun, reattach_close_delete) {
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
 TEST_HARNESS_MAIN

-- 
2.48.1

