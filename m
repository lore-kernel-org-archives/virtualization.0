Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C513DEADB
	for <virtualization@lists.linux.dev>; Fri, 26 Jun 2026 07:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782457496; cv=none; b=RaOZsZzxYxm4wwpMD2jst9PA26gpqmQtw5/d2F3i2jd7I5c7aTGySgDnsrSXHfBc9QlVr2gtOK+WSi/V0qQHAqm2pTemjpVcRsr5vGU9fAZ92fvgLABDOAjXHvPwtlwUwHduF4ZVhNu0dMXu0qOEIgfO08NTGg2Iuv+j3vZvbAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782457496; c=relaxed/simple;
	bh=RW1jPPYUb7bCu9ec/0Fv/4Q/N/7nYv7QouMskKa0t6o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I8aZDmxBlPzJGhJoLtziip8jE68JZoadbYbBptEu0Mpjlr97286ddYNOiy1m6zAg5bNd7aG3+1qzWajUng0pk9BQi1vp6YVzypXK6z7wrr+dcMfyZJdlJD1OfXcM1hCywqBVSMSlCKKFga6mO78LwY/fhx7TxcFK4Mf+B4aJ5AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VqNt3WOT; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VqNt3WOT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=6+
	fhL15IpXELWBk5X5Yj6nvB2KblT0bo0DI5mw+pYgU=; b=VqNt3WOTTzEg46+myV
	qEGM1V/jAIWA0OG52dQI20qc6XZ0nANoMyXXdrI+sBDZOkDHsNoQ/4BPZLubhZ3N
	d/Z9PvN+rSx8nbgb3SYYwkFW5UixLkpTXi/TzQdxBatrSkQNiiI38jCcloCT0FfM
	aJAYFc206obsV0QNpvsD0eVwc=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCXH_GKJD5qqPCwEA--.52186S2;
	Fri, 26 Jun 2026 15:04:43 +0800 (CST)
From: "rom.wang" <r4o5m6e8o@163.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Yufeng Wang <wangyufeng@kylinos.cn>
Subject: [PATCH v2] vhost/net: fix clear_user start address in VHOST_GET_FEATURES_ARRAY
Date: Fri, 26 Jun 2026 15:04:38 +0800
Message-Id: <20260626070438.59149-1-r4o5m6e8o@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCXH_GKJD5qqPCwEA--.52186S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF18Jw1fJr1rKr4rAF43ZFb_yoW8ZF1xpF
	Z7K3y5AFW5Cr4jyan2yrsrW3W8u3WfGFW0krW293y5CFn8Xry2yFs2kFW2qwnrWrWrJr13
	AFn0qr15JFWDu37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUrc-UUUUU=
X-CM-SenderInfo: 3uurkzkwhy0qqrwthudrp/xtbCzQxWy2o+JIx8MQAA3t

From: Yufeng Wang <wangyufeng@kylinos.cn>

The clear_user() call in VHOST_GET_FEATURES_ARRAY incorrectly starts
at argp, which is the beginning of the features array, overwriting the
data just written by copy_to_user(). It should start after the copied
elements at argp + copied * sizeof(u64) to only zero the trailing
unused space.

Use size_mul() for both the offset and length calculations so the
arithmetic stays consistent with the surrounding code and remains
overflow-safe.

Fixes: 333c515d1896 ("vhost-net: allow configuring extended features")
Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>

---
Changes in v2:
- Use size_mul() for the offset calculation as well, per review feedback.

Link to v1: https://lore.kernel.org/all/20260526080336.61296-1-r4o5m6e8o@163.com/

Note:
Thank you for your review and suggestions.

I tried to add a switch in tools/virtio/vhost_net_test.c.
The switch is meant to use VHOST_GET_FEATURES_ARRAY and
VHOST_SET_FEATURES_ARRAY instead of the legacy versions.

However, when I ran `make virtio` in the tools directory,
the build failed with an error: missing asm/percpu_types.h.
I fixed that error, but then another error appeared.

Would it be acceptable to postpone the submission of
this test case until I have sorted out all the build
errors?
---
 drivers/vhost/net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 77b59f49bddb..4b963dafa233 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1784,7 +1784,8 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 			return -EFAULT;
 
 		/* Zero the trailing space provided by user-space, if any */
-		if (clear_user(argp, size_mul(count - copied, sizeof(u64))))
+		if (clear_user(argp + size_mul(copied, sizeof(u64)),
+			       size_mul(count - copied, sizeof(u64))))
 			return -EFAULT;
 		return 0;
 	case VHOST_SET_FEATURES_ARRAY:
-- 
2.34.1

