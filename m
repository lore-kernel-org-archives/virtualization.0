Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8011D63C2
	for <virtualization@lists.linux.dev>; Sun, 11 May 2025 11:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746963890; cv=none; b=TebHlfupTBMEdXZHB33Gz2LisLQaU9t8QkdRjmHQDycosFpX+1iRbFzOehUX72lCBAlcxdZ4IzlYVNtMvfJq7ZJFWprtHqCDZgX2TfRqDBEc0yyYp6C62CfVAx2Kt6swmU5JUGJFNxan6hH05L16tQLxWVoiHaFF4PpfglQLAfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746963890; c=relaxed/simple;
	bh=nZNbzRH/a8a2IIoWWk8/rBDAiPPaS18qaGq9pxOm3iE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wn8NXYYTar9BOjCNjildNoFHBnClNGpG6xow+g96YhA7fHOHCmkyG2rpDaHOj+H5rSO2eoivFkd1U+IPIce59g/V4z7wPCDoGRF350pRROM33x5j+IMm2XH5PnXR+o+EpFZuO0zGy6BnnPgS4mPXO0uUje6PohAoIVM9zjCro0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22e730c05ddso31555935ad.2
        for <virtualization@lists.linux.dev>; Sun, 11 May 2025 04:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746963888; x=1747568688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M7G4Wu0KTwAJdcB+9Dtyf6xEZrbqfOK8YuXDGQQfqDY=;
        b=SYBtMRGQoxE02gX9fkVbpCWIMT1XwqO2iRHbRggStjei1mHYJ2hNEaem59oCkplf4E
         ZZpBQfeTFWFGsZPxwTmuS1/mAFx2qe3YU+UiRTLXDho3CcET4U6IzbybhaR2E3PiTKak
         8O2PIzyGk8A9QddzqYP7yEwbAOyMcZNx8maYw/V/vLITcRRaFParxo8y4NyU0h0DRJDo
         S6Op5JAunPZGCw2RG+y+c1rdtWqTr0a24GTGyTUcwcRANhH7Y5kdpenx4n3ZZ2krtPfv
         l9yxPW0HfvLtcZQRWuR0wUFKXA38iGj6w2c36B6V0icM9zgUvKXNpehWqx0uM7q6CQYu
         4fYg==
X-Forwarded-Encrypted: i=1; AJvYcCWvcQMCbPxx+SNFjjRDKLTv3pClt5dIXSEjyY/fi3ItEXY/9V8mfTohxK4NE21R3b/IsJSUHit3oXiCfDlUqg==@lists.linux.dev
X-Gm-Message-State: AOJu0YysRs1kR7be5p0IZT8m3JbGW2Siw7gwq8qsG8m+Bzk41Yi/XnVu
	SP4oyReAaajJPpLZqbWj7dh63Zj1kzdwBgm+A5DoProepZsbyNJD
X-Gm-Gg: ASbGncuqrg3TdcccMXUdRXbrM6cP0qRWbgMXjWyd6+VJtsgmHvBQYh47uaI0LWcgXoT
	bEeDLriydz5VV5ELFsqOLSWrKwn70hadtDwd6ZuxHWljtczGyWT8edARe6yevM+cdMLKZrch6bj
	7qu7EPHk4a5s2DlceqhS2QPOYsD2BUvYNX5cVRn71k9jBLUsGdm3B4jrHQZdFrt/NE9a9ge47E1
	r8GvepJh2cf/U8rft+RtfdlVOMkDHtKeGM4hXmGETjbULOix3x3hWM0CZqmtyKAfPIh12o3MJv+
	UXIQ3vN43bFUUb+CE+2nLWdFJrKvk7Y=
X-Google-Smtp-Source: AGHT+IFUn2uHbqLjP/EQgTpHbK7BjACdR7+4Fkw/htqQ9YeBMW79Iz2JpeL7a/ksY1yVFmlJT7HsGw==
X-Received: by 2002:a17:902:d546:b0:22e:4509:cb8a with SMTP id d9443c01a7336-22fc8b41084mr141753445ad.21.1746963888296;
        Sun, 11 May 2025 04:44:48 -0700 (PDT)
Received: from sami-laptop.hub ([115.131.45.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7741515sm45138375ad.95.2025.05.11.04.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 04:44:47 -0700 (PDT)
From: Sami Uddin sami.md.ko@gmail.com
To: mst@redhat.com
Cc: jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sami Uddin <sami.md.ko@gmail.com>
Subject: [PATCH v2] virtio: reject shm region if length is zero
Date: Sun, 11 May 2025 21:14:28 +0930
Message-Id: <20250511114428.2061-1-sami.md.ko@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sami Uddin <sami.md.ko@gmail.com>

Prevent usage of shared memory regions where the length is zero,
as such configurations are not valid and may lead to unexpected behavior.

Signed-off-by: Sami Uddin <sami.md.ko@gmail.com>
---
v2:
- Fixed coding style issue: added space after 'if' statement

 include/linux/virtio_config.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 169c7d367fac..b641b16d42ef 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -329,6 +329,8 @@ static inline
 bool virtio_get_shm_region(struct virtio_device *vdev,
 			   struct virtio_shm_region *region, u8 id)
 {
+	if (region->len == 0)
+		return false;
 	if (!vdev->config->get_shm_region)
 		return false;
 	return vdev->config->get_shm_region(vdev, region, id);
-- 
2.34.1

