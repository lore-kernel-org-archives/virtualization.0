Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368971A285
	for <virtualization@lists.linux.dev>; Sat, 18 Apr 2026 00:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776470507; cv=none; b=p0akNr+kycLWUshkPvErfikYywDx01BHoUWoRZzmgBaGVx+k3cq44wQZRgFaigo2dVegTxT+fWMYDa7M7HX5Wdz5fHs1dDJLhat48ls2s5KNCwS/cKMsFpfIItQEYocVGwqtu0DJAout0+QKrxrlYruH4qfkoT3ADbvVJ5IDyp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776470507; c=relaxed/simple;
	bh=aUw5Z9BShh7pPsO/YXyjGvI3vSM3MAsAxuOQ/UOswh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XFBs94WXITkQg7qBi3rE41eqML3gRwuKdcLLHzGf/NTjnNa3lsGynBhYIyRRbjU4ZFi6QvVOgJyDq9y7ao7KN0wnAax3KJ0emR72BVZEvMPqlgZimA0O2laIWCh0taOx2KtRect92ajRltTJaT2rG38hspopkPmolGuAw6brA3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILbLDTbU; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILbLDTbU"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cb3bae8d3eso106491985a.1
        for <virtualization@lists.linux.dev>; Fri, 17 Apr 2026 17:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776470505; x=1777075305; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R66LEpe02zTt9gVa2iVCV7h7l2cAvZnx/6Rq7QX2ojM=;
        b=ILbLDTbU1A56IYXgfbVZedh++bdA1QApYBBhXpC7rrhq7J3Mlkk/lcSh0Wabsitbho
         O381EzrCLphyu1c4VZnBEmJ/tJ48CJ65BNoM2+O2V9LY6cB6BNzsUXbkGi4c2RPKPlxy
         H2UYw4EAdyyNsZqyRMRtyMiYGBePSm2xhUlvEFlPMTyKI9zdluuerf8YiKkuZ1MWc6U+
         BLn1BRlMvkoSq7QucYIO/4aNW/PVRN3GdGbF0ELy84ELq+nP7yPmNY19I92637Th+HGC
         IVEIXQpJo+4f3oB33TqmUjCqxWg1UWYEr7O6bb5xFWwLUTg0X1egh8epuikiRbjyMfLi
         QzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776470505; x=1777075305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R66LEpe02zTt9gVa2iVCV7h7l2cAvZnx/6Rq7QX2ojM=;
        b=n3lt3G/uTRWPlegLwKN7vg91IJj/84/QhugCCDNeqpw9HSg5uQ2hJ+ZTnSPSF3QKNT
         9kzHRS9EpCOw6yiZOr1fmTKm1lUJfvZbUYOg8TXJSItiBQ18A/4dl9MNu4rsjvJtgnjY
         TnwR+fvzrDiKZBV/lL4pBYRXsVLzcQeIdWZci8GKQxrGmKPvXaaJxFK/F2iYaLHWkkEd
         WySBpIybFqvyNc6i+2ubJ7iql9MiPoMaVyKcxVNNWGowKHxu92MTQjI5rX+iI0iIJ8SU
         o8s820+54YtQaVte34olRuLxDpkItv2LwnJzAv03HGxHNkN9S7x337gx+kOSxGLg60wO
         dg7Q==
X-Forwarded-Encrypted: i=1; AFNElJ+fe9ixgJQyyLl9afVEVJBXCpZyqNeWBOMoIenBBrVY5fU6qfYmqlcefB+b//iI9SC19dIGC48M/i9vpfZqFw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxH6KKlYDPx1+8HvfMZgiYCvSYZ0GeUWcX9vzyOwAIdp8omz0oe
	9/L1guqRef0+EtMzFoAFcp2vbb4vZD6EvzjmbQwfUWdTSsiUWLLQSDnU
X-Gm-Gg: AeBDies7YYGGGgwV0w7K3zUWpFuP6R+r1o+a09rh5vNYetTLY1qwDneqtP2u8xO+7r+
	fJeeYH2EIquuU3wksuNxbvwg0SC9ShtTf+z6WU6e2fsCfhTZiFo2kHwG1EtGfM/YksHbXLIEchl
	e87YbcVbuz+5hc1mSkn3D60V9Qox0KDjjNfCGEo+je8zq2AWbUtGItN/n0VmMzY1KaMXea4KWZT
	W4vAdanzXzOcbKINyP2dX2NHGjMxElyT0z0ocfn8xgEEybLVW0UExlK6L/XBCiV/yiRNgWW3cI5
	+6qYSul5S03J6vKRZRMV+Iz4YWxrdiXMZQ0AK0DJgWhQwj+rB2D465uEWIU+Fz7uKBSn2GBYl2q
	7iA74+q8V5+HFvFXc1V8jcwu0W/cR3TIsyk+0+OxZh/75hd/qdRC1L1YeT63r824WVIHoIzH8mS
	crd8N+AehaMeinllu7H/xOlDpyS4WJIR3vsoBYcwErjJP4KT6+Bq/Mh26U2kMR1HPtDyuB4F2Pv
	qGdOgd5fbkjRBe+zrxU0Fjiu2hgnvM5iuJD6md/aUvDY2n+MIncJQ==
X-Received: by 2002:a05:620a:4101:b0:8cd:a3ab:352d with SMTP id af79cd13be357-8e792f433f6mr748234785a.61.1776470505139;
        Fri, 17 Apr 2026 17:01:45 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d64cc559sm228562585a.13.2026.04.17.17.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 17:01:44 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Soenke Huster <soenke.huster@eknoes.de>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH] Bluetooth: virtio_bt: clamp rx length before skb_put
Date: Fri, 17 Apr 2026 20:01:38 -0400
Message-ID: <20260418000138.1848813-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtbt_rx_work() calls skb_put(skb, len) where len comes directly
from virtqueue_get_buf() with no validation against the skb we
posted.  The RX skb is allocated as alloc_skb(1000) in
virtbt_add_inbuf().  A malicious or buggy virtio-bt backend that
reports used.len larger than the skb's tailroom causes skb_put() to
call skb_over_panic() in net/core/skbuff.c, which triggers
BUG() and panics the guest.

Reproduced on a QEMU 9.0 whose virtio-bt backend reports
used.len = 4096 into a 1000-byte rx skb:

  skbuff: skb_over_panic: text:ffffffff83958e84 len:4096 put:4096
      head:ffff88800c071000 data:ffff88800c071000 tail:0x1000
      end:0x6c0 dev:<NULL>
  ------------[ cut here ]------------
  kernel BUG at net/core/skbuff.c:214!
  Call Trace:
   skb_panic+0x160/0x162
   skb_put.cold+0x31/0x31
   virtbt_rx_work+0x94/0x250
   process_one_work+0x80d/0x1510
   worker_thread+0x4af/0xd20
   kthread+0x2cc/0x3a0

Reject any len that exceeds skb_tailroom().  Drop the skb on the
error path; virtbt_add_inbuf() reposts a fresh one for the next
iteration.  With the check in place the same harness runs without
BUG(); the driver logs "rx reply len %u exceeds skb tailroom %u"
and the device keeps running.

Same class of bug as commit c04db81cd028 ("net/9p: Fix buffer overflow in USB transport layer"),
which hardened the USB 9p transport against unchecked device-reported length.

Fixes: 160fbcf3bfb9 ("Bluetooth: virtio_bt: Use skb_put to set length")
Cc: stable@vger.kernel.org
Cc: Soenke Huster <soenke.huster@eknoes.de>
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
 drivers/bluetooth/virtio_bt.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 76d61af8a275..157e68b6e75f 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -227,8 +227,15 @@ static void virtbt_rx_work(struct work_struct *work)
 	if (!skb)
 		return;
 
-	skb_put(skb, len);
-	virtbt_rx_handle(vbt, skb);
+	if (len > skb_tailroom(skb)) {
+		bt_dev_err(vbt->hdev,
+			   "rx reply len %u exceeds skb tailroom %u\n",
+			   len, skb_tailroom(skb));
+		kfree_skb(skb);
+	} else {
+		skb_put(skb, len);
+		virtbt_rx_handle(vbt, skb);
+	}
 
 	if (virtbt_add_inbuf(vbt) < 0)
 		return;
-- 
2.53.0

