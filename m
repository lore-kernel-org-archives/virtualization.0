Return-Path: <SRS0=8i8N=ES=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43810C63699
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 13:39:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4A1022240
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 13:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HIo9IRO1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A1022240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6DCCF870D1;
	Thu, 12 Nov 2020 13:39:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ArtxqTRJLtgw; Thu, 12 Nov 2020 13:39:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2C8B3870E3;
	Thu, 12 Nov 2020 13:39:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13A59C1AD9;
	Thu, 12 Nov 2020 13:39:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 473C3C016F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:39:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3658E870D2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:39:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3EsadzyRw4Hv
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:39:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 33059870D1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605188373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V2NODLmfKck3SLsreXaoheI8rMneNnPIAE0lDKunWnA=;
 b=HIo9IRO1FTsc0rSHHms3Q/fBmCUDYcOQcOVKRdXgpQCg4snqevtLtH3EH3sYCqBMQmUrKj
 8dS3/vU/dNqdBZvtqCw+7pE8DWodTmPzKWa8cW0TQO3oc0O7eIHJlqM7pRFH5Zr17RXj5D
 JIBybjlJsCwN+0PwEoNbRGAg8EsXh7I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-737oRQ5aPJ63a5bZX9zV0w-1; Thu, 12 Nov 2020 08:39:31 -0500
X-MC-Unique: 737oRQ5aPJ63a5bZX9zV0w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DA9E801FDE;
 Thu, 12 Nov 2020 13:39:30 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-61.ams2.redhat.com [10.36.115.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5EB1A75132;
 Thu, 12 Nov 2020 13:39:28 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/29] virito-mem: existing (un)plug functions are specific
 to Sub Block Mode (SBM)
Date: Thu, 12 Nov 2020 14:38:08 +0100
Message-Id: <20201112133815.13332-23-david@redhat.com>
In-Reply-To: <20201112133815.13332-1-david@redhat.com>
References: <20201112133815.13332-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Wei Yang <richard.weiyang@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org
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

Let's rename them accordingly. virtio_mem_plug_request() and
virtio_mem_unplug_request() will be handled separately.

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 90 ++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 47 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 248d28e653a9..ec81f9d4bccf 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1099,8 +1099,8 @@ static int virtio_mem_send_unplug_all_request(struct virtio_mem *vm)
  * Plug selected subblocks. Updates the plugged state, but not the state
  * of the memory block.
  */
-static int virtio_mem_mb_plug_sb(struct virtio_mem *vm, unsigned long mb_id,
-				 int sb_id, int count)
+static int virtio_mem_sbm_plug_sb(struct virtio_mem *vm, unsigned long mb_id,
+				  int sb_id, int count)
 {
 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id) +
 			      sb_id * vm->sbm.sb_size;
@@ -1117,8 +1117,8 @@ static int virtio_mem_mb_plug_sb(struct virtio_mem *vm, unsigned long mb_id,
  * Unplug selected subblocks. Updates the plugged state, but not the state
  * of the memory block.
  */
-static int virtio_mem_mb_unplug_sb(struct virtio_mem *vm, unsigned long mb_id,
-				   int sb_id, int count)
+static int virtio_mem_sbm_unplug_sb(struct virtio_mem *vm, unsigned long mb_id,
+				    int sb_id, int count)
 {
 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id) +
 			      sb_id * vm->sbm.sb_size;
@@ -1140,8 +1140,8 @@ static int virtio_mem_mb_unplug_sb(struct virtio_mem *vm, unsigned long mb_id,
  *
  * Note: can fail after some subblocks were unplugged.
  */
-static int virtio_mem_mb_unplug_any_sb(struct virtio_mem *vm,
-				       unsigned long mb_id, uint64_t *nb_sb)
+static int virtio_mem_sbm_unplug_any_sb(struct virtio_mem *vm,
+					unsigned long mb_id, uint64_t *nb_sb)
 {
 	int sb_id, count;
 	int rc;
@@ -1162,7 +1162,7 @@ static int virtio_mem_mb_unplug_any_sb(struct virtio_mem *vm,
 			sb_id--;
 		}
 
-		rc = virtio_mem_mb_unplug_sb(vm, mb_id, sb_id, count);
+		rc = virtio_mem_sbm_unplug_sb(vm, mb_id, sb_id, count);
 		if (rc)
 			return rc;
 		*nb_sb -= count;
@@ -1179,18 +1179,18 @@ static int virtio_mem_mb_unplug_any_sb(struct virtio_mem *vm,
  *
  * Note: can fail after some subblocks were unplugged.
  */
-static int virtio_mem_mb_unplug(struct virtio_mem *vm, unsigned long mb_id)
+static int virtio_mem_sbm_unplug_mb(struct virtio_mem *vm, unsigned long mb_id)
 {
 	uint64_t nb_sb = vm->sbm.sbs_per_mb;
 
-	return virtio_mem_mb_unplug_any_sb(vm, mb_id, &nb_sb);
+	return virtio_mem_sbm_unplug_any_sb(vm, mb_id, &nb_sb);
 }
 
 /*
  * Prepare tracking data for the next memory block.
  */
-static int virtio_mem_prepare_next_mb(struct virtio_mem *vm,
-				      unsigned long *mb_id)
+static int virtio_mem_sbm_prepare_next_mb(struct virtio_mem *vm,
+					  unsigned long *mb_id)
 {
 	int rc;
 
@@ -1218,9 +1218,8 @@ static int virtio_mem_prepare_next_mb(struct virtio_mem *vm,
  *
  * Will modify the state of the memory block.
  */
-static int virtio_mem_mb_plug_and_add(struct virtio_mem *vm,
-				      unsigned long mb_id,
-				      uint64_t *nb_sb)
+static int virtio_mem_sbm_plug_and_add_mb(struct virtio_mem *vm,
+					  unsigned long mb_id, uint64_t *nb_sb)
 {
 	const int count = min_t(int, *nb_sb, vm->sbm.sbs_per_mb);
 	int rc;
@@ -1232,7 +1231,7 @@ static int virtio_mem_mb_plug_and_add(struct virtio_mem *vm,
 	 * Plug the requested number of subblocks before adding it to linux,
 	 * so that onlining will directly online all plugged subblocks.
 	 */
-	rc = virtio_mem_mb_plug_sb(vm, mb_id, 0, count);
+	rc = virtio_mem_sbm_plug_sb(vm, mb_id, 0, count);
 	if (rc)
 		return rc;
 
@@ -1259,7 +1258,7 @@ static int virtio_mem_mb_plug_and_add(struct virtio_mem *vm,
 		 * TODO: Linux MM does not properly clean up yet in all cases
 		 * where adding of memory failed - especially on -ENOMEM.
 		 */
-		if (virtio_mem_mb_unplug_sb(vm, mb_id, 0, count))
+		if (virtio_mem_sbm_unplug_sb(vm, mb_id, 0, count))
 			new_state = VIRTIO_MEM_SBM_MB_PLUGGED;
 		virtio_mem_sbm_set_mb_state(vm, mb_id, new_state);
 		return rc;
@@ -1277,8 +1276,9 @@ static int virtio_mem_mb_plug_and_add(struct virtio_mem *vm,
  *
  * Note: Can fail after some subblocks were successfully plugged.
  */
-static int virtio_mem_mb_plug_any_sb(struct virtio_mem *vm, unsigned long mb_id,
-				     uint64_t *nb_sb, bool online)
+static int virtio_mem_sbm_plug_any_sb(struct virtio_mem *vm,
+				      unsigned long mb_id, uint64_t *nb_sb,
+				      bool online)
 {
 	unsigned long pfn, nr_pages;
 	int sb_id, count;
@@ -1297,7 +1297,7 @@ static int virtio_mem_mb_plug_any_sb(struct virtio_mem *vm, unsigned long mb_id,
 		       !virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id + count, 1))
 			count++;
 
-		rc = virtio_mem_mb_plug_sb(vm, mb_id, sb_id, count);
+		rc = virtio_mem_sbm_plug_sb(vm, mb_id, sb_id, count);
 		if (rc)
 			return rc;
 		*nb_sb -= count;
@@ -1341,7 +1341,7 @@ static int virtio_mem_plug_request(struct virtio_mem *vm, uint64_t diff)
 	/* Try to plug subblocks of partially plugged online blocks. */
 	virtio_mem_sbm_for_each_mb(vm, mb_id,
 				   VIRTIO_MEM_SBM_MB_ONLINE_PARTIAL) {
-		rc = virtio_mem_mb_plug_any_sb(vm, mb_id, &nb_sb, true);
+		rc = virtio_mem_sbm_plug_any_sb(vm, mb_id, &nb_sb, true);
 		if (rc || !nb_sb)
 			goto out_unlock;
 		cond_resched();
@@ -1350,7 +1350,7 @@ static int virtio_mem_plug_request(struct virtio_mem *vm, uint64_t diff)
 	/* Try to plug subblocks of partially plugged offline blocks. */
 	virtio_mem_sbm_for_each_mb(vm, mb_id,
 				   VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL) {
-		rc = virtio_mem_mb_plug_any_sb(vm, mb_id, &nb_sb, false);
+		rc = virtio_mem_sbm_plug_any_sb(vm, mb_id, &nb_sb, false);
 		if (rc || !nb_sb)
 			goto out_unlock;
 		cond_resched();
@@ -1367,7 +1367,7 @@ static int virtio_mem_plug_request(struct virtio_mem *vm, uint64_t diff)
 		if (!virtio_mem_could_add_memory(vm, memory_block_size_bytes()))
 			return -ENOSPC;
 
-		rc = virtio_mem_mb_plug_and_add(vm, mb_id, &nb_sb);
+		rc = virtio_mem_sbm_plug_and_add_mb(vm, mb_id, &nb_sb);
 		if (rc || !nb_sb)
 			return rc;
 		cond_resched();
@@ -1378,10 +1378,10 @@ static int virtio_mem_plug_request(struct virtio_mem *vm, uint64_t diff)
 		if (!virtio_mem_could_add_memory(vm, memory_block_size_bytes()))
 			return -ENOSPC;
 
-		rc = virtio_mem_prepare_next_mb(vm, &mb_id);
+		rc = virtio_mem_sbm_prepare_next_mb(vm, &mb_id);
 		if (rc)
 			return rc;
-		rc = virtio_mem_mb_plug_and_add(vm, mb_id, &nb_sb);
+		rc = virtio_mem_sbm_plug_and_add_mb(vm, mb_id, &nb_sb);
 		if (rc)
 			return rc;
 		cond_resched();
@@ -1402,13 +1402,13 @@ static int virtio_mem_plug_request(struct virtio_mem *vm, uint64_t diff)
  *
  * Note: Can fail after some subblocks were successfully unplugged.
  */
-static int virtio_mem_mb_unplug_any_sb_offline(struct virtio_mem *vm,
-					       unsigned long mb_id,
-					       uint64_t *nb_sb)
+static int virtio_mem_sbm_unplug_any_sb_offline(struct virtio_mem *vm,
+						unsigned long mb_id,
+						uint64_t *nb_sb)
 {
 	int rc;
 
-	rc = virtio_mem_mb_unplug_any_sb(vm, mb_id, nb_sb);
+	rc = virtio_mem_sbm_unplug_any_sb(vm, mb_id, nb_sb);
 
 	/* some subblocks might have been unplugged even on failure */
 	if (!virtio_mem_sbm_test_sb_plugged(vm, mb_id, 0, vm->sbm.sbs_per_mb))
@@ -1440,9 +1440,9 @@ static int virtio_mem_mb_unplug_any_sb_offline(struct virtio_mem *vm,
  *
  * Will modify the state of the memory block.
  */
-static int virtio_mem_mb_unplug_sb_online(struct virtio_mem *vm,
-					  unsigned long mb_id, int sb_id,
-					  int count)
+static int virtio_mem_sbm_unplug_sb_online(struct virtio_mem *vm,
+					   unsigned long mb_id, int sb_id,
+					   int count)
 {
 	const unsigned long nr_pages = PFN_DOWN(vm->sbm.sb_size) * count;
 	unsigned long start_pfn;
@@ -1456,7 +1456,7 @@ static int virtio_mem_mb_unplug_sb_online(struct virtio_mem *vm,
 		return rc;
 
 	/* Try to unplug the allocated memory */
-	rc = virtio_mem_mb_unplug_sb(vm, mb_id, sb_id, count);
+	rc = virtio_mem_sbm_unplug_sb(vm, mb_id, sb_id, count);
 	if (rc) {
 		/* Return the memory to the buddy. */
 		virtio_mem_fake_online(start_pfn, nr_pages);
@@ -1478,17 +1478,17 @@ static int virtio_mem_mb_unplug_sb_online(struct virtio_mem *vm,
  * Note: Can fail after some subblocks were successfully unplugged. Can
  *       return 0 even if subblocks were busy and could not get unplugged.
  */
-static int virtio_mem_mb_unplug_any_sb_online(struct virtio_mem *vm,
-					      unsigned long mb_id,
-					      uint64_t *nb_sb)
+static int virtio_mem_sbm_unplug_any_sb_online(struct virtio_mem *vm,
+					       unsigned long mb_id,
+					       uint64_t *nb_sb)
 {
 	int rc, sb_id;
 
 	/* If possible, try to unplug the complete block in one shot. */
 	if (*nb_sb >= vm->sbm.sbs_per_mb &&
 	    virtio_mem_sbm_test_sb_plugged(vm, mb_id, 0, vm->sbm.sbs_per_mb)) {
-		rc = virtio_mem_mb_unplug_sb_online(vm, mb_id, 0,
-						    vm->sbm.sbs_per_mb);
+		rc = virtio_mem_sbm_unplug_sb_online(vm, mb_id, 0,
+						     vm->sbm.sbs_per_mb);
 		if (!rc) {
 			*nb_sb -= vm->sbm.sbs_per_mb;
 			goto unplugged;
@@ -1505,7 +1505,7 @@ static int virtio_mem_mb_unplug_any_sb_online(struct virtio_mem *vm,
 		if (sb_id < 0)
 			break;
 
-		rc = virtio_mem_mb_unplug_sb_online(vm, mb_id, sb_id, 1);
+		rc = virtio_mem_sbm_unplug_sb_online(vm, mb_id, sb_id, 1);
 		if (rc == -EBUSY)
 			continue;
 		else if (rc)
@@ -1553,8 +1553,7 @@ static int virtio_mem_unplug_request(struct virtio_mem *vm, uint64_t diff)
 	/* Try to unplug subblocks of partially plugged offline blocks. */
 	virtio_mem_sbm_for_each_mb_rev(vm, mb_id,
 				       VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL) {
-		rc = virtio_mem_mb_unplug_any_sb_offline(vm, mb_id,
-							 &nb_sb);
+		rc = virtio_mem_sbm_unplug_any_sb_offline(vm, mb_id, &nb_sb);
 		if (rc || !nb_sb)
 			goto out_unlock;
 		cond_resched();
@@ -1562,8 +1561,7 @@ static int virtio_mem_unplug_request(struct virtio_mem *vm, uint64_t diff)
 
 	/* Try to unplug subblocks of plugged offline blocks. */
 	virtio_mem_sbm_for_each_mb_rev(vm, mb_id, VIRTIO_MEM_SBM_MB_OFFLINE) {
-		rc = virtio_mem_mb_unplug_any_sb_offline(vm, mb_id,
-							 &nb_sb);
+		rc = virtio_mem_sbm_unplug_any_sb_offline(vm, mb_id, &nb_sb);
 		if (rc || !nb_sb)
 			goto out_unlock;
 		cond_resched();
@@ -1577,8 +1575,7 @@ static int virtio_mem_unplug_request(struct virtio_mem *vm, uint64_t diff)
 	/* Try to unplug subblocks of partially plugged online blocks. */
 	virtio_mem_sbm_for_each_mb_rev(vm, mb_id,
 				       VIRTIO_MEM_SBM_MB_ONLINE_PARTIAL) {
-		rc = virtio_mem_mb_unplug_any_sb_online(vm, mb_id,
-							&nb_sb);
+		rc = virtio_mem_sbm_unplug_any_sb_online(vm, mb_id, &nb_sb);
 		if (rc || !nb_sb)
 			goto out_unlock;
 		mutex_unlock(&vm->hotplug_mutex);
@@ -1588,8 +1585,7 @@ static int virtio_mem_unplug_request(struct virtio_mem *vm, uint64_t diff)
 
 	/* Try to unplug subblocks of plugged online blocks. */
 	virtio_mem_sbm_for_each_mb_rev(vm, mb_id, VIRTIO_MEM_SBM_MB_ONLINE) {
-		rc = virtio_mem_mb_unplug_any_sb_online(vm, mb_id,
-							&nb_sb);
+		rc = virtio_mem_sbm_unplug_any_sb_online(vm, mb_id, &nb_sb);
 		if (rc || !nb_sb)
 			goto out_unlock;
 		mutex_unlock(&vm->hotplug_mutex);
@@ -1614,7 +1610,7 @@ static int virtio_mem_unplug_pending_mb(struct virtio_mem *vm)
 	int rc;
 
 	virtio_mem_sbm_for_each_mb(vm, mb_id, VIRTIO_MEM_SBM_MB_PLUGGED) {
-		rc = virtio_mem_mb_unplug(vm, mb_id);
+		rc = virtio_mem_sbm_unplug_mb(vm, mb_id);
 		if (rc)
 			return rc;
 		virtio_mem_sbm_set_mb_state(vm, mb_id,
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
