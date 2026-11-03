Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725167;
	b=qs//vGHJ3LuPVzI0E4AjlrFoM73TpVPwSEfRgL3d+klHjIXeGCaSjNrDMF8nST8/U7I2
	 cqKhF7AVXhCbN19lJMeGxZ0Xcb+Qp/wuoxTQCX/9gqrAumb3//vNLxYsRYw+YKL1N6rzM
	 TCn/OVNYiUD+YMcSSJwJT+UpP+ocyUQB+TMPSI5RwdYnhOXGCuT5ZUQwATAhjGEvFqSWM
	 YT/qYt/59vHJxUkiUSbZI7Wgtc35qD0a3jlSHnQvvvgfPBpL9cqR8IMBX12beKJxrWpoz
	 r0XZG3u3tZRZtSiXb+puAyy21vhMvu9DasTIW0OIS1CjjTzuYW8elIdQ/OJe0CeofFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=30fBqIUk44N3HdvXKXPWYu2PFlzNF8/RtKozuVD1mMQ=;
	b=oNGvOAUFO8h838aNLozJDqy++4C1MG2l4mAs/TF426MH6xXMcU8gm6zXaOkjnAFSD4Aa
	 RMvhZ+DGV+aZz0UW55TYGpfyWyD3hgPp61JoV/MS4bTrkZl3ojpAF7m6e3Vcu3yxEF+68
	 YiPetm9cf1Wq/TrIf+fb1fkWgvMZBiOle/CLfheO52wZrbjHMAipfvRzuYM+olhgA1cPG
	 ZMRnPyqZSd9Byd4MwE5Hu7fyZptJjD8N673kdOLaARLXCAczokLEngoY198GyJFuMabic
	 xc0w11odReH7yg7gi0y6ExS0eLpBs5A6zvxgYiSHoaPOMUBTWLPeM+lZMuDv7n3hfJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OkfwVeIO;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DE7606A338
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 16:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42DE7606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OkfwVeIO
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36a17a332ecso6641570eec.1
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 08:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793725166; x=1794329966; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=30fBqIUk44N3HdvXKXPWYu2PFlzNF8/RtKozuVD1mMQ=;
        b=OkfwVeIOMsS37O7FS+G7HyOLV7xSdYMxXO/sYmxkpABETnGKiNFu8lXmWjiBh9LP7U
         H9YemFgDmu4rLDL+NSS3kt7I+3zB43xuzsh6bRI8D2PbIRoPcBOg+TLIQNMmIhHNDORt
         HX0EnqLepWKop3IzMlgcLyWqUgJUp4oPKX4UhF4NrmnHKPYHTlGc6R89PwvaeHd91Z4j
         u0FxnJJxV9eR54TI2Wwt0rkkggTTbNOqOyKLwgJ5JM2g3EYtsjGc+SkvRoYZwKfWYIka
         xNvHsOWz3AefwX+QlwHEeG4U6swigJo+5lJ+VXC7OEmSuwCZazuAmvzotr2tmH7WmjyE
         MX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793725166; x=1794329966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=30fBqIUk44N3HdvXKXPWYu2PFlzNF8/RtKozuVD1mMQ=;
        b=LCm4vGE6nHHCQdmMSrkuhw3Ff91RSkWalQQhVtHW4JeybkL9vydVBVF+FeOiUCBq+9
         5dml5BbczzD7chYie5vcNaNEPeAhmVcCu7si0AaRWTugQ2jqNF30+jR3es7p5C56JNpf
         vH+2d5naI245+PxeB7gGTrC14ILt+N5+GCNGrYQN05tzHqXIrVSBoqgiz3T0a7Zplp6D
         CbAdQ8YzvbPk96yu34r7Uhep6sE2iv9gBrEOqzciQgzV3IgzskkC1uiOWTwzbjPDxGtA
         l78WNkREu2NnuwSIEgXILX090oqdeftpx/+QsluIhckj5p6h1DkhH02rVo/w00fAZm0C
         WpwQ==
X-Forwarded-Encrypted: i=1; AKwUvBw+u8t04OvMYTMvsr6iUF9N3Gq/9ERysgYslxOn8ldBZMX9ebnzXnpo1JannNcQLKJlIc4mXbqs7x5n2KUS1w==@lists.linux.dev
X-Gm-Message-State: APuU4Z8sVDelrmIXdId0aXkyyAJ5EYeTP7vOURP/UHrfcffj+Mi+VzCi
	1hsFF8277I64BEhMuQgCbsJ2sV7h5yhKnC/8Os55DtqERptxTIkeUyVL
X-Gm-Gg: AYBFou3pLCo5dCxRdDGDZ2A4F8//JKeb3UDZwQ8k7ieqKr18xCJrCRN43h67Rmb6Gwr
	PvwzTAqcTUPnt9utb3jFcE176QtbNQ4isAdE/aXkS5wlmpcvgX1XLAD6ybQrAhbQT2EPAHi8TSr
	m1Ga+WmgUYi/JfxzsouhdtAfiijj4njoKiFbfIpreSLIe899MvSKgTKk0TSGixLc+XFQUpo20Mu
	w0t+8WBFY5ExRYNxSpcJiewIdMKmQ0DKkyTfNdmuHiMxyPZp5ODsJKPeBsPR3CNAlpAfjxJuXp7
	gtWawY/I6KcgQmadofBAq8j4FLOwm/BXzR0B3URU7JLCjBjC2e3fwlAGc/8KPzs7Axga9R9iLfB
	J0JCyZRGGaXs6DAevft+R3RsTZMM1ymSM1WPpbNiCDxWeb6YvRBu4Fs2tSmnQ51eVCD2h8JpSRq
	iNcX7jeZMXV+UFavDhq3cKe6GAuEW2nlstRBHx+iahRhG72iHkCJfC2mC3uPajbXjDMrGyiXwsa
	z/7H+alzo0nvoU0C9eKQ+hebwUmo3acQkMaqM7aDdlh+VJdwe6yr6JO6ag3XEeUWpbbiXF41o5X
	Rmp/Kl7d6kUWD/BBucAF3s+1cRwqJSm3z1IwfKTbtvPn+QXyVPieUYJMSUCRgETe/+/PKB1b/3p
	xE3y+qMxQTm/1jFgOqqL2bcKEKo4shCnTjsBLouFMnAYi5MASZR+x15aCA7f/sdn36ZpkGOQmBJ
	kT
X-Received: by 2002:a05:7301:4b0a:b0:369:9af5:7bc9 with SMTP id 5a478bee46e88-36a424199eamr20487749eec.23.1793725166155;
        Tue, 03 Nov 2026 08:59:26 -0800 (PST)
Received: from LAPTOP-97G9G880.domain.name ([106.222.203.148])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4239ca83sm9293247eec.0.2026.11.03.08.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:59:25 -0800 (PST)
From: Karthikeyan KS <karthiproffesional@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Mike Christie <michael.christie@oracle.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] vhost-scsi: use FOLL_PIN for DMA page pinning
Date: Tue,  3 Nov 2026 16:59:17 +0000
Message-ID: <20261103165917.148720-1-karthiproffesional@gmail.com>
X-Mailer: git-send-email 2.43.0
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

vhost_scsi_map_to_sgl() takes references on guest buffer pages with
iov_iter_get_pages2() (FOLL_GET) and then performs DMA to/from them.
Per Documentation/core-api/pin_user_pages.rst (Case 1: Direct IO),
pages that are the target of DMA must be pinned with FOLL_PIN instead.
Only FOLL_PIN pins are visible to folio_maybe_dma_pinned(), which fork()
uses to copy rather than COW-share anonymous pages under DMA, and only
FOLL_PIN guarantees a pinned anonymous page is exclusive to the process,
so a later write fault cannot replace it while DMA is in flight.

Switch to iov_iter_extract_pages(), which pins user-backed iterators,
and release the pages with unpin_user_page(). Kernel-backed iterators
take neither a reference nor a pin, so track with
iov_iter_extract_will_pin() whether an unpin is needed.

Cc: Jason Wang <jasowangio@gmail.com>
Cc: Mike Christie <michael.christie@oracle.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: virtualization@lists.linux.dev
Signed-off-by: Karthikeyan KS <karthiproffesional@gmail.com>
---
v1 -> v2:
 - Rebased on vhost next. Sashiko reported that the revert loop in
   vhost_scsi_map_to_sgl() leaks a page when the misaligned-I/O check
   trips on the first page with a non-zero offset. That bug is older
   than this patch (the loop leaked a put_page() reference) and is fixed
   in vhost next by Jia Jia's 058fc59326af ("vhost-scsi: fix page
   reference leak in misaligned I/O fallback"). On top of it, this patch
   only calls unpin_user_page() instead of put_page() in that loop.
 - Reworded the commit message to describe FOLL_GET and FOLL_PIN more
   accurately.

Testing: in QEMU (fileio backend), a 1 MiB write at page offset 3840 is
257 pages, more than BIO_MAX_VECS, so the misaligned-I/O check trips on
the first page and dmesg shows the "vhost-scsi detected misaligned IO"
warning. On v1 (before 058fc59326af) the nr_foll_pin_acquired and
nr_foll_pin_released counters end at 257 and 256 for each such command;
with v2 on vhost next they balance. Plain (256 pages) and T10-PI (260
pages) writes balance too.

v1:       https://lore.kernel.org/20261007163716.707102-1-karthiproffesional@gmail.com
RESEND:   https://lore.kernel.org/20261020182640.2048506-1-karthiproffesional@gmail.com
review:   https://lore.kernel.org/sashiko-outbox-180555@kernel.org
leak fix: https://lore.kernel.org/20261023104035.6686-1-physicalmtea@gmail.com

 drivers/vhost/scsi.c | 50 +++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index e44044449cef..8beeff06a7a7 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -115,6 +115,8 @@ struct vhost_scsi_cmd {
 	u32 tvc_sgl_count;
 	u32 tvc_prot_sgl_count;
 	u32 copied_iov:1;
+	u32 tvc_need_unpin:1;
+	u32 tvc_prot_need_unpin:1;
 	const void *read_iov;
 	struct iov_iter *read_iter;
 	struct scatterlist *sgl;
@@ -463,8 +465,13 @@ static void vhost_scsi_release_cmd_res(struct se_cmd *se_cmd)
 
 			if (tv_cmd->copied_iov)
 				__free_page(page);
-			else
-				put_page(page);
+			else if (tv_cmd->tvc_need_unpin)
+				unpin_user_page(page);
+			/*
+			 * Else: iov_iter_extract_pages() took neither a ref
+			 * nor a pin on this page (ITER_KVEC/BVEC/etc), so
+			 * there is nothing to release here.
+			 */
 		}
 		kfree(tv_cmd->read_iter);
 		kfree(tv_cmd->read_iov);
@@ -473,8 +480,8 @@ static void vhost_scsi_release_cmd_res(struct se_cmd *se_cmd)
 	if (tv_cmd->tvc_prot_sgl_count) {
 		for_each_sgtable_sg(&tv_cmd->prot_table, sg, i) {
 			page = sg_page(sg);
-			if (page)
-				put_page(page);
+			if (page && tv_cmd->tvc_prot_need_unpin)
+				unpin_user_page(page);
 		}
 		sg_free_table_chained(&tv_cmd->prot_table, vs->inline_sg_cnt);
 	}
@@ -820,7 +827,8 @@ vhost_scsi_get_cmd(struct vhost_virtqueue *vq, u64 scsi_tag)
 
 static void vhost_scsi_revert_map_iov_to_sgl(struct iov_iter *iter,
 					     struct scatterlist *curr,
-					     struct scatterlist *end)
+					     struct scatterlist *end,
+					     bool need_unpin)
 {
 	size_t revert_bytes = 0;
 	struct page *page;
@@ -829,7 +837,8 @@ static void vhost_scsi_revert_map_iov_to_sgl(struct iov_iter *iter,
 		page = sg_page(curr);
 
 		if (page) {
-			put_page(page);
+			if (need_unpin)
+				unpin_user_page(page);
 			revert_bytes += curr->length;
 		}
 		/* Clear so we can re-use it for the copy path */
@@ -859,9 +868,9 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
 	size_t offset;
 	unsigned int n, npages = 0;
 
-	bytes = iov_iter_get_pages2(iter, pages, LONG_MAX,
-				VHOST_SCSI_PREALLOC_UPAGES, &offset);
-	/* No pages were pinned */
+	bytes = iov_iter_extract_pages(iter, &pages, LONG_MAX,
+				       VHOST_SCSI_PREALLOC_UPAGES, 0, &offset);
+	/* No pages were extracted */
 	if (bytes <= 0)
 		return bytes < 0 ? bytes : -EFAULT;
 
@@ -884,7 +893,7 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
 		    cmd->tvc_sgl_count > BIO_MAX_VECS) {
 			WARN_ONCE(true,
 				  "vhost-scsi detected misaligned IO. Performance may be degraded.");
-			goto revert_iter_get_pages;
+			goto revert_iter_extract_pages;
 		}
 
 		sg_set_page(sg, pages[npages++], n, offset);
@@ -896,8 +905,10 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
 	*sgl = sg;
 	return npages;
 
-revert_iter_get_pages:
-	vhost_scsi_revert_map_iov_to_sgl(iter, *sgl, sg);
+revert_iter_extract_pages:
+	vhost_scsi_revert_map_iov_to_sgl(iter, *sgl, sg,
+					 is_prot ? cmd->tvc_prot_need_unpin :
+						   cmd->tvc_need_unpin);
 
 	iov_iter_revert(iter, bytes);
 	/*
@@ -907,7 +918,9 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
 	while (bytes) {
 		n = min_t(unsigned int, PAGE_SIZE - offset, bytes);
 
-		put_page(pages[npages++]);
+		if (is_prot ? cmd->tvc_prot_need_unpin : cmd->tvc_need_unpin)
+			unpin_user_page(pages[npages]);
+		npages++;
 		bytes -= n;
 		offset = 0;
 	}
@@ -983,6 +996,7 @@ vhost_scsi_copy_iov_to_sgl(struct vhost_scsi_cmd *cmd, struct iov_iter *iter,
 	}
 
 	cmd->copied_iov = 1;
+	cmd->tvc_need_unpin = 0;
 	return 0;
 
 err:
@@ -1007,11 +1021,17 @@ vhost_scsi_map_iov_to_sgl(struct vhost_scsi_cmd *cmd, struct iov_iter *iter,
 	struct scatterlist *sg = sg_table->sgl;
 	int ret;
 
+	if (is_prot)
+		cmd->tvc_prot_need_unpin = iov_iter_extract_will_pin(iter);
+	else
+		cmd->tvc_need_unpin = iov_iter_extract_will_pin(iter);
+
 	while (iov_iter_count(iter)) {
 		ret = vhost_scsi_map_to_sgl(cmd, iter, sg_table, &sg, is_prot);
 		if (ret < 0) {
 			vhost_scsi_revert_map_iov_to_sgl(iter, sg_table->sgl,
-							 sg);
+					sg, is_prot ? cmd->tvc_prot_need_unpin :
+						      cmd->tvc_need_unpin);
 			return ret;
 		}
 	}
@@ -1449,7 +1469,7 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 		/*
 		 * If T10_PI header + payload is present, setup prot_iter values
 		 * and recalculate data_iter for vhost_scsi_mapal() mapping to
-		 * host scatterlists via get_user_pages_fast().
+		 * host scatterlists via iov_iter_extract_pages().
 		 */
 		if (t10_pi) {
 			if (v_req_pi.pi_bytesout) {

base-commit: 1a577f9402c1780cc1e663f48d5dd54c02051b09
-- 
2.43.0

