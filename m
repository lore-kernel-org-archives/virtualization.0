Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DE6C433F5
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 15:48:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6707F80B80;
	Tue, 22 Feb 2022 15:48:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5_z4qyPHz1wr; Tue, 22 Feb 2022 15:48:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 16FB180B38;
	Tue, 22 Feb 2022 15:48:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0A05C0021;
	Tue, 22 Feb 2022 15:48:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 834C4C0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 15:48:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 72B6460EF9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 15:48:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o8nZAu5GwxJs
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 15:48:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E850E60EF4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 15:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=eJIsOb+w5CZcMt9B/oMf41HlBDbj/fZfDaQTBaIcUT8=; b=VfiTpnF7MwBzjSYQ+ZXutVaslD
 kscB2K42rXeZXsiwqGVNRvVp2Ax3dvBxD4WomLO4yKcJrbSfmoeYkzSCTxjmRmu4GZ+1Y/S8kihme
 ariz/qeqwM+FRvyeNIe2oNfQZuHmODuRGtTGWHULyfE7p8w/dKpB0/4bQaeXBYSiLIBY47yU8veub
 yG1TbKDZ3oDb75tPusCETi/DbGuFYCYP/HF2g16zXHzp97llfdgggceceK+OJvmvkhLKJHLWZNKzV
 J/mkQFYNNLbQyV9MMjei9b6EW2F0IdYcsHQx/WLYeDLxE2Ubmwig1ZmtqhYZito4AGLlMk8nptrif
 MRgj3ypA==;
Received: from [2001:4bb8:198:f8fc:c22a:ebfc:be8d:63c2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMXPF-00AOdd-0p; Tue, 22 Feb 2022 15:48:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: jasowang@redhat.com
Subject: [PATCH] vhost: use bvec_kmap_local in {get,put}u16_iotlb
Date: Tue, 22 Feb 2022 16:48:47 +0100
Message-Id: <20220222154847.597414-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Using local kmaps slightly reduces the chances to stray writes, and
the bvec interface cleans up the code a little bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/vhost/vringh.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 14e2043d76852..0f22a83fd09af 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1173,7 +1173,7 @@ static inline int getu16_iotlb(const struct vringh *vrh,
 			       u16 *val, const __virtio16 *p)
 {
 	struct bio_vec iov;
-	void *kaddr, *from;
+	void *kaddr;
 	int ret;
 
 	/* Atomic read is needed for getu16 */
@@ -1182,10 +1182,9 @@ static inline int getu16_iotlb(const struct vringh *vrh,
 	if (ret < 0)
 		return ret;
 
-	kaddr = kmap_atomic(iov.bv_page);
-	from = kaddr + iov.bv_offset;
-	*val = vringh16_to_cpu(vrh, READ_ONCE(*(__virtio16 *)from));
-	kunmap_atomic(kaddr);
+	kaddr = bvec_kmap_local(&iov);
+	*val = vringh16_to_cpu(vrh, READ_ONCE(*(__virtio16 *)kaddr));
+	kunmap_local(kaddr);
 
 	return 0;
 }
@@ -1194,7 +1193,7 @@ static inline int putu16_iotlb(const struct vringh *vrh,
 			       __virtio16 *p, u16 val)
 {
 	struct bio_vec iov;
-	void *kaddr, *to;
+	void *kaddr;
 	int ret;
 
 	/* Atomic write is needed for putu16 */
@@ -1203,10 +1202,9 @@ static inline int putu16_iotlb(const struct vringh *vrh,
 	if (ret < 0)
 		return ret;
 
-	kaddr = kmap_atomic(iov.bv_page);
-	to = kaddr + iov.bv_offset;
-	WRITE_ONCE(*(__virtio16 *)to, cpu_to_vringh16(vrh, val));
-	kunmap_atomic(kaddr);
+	kaddr = bvec_kmap_local(&iov);
+	WRITE_ONCE(*(__virtio16 *)kaddr, cpu_to_vringh16(vrh, val));
+	kunmap_local(kaddr);
 
 	return 0;
 }
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
