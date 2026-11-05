Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793864874;
	b=XtYeP1apgFjR9O7n5xybEQZ1YG66giVPmAH243E/sU5rCDfBxHr9bGbsUZMJrrtlFCt0
	 MPk0rU7th6uqoClEEJrNJYiVV9SJXuH+szPTFafYNHX+0XC5QJasdlf+OpYjOFxMPMCZT
	 RKSMYCWZvEmA6ERqeSsg/Wa2EhUGyEVB41AHysMbrAzyjlWhXCR2tkOXcPezVe6iKLE1D
	 7tysnpWW6UGHa3e1l8T6TLt/Ntj76ZzqhPnq/UD3G4gQgZIv/QGsD+xlr8hDogsZMZubK
	 NL4UnlnSdNFnsCyy0khHRtwa9JZ5WxPXV3BWEbqVYdstVLhgOb3iHsMUunGdFDpwWhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793864874;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DrbFdPeJVGFrc8E9XpDNvFLxAqYYBIIEWSforRQNQpY=;
	b=PW282/lwWIkIokfOTUolo16lk0V5k/K5847c5tqsaFwLZp8zB58PEJbpcqBtmpEGFG+Y
	 QBdsSeoeVF7q5ZisQ1c9vEz+9tdvFhxHSFfjKDb48VqcBx/Ov+d9oeJWMApyVGAHdQtny
	 5yQ1SBm2dvAwofisAgSs7XMZP+teXOvecswAG7kd+QhobpohU3ASRLo0d3d2HJxK9qB68
	 fc+5fuCcp55TvV+A0RbwLdPEGv0JMYJZesthsWeNjPrTGwrBk2wF9bnxZ7NdYBbilWhAU
	 x0V31NqJ/u5Ki6erD5nt4eJPx/IvvkoZ8tU/0ZN6brPDxfp6ZCnMRgKLMBIubAKdRug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b="dm/gVz9N";
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D679606A335
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 07:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D679606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=dm/gVz9N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=dm/gVz9Nf120tAe8MlhWS5EjwwciKc2WiFf+0ZxgTAOI8ruwb6vnDkc0y45EJ9i2kaeBgayBx0luq
	 Xvw6CN7YpAeCcadCTiSPKWTlPCT0Q/JRLDNg8ieeKjZyqq+o0JknCSsOdUXymxaTN8hAxAPPJdmTZQ
	 JckOrFpMjiB8zpjI=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16aec34a35e0-806fc;
	Thu, 05 Nov 2026 15:47:50 +0800 (CST)
X-RM-TRANSID:2ee16aec34a35e0-806fc
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHB-W5100250 (unknown[36.137.216.21])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56aec349f2f9-40b47;
	Thu, 05 Nov 2026 15:47:50 +0800 (CST)
X-RM-TRANSID:2ee56aec349f2f9-40b47
From: Gu Bin <gubin@cmss.chinamobile.com>
To: mst@redhat.com
Cc: jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/virtio/virtio_test: advance next_reset by reset_n, not completed
Date: Thu,  5 Nov 2026 15:47:40 +0800
Message-ID: <20261105074741.2177-1-gubin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
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

run_test() arms the next device reset with

	while (completed > next_reset)
		next_reset += completed;

next_reset starts at reset_n, but each rearm advances the threshold by
the absolute completion count instead of the configured interval, so
the reset cadence stretches after every reset: with reset_n == 16 the
resets fire at completions 17, 34, 68, 136, ... instead of every 16
completions, and only a handful of resets happen over the whole run.

Advance next_reset by reset_n so resets stay evenly spaced, matching
the --reset=<n> option meaning.

Fixes: 264ee5aa81ec ("tools/virtio: Add --reset")
Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>
---
 tools/virtio/virtio_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 028f54e6854a..b8deca893f12 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -250,7 +250,7 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
 
 				started = completed;
 				while (completed > next_reset)
-					next_reset += completed;
+					next_reset += reset_n;
 			}
 		} while (r == 0);
 		if (completed == completed_before && started == started_before)
-- 
2.55.0.windows.3



