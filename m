Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550C539B497;
	Sun, 10 May 2026 15:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778426277; cv=none; b=TBrC3aKhGedAvauAYJDnkwOVftqxfxMCj3NtKd7QTZTgIgbZsTJIVHN/eIkyZ7ZYjUEhIcicKDOpSiRyZxOxa4FIhZ1miunBUx5XOFjTn16t2UsElwnHegdUwKcVG7XUrp5QKiPMYZcTdsR1LKYt1X+1yK/7UMEqo/uwcwGVPBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778426277; c=relaxed/simple;
	bh=inU863N1S0Wz3nqs95hMQKdZEMGNYnr8+oPFXullAts=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvSjGWK2V3b9Hr0XO5iWnNxMM63BcVM/bTHPc2djXBTNw+SayQU2N4cywZ6jc5gkG45lns+w4YJR8owKUgKAmoVMlzLDprZ5ONfzRVOw19f2cxiq5tS5PHLVAwC+UFHKqqLIiPrpKTxmcVsLt4fjKHQ3piZ3rgzCcjHVjQ1FT/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=jJsNvSfM; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="jJsNvSfM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1778426259;
	bh=inU863N1S0Wz3nqs95hMQKdZEMGNYnr8+oPFXullAts=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=jJsNvSfM1u/55cJHMCjd0w8FjyGAUuYmAoweCEMWll+4zjXdkxYTVNYEXebtPZyRU
	 H/efAbVXvEM9+ytW2NuHjkiDu2i8U/nqreNeGXSTWXWJNOX0DqlBwDeFIW92uoK3OJ
	 F9zzxOVdevlny9FPGHsONtGYetfAXFgSEaoe3KcY=
Received: from simon-Latitude-5450.fritz.box (pd9eaa57d.dip0.t-ipconnect.de [217.234.165.125])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.1/8.19.0.1) with ESMTPSA id 64AFHaTE009831
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 10 May 2026 17:17:39 +0200 (CEST)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
        eperezma@redhat.com, leiyang@redhat.com, stephen@networkplumber.org,
        jon@nutanix.com, tim.gebauer@tu-dortmund.de,
        simon.schippers@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
Subject: [PATCH net-next v12 3/4] ptr_ring: move free-space check into separate helper
Date: Sun, 10 May 2026 17:15:28 +0200
Message-ID: <20260510151529.43895-4-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260510151529.43895-1-simon.schippers@tu-dortmund.de>
References: <20260510151529.43895-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch moves the check for available free space for a new entry into
a separate function. Existing callers that only check for a non-zero
return value are unaffected; __ptr_ring_produce() now returns -EINVAL
for a zero-size ring and -ENOSPC when full, whereas before both cases
returned -ENOSPC. The new helper allows callers to determine in advance
whether subsequent __ptr_ring_produce() calls will succeed. This
information can, for example, be used to temporarily stop producing until
__ptr_ring_check_produce() indicates that space is available again.

Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 include/linux/ptr_ring.h | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index d2c3629bbe45..c95e891903f0 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -96,6 +96,20 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
 	return ret;
 }
 
+/* Note: callers invoking this in a loop must use a compiler barrier,
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
@@ -103,8 +117,10 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
  */
 static inline int __ptr_ring_produce(struct ptr_ring *r, void *ptr)
 {
-	if (unlikely(!r->size) || data_race(r->queue[r->producer]))
-		return -ENOSPC;
+	int p = __ptr_ring_check_produce(r);
+
+	if (p)
+		return p;
 
 	/* Make sure the pointer we are storing points to a valid data. */
 	/* Pairs with the dependency ordering in __ptr_ring_consume. */
-- 
2.43.0

