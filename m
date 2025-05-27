Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBD71E3DE5
	for <virtualization@lists.linux.dev>; Tue, 27 May 2025 18:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748370858; cv=none; b=aaNUYRLU140Kbcjs434OYaZGAI4nDhQQMLM9NNwewZCDKnm2WMLw4lTFpugcXryhBLLPMlGakgcrT6U+T/JsmyOWUNmh/6Ne1HznqoozFNYlCiULTCpoa7NeGs0yUPT9N0EeaU9qj38fG8fqh2c0c47+Xdv0QzcDHiruiq3pSEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748370858; c=relaxed/simple;
	bh=0Jy79fKrZ2sdCTDLs4CL8isdKanjCgnJK4ncWOMFDkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEeNeMU6fHfFGHC4zM90yaqYBCRsTURmC1O3tfEoUSpkMW02K7JWmXdbMTUKcUia+eG/ysr2oWVNay+CqsmQY55//+y+lig3p4N5RpHWZMkiU9bQk7UsO/NeG2M6AENZeX4jblbjlpV8EhchxVHn8ismAWjlI4uqq691SV12HrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=huk6eN4O; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="huk6eN4O"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RFu3Oj024643;
	Tue, 27 May 2025 18:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=JgAVX
	+4qBGglzI/okdxjMM4pGRQoTAsDOhOkuaH0MoQ=; b=huk6eN4O8AHJ+5ckrFSXh
	XVA3mH/NkRBdg5jxigwqR1ECW5zvL3sFyxRRVZfcuxXQja8l11tiyfxB+wy+s3x/
	zmPFDmbwPHV9v7gixjoFO+2+mkSdsJhPF52qq7O5Rap6JRyC+6nZRlVoia7BBxhw
	EBfLK5j9oEhlMaAyaeA2UGwk1odn0X6GBdMPoqWS8hVl+J/aQiNALvj4jT8S+lhR
	PuLXyLTerM/cYSNRO+iViknjvtTTo/1XEzV+XM2fnLgp5RfRCO7/Ry+krWuTnf2G
	O4Ubz8lHbBEcFgjqVikrXS4QQDG7/1DR3ZEHbkb94UDhJnx3n4lERDweVlhp1Ui1
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v3pd3x8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 18:34:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54RHVdr6007197;
	Tue, 27 May 2025 18:34:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4j9jbvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 18:34:12 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54RIXHkx028068;
	Tue, 27 May 2025 18:34:11 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 46u4j9jbtx-2;
	Tue, 27 May 2025 18:34:11 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: david@redhat.com, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        virtualization@lists.linux.dev
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org,
        darren.kenny@oracle.com
Subject: [PATCH 2/3] virtio-mem: fix multiple typos in struct comments and function docs
Date: Tue, 27 May 2025 11:33:39 -0700
Message-ID: <20250527183407.2093374-2-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250527183407.2093374-1-alok.a.tiwari@oracle.com>
References: <20250527183407.2093374-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_09,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505270154
X-Proofpoint-ORIG-GUID: gTOj9NecW92TfvSD-XwVOP_P2tjHkVlN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDE1NCBTYWx0ZWRfX5zx+q2addZrO xQR5IYM5q1a1SwMQln+6KLP9VpYD5bBMx7DrygynNdjDzz/VwHxmLkIV0JKxszzkRFBP9aqhjm1 zi3UobF4GGiWeDN/yHBFKCalqyPoYogsoXNYkiOT6fAcGONJLbQbymQ+aCPla/txIIbSRMIqiIc
 xR956EjYtDhEUF+c5rSb5nI7IsjM247b5uR9IcT+3l8m4SuCg+7xUUzoiIslZLrYLT87TOmAzGY SGmduzh4lhLBHeKjcA7OkEWueTLLhLcv1Shht49QQLYSM//++19hG/w1jDsPXs6T0nENJpq8RA9 wJNmKQnRJne/qC8VUDxbLqTvSyCQ53n403rxQcrOopY76739mzi3jVHljQg4oz7JtrGJDIMyGKZ
 gBpwTElZYAwBontkKFjAEI2jFGy1qFC2GQiFGdz5OQ9BiRsgUVUW2fz2PC47MWbwcp/nMNzS
X-Authority-Analysis: v=2.4 cv=UZNRSLSN c=1 sm=1 tr=0 ts=683605a5 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=g6tw7J_2hcjgWMFmvSMA:9
X-Proofpoint-GUID: gTOj9NecW92TfvSD-XwVOP_P2tjHkVlN

Corrected several spelling mistakes in code comments, including:
- "bock" -> "block"
- "valued" -> "value"
- "actipn" -> "action"
- "accidentially" -> "accidentally"
- Improved grammar in a few places for clarity.

These changes are purely cosmetic and do not affect functionality.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/virtio/virtio_mem.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 56d0dbe62163..f318a2d3c885 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -164,7 +164,7 @@ struct virtio_mem {
 			unsigned long first_mb_id;
 			/* Id of the last usable memory block of this device. */
 			unsigned long last_usable_mb_id;
-			/* Id of the next memory bock to prepare when needed. */
+			/* Id of the next memory block to prepare when needed. */
 			unsigned long next_mb_id;
 
 			/* The subblock size. */
@@ -209,7 +209,7 @@ struct virtio_mem {
 			unsigned long first_bb_id;
 			/* Id of the last usable big block of this device. */
 			unsigned long last_usable_bb_id;
-			/* Id of the next device bock to prepare when needed. */
+			/* Id of the next device block to prepare when needed. */
 			unsigned long next_bb_id;
 
 			/* Summary of all big block states. */
@@ -240,7 +240,7 @@ struct virtio_mem {
 	/* An error occurred we cannot handle - stop processing requests. */
 	bool broken;
 
-	/* Cached valued of is_kdump_kernel() when the device was probed. */
+	/* Cached value of is_kdump_kernel() when the device was probed. */
 	bool in_kdump;
 
 	/* The driver is being removed. */
@@ -615,7 +615,7 @@ static int virtio_mem_sbm_sb_states_prepare_next_mb(struct virtio_mem *vm)
 
 /*
  * Test if we could add memory without creating too much offline memory -
- * to avoid running OOM if memory is getting onlined deferred.
+ * to avoid running OOM if memory is getting online deferred.
  */
 static bool virtio_mem_could_add_memory(struct virtio_mem *vm, uint64_t size)
 {
@@ -808,7 +808,7 @@ static int virtio_mem_sbm_try_remove_unplugged_mb(struct virtio_mem *vm,
 }
 
 /*
- * See virtio_mem_offline_and_remove_memory(): Try to offline and remove a
+ * See virtio_mem_offline_and_remove_memory(): Try to offline and remove
  * all Linux memory blocks covered by the big block.
  */
 static int virtio_mem_bbm_offline_and_remove_bb(struct virtio_mem *vm,
@@ -1080,7 +1080,7 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 		atomic64_sub(size, &vm->offline_size);
 		/*
 		 * Start adding more memory once we onlined half of our
-		 * threshold. Don't trigger if it's possibly due to our actipn
+		 * threshold. Don't trigger if it's possibly due to our action
 		 * (e.g., us adding memory which gets onlined immediately from
 		 * the core).
 		 */
@@ -2124,7 +2124,7 @@ static int virtio_mem_sbm_unplug_request(struct virtio_mem *vm, uint64_t diff)
 	 * whole memory blocks along with metadata. We prioritize ZONE_MOVABLE
 	 * as it's more reliable to unplug memory and remove whole memory
 	 * blocks, and we don't want to trigger a zone imbalances by
-	 * accidentially removing too much kernel memory.
+	 * accidentally removing too much kernel memory.
 	 */
 	for (i = 0; i < ARRAY_SIZE(mb_states); i++) {
 		virtio_mem_sbm_for_each_mb_rev(vm, mb_id, mb_states[i]) {
-- 
2.47.1

