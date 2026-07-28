Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E919388E7C;
	Tue, 28 Jul 2026 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785230804; cv=none; b=kf772DA5P7hwTx7spD3SQo65tGwhBAdCO1yJJT5tx9DBdxEOZijNyQ6U2Frltvh4RSvT5kLTScO5po+I1oBe8TxPSJD93EvIeIFAtWygYVrAee9ZQsNOR5Mw9MSCuKVdg7Ls3CnS8j0aoQeFbSXeFFTI14H/Mm/KPBLr/B3TSA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785230804; c=relaxed/simple;
	bh=5JjSdElpKzh+RWzeLc5cfee2BTBxyfX2vGo/cnlEx1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WsGW7lWVYEMfuIGmg2VXMS2juUBFRdgmBjNkOsLRwytjF4+KyEDDzhy9DnDAm+lJp5m66Falh4uc1CbyMaK08IOymYEyGqiCshxCOLqhxT2ZebvY86DcUit/9Rn0TgHtWXZkPN7+S7aVO0f1Pj+myBgt5+S7qnZgZgUp7ntO0Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=U3CmBNRI; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="U3CmBNRI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1785230603;
	bh=hrcP81Q5xEqsu0frztZRi/0gEcsV7q/oPN45oNEfVO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U3CmBNRIyrnxZGE2hnbphNv4zge7GLPrDWjf/C7H7fyVJ6kv8WR8WM3btBaWDVj9y
	 Pa0HRDLhv9LQyo1o11YghRwtOsMoF6zxQICFPEx74c06gKVycqaSZaqrSQO0TwB7La
	 +rXR8HSNEwjhVfBlKsASb/bujA7Tq6sO2eFxnymQ=
Received: from simon-Latitude-5450.cni.e-technik.tu-dortmund.de ([129.217.186.117])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 66S9NL4Q004577
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 11:23:22 +0200 (CEST)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowangio@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Tim Gebauer <tim.gebauer@tu-dortmund.de>,
        Brett Sheffield <brett@librecast.net>, kvm@vger.kernel.org,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        Simon Schippers <simon.schippers@tu-dortmund.de>
Subject: [PATCH net 2/4] Revert "ptr_ring: move free-space check into separate helper"
Date: Tue, 28 Jul 2026 11:22:38 +0200
Message-ID: <20260728092240.250257-3-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728092240.250257-1-simon.schippers@tu-dortmund.de>
References: <20260728092240.250257-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit fba362c17d9d9211fc51f272156bb84fc23bdf98.

__ptr_ring_check_produce() has no users left after reverting
commit 1d6e569b7d0c ("tun/tap & vhost-net: avoid ptr_ring tail-drop
when a qdisc is present").

Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 include/linux/ptr_ring.h | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index c95e891903f0..d2c3629bbe45 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -96,20 +96,6 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
 	return ret;
 }
 
-/* Note: callers invoking this in a loop must use a compiler barrier,
- * for example cpu_relax(). Callers must hold producer_lock.
- */
-static inline int __ptr_ring_check_produce(struct ptr_ring *r)
-{
-	if (unlikely(!r->size))
-		return -EINVAL;
-
-	if (data_race(r->queue[r->producer]))
-		return -ENOSPC;
-
-	return 0;
-}
-
 /* Note: callers invoking this in a loop must use a compiler barrier,
  * for example cpu_relax(). Callers must hold producer_lock.
  * Callers are responsible for making sure pointer that is being queued
@@ -117,10 +103,8 @@ static inline int __ptr_ring_check_produce(struct ptr_ring *r)
  */
 static inline int __ptr_ring_produce(struct ptr_ring *r, void *ptr)
 {
-	int p = __ptr_ring_check_produce(r);
-
-	if (p)
-		return p;
+	if (unlikely(!r->size) || data_race(r->queue[r->producer]))
+		return -ENOSPC;
 
 	/* Make sure the pointer we are storing points to a valid data. */
 	/* Pairs with the dependency ordering in __ptr_ring_consume. */
-- 
2.43.0

