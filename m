Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACE6157489
	for <virtualization@lists.linux.dev>; Wed, 24 Apr 2024 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713949614; cv=none; b=EgpLjqXhpJkg3uPPmw+rnNlbSujMdUy6EZtmgcpTTQORwHMu4Q6FzRaKjupeyZ7onf97FdmLQwv3TvMTKEF2uRCiMW6rtIceQuubXFLHHLEWnmAQDnNunmOVpdylG0KCIsNuG/kBhuCk/Ss8HPJFL1QL3PldbVupAzyK5zHPhY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713949614; c=relaxed/simple;
	bh=PIWDBeJBTJ8nI6deAO9S/CefLEHkMF1CEvSU9ILhtCU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jkoamwGMz53O0UHV753qRHBFNXOyN7pM5E8eAmaoMG8k18gaPQvQWjJZ5swTXHF9RlD+XLQEzoUGdh1M8SFuw5PJqJaefnFZJOovzUXVaPB0XIQ4/ygKOXyvTeL6Z1sJB50S6/MHyx3wQWAW33QgLj85l19vri2g5DUzJcdl8to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZ4AtYMq; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZ4AtYMq"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-6ed627829e6so7381213b3a.1
        for <virtualization@lists.linux.dev>; Wed, 24 Apr 2024 02:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713949611; x=1714554411; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5/BejucCQJg/1a61zK573V93gjIoiZEwubJ52BTIMU0=;
        b=SZ4AtYMqs4udzgywRzUUGUiyY7CrV0sQm2DU1wYvdNlV7KZjRoRzxvQS9cvCm5qJlU
         v33vq2RR0yo1S9Ww3Cx4c79+IvEMhmfa0os0eHdnEWehFqgbxV/irRZNQ/PNvPLUX0++
         XO97eUbOIwhvM6Hfik1dX/wMVryqvHpM479bWXkPo6jmCKfy6l9ikKT/N45U0ZDa9jNb
         z5UslPs67hRAqTefE+DsHgRcYGtwz9FFdWAAPgqXQwmgh1GzFEGyoyHVuB9Tzk2c/kIj
         j78Bh68+g+G2Y//ccD6RFUZl8abl3u+6oUO2XM7+YCDzec0j6r3v6hOjl3u+iwitCL+O
         4oSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713949611; x=1714554411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/BejucCQJg/1a61zK573V93gjIoiZEwubJ52BTIMU0=;
        b=Jw5j5FeDOzNeSwLYZFE4VIEj7rirz0iMBDd5N945llJeX9SHGTqKOZy1JlrYcTrrql
         a+Ce/IbsSjSR5R97Ul19iQWJoXXfww19wR7OVo7G7DnUConVVII+G4Ede2jJu0oF5gkj
         muT0HX/Eajda5HndvPjAZE97CIkWllmqFSP9PNPEtHkjU8fc0xweANdfXTfczE3/a4df
         t00yEjEPF7V2wLt4BoBT58dBzBDpg/gedTc0rseSIzdF9zcDm28Ut3O2cF6RvREYPTeG
         w2D58sJUyDkT6vYV90whClPowDUsRWJYH9TDL8GMzQQYy+0voigh/U00FqME7uSGHT6l
         gNuQ==
X-Gm-Message-State: AOJu0YykPHsiqW8dNELT3YRAn0NwQZo2hf69leufgxQawkH01CwxubLk
	J1Bu6u0z+lXZPnDOAobQ6AmfBzp5khZ+5W6/XWumS+WpMsvXXOkb
X-Google-Smtp-Source: AGHT+IFKRzyx9snJqmoMOtX6aAXFm0HExvHrUY7JVErkB9slUDmbicNo+zAy+Vth61McqB3ocB3b5w==
X-Received: by 2002:a05:6a20:7faa:b0:1a9:3cf2:508d with SMTP id d42-20020a056a207faa00b001a93cf2508dmr2047738pzj.38.1713949611015;
        Wed, 24 Apr 2024 02:06:51 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.33])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e5c200b001e556734814sm11408569plf.134.2024.04.24.02.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 02:06:50 -0700 (PDT)
From: Xinghui Li <korantwork@gmail.com>
X-Google-Original-From: Xinghui Li <korantli@tencent.com>
To: airlied@redhat.com,
	kraxel@redhat.com,
	wander@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xinghui Li <korantli@tencent.com>
Subject: [PATCH] drm/qxl: fix comment typo
Date: Wed, 24 Apr 2024 17:06:13 +0800
Message-Id: <20240424090613.2630952-1-korantli@tencent.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is one typo in drivers/gpu/drm/qxl/qxl_gem.c's comment, which
'acess' should be 'access'. So fix it.

Signed-off-by: Xinghui Li <korantli@tencent.com>
---
 drivers/gpu/drm/qxl/qxl_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_gem.c b/drivers/gpu/drm/qxl/qxl_gem.c
index fc5e3763c359..2cfe29d72d81 100644
--- a/drivers/gpu/drm/qxl/qxl_gem.c
+++ b/drivers/gpu/drm/qxl/qxl_gem.c
@@ -74,7 +74,7 @@ int qxl_gem_object_create(struct qxl_device *qdev, int size,
 
 /*
  * If the caller passed a valid gobj pointer, it is responsible to call
- * drm_gem_object_put() when it no longer needs to acess the object.
+ * drm_gem_object_put() when it no longer needs to access the object.
  *
  * If gobj is NULL, it is handled internally.
  */
-- 
2.39.3

