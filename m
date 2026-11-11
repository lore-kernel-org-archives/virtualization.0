Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.191
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405027;
	b=h1TnMfSJ9/wD8BmNMo4NKCdrMoTs4aCYElUrve3ZRsZ8PrRdUFFsN5SiKLcgLa2+Oujd
	 xkbFkRrUzWOM5JKUAr0exuTX37i9GPy8JHaKVN0ehrgbksqZx7ChH3ELeOZIb8F0AYLIz
	 IFWS2jyAhX0yLwAh5Tr5avrsVGP+c612pdJCus1eqDfoBUoTEY/OU0VDYBNz/wm/aFS8P
	 8tH2pwV2+LNEKA652h9Bi3gYZib/TMxLe+BTmdnB4Tz94hdJwEEKHcL7hwil74KjDydso
	 bMLrfBjo3xfWB+cO2CuIgjdZdcVBko6gUuzkB8KTO95Bi2cchEcsfQlwmGkjMKyuENw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405027;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=W0fVDpxe9XYsp0i+6ZgSyoLxBF06zc9LwPS7rJSHqiY=;
	b=pZbWv0mi66aull6KdzPgW/gboqt2inySRqngX/XI6YX1LK66MPTKJ1LbeBGw3aJjAx8X
	 FvHij7mRheW72ePX9l/OINEIVHBaOEIuoNUB12LY555M15PgvJEQY60W2B2HcTLk/fi2s
	 i55YQBUee/5VVgQHopt8MBkeCSGkQhe2+NoVss8GjOIKTWlTZtRg3SbULvkq7AyzBdfEr
	 7jfjJV/BH9Sg6Bva1oVvnJRWJ3ob4YciGRf4MR4W2kdU1zB/vrXruY3HzjDI/Cb8qmcvs
	 BayMWRy1IX6g/K/PtH7/aLa5fU47yHpRfE0l2vXTFTj7NFbPGTeIkKbG/Mq10a6hO9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b="rPme4P+/";
	arc=none smtp.remote-ip=203.205.221.191
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9095060A2609
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 13:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9095060A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=rPme4P+/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794405022; bh=W0fVDpxe9XYsp0i+6ZgSyoLxBF06zc9LwPS7rJSHqiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rPme4P+/qiH/Pg+F4luIQYFEUSNQStcJZLz1LMFChkiE4oK4kzNgRBsA3bxkm53bl
	 bfZ+XthEg54ZyffI1B7v0OEWHJN4ZtsCFS3TaVuBrCOXBhG8q97k7uVD4MUjQj6rN8
	 kuV3fvqqBErq3pf52DYPNjLslSneAAJcRDmQ08bo=
Received: from ubuntu.. ([112.3.92.91])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id C92862E4; Wed, 11 Nov 2026 21:50:18 +0800
X-QQ-mid: xmsmtpt1794405018t57z251ok
Message-ID: <tencent_74EA7A2E8BF5758E9C5EF18C9B1CED401D06@qq.com>
X-QQ-XMAILINFO: NBPcaZsd6bGOn8PNIyEDiAC51qdQli4kKvysCslyWIriXpR9YHSu/ay962/2Ft
	 B2HFSrnWFcTaaj2G/smw6YmkSR9rApmrNbyiXuxSZWVF8KYN7+RfiU43ImKHcFX9pkbkqD1JFxtN
	 SRrtWGdG+RF8XG0Oxcf0cQWPEwNFRlxNYq/IEhc5Zz9miMOMps4ze5/YEemkLZzTNPJuwuLBG54m
	 wcjGi1M9w2cZ3+zaudwK8g7lcbusUq3/Uscyxj6UmuBW6//OEMOqR1ZD1LIIi628MalH3dbi6JOf
	 7EprQ8hq499q02sjEtVwAEhy57L6Y1RMPNCX2Zk+CbIHz8v2UWxpBNNbxGZRaE9qmT/TiB49EYEb
	 GWsF4S9yRMqmcLdjQB4PFBlg1TiRp8FUIYNhKCldDJvHsB6pZ2cZLtFFOkv1TJlLhZbVvu/RlaoL
	 LAODtPl7OSiV5ee2nGsJEhK5H2kODChJznoo0egtwQ8o6wDvtC2y5oWgQ/Hsp5WAHpH9c0GhCyVZ
	 y3jf2kKbCKakxqK/Oz1Uup1A1AKXLWrAfiA7yEvHQWhL2uRvH80f4UqXLK+rWbXguo/PCTIqxYL5
	 Bw1hlYixyzmrP28LbiLFVvjRsBBm6BJ6i7BF9S5rBvaJDQPmbheIenbXCNemYkG7+zhJCOtgyK5m
	 oVwFSQevSHB/OzrC093FMWBOTPIkXlug3I+3QozfrTP9Y9laXnK/G6TimoF4V4p4pn+OClYkfoPX
	 MQ16IMz8xIPiUp4g7rLbuTUFqIsp7GnQuTo6z88DaWtnowRJEba1e9FeRbhl98aqAOCJ2jLzv+Oz
	 G21LSKIAqr5SHUDSnvkxLLt7Vz/3S47Cs2KBO7J+cYd+tGDXXH/Ekr+YY9VqnN29n/Z3iZVtTHBQ
	 Gz5nJKBRnidh4P14uQ1Uzcrt1vTQ7bjj4s2hRtA91PWDVXBjG2AfKiWTjA+35T1BG+Z9AfmybWIr
	 L42LlFDM7tJVxOXWZ7ISxKl51h5DtCp90uCLKtnHg5oxNFjCEMdSbaGV4KUDj77llWpXrlJLGFpU
	 3NnXy//iKXgFVyoasNnAJ6CIx3evYU/IIyhP9E5W3kuhWKngg7KFUn89us/VcZpB+MQ1r8eHImS+
	 sCYmYytPqyDC0gyWOuh3BhZZYLAsx6p8rjn1qfhMXfdx6ED+w8ojqF12HxgBXdZk7E5A3ECH47G5
	 mC3m9jpdG9J9NRwQ==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Congjie Zhou <zcjie0802@qq.com>
To: netdev@vger.kernel.org
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zcjie0802@qq.com
Subject: [PATCH net 1/2] net: napi: add completion with an ordered IRQ mask callback
Date: Wed, 11 Nov 2026 21:50:07 +0800
X-OQ-MSGID: <20261111135008.1048054-1-zcjie0802@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_AA4F39DA7ADE330C721C03AAA832B92DD608@qq.com>
References: <tencent_AA4F39DA7ADE330C721C03AAA832B92DD608@qq.com>
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

napi_complete_done() can clear SCHED, arm the watchdog and return false
when deferring hard IRQs. A false return therefore does not guarantee
that the caller still owns NAPI. Masking interrupts after this return
can overwrite the interrupt state established by a successor poll.

Add napi_complete_done_with_irq_mask() with a mask callback that runs on
false-return paths before ownership can be handed off. The callback
must be non-sleeping, idempotent and leave NAPI state unchanged, since
a state-update retry may invoke it more than once.

Keep napi_complete_done() as a wrapper without a callback, and inline
the shared implementation to eliminate the callback path for existing
callers.

Signed-off-by: Congjie Zhou <zcjie0802@qq.com>
---
 include/linux/netdevice.h | 18 ++++++++++++++++++
 net/core/dev.c            | 29 +++++++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 435be7880..810527cd8 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -601,6 +601,24 @@ static inline void napi_schedule_irqoff(struct napi_struct *n)
  */
 bool napi_complete_done(struct napi_struct *n, int work_done);
 
+/**
+ * napi_complete_done_with_irq_mask - complete with an ordered IRQ mask callback
+ * @n: NAPI context
+ * @work_done: number of packets processed
+ * @mask: non-sleeping, idempotent device interrupt mask callback
+ * @data: callback argument
+ *
+ * Like napi_complete_done(), but call @mask on false-return paths before
+ * releasing NAPI ownership. Drivers which prepare interrupt rearming before
+ * completion must not mask interrupts after ownership has been released.
+ * The callback must not modify NAPI state and may run more than once if the
+ * state update is retried.
+ *
+ * Return: false if device interrupts have been masked by the callback.
+ */
+bool napi_complete_done_with_irq_mask(struct napi_struct *n, int work_done,
+				      void (*mask)(void *data), void *data);
+
 static inline bool napi_complete(struct napi_struct *n)
 {
 	return napi_complete_done(n, 0);
diff --git a/net/core/dev.c b/net/core/dev.c
index df1a840b0..4ba9e4c1b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7001,7 +7001,10 @@ void __napi_schedule_irqoff(struct napi_struct *n)
 }
 EXPORT_SYMBOL(__napi_schedule_irqoff);
 
-bool napi_complete_done(struct napi_struct *n, int work_done)
+/* Inline so the legacy API eliminates the optional mask callback path. */
+static __always_inline bool
+__napi_complete_done(struct napi_struct *n, int work_done,
+		     void (*mask)(void *data), void *data)
 {
 	unsigned long flags, val, new, timeout = 0;
 	bool ret = true;
@@ -7013,8 +7016,11 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 	 *    the guarantee we will be called later.
 	 */
 	if (unlikely(n->state & (NAPIF_STATE_NPSVC |
-				 NAPIF_STATE_IN_BUSY_POLL)))
+				 NAPIF_STATE_IN_BUSY_POLL))) {
+		if (mask)
+			mask(data);
 		return false;
+	}
 
 	if (work_done) {
 		if (n->gro.bitmask)
@@ -7047,6 +7053,13 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 	do {
 		WARN_ON_ONCE(!(val & NAPIF_STATE_SCHED));
 
+		/*
+		 * A false result is not proof of retained ownership. Mask
+		 * before the state transition lets another CPU enter poll.
+		 */
+		if (mask && (!ret || (val & NAPIF_STATE_MISSED)))
+			mask(data);
+
 		new = val & ~(NAPIF_STATE_MISSED | NAPIF_STATE_SCHED |
 			      NAPIF_STATE_SCHED_THREADED |
 			      NAPIF_STATE_PREFER_BUSY_POLL);
@@ -7069,8 +7082,20 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 			      HRTIMER_MODE_REL_PINNED);
 	return ret;
 }
+
+bool napi_complete_done(struct napi_struct *n, int work_done)
+{
+	return __napi_complete_done(n, work_done, NULL, NULL);
+}
 EXPORT_SYMBOL(napi_complete_done);
 
+bool napi_complete_done_with_irq_mask(struct napi_struct *n, int work_done,
+				      void (*mask)(void *data), void *data)
+{
+	return __napi_complete_done(n, work_done, mask, data);
+}
+EXPORT_SYMBOL(napi_complete_done_with_irq_mask);
+
 static void __skb_defer_free_flush(struct skb_defer_node *sdn, int budget)
 {
 	struct llist_node *free_list;

base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
-- 
2.43.0

