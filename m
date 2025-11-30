Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1945218FDDB
	for <virtualization@lists.linux.dev>; Sun, 30 Nov 2025 00:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764462360; cv=none; b=NwH7NblR0fMXTcekra891EAO+cYfEeM7ZihOOR6Q6wScOqix3qZJg2RvodaR8cxyZeWLVQARMnBS3sbC1MIUFPiPEDAA3rdwUgCUwP/nSkD3M80H/1y2iYlH3uSfqO66GHRT07iu3dqUzzrebl6xtCrI1FWAjfbda4lwbsau3h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764462360; c=relaxed/simple;
	bh=DXrds2QZnhQeiB4twO/hRWkLmhmFyQh2ldJMznZxjoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CdJroj3eOMysIcqAohWECCytE2Uu7orAkhSyhtakIBxgqgCVjtWUr/Ym7KOAQZyaQk415TPsQD+eLkb76qPaK9Dr5oTGSsaCng+faA7xqOSzXZ2Kr9krUKXbQUZZcpi4YQn1PNkUy7WcB2/dcEbAynNMgBm66YKdiRweFan+AtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fxB9i6Z8; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fxB9i6Z8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=tChOrQVQnuoEXPQAWzmzpnvp45On0v+E3PDuWpK7JCc=;
	b=fxB9i6Z89BS8rTTf5oPSZLN0kx2Yw85eQRcuJpO1CNfP71aLvNaCb4SCu7ksL8
	Ju9aVc2Zu1Z/QxF00VTkM4qEQiKBbSp843KqqhYoLvhkMH3k46yijyXrFTUpbD3d
	z+/LzxtNcFohFOJhpeX2zDlRgK4R1vvySodZdttU2nbPs=
Received: from rom-ubuntu.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDHJ_oEjytprB1qDg--.24827S2;
	Sun, 30 Nov 2025 08:25:40 +0800 (CST)
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
Subject: [PATCH][v2] tools: virtio/linux/compiler.h add __must_check define.
Date: Sun, 30 Nov 2025 08:25:38 +0800
Message-ID: <20251130002538.14875-1-r4o5m6e8o@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHJ_oEjytprB1qDg--.24827S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrWUAw18uF1ktr4ftF1xuFg_yoW8AFWxp3
	WDury5GF48ur1fC3WfG3Wa9ry7uws3CryxKFy7uw1UCFy3tF1Iq3ZIkF1ayrZFv3yvkayF
	kr15Xryjka9rZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pROzstUUUUU=
X-CM-SenderInfo: 3uurkzkwhy0qqrwthudrp/xtbCzgUKf2krjwWBEAAA3n

Port over the definition of __must_check and SIZE_MAX, make us can build tools/virtio.

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
 tools/virtio/linux/compiler.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
index 204ef0e9f542..0a620a6777aa 100644
--- a/tools/virtio/linux/compiler.h
+++ b/tools/virtio/linux/compiler.h
@@ -11,6 +11,12 @@
 
 #define __aligned(x) __attribute((__aligned__(x)))
 
+#ifndef __must_check
+# define __must_check
+#endif //__must_check
+
+#define SIZE_MAX (~(size_t)0)
+
 /**
  * data_race - mark an expression as containing intentional data races
  *
-- 
2.43.0

