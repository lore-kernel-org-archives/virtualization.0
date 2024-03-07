Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5E61E52A
	for <virtualization@lists.linux.dev>; Thu,  7 Mar 2024 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709808086; cv=none; b=QWHU5hNyMgG5iOt5+z9amx3FsXvWSoqH5DgyaXmT7xbj9Ko2KBE4bH1iWEhP6jGK5xwFnCdVBaQvVR2Stl8vOVcbQk+uLjBuXY0C19eNRpSuSn6D4FqPQlz0CtrFzdL4pHo69+5UZhgmv4Qlxwd97fClETWeGxz+XYgWt5ecvpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709808086; c=relaxed/simple;
	bh=u0HbKc169Dv/IfHrwEar9MH/mTXRwSs/imuaMF9eTMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=oPFSiz7HGNahwmH8GL0eKNanFmyOUcNmsf3gYu0qCiI0D7JqhG6/6Bj+eyUI0iJUh2EdBH2sKt3Gm5qL9ymbljox2FX4q59D7vbt7RggkHLFwbnwGZGea7lfCz1J40SxvHVHqmlu6cuXc/0RcVUg88OtGuoqFSA/YisSIJNC7Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZFuEQmj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZFuEQmj"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412eddd165eso6025125e9.1
        for <virtualization@lists.linux.dev>; Thu, 07 Mar 2024 02:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709808083; x=1710412883; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qgaA4hwjMMxXsNn/H65VvY2aAb1+rjCArUM3dz35oeg=;
        b=DZFuEQmjAYQz6p8Dz5RDiiAVSO997WUgOoryko1haiJHguiQxd80cmpJi7o4O5WH1e
         HmyeWll0K31qtgL/IVTilMSUBzPY/FAnhRFNU4L4Egq+LDlG7qvY0GWBLqPOrKiZh3qy
         tqWElBoNDxh1V2GBNhm8hRceN47zqOypq2gIccrRrdqDT1BJ6NaY6i1Nl56jVJM1Vfm5
         u1h3YAESvfKotk9gQ2Lk7JTS8zKAdlUTQ+wMLYgUgUOuRROQiggJQ8ozXsNcQkiOTGvU
         OH5ELNVTm1dN3628/I7J/vFmWfhLvOH22NQkd7HvQEtQdhI/46aCqneeF4NSCU7S18Sc
         GBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709808083; x=1710412883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qgaA4hwjMMxXsNn/H65VvY2aAb1+rjCArUM3dz35oeg=;
        b=J18awWSJEi9L73dh8IbnS/OP9qvUjoX7dFjVKYuKkWn5YUCVx2mqR4/Rak66UzjsRu
         mj8Y8hQ0E410E8EDlLQo7GCCeSYpMr7ilDMJ2vHJvk5hk6Y/85mJKTPRR+NHhbCtNBk+
         3/BQMgaeUQwAqbw23gzgsoS52KHz0HNzr/51L5kpf3rxMDSnLYEfp1fd2dN2S0mLIFjs
         mxt0fHQKRCJajQjyczDjuMc+6q4B2/I6M9jBiXwOU+U1k23ExDtfzK03VapGixS41quR
         F5XaPQgfb5Bn/9LJnS3N9u6meqRWtXXwrU7HzETg5vVNz/d21Bhrx+cK0KQJZqxIJYL/
         EqZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTDI5Y4hscwYwmb/KjVIvP7CL/YMBIieX+zDlUVcEJZQouAbXL1022M5WJyfb8CLShBF8RtVFWaQnw28CUf/zwraHUBIil7u24owodH8M=
X-Gm-Message-State: AOJu0YyEPErrgKtj2I1jdOC/9dkJxXBCOf3LrmBnBptpIYL8/JwNVtvI
	QPGs04zaneVvnrFchpmcv9NaY87oxWUPb2v2pst4A1DNEdTC9+Mf
X-Google-Smtp-Source: AGHT+IHFfQLpO+Ajim+32v9BfNQVyFeSt1SNjsGAX7r/QvA8WtdX08e2LuaNBQOxKkcCwOPQi0HNYg==
X-Received: by 2002:a05:600c:4ecf:b0:412:b457:6303 with SMTP id g15-20020a05600c4ecf00b00412b4576303mr15685863wmq.21.1709808082840;
        Thu, 07 Mar 2024 02:41:22 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id fk15-20020a05600c0ccf00b00413133cb9b8sm384147wmb.19.2024.03.07.02.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 02:41:19 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/qxl: remove unused variable num_relocs
Date: Thu,  7 Mar 2024 10:41:19 +0000
Message-Id: <20240307104119.1980621-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable num_relocs is being initialized and incremented but it is
never actually referenced in any other way. The variable is redundant
and can be removed.

Cleans up clang scan build warning:
drivers/gpu/drm/qxl/qxl_ioctl.c:148:14: warning: variable 'num_relocs'
set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_ioctl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index dd0f834d881c..506ae1f5e099 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -145,7 +145,7 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 	struct qxl_release *release;
 	struct qxl_bo *cmd_bo;
 	void *fb_cmd;
-	int i, ret, num_relocs;
+	int i, ret;
 	int unwritten;
 
 	switch (cmd->type) {
@@ -200,7 +200,6 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 	}
 
 	/* fill out reloc info structs */
-	num_relocs = 0;
 	for (i = 0; i < cmd->relocs_num; ++i) {
 		struct drm_qxl_reloc reloc;
 		struct drm_qxl_reloc __user *u = u64_to_user_ptr(cmd->relocs);
@@ -230,7 +229,6 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 			reloc_info[i].dst_bo = cmd_bo;
 			reloc_info[i].dst_offset = reloc.dst_offset + release->release_offset;
 		}
-		num_relocs++;
 
 		/* reserve and validate the reloc dst bo */
 		if (reloc.reloc_type == QXL_RELOC_TYPE_BO || reloc.src_handle) {
-- 
2.39.2

