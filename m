Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09709C433F5
	for <virtualization@archiver.kernel.org>; Thu,  7 Apr 2022 01:12:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C0964197A;
	Thu,  7 Apr 2022 01:12:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kze4BsCjmlr8; Thu,  7 Apr 2022 01:12:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1659B4188D;
	Thu,  7 Apr 2022 01:12:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1F54C002C;
	Thu,  7 Apr 2022 01:12:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08F3AC0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 01:12:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DCBD541979
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 01:12:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DC2HZ-c3UvCu
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 01:12:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 08C2341978
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 01:12:27 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 5BD65B82692;
 Thu,  7 Apr 2022 01:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468EAC385A1;
 Thu,  7 Apr 2022 01:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649293945;
 bh=ssJYHvkpscxFMbUpBVyB4ceTVTGzImrTC1CGpjG5HWs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=i1zTnDqj2rRwhVuK/M+swJq1kukpQkYg7FT8LBZp7lSvdBoGcH+QdPztyg/2Z5aTC
 N2QNb4ZpAuBJIIhqW4+rKDEbO1BAROI9EMJXhPukP4Gq9oSxdGkHZWanSWaTzAc8db
 len+RJgLrveZd59CAR6zW0o9FnII2FSfUgQfgBdAEXi19j1cw6XnN71jj+xbAS8bqj
 r90Te+qKceckxJ1elFu0xSty+PQjAOQ3U6XMoPF43EoKYf8EudjuloQ4Brx+BvAK4U
 JyjMfdLSCIxeEX3VDyXwIMw3eJ5XvkQvt+rd5lE8Y3p/rATZw25MR9350R9qy5ZG9n
 0auxtyrm7XHCw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.16 20/30] tools/virtio: compile with -pthread
Date: Wed,  6 Apr 2022 21:11:30 -0400
Message-Id: <20220407011140.113856-20-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407011140.113856-1-sashal@kernel.org>
References: <20220407011140.113856-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, virtualization@lists.linux-foundation.org,
 Matthew Wilcox <willy@infradead.org>, "Michael S. Tsirkin" <mst@redhat.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: "Michael S. Tsirkin" <mst@redhat.com>

[ Upstream commit f03560a57c1f60db6ac23ffd9714e1c69e2f95c7 ]

When using pthreads, one has to compile and link with -lpthread,
otherwise e.g. glibc is not guaranteed to be reentrant.

This replaces -lpthread.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/virtio/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
index 0d7bbe49359d..1b25cc7c64bb 100644
--- a/tools/virtio/Makefile
+++ b/tools/virtio/Makefile
@@ -5,7 +5,8 @@ virtio_test: virtio_ring.o virtio_test.o
 vringh_test: vringh_test.o vringh.o virtio_ring.o
 
 CFLAGS += -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h
-LDFLAGS += -lpthread
+CFLAGS += -pthread
+LDFLAGS += -pthread
 vpath %.c ../../drivers/virtio ../../drivers/vhost
 mod:
 	${MAKE} -C `pwd`/../.. M=`pwd`/vhost_test V=${V}
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
