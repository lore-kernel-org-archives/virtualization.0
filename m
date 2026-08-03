Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21382DF132;
	Tue,  4 Aug 2026 01:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785808563; cv=none; b=rrq78S94qM3MvxELnPNHTeC9EicKZjzQTaRgC2NETJDoe3ggPfY3HOiJk/bJvQSP7w6SpF6x+AB2wGl9a8ag7zCTQ9ZWSqXglj1i4ufKqL8Uo+D+QcoifrcaLWtrCqPWWf4nqvRq0wINIzv+3cH2WuESbsd7QGhkz7keG1ijG6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785808563; c=relaxed/simple;
	bh=xieuQ4srYX3Mb3DrLqjIEew0FZmS9X/F1GKmxTg6pQs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWPgvjyONsthLPGSeVdheOA29ASlCB7p9oBCli0CTUSNNVcvwFoubVZeCicy/WUeEufFzNV2Hl6ThS4nQWqPktkq+pZUIzIy2WhPECS0+Y17oVQu8mNVEq4GeNpH6e3IgtH/bYuuTQZgSDKj19JGRjaku4sRITg7xr7dg0nnllI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Received: from simon-Latitude-5450.. (tmo-075-57.customers.d1-online.com [80.187.75.57])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 673IarsE011387
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 3 Aug 2026 20:37:00 +0200 (CEST)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, mst@redhat.com,
        eperezma@redhat.com, leiyang@redhat.com, stephen@networkplumber.org,
        jon@nutanix.com, brett@librecast.net, corbet@lwn.net,
        skhan@linuxfoundation.org, tim.gebauer@tu-dortmund.de,
        simon.schippers@tu-dortmund.de, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: [PATCH net-next v14 4/5] ptr_ring: move free-space check into separate helper
Date: Mon,  3 Aug 2026 20:36:40 +0200
Message-ID: <20260803183641.96882-5-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803183641.96882-1-simon.schippers@tu-dortmund.de>
References: <20260803183641.96882-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch moves the check for available free space for a new entry into
a separate function. Existing callers that only check for a non-zero
return value are unaffected. __ptr_ring_produce() now returns -EINVAL
for a zero-size ring and -ENOSPC when full, whereas before both cases
returned -ENOSPC. The new helper allows callers to determine in advance
whether a single subsequent __ptr_ring_produce() call will succeed. This
information can, for example, be used to temporarily stop producing until
__ptr_ring_check_produce() indicates that space is available again.

The return values are documented above the helper, as a caller that waits
for space must distinguish the transient -ENOSPC from the permanent
-EINVAL.

Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 include/linux/ptr_ring.h | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index d2c3629bbe45..631c43fde440 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -96,6 +96,26 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
 	return ret;
 }
 
+/* Report whether the next __ptr_ring_produce() has room for one entry:
+ * 0 means the single slot at r->queue[r->producer] is free, -ENOSPC means
+ * the ring is full, which is transient, and -EINVAL means r->size is 0,
+ * which is permanent. A caller that stops producing and waits for space
+ * must therefore do so only for -ENOSPC.
+ *
+ * Note: callers invoking this in a loop must use a compiler barrier,
+ * for example cpu_relax(). Callers must hold producer_lock.
+ */
+static inline int __ptr_ring_check_produce(struct ptr_ring *r)
+{
+	if (unlikely(!r->size))
+		return -EINVAL;
+
+	if (data_race(r->queue[r->producer]))
+		return -ENOSPC;
+
+	return 0;
+}
+
 /* Note: callers invoking this in a loop must use a compiler barrier,
  * for example cpu_relax(). Callers must hold producer_lock.
  * Callers are responsible for making sure pointer that is being queued
@@ -103,8 +123,10 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
  */
 static inline int __ptr_ring_produce(struct ptr_ring *r, void *ptr)
 {
-	if (unlikely(!r->size) || data_race(r->queue[r->producer]))
-		return -ENOSPC;
+	int ret = __ptr_ring_check_produce(r);
+
+	if (ret)
+		return ret;
 
 	/* Make sure the pointer we are storing points to a valid data. */
 	/* Pairs with the dependency ordering in __ptr_ring_consume. */
-- 
2.43.0

