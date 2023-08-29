Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50775C83F12
	for <virtualization@archiver.kernel.org>; Tue, 29 Aug 2023 13:32:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6EDC64114E;
	Tue, 29 Aug 2023 13:32:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6EDC64114E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=simEZLPu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ToyNB_1PESPq; Tue, 29 Aug 2023 13:32:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D48D641145;
	Tue, 29 Aug 2023 13:32:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D48D641145
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16673C0DD6;
	Tue, 29 Aug 2023 13:32:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83293C0039
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 13:32:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 494FC81FE0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 13:32:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 494FC81FE0
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=simEZLPu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ojhA59eK3gCA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 13:32:30 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8159D81FAC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 13:32:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8159D81FAC
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id BE7FD6574A;
 Tue, 29 Aug 2023 13:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FBFC433C8;
 Tue, 29 Aug 2023 13:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693315949;
 bh=ms2FDB3jNM4pkoafxxmkuXKTvTc4QVtI/Rqaf/6iA4c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=simEZLPuHoHZ4yF/ICZzdb4EzgcHdS/VroLHjdtVDsDR6RN3uIXNJNvs32ObFWzFA
 KEZI9lS9T4MgPgsYxBHU6kCCcGcjKH3D2t7uTi0okdrHiT1b3a81WrkyRKKObrmkbB
 1iJNEB9Xhbyp7aAIqWhm63Yg2h+82LjQyhbN+T4cL1joj1P9hinn1i6qR2vAKGzwGA
 wIW2p7oL52bj8J444rHa61qgtHmRRrpxCIdZoYMmooBqCgnM/aCTnOwC3qv4Z5Gm8z
 j4CWwcXuM3u96Y18hPXKNEE//5e8e0rtyzzve2uDZclJ8XpYxIiRZUb+BnaI0bmhH0
 q9c0JBZsweSNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 09/17] virtio-mem: check if the config changed
 before fake offlining memory
Date: Tue, 29 Aug 2023 09:31:56 -0400
Message-Id: <20230829133211.519957-9-sashal@kernel.org>
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

[ Upstream commit f55484fd7be923b740e8e1fc304070ba53675cb4 ]

If we repeatedly fail to fake offline memory to unplug it, we won't be
sending any unplug requests to the device. However, we only check if the
config changed when sending such (un)plug requests.

We could end up trying for a long time to unplug memory, even though
the config changed already and we're not supposed to unplug memory
anymore. For example, the hypervisor might detect a low-memory situation
while unplugging memory and decide to replug some memory. Continuing
trying to unplug memory in that case can be problematic.

So let's check on a more regular basis.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20230713145551.2824980-5-david@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_mem.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index a5cf92e3e5af2..fa5226c198cc6 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1189,7 +1189,8 @@ static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pages)
  * Try to allocate a range, marking pages fake-offline, effectively
  * fake-offlining them.
  */
-static int virtio_mem_fake_offline(unsigned long pfn, unsigned long nr_pages)
+static int virtio_mem_fake_offline(struct virtio_mem *vm, unsigned long pfn,
+				   unsigned long nr_pages)
 {
 	const bool is_movable = is_zone_movable_page(pfn_to_page(pfn));
 	int rc, retry_count;
@@ -1202,6 +1203,14 @@ static int virtio_mem_fake_offline(unsigned long pfn, unsigned long nr_pages)
 	 * some guarantees.
 	 */
 	for (retry_count = 0; retry_count < 5; retry_count++) {
+		/*
+		 * If the config changed, stop immediately and go back to the
+		 * main loop: avoid trying to keep unplugging if the device
+		 * might have decided to not remove any more memory.
+		 */
+		if (atomic_read(&vm->config_changed))
+			return -EAGAIN;
+
 		rc = alloc_contig_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE,
 					GFP_KERNEL);
 		if (rc == -ENOMEM)
@@ -1951,7 +1960,7 @@ static int virtio_mem_sbm_unplug_sb_online(struct virtio_mem *vm,
 	start_pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
 			     sb_id * vm->sbm.sb_size);
 
-	rc = virtio_mem_fake_offline(start_pfn, nr_pages);
+	rc = virtio_mem_fake_offline(vm, start_pfn, nr_pages);
 	if (rc)
 		return rc;
 
@@ -2149,7 +2158,7 @@ static int virtio_mem_bbm_offline_remove_and_unplug_bb(struct virtio_mem *vm,
 		if (!page)
 			continue;
 
-		rc = virtio_mem_fake_offline(pfn, PAGES_PER_SECTION);
+		rc = virtio_mem_fake_offline(vm, pfn, PAGES_PER_SECTION);
 		if (rc) {
 			end_pfn = pfn;
 			goto rollback;
-- 
2.40.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
