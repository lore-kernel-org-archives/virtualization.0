Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1910A3C7685
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 08:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784102966; cv=none; b=gUWvqpzKUHcMFkN2brnVu1AfHP56orsQVuwXSAb7O9IVKFBZ6HCmCjgV8iBlmAvUmXs4gFaMDLtAVyDhAFLyOMO55529PjJFk2YuU3ge8d279m5XO00Ql9emR+yHqUjmsFUvArbmxuufgUc9ntwkfjtkBRKJhJqSUDKwcgFM5cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784102966; c=relaxed/simple;
	bh=5Ax3j0NqEgjroTacMrvcIM4zb6Jrjl0MEiLI5RI4SN0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gcDSfSITfPH0p+u5Jq45HSNmUmaKry/5DQvoN7XfH9qzCDVzg4eXNtOVGNRg3Hk9BoSNxzZZ++mv1iZ2+JXZSexS2tV/4/3dSV/6q6YX3Gw8/kds5vNing0Y6mlIbLRTYkxv2gBD3C0CEptO7mH0SC6NHOq+iRr+Dw/cUh7el70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YRhTkS51; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YRhTkS51"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=dh
	pN8GqmV6xkp5xB49P83Dn8bU441/NJWNaStWhdTOk=; b=YRhTkS51Ces3gzdfL7
	scplVcqCqqx2tukugrzbSWMzKogF9RsG1Xb8WChe3aldKWK5JefA0FXZ2qkSood0
	ESkbpQFnK+PcCQzHSKQp2tzLlPQJANKqtE1qGwsUgCSineBORNKjwbVtrD5CEWrJ
	wgN1yC1Cwi7ybfljhij52pfJ0=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAXn_8sQFdq53nVJw--.65383S2;
	Wed, 15 Jul 2026 16:09:16 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: virtualization@lists.linux.dev
Subject: [PATCH 03/12] vhost-net: improve TSO and checksum TODO comments
Date: Wed, 15 Jul 2026 16:09:16 +0800
Message-ID: <20260715080916.21756-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXn_8sQFdq53nVJw--.65383S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7urWkWr13ur43Jr45Zw45Awb_yoW8ArWkpa
	17Kry8Zw15Wa12ga17AF47AF4fKa48GFyqk39aga4FkFyUur1UXF45Kay5KF98JrWfZFyf
	ZFn2y3WUGF1ru3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8yCXUUUUU=
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbC8AyLG2pXQCwEyAAA3x

From: xiongweimin <xiongwm2026@163.com>

Update TODO comments related to TSO (TCP Segmentation Offload) and
checksum handling to clearly document the current limitations and
what's needed for future implementation.

Signed-off-by: Weimin Xiong <xiongwm2026@163.com>
Co-authored-by: Cursor <cursoragent@cursor.com>
---
 drivers/vhost/net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 77b59f49b..c6854cba5 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -644,7 +644,7 @@ static bool vhost_exceeds_maxpend(struct vhost_net *net)
 static size_t init_iov_iter(struct vhost_virtqueue *vq, struct iov_iter *iter,
 			    size_t hdr_size, int out)
 {
-	/* Skip header. TODO: support TSO. */
+	/* Skip header. TSO support requires parsing virtio_net_hdr gso_type */
 	size_t len = iov_length(vq->iov, out);
 
 	iov_iter_init(iter, ITER_SOURCE, vq->iov, out, len);
@@ -1240,8 +1240,8 @@ static void handle_rx(struct vhost_net *net)
 		iov_iter_init(&msg.msg_iter, ITER_DEST, vq->iov, in, vhost_len);
 		fixup = msg.msg_iter;
 		if (unlikely((vhost_hlen))) {
-			/* We will supply the header ourselves
-			 * TODO: support TSO.
+			/* We will supply the header ourselves.
+			 * Note: TSO requires handling gso_size/gso_type in virtio_net_hdr.
 			 */
 			iov_iter_advance(&msg.msg_iter, vhost_hlen);
 		}
@@ -1270,7 +1270,7 @@ static void handle_rx(struct vhost_net *net)
 			 */
 			iov_iter_advance(&fixup, sizeof(hdr));
 		}
-		/* TODO: Should check and handle checksum. */
+		/* Note: Checksum offload handling not yet implemented */
 
 		num_buffers = cpu_to_vhost16(vq, headcount);
 		if (likely(set_num_buffers) &&
-- 
2.43.0

