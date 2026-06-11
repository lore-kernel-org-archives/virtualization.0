Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9FF3B52F4
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161995; cv=none; b=IbVJV1hl+Bo0re9phRU+NBPl+Cw6jtFYLfTTWj2gCGZY4FSDWuz3DkCbD7loZPnBV5Hm/AmHmLmZgEj882gN9CKvBl0dom9gUg64ZSwBEz9uBuBYusGtbhuiV2REwr4F/ZsuOrKEXm/luzCoYNmDmI9dWy7r3VuTkU93deu1Apk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161995; c=relaxed/simple;
	bh=ufFawdkbPQyxtvP/vY4bfmggah69hAiP4MacVPkP8Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zy/sLSp2cKuc8FYurjijBxUl4Zi8MtUxJoQUAIbuiD8hM9ujzZwpPR4QSCyPfqq7yE0ytHtWGTfGmqYXwfbK1kNjpT4ATWQuynYQJfSy5Bh7YcpjXIO9Ptw5DM6vNpZw7DjjqZWvg40j7VbzgVwCbS3dM4IAecRF2aOPJSXhQmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qVd7itC9; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVd7itC9"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-7efd49373c0so53988387b3.1
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 00:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781161993; x=1781766793; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vZX9ZLsq7+qZlX0ydHeLJ+45hrHGXpIcH8h2xOtT/8=;
        b=qVd7itC9ctkvqKNA4+WcC6A8t7lpqv/wfy/hHq/80OSebZKp5ebljEfPEDOsPB++tg
         WPhODp08xgWUBw4CP8+hb4F4WDWn0OEecSIrF+dvv10nWu62vPNc5O4BLhIVb8Nd6wSm
         dZAHMTHF/SvmJPbJhLIe07LgvvHp2OdlzG9JQ8spT5oJJob3PIMEE2fQSb5dz1gTDKys
         djkVZIxPkWzj2DHR21jL68vALF+hPaEheD+evqWeJApyWfwprraJoQAqZHZhetDMnAMK
         eD4aTARPfWQ0y/YVZtxrKf8Q7TlEJnAivVeGM0fi22IiTCWjfSQ0UEaENjFPeZlTNTAd
         7/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781161993; x=1781766793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5vZX9ZLsq7+qZlX0ydHeLJ+45hrHGXpIcH8h2xOtT/8=;
        b=rbtbigzyeUjDwLvIE6Yryn1Xi5O1kDLzLsHZMn1jiT6Fj3nAcUSFLbRzrKF1JFPfuZ
         cer7210rPLSHaOINW9+t3oHTHLYrxi/pWmu+7thBFrd1nK02X8NE23KILEEogb6hw2kx
         LDyK0QV5l0nxFnGi9GsnnJNJa9bqbx0bw0BKINKkCsV4Iw7sv+fJLPlM2G/2CdkYXQhG
         b1zb1SFyf+FKQWE0AbR5x0U1jiVYOdppMGkUsz+ALIleIJ91cTfty3S3kSrrr4nqWFBP
         JwHYf/Rn8TqlkEUeMC8fteGPzlgOP13yscewfHHR04H5AZ4xEiL/Ox2w87KE+Hov0TuZ
         ve1g==
X-Forwarded-Encrypted: i=1; AFNElJ/QLtekEf/LxzTMoPu5sUOcHEOlbDXeNTs2ckGPhK5y9mPzBOeYKgmQAXYvbQspVRmqnHPpkEKnhdQh6xb9dQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwH1glkBsmNgDWPa8OatY4/loQQkN0q7AapDEdX+JO6AdLVkIPC
	/rs2KFMcjdalKSoxikUHguk384cw9i+pd3MtvW/FrRZ3UUqmmvC3N+y8
X-Gm-Gg: Acq92OHL9kQqmfEHs2+4alNOuEJLnJbU6MDMktZ+w3lBzTMO5eMV9x8NM3W0bqzu9eN
	0SlHBY1MJdrv+FoC75dHanTaH5MzHSY+ARBQXAbhGt3b/SbhjvfHjXm8mDDqNqc/p9SbeyXghwN
	D09IcYIKwUtggNeHCKA+jSVFC67gwersHy5s1aWeb+ckK6Dy+BxOuwjhlzbDRoO9XuOUnJMcteq
	bd80Qprpozx3QM4p6vxvycSPp3WlXc5FPqg+XE63jjyFdU9WOZfxkPKrgdHQk0J9UtE5zbNAXSO
	LZ+5nbqeIuDgRJTQUj9rB//FEiwjdFOCDNUtL3lnljfimL7VtSTfW02jfAEWAdA4hAAvDEhmQ2G
	Az4htvsmoky+nlSX4y5zZwnD2DObbHVXJLs30h8rXZGf+Vx3jW0n+AaMYf4xd10iMkrNIVhbtLn
	jqq9egQAIJOh9lQxxOan31J10AiPOksGDHXfHzKIXUm/qsGnYbtctR9G/OAsITcQ==
X-Received: by 2002:a05:690c:c4c9:b0:7dd:63c7:39b6 with SMTP id 00721157ae682-7f655007fb6mr16817817b3.9.1781161992785;
        Thu, 11 Jun 2026 00:13:12 -0700 (PDT)
Received: from localhost.localdomain ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7f693504701sm2551487b3.15.2026.06.11.00.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 00:13:12 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: dongml2@chinatelecom.cn
To: jasowang@redhat.com
Cc: mst@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bjorn@kernel.org,
	kerneljasonxing@gmail.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next 1/3] net: busy-poll: introduce sk_tx_busy_loop()
Date: Thu, 11 Jun 2026 15:12:40 +0800
Message-ID: <20260611071242.2485058-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611071242.2485058-1-dongml2@chinatelecom.cn>
References: <20260611071242.2485058-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <dongml2@chinatelecom.cn>

For now, we use sk_busy_loop() for both rx and tx path. The sk_busy_loop()
will call napi_busy_loop() for the specified napi_id. However, some
nic drivers have tx napi, such as virtio-net. In this case, sk_busy_loop()
doesn't work, as it can only schedule the NAPI for the rx queue.

Therefore, introduce sk_tx_busy_loop() for the nic drivers that support tx
napi, which will schedule the tx napi if available.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/netdevice.h |  1 +
 include/net/busy_poll.h   | 41 ++++++++++++++++++++++++++++++++++++---
 net/core/dev.c            | 26 +++++++------------------
 3 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0e1e581efc5a..8a771b014d54 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -416,6 +416,7 @@ struct napi_struct {
 	int			napi_rmap_idx;
 	int			index;
 	struct napi_config	*config;
+	struct napi_struct	*tx_napi;
 };
 
 enum {
diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
index 6e172d0f6ef5..0959e80272c7 100644
--- a/include/net/busy_poll.h
+++ b/include/net/busy_poll.h
@@ -33,6 +33,12 @@ static inline bool napi_id_valid(unsigned int napi_id)
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
 
+enum {
+	NAPI_F_PREFER_BUSY_POLL	= 1,
+	NAPI_F_END_ON_RESCHED	= 2,
+	NAPI_F_TX_NAPI		= 4,
+};
+
 struct napi_struct;
 extern unsigned int sysctl_net_busy_read __read_mostly;
 extern unsigned int sysctl_net_busy_poll __read_mostly;
@@ -49,9 +55,9 @@ static inline bool sk_can_busy_loop(const struct sock *sk)
 
 bool sk_busy_loop_end(void *p, unsigned long start_time);
 
-void napi_busy_loop(unsigned int napi_id,
-		    bool (*loop_end)(void *, unsigned long),
-		    void *loop_end_arg, bool prefer_busy_poll, u16 budget);
+void __napi_busy_loop(unsigned int napi_id,
+		      bool (*loop_end)(void *, unsigned long),
+		      void *loop_end_arg, unsigned int flags, u16 budget);
 
 void napi_busy_loop_rcu(unsigned int napi_id,
 			bool (*loop_end)(void *, unsigned long),
@@ -60,6 +66,17 @@ void napi_busy_loop_rcu(unsigned int napi_id,
 void napi_suspend_irqs(unsigned int napi_id);
 void napi_resume_irqs(unsigned int napi_id);
 
+static inline void napi_busy_loop(unsigned int napi_id,
+				  bool (*loop_end)(void *, unsigned long),
+				  void *loop_end_arg, bool prefer_busy_poll, u16 budget)
+{
+	unsigned int flags = prefer_busy_poll ? NAPI_F_PREFER_BUSY_POLL : 0;
+
+	rcu_read_lock();
+	__napi_busy_loop(napi_id, loop_end, loop_end_arg, flags, budget);
+	rcu_read_unlock();
+}
+
 #else /* CONFIG_NET_RX_BUSY_POLL */
 static inline unsigned long net_busy_loop_on(void)
 {
@@ -126,6 +143,24 @@ static inline void sk_busy_loop(struct sock *sk, int nonblock)
 #endif
 }
 
+static inline void sk_tx_busy_loop(struct sock *sk, int nonblock)
+{
+#ifdef CONFIG_NET_RX_BUSY_POLL
+	unsigned int napi_id = READ_ONCE(sk->sk_napi_id);
+	unsigned int flags = NAPI_F_TX_NAPI;
+
+	if (READ_ONCE(sk->sk_prefer_busy_poll))
+		flags |= NAPI_F_PREFER_BUSY_POLL;
+
+	if (napi_id_valid(napi_id)) {
+		rcu_read_lock();
+		__napi_busy_loop(napi_id, nonblock ? NULL : sk_busy_loop_end, sk, flags,
+				 READ_ONCE(sk->sk_busy_poll_budget) ?: BUSY_POLL_BUDGET);
+		rcu_read_unlock();
+	}
+#endif
+}
+
 /* used in the NIC receive handler to mark the skb */
 static inline void __skb_mark_napi_id(struct sk_buff *skb,
 				      const struct gro_node *gro)
diff --git a/net/core/dev.c b/net/core/dev.c
index 0c6c270d9f7d..645a2e851918 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6878,11 +6878,6 @@ static void __busy_poll_stop(struct napi_struct *napi, unsigned long timeout)
 		      HRTIMER_MODE_REL_PINNED);
 }
 
-enum {
-	NAPI_F_PREFER_BUSY_POLL	= 1,
-	NAPI_F_END_ON_RESCHED	= 2,
-};
-
 static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 			   unsigned flags, u16 budget)
 {
@@ -6932,9 +6927,9 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 	local_bh_enable();
 }
 
-static void __napi_busy_loop(unsigned int napi_id,
+void __napi_busy_loop(unsigned int napi_id,
 		      bool (*loop_end)(void *, unsigned long),
-		      void *loop_end_arg, unsigned flags, u16 budget)
+		      void *loop_end_arg, unsigned int flags, u16 budget)
 {
 	unsigned long start_time = loop_end ? busy_loop_current_time() : 0;
 	int (*napi_poll)(struct napi_struct *napi, int budget);
@@ -6951,6 +6946,9 @@ static void __napi_busy_loop(unsigned int napi_id,
 	if (!napi)
 		return;
 
+	if ((flags & NAPI_F_TX_NAPI) && napi->tx_napi)
+		napi = napi->tx_napi;
+
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		preempt_disable();
 	for (;;) {
@@ -7015,6 +7013,7 @@ static void __napi_busy_loop(unsigned int napi_id,
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		preempt_enable();
 }
+EXPORT_SYMBOL(__napi_busy_loop);
 
 void napi_busy_loop_rcu(unsigned int napi_id,
 			bool (*loop_end)(void *, unsigned long),
@@ -7028,18 +7027,6 @@ void napi_busy_loop_rcu(unsigned int napi_id,
 	__napi_busy_loop(napi_id, loop_end, loop_end_arg, flags, budget);
 }
 
-void napi_busy_loop(unsigned int napi_id,
-		    bool (*loop_end)(void *, unsigned long),
-		    void *loop_end_arg, bool prefer_busy_poll, u16 budget)
-{
-	unsigned flags = prefer_busy_poll ? NAPI_F_PREFER_BUSY_POLL : 0;
-
-	rcu_read_lock();
-	__napi_busy_loop(napi_id, loop_end, loop_end_arg, flags, budget);
-	rcu_read_unlock();
-}
-EXPORT_SYMBOL(napi_busy_loop);
-
 void napi_suspend_irqs(unsigned int napi_id)
 {
 	struct napi_struct *napi;
@@ -7579,6 +7566,7 @@ void netif_napi_add_weight_locked(struct net_device *dev,
 	napi->poll_owner = -1;
 #endif
 	napi->list_owner = -1;
+	napi->tx_napi = NULL;
 	set_bit(NAPI_STATE_SCHED, &napi->state);
 	set_bit(NAPI_STATE_NPSVC, &napi->state);
 	netif_napi_dev_list_add(dev, napi);
-- 
2.54.0

