Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AB41F7580
	for <virtualization@lists.linux.dev>; Mon,  5 May 2025 09:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435605; cv=none; b=ohshukKHa/oco+zvkHYJ5VBUBrCoK3CoFzoEf3XliM1Yd2VZlLak0d3Q1xVK7i8nzJWZjXh4R3/wnFlJZJTdEqxi5KMlHvBoT2mPoPl0Qh9UjQCp7Mgzya5TU/L5FNPfzlkNX/WnGTyyAivjsLxIhN0Di/JHBD5PpSmMvsyukyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435605; c=relaxed/simple;
	bh=0gWVNbRB11j6NzQheFtP3AhW2B6FSY8x/IiQjLkDkHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZNcV+B6tTF1crtz/g4l86sFeImitIzDuBSjMG82occbCMwd0uGEsHKAkfrS8iRVpnHNuoxT+RE1U/MW4VhQXYhZ3341qnaoUejLJa7KPyvpdJrWFeB/kieA+EBZwAoiR4JneBe2RAITwOlvQFWs4Nt3i+9ETxRjVDBUITz6fOGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vJgpg+Iu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vJgpg+Iu"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so38181585e9.2
        for <virtualization@lists.linux.dev>; Mon, 05 May 2025 02:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746435602; x=1747040402; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2aENDSHoBUQDncGi75hijmd8KFyNYGfXXoOg+4vaXxg=;
        b=vJgpg+IuM9gikiatC83VDlXpYK0sy9BsIGPq0n+TmHoaU3k1PAnR+PFsd+d/luzx/K
         P443zXG/00O87LMOQ+0laSyNXDYZf8jnU02nbcm38/Vkj9LStNXq0/N9/58xKFDIYhhS
         nrHREbV3ck/iYhzqTCvS5WMajsJbV9cnb+Vf2sWx1VyLV5l8F1GUwcv8XMt/ex5r8nPX
         9N5ZkBaqd2oGjtq09iAYptHgtv9WMbTPh85lRUivmuXbgLmHpbBLnajBBitm4uBqcuTb
         CoNMd4fTDuqq63FvtwRYfCcO6GFp2KQ8kRb07hgw3+tWCtnGjEhHn+gIdwPVYJy3onxG
         xUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746435602; x=1747040402;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2aENDSHoBUQDncGi75hijmd8KFyNYGfXXoOg+4vaXxg=;
        b=eMpDz4XeI2VQzM0iEXUxyS4+zZIdqzizeN7u+88m+xgSmmSdi5QD4tec+AbWS+sGi5
         lWchDLLJbglxec66oXfNYr/OQJ+jAhZ/kUyyIFGdA+uhVZEXHRWv8b4EC/U6Y5Woyoat
         DTc+ABXQ1bL7rqwJ09bmAYzPk1GV8H3QL85sIhrTRb+q3iS0GIXdyGrSldLqk3Bs9fAa
         LPPIi9AkuOZTR2RAwCwx7Gydt957asnIRfUMcQO2ktBOxEJL/menCjlJCdirXUNA65FU
         DAkWgy0Be7nUwD5yQb6ICkSmMbEdd2fCDsrIIwTZEaRK8O7lOTjkAU8keF4Ey9pD20M9
         I2Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVW0sY8DzAvJqsQtGxT+Ag9MQCFzgINN/LpcDSHe/hAjrN52nyvn52Z9sWzFsc3rCMbXRKSNzwiE2gnLg7L5A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUkgw+7KUNHU9sK1uZRBeUZXOLXY12iSpC/3GACBCEoQULe4U9
	U1fI/cN31VvXUsB5eiryZvYnWCHOAl9tkeqGxl42+FziLt3rgBE4ZXFdjtv+t+w=
X-Gm-Gg: ASbGnctMbvkFIWwhbNlDkDQBJnYhddi9AQvCwU4/fZfcvJyD1djHEOyG1B7HpEDSVo+
	QBcJyHB/ZEAcMuLmpNA6JJ9EtK3HpS+khCy8utjMBwB/Qy4uqSaqdFSmiwn2kzNSZkDaVRNV0PV
	8UeKAlH5uyy8Y6vl4EBicLMcBpv3JlJmYxUi3jhNbJWM7IKCif6HfcQENl+63IpKgmGceWOLdgb
	tyGfT+rFO4rlXGGMsHzNBwD+EYBopDo51/Lv0Hz3RWT+nmVtNdJsfUYLs6kpOfrreOG50XylPTV
	6xLxS0aAiqWU88Ev6JW7hOXvPQm1wJgLyOidQ+ju6tE82C9krpPLISIuSbNyesIEue0VerVgbHr
	LLxxKfrdz9pHY174=
X-Google-Smtp-Source: AGHT+IGg0Vn+z3bbOg/uzaXcU9oRZ5gyFrNKK7mD8WX6VvRKSYjefILs7xFlLJvJAY/rZ0IGfGWxiA==
X-Received: by 2002:a05:600c:8283:b0:43c:fe5e:f03b with SMTP id 5b1f17b1804b1-441c49483f8mr58600635e9.30.1746435602452;
        Mon, 05 May 2025 02:00:02 -0700 (PDT)
Received: from [127.0.1.1] (adsl-186.37.6.163.tellas.gr. [37.6.163.186])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2b28045sm170432475e9.35.2025.05.05.02.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 02:00:02 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 05 May 2025 11:59:16 +0300
Subject: [PATCH 3/3] virtgpu: deallocate capsets on device deinit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-virtgpu-queue-cleanup-v1-v1-3-810923da2b1e@linaro.org>
References: <20250505-virtgpu-queue-cleanup-v1-v1-0-810923da2b1e@linaro.org>
In-Reply-To: <20250505-virtgpu-queue-cleanup-v1-v1-0-810923da2b1e@linaro.org>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, dri-devel@lists.freedesktop.org, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1065;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=0gWVNbRB11j6NzQheFtP3AhW2B6FSY8x/IiQjLkDkHA=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9HSDRMbDdqamlhQ3I0b0s2OVo3LzBzKzdVNWx3CmpudkIydlE2b2hCOEdXWElV
 ZzJKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUJoK0N3QUt
 DUkIzS2Nkd2YzNEowTHZSRUFDUkIrdGM4Sk9ENzJTL3lzM2JPWDhFV3RaLzByRWszRm9aSnpWZA
 pTQ0RSem0zL1BKeWZmeWMyYmUzS3o2RDU3SkFjRzV2dERlOFJFbXNxaE5GUmlrdnd6RVZnOGo5N
 2NrNTFsZHR4CnMxdC82TmlXYzFlZmFXMTJNNVprWGFwdVpPSVZ3SVlGUVFwY1N1VDg0REtMV0xQ
 UnBqTG9BcmFSYTE2UndaRk0KWEJWVEl3ZUg4WWI3ekluMzkzMFVKckordDgxaUg4bUFFTlFjVHB
 PVWFxMVFCeWE1U3FHK29aSENWTFV3b21kdwpwS3Z3ajBKMW5MM0VvTVJNOUhLUFZPRTlpVjdzVk
 RvdnlDRHlNM3M3T095OXJ0elk1c0VqYkhxK3ptdWJrU1ZZCmhsRWNKUkRVYk1yVnRBSGI0Zy84d
 GxzMGp0OEluUGhERWg1SmNTeTlJYnpwWjNVQnJxNithNEpxQ2M3bzVzSjYKUUg2YmJJelZYZlkr
 VThvamc3a05VSGd0V0lYc0VNOFozeUhhcG1NWWVzRVhMWDRCTTdjMUxIK2NoT2syRk54UQpjWkx
 HblBlNVl3ZkFQQnYyNkJCUnhMdFhvUGZRNGJqdWd1YnVnTkRsQnNNajFnOHRUQmhBZ3pIMkZ1bX
 VjdDJHCkhBcjVaTVR1N2JUYVlPQ2dHL2ZwNVZzZERWYWd5UTliSGpubjNqS0RlWjR5Z2hFcHlQO
 EtydjdPV0JzVTZpdFEKR1Z5T0RNUi9JeXdycjFuNUVGQUtaOHQrRjk1MmtmWHZlVEFPQkRxZHI1
 WS8ra09OckRpem5iVnptcDZzbmx0OApURFpab1Mxa1d3ZDFEVGR5cm96T3puajRYQ00wdTVRSGZ
 sYWhPQWNhdjJZY0Q0ZVRTcVl4b0hTZFlONkJoZUl5CnluUnNNdz09Cj1MSFJmCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1

virtio_gpu_device's capsets field is allocated with the DRM memory
allocator but never freed. Add the appropriate freeing call inside
virtio_gpu_deinit.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 drivers/gpu/drm/virtio/virtgpu_kms.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 7b3c4d314f8eee692e2842a7056d6dc64936fc2f..a8b751179332b9ec2fbba1392a6ee0e638a5192e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -286,6 +286,10 @@ void virtio_gpu_deinit(struct drm_device *dev)
 	flush_work(&vgdev->cursorq.dequeue_work);
 	flush_work(&vgdev->config_changed_work);
 	virtio_reset_device(vgdev->vdev);
+	spin_lock(&vgdev->display_info_lock);
+	drmm_kfree(dev, vgdev->capsets);
+	vgdev->capsets = NULL;
+	spin_unlock(&vgdev->display_info_lock);
 	virtio_gpu_fence_cleanup(vgdev);
 	virtio_gpu_queue_cleanup(vgdev);
 	vgdev->vdev->config->del_vqs(vgdev->vdev);

-- 
2.47.2

