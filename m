Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DD92E2292
	for <virtualization@lists.linux.dev>; Mon, 18 Aug 2025 11:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755516965; cv=none; b=uzSH1NYDvouAz1NWa50xOiTD8O4LowGpyVwg/1S9jk/xZRXgobXGkgv6/gARpHwwKKm7waDHNjpbflq8KHDRbq4kYtufA8DtRYX1bdIwYVWixpPX/RdSefvh7FFlpufA8sOF3/czhVW2+dXNBgTontUf0/PehzJTdekYiVZ8BGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755516965; c=relaxed/simple;
	bh=pJxE+OEQ5Wyzmel59Y0sr7fQRcSfIty8hGB+7BBVnAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EJ82AujHQhTTA7qxGjuePeB2r68EDbAsFVrZzRoL6zWQS+g8qWLAd/J6CIlb1hNjJdNLfamlTEV/2OFZVl/qfNyRpA8vUQFiojDIBJkLbuxWQhCJyPHFMQCu+b+lqtz9svU0DfU0zkcT2qM5kaqhb7J2NKo4yEnlA2vPEqLCc80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeWuHJh5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeWuHJh5"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b04f8b5so19366025e9.1
        for <virtualization@lists.linux.dev>; Mon, 18 Aug 2025 04:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755516962; x=1756121762; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dDUdPZKNkg1iBDfC6ofC+qEV+2e3XCCr9Niar66w+L4=;
        b=FeWuHJh5biCl3Cgpis0ox/zMwECyZ7rH2MWDXaq/j69VJPbH5YTHI1tfP0VFTfvLT8
         BRn1DgvulEyliyXHzAUdk4AuGqIyxeCFYatYJEaxQggNOg5nf1EpA7v2xXkCLmfW1Y0p
         1Sr2klUgcQF626B7eK+3DK2R1d2NAyYKHR8VCjwn0lcw453H1PkQRG0yo/Bm3xd1uuKB
         C1Mn8MNu/CH/LadJZWCQEISWEOO+30u8W227fXEWZSJ9+I+ap9gL4eyNmJIeAnWQOMsJ
         QNZy2wd6POklZdQ3vIlhIu8s8Zbp85JrFcwqeNrfaW0/I3QLxfa1EjbM50uJgrEMglr1
         4WOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755516962; x=1756121762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dDUdPZKNkg1iBDfC6ofC+qEV+2e3XCCr9Niar66w+L4=;
        b=oJ5Go5hIyDgrx5eSAW+v/XbJcxHLUD146TICUcH9wvF0a3w5KJqwU1sDnrRp45WhFw
         w2tmd8wEBq06ru9Qcjz64Mt+sM1iihWI/emZOTbdm/K7Ui30gkS919xAatq/pnhYABak
         E97YJyo1UPySJJcweLTa7ez1P1FALp8c21zQBj7IKQwrGGHvnpPSNcm/7dYBsmK2dO1V
         ASgdYCHi6fTw3TjfyvgOm8NnqPm8ZJWSjRwdjFM3KGjOm/GDrH3NA8ek+Uo19bj6yJMF
         0XGSbJ24SFG4RTLIJcq9dIomBG5WhpQ0MY5iIE4JAaHVKQ3VzxDI7Ji2rLxhXSnq+xY1
         EM1g==
X-Forwarded-Encrypted: i=1; AJvYcCVLo7X7Piq53IBaLivVNJXK6eycHqDVVg9qXTXou9N6ACu/AA1GZeBXqLmVyM/GcCRUIIG69i7SzaBNKDCdeA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgoyJ8kx/jJiwgJ51GWMtudscRJv1WBFjsQ8c7+5PfK9H+svCG
	pMmVf5kvv05JVRrEaNTYD4GlQPoPsU/6yhIP1Qge5rgALmB+DdgkjkrV
X-Gm-Gg: ASbGncslJe9QjL7kohavdYfuGF35WJAXimciD/ymx3u2t8UZ1tERx6KbvP+u3AwCBoh
	jxtqaE66GnsDPeyczDnvm0iHoB3Oek6ZW3WgH6QFOFfufNYef19Q11Qxa4nUIQLhmnHjZhPb7r/
	qC8paa/rxHGqCB5C30vGAnii1aISUu7R0VdS/8j/+/w0FBqHZB7VIFoEXzWcjaF6ryZlpMPbzRl
	pyPGcSt0upyNS6T4e3xDKqfCWfZp7uMOt8sEKN+KU1q2cZsLKbJfrB11eB8XHxvktFPPD+KR41t
	SJssUnDqhh2YI2h4jeTFRoYWep+TEYhiO0P9OtTyILOWuL0ofeZ39RpsN1k0ylZT+J8YwbEDthn
	NdQPw4gYGovK0c3NLb+waP8vjDbA/xVQ6annT0IH4a7P+u+8VU6/iBQ==
X-Google-Smtp-Source: AGHT+IEvNQBZsuo8Hf7IiG7SsKJtDHqDwAW6SCT0x2vVEo9x1zPaztZ3dLK1klhGjAt39vstSNNDxw==
X-Received: by 2002:a05:600c:4f4c:b0:459:d9a2:e92d with SMTP id 5b1f17b1804b1-45a27151246mr62315245e9.5.1755516961619;
        Mon, 18 Aug 2025 04:36:01 -0700 (PDT)
Received: from stiangglanda-IdeaPad.. ([85.233.101.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c74876csm169135535e9.14.2025.08.18.04.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 04:36:00 -0700 (PDT)
From: Leander Kieweg <kieweg.leander@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Leander Kieweg <kieweg.leander@gmail.com>,
	virtualization@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/tiny/bochs: Convert dev_err() to drm_err()
Date: Mon, 18 Aug 2025 13:35:29 +0200
Message-ID: <20250818113530.187440-1-kieweg.leander@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DRM subsystem has a set of preferred, prefixed logging functions
(drm_info, drm_warn, drm_err) which improve debuggability by including
the driver and function name in the log output.

As part of the ongoing effort to modernize logging calls,
convert a dev_err() call in the bochs hardware initialization
function to its drm_err() equivalent.

This work was suggested by the DRM TODO list.

Signed-off-by: Leander Kieweg <kieweg.leander@gmail.com>
---
 drivers/gpu/drm/tiny/bochs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 8d3b7c4fa6a4..d2d5e9f1269f 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -252,7 +252,7 @@ static int bochs_hw_init(struct bochs_device *bochs)
 		}
 		bochs->ioports = 1;
 	} else {
-		dev_err(dev->dev, "I/O ports are not supported\n");
+		drm_err(dev, "I/O ports are not supported\n");
 		return -EIO;
 	}
 
-- 
2.43.0

