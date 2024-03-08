Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C403D224EC
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Mar 2024 01:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709860349; cv=none; b=uwdFk8FHuZXMNmhzH6Sg5e1R2g3C7SR31PYtMkHjsDVSP4mXygmH67Dk6bNF2s75nVRaZ8OWYsy8ZueJqtFP52vEju/vB9NGnJF4N95qyNOXXuDqYT13fqL/5saTxdkuAiZoGJDbITn5eP1FxAEP0hFHRB7mbMzG2xLmaRhYW6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709860349; c=relaxed/simple;
	bh=sA5YotOtX3AcvjjrYf5fHrYUORIzots7hTq07UQbKVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F0rNfjc18tbV5ZNdviqsEygUBTShsViyxwJKc3XhwOLf0MXNbkKB6cHplJewWeEU4xNzcW9VnFTCj89AOuyKAM3uEp2aD+RJB4ykvVMEPJ1fu9w4H9rbX1eXByPneKQ4ir2AYoTuzW0XGTF7lLWd1HgrZgei7oWlUk7Og9Ek4Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaDjMbxn; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaDjMbxn"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6AA1C82B9F
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Mar 2024 01:12:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r57el3kX884k
	for <virtualization@lists.linux-foundation.org>;
	Fri,  8 Mar 2024 01:12:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com; envelope-from=dreaming.about.electric.sheep@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3422482B84
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3422482B84
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LaDjMbxn
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3422482B84
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Mar 2024 01:12:27 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-33e709ea80fso456298f8f.1
        for <virtualization@lists.linux-foundation.org>; Thu, 07 Mar 2024 17:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709860345; x=1710465145; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Owx6jt72g5QT/V0uQHGstO9uCqzU46h0v31gh/DzxSw=;
        b=LaDjMbxnqzAOBGTlKWWEF7b90ecLrVg5CRG3gtHkzIMPaXrvuK4ZjywDPEjijRH4Ja
         5v2TvZ7/KmQFi0tXj8AvPMKmDRXQQeGdhGHxuKUBBor9xbjz0+wwKAUr38iCyV79n2Ns
         LkjhDPn5/ux+5CNlsg7iqd+pPGWdDPRroKVeE61VqzBiKKL6sjBbM/9BhZ7hhHIF7aTi
         VAQXP5LlNvh9ocHcjU+uo6RyeQaQj1FxaJtWZuDlTbDQSpjWDG8jLzTDoKpCTUfp3l3U
         4FP4tQEBw4CE9+FPN+HT6oDnNG/ZRO/0ioEwKaUriAf/GTncmlk3sy7ThbJSBRmaBOGA
         G8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709860345; x=1710465145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Owx6jt72g5QT/V0uQHGstO9uCqzU46h0v31gh/DzxSw=;
        b=ofLv6Zx7KksQoDYzpDVArXK6w+IBqn929a5AEWVetEGJOt7h6fWyR10Z3DPsuftBGq
         n3dJ6oaGpCggTJv5qzS10g0RlYm0uvANB2eWJQTgm0uM3C6yJEJfjVfC50KYSufzjqg+
         FRc/UTks30GVm8owaqHecuCI5owMXw0Q3J9gA9F6fFctg+lws5r3c/SmwQlcaJ4d5oUU
         6XwxsOCRmUuQFVxjWdwubhEp1tzhnhTdIS+Einfk/KciwJSy4wHGhkxr8+7pkqTXUVvw
         nk3w9J8i4aiSDEK4H1pPdVqb8W8Cl36gxmy9WotHbmmTPRv1nuxR/JITHzRb6NIdl9sc
         Z5ag==
X-Forwarded-Encrypted: i=1; AJvYcCVJHqxSjaWzCblleqG9PedRCS5PKdzP+DkaxHIQfn+HCi0xZUaJkesmYnm8+ThTK9jw5ysM3tMo4SIwHH0vH5hx8+fM/o/5m78m5dUPexuj+SL5z9JltaFWSw==
X-Gm-Message-State: AOJu0YwimjYn3q+JpUNJg9H14P0WD1Xv281+uFBZueZFS7IpEWBRACDy
	hZGrUCyy9ChJ14sonLItK+miYFVAanF51J81v5YruM+3Jt84k5SW
X-Google-Smtp-Source: AGHT+IGyFK85fLcK62sC298qj//c9CgMsC5e3P8Va0z/mRDqMFtCe0XGX8iOSmZnzWnJeMlfMP112A==
X-Received: by 2002:a5d:554d:0:b0:33e:6760:6def with SMTP id g13-20020a5d554d000000b0033e67606defmr2195331wrw.56.1709860344707;
        Thu, 07 Mar 2024 17:12:24 -0800 (PST)
Received: from localhost (ec2-18-169-47-158.eu-west-2.compute.amazonaws.com. [18.169.47.158])
        by smtp.gmail.com with ESMTPSA id f14-20020a5d50ce000000b0033b66c2d61esm21450770wrt.48.2024.03.07.17.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 17:12:24 -0800 (PST)
From: Alex Constantino <dreaming.about.electric.sheep@gmail.com>
To: regressions@leemhuis.info
Cc: 1054514@bugs.debian.org,
	airlied@redhat.com,
	carnil@debian.org,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	kraxel@redhat.com,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	timo.lindfors@iki.fi,
	tzimmermann@suse.de,
	virtualization@lists.linux-foundation.org,
	Alex Constantino <dreaming.about.electric.sheep@gmail.com>
Subject: [PATCH 1/1] drm/qxl: fixes qxl_fence_wait
Date: Fri,  8 Mar 2024 01:08:51 +0000
Message-Id: <20240308010851.17104-2-dreaming.about.electric.sheep@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240308010851.17104-1-dreaming.about.electric.sheep@gmail.com>
References: <fb0fda6a-3750-4e1b-893f-97a3e402b9af@leemhuis.info>
 <20240308010851.17104-1-dreaming.about.electric.sheep@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix OOM scenario by doing multiple notifications to the OOM handler through
a busy wait logic.
Changes from commit 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait") would
result in a '[TTM] Buffer eviction failed' exception whenever it reached a
timeout.

Fixes: 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait")
Link: https://lore.kernel.org/regressions/fb0fda6a-3750-4e1b-893f-97a3e402b9af@leemhuis.info
Reported-by: Timo Lindfors <timo.lindfors@iki.fi>
Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1054514
Signed-off-by: Alex Constantino <dreaming.about.electric.sheep@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_release.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 368d26da0d6a..51c22e7f9647 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -20,8 +20,6 @@
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include <linux/delay.h>
-
 #include <trace/events/dma_fence.h>
 
 #include "qxl_drv.h"
@@ -59,14 +57,24 @@ static long qxl_fence_wait(struct dma_fence *fence, bool intr,
 {
 	struct qxl_device *qdev;
 	unsigned long cur, end = jiffies + timeout;
+	signed long iterations = 1;
+	signed long timeout_fraction = timeout;
 
 	qdev = container_of(fence->lock, struct qxl_device, release_lock);
 
-	if (!wait_event_timeout(qdev->release_event,
+	// using HZ as a factor since it is used in ttm_bo_wait_ctx too
+	if (timeout_fraction > HZ) {
+		iterations = timeout_fraction / HZ;
+		timeout_fraction = HZ;
+	}
+	for (int i = 0; i < iterations; i++) {
+		if (wait_event_timeout(
+				qdev->release_event,
 				(dma_fence_is_signaled(fence) ||
-				 (qxl_io_notify_oom(qdev), 0)),
-				timeout))
-		return 0;
+					(qxl_io_notify_oom(qdev), 0)),
+				timeout_fraction))
+			break;
+	}
 
 	cur = jiffies;
 	if (time_after(cur, end))
-- 
2.39.2

