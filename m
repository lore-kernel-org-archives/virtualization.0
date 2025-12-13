Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFDF1DE4EF
	for <virtualization@lists.linux.dev>; Sat, 13 Dec 2025 01:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765589358; cv=none; b=oz0gqZK/l5ZnJriuhQm5CutCRbmu2i22r7fGihkXXLlXv6KohqW4Gtn05hCX9M/tV/yXUVdYR8ziOFWSQy0aMAaHaVrSd2G6F0mLAF8RbaO4YTGCrm85FMUn9UMUMMV7e0HyNQlHYVUWOXWT5wTMOsNPCHDb2y9NwOm6SPzNc3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765589358; c=relaxed/simple;
	bh=Q/BnWKrddUCa21vqQ0fyH/iLAaKmHYd+0zEE+INzCdw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AHe0/OLQyMywPKZ+Z8FmxKYk2ia9wmSg3PxfdY3fBmWPoA22o9YKGtaqfY7cWqDLHm3bUnt1vmOqIutcZUDUSdZr8cf1jLnDLRvSfwbsE2BzGsqpoUYtfYzDy0Arj7ersYjnD+lewOb2j2/6QqSLqM37jq/5pPhCNgeHi5lYqE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIXe2SQL; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIXe2SQL"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29f08b909aeso3370265ad.2
        for <virtualization@lists.linux.dev>; Fri, 12 Dec 2025 17:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765589357; x=1766194157; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cln0tpkwGaPX83TGznuKujQwit6sD5kTkWZGVuQGa7E=;
        b=WIXe2SQL1XYvOHKs0bD6F40wMY0K2ZPJeUcmIGSTFKkFevAHUyUdV2J0gAhPdneGAQ
         lPrM5xU6lWs45LCKjYBPRg+uKoLUTV67NMgqsQLOMkOP0dplB4Le0aDizhkFAYO5Vw6c
         llTPsCM9tIZnpt7o1ZGO6nPaXumaZIW6bzIIgDhlc9su2yi/BQoEx+d8VGpSrDlqvg/u
         j23pNx/Y8qhSvcXQLF6XB4f3tN3nUN6uI2rGjkCUF2pLFySSEbBnfskP/sqaa3CD32FO
         H9gbUNCK/EEu4Rj+beo9faipw6YSc9pXY9in5Lxtf08XJH+E889MI5fd7L6lWtzSJy0x
         +8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765589357; x=1766194157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cln0tpkwGaPX83TGznuKujQwit6sD5kTkWZGVuQGa7E=;
        b=m42HLadcGjtcKjgPLTMhgJOzykb/lUrwNY+VZMWEMmK/wPrm4TQ0PrX6m9dwmaHO3g
         4SigxGnZFUhf96Y+kp5z8YoQwbhn/8tD6dmTXaH/o/0h/e/PwbpjMc+LTtnvUHaNN+5j
         X07kTauZd47O/xdTBCHXl224bKgVYX/g8YXgyKhtAexyx+l5iPKHfiZhTJhPlAn6szy+
         T8DDj3U9lQVuwoyGv3Yogh9VNge/F+fdXaP1kg1Slw8LuuCbByOTnnrJg+ed2RXkIV8x
         ocmvsYd3hegrnBQBEhOxrN92U05RMqB6P4ZhNrhGNoC6hiRTuSCdjjt3PMtTChaW37+f
         mV1w==
X-Forwarded-Encrypted: i=1; AJvYcCWuUy/48Q2OZQGGuWffBq566W4IzIOgt3ju1GcilaxIol6KKp1R01t2V8O5Pq91NLQaehI20pqU1u2qlOAZCA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzqz2F5/6ccWvu/cy/P75H9U1TYzEGs62Q6ZiruXWrizRoY5FkK
	DvWjmheYTiSz3eB6EG6W9RMXA/zxXr6kIOpmkMYC9oldJ7B2L+9LhQMdSULdV5Lr
X-Gm-Gg: AY/fxX7jn7rG24xFxF1Azcv3Mt63+536rtDlD2w4JZ9Jo9VORD966bNSd1X7oMfassA
	M4nB423Y9l0lPIZub0T6PKMeaZcauu3Uj/MaoFzVZe3KLKiurlmK/FoWn78xe+laKYwKTiRtJI/
	ZMiAY3u3I6zIQesDFN5blQmA2mWdu5ZstuSs+jAo+iERqdYfA18+hgTTZJyyHgFBhxoZSUCSLpy
	fXYuWEYDPO8kVq8On2iNr6S4of6C75Sa9+r8mJP38bW0hT4zE2f43Y0EJamXLcU7wQrIrvwFkLY
	fk4wTPi0jtrzeAQJSDlGl8sh5HfZawW4cglxRtjBPdt19/x8hTY0KMGfN+Wdcte9ZtZOy4y8E3k
	M+rQaGehKlnXXRQ21OW9ca4F6rnBRZDMGychXqbnATkzW4P8QEGPaPB4uI+TmbpLwh/N1pgPcF+
	5RtzBKZ6ltHcq6YjUrQQm9EgejmtdJO8r5oauJiB5VEDrCBWoOpT59PfOyvgZ+GDY1Nn4tFIg1
X-Google-Smtp-Source: AGHT+IE2FNluVs7vDa7N2km+hccJ4M70DEuxxCelM+kxINda5gMkw26py8jFfb68ATt4fxnqeEdPGQ==
X-Received: by 2002:a17:90b:2692:b0:340:b501:3ae2 with SMTP id 98e67ed59e1d1-34abd5c1d75mr2654608a91.0.1765589356670;
        Fri, 12 Dec 2025 17:29:16 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2ad5663dsm6370008a12.17.2025.12.12.17.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 17:29:16 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhitong Liu <liuzhitong1993@gmail.com>,
	Qianchang Zhao <pioooooooooip@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] virtiofs: fix NULL dereference in virtio_fs_add_queues_sysfs()
Date: Sat, 13 Dec 2025 10:28:29 +0900
Message-Id: <20251213012829.685605-1-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_fs_add_queues_sysfs() creates per-queue sysfs kobjects via
kobject_create_and_add(). The current code checks the wrong variable
after the allocation:

- kobject_create_and_add() may return NULL on failure.
- The code incorrectly checks fs->mqs_kobj (the parent kobject), which is
  expected to be non-NULL at this point.
- If kobject_create_and_add() fails, fsvq->kobj is NULL but the code can
  still call sysfs_create_group(fsvq->kobj, ...), leading to a NULL pointer
  dereference and kernel panic (DoS).

Fix by validating fsvq->kobj immediately after kobject_create_and_add()
and aborting on failure, so sysfs_create_group() is never called with a
NULL kobject.

Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
Reported-by: Zhitong Liu <liuzhitong1993@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
---
 fs/fuse/virtio_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 6bc7c97b0..b2f6486fe 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -373,7 +373,7 @@ static int virtio_fs_add_queues_sysfs(struct virtio_fs *fs)
 
 		sprintf(buff, "%d", i);
 		fsvq->kobj = kobject_create_and_add(buff, fs->mqs_kobj);
-		if (!fs->mqs_kobj) {
+		if (!fsvq->kobj) {
 			ret = -ENOMEM;
 			goto out_del;
 		}
-- 
2.34.1

