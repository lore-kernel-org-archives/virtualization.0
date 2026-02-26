Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5892737C0FB
	for <virtualization@lists.linux.dev>; Thu, 26 Feb 2026 11:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772106961; cv=none; b=sGIrg1L9NvEMc0lD5RWZa8BTLrnw3giciVeGuLjve9bnOew96t3ik0UCB+8YBT2D+oOQsmXy1prsgguSHppUDMv/trZPbMLCsxK9P3XytSvbHMl0DyKOf+xSSaTZ/N2WbMlq5f6kk79OmeF/4TD2wI0UkoC2G5bmbxOWdZ5TqCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772106961; c=relaxed/simple;
	bh=w7vvFL90iWOJwmFthiIqX1DVDr47xxTizqrwF6xi2fE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=szMUZomyujOdE/HCflvuhwrRiLQNW85b0R6DWAX06UJJoSHmjFYn88lkibM1e6eaKSEe2yLRhc81U5BNB6N/yIKSNY7ZOeeLIR/m/9QW+6h0rGT0rYHjurWEYSu4Q228pBXQdCxO5gfJdmXpPyB4sy8AQ7fiLFtuZLFTLYeMH9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dHkMKXWj; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dHkMKXWj"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-356337f058aso320673a91.2
        for <virtualization@lists.linux.dev>; Thu, 26 Feb 2026 03:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1772106957; x=1772711757; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G5RGwY3a59FVAlUmYvzH4CPVvQ3Lh3N8X70H6FVGhvY=;
        b=dHkMKXWjaXC8nEyRjVyMsxnuwlTSvRBi18rnkVQ21lTuLmML5eqopQQAkj/zxm/jDw
         /LmnlCqkzWUyR87hniF9BXrdbcCqDG/pWtGdc3YVUC6viV+prPKICEAIC6E0VDwUlsJk
         Z1HVp5KsecJtJtRrT4nyZ8AKkYyBVrIA8FfwT6ESQaxLjjQiPQIXNa9RnpLpxhdCLIGG
         FSjU5PVAo5S3PLZBPpmjz+4VKXTz8OiPW3NkLRGWpfTjMbMqm47ETG+EH8lvMAesLOK9
         qVC0F4ZcIakd0H9qzTtgoawGfpHw0sLRaB3gLk0m5wEbD0WHRE2Q9aqi1/hUOYMvRNEY
         Q/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772106957; x=1772711757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5RGwY3a59FVAlUmYvzH4CPVvQ3Lh3N8X70H6FVGhvY=;
        b=kZFkcBVoT/PdZws6gPR4TI2fDRX/eBs+OiabESZl8l6qNDm4PB8RZUkQ9S/8GFd4cV
         ZOxy+DoE2BwH6mkvRsiUd7jquW2DZO361FcY2tzYlLjzUlHk5td8wpSpNka7geLDtEeZ
         nQwqorNICQTu0PzyBTjMK0nI48diLP8qCZ8e6htoxd7beTJ9HbE4gjQxc2HyZG9rCC8a
         3Qiiq8qtH4MhtCPUtVbCVqeSuswSvhC+PtlFTSN+li2yP2bHiym+HGBR19+DEHLfDttG
         YbkLp5WXXFxNeYh3tEjb7bxH0wHiJV75rMmol+xpJRObaT2j3ukHIGD/gR+oKP6ounYU
         mcZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu3enp54+9a/EckVnIpu8BPC5hULzHRVKh3XVMdB8tlxL1vDxVcEC33kIbTtFxcWbYFzcRfnBQx85oEW+Pjw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9asz9pH37xIzdT949NepTP2HQgSU/y4Zny0yLr3uU1WJ7Ws00
	3Y5Qi8vFjsSpzQpVD6pn/Vuh6cd7wt3bDQ3hLRDn2CZqTGImFUvvyMSTBzy51IIGS04=
X-Gm-Gg: ATEYQzxn9JZgtR2bcAW+6z3SNI3IrZlTQRTApORndPcyUksaeFOlBX0zHjHd3Dd9TYM
	Zd1jb+33WBe7DDGzHBRvBTlPmN5MJw+qMTI4XUWClQA1W7owdeVm884RnLpC6Gg9KT1UZx5Nd4I
	d8npWxCOyv6lAIQovPx6QxD3dP6BmzhW3Ia5FfV6M/TkrkMo1PUfTM/AZifWeCtFIJvKN6k1/12
	hQyHm/pDpslwoDdxk9gzI0o3pgDAXYlojf2lpJm+co4X3BpPcwgdwEoYOgrzYUEMApiWq1txcXc
	xaGTkr2KVJc39xwaqa9RRnSsa8E0xlRdZzi3GlQF6+3tQYPoBbPszvwqZTAcqbUhAWnHoNNl7We
	rizGLIfibqDshpnw7cZwJZI1Itai80lyDJh2ECplztdiJ2y1l47AqBRy7EQmPMs8mf8j3vFClzA
	dV7YVqySKuSJSpn7XewxYOF+rl6ySsJrNJ+SOxLF1rGhRNqe1ZCUrlAwgLU43kknpOslA=
X-Received: by 2002:a17:90b:3e50:b0:34a:b4a2:f0bf with SMTP id 98e67ed59e1d1-358ae8a5315mr17289805a91.16.1772106956626;
        Thu, 26 Feb 2026 03:55:56 -0800 (PST)
Received: from tianci-mac.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359130712bcsm2390815a91.7.2026.02.26.03.55.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Feb 2026 03:55:56 -0800 (PST)
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	marco.crivellari@suse.com,
	anders.roxell@linaro.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Zhang Tianci <zhangtianci.1997@bytedance.com>
Subject: [PATCH v4 0/2] vduse: Fix race in vduse_dev_msg_sync and vduse_dev_read_iter
Date: Thu, 26 Feb 2026 19:55:48 +0800
Message-ID: <20260226115550.1814-1-zhangtianci.1997@bytedance.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v4:
 - Simplify code.                                 [Jason]
 - Add comment for rolling back.                  [Jason]
 - Link to v3: https://lore.kernel.org/lkml/20260202072655.95143-1-zhangtianci.1997@bytedance.com/

Changes in v3:
 - Add first patch.
 - Link to v2: https://lore.kernel.org/lkml/20260202031212.26871-1-zhangtianci.1997@bytedance.com/

Changes in v2:
 - Rewrite commit message.                        [Michael]
 - Add Fixes tag and cc stable email list.        [Eugenio]
 - Rewrite one comment.                           [Michael]
 - Link to v1: https://lore.kernel.org/lkml/20260130081524.81271-1-zhangtianci.1997@bytedance.com/


Zhang Tianci (2):
  vduse: Requeue failed read to send_list head
  vduse: Fix race in vduse_dev_msg_sync and vduse_dev_read_iter

 drivers/vdpa/vdpa_user/vduse_dev.c | 43 +++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 10 deletions(-)

-- 
2.39.5

