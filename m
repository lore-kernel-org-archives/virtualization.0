Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12FB30E0EE
	for <virtualization@lists.linux.dev>; Thu,  2 Jul 2026 03:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782961488; cv=none; b=rgCLrK5SMMmq2LG1/QS57O01S7GZH53epH1Y802mkuaLd9J9VXclVgjMr0tn0bR0F4+pJ7g3FXjBIlBrP48wGJQLPtv94gjWbtQB3f+3081oeEIkcao/0BxY4Mmt/aBVj4iNstqwm+duaE3UkelNxT6DHbctj8QkxUeh+TPQkWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782961488; c=relaxed/simple;
	bh=GPmldPXV0HzyVSh7yBU/ZMa1laVZTv93CSClbqvtLgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f9nJLBp4C49wXffS5uctYYXNpK7jVje8lz02/mydifOmVRjTfAGzqXL4pSwgDCLXuzDa+X7pyl6RmZiqLOwOz+aoY+OtrQJuODhh7BNsHEFQQJgEtNHGUeCc3//tfJ1tmsSKH2HwXEMg/Ucqo6VEdSi2Z7Qp0M0XVuL6uzWAUUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=QMaSXaPS; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="QMaSXaPS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782961471;
	bh=DoBe1Xekvfk1MnX9b1zqqBICyOO18N2n/at0nVS4qeI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=QMaSXaPS8q4/LYP+ujJTSEQY5T2S6xdnihwK8+UbNp8Jko1gec/7lV8YhuRQnXRqP
	 6UstCp5CmKgrmVKUibPG0gEB1suAFtYVXChQPdBrE1Lg78cecGi9g3FLS9EEJ3+V12
	 PeS8AQPa6r4NQHdlr9R9egznx4x3Daygf+1t4mIM=
X-QQ-mid: esmtpgz15t1782961453t3141c51b
X-QQ-Originating-IP: zhqxNkOUnOzuCiKzjPeq43ip8/LDa4qSSvVHAxL+DI8=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 02 Jul 2026 11:04:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14804382044737647487
EX-QQ-RecipientCnt: 12
From: Yichong Chen <chenyichong@uniontech.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	akpm@linux-foundation.org
Cc: sj@kernel.org,
	rppt@kernel.org,
	ljs@kernel.org,
	pabeni@redhat.com,
	chenyichong@uniontech.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] tools/include: Include stdint.h for SIZE_MAX in overflow.h
Date: Thu,  2 Jul 2026 11:03:58 +0800
Message-Id: <20260702030358.308155-3-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260702030358.308155-1-chenyichong@uniontech.com>
References: <20260702030358.308155-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MhOKvsv6t0fk2wsJVcB+pD5yb3mXFufqgm/namIG/K109n9Hq3e57TmN
	D3Ll6XM+yd3dgAmrLnoBPIZtJlNX5cfJwu+W013z0X09ZA+aMEH9H0hi0EUhsnf6K7e6Jsk
	L5PeYiYwBaHzeJnaAQQ+//kaeB3VNI11AuA60wSH1QoapLsCqPRWKorXhIA3gYWUGmlngXQ
	uEgL2+HN7w011SLOo0nrP/01d4woeICzlkefjoI52cC22A0XRu2IlPC3NR6GhVu4Ae2l49v
	vd+ZwXJFu8bY6Zr8iNdoPsOikg2pwt/6h78Alu6JmAso9qJJxF6A3i2wYF7DHWx5WePsd5n
	A2CgJeaR03bbgKQGm5Q3Tf7qxnNnotoLP0VYGMHFx8LjpRCEkKFxzWhoSTZJORIx6Xt4zyz
	7RoPvFT/JMWFKFn4DEkujDQJQjQ+YagHHhhGm9isspVm31+cB95TRGoVtiy7/FM4a2fluSH
	fzHbw24lYLsyc9Laxzu02KZG57Gq1xa1CKucR3w5sXUnpRmjrfH2mAP1fSXTSqf4ezVagA8
	mKJgRNIQ0AIzAaXGBvL42Grh2VG5QIhM0BWJPzrpiovEvHpL1GOYEzuiyW/z8w2jqh7boxU
	Tcl7YqQtessSAl/G+bRRgn9+DLmSvChRnu54m9e5r/vni72gXmJ7IN7wBB3c+eWmOQe2jLP
	ZqjbgJ5G6Lu0ZJFJlhR9cZSGLtz/L6D88uDjq4vSqC6CE/Wp2+PcJFAAyA8uZQvju/dmb/s
	MAVPu836gsEhHTWtYkIvn1vqyOmr/2dUhqwI/vNBBdEaExb1CnJ95pirlHHtP3pne6Vci82
	PtBgphD2vSNsTgUIhg86m8WAy9RmnrZq9DtvvDGwkkVCH4y1LSWD5iau7gE+G53Kb4Tu+pm
	OKQYkX72fuw0VmJPKvJW9OH42MQJJ0aJ/UwXOIXaE8MLN2328VCqGAnxP03bVzz1IP5OmBN
	aC0E/6VHVG7F7Unqy7rOvy7MJSgV11ibNlL5uf2T5KQ6ueLgcYw+DQdhsTC/34QOmHgwKGP
	rTvPyuwqVS224S918Hr2LocvYs4yEdEgGP0Ai4QAHsz8WJj5nO2QnoV5NL3MrsbWKUAB3l/
	yA7vnpoQD0t4hBTqaMRPxg=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

tools/include/linux/overflow.h uses SIZE_MAX in its size helper
functions.

Include stdint.h so tools users that include overflow.h without another
SIZE_MAX provider can build.

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

