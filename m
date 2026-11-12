Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794473809;
	b=vBculqNRFNq5zVA4dZ9EtGHSVeg7LuCk9FMfcbnBvfDVATPLeEabGcNyhKKq9b2z5Vla
	 kfLpn/7cndXbgBLPu9AR6Vl6H9ACMm+jVIwWnxwU2h5ApAF1E0chNRyzHlh6Y12Avfsnt
	 fLWXXmsvcsCfEWgLSXJhRG2hnExIYkeXm2jowvwmRDjqXwsglS2zeaQOE8Mrt0fAcafLx
	 ui/QDZ6jgGMLCVrNuDFIuYQ5GlSjXhLh0PvRrEdct/18nPmOqBKRB6RxSxHHtQj1buObU
	 7jwyvHAUcZoMMYZeHfkywTtC0BSD20FPhcrOObjqqSnz901pQQ++UDndww34CZjbGmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473809;
	h=DMARC-Filter:X-UUID:X-CID-CACHE:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:
	 X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3rmNGZ3FyLxulD7mp5QOdVRfcfOUI6QTy1OLeUY9pY0=;
	b=NxitucSnnbldP80wW+45FzrDCTgXshIcqxzilZH1rUFgMHiPJm4NHSL/byxE3OXJuZF5
	 qRqmcv151XXQ7pm9Gs4GWbhPjqVM37xPc4saU1iosvu1pgpSijzXuZL7oQkwM8bK5umFc
	 Evn+LgUFS/F4hZqPM/a00Nb/AQ38mPp/e9vW9RZZ1QbnZ8BYGjoPi6BErwBvwBZqaHge3
	 fRbTGhDvxnPDpgGqX5wpELOWui60401RJxZTfFjbg/P+5YTkjyzhxGTJYX4j67RrziDtr
	 c1tB1x23MBx7VAyBRtjEiX3tykGxty7xRN3caobWtN5cR9Jb8siwadENn+jlPiwJ4TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5C5606A8AF
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 08:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F5C5606A8AF
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fc264180de7611f19a56ed5b684f684d-20261112
X-CID-CACHE: Type:Local,Time:202611121605+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:b76f948c-f57b-4d42-80b7-cf3d90f2704f,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:24f61df2c0030f820d9e23753848eb35,BulkI
	D:nil,BulkQuantity:0,SF:102|123|865|898,TC:nil,Content:0|15|50|99,EDM:5,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fc264180de7611f19a56ed5b684f684d-20261112
X-User: zhaoguohan@kylinos.cn
Received: from ubuntu.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhaoguohan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 847822666; Thu, 12 Nov 2026 16:56:44 +0800
From: zhaoguohan@kylinos.cn
To: mst@redhat.com
Cc: jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] vhost: set dirty log bits without pinning pages on x86
Date: Thu, 12 Nov 2026 16:56:30 +0800
Message-ID: <20261112085631.128819-2-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112085631.128819-1-zhaoguohan@kylinos.cn>
References: <20261112085631.128819-1-zhaoguohan@kylinos.cn>
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

set_bit_to_user() pins the log page with pin_user_pages_fast(), maps it
with kmap_atomic(), sets one bit and then unpins the page and marks it
dirty. This runs for every bit set in the dirty log, e.g. on each used
ring update while logging is enabled for live migration.

log_write() always passes a byte address and a bit number in [0, 7], so
the update can be done as a byte-sized cmpxchg on the user address. On
x86, try that first using unsafe_try_cmpxchg_user() inside a
user_access_begin()/user_access_end() section with page faults disabled.
If the access faults (page not present, read-only or needing COW), or
the cmpxchg loses to concurrent updates of the same byte four times in
a row, fall back to the existing pin/kmap/set_bit path, which can fault
the page in.

unsafe_try_cmpxchg_user() is only implemented on x86, so other
architectures keep using the existing path.

On an x86_64 KVM guest (i7-12800HX host), a synthetic used-ring
workload with logging enabled went from 243.60 to 171.11 ns per
descriptor, averaged over five alternating runs. This is the
end-to-end cost per descriptor, not live migration performance.

Signed-off-by: Khan Zhao <zhaoguohan@kylinos.cn>
---
 drivers/vhost/vhost.c | 50 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index e29f154706da..9c3045504709 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2527,11 +2527,7 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 }
 EXPORT_SYMBOL_GPL(vhost_dev_ioctl);
 
-/* TODO: This is really inefficient.  We need something like get_user()
- * (instruction directly accesses the data, with an exception table entry
- * returning -EFAULT). See Documentation/arch/x86/exception-tables.rst.
- */
-static int set_bit_to_user(int nr, void __user *addr)
+static int set_bit_to_user_slow(int nr, void __user *addr)
 {
 	unsigned long log = (unsigned long)addr;
 	struct page *page;
@@ -2550,6 +2546,50 @@ static int set_bit_to_user(int nr, void __user *addr)
 	return 0;
 }
 
+#ifdef CONFIG_X86
+static bool set_bit_to_user_fast(int nr, void __user *addr)
+{
+	u8 __user *p = addr;
+	u8 old;
+	int retries = 4;
+	bool success = false;
+
+	/*
+	 * log_write() passes a byte address and a bit number in [0, 7].
+	 * On x86, update just that byte to avoid crossing a page boundary.
+	 * Bound retries so a contended byte cannot hold up the worker.
+	 */
+	pagefault_disable();
+	if (!user_access_begin(p, sizeof(*p)))
+		goto out;
+	unsafe_get_user(old, p, fault);
+	do {
+		if (unsafe_try_cmpxchg_user(p, &old, old | BIT(nr), fault)) {
+			success = true;
+			break;
+		}
+	} while (--retries);
+fault:
+	user_access_end();
+out:
+	pagefault_enable();
+	return success;
+}
+#else
+static bool set_bit_to_user_fast(int nr, void __user *addr)
+{
+	return false;
+}
+#endif /* CONFIG_X86 */
+
+static int set_bit_to_user(int nr, void __user *addr)
+{
+	if (set_bit_to_user_fast(nr, addr))
+		return 0;
+	/* Resolve faults, or use the native bit layout on other architectures. */
+	return set_bit_to_user_slow(nr, addr);
+}
+
 static int log_write(void __user *log_base,
 		     u64 write_address, u64 write_length)
 {
-- 
2.43.0

