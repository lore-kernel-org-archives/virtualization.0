Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CD43AA195
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784885898; cv=none; b=hZPkAN3SwQ7u45i3ftJaQ58IG/JG2Wt7tK9jvUv7R3bfv2bLaYRswe0/cYgZPeO98rzvArqduBkt6imW1WSI8WLlCROLUYaN5I6idYIqhHmJ/vctyvJTQcoCuXq8s7Hc6+xJwJ33ypLJqmIWq1DESegxFpd0KerRXIS6whdq470=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784885898; c=relaxed/simple;
	bh=0S1MU3I01+SXc+k+DC6HxBTZZEBkCigMKIl5zKam2YU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ntMEFHqQ0DZsUgXm/D99tkJOLBrE4oLyylgLjUjULdcVuNeVMAMgESd3oN8Et/pio9guIMVjJ0fXGgn2qqhvoZb04vdJDT4RFljF7cAhwDcLi8/vu+Wd8wgsAMlMBnC9FglqRMog/A5ZqwiUZEu7m8OyfyyuqN8vJdl0EUWVE70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gj9yO5cf; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gj9yO5cf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=4y
	j940qjx+FeltU9fph5m0Y6GNN8PcoIDW2zyosnPjg=; b=gj9yO5cfTDLSRJiI84
	Eru/s8yvTVCWU2KONQ3DUe82+oYxAjtBBp0iv5q0C26/xyjgrAU8bGoDQ06xLT1b
	mp4h/KOjfYJmNI5T+f7wLEAn1HPopX8vk1XknUhid58l3V74GTagHAyvrG6shvRo
	1rq7s/wwzqYKpt7IYLD1+Q1TQ=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wB3tZ+BMmNqFvnbLg--.65177S2;
	Fri, 24 Jul 2026 17:38:10 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH] hw/net/virtio-net: Remove dangerous cast in receive_header
Date: Fri, 24 Jul 2026 17:38:09 +0800
Message-ID: <20260724093809.810263-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3tZ+BMmNqFvnbLg--.65177S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr17CFWkJw4fZry3CrW3KFg_yoW8GFyxpF
	n0gF4Iqr4rXF13Ga1rAFs5X34jy3Zaka43CrWqq345uFZ8Ar1DtryY93W8t3WakFWkAF1I
	9rWFqFy5JF1Du3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jAl19UUUUU=
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzgIgr2pjMoLlmQAA3G

From: Xiong Weimin <xiongweimin@kylinos.cn>

The receive_header() function contains a "FIXME this cast is evil"
comment. The code does:
    void *wbuf = (void *)buf;

This cast from 'const void *' to 'void *' removes const qualifier which
could lead to unintended modifications. Instead, use a properly typed
pointer and pass it correctly to work_around_broken_dhclient().

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 hw/net/virtio-net.c | 12 +++++++----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 1234567890ab..fedcba098765 4321006
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1716,12 +1716,14 @@ static void receive_header(VirtIONet *n, const struct iovec *iov, int iov_cnt,
                            const void *buf, size_t size)
 {
     if (n->has_vnet_hdr) {
-        /* FIXME this cast is evil */
-        void *wbuf = (void *)buf;
-        work_around_broken_dhclient(wbuf, wbuf + n->host_hdr_len,
-                                    size - n->host_hdr_len);
+        const uint8_t *wbuf = buf;
+        uint8_t *payload = (uint8_t *)(wbuf + n->host_hdr_len);
+
+        work_around_broken_dhclient(wbuf, payload,
+                                    size - n->host_hdr_len);
 
         if (n->needs_vnet_hdr_swap) {
-            virtio_net_hdr_swap(VIRTIO_DEVICE(n), wbuf);
+            virtio_net_hdr_swap(VIRTIO_DEVICE(n), (void *)wbuf);
         }
         iov_from_buf(iov, iov_cnt, 0, buf, sizeof(struct virtio_net_hdr));
     } else {

