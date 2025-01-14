Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DC71C3BEB
	for <virtualization@lists.linux.dev>; Tue, 14 Jan 2025 06:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736837260; cv=none; b=Lypwcd+0SrFZjIjEqhALdPQnn3wbjjMJuhgV3I8+H6ZlmR1lou9UqcxaUPi8oQEEav+3pz34CWx2Yc6dDhXQ5+XeuBwVHKqDv7L6TlUNIoaaP7l/yjuTTOSGkAXpd8y+2gujpEwSP8jy8fkvhfE4iWYMBR92w+wr5OuIoAunoWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736837260; c=relaxed/simple;
	bh=CGWBLDIeQ3qOXFC/CbM1S2qAFV8nPEkURe2AFlZBSsI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pcmFplSDMCXcXPe1cQobTNxTSCr/QSw7ge5Pu8QS9KZovxyue7f8ydSi01ZLQ+uqq2migv1CLpEm2/xVDM9zFcSDOdRP804FA49WxlUbd8kOeFtM3ML3Rs4NnWpC0iajC1O5LFOIhns/xZkLh6jFfgMPw0emX7VBfZExAjUESHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6c6e0e10d24311efa216b1d71e6e1362-20250114
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:a944e3e1-01fc-4c28-ab15-b98f6d33a208,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:16ec472e98dba6bff5eea2305603cc40,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6c6e0e10d24311efa216b1d71e6e1362-20250114
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <wangyufeng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1249712274; Tue, 14 Jan 2025 14:47:29 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 5AFB3B803964;
	Tue, 14 Jan 2025 14:47:29 +0800 (CST)
X-ns-mid: postfix-67860881-1774315569
Received: from localhost.localdomain (unknown [10.42.12.106])
	by node2.com.cn (NSMail) with ESMTPA id 7E325B803964;
	Tue, 14 Jan 2025 06:47:28 +0000 (UTC)
From: Yufeng Wang <wangyufeng@kylinos.cn>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Yufeng Wang <wangyufeng@kylinos.cn>,
	virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] tools: virtio/linux/module.h add MODULE_DESCRIPTION() define.
Date: Tue, 14 Jan 2025 14:47:26 +0800
Message-Id: <20250114064726.33079-1-wangyufeng@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

when we build tools/virtio, meet below error information.

cc -g -O2 -Werror -Wno-maybe-uninitialized -Wall
-I. -I../include/ -I ../../usr/include/
-Wno-pointer-sign -fno-strict-overflow
-fno-strict-aliasing -fno-common -MMD
-U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h
-mfunction-return=3Dthunk -fcf-protection=3Dnone
-mindirect-branch-register -pthread
-c -o virtio_ring.o ../../drivers/virtio/virtio_ring.c
../../drivers/virtio/virtio_ring.c:3276:20: error=EF=BC=9Aexpected declar=
ation specifiers or =E2=80=98...=E2=80=99 before string constant
 3276 | MODULE_DESCRIPTION("Virtio ring implementation");
      |

Fixes: <ab0727f3ddb8>("virtio: add missing MODULE_DESCRIPTION() macros")
also add MODULE_DESCRIPTION() define for virtio test.

Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>
---
 tools/virtio/linux/module.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/virtio/linux/module.h b/tools/virtio/linux/module.h
index 9dfa96fea2b2..b91681fc1571 100644
--- a/tools/virtio/linux/module.h
+++ b/tools/virtio/linux/module.h
@@ -5,3 +5,10 @@
 	static __attribute__((unused)) const char *__MODULE_LICENSE_name =3D \
 		__MODULE_LICENSE_value
=20
+#ifndef MODULE_AUTHOR
+#define MODULE_AUTHOR(x)
+#endif
+
+#ifndef MODULE_DESCRIPTION
+#define MODULE_DESCRIPTION(x)
+#endif
--=20
2.34.1

