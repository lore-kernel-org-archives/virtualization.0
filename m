Return-Path: <SRS0=R3N6=DT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E0DC433E7
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 12:56:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 938DE21BE5
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 12:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iha3NUoc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938DE21BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1E0542051F;
	Mon, 12 Oct 2020 12:56:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XY7CEG2sl39R; Mon, 12 Oct 2020 12:56:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0FC492079A;
	Mon, 12 Oct 2020 12:56:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02C58C07FF;
	Mon, 12 Oct 2020 12:56:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04428C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:56:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DE8382051F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:56:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dn8u6-Z2WC+n
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:56:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 8E9F52079A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602507360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7P2vBNnGvTj7ryjZqgBDKBivuPaDY4fI99105fL53IE=;
 b=iha3NUocjIstH/s/P2w9AXO3G+rmtnxSPyZuCNro1hV4+49+Op6lUBCVYuti4OCl7cVJTK
 iHAJjqFUfIgUp4x7dtdhfmU7yQNJrMv9KDwvDrZ5gBtVqpaDKUj+IMRO+GEy2sB5wMpJTm
 IettSAzmnUJY8/+eRRqQzNmLyF8yV2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-5FQdEEU9MSCnx-uOaL-vSw-1; Mon, 12 Oct 2020 08:55:58 -0400
X-MC-Unique: 5FQdEEU9MSCnx-uOaL-vSw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 692ED801FD4;
 Mon, 12 Oct 2020 12:55:57 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-251.ams2.redhat.com [10.36.113.251])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B1B1460C07;
 Mon, 12 Oct 2020 12:55:49 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 18/29] virtio-mem: factor out calculation of the bit number
 within the sb_states bitmap
Date: Mon, 12 Oct 2020 14:53:12 +0200
Message-Id: <20201012125323.17509-19-david@redhat.com>
In-Reply-To: <20201012125323.17509-1-david@redhat.com>
References: <20201012125323.17509-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
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

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 2cc497ad8298..73ff6e9ba839 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -327,6 +327,16 @@ static int virtio_mem_sbm_mb_states_prepare_next_mb(struct virtio_mem *vm)
 	     _mb_id--) \
 		if (virtio_mem_sbm_get_mb_state(_vm, _mb_id) == _state)
 
+/*
+ * Calculate the bit number in the sb_states bitmap for the given subblock
+ * inside the given memory block.
+ */
+static int virtio_mem_sbm_sb_state_bit_nr(struct virtio_mem *vm,
+					  unsigned long mb_id, int sb_id)
+{
+	return (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
+}
+
 /*
  * Mark all selected subblocks plugged.
  *
@@ -336,7 +346,7 @@ static void virtio_mem_sbm_set_sb_plugged(struct virtio_mem *vm,
 					  unsigned long mb_id, int sb_id,
 					  int count)
 {
-	const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
+	const int bit = virtio_mem_sbm_sb_state_bit_nr(vm, mb_id, sb_id);
 
 	__bitmap_set(vm->sbm.sb_states, bit, count);
 }
@@ -350,7 +360,7 @@ static void virtio_mem_sbm_set_sb_unplugged(struct virtio_mem *vm,
 					    unsigned long mb_id, int sb_id,
 					    int count)
 {
-	const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
+	const int bit = virtio_mem_sbm_sb_state_bit_nr(vm, mb_id, sb_id);
 
 	__bitmap_clear(vm->sbm.sb_states, bit, count);
 }
@@ -362,7 +372,7 @@ static bool virtio_mem_sbm_test_sb_plugged(struct virtio_mem *vm,
 					   unsigned long mb_id, int sb_id,
 					   int count)
 {
-	const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
+	const int bit = virtio_mem_sbm_sb_state_bit_nr(vm, mb_id, sb_id);
 
 	if (count == 1)
 		return test_bit(bit, vm->sbm.sb_states);
@@ -379,7 +389,7 @@ static bool virtio_mem_sbm_test_sb_unplugged(struct virtio_mem *vm,
 					     unsigned long mb_id, int sb_id,
 					     int count)
 {
-	const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
+	const int bit = virtio_mem_sbm_sb_state_bit_nr(vm, mb_id, sb_id);
 
 	/* TODO: Helper similar to bitmap_set() */
 	return find_next_bit(vm->sbm.sb_states, bit + count, bit) >=
@@ -393,7 +403,7 @@ static bool virtio_mem_sbm_test_sb_unplugged(struct virtio_mem *vm,
 static int virtio_mem_sbm_first_unplugged_sb(struct virtio_mem *vm,
 					    unsigned long mb_id)
 {
-	const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb;
+	const int bit = virtio_mem_sbm_sb_state_bit_nr(vm, mb_id, 0);
 
 	return find_next_zero_bit(vm->sbm.sb_states,
 				  bit + vm->nb_sb_per_mb, bit) - bit;
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
