Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC5E3680BA
	for <virtualization@lists.linux.dev>; Wed,  3 Sep 2025 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925979; cv=none; b=D3x6LpFwJOOnGokIHTcQWs6wmzHEbOn45t22dmBfn096VhywSg97R9wjn5F82WejZI4kiM+rzej/guiFDC6XkuDnLQYk8H+rtq6qGPdvZMryR+Xg4AbSeSwbrtXPK6cLR2wC7FJQ9Xvu3JkCeeFuWCYE605Z4rzvVA+t26WpxtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925979; c=relaxed/simple;
	bh=L9mBqIG1TiHreIDV8a0dfjkIxduVLSZagZOu8X4AsI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXgduMXpaEhkIzUDPUrEArQYSeoQXgIrd76QdbBVFtl0UsQg9B1DWJ3LOcXLYUeY+ZZOYDjq3Box/Yq5dpCWiqYi3gxb62cK5wzPNFVUVAeNFT4pu1TA3erZ24QOI8hs3oOnn+BsjghjtC/vyFItfUYsGDACyQC26RxYABDf/zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDYXtds7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDYXtds7"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24b1596b1beso2815175ad.2
        for <virtualization@lists.linux.dev>; Wed, 03 Sep 2025 11:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756925977; x=1757530777; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p96JFKpspRPKBmH2rgBynj/gu4bh0EGooQeUZ0NhcIU=;
        b=kDYXtds7EFUOgaZjiy6Yw0qSb3TI6eGMYV3IdBP98loKiGWhe8rw5WYprJmlIWD7pY
         tx2jgQowYl4pQJev1RTkTR2ifi1tZuqZYafOHZMnXyz+jiAC4Pr/8z0gI7qVuWITyda2
         ANOU/nqJS4691k+2p6Orx4pAj6FO5mKsU6my6JTVSn395GI5eiBfTuLYvanVusYNa9oL
         Brd0FRrXKz8Psfua8q5W0Ap5eSdZz80M2m6aWN3C7+LP6qGK2fTTVW4qJk62sDvE243n
         HIJ3obE76XS1uDXBtXl99J6Y8WJMzkboPGGKsqrw8HD+XRWk8WnGLTwDbQEhOzwPugo5
         0zWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756925977; x=1757530777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p96JFKpspRPKBmH2rgBynj/gu4bh0EGooQeUZ0NhcIU=;
        b=EQplRDCB/Pk/X0YIbJk3aXXFuG/7kl90NHSXuni157VK6+SXSs/fFbFqS3wclcYUsC
         F+WdDaRPqcONVbnO2d2tZYHDWF/2PcE/Sf/FqV5hTvxBpQaAU7LIDbXKoXRLOOt5tjlV
         Io+l0P1qm1zxvcRm7HgHnh/pSfG4k9duTLzzNTMNRl+hCDFjKUASS4Yvg5t+UtAzg328
         AHyRqN0MurLamPKFVSl5NrAoizUIlEncpk2oths0RTQe9r10D5P72XZtlc2mSjPsFUiz
         HLn2hVcAUtAgy4pFegcU72TOnNhCZ3H279D6LyFpZWGk9RdJXiBoRgUj9khbOxp9M1Oo
         eOkw==
X-Forwarded-Encrypted: i=1; AJvYcCVUqQhIe746YzrlAa5PZ+6023552vfPLB5gJF4A4VvRaQwEdYIw+76OJNz7TvCBERLdGimwKYTFDBDAFx0usA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzC++xF6EBKTPUp2VAykLpxcBm65E5EJi+N8WXNpGV6hZgDA0a2
	8qUqasNn3ISxvef1S9iOKJLvzIP/ueOQijg45Kw55kBaNNDlZRzA2m4D
X-Gm-Gg: ASbGncswRxHEDGsHfg5jo+7ULv2s5MGZYMw3uzLQoJHbkkXhB5wJ1TLUlbLn735UWh+
	aw6yIn2SS3hucHsI66W+oBtjBCfgrUPskY737Qlj2YfslrCP6EitDpeHOMoAhiVNm1gl5DBdy6B
	2//aQm2n4rt40dS/kZJ2NFALf1FG3U1mlm7f23dKNPo7KgxIN8KT5DcDMf4v4Q2VkOqbcZmI14W
	jzOj+TYqPlkt3Lkm3/o9RLrk9DjpQd207uRUwu2K6qRTjttPeCUjvC1SjsmHkr7c4cc2Ad3cIID
	EtkoVS9FODFc1Lbq2M6XaT7bpeEoluP+iK+f5IIM2vkIxZrAL+AKK8qX8YjJ3a/vKjlTBGnnmmn
	JqKjMZfFZcvbyGOEI8Fg7mTSBv8SNt0c5k/u03Fb/II/kpFmemMkQrzF4+pO8H+ZNrG+9IysgrL
	I=
X-Google-Smtp-Source: AGHT+IF6bU8SPLeBKOcF3DV0pz3IKcU2SprGWCJIgsDwHZ4utP76U3dUm2BhH0lDWIsPOTFAl0TAFQ==
X-Received: by 2002:a17:903:2f8f:b0:234:b743:c7a4 with SMTP id d9443c01a7336-24944b19ea3mr233283115ad.38.1756925977585;
        Wed, 03 Sep 2025 11:59:37 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-249065ab343sm169403475ad.126.2025.09.03.11.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:59:36 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-efi@vger.kernel.org,
	virtualization@lists.linux.dev,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Justin Sanders <justin@coraid.com>,
	Jens Axboe <axboe@kernel.dk>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v3 2/7] aoe: Stop calling page_address() in free_page()
Date: Wed,  3 Sep 2025 11:59:16 -0700
Message-ID: <20250903185921.1785167-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903185921.1785167-1-vishal.moola@gmail.com>
References: <20250903185921.1785167-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

free_page() should be used when we only have a virtual address. We
should call __free_page() directly on our page instead.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/block/aoe/aoecmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 6298f8e271e3..a9affb7c264d 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -1761,6 +1761,6 @@ aoecmd_exit(void)
 	kfree(kts);
 	kfree(ktiowq);
 
-	free_page((unsigned long) page_address(empty_page));
+	__free_page(empty_page);
 	empty_page = NULL;
 }
-- 
2.51.0

