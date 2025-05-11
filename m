Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EBE3987D
	for <virtualization@lists.linux.dev>; Sun, 11 May 2025 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746963020; cv=none; b=NPuZN7j3w9NFCe2wNgplqDgJGNcA379vHigliy9Atoc2G8xLw48J2WE1ummqRmpzl9sMQTcWwrPtHD80VoFYRX8XyESdQ5KYoaqLEOGm4H0NPd1GHr517PYCOUqCKoXTGQNOkiQ3l9AxFb32uhjrqxOWX11fTVz6t6uON5zXpPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746963020; c=relaxed/simple;
	bh=+OeCdGeJpLODqGo5xITfIxosQaHmRQG782TvW3Rx91M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=etypio7NrhYAQ5iwjXEhSWQTTCBBUrRylLMa0aCJieXvOr95x9abFE0TsRhENq43WbptF6cdss+WZdxzOTVhPXlh5DRUJ6PkJtONhWAax4LMvO3yj+Lygao1bUnLZZfVj/zOTaqWbCIXZK64abAJ2f4TQmpXZWqktXHTPYtlUpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7415d28381dso2675151b3a.1
        for <virtualization@lists.linux.dev>; Sun, 11 May 2025 04:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746963018; x=1747567818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dAWgXd10woF6tGateM9qIPHOps1YIfwoETiHUY/GHrI=;
        b=t+i+GQyZbRv2XcBBEcTDSzOKH6AZF2VrNLoJroR5AXNnSjhVvk1mldhdRCivvNAqAu
         O0qQKX3Ixia08INLw5PbWUcHT8TOS3EbHRKXikBVYTUrq/wGPXuEaGh6rwtLCC3OGgxU
         MbHedElC6hXBvdZSfCeuguZuxU+9mThqN796K/OWn7dq+kseGKuAwM7ruU+XCjfyCbbG
         iyOGQeown4EUsrE++8b3jtUlyQmdt1W4RPS7aHzrmOyycZA99zSGBi0i9HztxvMnVS9p
         jF98QJuyXy6zTKSaVH/MiILlOyL3OpMzcbf3V/bodXdwYWEKpdtSHn97oAk1rw28wqt6
         t10g==
X-Forwarded-Encrypted: i=1; AJvYcCXQScygkS7kgkEMF6OUbhty1UPRMqfjaiAJ5TyL0JrtVcl8SN/8TGO6bd1gJ21OQzgSg2bW4eflrhnbEo4M1g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7cfoSFbIdNqKgEAUR78axb4XqTj7CSzU+VdEwvmA6Np8qodHa
	TdjIlOTewBSgNJg9gIychakkSKOmXnUibQiO29LC9NLb0LPDL6rAniHydy3MVT4=
X-Gm-Gg: ASbGncuUmi0xGPZM7RPhSYhx4aTh+W5yxCfGqyoQYVsVAKTqxBUSBFsH79cTiYRYurR
	a+QQsQ56liSJqcNic8q1gwM31ynmjadhuomtHHT49MjkDjb5xs6NWbQLlPfE0TEDEyOIfSCaO9v
	Pax+0IN5bMAhtdomqx7z6UXuZAly2OOISBPBLY1aMcTdurZ/lxgvWKytoTnCwvSyyZQOP1MCh5E
	sZZrH5Yj9ptXJFI/X0SDSqB9G91aIefX++rchZyEoebW3Zj06zosZM1UXJ8yPmkUqwC1eoTsXnc
	8DdU6m3IJ3A7zXNdGmmZEN8uotUIMxA=
X-Google-Smtp-Source: AGHT+IH93Jmjp5u+rJnqqD6t9rGcNHBHAKl8ENOicWrZp3u0OqIM37d3cNzqX9X49U5fdTYqmHNMuA==
X-Received: by 2002:a05:6a00:a83:b0:736:33fd:f57d with SMTP id d2e1a72fcca58-7423c055aa5mr13231077b3a.17.1746963018197;
        Sun, 11 May 2025 04:30:18 -0700 (PDT)
Received: from sami-laptop.hub ([115.131.45.100])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a104e7sm4442952b3a.104.2025.05.11.04.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 04:30:17 -0700 (PDT)
From: Sami Uddin sami.md.ko@gmail.com
To: mst@redhat.com
Cc: jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sami Uddin <sami.md.ko@gmail.com>
Subject: [PATCH] virtio: reject shm region if length is zero
Date: Sun, 11 May 2025 21:00:00 +0930
Message-Id: <20250511113000.1894-1-sami.md.ko@gmail.com>
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
 include/linux/virtio_config.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 169c7d367fac..f4fac027e830 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -329,6 +329,8 @@ static inline
 bool virtio_get_shm_region(struct virtio_device *vdev,
 			   struct virtio_shm_region *region, u8 id)
 {
+	if(region->len == 0)
+		return false;
 	if (!vdev->config->get_shm_region)
 		return false;
 	return vdev->config->get_shm_region(vdev, region, id);
-- 
2.34.1

