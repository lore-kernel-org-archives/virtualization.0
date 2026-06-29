Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B298DE56A
	for <virtualization@lists.linux.dev>; Mon, 29 Jun 2026 02:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782699777; cv=none; b=MSjPOUuqs7DobhWHVWid+mUtSQPbMOUH5fcp/CCLzVXoYRLFqAhzbi7S75pdXf2nOChffcOt4CC2wB9ql68w3ezoo7EhRx6ipgipMke8DF+3prWsDR96r/Nuwwu1kj7nztIQex50gB5jZKQxM8WObwsHNu2wxGCOsAJu3U8Xm1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782699777; c=relaxed/simple;
	bh=1lrMevxioPQgYqp1Er5UhGX6mEyWxT3XXDNEifKPvJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UQnt0cguDYL1e0VVS0J0TAE5azby3yMVNZsQps10J1Ny3rCoVQQTYdgH066rywlct7CqjG+KzkIOLg1WeebrMpMNWQK+pzluZ7y+WnWuJo8JhDBUnnfraIOERV4+4cjo659epMotHr4ht9MINv5ksZSJAjQDkYQI5s1Vt6MdoQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Q1jtjGAh; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Q1jtjGAh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782699722;
	bh=02Nz6hrMnyBRIcfODSTK5BCx0x1YHJQTMTAZgBysR/k=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Q1jtjGAh+pj4zzUI8Dy01XlH+ZsNd6KWyQS5o/sWovZTS8C8xSv4zJc9JCUm5djRd
	 Po0s/OCHukQ/64rrzr8itW3JLLMw6CCrsXUe6plnOErJzTBZQDhuV53RwNX2nohBqb
	 HQ25YFxyDKKhH5ohYn4UkQHNNOi/oE2ZYAt1psoM=
X-QQ-mid: esmtpsz17t1782699700tbb0b13bb
X-QQ-Originating-IP: E89XAc+YUNG9EgiZzXK/OBl9q9/vEPm8GzfoWAnj9ds=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Jun 2026 10:21:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4934061322778060234
EX-QQ-RecipientCnt: 11
From: Yichong Chen <chenyichong@uniontech.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: akpm@linux-foundation.org,
	rppt@kernel.org,
	ljs@kernel.org,
	pabeni@redhat.com,
	chenyichong@uniontech.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v2 2/2] tools/include: Include stdint.h for SIZE_MAX in overflow.h
Date: Mon, 29 Jun 2026 10:21:24 +0800
Message-Id: <20260629022124.131894-3-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260629022124.131894-1-chenyichong@uniontech.com>
References: <20260629022124.131894-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NKv2G1wnhDBnEfj4xKCTtZhRcP4RM+TEzXts4dvIN3LjaSMZA/d8+jBR
	rZ+lcqh8OUIAjlVnXo/ruLGAAB7zePrIrFLJ74b4cHZAI4F+EoTQydyKQrBF5w29rMN9+wS
	FUUczvp3bNlBq+BE7ETC7a1jIoclXunIiQP5e1Z3uvaw+GH4FgUYJDNhLXixG1Xw338oir1
	sWCFV5B6HDIyfFuUS7jfI91gQpv6ARZZUI+Nvjypzj07R3EfuzY0wINO8DDsE1Wm1hBFKPH
	XGEKLDfYDPMOgkM0wbyPbepGwVR9Z9T6vsLavIRu1jTovC9RfyhCI5yJJ56wBX6P0bum6V+
	vyP9MfT1juBVYKo6jpoWu4LlwSFXLD9WjqeP4uzhxkgu+Cado068hHsYphYRAKXuh3ifs6A
	uyZrBm/jZDgUPM4tGxr+mzneKkyvgxm/aJhQsSZij3cH87QKsi6f7U6m2P02aAnAGNxlLLw
	k8i7iFJKmBnjwfml3AjF4yVr+BBWtzHpdPN3WIoozn6a+Zd91Y8lSoxh7RvTlBStZaKNP1x
	rXjCMLF2z2CVR8tuJdegOudJdUtFfO12AckBA5jNLhwxb3Fx0SKvKphL69s42RaRrHmJ5Yg
	pkYr9Lqn6TcGZK/naKLu50bJ663/WKlBICaRlYkea90MLq8n6IEXBcUbUVxBRETgbi/IhI4
	I3qnU+x2+ojynycFzZrDG/7FVLg/e61h2KyxhPQ8TWi50G6KefGrTTQuSkRG2qRSPL2VHz1
	VuS3JJ+gweA39SpL6brQccWOp4NWxyIsjIkuWR5/BGs2Kfgj4l7thyLQQVbkRhEMIzOdqY3
	U0d6J20vKTomLWQ1udxMsO/NMTpojo0qk9J5SkxIjouY4ereRS5/7tiYuW3e9p4NqiqTWOq
	Grk327nrQ1p6T8ClrhI1Z88rtIY1E4HE4ItHcGF5FbUh0N+YM9SJ3W7h8Co7BtLfZbsNvgk
	Jip4liB8pLlA/oQS14u0bRGAeGKTuinTrsZGgZHUM6A6FKZaulqp7z4vPiHD7ZYzvYRIRes
	QJJc/voJafU0jIRscM61F4t/DkTEBI6npPxKeiv/Rdhj4b7nVQ
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

tools/include/linux/overflow.h uses SIZE_MAX in its size helper
functions.

Include stdint.h so tools users that include overflow.h without another
SIZE_MAX provider can build.

Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 tools/include/linux/overflow.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/linux/overflow.h b/tools/include/linux/overflow.h
index 3427d7880326..98963688143f 100644
--- a/tools/include/linux/overflow.h
+++ b/tools/include/linux/overflow.h
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 OR MIT */
+#include <stdint.h>
 #ifndef __LINUX_OVERFLOW_H
 #define __LINUX_OVERFLOW_H
 
-- 
2.51.0

