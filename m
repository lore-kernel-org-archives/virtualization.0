Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FFC7764E
	for <virtualization@lists.linux.dev>; Mon, 27 May 2024 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716803244; cv=none; b=e9ldWhEN3nnsGJrpiSCavjcIEFPATI1NCfHDaxJj1u4b1rdisbkALy8Cn0+9BIwxTFsKNfPAtDbwJkgdXJHwXJhFIrJeBwlVLayuqcufx3U4G5PeuZ+P1crUdONNyQR3Gdk2d1Dundyjo8k3jZS5xqFM39xrh8ZnnoAINZiuFJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716803244; c=relaxed/simple;
	bh=mogT9CSK+Vk/ExDHgD2Bj+5ISdL3rSJDhZAR+YNxGEg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ULMa4HZONvdcyGkvfyydHGfCczTv7PdQtdHyiceS0Tz7h2dkrqYAQ8+dRKQz/6/kUAYka6uOjsgcyKo0iObU155iZwzJSsRWbr7mF3NjfIl3/QqClcR0flSYtcjuJxzvNqsWuXWOEPBG77frlHjEAJe+6ZJfRqXf9wCvczLayxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJoeX1oC; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJoeX1oC"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-681a48efe77so2392255a12.2
        for <virtualization@lists.linux.dev>; Mon, 27 May 2024 02:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716803243; x=1717408043; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=50caWXAQ+sC+cT9R3qngK0AJe0BNtDYXixsKN4qP8Dc=;
        b=dJoeX1oCaH5tcZbd+DFNcrnBlnwuBGRyvGcXOa6uNZhRpok4qXl7opT7dYazTvzzLe
         EgtSFwdEpsd9RKTUj2REGhN9WWQ1r0BW/WLQs4lWfVWROoEVzno4uvFcycs07cPmVHWO
         grCDIwLse8mcC0+pSUa/McrWUhqyXErlxrHxO1ToXnqHm2Hgkksgx8LJQu9Kuycman/L
         qwpzKA7fqMoX0vQF+DrYh0oAjwgHd7dDIfOOb5bmZZd2yhSXH4Vzh64j6FEmp3RonqYp
         L6jpefVfQBYa6WLJ8suEMPq+TCMAz9lV/CV2JINyrtpr1tt5XU5ZZwlMLHyLpk22vz4u
         +wGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716803243; x=1717408043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50caWXAQ+sC+cT9R3qngK0AJe0BNtDYXixsKN4qP8Dc=;
        b=e8Qg3SY0RfBegzrqxrxeiCoGhLq20cjFcZZk0xBC7TDKfAedpJlEb8Gujzn74e9wES
         nkNF+5V6/FnvksAUhPJbhTJXq2jdZ579zQXzHNxRncKgB9uYOhOvfQ9otsAgzVKnITiR
         DWybyfzy2mgNWLVVg+MdgHNvZsMMbgONu3PYHuoi2nrwwgOowZal5O3vg4qSn0zbncaq
         ks5QIzk2+CAcNfp7CPOzNefzPPe3BK8zd/K1+ZLFDr1aHlI4bb5mVxXVZxOBB4VDEYAG
         sKzaJmBP/FbR3Pq1MxVYF5pdM1h2lai0ErGG3ROAcSqnbzXIRCI5/VIXzYEmEeEV/Eoh
         B2Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXYjTNHTTkDpECiVP7eyIaQkMCZV2+OOJJ/i5eZJPZZRQ9cRLjJKhHttkffRlVynZHzHw1/yKIEJlW8D7AJ+UZe4xaU1hPpysYYytTtXls=
X-Gm-Message-State: AOJu0YwZ7VfRd5NRuM/97nR8dBKi8KJ5hy3FAx0OuuhtQukcIw8pCf3C
	Fw7tUA+J8M5C2J0PrtCrN+BSY9CSqlIE3dn8LA4R9+lwm5QVWmLG
X-Google-Smtp-Source: AGHT+IEDc4LAFSKqNq5l9LzfWWsnC59oJ3ZllKmfg3ST/QQZBYyxM+DacHLuQWZE3lQ4rKv/W1CerQ==
X-Received: by 2002:a05:6a20:72a8:b0:1b1:c745:5c66 with SMTP id adf61e73a8af0-1b212e64d95mr11249287637.54.1716803242578;
        Mon, 27 May 2024 02:47:22 -0700 (PDT)
Received: from paran-QEMU-Virtual-Machine.. ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c7d1b39sm56788195ad.116.2024.05.27.02.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 02:47:22 -0700 (PDT)
From: yskelg@gmail.com
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: skhan@linuxfoundation.org,
	Austin Kim <austindh.kim@gmail.com>,
	shjy180909@gmail.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Yunseong Kim <yskelg@gmail.com>
Subject: [PATCH v2] tools/virtio: creating pipe assertion in vringh_test
Date: Mon, 27 May 2024 18:46:05 +0900
Message-Id: <20240527094603.23481-1-yskelg@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yunseong Kim <yskelg@gmail.com>

The parallel_test() function in vringh_test needs to verify
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
2.34.1

