Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6291B23D7E6
	for <virtualization@lists.linux.dev>; Mon,  8 Dec 2025 16:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765209775; cv=none; b=e8XKpdt0h4oRZiWYoxVaIH2CIoYO75b7oz+CeEAg9HEU8G/nLDazl0yZkyFQ70wEpghT8Y0Cw/ocCTRRcdC4+j34bnGG2/KKHo0ieZHjvUDOdmoMR0WEYBx+nMPlKyihqme0oARADhh1w30u8mU21MVeZ654eb7OldoUgaaGtYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765209775; c=relaxed/simple;
	bh=bLJ/DxhuYtfghkD/xdLw9mssOsq58QXFAJcdNJ3qiKM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UdhuA6OaJgEnMRlelqJq+NtlnTeoNpRLBcdYhc4RGWbXbt1Gqtk3A8dk1jsLYhpBWJl0FNxXBDbq+mHnWq71kb+mKvgTDf+xHzxk5/7jxCviNBJhTYnAddMOGig7rVlsDVCnLVPe3qTThVH9vnroEa0DSrL6EMquodfx2HgcyPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4gstSlj; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4gstSlj"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5958232f806so4898481e87.0
        for <virtualization@lists.linux.dev>; Mon, 08 Dec 2025 08:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765209770; x=1765814570; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Im/UU88NzMzAmZTVyjewlopeNrCHZj8w4QA0s6ZSqCQ=;
        b=k4gstSljnv+x3x8JsQAOduwcrPbCMyY9DXVZygzP+5NK9t9Ov6EOZkwtZPJ7QjpAHU
         oiUwUgW0cBHj1c95RMxijYnennGYIxiHXUf8a//IGzffB9xrf3J/7YiK/V8KKdj4PLDA
         49IT6emSaMi4xD4I76ae/VwDgg+c0RgktPCELf8jKEnwfNhahZ0WOIrm96NzVpMrvhIR
         46A5EzShuFBfXUR8+lGYoHwv+51opIVq9RHG7uIvWn0RZmB8Yu6JYZ5c9FJMvz1bcQth
         RvVifARLF8xH8uho25cX4XyhHIeF3ZdZqVpO8bhftB3mh8g3Bt2yk10Nd5kulxmVbqrk
         KorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765209770; x=1765814570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Im/UU88NzMzAmZTVyjewlopeNrCHZj8w4QA0s6ZSqCQ=;
        b=xO1/cjR4/jADC6EbOS2z9eqnPKeE1WDl68+NcqRA5gPB/pH+D2tD32xd2DhPAIcTrK
         I67UFE+MWqnTIs9akEs9GpQdJngKLSp79ltnuIMbD2Mi+5IrukTJ9gCCndGOQBcqfG2k
         uKheeNXlWj9PgiU1bNZFDeyG4w7Ol+hrEmNFJXRJ2VWtTORW72UUieDRBlhUBhC48eRI
         0tRE52BWc9Bl/WEaX8JxESbzTIfV7z0DM9+UGkMj3LGDvJtqdRzP41LhyZEmeE0ISfif
         1KQqw3u7IptZ95fGni2wc0wmV0N0EY1t9/+ABv4UaQ9cRPcui+V8iWQDThE7IoBD9bPn
         P2Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVXDXjY2SZTSbjhKBq7P/sqxepDGiUJIP2tEHf/d0q7D76tEjzymaP1nXdH2Uyu9GH22TgLqmidYjK+rsYD3g==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywo0xqzBb4iRyvEEdeQdQZLPQ1Nc2eL4JkgQAGz4KjaMBWAz0f3
	5T3zI35plQNOu5l/WJ6vQ63IFy2K4MDGV9T5r88zUakQF0cXD9xvmWk3
X-Gm-Gg: ASbGnct8jFMEcceSb4CG5dTZiS1KzKfMLp44bT6WcS+qtKc5SVb1OqFH3aM98GIpMbK
	Mw0rKqG+BZf5dEuC3bRRSS8CtxIvg9qHsaajzSdVr62LeW4YLWajzwdI9jswE0iW91p5U5g8SGb
	uMyODfyJdZ7Ph33gFanXayen2Z/NdjGUXNNokVjF1/4oq8m017aM+Wc1WnuurLFn7iZrAChiGks
	a/BiiebybRycB5exw5jVUJrXQ6kbym23d/2etSXK8mq8Tc3j1K5pD8VCq0zosMLd2g4P+l0OHty
	XsWK6UwaiFOFk5CQD4GXOUxUDWQ/eVrk6n6vkeE2XYEUMqLG/pz+muQQ7MCBayKvNNmL1CRf4Un
	4u+QKVIplNFCnzV6/d637iOFNw4RFS66coosdCZIZvqA0IuXDgh6w6hP0l0wM/8h7AwDc4buwtQ
	Te83fB8mQAvVKvjcPWizYysxXsz0W2DjfIrIs80xo7Kz2CLaks
X-Google-Smtp-Source: AGHT+IGl+2gac5WBQa4JRm/ES2jta48b8h2trd4DFOGKpZqgj+BulMqtAB1nSDlk9h7vcIXyCWxuow==
X-Received: by 2002:a05:6512:e88:b0:595:81e5:7574 with SMTP id 2adb3069b0e04-5987e8c36c5mr2692786e87.20.1765209770098;
        Mon, 08 Dec 2025 08:02:50 -0800 (PST)
Received: from home-server.lan (89-109-48-215.dynamic.mts-nn.ru. [89.109.48.215])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-597df2f7400sm2890827e87.35.2025.12.08.08.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 08:02:49 -0800 (PST)
From: Alexey Simakov <bigalex934@gmail.com>
To: David Airlie <airlied@redhat.com>
Cc: Alexey Simakov <bigalex934@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	Lingfeng Yang <lfy@google.com>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] drm/virtio: fix undefined behavior in capset shift calculation
Date: Mon,  8 Dec 2025 19:02:29 +0300
Message-Id: <20251208160228.13145-1-bigalex934@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to MAX_CAPSET_ID, possible values of vgdev->capsets[i].id
range from 0 to 63. Since the intermediate calculation uses type int,
shifting by values larger than the bit width of int is undefined
behavior as per the C language standard.

Explicitly cast the left-shift operand to ULL to prevent undefined
behavior during the calculation.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Fixes: 1925d6a7e0f4 ("drm/virtio: implement context init: track valid capabilities in a mask")
Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 1c15cbf326b7..2e0ec7590ac2 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -104,7 +104,7 @@ static void virtio_gpu_get_capsets(struct virtio_gpu_device *vgdev,
 			return;
 		}
 
-		vgdev->capset_id_mask |= 1 << vgdev->capsets[i].id;
+		vgdev->capset_id_mask |= 1ULL << vgdev->capsets[i].id;
 		DRM_INFO("cap set %d: id %d, max-version %d, max-size %d\n",
 			 i, vgdev->capsets[i].id,
 			 vgdev->capsets[i].max_version,
-- 
2.34.1

