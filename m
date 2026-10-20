Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493711;
	b=q0B755iKKeGJ7BBnjh80InE2kfu8ehumFHYEpXGhQn7EX7vMECBLVMv5OW8zy+AC++Ny
	 sZpT3B25GRgg0fbAQo96UqElnE0PxTM8lml2uT5ZbUszubWUeeo2oMQVeOnUWPXrJajeH
	 QvOTh7MRAyp3lB53z7sA7LI3gi0HfCxq4EVZ2er5NQSWAYjCBq2uvM5vXWk1gYACkrgOt
	 +aRjjrH9dliJGcWY5FdHLKFmPJc44yneASs5Kytv2MwoFleuyivrdRnnb3nzTnHasFuGk
	 J0qkeTR/1q+CO+gHK230kzrM5ossW5XXt2RfPMzPKpIMoUdaQ/ew+rUNy1TmSkqLfcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493711;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=IstVKehuob5ZIhaaqjFytiIbVJXifuNQQEI4PdRRqKY=;
	b=eFmibCEpEv8X9J1hK8kPx18r0e10/uL2uRjiaf3uZUuarGvIqq+2O4Gp5nmV2R5vBL6Y
	 YFCSfms7b3eU2gmiltER7T0WNI08Uo7xnXa5VKFu92Pn80N5M5rwIBfX+0ffwlQyKn0i1
	 X0zbqulGO1fTnv7lITfHl2p4RiWf27wkNjr4KSXHZaH37swTTzAsxd0bleISRW4IOXKlD
	 ZCibrzSRB6V4QqF50AQixwH4DJu8BoXKbIFBIUY5LkKSqWI/Jva3IJ6UP8q2Db1YfSx5B
	 pRdVPLlT0wr7+NoNoE20ZLOlYjl68FtpGo8xCQ1cEwcl5JZLMlcOeJ++Ej5bRvKkhmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=octane.security;
	spf=pass smtp.mailfrom=octane.security;
	dkim=pass header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=OMDdE19j;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EBB606A31D
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 10:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7EBB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octane.security
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=OMDdE19j
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so6501754eec.0
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 03:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=octane.security; s=google; t=1792493710; x=1793098510; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IstVKehuob5ZIhaaqjFytiIbVJXifuNQQEI4PdRRqKY=;
        b=OMDdE19jzXP7Rd/vnEXAz1Zm06g6xZIfJgHzZfxeg4cHO9SZ0Rwxhch8wPkeZGYFSz
         o8A/SO6neNdL1CL+ZQs31ZxNye19iYqlJ4FpHUVSIFMDh8mr+J67hhy4UJSirKt9K2Oh
         tC3QfmbKqJYvOZQT1PMgVWE0FkdElwG/nnegyV8EYm1riFH1vpWYYe+RKzoHq37EzVZj
         JX2Qo1AeY8ZqPlHEmE8+2fqF977PgQG7bnSKsPMOqD+W5XxMStr1bEU4vw3oVrVATOAc
         OqRK7bfOay0KTNTnkprPT19IqAqYQNOmYZ+z6dgKEXy6jFqfuj6WOfgMu8N9cHMOLLQe
         jw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493710; x=1793098510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IstVKehuob5ZIhaaqjFytiIbVJXifuNQQEI4PdRRqKY=;
        b=dfuCMgcFoWwZiZRnePiYO2cE9lXaYE9PiwRJx3e5xFXAYQfS9Snt2zME/+cibEdXAj
         R6lgbqlr0ffL2h8G1tIPQwTromp83f7iuPTa1IBVbitehMXNDWtp1Ua6MWzajFvq27cj
         p+zYP3SgQk135RloUssD7S5mmO5uV/mDzLUS9n2i7dcyDaBRH8y1fJzl/ueXmdVQShUC
         aQ6oBai6F54x6i6HcDgaBV3xDmEaudm1gHjZ+ipCoXIpghEqxNUrdsH8FAw+4G7tTt5g
         WfFnGnrsDY+ueTOnFa++IE1VeYLRFZAotSrS1ee4ZSDwfz1Z3W27SDwc0q3POKZfWN58
         7s0A==
X-Gm-Message-State: AFq9FYIkRGC9sQD2opyJopzon0BnlGdNw+CgcmLkXNBICwLlkQZH/qeo
	fHSv4vMP55p46FzJRuxedEUlpfmRkgLXSKEZQMgrLaquEURSfbgwtRInTZppZTmHe4xf1OLln/o
	Vzi3W
X-Gm-Gg: AYBFou0kr89rHcNeIlI6kGXNdrehLTw6cCQ3oZrwElks+GBeNfo4WXwGJKm3oToQB2O
	iHrT7eN3fbiwNYUfkEfv4U25K8G0aizdA0uGbUrV1/iM+NukfF9I/3r/4Ce5IOMEPxpkAyBR/bW
	JdaivuJAlIF6zYj1o3YDRlj7gb+T/2CHmXv8uo7h8ZbJrxWFx0+v1Y+7u1+bbAR/MkXDxOK/CTM
	PXxjvAGz4Qz2hS1IXOE0Ko45Sapat3Uf+wEmPrDOztUyZBiGInWw/j9tX1a5RkS2CcAlg7d1k9W
	u/Fy9UxN97dfYww9NUjRpn4R4xxaIuNDKOjqWx1d3hJZ3B+4wc4OZhGyq8yH6xi9fFHRRFi0Fsx
	CShgV1txTnJtUuXtWV0Un1le5ww1A27afnoAQq2g51gE88fTiUUz/5rr3fYUWgqHifcXmtQA45w
	RjCMPET32kNSsVXLqXX9sOcX85Uz8V+AinAQNUbvYpriUyaFdp4BuVOm1d7NXDgIS49IKiaqDyR
	ZibPrMvAb2MIw9QQ8oEeJCKbV4nENwVbt9LUUd69Js6iRHw5UJzIEaJ9P7hswZglRM9I469xqJS
	ia8zISwCVuSUH/h+X+nMeItP398B9g==
X-Received: by 2002:a05:701b:4550:10b0:150:1cea:31a8 with SMTP id a92af1059eb24-185125790a4mr14974157c88.19.1792493709497;
        Tue, 20 Oct 2026 03:55:09 -0700 (PDT)
Received: from localhost.localdomain ([103.207.175.177])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360826875b3sm42255592eec.21.2026.10.20.03.55.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 03:55:09 -0700 (PDT)
From: Shubham Antil <shubham@octane.security>
To: virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Mike Christie <michael.christie@oracle.com>,
	gio@octane.security,
	stable@vger.kernel.org
Subject: [PATCH v3] vhost-scsi: zero misaligned I/O bounce pages
Date: Tue, 20 Oct 2026 16:25:03 +0530
Message-ID: <20261020105503.75904-1-shubham@octane.security>
X-Mailer: git-send-email 2.54.0
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

The misaligned I/O fallback copies the full bounce scatterlist to the
request buffer during completion.  If a data-in command transfers less
than requested, part of a newly allocated bounce page can remain unwritten.

Allocate bounce pages with __GFP_ZERO so all bytes copied during completion
have a defined value.  This path is already the slow fallback for
misaligned I/O, so the added initialization cost is acceptable.

Found during an LLM-assisted source audit and validated with a QEMU/KVM
vhost-scsi target using misaligned data-in commands.

Fixes: 5ced58bfa132 ("vhost-scsi: Fix alignment handling with windows")
Cc: stable@vger.kernel.org
Assisted-by: LLM (OpenAI Codex, gpt-5.6-sol)
Signed-off-by: Shubham Antil <shubham@octane.security>
---
Changes in v3:
- Restore allocation-time zeroing after review confirmed that this is an
  already slow and uncommon bounce-buffer fallback.
- Keep the change minimal and document why the zeroing is required.
- Drop the transfer-length copy-back change from v2.
- Add the discovery method and the requested Fixes, stable Cc, Assisted-by,
  and Signed-off-by tags.

 drivers/vhost/scsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 885fac5ed042..8493a372de6c 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -937,7 +937,12 @@ vhost_scsi_copy_iov_to_sgl(struct vhost_scsi_cmd *cmd, struct iov_iter *iter,
 	}
 
 	for_each_sgtable_sg(sg_table, sg, i) {
-		page = alloc_page(GFP_KERNEL);
+		/*
+		 * Completion copies the full bounce buffer, including bytes the
+		 * target did not write. This is already the slow fallback for
+		 * misaligned I/O, so zeroing is acceptable here.
+		 */
+		page = alloc_page(GFP_KERNEL | __GFP_ZERO);
 		if (!page) {
 			ret = -ENOMEM;
 			goto err;

base-commit: c69023b5e16e5ffe9368603dca76d85bd544ee57
-- 
2.43.0

