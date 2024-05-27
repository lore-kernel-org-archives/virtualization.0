Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5889B168A9
	for <virtualization@lists.linux.dev>; Mon, 27 May 2024 07:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716794037; cv=none; b=aTqK+Vx7MmkuoJuuhLAKRrT2EYJoBvjXbSDetR3uQd18JQx+QgR/MaaZSglwKUudifEv4ObTCN3Wp4fjWojxUsnrhzTg5aCUp19ldygK033fWhDhhI/NZZq87z8YH/HMuKdvx4NMzLcop5mJMQpVqxiS/zHeOTqFy9HTmj3nzks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716794037; c=relaxed/simple;
	bh=hPOiU8EzJd6UGf1Qrqx8b1T+bxulcNCNVewdy3U/vsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oeIABBuaWwC3GKldrEPMHFkl7ak7a4P1vt2Qm62zXXr9lw8uCRKVeTt4sl5tMbmIAbcJEeQdUKMjN0QF0tyrNRuL3I5BVDOo8fAmfKruXw6NFuERNw8oUt8C2ulSnexMILdNP4Si9Ewe+z9QniNi8f3MGXyGOhRLIBBgT6x452U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAd/L1Fo; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAd/L1Fo"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6f12171523eso4770362a34.1
        for <virtualization@lists.linux.dev>; Mon, 27 May 2024 00:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716794035; x=1717398835; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uye+qPyIlPr8r1G8aGQy8xNPlvuLVvJZ8ppLZ/tUAB4=;
        b=DAd/L1Foryzri4S/NyvSM0NaSBRp/2lF6eo2Z4G67+eRkaGm93EYRUaM1Bvl09gZ96
         88gi9dEUwFoQCylOR5pMR4Qcx/ZIB1mfW38lFmP+Oapxz9+L2NgsPoSaQLjIzZeNLPHq
         AtVyn7GIH4PWgcAE62tGESSiEGXIAG/DHo8CyuRwDqKTdbhl2tUYC5NKw5jbsPZPk6SE
         /FcDRPpNmS663O0lxw9vABHz5W0XJhS5DwV0F8SqTZlXXY03Dc/i4gfIBShI5P44u1rQ
         40FrFF9Od/sztxruy5wu0EJSmW1Uuvx+sJzpVf4/KiDCL0+OviZbvBSSW3XuO5yN+guq
         7LZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716794035; x=1717398835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uye+qPyIlPr8r1G8aGQy8xNPlvuLVvJZ8ppLZ/tUAB4=;
        b=jeFEf3U1O2+hNrH2Msi0QSMvTiqD5pyANRhK+1ODjfc3iHhNvpBcYMuYKgR4X9I7NJ
         kHEaP3UifhJXUDFGxZiloDqX540vJOfp8Dm0m2Wj4Q1OcyRxEjflKWinmmF12Zqq3E9B
         UQp4FQxpRIV8VgElXLBIc9XLaKVEfD21pEHGYHcwJN0CYaagh7PtJ9TJ/FJWsmj76F69
         qVuyvzi7k9fQgyTGrMQipo8wfPXAKM51qGxWwfFlPC1rZRe4ivrykQadOiI5L5hiNCxm
         pQ15Z2S0jdes1GH2UI9w0QYjy6zL0swrmLbe+1Shvr5cbIXQy8jKJoqg9rdru6o8KHOr
         mpQw==
X-Forwarded-Encrypted: i=1; AJvYcCWAL6FkgXr43NsA+DIw6T3NVagHDI+EBFVjg5NKT88NIU0A8344A/d7M9zRckRzU7GpmVKkaBAT7WDtazB8Hdri7rwnMYzDvkpGiPjpn3E=
X-Gm-Message-State: AOJu0YwN8Py5661yIBN/kvMOiDvJrbggtExOdRcZg0eIu3j3ix7zbu7h
	sML4nlqVa2Bxr/1+QF0JnTQFPsZfHQa++7eap9PbiO8dn63FSQztgqNzyY+oWyc=
X-Google-Smtp-Source: AGHT+IGDFKLKRkNsLLmb9PBuSt2+uES2v9ZFulvy+8S4g4S8berIKqqGnZ6WVt4Fg9LxWzPpocp1WQ==
X-Received: by 2002:a05:6870:fbab:b0:22e:8a0c:ea26 with SMTP id 586e51a60fabf-24ca13e796cmr9174312fac.44.1716794035173;
        Mon, 27 May 2024 00:13:55 -0700 (PDT)
Received: from paran-QEMU-Virtual-Machine.. ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fd4d56casm4357253b3a.199.2024.05.27.00.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 00:13:54 -0700 (PDT)
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
Subject: [PATCH] tools/virtio: pipe assertion in vring_test.c
Date: Mon, 27 May 2024 16:13:31 +0900
Message-Id: <20240527071330.105268-1-yskelg@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yunseong Kim <yskelg@gmail.com>

The virtio_device need to fail checking when create the geust/host pipe.

Signed-off-by: Yunseong Kim <yskelg@gmail.com>
---
 tools/virtio/vringh_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index 98ff808d6f0c..b1af8807c02a 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -161,8 +161,8 @@ static int parallel_test(u64 features,
 	host_map = mmap(NULL, mapsize, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
 	guest_map = mmap(NULL, mapsize, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
 
-	pipe(to_guest);
-	pipe(to_host);
+	assert(pipe(to_guest) == 0);
+	assert(pipe(to_host) == 0);
 
 	CPU_ZERO(&cpu_set);
 	find_cpus(&first_cpu, &last_cpu);
-- 
2.34.1

