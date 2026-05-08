Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C0D3264F2
	for <virtualization@lists.linux.dev>; Fri,  8 May 2026 05:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778217538; cv=none; b=OUP8L3kQavPHZOdEWH5H+H0K/XXaZEszik2fIcR3DFAVjNbGOCRTuOa62rASU807LXIoi9kCasKcG6TwpGinT8o4bzsgnxiPYROgI+rkkLTahnN4lGJOHEjUBbetk2jpggvlijApgCLtIjHkUoW850TK+9iTQX8tnye9ffI0DXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778217538; c=relaxed/simple;
	bh=wnuBfTCXjzfCdhWzj7AhvWHvJp0yriAxxo2qyT1rUB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HR1+SlkjVHqgdUAe2qfzUy74HmqR16HPn4gcieGx/OpYY8UKf/flZmLIkt3Z+jJEce3iVrIEU4pMpaPz+5Z/6Ijrj8Z1F5gcoRttHQJipyqCDNxOufRJ5xvfPZ43QiTkA+PceFMG0TSTjT2ATXyubj3JuUVowecK0yhmQq3qg4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pJdifsg2; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJdifsg2"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8353fd1cb5fso785351b3a.0
        for <virtualization@lists.linux.dev>; Thu, 07 May 2026 22:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778217535; x=1778822335; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3nUCYtIDEspjLLgUB8l95D2jVq1kgmCgW5n8KURqcH0=;
        b=pJdifsg2ZciGmFMS5KtCYiSwtinCTie8vUWJoBtQvD3G2pyIgroTJwiuf64+tMtVBE
         3QTysimjRp0ZqtwqJTlO/Oqcmfdkk5gNbcL/oH14XyLpjUqzKSRi9uOBelw4zhyOzk/T
         RQRS4fYFBH1KiGF8aXLjLPfNCc0h+G3Q0vV532PP0fUNOXMiqcsPCYnLENQ0Pox1jHRQ
         a3kyWYTdgOU01+BcP7frvme5BFdDAIApVwCWzpmJW0dBfHyBOSo+tBFoneRZuNXrc5ET
         bfWh3s+HsNaOVNTv8Dr5RrjYMiVven/TFBwELmS2b5OWBmi0Ch7zaSjh0waO2Ny5yqw4
         CNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778217535; x=1778822335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nUCYtIDEspjLLgUB8l95D2jVq1kgmCgW5n8KURqcH0=;
        b=r4nwEKDo+WjhdbflR2fkvX7RPpJ2oZ6CcmSyNSKPejvGxa3dp+IPNmVHsCWTew3PIv
         +uGVF2jSA8L+TiSw7U+Lzjz9tkSF+Y9otkuWyuL9G12TfymHG7VdlP7QDA8wHCmQ5ae/
         Yznh8oxPSq5CN01qcG7YJonaqnqDL3+h2Z8dAkUhwsmdlDuOvl7UbfoAHfAY6z3wx1hO
         WEiAC0o0wX2K2JSTzOm8q4wcdJBdvKAHsw51LOMMfDgMdwpR2KtOtoPCMlhhrJmQNqoF
         hfEU7w0laCqaefyDeyj1FgRR2qs3ZLL+LufQ3v8m6lugqvByUaAJUmYjFaoGsEt3jhqU
         505Q==
X-Gm-Message-State: AOJu0Yz3xbxJJUEU6wm46nCSbL9ziOU8pHdnAk/WI/Q/TTCWKLEfQW8X
	awF+D72t/8HTlEBH+bKRZdSzb5QYWD5Xne17pWveE6ONb/2FkCDY/TgfPnwj52G1
X-Gm-Gg: AeBDiesTmZOtLk2ODwv2ALIZtUAZbcHEEuZcf3XCcZ0Ian9MF6+dnh/LXIN3goU5V39
	V7KTjYiEc2ztQaKMF9K3fn7QyLH32XMPgpu6lv+oBsqU39jB6SevEuYRFbSEMpPsAvXTRD7eO5L
	qtCvG9wW4fQ+wCXhi2MR84VnsWPtNRX85h2QhpKYeLauJNQqclWtD4Q7yswRxkL0pkNykZ0KmT7
	6w2j3o+Xe/QGLuu18/15ZM/VnI5jQoe1hYWUVB1LmCMxhOYbba8gY46RskfbY7SsvRmRDcOMgba
	G3ArIN7Xk28z1rcVmDYNX5Loowsx9mXa+gD7w9HY0hIR1vf/WjccYcVjCGtgVznF/huFXYraJus
	V3hkkhjl2AJFcBuV9bnGWMCKsXuZfjDb3dd2iILQd6WZLyS3FE/VEi6aV/TIqMTZ831XJeHVP/E
	KhaRcG3WrzChWCB+cZkOtRA7616LFx93fPBIRiWqyL5rc9SU2u2vDKIi0MavwIQTGt7egjYdpPg
	uttqFyd+XBtnq7uBXR8dEkz3W+OrD0aO3Y=
X-Received: by 2002:a05:6a00:3e1c:b0:837:8342:abe5 with SMTP id d2e1a72fcca58-83bb7cb6c1bmr4808279b3a.18.1778217535314;
        Thu, 07 May 2026 22:18:55 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c861esm13460826b3a.30.2026.05.07.22.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 22:18:54 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: virtualization@lists.linux.dev
Cc: Dragos Tatulea <dtatulea@nvidia.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] vdpa/mlx5: Use kvzalloc_flex() for MTT command memory
Date: Thu,  7 May 2026 22:18:37 -0700
Message-ID: <20260508051837.1744409-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The create mkey command memory embeds the MTT array as a flexible array
member. Use kvzalloc_flex() to allocate it directly instead of open-coding
the struct_size() calculation with kvcalloc().

The MTT allocation still needs to be aligned to MLX5_VDPA_MTT_ALIGN bytes.
Since each MTT entry is __be64, align the entry count directly and avoid
carrying a separate byte length variable.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/vdpa/mlx5/core/mr.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index 42c2705077a6..6d02ccf9eb91 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -221,11 +221,10 @@ static int create_direct_keys(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *
 
 	list_for_each_entry(dmr, &mr->head, list) {
 		struct mlx5_create_mkey_mem *cmd_mem;
-		int mttlen, mttcount;
+		int mttcount;
 
-		mttlen = roundup(MLX5_ST_SZ_BYTES(mtt) * dmr->nsg, MLX5_VDPA_MTT_ALIGN);
-		mttcount = mttlen / sizeof(cmd_mem->mtt[0]);
-		cmd_mem = kvcalloc(1, struct_size(cmd_mem, mtt, mttcount), GFP_KERNEL);
+		mttcount = ALIGN(dmr->nsg, MLX5_VDPA_MTT_ALIGN / sizeof(cmd_mem->mtt[0]));
+		cmd_mem = kvzalloc_flex(*cmd_mem, mtt, mttcount);
 		if (!cmd_mem) {
 			err = -ENOMEM;
 			goto done;
-- 
2.54.0

