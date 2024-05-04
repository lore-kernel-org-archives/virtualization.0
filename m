Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69F711711;
	Sat,  4 May 2024 17:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714844857; cv=none; b=tjmtFZnnlL2loaqQpSMVAQEfg8Bb1scM5RIvU/68qr/0jMmsd9HcwximMsaIvxhBceyKtCk2eq1bd7NT+RV5mitVJ6ygPBZoDgKqqLrzK/7mlbemJCpDsb9Ke+hQRT0SBFuzxaZ985flF+JbvPDuDbWK8Z47hQpVI2d9D8WxNsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714844857; c=relaxed/simple;
	bh=IHtIP0EtQDR9fOyci5/lR8nXQDYsn8u0YXQIcC1Fg1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eazVD6iXd8t5ztueKd190EXV5qHe+t7ocj97HzCjn5ZjglcS3VfWdZ2V8anmR0GbsSm5QjbPpsVQWH1L5eBHZsooOWkx2adUduAqz4niOxJ5sCTfIvsFfGah87moMcc0tRdW8qoE7gKrG5uFtmu0s1iOYIPWpP8scFMmawxVylM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=c1NsdjR/; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="c1NsdjR/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=bXSMtJDvtSCeDVCr5+vqoHO/GdfeLIzdEmzTM6URT2c=; b=c1NsdjR/tJTENPqZ
	Jkeu1MwZ7pumLejjy9b6wEccx8YL9K4QTPCciyrL0CB8lDZH+9Sln5hbZ/ZEXTP1K4Pe2OTcbvfiu
	Jfgpn/86cJgwS9eWatpnSX5OdjIKxQNuPKs0BmeN0UAM9d8TiCxv1+7JUxtNCV2GhmRrBu8hWWNnQ
	5XYLl3nA9sRv8ByfgsFa8LXNDpqR7Pm2JtMagap+WJYYKIQBZOgLuax09TmzIuOeiHVQcyJwf/Aqi
	uFRQPrfy8AnV1Z3Tw/VXX7V0PMzk4TK1tgiErSJlRDXRbE3XJUzbWlTwkrTxkUGaNPMxHVHGbpUfH
	YnaVD5JzGjWhsD7YwA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s3JTv-004iPA-2H;
	Sat, 04 May 2024 17:47:31 +0000
From: linux@treblig.org
To: fei1.li@intel.com
Cc: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] virt: acrn: Remove unusted list 'acrn_irqfd_clients'
Date: Sat,  4 May 2024 18:47:25 +0100
Message-ID: <20240504174725.93495-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

It doesn't look like this was ever used.

Build tested only.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/virt/acrn/irqfd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/virt/acrn/irqfd.c b/drivers/virt/acrn/irqfd.c
index d4ad211dce7a3..346cf0be4aac7 100644
--- a/drivers/virt/acrn/irqfd.c
+++ b/drivers/virt/acrn/irqfd.c
@@ -16,8 +16,6 @@
 
 #include "acrn_drv.h"
 
-static LIST_HEAD(acrn_irqfd_clients);
-
 /**
  * struct hsm_irqfd - Properties of HSM irqfd
  * @vm:		Associated VM pointer
-- 
2.45.0

