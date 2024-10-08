Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E965B1E0488
	for <virtualization@lists.linux.dev>; Tue,  8 Oct 2024 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399136; cv=none; b=bIJ5VlnaMh+w7fI1ajTZ+bn9fNc2AOXLK6i+7PyU/Ish3OdMLCqsijVEbY5PS/IdCjx9tD5d7le9jzScTjqyAg5WrOJ+F3ojFjAXoaWrFdubWaRDct0CfhVrbFOK44f/Go8RFIkzNlsfT+gYlI0qVmYRCiv8sAcbE5zRwnquedo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399136; c=relaxed/simple;
	bh=Zn5Lg4NhSvGrhq3IQewNEP54T8jNklAcWLlaRE/1F9A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MPVo7ezpAfUqDQln9hEGGZwJU0j1AV1ZjQQ6v19odwW3RRqQ7WRFCK9tzI+Wgl2MLk8cjT0kyW1htHEsFDwdrF/RyrvwumIS/i/KjBalFPHbSFUJGlWauFpaB77i62TQeFe9TDRz+TivVjvbeTXnCzK0vATTOSs66668V/0S46A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJeLyuOc; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJeLyuOc"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7157c329d93so195067a34.3
        for <virtualization@lists.linux.dev>; Tue, 08 Oct 2024 07:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728399134; x=1729003934; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xUyhXq0XNpQ1vRtn0GLY0jKRlrx865fpEqPXy7ajtC4=;
        b=YJeLyuOcbQR1a7shlvqPym9zhDJQBMP2SNiYu9+OMXMZximhAydxluGImUHU9qfK2H
         Tu3AKWAuoO43P4hvLGdP5YmBU6azxg0JDkxiufBU0vco5fBQ54bW5g5wjyXRA8ZP9tFF
         weetqX+jM//sEte7jrMF8IX+qA4HFXiEuPhQAQUse3dQZKZIZ+qyqvNviNyX5eR5ZUh5
         8cXWKTcmSrgKg4QuByd7Klm0EjM+WKcdz1YNSqEuRouEqMUT8QAG559EwQ6xvwMJPJU9
         N3wD7EthE1k8Rkn9PImEQLUGoy/WM/kuTQ4bVBf/hQ8LgJPlzq9pe0Da1zl1Z/0w8m5k
         FYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728399134; x=1729003934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xUyhXq0XNpQ1vRtn0GLY0jKRlrx865fpEqPXy7ajtC4=;
        b=cxVWTX5Tw0BOrI93cHE8ZG9c1Vs7rAcbO7tJnU1n5SFqTizI86GCdoy6ARJT4a4pEm
         mpGl6T4v2OwAHzljUYs9npbjHeujY5RrY5+fjCmX5ILYFotiWpNVj6+CzSV8vrP+dDne
         PPz/6tuApHZbWMM3eDXadgndf+qwFHYmLP8MbtrrpPcL6ORcwWSnl/snxDTgxptSmRgl
         zs/cEvXKGAfbLKOZF0w+ZhuMd32FQYpRuqBocnteLUgYaF6N+ymhUSOuhVhmVf3jfZRl
         gyfFRi5pgx1eiLJOSGqh0XDci3bXYUxnV1X3Iq2IWTou8kCQV3hgbGPSww83En82YqY4
         fu9A==
X-Gm-Message-State: AOJu0Yw/40YA2nEjGwmQ4bpVlfQ8GaISBRvIrclFzcj+hlyuKJmX/atj
	/P3Drp7m+Ul2xD/xVQHQokBM4PVdgASD/8QUb64vdnU/98/kfRQh
X-Google-Smtp-Source: AGHT+IEkXbnGd0K9vpnQ3q25JVRnOSg43qf6tJeJGStyswbMqU+pptDh76yBoZwTlOKjBsOHGzfg7w==
X-Received: by 2002:a05:6830:926:b0:710:f300:9fad with SMTP id 46e09a7af769-7154e97cb9fmr11998102a34.30.1728399134027;
        Tue, 08 Oct 2024 07:52:14 -0700 (PDT)
Received: from Kuchus.. ([115.96.37.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c4cdfdsm6870944a12.87.2024.10.08.07.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:52:13 -0700 (PDT)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	perezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shivam Chaudhary <cvam0000@gmail.com>
Subject: [PATCH] Fix typo in vringh_test.c
Date: Tue,  8 Oct 2024 20:22:04 +0530
Message-Id: <20241008145204.478749-1-cvam0000@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Corrected minor typo in tools/virtio/vringh_test.c:
- Fixed "retreives" to "retrieves"

Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
---
 tools/virtio/vringh_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index 43d3a6aa1dcf..b9591223437a 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -519,7 +519,7 @@ int main(int argc, char *argv[])
 		errx(1, "virtqueue_add_sgs: %i", err);
 	__kmalloc_fake = NULL;
 
-	/* Host retreives it. */
+	/* Host retrieves it. */
 	vringh_iov_init(&riov, host_riov, ARRAY_SIZE(host_riov));
 	vringh_iov_init(&wiov, host_wiov, ARRAY_SIZE(host_wiov));
 
-- 
2.34.1

