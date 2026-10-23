Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743692;
	b=2iJ0bXbe3mDd0jTQteVAGnU9fqTQRcUdMk5oSnJAbOfMs06q/lrx+m4DK8c2j/cbhvt2
	 T93I2VFyRVpHZ9vIOkS/uo1Z7A5OO8QcL8PZ5PemGafXBiVQ39LqXuyIDtpiRPb2tadOb
	 JCNnxSunQ4o4oeioJ4ELwT/cOUJZcNIBZWvWC+U6oz7ht56C7m+8+inTCcOpmvwWuaxJz
	 1NY0jC8KcjdbBvbhg9vjJeRibnnw9TeIHsKOlmvRaj/HW2enQ7JyrtSlPcNLsrlvBptYC
	 LUDfY0jV9Mkx0/grUB4CVKUTN9BNgXlFXDpa8TlEXOz6t2dI3a5a6SyEuz15rLdR+6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743692;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=p6NHsQh6FnQZ5O5CU2muMwdS/Y29oiEXUuDekOVD+lI=;
	b=m1iSixAa6sMY2kWCdmRrr1CcE7yi9ORUjo/vdjh1jMs3V1BI+p9s/Q1a8fmn29TPNDoU
	 Mqc/qU8nshm2bUOn6q7oJOgWPZAyXkEsxdssfgfRL1LX0U/VcXPwwDr9xty+IU4Qq+vYK
	 bunlhWIV7jWQcH5N7raCWeSTlE3kJouPiAiYr4AfRWzpxtMcK5eBc8rJK0DCrWt5ylhQE
	 i6utPoiL4w324eV5ICpgEt3KAbnZkKDoR5i8lsktvVkWDYRKKFVL+54a65u7t2+NxC8Ij
	 yPBJtENXgUMKg/JwGXjySUzXmDbdsbQ2DYpcQALuw1p7++PGkB2vUgUoqiEV5H7GAcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=Fu036nvQ;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DD8606A327
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 08:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8DD8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=Fu036nvQ
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7F9PA3370087;
	Fri, 23 Oct 2026 01:21:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=p6NHsQh6F
	nQZ5O5CU2muMwdS/Y29oiEXUuDekOVD+lI=; b=Fu036nvQ3WEPMhkWHrIOM3XX8
	kaV/aG338cCigSnvGUtXoYFzxQKqZ2zLKSFuzDG9hJ96X7QgB9qUQb50hZx9znCE
	NbZzSbMHnl/VAXQoijs4tTArmSb87K97i5YVYTb4QO29NFB9QjsBaJU5JMElKN1F
	a0wLux2Iz+94JPLNgfXBmk6gBMOEpTSWEL+CeorkTmsVMvQQgHa4Oc1nXf4e2Lk0
	rfo/IdRlBZcuhd/9HEBuHKDAiji5zWP20ghnulGiSfRu+Ra7zZxXD4Z/RKAW5dql
	LW0i9ORRjPSDTg4bMPD2limTu/OAXX2WObsFqEemB9eafxWbvHdCJ/TACowFQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hf9mx9fp9-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 23 Oct 2026 01:21:08 -0700 (PDT)
Received: from localhost (2620:10d:c085:108::4) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 23 Oct
 2026 08:21:06 +0000
From: Ruben Hakobyan <hruben@meta.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand
	<david@kernel.org>
CC: Breno Leitao <leitao@debian.org>, Atish Patra <atishp@meta.com>,
        "Jason
 Wang" <jasowangio@gmail.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Alexander
 Duyck" <alexander.h.duyck@linux.intel.com>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] virtio_balloon: batch large descriptor chains for page reporting
Date: Fri, 23 Oct 2026 01:19:19 -0700
Message-ID: <20261023081923.164950-1-hruben@meta.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Omy9UxNFoTOB8myOSsMFCBtB-vJiFFj1
X-Authority-Analysis: v=2.4 cv=G7iJgNk5 c=1 sm=1 tr=0 ts=6adb18f4 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=wpfVPzegXHpEFt3DAXn9:22 a=mkMtH7XpAAAA:8 a=vovA2YXZAAAA:20 a=VabnemYjAAAA:8
 a=LV-WQNVlgMwP2ZNcymAA:9 a=I9Slk6e--tAXHahELIuT:22 a=gKebqoRLp9LExxC7YDUY:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX5RHn0ccRY3Ml
 ky9o5oDxxlRFybnZs3KeOk8IgLegqv3Yahh2CN193WW0jmCW2Rdvoin8tkgtd+0ASH4fnq9IAw9
 WrBLv6rAdvsdtevjikpuTi8V8iWTFBM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX3HENgCL76aT+
 B5UNIbQlly8qbDPiTF4iQ+tTSENOkkwLcCbBXVjhBtas7kTH5o7VHziBuVQtc93h9RdqW3tu7yE
 GZocXJCy3y/ANm/EPyd8yRI5/jjB0Zjx74cQZUAflun79JVDQQHUfCu9uWgthmBNFxVOpRsFvMz
 BNmme7scFMaeXfCJU9AOACGmcTmtapblc8xTcCScmAClop3xsGBGNx6RYsUrbM2+kwl7l6r0rzH
 yo+4BypdDdhpOXbPRSQDKnKLkNLBq1QGaBVSE9UOMl6gPmtP2Pf34Wmo2JqrU9hMu0MfSSaEnkw
 l2Lg0v7U6iqhOvxBvG9mPe4PnAyfetvsouINCHi+0IgHT424lB2Qjbv31LZhrNBSP8+1WM01YoV
 R5ozoJuwh5j8fpIgP0yDrWMRRNwFtNBseanSfNcLVWhEdHQH887qeY/ku8rhcX5x7YPxNAkp0Ln
 B4fv7k/byhbC89C90rQ==
X-Proofpoint-ORIG-GUID: Omy9UxNFoTOB8myOSsMFCBtB-vJiFFj1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01

The virtio_balloon driver reports a scatter-gather list of free pages
to the VMM so it may discard unused pages.

For an arm64 kernel with 64 KiB pages, the default reporting and
allocation orders allow entries ranging from 2 MiB to 512 MiB. If the
report contains a sufficient number of large entries, we will end up
with a descriptor chain that represents over 4 GiB of memory. This
violates virtio spec section 2.7.5.2, which requires that the total
buffer length of a descriptor chain be at most 4 GiB [1]. A VMM that
faithfully follows the spec may stop processing the descriptor chain
when it exceeds 4 GiB, and discard less memory than it could. For
example, this is the case for the virtio-queue in Rust-VMM [2].

Batch the requests into descriptor chains of at most U32_MAX bytes
(4 GiB - 1 byte). We use U32_MAX here so we can conveniently represent
the batch length in a u32.

[1] https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.html
[2]
https://github.com/rust-vmm/rust-vmm/blob/9f7250b1555ebe022ea4133fda676e6311040738/vm-virtio/virtio-queue/src/chain.rs#L183-L190

Fixes: b0c504f15471 ("virtio-balloon: add support for providing free page reports to host")
Signed-off-by: Ruben Hakobyan <hruben@meta.com>
---
The wording in the spec is a bit ambiguous because it uses "chain
length" for both descriptor counts and the total size of the memory
ranges referenced by the descriptors. My read is that the byte limit
applies to the sum of descriptor lengths, which is also what rust-vmm
checks.

Another option I considered was to limit reporting capacity based
on the largest possible block. E.g. for 64 KiB pages, the largest
block is 512 MiB, so limit the reporting capacity to 7 to stay
below 4GiB. Although simpler, I found that the time to reclaim
was quite a bit longer.

I tested this patch on Cloud Hypervisor (which uses Rust-VMM)
and QEMU (which doesn't enforce this limit).

 drivers/virtio/virtio_balloon.c | 47 ++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index ab3e3d887e00..68ce627c8e04 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/balloon.h>
+#include <linux/limits.h>
 #include <linux/oom.h>
 #include <linux/wait.h>
 #include <linux/mm.h>
@@ -207,21 +208,43 @@ static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_i
 	struct virtqueue *vq = vb->reporting_vq;
 	unsigned int unused, err;
 
-	/* We should always be able to add these buffers to an empty queue. */
-	err = virtqueue_add_inbuf(vq, sg, nents, vb, GFP_NOWAIT);
+	while (nents) {
+		bool unmark_end;
+		struct scatterlist *sg_batch_start = sg;
+		u32 batch_len = 0;
+		unsigned int batch_nents = 0;
 
-	/*
-	 * In the extremely unlikely case that something has occurred and we
-	 * are able to trigger an error we will simply display a warning
-	 * and exit without actually processing the pages.
-	 */
-	if (WARN_ON_ONCE(err))
-		return err;
+		/*
+		 * Virtio spec 2.7.5.2 limits the total buffer length of a
+		 * descriptor chain to 2^32 bytes (4 GiB), so split larger
+		 * reports into batches no bigger than that size.
+		 */
+		while (batch_nents < nents &&
+		       sg->length <= U32_MAX - batch_len) {
+			batch_len += sg->length;
+			batch_nents += 1;
+			sg = sg_next(sg);
+		}
+		unmark_end = !sg_is_last(&sg_batch_start[batch_nents - 1]);
 
-	virtqueue_kick(vq);
+		if (unmark_end)
+			sg_mark_end(&sg_batch_start[batch_nents - 1]);
 
-	/* When host has read buffer, this completes via balloon_ack */
-	wait_event(vb->acked, virtqueue_get_buf(vq, &unused));
+		err = virtqueue_add_inbuf(vq, sg_batch_start, batch_nents, vb,
+					  GFP_NOWAIT);
+
+		if (unmark_end)
+			sg_unmark_end(&sg_batch_start[batch_nents - 1]);
+
+		if (WARN_ON_ONCE(err))
+			return err;
+
+		virtqueue_kick(vq);
+
+		/* When host has read buffer, this completes via balloon_ack */
+		wait_event(vb->acked, virtqueue_get_buf(vq, &unused));
+		nents -= batch_nents;
+	}
 
 	return 0;
 }
-- 
2.53.0-Meta

