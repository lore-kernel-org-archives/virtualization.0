Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1B12DA759;
	Thu, 12 Mar 2026 13:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320824; cv=none; b=Po+Ng28YjlYI/SI/PDieKJdBsd9m5MxVOix+i0ALDGQPLDtB0zKMzTr5jeVrZaXZ1EOZO8Q93Bi9Ghwo3czx5LjZp+GaF6rTl2Dkhwo9CMYsarWK4XFMNMIZN580PUo/olO/n9z9xKudJkKOITK5EcJNECGIDrMJJSCOyaQcM2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320824; c=relaxed/simple;
	bh=i6EXM/dz88Cyoq8LtFGDSx5xkGpNbJe1oE+QY2KW7uQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kIdteaW01wp483ckPHMF65skwTqUzJIvXNHUmUr0T1iHqAAQ97HfyI4i/TdGzTkWBZdKYdj+zOioGu4RsO6u7+j42EB30TnVXoASAfWNypRbFASyz9WPDcLRMf+ynKsF3whOIkKIsYpoJCkKNWrl2lXGsb0Y65g7eEMedbCVlLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=L7Fn6Usr; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="L7Fn6Usr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1773320812;
	bh=i6EXM/dz88Cyoq8LtFGDSx5xkGpNbJe1oE+QY2KW7uQ=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=L7Fn6Usr6CqpQSJg+sTfOg+35BhQICdFNJsUxwLeYojj09WsbqE+QES+PyTLa3XFu
	 FxS04Bhek6fbU8EeHr7JE5aXHsrDYgmS7DMPN3pylLsP+mmqheDPHhH+upjzAsxHlu
	 Hu27Gl+oOCiNAmlpvvsN7rxBct8aXBLITJeT4+sg=
Received: from simon-Latitude-5450.fritz.box ([129.217.186.105])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.2/8.18.2) with ESMTPSA id 62CD6mql014094
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 14:06:51 +0100 (CET)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
        eperezma@redhat.com, leiyang@redhat.com, stephen@networkplumber.org,
        jon@nutanix.com, tim.gebauer@tu-dortmund.de,
        simon.schippers@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
Subject: [PATCH net-next v8 3/4] ptr_ring: move free-space check into separate helper
Date: Thu, 12 Mar 2026 14:06:38 +0100
Message-ID: <20260312130639.138988-4-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch moves the check for available free space for a new entry into
a separate function. As a result, __ptr_ring_produce() remains logically
unchanged, while the new helper allows callers to determine in advance
whether subsequent __ptr_ring_produce() calls will succeed. This
information can, for example, be used to temporarily stop producing until
__ptr_ring_peek() indicates that space is available again.

Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 include/linux/ptr_ring.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index 534531807d95..a5a3fa4916d3 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -96,6 +96,14 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
 	return ret;
 }
 
+static inline int __ptr_ring_produce_peek(struct ptr_ring *r)
+{
+	if (unlikely(!r->size) || r->queue[r->producer])
+		return -ENOSPC;
+
+	return 0;
+}
+
 /* Note: callers invoking this in a loop must use a compiler barrier,
  * for example cpu_relax(). Callers must hold producer_lock.
  * Callers are responsible for making sure pointer that is being queued
@@ -103,8 +111,10 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
  */
 static inline int __ptr_ring_produce(struct ptr_ring *r, void *ptr)
 {
-	if (unlikely(!r->size) || r->queue[r->producer])
-		return -ENOSPC;
+	int p = __ptr_ring_produce_peek(r);
+
+	if (p)
+		return p;
 
 	/* Make sure the pointer we are storing points to a valid data. */
 	/* Pairs with the dependency ordering in __ptr_ring_consume. */
-- 
2.43.0

