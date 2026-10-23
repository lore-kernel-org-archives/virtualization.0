Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792752043;
	b=EndUbR7u71+wRHRCT7kIhpB2DfxpgG97anarBVq52cGrpA+byrdKSMe3vzX/JHSaWbZE
	 iVSzcj9EnmZkUIvGC70GxruQx6324fd5410kaqDkEpTYk/VuKj/9IxMb/DBmMCSty3GoZ
	 gvn/ulm6hQ2q4+HpU1X55QyzD98900/sbvFCFzcd4afgUTMKbkXn9d0cG2sAnSUJ3HA2P
	 CF6JHPN0gRaZ9zZZgWWX6ub5nxZvAYcqwyAjAzoXgjDIheoHaE3amEOZnEmfRcM8cawa7
	 YoNPiD95+oTT6WtsL2dcANgE3sf8oSsSS1buBfbVNp5FnNiummAIgyfxd8kvmljGC2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792752043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3fn/qeSOMh17ArAGKi+SkWfmCErKg3ju5QLNHCwzqmI=;
	b=l2ejreKNV+RGp0txMaGn9TbmU8zhAHb4Mjb0oNRQiYZunp4+rX4R/JfbznBygKmyT3b6
	 0UZqOZNpsHWgxoyWvvtzeAvrd84Ea02xgJJ40XYdV8CyZGGqTS/LDEWDKyQ6p/14WhEDN
	 /wvANwn28jAQSFP3u2oezTFzEwL0Vul87/bGnEcDiOHIVqIXb+l53CIYrXSxd4zf0qrJJ
	 R+LhnWkjF1VXzHLJa/zZRNwaMS4GV52DjA37sMlXfYmhn8Eo8JRZVNUQ61HHC6oqs8nX7
	 2XpGGHG43vvNVv7bY78Cxd9S16VR/piNEwyhmJwDVAIINyFjqqKMhkKKuwrTtnKAcwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Sp+vwKRN;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0347606A31D
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 10:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0347606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Sp+vwKRN
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so294179a12.0
        for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 03:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792752042; x=1793356842; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3fn/qeSOMh17ArAGKi+SkWfmCErKg3ju5QLNHCwzqmI=;
        b=Sp+vwKRN55Lrw80uMyS2PmozCJXQjWUjajxWZv5niOcgfKPIIbmWn+4b1UjaFhf3O/
         4PTWP2jdEHUOpy6kOe1UUiZ5OyLdQohY81Y3Amf/5LXygnWfDz6ykojK3wcm55LNgwkg
         HTXaKGJz7XZiU4FIhtgU9C7G3EeNvlcx1k0MYlSf8jYMavF4f0i8ZWFoV1lXvi4T4Wjt
         sxtWL2B615siOny2CAe0m75NjE8p/3xmtJ/c0Cu9saVm4B8MQoKXoioOFMWZk3+46Pc7
         k+2Ckv0qWTTC0B7k7aNWlDwE8B1BuJ2F2yAjrVYF1BNY0YnufoLnjvnBJWFsbVfL8gIF
         BTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792752042; x=1793356842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3fn/qeSOMh17ArAGKi+SkWfmCErKg3ju5QLNHCwzqmI=;
        b=D64NmJ444i5ow9cFYUSQuQ83fDR/nkAb6B/8EOKOWIYOxrP6NOdfMhn6TOZBBqQfkO
         na4G+OOlVmjKsrOxWxT+zvTNL7GOPJ2fdTpWVyWh12CbE6ligeH8Kjgz4/R/8g9/JaK7
         V0Lz5IZsfe4PhGrgGA85igu9y33WGi4n1itxcEyEXhWGzjCzVAIiA86JsSy1kGBUFLm7
         JNRANewl7W8SIg2Mw6FZ3J6U8tzutv9KzLMGzhalta343NZ6PdmpeH9MyYy3kqlIqVU+
         rZRs9YqiKl/rvc7NsQKWsSavUp8qmU8AD8FLfJ4wIgdVZJt2nYRKxZVEfe4rzqzYhKF+
         7lRA==
X-Forwarded-Encrypted: i=1; AKwUvBxwBcUY9vkwYGqAMJRdyw6EEcImz0gPjJnQN50ncoiOWtpkHlqo1+ZNrtH5d1DRix/FpD2ArSQvDB+rUHW35g==@lists.linux.dev
X-Gm-Message-State: AFq9FYLnuEOuwdlEz5Cj89e5nxtw4No5hHJvTGGKp0IpZgb/swj/CD6t
	FawZ+vcIYxlmXYI2sjxygdKzCsP0jM6ttcdiKMy3SbLkfWFIDVCvxcvd23VFA2Ma
X-Gm-Gg: AYBFou0q47DohcM3aE2FJkws6PvQnkVAK5YT7a7D36rW6QSb0M851FT26FKY6pTrcgw
	KMPWxyMcii/MFwB7TZcDBFarsFow1+TRDuetzItyeuVXWg3SD4fqNUwDGlnTUVNVtf/qA1T+ln+
	UQvUNEWdgrbA8XIEu/QAAhO27NDUO4mdwMDY/g0iAXqGJOErQt4eRAUd2Z4PrXv9jqxwNuzNF4J
	0Xr3C20ZEE1nRhF+Q9iPXSzaCr1XP4PCPIbE3UBl7UDHTezoIvqovlhXj19vO9b7ZYQFZ7rfp+S
	liagVEiWnyiO0GmplAe9ljxXGmeUqe5ArW53chK8TotNeGEZGpGpYhmc3nYROjEJ35WqCCwXy8l
	OqBVNkBmOO2HLk3w30ewY75cvounNJOjhFVpy/yuJPv7Uits57iCEYCvJB40e4Tmh3PcAsB/5L7
	6qwK7R4E/SRsCm0PXlu78ycQ8lgEfLNH+Qnvn7FFHitmRZp01UK7UgIO1yCLEYzQ1T4UeUUXXY1
	XMdbmckaN79qNsnzCcHNJFLGbhIOoYWB9JYPh/IQXUjO7ildPbcPjWIcQ==
X-Received: by 2002:a17:90b:2543:b0:3ac:b08a:ed2c with SMTP id 98e67ed59e1d1-3adce08327fmr1475446a91.40.1792752041791;
        Fri, 23 Oct 2026 03:40:41 -0700 (PDT)
Received: from gmail.com ([185.220.236.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adcb1b133dsm3300636a91.7.2026.10.23.03.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:40:41 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] vhost-scsi: fix page reference leak in misaligned I/O fallback
Date: Fri, 23 Oct 2026 18:40:35 +0800
Message-Id: <20261023104035.6686-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
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

iov_iter_get_pages2() returns a byte count that excludes the offset into
the first page, but also returns a reference to that page in pages[].

On the misaligned-I/O fallback, vhost_scsi_revert_map_iov_to_sgl() puts
pages already added to the SG list. The cleanup loop starts at
pages[npages], but accounts for its first page as PAGE_SIZE bytes
rather than PAGE_SIZE - offset. If the remaining data starts at a
non-zero offset, it can finish one page early and leave a page reference
behind.

Use PAGE_SIZE - offset for the first remaining page and clear offset for
later pages, as in the mapping loop. Without this, each affected request
leaks one page reference.

Fixes: bca939d5bcd0 ("vhost-scsi: Dynamically allocate scatterlists")
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
Testing:

- Four fileio vhost-scsi test instances repeatedly issued affected writes
  using recycled backing pages. After about 1.33 million requests,
  MemAvailable fell from 5.3 GB to 13 MB and swap was nearly exhausted.

The affected fallback is reachable from guest-issued virtio-scsi I/O.

 drivers/vhost/scsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 4f8c0260bc9e..b0a536fbc69a 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -883,11 +883,16 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
 	vhost_scsi_revert_map_iov_to_sgl(iter, *sgl, sg);
 
 	iov_iter_revert(iter, bytes);
+	/*
+	 * pages[npages] is the first page not added to the SG list.
+	 * The remaining data starts at offset in that page.
+	 */
 	while (bytes) {
-		n = min_t(unsigned int, PAGE_SIZE, bytes);
+		n = min_t(unsigned int, PAGE_SIZE - offset, bytes);
 
 		put_page(pages[npages++]);
 		bytes -= n;
+		offset = 0;
 	}
 
 	return -EINVAL;
-- 
2.34.1
