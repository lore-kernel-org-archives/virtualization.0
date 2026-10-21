Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792572939;
	b=beMuYw8neE1Juh+XnRj0IFND3DprPpfbLCvTY+DflP1jB+XZJ5S4lk/ogP7owK21V1fn
	 Uvq9hTCZH4bkIrzncfHcti41X8fA4pBsTS/5liO2+K6Gbn9Sfk9ybFr+xKuQd1s7a+W8v
	 rGhlG4hGNcPDZ0fT9u/1tpgNB2QClKZTgECYV4xiUm9Lu6sRO+EQeWtMAaVdGjDrieME1
	 hLpxXtyNdd5Cpi6CBqx0a1zowvTtWMEaorrwhdf6r/wXVAeSUH7Ad9ddaySiAdG82xr5y
	 ShmYZLEq93ruhHM6w1PErUsNSACgz5p3LvwHK8Jd4bXheElRG+rCBTOFjFOkJVcV9Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZlzMMtlOMt0j7sxnZGkr7qkygcFA8MGAgcH9bAVX7Kk=;
	b=VnjzL+KmIXDeqUk5UihYdCXvbv2gExtsnEVLCcBPnVmB7YtEho20xMLLCO11n1aVZC2U
	 DPyGcNJ3NQgKd8GL+OCQH+IgxVmK8cD+1i1+DM9Cw8IHHUTQs2T5FlX576rLPeG5bzaOv
	 8L1HEr0pg4CtNzy/wc0KJ6WMLIV0JTJ03xLSLyhxkQd0Qa9q0OZfxIprOn/nVTv2y2xlE
	 3kYgo73xg3/8o2sAt7stoKAbkrjQ3dsgXB0VNGxjjzk3evCNgZCY4oVaeUhgWdn8mx1XU
	 P+30pDdnb5bAFYkrFeZ7olMzDWSE3i2VyzYwPFtpZsanKGqUk3owIpG5KyWa4iKnMfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="sdckCa/H";
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8355E606A319
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 08:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8355E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sdckCa/H
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ac677668a9so480960a91.2
        for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 01:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792572939; x=1793177739; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZlzMMtlOMt0j7sxnZGkr7qkygcFA8MGAgcH9bAVX7Kk=;
        b=sdckCa/Hj0KsFtcruYb2gqWpztsJxkRmxyU3Asa0nL8hwo1cevpcZIs0M58hu9Hf0u
         jwFe/QFyK7jDLqm5hRP96kGWiqPs+Sg2Mr08IM39HPHi9a6BpoAEMJEcyqKSRigobRJX
         LfHkbTmozwstYQ9NMaNHL09VRfz+7iFMnFvigfMaP7WJspbQuxnn4X4tiFAgOHNi69Ej
         Nvkdv1U/+Mj+T6AqHDUzUiXxilk0nslA7T78BLFIGkJsFHIzK/EYtSgYGg48/svzBkZv
         j0BvfqKOq0c7LrsUuQokNwObn5Tc50c7oAxFiNSx1/CsriNXzZN0mT3EY13P58qKStp7
         iJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792572939; x=1793177739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZlzMMtlOMt0j7sxnZGkr7qkygcFA8MGAgcH9bAVX7Kk=;
        b=lcAqfHedBZBPBeUVBoFPH7dik/9DLWGMUZPMtuuuyvMNrzcdapZ+tJRLecVMBSMGCq
         /uYwkLIfyOiHqgfiiwFQ7WYXJAe6XTsrtcdTyXJyF4zytcutFCJHF5zmbNW9IK28kDX7
         Z5dC1m36a2veCUGM98fYP3cn82ngm8E+b5k03mE2va3E6mCxetp8u15qrPDgaE7ryUnf
         Vzxi3MvvblayBl/IBf6o2KcHee1Ms2QmFTG0lpLB3iTA1qEzTOUQqU9oMyTSN+mxKe1O
         DYTpr5lDRweVMWKGOCDiyqGTqWiw/oRVol6UoW1WKskoxQZKRVGJ+Rbt87AJRB+o9dHu
         Qbkg==
X-Forwarded-Encrypted: i=1; AKwUvByVRAj+rX0JSOR7xFEdduXGjvyjITtk3m26h7Azzpt7ef2E4vrQ8mNTtyCIWCIS2YY7a7khYe1O5rNq5rLP+Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYIwlDzjldfYSyL0q4x69q0xq6827YiPA+dZrFPDwuHgzjivls9l
	CaIz9uuEdEv3uXS/+GEDmX3QYRAG+9Mn8fwBXJMgqIFo26MVgeB7lxb6
X-Gm-Gg: AYBFou2RaNqTTEW7UQNEBbmJue5mOaFxur5Pnbfq35Eo2YEQumTxFU8zNDqK+AqMQjs
	B+nj+WK1h5NAZHrVagFCRaO5DkJHWBmeIPYLBDUXBhruVwU+CsU2eX3vyb2/dsWXTmoPLBbso2d
	ZP4Hr7OKsl5PzOdDg8MV0ZNCmoTh35jXKDjEJsng9hfxWQygujrAcQzf6pfxS58HkoOWyt7yzGx
	8DqleNVA2swvcuEtRBYKoyHBgaK42k5Jn0aoB9bwBsFjekRoU72Mz0KH3CzBUZEw8unp0DNzDC9
	kuu7Jr+W2yPr/5VzlTCxxa2OgEOJkx9eefFTzSpBoN/7ZOiqVTiGS5WhyjQrAmxLSED3yfqmzEa
	wMvCtQmxzlqc7TzLRYt+yXqfti8rPtN9e+oK8IGIvVVH9JjImq4SlbYwEJJkLYNx6WEA+HqnPb3
	snVJEgIHK3pwD1PU5/q3oDBTRQZlwpc+YyedbQPXS8QWDooAtVga72X15Wrf2ozvOVysej5ZfSW
	8r5t7zjpcJj1KZ4SKoUm4XdcavsQ01+4R/c6N1HeeTCvbUUg8P+a1A=
X-Received: by 2002:a17:90b:2f8b:b0:3ad:6781:da66 with SMTP id 98e67ed59e1d1-3ad86c79915mr1116703a91.23.1792572938794;
        Wed, 21 Oct 2026 01:55:38 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad85f56b03sm1398207a91.3.2026.10.21.01.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:55:38 -0700 (PDT)
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
Subject: [PATCH] vhost-scsi: fix page reference leak in misaligned I/O fallback
Date: Wed, 21 Oct 2026 16:54:58 +0800
Message-Id: <20261021085458.196742-1-physicalmtea@gmail.com>
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

iov_iter_get_pages2() returns a byte count that excludes the offset
into the first page, but also returns a reference to that page in
pages[].

On the misaligned-I/O fallback,
vhost_scsi_revert_map_iov_to_sgl() puts pages already added to the SG
list.  The cleanup loop starts at pages[npages], but accounts for its
first page as PAGE_SIZE bytes rather than PAGE_SIZE - offset.  If the
remaining data starts at a non-zero offset, it can finish one page
early and leave a page reference behind.

Use PAGE_SIZE - offset for the first remaining page and clear offset
for later pages, as in the mapping loop.  Without this, each affected
request leaks one page reference.

Fixes: bca939d5bcd0 ("vhost-scsi: Dynamically allocate scatterlists")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
Testing:

- Four fileio vhost-scsi test instances repeatedly issued affected
  writes using recycled backing pages.  After about 1.33 million
  requests, MemAvailable fell from 5.3 GB to 13 MB and swap was nearly
  exhausted.

The affected fallback is reachable from guest-issued virtio-scsi I/O.

 drivers/vhost/scsi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 4f8c0260bc9e..b7e41c0a91d4 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -883,11 +883,16 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
 	vhost_scsi_revert_map_iov_to_sgl(iter, *sgl, sg);
 
 	iov_iter_revert(iter, bytes);
+	/*
+	 * pages[npages] is the first page not added to the SG list.  The
+	 * remaining data starts at offset in that page.
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
2.47.0
