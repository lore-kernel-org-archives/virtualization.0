Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE74E22BAA0
	for <virtualization@lists.linux.dev>; Tue, 14 Jan 2025 03:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736825807; cv=none; b=sHF+dafRa4x9bhZ7rJI9KMhvYcMI+dhyftVDJsCMs2i8APUNu8K7YJm5sQMqe80li/mC/Z1gxiS+Dtg65T4vGyvH6nVl7X9Zlgf+2nlN56tu5UpjPe2mEnuoZDxvbODPcOysad1OTgb0rV0AsSJ+0KIgLo+wMxeYytraeXIG/bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736825807; c=relaxed/simple;
	bh=MbW+ygYe/V2olM+pIl9YFo3qwLf1ttjA8+0Rsa7l4OE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=A4G7o7LDJzYLJ7w3IOGiVjms/OqU7Nn7v00w+Cs/vaCNko6KBkmZXdZ+l7gXTWm0LvEaJkue+ba+q/7Z6y4yPZuyZqd6CBOvDIVQfW9eotoy+GYoAN7Y/b5IdoCZF2s56cNdNqijkOzo3TtYw14ocYaWyJFoH7R0J8rUh2q0Jpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c36cae44d22811efa216b1d71e6e1362-20250114
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:322852ef-3c7b-452e-b2a3-bf55e25d2c33,IP:0,U
	RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-30
X-CID-META: VersionHash:6493067,CLOUDID:f1e39af9d8b5a3138561c6e462b08afb,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:2,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c36cae44d22811efa216b1d71e6e1362-20250114
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <wangyufeng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1552972064; Tue, 14 Jan 2025 11:36:39 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id D7089B80394C;
	Tue, 14 Jan 2025 11:36:38 +0800 (CST)
X-ns-mid: postfix-6785DBC6-7754494935
Received: from localhost.localdomain (unknown [10.42.12.106])
	by node2.com.cn (NSMail) with ESMTPA id 5A9ADB80394C;
	Tue, 14 Jan 2025 03:36:38 +0000 (UTC)
From: Yufeng Wang <wangyufeng@kylinos.cn>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Yufeng Wang <wangyufeng@kylinos.cn>,
	virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] tools: virtio/linux/compiler.h: Add data_race() define.
Date: Tue, 14 Jan 2025 11:36:35 +0800
Message-Id: <20250114033635.20623-1-wangyufeng@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Port over the definition of data_race() so we can build tools/virtio.

cc -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I.
-I../include/ -I ../../usr/include/ -Wno-pointer-sign
-fno-strict-overflow -fno-strict-aliasing -fno-common
-MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h
-mfunction-return=3Dthunk -fcf-protection=3Dnone
-mindirect-branch-register -pthread
-c -o virtio_ring.o ../../drivers/virtio/virtio_ring.c
../../drivers/virtio/virtio_ring.c: in function'vring_interrupt':
../../drivers/virtio/virtio_ring.c:2711:17: error=EF=BC=9AImplicit declar=
ation function'data_race' [-Wimplicit-function-declaration]
 2711 |                 data_race(vq->event_triggered =3D true);
      |                 ^~~~~~~~~

Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>
---
 tools/virtio/linux/compiler.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.=
h
index 1f3a15b954b9..204ef0e9f542 100644
--- a/tools/virtio/linux/compiler.h
+++ b/tools/virtio/linux/compiler.h
@@ -10,4 +10,29 @@
 #define READ_ONCE(var) (*((volatile typeof(var) *)(&(var))))
=20
 #define __aligned(x) __attribute((__aligned__(x)))
+
+/**
+ * data_race - mark an expression as containing intentional data races
+ *
+ * This data_race() macro is useful for situations in which data races
+ * should be forgiven.  One example is diagnostic code that accesses
+ * shared variables but is not a part of the core synchronization design=
.
+ * For example, if accesses to a given variable are protected by a lock,
+ * except for diagnostic code, then the accesses under the lock should
+ * be plain C-language accesses and those in the diagnostic code should
+ * use data_race().  This way, KCSAN will complain if buggy lockless
+ * accesses to that variable are introduced, even if the buggy accesses
+ * are protected by READ_ONCE() or WRITE_ONCE().
+ *
+ * This macro *does not* affect normal code generation, but is a hint
+ * to tooling that data races here are to be ignored.  If the access mus=
t
+ * be atomic *and* KCSAN should ignore the access, use both data_race()
+ * and READ_ONCE(), for example, data_race(READ_ONCE(x)).
+ */
+#define data_race(expr)							\
+({									\
+	__auto_type __v =3D (expr);					\
+	__v;								\
+})
+
 #endif
--=20
2.34.1

