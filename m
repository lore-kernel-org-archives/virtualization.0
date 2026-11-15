Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794726784;
	b=abLXOygK24PLSKcf0KX1ZoFKtTuXsGnqOyUId0OwEVlccutByrhBN4WMGXcscx9MeO0a
	 TMRwuHoosQGK+V6Mlp96re/DT/TGklTD13N33fIAqwsSIKwBx7d0CSHEdvcGMeFtmlsnU
	 UgSsp1bjv4tn+xopy3asO59S+xGKjKNdGJEl6baHOIc3UW1/8Hgw/Iz7ogH81uRK3NnMh
	 SQxR1qFuU1U+u1TfRwy57yd/Kl1GBPnrjKXf6Hk/esz9uihI9erH4hMnLdbvmMwhkLGYc
	 arH586lA1+QYQysFg+AykhY8/puDDmMpW8x2ZiaD48QZDhhk6FkbiCUMNwvC/zSZm4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794726784;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0Z+TaypX6Nv4nbH4lcelIKsz6XBKBS8H3IpTVaphkkM=;
	b=zJH0Bc9FyFs1NL07ZAQmE3/E6rcQOK9ewVrdoC4H7w4mXIIYM7tGUsmAvY6WORP/MgdY
	 frTiUl85m51qUh+HVch0i+HjQqdPsHRN1hpgpsEvlwQKLkwnELGPpQi49CrnHSIXHMZnr
	 1aKsdQJUlVPThuDN02a7OyJJn6+4Ecpegkf/Y1xzCUlDos6Vq6MZVXg/c3yz3fDpk4iFN
	 Z7a8eDQ35mpaEYf/LKUix3g0DGmpRkKaBtkiJUpMGj/kSsTbDAE7RRuXDHCmGr33x/jvM
	 ojpq8SLifmcmxxyEUVaqNPWEsSQPhGHpp3VX7VceJeTJSopcOcMXKWAAYRd/fIFoZEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=xytmkvBI;
	arc=none smtp.remote-ip=43.163.128.43
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.43])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4794B606A323
	for <virtualization@lists.linux.dev>; Sun, 15 Nov 2026 07:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4794B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=xytmkvBI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794726773; bh=0Z+TaypX6Nv4nbH4lcelIKsz6XBKBS8H3IpTVaphkkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xytmkvBI4I1yUosmCtKrJ62gocZgx8c8HQqpRle8x2vIu1oSSNVkilMqAfTZLHPSV
	 HjoCSExMB49b6zGK+iMoyd6CwyDIVKlDjRSZT2Mn2l4PVQ30i+Xo1a58julnSPxggq
	 CMfom4kyIzty+CvxYzOvjUQYAY5jko4Oibu2T5wI=
Received: from ubuntu.. ([112.3.92.91])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 331A3A28; Sun, 15 Nov 2026 15:12:49 +0800
X-QQ-mid: xmsmtpt1794726769tl3iiugjm
Message-ID: <tencent_2A5F8EBA9EC78CA99CD080386A68EE90B506@qq.com>
X-QQ-XMAILINFO: NdB5/PuY7PjGlSs9wjl/U+WvFpZYh9a6snnY723MQPkFp3jWEfdaUypSk6u9iO
	 UvE9UPD6/PP5l71k3VtBz8cfNcAa12joolprQjDypB06mvYblW86l8ZLdLRf39PZPN4161mefRqn
	 Q6saEYAAdxuYtKNRWlt6qPIyqkpX54tyfsvs1A4erDfb8DY4EVMiEvAL0npmAmbVziBM/oL5712Q
	 rMv+3Ni4mrtNS5xMIbgbmsiwn/qG7xOGQ5EtA7CLSabl/PWxeL+rw+Ja6PV/Zac0/fC7L+TIOTop
	 7y1PNLN40oQrgg0albd0+0OUF6YJXWEnb4rt8kEsb7KGMdAsFImo2SR+6jxsTZnO83a3v2wEIAc7
	 hXpZV4sS+JNEkgjW4qtt5Lt+ThUaLNmMoNxZqzRjwpu8gjLpIXDogx61wY+LYYo+R2FXVEck+/1P
	 1o5UooS9L+d0c2Mq4yCBQp5/G/C436vMIfxElG1UwR3G8OSz08h+4eWiN1myiqac3tjWkITiJDuD
	 jZcEMnIve2iAbC/s+9CKTd2GQN0g4oEn2ngtCarzsvuSLrJjgUUM5/50bdHcS2ogsNodcrsdpBiL
	 0n/nn/dedKobCFvgydIuVhRjt9UCKgI+YmNxZYh/EPU2yTQMSlg7En4UoWdhtPwHOL9jRTWkHy0c
	 4vGW0xKK0Y1CV3EMYK587SDQM5vghaD3WqYUNeuVxSs3y30f5wc6qzylLUwfO79On4BIjjfh70fl
	 oxXNNcSN9AhElrjAQuf3146s95kFPoLQq1pun5pbu5xKSojIfmHzRa9gYUxYVYbo944onVluCZbs
	 o/ZbTaZO3DjYoVkJX1OX8xbE/CV+PNBtx4rE1j3Ps/XS9PBh70yAnVCdDxcykw8UhFkv4PLCrNFR
	 K/4KgsZ4gt3mmncUsPGPMYD7Afrd5FYsbGxB+QhWEKaTbTq7e194Kv3w+CwcWt5StnktRh72BU4j
	 s0lPAJ787awXGjxqqADtAToXlOeYC28j5ul6iCcTdv4Mk7mP2px7mOI5PyhzQBAgAdD89fv0ipNG
	 Ru5i2x+CQebhLTidbIafsg7BZtHIeZrwkIZCfJCxtW4LIc5wznE461GF1M/KTK9uzSY/2rObMUyr
	 ZbP9g+s9PP++VvNDk=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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
Subject: [PATCH net v2 1/2] net: napi: add completion with an ordered IRQ mask callback
Date: Sun, 15 Nov 2026 15:12:45 +0800
X-OQ-MSGID: <20261115071246.9096-1-zcjie0802@qq.com>
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
Changes in v2:
 - Add the Fixes tag to patch 2/2; no code changes in either patch.

v1: https://lore.kernel.org/netdev/tencent_74EA7A2E8BF5758E9C5EF18C9B1CED401D06@qq.com/
Bug report: https://lore.kernel.org/netdev/tencent_AA4F39DA7ADE330C721C03AAA832B92DD608@qq.com/
Discovery and validation: https://lore.kernel.org/netdev/tencent_4DBDF69909B9FD811F54F2DC0E6BAC1C0507@qq.com/

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

