Return-Path: <SRS0=8i8N=ES=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21283C56202
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 13:38:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96BD622249
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 13:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AAS2w4uT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96BD622249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 58C9C870E6;
	Thu, 12 Nov 2020 13:38:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mTR7t2X2vX5C; Thu, 12 Nov 2020 13:38:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B41A4870D9;
	Thu, 12 Nov 2020 13:38:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD8F0C088B;
	Thu, 12 Nov 2020 13:38:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D2B6C016F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:38:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2C72D870E5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:38:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id loXu3rDqaPcV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:38:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7E0C5870D9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605188330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X0WfQnw15Vm9t+Uqndhh69vgkO1/7kUW5WBgUBhjrGY=;
 b=AAS2w4uT/MWOtwolF8jzHBjkIWkyX4oNPGD2L79h1LMWbzyjN1Sm/GdBO9VeitHJvzKKQx
 V0RLRKaZmC5hjNXDvtHmxFJQzFSavl4sJWbxlZxwOqCb42Mh0o5ePkhzwDxoBkGLkSZ7oo
 t89tvy9PmFhqG9xHU7yeoRFe1AwzmZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-k-FLLVhEMsmObHVn5xkdtw-1; Thu, 12 Nov 2020 08:38:46 -0500
X-MC-Unique: k-FLLVhEMsmObHVn5xkdtw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 215E01030986;
 Thu, 12 Nov 2020 13:38:45 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-61.ams2.redhat.com [10.36.115.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F2EB955765;
 Thu, 12 Nov 2020 13:38:36 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/29] virtio-mem: factor out calculation of the bit number
 within the subblock bitmap
Date: Thu, 12 Nov 2020 14:37:52 +0100
Message-Id: <20201112133815.13332-7-david@redhat.com>
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

The calculation is already complicated enough, let's limit it to one
location.

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 94451b401fba..30b4d07f5263 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -290,6 +290,16 @@ static int virtio_mem_mb_state_prepare_next_mb(struct virtio_mem *vm)
 	     _mb_id--) \
 		if (virtio_mem_mb_get_state(_vm, _mb_id) == _state)
 
+/*
+ * Calculate the bit number in the subblock bitmap for the given subblock
+ * inside the given memory block.
+ */
+static int virtio_mem_sb_bitmap_bit_nr(struct virtio_mem *vm,
+				       unsigned long mb_id, int sb_id)
+{
+	return (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
+}
+
 /*
  * Mark all selected subblocks plugged.
  *
@@ -299,7 +309,7 @@ static void virtio_mem_mb_set_sb_plugged(struct virtio_mem *vm,
 					 unsigned long mb_id, int sb_id,
 					 int count)
 {
-	const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
+	const int bit = virtio_mem_sb_bitmap_bit_nr(vm, mb_id, sb_id);
 
 	__bitmap_set(vm->sb_bitmap, bit, count);
 }
@@ -313,7 +323,7 @@ static void virtio_mem_mb_set_sb_unplugged(struct virtio_mem *vm,
 					   unsigned long mb_id, int sb_id,
 					   int count)
 {
-	const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
+	const int bit = virtio_mem_sb_bitmap_bit_nr(vm, mb_id, sb_id);
 
 	__bitmap_clear(vm->sb_bitmap, bit, count);
 }
@@ -325,7 +335,7 @@ static bool virtio_mem_mb_test_sb_plugged(struct virtio_mem *vm,
 					  unsigned long mb_id, int sb_id,
 					  int count)
 {
-	const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
+	const int bit = virtio_mem_sb_bitmap_bit_nr(vm, mb_id, sb_id);
 
 	if (count == 1)
 		return test_bit(bit, vm->sb_bitmap);
@@ -342,7 +352,7 @@ static bool virtio_mem_mb_test_sb_unplugged(struct virtio_mem *vm,
 					    unsigned long mb_id, int sb_id,
 					    int count)
 {
-	const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
+	const int bit = virtio_mem_sb_bitmap_bit_nr(vm, mb_id, sb_id);
 
 	/* TODO: Helper similar to bitmap_set() */
 	return find_next_bit(vm->sb_bitmap, bit + count, bit) >= bit + count;
@@ -355,7 +365,7 @@ static bool virtio_mem_mb_test_sb_unplugged(struct virtio_mem *vm,
 static int virtio_mem_mb_first_unplugged_sb(struct virtio_mem *vm,
 					    unsigned long mb_id)
 {
-	const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb;
+	const int bit = virtio_mem_sb_bitmap_bit_nr(vm, mb_id, 0);
 
 	return find_next_zero_bit(vm->sb_bitmap, bit + vm->nb_sb_per_mb, bit) -
 	       bit;
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
