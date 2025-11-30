Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D86BA55
	for <virtualization@lists.linux.dev>; Sun, 30 Nov 2025 00:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764461035; cv=none; b=T5AzAVSDHE70SBjIcd3sjxwEu2NmpFUGG9fgCBlGVxqQzKtmBMOFfAMUnw+yoxvFM/Cb2ea361FtqxKq/TlPQPXGRmXaa7EfGJUh1KiVD+zAPMvaFLUHQlbQgH4784dauMqhqiBpHSYmkbtpxIO3qeqfD0rGq2dG9nAPHSjrwC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764461035; c=relaxed/simple;
	bh=2CZ0G7Lx9UBPrpSGEoDj6hdA+oKbgrHY9570I3L5PnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e2BRR6EVa7Qh4TEkqbRxWxdKc3XV9a56yrZZbPHtlMGWRs0QvWC0yXrl7s6NDDDkHG0QZxy1X+gW5cbG3kak8RAVEvMMRO/EfikUfMOfm6KEuZPRyAa6iJNYDdnisYraHxqw4MmB+ckop8UMUfacpjXZpFMAjEh7CI9X1gkOBfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=b6JLmv28; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="b6JLmv28"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=yUYs23Uqf5ZNeoGn6Xlqs5/UveVEhVywpcqF8TR87p0=;
	b=b6JLmv28iRLB3Jet+vxmGb92/ymL3vn7ECMmj2Uky2APWKcG4qGd/VVVtPWyqr
	Zj21/lPD05HF0E3uJiqyBfV8xzUTbTW39hq2Lq2bQ15m/KUca34ohbi1RRkUiSem
	4yv7wCtmbB3mTvWLXDy+h4EOFOVR7QPTEFqEwHMEzVldo=
Received: from rom-ubuntu.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCXCDHUiStprISjDA--.32665S2;
	Sun, 30 Nov 2025 08:03:33 +0800 (CST)
From: Yufeng Wang <r4o5m6e8o@163.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Yufeng Wang <r4o5m6e8o@163.com>,
	Vincent Mailhol <mailhol@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Yuedong Wang <wyd20130109@163.com>,
	Yuexuan Wang <wangyx20170302@163.com>,
	Haimei Qu <545714393@qq.com>
Subject: [PATCH] tools: virtio/linux/compiler.h add __must_check define.
Date: Sun, 30 Nov 2025 08:03:30 +0800
Message-ID: <20251130000330.13139-1-r4o5m6e8o@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXCDHUiStprISjDA--.32665S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw4DWr48Kw48Cry3Xw45Awb_yoW8ArWrp3
	WDury5Ga18uryxC3WfK3Wa9ry7uws3CryxtFy7uw1UCFyaqF1Iq3ZIkF1ayrZFv3yvka10
	kr13XryDKa9rZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pROzstUUUUU=
X-CM-SenderInfo: 3uurkzkwhy0qqrwthudrp/xtbCzhW8MmkridXmywAA3m

Port over the definition of __must_check, make us can build tools/virtio.

cc -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h -mfunction-return=thunk -fcf-protection=none -mindirect-branch-register -pthread   -c -o virtio_ring.o ../../drivers/virtio/virtio_ring.c
In file included from ../include/linux/bits.h:32,
                 from ../include/linux/bitops.h:14,
                 from ../include/linux/log2.h:11,
                 from ./linux/kernel.h:14,
                 from ./linux/scatterlist.h:4,
                 from ./linux/virtio.h:4,
                 from ../../drivers/virtio/virtio_ring.c:6:
../include/linux/overflow.h:82:15: error: unknown type name ‘__must_check’
   82 | static inline __must_check size_t array_size(size_t a, size_t b)

Fixes: fc92099902fb ("tools headers: Synchronize linux/bits.h with the kernel sources")
Signed-off-by: Yufeng Wang <r4o5m6e8o@163.com>
Tested-by: Yuedong Wang <wyd20130109@163.com>
Tested-by: Yuexuan Wang <wangyx20170302@163.com>
Tested-by: Haimei Qu <545714393@qq.com>
---
 tools/virtio/linux/compiler.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
index 204ef0e9f542..38c2b47b5f73 100644
--- a/tools/virtio/linux/compiler.h
+++ b/tools/virtio/linux/compiler.h
@@ -11,6 +11,10 @@
 
 #define __aligned(x) __attribute((__aligned__(x)))
 
+#ifndef __must_check
+# define __must_check
+#endif //__must_check
+
 /**
  * data_race - mark an expression as containing intentional data races
  *
-- 
2.43.0

