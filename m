Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904432;
	b=cApXp98sECJ/2XsyhdK8wWgTr6+SGiWgIolDBUKcn9eJ9vvtJCbdPPRRKx9pBJDNJLvq
	 TE9e4e0fo9MCri5fLKwGP5Y7Fr+KsnGcnOFqmIe1WP5L00pAwO+0ujQmzcCsfWop9lwwL
	 Xdf1yeU6L1PZJjm3dAo11uBWwsW3LkacrzMedyH/hpMRFI0Pyoa2a4WyDV0eCEdkFpmTr
	 RRVzXX60G0BmmBpjIPesYrnui29rtB8sVaEzaDgBtNenpJ7WbG8pcVkng1zNdiyBw0rNF
	 otzep5uZN+E3KV87URY0+A+5tcVi72aFTywup4O/gUMnljwET9zOsn3VVRy0ajKIV8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904432;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0ybH/Jy8OsAoPc4+xPNbpfBj5eNzpQlYRR4mvFXDLxs=;
	b=SaFTZqKp9D73bUXO1P+JFXhhKc5uhr2eEj+LKSupH/44QPP6Fg/lvymEQzTDgpBdpz/H
	 ycQOXMOjqiTAcGj/Yxvg2xuwLTK7msnqSDvsBEFodlVic88+IuGTlZnzKO0Zh5HHI6rZ2
	 oy46WwX4y0UgLRTGDu7WowIPBaisFPnjw9jxkzU1NK1Z9h7KPKgu/ob2pchED9mUBo8TX
	 c5G2GZPgxy0Gtf1ZaglSm9Nu05QrmRPAGD+RgbI9QuhkOEJg4ynaJ3oso7l11HsYQm6Dp
	 Emnj6DpsI6B+LmVguZto1MGeI8KoJod2NXCO1ke/f+HukRmN3ojCBhT1QuPnXu+3Myw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6431A606A8A2
	for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 08:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6431A606A8A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9821d1a6e26111f19a56ed5b684f684d-20261117
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:ecb2d8eb-a7a5-4ac4-a91e-7725d9e6362b,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:5c3ec8fa327a7d1464f059665462b4f4,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|123|865|898,TC:nil,Content:0|15|50|99,ED
	M:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9821d1a6e26111f19a56ed5b684f684d-20261117
X-User: zhaoguohan@kylinos.cn
Received: from ubuntu.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhaoguohan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 339652246; Tue, 17 Nov 2026 16:33:41 +0800
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
Subject: [PATCH v2 1/2] vhost: set dirty log bits without pinning pages on x86
Date: Tue, 17 Nov 2026 16:33:22 +0800
Message-ID: <20261117083323.89502-2-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117083323.89502-1-zhaoguohan@kylinos.cn>
References: <20261117083323.89502-1-zhaoguohan@kylinos.cn>
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

From: "Michael S. Tsirkin" <mst@redhat.com>

vhost had a TODO to replace page pinning with a version
of set_bit that works on userspace memory, since forever.

It is really best to avoid GUP on fast path entirely.
Implement set_bit_user and use it in vhost, to do just that.

Should not be too hard for non-x86 too.

Reported-by: Khan Zhao <zhaoguohan@kylinos.cn>
Link: https://lore.kernel.org/all/20261112085631.128819-1-zhaoguohan@kylinos.cn/
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
[Khan: declare efault with __label__ so it is local to the macro]
Signed-off-by: Khan Zhao <zhaoguohan@kylinos.cn>
---
v2: new in this series; replaces my v1 patch 1. Taken from
    Michael's reply in the RFC thread, with __label__ added for efault.

 arch/x86/include/asm/uaccess.h | 23 +++++++++++++++++++++++
 drivers/vhost/vhost.c          |  7 +++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index f4700ad6b5ec..a727ef8084f4 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -540,6 +540,29 @@ _label:									\
 	__ret;								\
 							})
 
+/* set_bit() on a byte of user memory; returns -EFAULT on fault. */
+#define set_bit_user(nr, addr)					\
+({									\
+	__label__ efault;						\
+	int __err = -EFAULT;						\
+	u8 __user *__p = (addr);					\
+	scoped_user_rw_access(__p, efault) {				\
+		__err = 0;						\
+		asm volatile("\n"					\
+			     "1: " LOCK_PREFIX "orb %[mask], %[ptr]\n"	\
+			     "2:\n"					\
+			     _ASM_EXTABLE_TYPE_REG(1b, 2b,			\
+						   EX_TYPE_EFAULT_REG,	\
+						   %[errout])		\
+			     : [errout] "+r" (__err),			\
+			       [ptr] "+m" (*__p)			\
+			     : [mask] "q" ((unsigned char)BIT(nr))	\
+			     : "memory", "cc");				\
+	}								\
+efault:									\
+	__err;								\
+})
+
 /*
  * We want the unsafe accessors to always be inlined and use
  * the error labels - thus the macro games.
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index e29f154706da..d426f303c107 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2527,6 +2527,12 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 }
 EXPORT_SYMBOL_GPL(vhost_dev_ioctl);
 
+#ifdef CONFIG_X86
+static int set_bit_to_user(int nr, void __user *addr)
+{
+	return set_bit_user(nr, addr);
+}
+#else
 /* TODO: This is really inefficient.  We need something like get_user()
  * (instruction directly accesses the data, with an exception table entry
  * returning -EFAULT). See Documentation/arch/x86/exception-tables.rst.
@@ -2549,6 +2555,7 @@ static int set_bit_to_user(int nr, void __user *addr)
 	unpin_user_pages_dirty_lock(&page, 1, true);
 	return 0;
 }
+#endif /* CONFIG_X86 */
 
 static int log_write(void __user *log_base,
 		     u64 write_address, u64 write_length)
-- 
2.43.0

