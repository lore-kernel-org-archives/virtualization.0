Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A892FC71153
	for <virtualization@archiver.kernel.org>; Tue, 29 Aug 2023 13:32:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 281EE41749;
	Tue, 29 Aug 2023 13:32:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 281EE41749
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OTplIusP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jzg9UfZ8kjrZ; Tue, 29 Aug 2023 13:32:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5438940998;
	Tue, 29 Aug 2023 13:32:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5438940998
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3729AC0039;
	Tue, 29 Aug 2023 13:32:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4349C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 13:32:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9A16360742
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 13:32:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9A16360742
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=OTplIusP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SZtJpn3NGYoj
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 13:32:26 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C2E0A60803
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 13:32:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C2E0A60803
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EC88165707;
 Tue, 29 Aug 2023 13:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B955C433D9;
 Tue, 29 Aug 2023 13:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693315945;
 bh=zAfL9VjGXc4IzETDr4PebRkgD3HymZWi4GCYoJtKNN8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OTplIusPkKX/Xd3Kp/aWvedEOubGHPgRlgVDJ/EUTndEVWBiouUR1Wynl90UmiSZC
 UfigdUCVH6Zr/kRkQdR9r0yCpuaLL56AzSA9nDedAHBmLdtjld8szkyjBsRfHPw95J
 nCz31Slbc2nfNSnx4CIuO03oo/5EwiaZi4F2W7EuaxnveAaUKWmJWRnKVua3MryAVx
 wbZi1/SyZXQsX8QVtEjbqUIMeeuCcf6hRPR0KJfL6T1yy2K9Ra1wHurz9n1F8gVBBI
 FPIVTwMWMq8zOr/pK4ra/TGJ9+NkfUYqa3VLO6F1HFzh9wxhJ5DLJg1JtkjVTQcnIs
 lrJmOaa/3Dq0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 06/17] virtio-mem: remove unsafe unplug in Big
 Block Mode (BBM)
Date: Tue, 29 Aug 2023 09:31:53 -0400
Message-Id: <20230829133211.519957-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230829133211.519957-1-sashal@kernel.org>
References: <20230829133211.519957-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.12
Cc: Sasha Levin <sashal@kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

From: David Hildenbrand <david@redhat.com>

[ Upstream commit f504e15b94eb4e5b47f8715da59c0207f68dffe1 ]

When "unsafe unplug" is enabled, we don't fake-offline all memory ahead of
actual memory offlining using alloc_contig_range(). Instead, we rely on
offline_pages() to also perform actual page migration, which might fail
or take a very long time.

In that case, it's possible to easily run into endless loops that cannot be
aborted anymore (as offlining is triggered by a workqueue then): For
example, a single (accidentally) permanently unmovable page in
ZONE_MOVABLE results in an endless loop. For ZONE_NORMAL, races between
isolating the pageblock (and checking for unmovable pages) and
concurrent page allocation are possible and similarly result in endless
loops.

The idea of the unsafe unplug mode was to make it possible to more
reliably unplug large memory blocks. However, (a) we really should be
tackling that differently, by extending the alloc_contig_range()-based
mechanism; and (b) this mode is not the default and as far as I know,
it's unused either way.

So let's simply get rid of it.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20230713145551.2824980-2-david@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_mem.c | 51 +++++++++++++++----------------------
 1 file changed, 20 insertions(+), 31 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 835f6cc2fb664..ed15d2a4bd96b 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -38,11 +38,6 @@ module_param(bbm_block_size, ulong, 0444);
 MODULE_PARM_DESC(bbm_block_size,
 		 "Big Block size in bytes. Default is 0 (auto-detection).");
 
-static bool bbm_safe_unplug = true;
-module_param(bbm_safe_unplug, bool, 0444);
-MODULE_PARM_DESC(bbm_safe_unplug,
-	     "Use a safe unplug mechanism in BBM, avoiding long/endless loops");
-
 /*
  * virtio-mem currently supports the following modes of operation:
  *
@@ -2111,38 +2106,32 @@ static int virtio_mem_bbm_offline_remove_and_unplug_bb(struct virtio_mem *vm,
 			 VIRTIO_MEM_BBM_BB_ADDED))
 		return -EINVAL;
 
-	if (bbm_safe_unplug) {
-		/*
-		 * Start by fake-offlining all memory. Once we marked the device
-		 * block as fake-offline, all newly onlined memory will
-		 * automatically be kept fake-offline. Protect from concurrent
-		 * onlining/offlining until we have a consistent state.
-		 */
-		mutex_lock(&vm->hotplug_mutex);
-		virtio_mem_bbm_set_bb_state(vm, bb_id,
-					    VIRTIO_MEM_BBM_BB_FAKE_OFFLINE);
+	/*
+	 * Start by fake-offlining all memory. Once we marked the device
+	 * block as fake-offline, all newly onlined memory will
+	 * automatically be kept fake-offline. Protect from concurrent
+	 * onlining/offlining until we have a consistent state.
+	 */
+	mutex_lock(&vm->hotplug_mutex);
+	virtio_mem_bbm_set_bb_state(vm, bb_id, VIRTIO_MEM_BBM_BB_FAKE_OFFLINE);
 
-		for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
-			page = pfn_to_online_page(pfn);
-			if (!page)
-				continue;
+	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
+		page = pfn_to_online_page(pfn);
+		if (!page)
+			continue;
 
-			rc = virtio_mem_fake_offline(pfn, PAGES_PER_SECTION);
-			if (rc) {
-				end_pfn = pfn;
-				goto rollback_safe_unplug;
-			}
+		rc = virtio_mem_fake_offline(pfn, PAGES_PER_SECTION);
+		if (rc) {
+			end_pfn = pfn;
+			goto rollback;
 		}
-		mutex_unlock(&vm->hotplug_mutex);
 	}
+	mutex_unlock(&vm->hotplug_mutex);
 
 	rc = virtio_mem_bbm_offline_and_remove_bb(vm, bb_id);
 	if (rc) {
-		if (bbm_safe_unplug) {
-			mutex_lock(&vm->hotplug_mutex);
-			goto rollback_safe_unplug;
-		}
-		return rc;
+		mutex_lock(&vm->hotplug_mutex);
+		goto rollback;
 	}
 
 	rc = virtio_mem_bbm_unplug_bb(vm, bb_id);
@@ -2154,7 +2143,7 @@ static int virtio_mem_bbm_offline_remove_and_unplug_bb(struct virtio_mem *vm,
 					    VIRTIO_MEM_BBM_BB_UNUSED);
 	return rc;
 
-rollback_safe_unplug:
+rollback:
 	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
 		page = pfn_to_online_page(pfn);
 		if (!page)
-- 
2.40.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
