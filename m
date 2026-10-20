Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520813;
	b=2OoO6Y/WoU8hGsvYJSNqOWVcKgVpAGRGT0MxO9qj8AzHOa2Vs+Y5e+kGESq8QOCATLE2
	 NHilB8jYij5oaa3bet/qHNxBlUJU2O3p5cT7D8eiBJC9wsRP06+dw3l/1KD3BzmTDzap9
	 Iq3wPhPdQZ4zk/tQLJtrySqBd6rxbcdL6/HbGuVRKMKBPfuywjZH8g4e9p0oABbHeZjQN
	 gfVKTRCCth3TN3R7LsLwYYix8Zyky/oOVrAT2BWkozWgqX7/BA4yZ6lt21zDKQJCITXPL
	 sAb8lVsYGTD6Dpa/g2nk1agGI3z/rp4MmNge6wdDx3GXx0IWfCsAJQvYU8psDrSargA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520813;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zzmCTlN2LKpQDlGX69irecctA25CCs8mwLmZ5GzVuOQ=;
	b=GzrtscCXaDsyeHTdIdqST8gXq3V+nmiC46Q1+A9xO3Wiq043htCNYOcR6mel+SMYomOl
	 euuiuYGeoLPdcYcJ93L6BsxODjJvdFjaYNYm/vrmx+whNFdRZIoKjSKe1lo/qhSNrq5yQ
	 KGvtZFFJWKEiDSLRuKdJFJ6BGeF9oGnby8wB5PyhbmEjCuleFgS5WMiqv/Gf6XhoyhY2q
	 GZfn7MKFIRmJ6aFNaVzs2FtBgODILoe3RaZLvwvMWQzXf3EJcmUZ/ep5mNDwFQAiXRZ9f
	 OyHYMqGTH3NhCPsBNgDbTXZx1mdtMqFAOpjQj0SRJkQXkCdT0OM9WGvgySypjfrCeKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ViA+Ytq3;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4095E606A31B
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 18:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4095E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ViA+Ytq3
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso5243392eec.0
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 11:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792520812; x=1793125612; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zzmCTlN2LKpQDlGX69irecctA25CCs8mwLmZ5GzVuOQ=;
        b=ViA+Ytq3XRdGUGsWUcaMEOZUk9G/nI1M8DNieY2GrYNWAfF9qcAo13TB3h/cbcnGeZ
         hjqFbuSAHxuUj3FiqB62QCdNQDJRMk9eqxygPi9C8O4Pcyz9RwwbyCDTew2yZvDxNqqk
         eUadKzH9UgSX4HgeY3AkJhz3a2sEZ+7pCaVe2Dloq3NEGvGhKOGKv8uLkQWtKyWSyAwk
         LPqpzQ2rIw1kUl3V86BDe7kIdStEPlLlaFsHvMShZfUbPzFNvZNvi1mgDIkqT2aTcxh0
         YcPyL9W5Tq78YZyWVSAWiGR+iCRjAVhsuVS8BYC6L+ggXYXjEbdbemKFpz9YUetFdxBo
         77UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792520812; x=1793125612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zzmCTlN2LKpQDlGX69irecctA25CCs8mwLmZ5GzVuOQ=;
        b=Q6abmB9JPe4JfAUXkrCw2WMmPNmsduE1JBzO+bE5MOIhTh3QZM/Zu3XxmwAhBr2ccI
         LN+mD354cb2EnffYkBVtf+u/hzKej5xKtUdFYlu+jhk2w7MdBfGWjjkMcO56Wi6tFE5V
         602VmsdJwkq4VchhBSm1cSd6RfBzXRaxbJmYKIBqo7cXNaiIkZOBgwsDf6j7W7zYgKrB
         AKQU6w335Ar9I12qHONZ6k2hgp9psMXxMqscmQuxzFdPv+lV8Ae7USHN6QktzZDVHcfm
         C+3CAcVN7urPkCQr1WzBHBPeuaErM0aDPGhoE/ryhqT39AYn5nPmA4/D0N5cboNNFaQp
         1InQ==
X-Forwarded-Encrypted: i=1; AKwUvBwZg7MVAiCyfjRz/C80YEM0EaKNlpV0P/9zXjBxHM7qzbZ/afZIT9uhDgWHUTYrXeKCC0xDeiCZZ+zm8kzl6Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYK33zpzm7xbWdP1/BlOecydBsDHJ6P8/ySOuUA201YxGkW1Mmh9
	kmJn7KWYhgK41KpSjKVW573VbG2NMGw6HJEOyOHh2ihFJV2tHjZL73gA
X-Gm-Gg: AYBFou3lWTnayNtNO2xcqDzIWk6yLdUVNrW7bi4kEa//1rteWq2V9pVM1xAjc41/xfw
	37II4WiIajhQ3fL68hX5WfmMrUlDEooWpASlIDqSAvk0SBANaZ59OhhTSY7WiGzV2b53EQrDka1
	N7v8Lj6jLGfTTl8plnrn6bZBpKCvoqaC/XfsOhuuPA0X2p/w7ZHp0Ykg9BZqy9IZTB1Mza/v4j1
	DYKKGzEDJMvqv99dFVY3GV0WGkuctxc99EzRuJ4zV1U4nCeUKRqvYn3exAaQd16T9YuqGpJxhJ3
	aB4kj6nks+u1StefBcaQRbBDnBDVLlFYsj67ohlKDBzHHE2JKCijSCRt2lqn6kHQI/OM4now1u5
	FvAn73Aval00UNpkvx08Sb3erIj8h9rZ63BsMz7pT7pgvWecy2VL0rm8jmY2tT2DKBkSo118Amj
	wfA0r6sX0/LxoPZReGe2sMWs0v3S9j2ZPkeyJt6j5e+trztc0oi0VavW3BWED0CBNPtyq49hczX
	3rtEa1oQuXvuffJSUGgzH5pE6TTQN64Zmm01b2LWVRlLj2ew7tH5NIhcPmP7ObOnsX0KnxY/WiS
	L0+xJNXg6Of5Wl7cEfOka8OpaQMvisge0xaDjgAX
X-Received: by 2002:a05:693c:87da:20b0:35e:9c54:d41b with SMTP id 5a478bee46e88-3674db4d065mr98253eec.21.1792520812113;
        Tue, 20 Oct 2026 11:26:52 -0700 (PDT)
Received: from LAPTOP-97G9G880.bbrouter ([106.51.148.253])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367411bd2a6sm549302eec.18.2026.10.20.11.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:26:51 -0700 (PDT)
From: Karthikeyan KS <karthiproffesional@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Mike Christie <michael.christie@oracle.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Hubbard <jhubbard@nvidia.com>
Cc: Karthikeyan KS <karthiproffesional@gmail.com>
Subject: [PATCH RESEND] vhost-scsi: use FOLL_PIN for DMA page pinning
Date: Tue, 20 Oct 2026 18:26:40 +0000
Message-ID: <20261020182640.2048506-1-karthiproffesional@gmail.com>
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

vhost_scsi_map_to_sgl() pins guest buffer pages via
iov_iter_get_pages2() (FOLL_GET), which does not prevent
copy-on-write or page migration while DMA is in flight. Switch to
iov_iter_extract_pages() (FOLL_PIN), which does.

Cc: Jason Wang <jasowangio@gmail.com>
Cc: Mike Christie <michael.christie@oracle.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: virtualization@lists.linux.dev
Signed-off-by: Karthikeyan KS <karthiproffesional@gmail.com>
---
 drivers/vhost/scsi.c | 49 ++++++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 7a1f39a327da..e14b4da4ea9c 100644
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
@@ -433,8 +435,13 @@ static void vhost_scsi_release_cmd_res(struct se_cmd *se_cmd)
 
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
@@ -443,8 +450,8 @@ static void vhost_scsi_release_cmd_res(struct se_cmd *se_cmd)
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
@@ -773,7 +780,8 @@ vhost_scsi_get_cmd(struct vhost_virtqueue *vq, u64 scsi_tag)
 
 static void vhost_scsi_revert_map_iov_to_sgl(struct iov_iter *iter,
 					     struct scatterlist *curr,
-					     struct scatterlist *end)
+					     struct scatterlist *end,
+					     bool need_unpin)
 {
 	size_t revert_bytes = 0;
 	struct page *page;
@@ -782,7 +790,8 @@ static void vhost_scsi_revert_map_iov_to_sgl(struct iov_iter *iter,
 		page = sg_page(curr);
 
 		if (page) {
-			put_page(page);
+			if (need_unpin)
+				unpin_user_page(page);
 			revert_bytes += curr->length;
 		}
 		/* Clear so we can re-use it for the copy path */
@@ -812,9 +821,9 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
 	size_t offset;
 	unsigned int n, npages = 0;
 
-	bytes = iov_iter_get_pages2(iter, pages, LONG_MAX,
-				VHOST_SCSI_PREALLOC_UPAGES, &offset);
-	/* No pages were pinned */
+	bytes = iov_iter_extract_pages(iter, &pages, LONG_MAX,
+				VHOST_SCSI_PREALLOC_UPAGES, 0, &offset);
+	/* No pages were extracted */
 	if (bytes <= 0)
 		return bytes < 0 ? bytes : -EFAULT;
 
@@ -837,7 +846,7 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
 		    cmd->tvc_sgl_count > BIO_MAX_VECS) {
 			WARN_ONCE(true,
 				  "vhost-scsi detected misaligned IO. Performance may be degraded.");
-			goto revert_iter_get_pages;
+			goto revert_iter_extract_pages;
 		}
 
 		sg_set_page(sg, pages[npages++], n, offset);
@@ -849,14 +858,17 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
 	*sgl = sg;
 	return npages;
 
-revert_iter_get_pages:
-	vhost_scsi_revert_map_iov_to_sgl(iter, *sgl, sg);
+revert_iter_extract_pages:
+	vhost_scsi_revert_map_iov_to_sgl(iter, *sgl, sg,
+			is_prot ? cmd->tvc_prot_need_unpin : cmd->tvc_need_unpin);
 
 	iov_iter_revert(iter, bytes);
 	while (bytes) {
 		n = min_t(unsigned int, PAGE_SIZE, bytes);
 
-		put_page(pages[npages++]);
+		if (is_prot ? cmd->tvc_prot_need_unpin : cmd->tvc_need_unpin)
+			unpin_user_page(pages[npages]);
+		npages++;
 		bytes -= n;
 	}
 
@@ -926,6 +938,7 @@ vhost_scsi_copy_iov_to_sgl(struct vhost_scsi_cmd *cmd, struct iov_iter *iter,
 	}
 
 	cmd->copied_iov = 1;
+	cmd->tvc_need_unpin = 0;
 	return 0;
 
 err:
@@ -950,11 +963,17 @@ vhost_scsi_map_iov_to_sgl(struct vhost_scsi_cmd *cmd, struct iov_iter *iter,
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
@@ -1392,7 +1411,7 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 		/*
 		 * If T10_PI header + payload is present, setup prot_iter values
 		 * and recalculate data_iter for vhost_scsi_mapal() mapping to
-		 * host scatterlists via get_user_pages_fast().
+		 * host scatterlists via iov_iter_extract_pages().
 		 */
 		if (t10_pi) {
 			if (v_req_pi.pi_bytesout) {
-- 
2.43.0

