Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A06D3BFE4A
	for <virtualization@lists.linux.dev>; Thu, 18 Jun 2026 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781776687; cv=none; b=tYNiT96X2ZiMtDyJMgFhk3vbglvw1s9Y1Kes3DyogtPHgvTVtnSgrqxw8pQwqBtvxNDBixSvXxMGdbh/O2oxO99rNgL0ElC2agnWvxCRvMwT1z0/we/0mtU0qKJXE1pKrfs/O1xjag8tehyKwyQBg9Vy7EhAczXRZW7pya6/O8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781776687; c=relaxed/simple;
	bh=62t1laBwNgZHF8RwIKtZBtLPqAx+i0NptKBCgWZPxYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbDMn/Dq6+cZP4eDCFOxMhNjCJ7wJDn551XY53KXnSStWsNuE8239D6b1DJSiYKdSiMjRNjxGZCj6tB14lkzCQLDnYr52OErY2DKJ4fICsrcwViuVD/5GQd2nk6TDZCuDd2ka6CYd1XqcPvD5k/ZxPDIdkGgdXORBEE9PbewrdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=TlSQWhSA; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="TlSQWhSA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781776662;
	bh=Pj25C/v+EL6kS8XUQkQTGImgX/LYSs7AnacR88uLE0A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=TlSQWhSA5TwgvExowWby/vE1pOUcobuk/krs/+/D2AY+nXv4ghiZ5M/3fKCij6OOZ
	 uCP9VxVt4LFrq3OivCzeWPZVxt2enOx/yxi8a7A6mh9gk9urVGlGlEozxLHacb8vaJ
	 WQwb090rgELZyxVIQkD9vkvoYxTkf3JXjqmoLAJQ=
X-QQ-mid: zesmtpgz1t1781776644t5d22a5d2
X-QQ-Originating-IP: f5Mz8b6t4rHIKpe6OrC3J90H2J5KZUMAJelm+1v6EKE=
Received: from Shurima ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 17:57:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3722739049147932067
EX-QQ-RecipientCnt: 10
From: Yichong Chen <chenyichong@uniontech.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	rppt@kernel.org,
	ljs@kernel.org,
	akpm@linux-foundation.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	chenyichong@uniontech.com
Subject: [PATCH 2/2] tools/include: Include stdint.h for SIZE_MAX in overflow.h
Date: Thu, 18 Jun 2026 17:56:42 +0800
Message-ID: <3B857B143D03C4AA+20260618095642.510565-3-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260618095642.510565-1-chenyichong@uniontech.com>
References: <20260618095642.510565-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OQhZ3T0tjf0aCF3EcmZpKQwjq9ui9H6OZpX7SF4C66PUFDD/BcjL235g
	DIc1SUQ85k4/HVWRPuIBYuloycHkF2tGbwVzNWF2QWnYYcujF0DXxrsqZOcNi1CvC9oX7h/
	/wKSHNuCCchkg3ofh4U5PaFXVOlBtA4xmKHCkl2XFcij+w+kGamQWk12RhtxZFz/pKXERFM
	MHThae/jIJW81CcPSURw4t20T6c+43J6nY+1hhcxsrs6fAFPuGbUaGx+Qu0djxZHX+wTgRt
	GAOIJS32hwpdDW9bbfteBLXlnImajrYpTwx+bQhAcqP5rQ/OZeFU8HTAoYQ6/WNmZTHDV37
	L0bxsVIC3IQy3md0PYyZGWtvR26o1P+l8TorCX8NwP+ZKs+eG+8zipJXIO2jBN4Il/D44d0
	MrTXLWexPAGww/jC/ud/GhKLqOFjxF/tMYi6szTB/CkRfGBMReRO3bEsSrPAc2Pi46qUTb9
	fECe2dJ5rig2rBzW7JRepImHoHD09h3c2qGlqypQgF1t706i3/0FUsXyqYU95L1w9Mjnlz2
	wOzUCZm/Ohh7YKkn1O0hsYmZsUKyBEepUdxfm/L3qUGCPJ6NmbDA2uz2HnkQGcm7w9gGyQb
	ewVBbbFEIJcFK9t8J+TgSVTXlhkz0XgTZpSrkOxXn3wrlEvdM2V0frwmMmRVgbKssNRc3Ov
	xN2yyG+ZPHHoS7KDuF2uduDaTpgNDsoBzKxslckxc6+SjFMRVr661t7XgwWJsznu5kcV6pT
	S1k0IZA+Xgx3/HNzg9YtuLyNCAcI61YiS/bwbNUHgc/rA+6xqttJoQO+NZtdrSHHun6o/aa
	6w+ePMteTvorvTzoamM/utRS/Gs5aT4XpoKmL9RAScZKG1ybRyms45/TY0xhn+sRS8apvbX
	b/3w1KwqMjC65ig11JIW07W7qMoccYA1OD0ZzxyyjX5I+3G0KE+6C9HQ4MvR1xyyKlUTRed
	0bV0GRGi60NQFLwWPjnHCs1n1lQRXkrF+UCndeBqQ5LjTQ1KITn5ka/OGH29fWzbBT9Gk8h
	a9fzwN4rqK77Yle08Gg+8JLgi9FqPuYOTucK0oQA0xitpL56iiZizopx+YYWA=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

tools/include/linux/overflow.h uses SIZE_MAX in its size helpers.

Include stdint.h so overflow.h provides that dependency itself.

Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 tools/include/linux/overflow.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/linux/overflow.h b/tools/include/linux/overflow.h
index 3427d7880326..9d30ae0dbd1d 100644
--- a/tools/include/linux/overflow.h
+++ b/tools/include/linux/overflow.h
@@ -2,6 +2,8 @@
 #ifndef __LINUX_OVERFLOW_H
 #define __LINUX_OVERFLOW_H
 
+#include <stdint.h>
+
 #include <linux/compiler.h>
 
 /*
-- 
2.51.0

