Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685701662E7
	for <virtualization@lists.linux.dev>; Sun, 11 May 2025 22:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747002135; cv=none; b=A5L8Orqt4lArkuHvqnbq4Nia178Nm4sQM755ILE084aCGpR2ibv/gbvAeSlaEMOv2ee8rHiqBUc0xn2Insy6rBziihT38u4lsOMWJ3ZgbkoVT+Eh4iZtpTO0Z5S4UyZskrdvaoR29jCplkuiyu/hSgil+VgMcxJGszucskN6Yio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747002135; c=relaxed/simple;
	bh=RfIn9bmSexrd7M7wBFF6Cbmoa+oKqgWiyHr0wJXms8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DOkqi67lHM5A7fAvBwRephbYJVJgLyDMGpYpVURIxWh4Cfd2iUAhMuU1W/GJaZXuZM74Gxzx3h8G2BzR/s1ktwmMB9NlwOupH+TA5Pny9IIDQrs5yQQJDwnlXP9EYrJUEDmuFVaWn5vimI3eHMyo4c5LqTdF/TUKTq6YHpBQpl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7426c44e014so101520b3a.3
        for <virtualization@lists.linux.dev>; Sun, 11 May 2025 15:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747002133; x=1747606933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tM26XwnTvJOmDDum8lOjUHX5JW1MkKCMFnfkzUeSffQ=;
        b=HlwWOYjaTNc+0jNU4yXNMjwhpNY+pzHMpe5Oo5399LlAgN3w3L8MgzR0RtVEF8+7lq
         mHL4NySFClDnIvMki2pWxz9Okhw06+s0KsA4pmFeMMybqvV1mn68eGTdKurHmzig3ob8
         61ohAVS3ova9OO4Ty1BtYM3QnNsfZuGZ5hLabm2eBlxxd79ktH4+lGQdHREVXohoAYy1
         0vVzuCLVmU0Qx9gr9bSFU4EbYz/21GNtO0aCjfQvRPYyEEM6p5MUEYXjlrP7IpU6euAv
         AoHoQJKiD3fA+Ggm6w+ippu1vokW00TMxGXLnL3VW6Cn5LB3PCy//kh7pj6uBC4tgq0a
         podw==
X-Forwarded-Encrypted: i=1; AJvYcCWDudpwI3Bwtb5r5sse1IzbCgDy9eXumyJ/drYP7m0J2J98okwvHqQFNRQGPRnE9bin3klP18h9jEONDlL/IA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3LDQk43kKwputMmIEXJ/xsTDKWiaBm6UQFng+altBk8y98NtY
	ATqLZiA59tfE8o6btz9EZ+fxsjX/cnELz1jmUm9Ytz04FMDZBI4x
X-Gm-Gg: ASbGncv45M0tzhdG1gl4Eesepyu2rOhjGZCGUlPuitwMZnyTDZrN4iqhUXwPR5MShKb
	JE6iglVnbyrTdAP/5C5/Pw8vCq+PAmd4HWntygCLDf3btfdUVu31WY7rSw7HRBonKyLcSjEgGRz
	aL5KSHxk2+rLK/Z2V9vLgEtBdsjrKr9SgeMWIiQvC2lAvGs0lEJPpSRE1EkFIOK77NNzoBIxqVQ
	Hwt9K17c3daY2OgKzGE6oxxQPZGaKaueCht9JJNLaYNuaSI7c2kdZvIrOEwEa68dfy951HRSkmc
	1pIZGBaoixVeiEsNQqar9w+8cHqS/ME=
X-Google-Smtp-Source: AGHT+IGFNbZwi4DvSA8eMlnyQIuIaeH8HI52cSPd6JL+isEsuYfpi3ZXVI6HKyxijasigvaZvr3RPA==
X-Received: by 2002:a05:6a00:9286:b0:736:5725:59b9 with SMTP id d2e1a72fcca58-7423bc1d5e9mr13676723b3a.2.1747002133463;
        Sun, 11 May 2025 15:22:13 -0700 (PDT)
Received: from sami-laptop.hub ([115.131.45.100])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a10867sm4884425b3a.110.2025.05.11.15.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 15:22:13 -0700 (PDT)
From: Sami Uddin sami.md.ko@gmail.com
To: mst@redhat.com
Cc: jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sami Uddin <sami.md.ko@gmail.com>
Subject: [PATCH v3] virtio: reject shm region if length is zero
Date: Mon, 12 May 2025 07:51:53 +0930
Message-Id: <20250511222153.2332-1-sami.md.ko@gmail.com>
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
v3:
- Use idiomatic 'if (!region->len)' as suggested by reviewer
v2:
- Fixed coding style issue: added space after 'if' statement

 include/linux/virtio_config.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 169c7d367fac..b3e1d30c765b 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -329,6 +329,8 @@ static inline
 bool virtio_get_shm_region(struct virtio_device *vdev,
 			   struct virtio_shm_region *region, u8 id)
 {
+	if (!region->len)
+		return false;
 	if (!vdev->config->get_shm_region)
 		return false;
 	return vdev->config->get_shm_region(vdev, region, id);
-- 
2.34.1

