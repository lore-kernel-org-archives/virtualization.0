Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823FE1A01C4
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251388; cv=none; b=VC5tKV8LhiLeUXSC5HcQWnam2XqnxNCAamBx6tgGBDTfoyPjzZvKrWnW1+pXmoNxYUBXZZ7dmP7uOB4LbFHhPI41vz7tWALT83JQPGf9cqq88O3lg4PEVZA1qZbrepnXTTFbBAmN8ioJpO8M/oNjCUomnEqu4vuf0UV68y7nxXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251388; c=relaxed/simple;
	bh=Ssjb3Uo4Iut5+I8dmIRqobRAiZrYRNHEz6Ht7+Uda/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tm8XbFvWGV1ciJ9J8DZbcnwV44EofzjbrEQRo/zQviTLWzabw/n36l9+3RJr2lvMQzgiQKC2jStyuj7AxWxJONe9ZnM+KyryxYOYBcm6xZQy4VjTPg78f9+1GdncR5k1wCmfbL/L2u3mhHyyrdRUpkO1DR3IRPPdv6fPDp4N8Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kj82nvb/; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kj82nvb/"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70675977d0eso1543280b3a.0
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 10:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719251387; x=1719856187; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mkH0vN6ua6Gjn09ocrkAPIaM9p5reMjO+llNAon/y1w=;
        b=Kj82nvb/BtaOA+i5cTqHwOh1AOLJFa8Th1wSwx6bxm+ronZEXzUqcxcCkSQf48uaq7
         LCBi6IzFhef6Vp/cfCoM2xlMN9dfq7uh08PtlKVKkc84mbXHpAtqalXIazRuzJUFiVqa
         KEm9yTj5D4NmWi37hUrEZRkTSK9silexfz9TGXjGSRZ5eE4EZ7PUjNNQ1xbxE/179Uu/
         GxDOyLOxN9r9Vp+yXe80X/Gs2dRK53qIhhLH2usm5FLP7/qLU6kNRiN/IoY+RZl4Mlpr
         YteuuLA/i2K56A5a9hzM1AaxS6ThcOwV+14EKp2BQt3DEGFh6y8PdWAV2WSwF4RYLpVM
         ic4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719251387; x=1719856187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mkH0vN6ua6Gjn09ocrkAPIaM9p5reMjO+llNAon/y1w=;
        b=W4O93HbAMHjXq01t71M1scZHSDhinlS9eQytj8jXJ32ltssT1V+Bk36F/lvwajO5HC
         XKxi92XuxVS1ebKi1Llvz7VTF7mHUpJ0vrpZJei42blGqr+M/iWdcsQwQu5pkgyBQ9Eq
         fogF50ezAn62uSm74ZG81F9AidVw/D3wOx3K1ZbSDj2VAlQAIq3ichsm7v8jYZLO75/m
         a/Mq3Jt4oDXgUVfXMlE36FiQgcHHg1yNtRoj/ybBApiq3pZBeWLxav7lqTfljx9i55/R
         0KMWgrYJuLsWjXJnGcUNaGB6IuO/obWuyCXy8sEmPQh19lPDbXqYUkXnM9j6p4kiX4P1
         OqwA==
X-Forwarded-Encrypted: i=1; AJvYcCV00Z962oZYHIaPSE7asJ4SC5Qaeed/c7QaHi5dbYhXSe6Yo6nM8YdV3lBlh266hL+fAM3QjB1WIWZIGMk1/+FDZPqj3HtVubWq1vT67a4=
X-Gm-Message-State: AOJu0YxHaRPDQs7nLk3nXPh/PcKcRboyhioYdy0G/C0Vo3IBLH7kaZSj
	ygTFTjNLT6jZyQTROmWNM927i1nW/qpT6Dni9TR5OIeN2c2dM46i
X-Google-Smtp-Source: AGHT+IH+svNIq4Zyd95MOOzrn+9RVplI0PwbRSAbMW2J6ZziscrSXG44QMEcN53Xd1+ghzGSLAAj8Q==
X-Received: by 2002:aa7:82c2:0:b0:706:6f39:1d63 with SMTP id d2e1a72fcca58-70674690fb3mr3975274b3a.22.1719251386616;
        Mon, 24 Jun 2024 10:49:46 -0700 (PDT)
Received: from localhost.localdomain ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065130078dsm6487825b3a.204.2024.06.24.10.49.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Jun 2024 10:49:46 -0700 (PDT)
From: yskelg@gmail.com
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: Austin Kim <austindh.kim@gmail.com>,
	MichelleJin <shjy180909@gmail.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yunseong Kim <yskelg@gmail.com>
Subject: [PATCH RESEND v2] tools/virtio: creating pipe assertion in vringh_test
Date: Tue, 25 Jun 2024 02:49:06 +0900
Message-ID: <20240624174905.27980-2-yskelg@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yunseong Kim <yskelg@gmail.com>

parallel_test() function in vringh_test needs to verify
the creation of the guest/host pipe.

Signed-off-by: Yunseong Kim <yskelg@gmail.com>
---
 tools/virtio/vringh_test.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index 98ff808d6f0c..43d3a6aa1dcf 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -139,7 +139,7 @@ static int parallel_test(u64 features,
 			 bool fast_vringh)
 {
 	void *host_map, *guest_map;
-	int fd, mapsize, to_guest[2], to_host[2];
+	int pipe_ret, fd, mapsize, to_guest[2], to_host[2];
 	unsigned long xfers = 0, notifies = 0, receives = 0;
 	unsigned int first_cpu, last_cpu;
 	cpu_set_t cpu_set;
@@ -161,8 +161,11 @@ static int parallel_test(u64 features,
 	host_map = mmap(NULL, mapsize, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
 	guest_map = mmap(NULL, mapsize, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
 
-	pipe(to_guest);
-	pipe(to_host);
+	pipe_ret = pipe(to_guest);
+	assert(!pipe_ret);
+
+	pipe_ret = pipe(to_host);
+	assert(!pipe_ret);
 
 	CPU_ZERO(&cpu_set);
 	find_cpus(&first_cpu, &last_cpu);
-- 
2.45.2

