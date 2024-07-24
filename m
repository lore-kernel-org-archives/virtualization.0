Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B1778C60
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 07:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721807063; cv=none; b=ply7e7qZj1QBFlSTGrXZWylHf/qUhtWJ/N6Y9O5uDIltv6XHFHcGrT0emhYJcMrZJnC19FxL+TDp8DptWPS77via1zLkB1W3njV7XTkXVuKMuxp9MBQj2ZaMY/gp8Ye3q0taKTlJNh4HOBUlHoFqBQKB2xRMqSAZ/oEJAmusH/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721807063; c=relaxed/simple;
	bh=hE8ktlpj2I0sEfyauUuSarz3WiB52KyQR97yUyk6ygU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=EYatEuGMERyJumWh3woKRusNtIH3AM5+pN6LK06Bw6nFgVWEYtZyrTEuvvZDuJofOD/v8IoJ21mh8NkO+ehUz6e6GubMptzSKHaQNzVqmrcwQjwCJmnhL6yfzRtTlqCsbr9I/V/78w0M3beR/AnvLW7iXW1O9GXFgUJLJeEClac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee266a0b015bda-cdbde;
	Wed, 24 Jul 2024 15:41:10 +0800 (CST)
X-RM-TRANSID:2ee266a0b015bda-cdbde
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[223.108.79.96])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee866a0b01526c-9c7a5;
	Wed, 24 Jul 2024 15:41:10 +0800 (CST)
X-RM-TRANSID:2ee866a0b01526c-9c7a5
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	zhujun2@cmss.chinamobile.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/virtio:Fix the wrong format specifier
Date: Wed, 24 Jul 2024 00:41:08 -0700
Message-Id: <20240724074108.9530-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The unsigned int should use "%u" instead of "%d".

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/virtio/ringtest/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/ringtest/main.c b/tools/virtio/ringtest/main.c
index 5a18b2301a63..e471d8e7cfaa 100644
--- a/tools/virtio/ringtest/main.c
+++ b/tools/virtio/ringtest/main.c
@@ -276,7 +276,7 @@ static void help(void)
 	fprintf(stderr, "Usage: <test> [--help]"
 		" [--host-affinity H]"
 		" [--guest-affinity G]"
-		" [--ring-size R (default: %d)]"
+		" [--ring-size R (default: %u)]"
 		" [--run-cycles C (default: %d)]"
 		" [--batch b]"
 		" [--outstanding o]"
-- 
2.17.1



