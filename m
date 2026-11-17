Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904428;
	b=d+Dbdh7g2G2ApaYgkVoeZ4wX3IhwHiHeZP6zr1bSw/H3gWyesSTR2C4Eh1XY11En1pKT
	 pkUaRv4PlT9ZIoNTf/ebDrW93t2R1sE1uPeJJ1CpCYV06mWsMAN13WexYPS+Pxsw0m/rP
	 Ss2DAl3j9iZOTM6RFkJTZNag6blHjA7tK1MwjBmgctuOLMBIlG64sfAZxAQvYAJCy2Li1
	 9VTh59wZWoC+DuHLQFgUfL4NFYtzDC9vF3BeHaW5SCnCQtB7HOX5dCy2j5c9HvHLAgIGT
	 RbH0ab199mHAe//0EhVK1sKepuCMh/0H/JLPVNwW24EDq4uJ5MU/OMwsz1VWlUFOCMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904428;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pc3hd5EJJHTuogUWGwaEfmIOo0IjFod+Ai9pssRTzyw=;
	b=5gUr/x3B2VpHxJ44VgTpeOo63gR3/cLks/XH2EXhbXHf8MDD7A3KVp/RVT+5jtQoJx7k
	 yAcXRhAj74cLH8m7iqlM1hQGOGiY3VfSsoyNRDz8zDOPtePM1sHGXwr3WhECDivWdPLtf
	 15+cg0u4OIrhQLeB5xXr5FUFVLOu7lbRkQoHr8vetPnLatWjIIkE1+XWW7gjm0RBSUfHP
	 bWUk2kbh7aEbxinHeDBZGvw2vXARLrSTqkNz85G+Atb1ESEfax92Bg6i5iLN4tDXRmux2
	 DhT+b96HMYafq1ZGFtoS8ygQlDEyNI9HLBuXHVBdC6Fqr0hy75ysgK1QVzsfWOb/BNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5654606A8AB
	for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 08:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5654606A8AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 94e4be04e26111f19a56ed5b684f684d-20261117
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:b78c4b1d-5434-4065-8df3-7b4f70eb62a3,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:5fd36afc6f2618dd34de8351584e44a3,BulkI
	D:nil,BulkQuantity:0,SF:102|123|865|898,TC:nil,Content:0|15|50|99,EDM:-3,I
	P:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 94e4be04e26111f19a56ed5b684f684d-20261117
X-User: zhaoguohan@kylinos.cn
Received: from ubuntu.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhaoguohan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1858957154; Tue, 17 Nov 2026 16:33:36 +0800
From: zhaoguohan@kylinos.cn
To: mst@redhat.com,
	jasowang@redhat.com
Cc: eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khan Zhao <zhaoguohan@kylinos.cn>
Subject: [PATCH v2 0/2] vhost: set dirty log bits without pinning pages on x86
Date: Tue, 17 Nov 2026 16:33:21 +0800
Message-ID: <20261117083323.89502-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
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

From: Khan Zhao <zhaoguohan@kylinos.cn>

This replaces my v1 with Michael's set_bit_user() from the RFC thread,
plus the userspace test from v1 extended with a cross-page case.

Patch 2 adds tools/virtio/vhost_log_test

Median of five runs of "vhost_log_test --bench", which pushes batches
of 128 descriptors through vhost_test and reports the time per
descriptor (lower is better). "logging enabled" sets
VHOST_VRING_F_LOG, so each descriptor logs two used ring writes (the
used element and used->idx); data buffer logging (VHOST_F_LOG_ALL) is
not exercised. baseline is the same tree without this series.

                      baseline      v2    change
  logging disabled      155.04  158.78     +2.4%
  logging enabled       287.58  189.20    -34.2%

Changes since v1:
 - Patch 1 is now Michael's set_bit_user() with scoped user access,
   replacing my cmpxchg loop and its GUP fallback. I added __label__
   for the efault label so it stays local to the macro.
 - Patch 2: add the cross-page case, use VHOST_PAGE_SIZE from the
   UAPI, and print the bitmap when the cross-page check fails.

v1:  https://lore.kernel.org/all/20261112085631.128819-1-zhaoguohan@kylinos.cn/
RFC: https://lore.kernel.org/all/af7f05bf637337d35fdd10f3e0dbb5e39d7780e7.1794480795.git.mst@redhat.com/

Khan Zhao (1):
  tools/virtio: add a vhost dirty log test

Michael S. Tsirkin (1):
  vhost: set dirty log bits without pinning pages on x86

 arch/x86/include/asm/uaccess.h  |  23 ++
 drivers/vhost/vhost.c           |   7 +
 tools/virtio/.gitignore         |   1 +
 tools/virtio/Makefile           |   7 +-
 tools/virtio/vhost_log_test.c   | 432 ++++++++++++++++++++++++++++++++
 tools/virtio/vhost_log_test.rst |  61 +++++
 6 files changed, 529 insertions(+), 2 deletions(-)
 create mode 100644 tools/virtio/vhost_log_test.c
 create mode 100644 tools/virtio/vhost_log_test.rst


base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
-- 
2.43.0

