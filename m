Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62793EA9F
	for <virtualization@lists.linux.dev>; Wed, 13 Mar 2024 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710329196; cv=none; b=WzkoUPeAboaqKaPNN+TBycxs8BIG5no3KG82wUW4iwbpj1tHpezyOAU0zQNnuKk8/B2DbEuAFxwX6lvgWhEn5Y4fyeJkgrTV7OBUbsvNTkPpw48DkIFNahQLA1F7eClCsHu3U8s5rWMBq3Ckxyy8DpeR8LidPmJe0Skr8cqf+94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710329196; c=relaxed/simple;
	bh=5qzekjfuvebL2UR1FzA7R5gK9ijJWsW3F2Wj7DKSuvU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c5J5ivvmmX7HvR73n+IEw5p4IZZu7lYjx6BCn9ih9Y+p22SfHVN4VDDEgiI2nF/c4Fy/1llWsEGQX25iuaQ1SnVnRYuj7tZUFaCLlUqhU2FyN6H73U8JbEvWV5R+WEvdFImxvxs8iLYSTifQKU5FSCdotittEUZ6MngT766xMPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jjp1fMBJ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jjp1fMBJ"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51323dfce59so4874775e87.3
        for <virtualization@lists.linux.dev>; Wed, 13 Mar 2024 04:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710329193; x=1710933993; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lfLsFRDMtbO4BOATAAgu9+j4r/MV0Lasvl2lY8+nWuI=;
        b=Jjp1fMBJDvc11T2eQ9Xa6EzN1GYvO2SBzGP6+7DPsJ2kaxgHJttnilnxV3FVTuyye8
         oKmu0OxhIMGVZjwgyhZUM4j0QYtgZdlLeWY9wMrgqKQ7HVtvz2zYnPTwFImhtK1bYVuH
         d/WZIbu78tXuuIRou57VOS1Ji+7mCyG3Chakw/Ter6w+qcyka7QhrdqIXM05z3w+OJM3
         ayLNAiiOMuyueICkpaUoqZZ0iqDU8ySScupi7wB0whXjduUwIB6zDF3nzFp4TiSBxlgd
         2nofeAJoKbwq+IasUJe6+z7M2YfeGKJaypcY68m6LnkFuZs4z3t9eeujRyXfJTYzTGA3
         FQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710329193; x=1710933993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfLsFRDMtbO4BOATAAgu9+j4r/MV0Lasvl2lY8+nWuI=;
        b=cfZwS7Mg+WADiiw3qH32BTfTfA8a/pUtg9O0s4DEvSk2A3PCZ8nBFJ30RuR4Uw0tGx
         Jqy/7SyazMvVABuozDSVoc8i6jL9gVrGE6Tt3C2+6hqLaEXQBZQ4PcCK7opM8SYVHZb5
         l/LBZPkmCSfJuSaOtEO6/R0RbNpi1UzPaa1R+ZNc0WIwWllajA65EeSJzv8/Sxq6hUud
         TpCoIeuBeFnEulpLckA8euUorTsD1lnYFxwx2R1yAhg3ps7A1IrPD0JXpooypWM37w5Q
         4Et4p/SqVwEDROw18Crsimy0fDmOa9P7Nuk+NKobWjyG0CX1cDwbZ6SKMLTrOdb5Hmyx
         6wAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhep4RHg9kSEoLs0EiE/dRadN+A56lM3P++q1bA+s4FhwldTBOpAWv5SCPuTwFcRLOPWGgLncFuP9FsREKgv0iLgPK+oawvOdHTJWHWqk=
X-Gm-Message-State: AOJu0YxgpesQoQ9Ft8Yo2lH9ZtYi0RO+uMXCajc0pMhw8zHXT1dgCxqL
	TaZKNSlE0Y/baWtm+gihOuAuLQQ5wj7VotY8OycHpOl+/GeLwwtG
X-Google-Smtp-Source: AGHT+IE09mLx4VQegu+Vnd0FwZuy7/tra7X+S5yizQYa4igYpoiDi330J+2AjIJz1BQLwhk6pLz3rA==
X-Received: by 2002:ac2:5506:0:b0:512:a4ce:abaa with SMTP id j6-20020ac25506000000b00512a4ceabaamr7845165lfk.48.1710329192820;
        Wed, 13 Mar 2024 04:26:32 -0700 (PDT)
Received: from localhost.localdomain ([212.22.67.162])
        by smtp.gmail.com with ESMTPSA id g5-20020a19e045000000b00513201a0e56sm268249lfj.78.2024.03.13.04.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 04:26:32 -0700 (PDT)
From: Maxim Korotkov <korotkov.maxim.s@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Maxim Korotkov <korotkov.maxim.s@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	virtualization@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Maxim Korotkov <m.korotkov@securitycode.ru>
Subject: [PATCH] drm/bochs: avoided potential integer overflow
Date: Wed, 13 Mar 2024 14:25:18 +0300
Message-Id: <20240313112518.2030805-1-korotkov.maxim.s@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

if the bochs_dispi_read() function returns a value between
0x8000 and 0xFFFF, then an overflow may occurs.

Found by Security Code and Linux Verification Center (linuxtesting.org)

Signed-off-by: Maxim Korotkov <m.korotkov@securitycode.ru>
---
 drivers/gpu/drm/tiny/bochs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index c23c9f0cf49c..ad31049f9779 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -240,7 +240,7 @@ static int bochs_hw_init(struct drm_device *dev)
 
 	id = bochs_dispi_read(bochs, VBE_DISPI_INDEX_ID);
 	mem = bochs_dispi_read(bochs, VBE_DISPI_INDEX_VIDEO_MEMORY_64K)
-		* 64 * 1024;
+		* mul_u32_u32(64, 1024);
 	if ((id & 0xfff0) != VBE_DISPI_ID0) {
 		DRM_ERROR("ID mismatch\n");
 		return -ENODEV;
-- 
2.34.1

