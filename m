Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108435;
	b=np3RUfhBvKw9evLrX8XgzCvedVHsbE2wO7D+i4Cvk89M1Z3b6VF/Qh9YKYJ+AdONl0a2
	 hGHTsp6YSzvKyVFqzGVnRZ8Xx2mdCQfWQwqmYI6Bv1cIUgacnXrCFFOdO0onI2Q0jIRrW
	 NnOTCWmf8JyjaTBeh2fgEHH9Zc4w6U6LI6hLh2ssyWt06WktXoo8Qqb+1mp2MfuefJMx7
	 pjshcMwfDWg6Jg+Zy1qYR9tM7u5va5esshfcFNlVeqY8H9A4LN+m772Yh3smoTVi9MlVq
	 519d7ZVhQLgFy+i6bmFFlKleb6w0n1a7WtnC4v5SmVE03PWK7x6gb1wzCkEzc9jHbSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108435;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=2lJR0AnwTJygazs23JNSPoGHwUkRi2+i1ThgrxLVwl0=;
	b=r/7NfFyO7feKXY9IG/81lsA0mJKb6A6h5IGeuGm7s3vJaKgVvsxihH+jwOIQaK8fkR6Q
	 NZeSzfocLHiRUeycnjR4mbTDxKaVeCVG9J/hmL8OyWMAmd+Y/My+LIpbVlvTaM44VMYzE
	 yez3DBSWIYq2hV6nSyY1iC9TQ6ttGsBe5cV2GTHTmuoSZClVkLUdAYhTkqEVbVqfgBbf+
	 PAUog7gIUmdt5KK3iHKwYxTrsCcnEfoQ0qkSxSIIR+KdGcSU49fkWzW1AKgz4hw9TX5W/
	 rDAoh2IGGiMoPlfBBvjOoWw63dXTXhQ2fYCFe1b63eTeNC8sQO/FnLaJ79/9f0eJqOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hWzjNpnG;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD60606A622
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 17:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFD60606A622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hWzjNpnG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795108433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=2lJR0AnwTJygazs23JNSPoGHwUkRi2+i1ThgrxLVwl0=;
	b=hWzjNpnGe9CnUXYJpF/8ZiV+0KNC96DBprKR3JMcc/LgXcPzRDn3DG1Cjj8wNZNLgIafn1
	fVaENpS6NdqD8+e3Rj7mmR3ySQthWqnD0OuoyR1gismu3Ur/1pp7p8f0m/VdtNMV++RDYY
	S6bKckZm+9FAWt7mgG2oaP8U/edfN1o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-NfUFZ2Y2Odmkj3b0incmSg-1; Thu, 19 Nov 2026 12:13:51 -0500
X-MC-Unique: NfUFZ2Y2Odmkj3b0incmSg-1
X-Mimecast-MFC-AGG-ID: NfUFZ2Y2Odmkj3b0incmSg_1795108429
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48c6a1d4034so1834226f8f.0
        for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 09:13:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795108428; x=1795713228;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2lJR0AnwTJygazs23JNSPoGHwUkRi2+i1ThgrxLVwl0=;
        b=Zl9aLtcwO1A7OKhuTOPgNArdDPeSeQpyYs5osr0+Wa84iPQE89fQKwHdZntcvUk8wv
         VQBuFUbH0YZ938AlnsQJGqOrltab1jnvUR1GAMIzASEnTeUwj4xRp5/OTzrt53QHuHFF
         eT6vh35KRq3VsmcK7J94pgurHWPs9ZcwP3kLQ65lB0kZdmNg3qPIkC7+IobSVS2LheK/
         olZ1mHTE0TwGmS+vfMLcJV9m2ucHGxIiklEiX619MPgQMAhwhY9lAAsUK7YDZtMvijrD
         MgqQ13fNF2j2E71i4umzfQ93Webk48TYU3qaxJd2bmimZM8mrP7RwrBxRHOlPbr8geYq
         xAHg==
X-Forwarded-Encrypted: i=1; AL+hErGbu4MHmMx/Gq6H4HTkjyDKIszhEZYl7dx7pcu3FMAiJP50ifxYTCYLgvkPfgAsGpjUjTcCwZ/Fu3JWNEPrlw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8jGIaeKMYFE4iNYruEo8ZCqGf6pyPGaVll3rfvkv8hPkuCmZtm
	fcW+I9fGe89D7jVPe7f3rgrSpZ+IghvtfmHAjloWrwV12xsoIWtvFMRIhvSAbnZYX9GEdoau4tJ
	A+8pknt1kDKEMQohCy3MoorS4hPy5XZYhwPvVNonao1tDB39UHgZ7ewViJZjCFGZzJbOE
X-Gm-Gg: AZFdTZcvYUGMYpRRg/Qk+6UYd1k96tEQFHx1qLZQ1Nf6v6/2EuR05POPb6YeXF92yL/
	iVOrYCMZaFOqAoyYY6EaqvQygLI8RtJOXh8pf8zGtvEC9BM6qstsUdow0LRT7pJpRzACeoKcga4
	tDDcJh6JO0MRHTR0gsh52t34MMcYDKZUzB2NNBkwPgkDdEAJxsBX7d5DS5jcmYG/M7+v4BOmhOX
	0eUeju5R1Be5xgBtAXIjpbv4XMZEdmtR3bojYfT/TAg7vF8UHI5dN/M/StYtZscNCfmaVXv7xx6
	3YGzv3lbMZXdH/3n3XojufkJTObq3c3zcC7ELXGBS/yxaem8A1/ue2nDCF/G1PXIGmSBwAsIA55
	b2XzvlQ/96JUy3oZyYwFrIFglbrKpgli/+I1aNI0bMQ==
X-Received: by 2002:a05:6000:26ca:b0:492:3176:3d64 with SMTP id ffacd0b85a97d-4abad5ac748mr34943f8f.8.1795108428401;
        Thu, 19 Nov 2026 09:13:48 -0800 (PST)
X-Received: by 2002:a05:6000:26ca:b0:492:3176:3d64 with SMTP id ffacd0b85a97d-4abad5ac748mr34864f8f.8.1795108427852;
        Thu, 19 Nov 2026 09:13:47 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1522:6500:ac93:c62:f076:48c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c61f558sm723019f8f.58.2026.11.19.09.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:13:47 -0800 (PST)
Date: Thu, 19 Nov 2026 12:13:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Congjie Zhou <zcjie0802@qq.com>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH net] virtio_net: mask callbacks before handing off NAPI
 ownership
Message-ID: <ad74886a8429a862c00d1e42f1dc746f2924b75f.1795108341.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yRvNlJBfrSgOPWVNabAMdf5lYwhYuE-243XlA4WlGug_1795108429
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Virtio is special in that enabling or disabling callbacks (interrupts)
accesses shared virtqueue state and must be serialized with polling. It
therefore enables callbacks before completing NAPI, and disables them
again if completion returns false.

With napi_complete_done(), that false return can come after ownership has
passed to another poll. The first poll can then disable callbacks after
its successor has enabled them, leaving RX stalled. Virtio therefore
needs to disable callbacks before handing off NAPI ownership.

Add a prepare/finish NAPI completion API so virtio-net can mask interrupts
before handing ownership off.

Reported-by: Congjie Zhou <zcjie0802@qq.com>
Closes: https://lore.kernel.org/netdev/tencent_D0650F8CA2AAE4C258BFE5BCE805CDB4CA0A@qq.com/
Fixes: 6f8b12d661d0 ("net: napi: add hard irqs deferral feature")
Message-ID: <20261119064843-mutt-send-email-mst@kernel.org>
Assisted-by: LLM
Tested-by: Congjie Zhou <zcjie0802@qq.com>

---

This preserves interrupt suppression without a callback or an additional
data-path barrier. Ordinary napi_complete_done() compiles identically in
the tested configuration.

Tested on x86-64 KVM with lock debugging, including IRQ deferral, concurrent
scheduling, busy polling, netpoll, and threaded NAPI. Split and packed
virtqueue TCP RX tests with IRQ deferral and busy polling also passed.

 drivers/net/virtio_net.c  |  4 ++-
 include/linux/netdevice.h |  9 +++++
 net/core/dev.c            | 69 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index dd2c41ef6fbe7..de370a39bc8fa 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -730,16 +730,18 @@ static void virtqueue_napi_schedule(struct napi_struct *napi,
 static bool virtqueue_napi_complete(struct napi_struct *napi,
 				    struct virtqueue *vq, int processed)
 {
+	struct napi_completion completion;
 	int opaque;
 
 	opaque = virtqueue_enable_cb_prepare(vq);
-	if (napi_complete_done(napi, processed)) {
+	if (napi_complete_done_prepare(napi, processed, &completion)) {
 		if (unlikely(virtqueue_poll(vq, opaque)))
 			virtqueue_napi_schedule(napi, vq);
 		else
 			return true;
 	} else {
 		virtqueue_disable_cb(vq);
+		napi_complete_done_finish(napi, &completion);
 	}
 
 	return false;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c0ae442c4344b..a182882624d6a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -599,6 +599,15 @@ static inline void napi_schedule_irqoff(struct napi_struct *n)
  */
 bool napi_complete_done(struct napi_struct *n, int work_done);
 
+struct napi_completion {
+	unsigned long timeout;
+};
+
+bool napi_complete_done_prepare(struct napi_struct *n, int work_done,
+				struct napi_completion *completion);
+void napi_complete_done_finish(struct napi_struct *n,
+			       struct napi_completion *completion);
+
 static inline bool napi_complete(struct napi_struct *n)
 {
 	return napi_complete_done(n, 0);
diff --git a/net/core/dev.c b/net/core/dev.c
index 3ac700d37e596..fa9baa70e9d72 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6999,9 +6999,17 @@ void __napi_schedule_irqoff(struct napi_struct *n)
 }
 EXPORT_SYMBOL(__napi_schedule_irqoff);
 
-bool napi_complete_done(struct napi_struct *n, int work_done)
+static __always_inline bool
+__napi_complete_done_finish(struct napi_struct *n, unsigned long timeout,
+			    bool ret, bool allow_pending,
+			    struct napi_completion *completion);
+
+static __always_inline bool
+__napi_complete_done_prepare(struct napi_struct *n, int work_done,
+			     bool allow_pending,
+			     struct napi_completion *completion)
 {
-	unsigned long flags, val, new, timeout = 0;
+	unsigned long flags, timeout = 0;
 	bool ret = true;
 
 	/*
@@ -7041,10 +7049,25 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 	}
 	WRITE_ONCE(n->list_owner, -1);
 
-	val = READ_ONCE(n->state);
+	return __napi_complete_done_finish(n, timeout, ret, allow_pending,
+					   completion);
+}
+
+static __always_inline bool
+__napi_complete_done_finish(struct napi_struct *n, unsigned long timeout,
+			    bool ret, bool allow_pending,
+			    struct napi_completion *completion)
+{
+	unsigned long val = READ_ONCE(n->state), new;
+
 	do {
 		WARN_ON_ONCE(!(val & NAPIF_STATE_SCHED));
 
+		if (allow_pending && (!ret || (val & NAPIF_STATE_MISSED))) {
+			completion->timeout = timeout;
+			return false;
+		}
+
 		new = val & ~(NAPIF_STATE_MISSED | NAPIF_STATE_SCHED |
 			      NAPIF_STATE_SCHED_THREADED |
 			      NAPIF_STATE_PREFER_BUSY_POLL);
@@ -7067,8 +7090,48 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 			      HRTIMER_MODE_REL_PINNED);
 	return ret;
 }
+
+bool napi_complete_done(struct napi_struct *n, int work_done)
+{
+	return __napi_complete_done_prepare(n, work_done, false, NULL);
+}
 EXPORT_SYMBOL(napi_complete_done);
 
+/**
+ * napi_complete_done_prepare - prepare NAPI completion
+ * @n: NAPI context
+ * @work_done: number of packets processed
+ * @completion: opaque completion token
+ *
+ * Return: true if NAPI is complete and interrupts may remain enabled;
+ * false if ownership is retained. On false, mask interrupts and call
+ * napi_complete_done_finish().
+ */
+bool napi_complete_done_prepare(struct napi_struct *n, int work_done,
+				struct napi_completion *completion)
+{
+	return __napi_complete_done_prepare(n, work_done, true, completion);
+}
+EXPORT_SYMBOL_GPL(napi_complete_done_prepare);
+
+/**
+ * napi_complete_done_finish - finish NAPI completion after masking interrupts
+ * @n: NAPI context
+ * @completion: token passed to napi_complete_done_prepare()
+ *
+ * The caller must provide any device-specific interrupt ordering.
+ */
+void napi_complete_done_finish(struct napi_struct *n,
+			       struct napi_completion *completion)
+{
+	if (unlikely(n->state & (NAPIF_STATE_NPSVC |
+				 NAPIF_STATE_IN_BUSY_POLL)))
+		return;
+
+	__napi_complete_done_finish(n, completion->timeout, false, false, NULL);
+}
+EXPORT_SYMBOL_GPL(napi_complete_done_finish);
+
 static void __skb_defer_free_flush(struct skb_defer_node *sdn, int budget)
 {
 	struct llist_node *free_list;
-- 
MST

