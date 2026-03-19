Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BF839A7E9
	for <virtualization@lists.linux.dev>; Thu, 19 Mar 2026 08:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773907290; cv=none; b=W+yMR3fZV9tBOGsI4iI0xP65CXNmsB28oJiuwsV7mj8hIiFp1NjFt6TAEoRgVlr/IJFqcTLU9rV7Op5bp7mA+zbOoA3jBK9BJqrk6t4JMAh9myMXHKJh5IkeSDu6lwzEGdBuD7ZkpxXruRWzbTVA9TYnaB9yrIWiW9veikmXoMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773907290; c=relaxed/simple;
	bh=Z5XzVzZjSM8KYAVqS2gks8t042AVRybgtkb6BUkQIk0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fXiME4nHfINkUiSpqU47orMBDk7VG5P+dWpKfIx0BrLx2HmpRLzyPO372xyQT9YYn6M7zqNhCeOR1jIUebCiVoZDVzGrUTXQL9SfORkm4E333L0ZRvFUrHP9JzX1SbOLzc6VBmsWsVnYxuHxoOJ7xynckz1WDQ+7DMR6YwdmubA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=xCr85/J2; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="xCr85/J2"
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 5C84F808CB;
	Thu, 19 Mar 2026 11:01:23 +0300 (MSK)
Received: from kniv-nix.yandex-team.ru (unknown [2a02:6bf:8080:4b::1:26])
	by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id q0JiSw1AZqM0-jT7pE6cZ;
	Thu, 19 Mar 2026 11:01:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1773907282;
	bh=fCQ+qU35pEQq1W3N0/JCh6dWJijS1YVgrLWBHzC2aag=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=xCr85/J2LC2iaAF5kmuY9eN3SEbZpC4hz6VPWg/H1bXTqlNY50uauhwSFPtoOzuOG
	 qIpGSYKZKMAzVyRYybtM/BRR64ASk4ZrWbeH5PF1T4JjuYBHvfIG8aIgk30HCuzMvD
	 Am8lkbESG2fhvnxsNeWcSmmw8H1Cp5kw5BzYPrdQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Nikolay Kuratov <kniv@yandex-team.ru>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH] vhost: Bump max_mem_regions default to 256
Date: Thu, 19 Mar 2026 11:00:52 +0300
Message-Id: <20260319080052.1942514-1-kniv@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Today, vfio mappings for a single GPU (BAR 0) may consume more than 30
umem entries (e.g. configured by qemu with vhost-net), so bump default to
allow running with a few GPUs without module parameter adjustment - it
is harmless, since umem rarely used and iotlb already have larger limit.

Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
---
 drivers/vhost/vhost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 2f2c45d20883..3ac2ba272716 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -34,10 +34,10 @@
 
 #include "vhost.h"
 
-static ushort max_mem_regions = 64;
+static ushort max_mem_regions = 256;
 module_param(max_mem_regions, ushort, 0444);
 MODULE_PARM_DESC(max_mem_regions,
-	"Maximum number of memory regions in memory map. (default: 64)");
+	"Maximum number of memory regions in memory map. (default: 256)");
 static int max_iotlb_entries = 2048;
 module_param(max_iotlb_entries, int, 0444);
 MODULE_PARM_DESC(max_iotlb_entries,
-- 
2.34.1

