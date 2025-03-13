Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9BC2045A0
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Mar 2025 07:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849333; cv=none; b=Zmqdbugp/kcvw4/9L80Bm9cWudg/4OWFhXSK4oadkxpaSJfmbqJhTp1q0PHcDzxByJObe4/82QFPrXyyd9B0qbT1Jlx4sbGf8PSWocCrhzxLeo5Vwoc91aQ7NTib2BJoWh1F4kdtg7Tu11GEtVjmnxGv2xSJZEn+dQajHFE3/e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849333; c=relaxed/simple;
	bh=GneHmk/qL//iBdk3HQU3hkToakkrBvwUGgglHdEvMAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=amjK3baKDFK7be4Ivx9YqG+59mzKhBLnCot+fosFFaH7ebDlrxZXgi+FfUDsJHMmbsBELt1qAB3ls8rB3G70gM3R2067OzWDbyj8zgfrEgTiWBo0tfIZPluAnkFpm/FI/zs/DzXRfVLurMfilgT4yhNCSslJhsR8sbwr7ztndqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=QwHiH2mV; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="QwHiH2mV"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9816580B16
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Mar 2025 07:02:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ofh7pL7Gl2S for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Mar 2025 07:02:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E625A801E4
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E625A801E4
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=QwHiH2mV
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E625A801E4
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Mar 2025 07:02:08 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-22403cbb47fso11884705ad.0
        for <virtualization@lists.linux-foundation.org>; Thu, 13 Mar 2025 00:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741849328; x=1742454128; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tr9XV/m9Yn0vfZS8el5Q1nXWgm/+NfgkMX4LFmMiC1g=;
        b=QwHiH2mV5+ARkl8iJ1bO+d0xY/oKFLv5Pfl8W+p5y65LcnMKTfm+Wt4q3ZupTcpC8r
         zFaQHgq0sttbVI61Dv+MMEbVjYxZ7V+LX0NYnRzWhPsuHjkfAZmxh1Qx/z85tVVoCLDl
         Nl34sFazM1s8V8awmgSJ7b47rBaZN0ex/wTpuIOxYrKX03zVW8mzXfkMEdDkKDHDPv4F
         NMuxdDe3dGUZ3qQu2SZz/C4vUF86QIVS3rNUS3lLc2D+DjTuoA2xdODqeCW/gzMSeQma
         rZsNIpdamX0a5epDz6L5n6sCApOZe1mSXLBr3Q9GH9yWKtk2nuell9mXXctFzcMRSJyl
         55OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741849328; x=1742454128;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tr9XV/m9Yn0vfZS8el5Q1nXWgm/+NfgkMX4LFmMiC1g=;
        b=X5HAMMCqQeGIaOdc5rgpN9F42xr9oTWbglYSCW9OAbd05rlJcP9xiU4c1sG6NJOQBn
         +sYOJZvNmTr8NjIgS4u/2D86t5MS6XfiQwT8aPx5wn2d3Xy9Oa+pLi/RpqiP2RPRH2y9
         4g7JMVlDQmPuJZiMaZFrKR53BFSl1KBsJdQ/azOyHMm2TiE0P6kBbe3XUUhmRBwPIHUw
         0359kMSLinYvJpOuazW6oQMPXSthwRekrXTzK7+5z1UZpQ6CXPVxGJf0Jr3CYrGImEh5
         63xAMzz1GC40/5V3yPvmPhPTUkD4vVnU/9LWOZlZPVZ7ebiADLStkFu1bYx4APgoViOI
         ZV0A==
X-Forwarded-Encrypted: i=1; AJvYcCWzbS50cCtsYPIm4lbg1zzgyRIWgC1icfF3JKc4KjD2cZgoDluJ8WfADkiBUzIM8x0ov8vbjm0DdgMfrxEQTg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxMqpnI31umCeZ+BkOOXrkGsz9m0HzRTHad0wnAHv8D/dyJiLNn
	GqYwpR3cd1wIMhKsEPbHi4NRkjdH162ZjRylVk3mUPZFop+6MtiPhrpL7mVIdaY=
X-Gm-Gg: ASbGncvfnukU6gj5vMsT5Mf525T+tSdtw/M7mkD9OShJE+yM4kkqDcBo9MnROd0FJwC
	DXv1ZqdmyAeRgFgiMWmcG0EV9dIPB0l0f81r/zdwmojVVMqu0Uk2IK0cojL30UTLveY80FG12Rv
	r9dTrOLlM8rnG2Q8QfGKmveEyP3EzTEv7glraSs9kQ2OJ6EtFVJaje85iDbV6a0eyappvZEr/8T
	kKUitGm4tOitSrJmseqv1ewfC4Soxi75oInJy+6vTu8q5ExmPA/3A+7PeP4rATiXfS8lFumPFWD
	oDVOoXkEaIui0R+2S2zTxtfIK9d9JtZs2njgzgyoVMG72+lt
X-Google-Smtp-Source: AGHT+IELBqab1Bv03Rmb+11tOmP6uVWtb9Wp6RhocPBZEFYo+tXlKUya4SfhZrxV9fTmHmtnOCET6w==
X-Received: by 2002:a05:6a00:27a0:b0:736:532b:7c10 with SMTP id d2e1a72fcca58-736aaae81dbmr33112877b3a.21.1741849327993;
        Thu, 13 Mar 2025 00:02:07 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-737115293f6sm662442b3a.14.2025.03.13.00.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 00:02:07 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 16:01:10 +0900
Subject: [PATCH net-next v10 07/10] selftest: tun: Test vnet ioctls without
 device
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-rss-v10-7-3185d73a9af0@daynix.com>
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

