Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795089038;
	b=kU7GinUbBI3yJkbAnjiQACsg+OC8C9/yuyKw9D616qSBPltvpuCy+Jkq9qWBwBBpllTC
	 CouUmz0h3uHunCYKf6nenpeolNYCMGNCUk2pk14G7UYLtAik9KKP8cKiHtNzk5Y0yJ/G5
	 zg8eM1cKVDE0EFwEXEV3zF2Nnenlj8XoZ3pOTIZPoNTvg4CbMOddDq8uNSFNrMmytypOV
	 xQMvRsAlZbu3JwsNTGp/GyB76UFckRCZ4WtmY6+FrYMPPQWrJS1dXRkF3ybktnvOswZ/E
	 9O/4y5BMZvubMgL8/LyDxt1WV/ROphU1eoV1I2mBGy3C8A0dqoG6EyOTJO1hB/WhIag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795089038;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=0W+qwjoYXMK+Wkr2hnHwTmEZq17Go6E3zq5Ot2mWL14=;
	b=UqfKRTZ4PavS5oZ4OpjJViQrcHwk/M5pEW73/qPtyXxOCgD7w/HRHZeL8LXW3znh4eDj
	 oll5KFhi6VfU23gZ5Sr/utVsSXVoLHMs6hSQrikdUEXaEmn5ABGIXu8yPTBC3AY6ufxsU
	 T7hwRNXgce+lh82WNtQskmm6KTWKD/x146RuZ7wABgDbN0uvygBrhaxEeENxkJ7zvgGZd
	 2vnjZpAGoJPE4QncJLoZ2z2ymjtLhxQMh4umMnxT8G/ZZ/upaKM2S4vlG5KtyyiFRzGpk
	 onpHSVOsXPMU7ZRu3jLkjbo7H3ou6Q+KU9ZeCS5ZuZm5MXK0Nq4dD1kWu5PrkZ3gvDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EPTDUTzh;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CB4606A325
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 11:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4CB4606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EPTDUTzh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795089036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0W+qwjoYXMK+Wkr2hnHwTmEZq17Go6E3zq5Ot2mWL14=;
	b=EPTDUTzhsFb8KHl5FxBEkLWUKUarIKo/ViDoq+weFVu4X18bpzSmpt7/5ZBcVw4C2JKIX9
	pzIVzu1GqTDimQWwOLZaWZ6yV0ONlQUcSdWyQPwMQtl3L8eINceSrwyUZSwSQWcczhDYX9
	UvKXtKST9sEOtR/nRxXUR6sSpMzQ28g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-pH4feSwNMTCP7JDuFEV8rw-1; Thu, 19 Nov 2026 06:50:27 -0500
X-MC-Unique: pH4feSwNMTCP7JDuFEV8rw-1
X-Mimecast-MFC-AGG-ID: pH4feSwNMTCP7JDuFEV8rw_1795089027
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4ba01393800so13888115e9.1
        for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 03:50:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795089026; x=1795693826;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0W+qwjoYXMK+Wkr2hnHwTmEZq17Go6E3zq5Ot2mWL14=;
        b=1x9XmbrghbV5kDVhfmNWseiI2oJAy+22j93l6DtsDWHaTe6lSddwahdPlie+zVyTUV
         RbGGQ9vpQgqLM2Qc4FnNYE/RFO1K4Z1I6sdhJy7GxtSfbd69Epeq659PO5ryMCQ1uWs8
         yRI/C9wgV8owPVe2suql4TyTbkJzrHSoAdS6oixPxx6/PnYEeDfzLPRldXsjImiXYVnN
         BKyo8PuioskUPylvAyigRaTujdfPg/WDPrnGZcM4S9s2psrdZbdoNkWJCD2TYUt9So/s
         nNP7ApqHBhJtEM5HEJr9iNnZ9f/eyxD0EyRq9c2ehFrdY7o8246K2nS/xlrib9MEhjUN
         WrfQ==
X-Forwarded-Encrypted: i=1; AL+hErFVE2wF5lrm3PMnHV1MVbI5TDNMmYbYdC6I14WnXrr+QgW0altMSMGGGk1In8ISZxTIYu22rSN50eAPvBHCqA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/9pnrB/SVMsacDX13eNA857OgFQVdd135emqaaZznI29BN0N6S
	cSTC60O1bIKRrjipCxuyOaNrAVNr+YUF/IqweXdDfVut81FCNn8uBGLieUDJiZWiGbHsj+NcUTX
	WgbKx3ubtNBQF48daCaPLViRfz9ckXaVurMsbzhsHB1RUbsJDJdykAyNHfBkwGfjX3DVc
X-Gm-Gg: AYBFou2r47JICTOR/ILBX3E4Ek8H0VkMffYm71485YsOmU5S2bZMPgxJAcTlabXlyqR
	M/qPliDTRTsvC36LtkeBqOP9ticx3jt8tCM9/vawzYQVago1gVlJd9iBtvQ8owIts2nza+hCTti
	fGu2yMa2otZdEkueQV2J3Q//onqtocBEhauSQj9U57spVbUWybqKC0lpqY7lG4+Orhjh90YPFYw
	TJFl9PSodWcY6+i0yNv6DidmI7Z+/2Wq4FE6ZCkuc4W295n/4CxlAiaxwoh2BD2hLiG1tYe0/WZ
	OZKpCcb4DZ7RlLHxAhxR3VH0Aw2+fhaptGwT3aC2l3j3u+0O5P8wp2WE49IkYqULZ+Gd6/A8IPx
	MeGfrdhmc7tMW0RzCMM7iCYhcfIMMKsHjU/d5yxjhoXE=
X-Received: by 2002:a05:600c:3494:b0:4a2:267:25b3 with SMTP id 5b1f17b1804b1-4bb7da4efd4mr109616755e9.35.1795089026410;
        Thu, 19 Nov 2026 03:50:26 -0800 (PST)
X-Received: by 2002:a05:600c:3494:b0:4a2:267:25b3 with SMTP id 5b1f17b1804b1-4bb7da4efd4mr109616265e9.35.1795089025921;
        Thu, 19 Nov 2026 03:50:25 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1520:4400:d78d:7b2d:2f5d:e08f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654b807fesm9172572f8f.10.2026.11.19.03.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 03:50:25 -0800 (PST)
Date: Thu, 19 Nov 2026 06:50:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Congjie Zhou <zcjie0802@qq.com>
Cc: netdev <netdev@vger.kernel.org>, jasowangio <jasowangio@gmail.com>,
	eperezma <eperezma@redhat.com>,
	xuanzhuo <xuanzhuo@linux.alibaba.com>,
	andrew+netdev <andrew+netdev@lunn.ch>, davem <davem@davemloft.net>,
	edumazet <edumazet@kernel.org>, kuba <kuba@kernel.org>,
	pabeni <pabeni@redhat.com>, horms <horms@kernel.org>,
	virtualization <virtualization@lists.linux.dev>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] virtio_net: RX stall caused by masking callbacks after
 NAPI ownership release
Message-ID: <20261119064843-mutt-send-email-mst@kernel.org>
References: <tencent_AA4F39DA7ADE330C721C03AAA832B92DD608@qq.com>
 <20261115175445-mutt-send-email-mst@kernel.org>
 <tencent_94953697D2BA27275BEF7A26404E69800605@qq.com>
 <20261116044750-mutt-send-email-mst@kernel.org>
 <tencent_D0650F8CA2AAE4C258BFE5BCE805CDB4CA0A@qq.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <tencent_D0650F8CA2AAE4C258BFE5BCE805CDB4CA0A@qq.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DIsG6i0x7kysEgB9F4JLU9YKzsUXHv7t1r3072c5JJI_1795089027
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Nov 17, 2026 at 12:05:24AM +0800, Congjie Zhou wrote:
> > Maybe let's just check the poll list.
> 
> Checking the poll list fixes the earlier race where the watchdog has
> already finished. However, the timer can still be consumed without
> triggering another poll if it fires after the old caller's check:
> 
>   old poll / watchdog                successor busy-poll
>   -------------------                -------------------
>   napi_complete_done():
>     clear SCHED, arm timer,
>     return false
>                                      acquire NAPI
>                                      enable callbacks,
>                                      then pause before completion
>   disable callbacks
>   napi_has_pending_poll():
>     timer is still queued,
>     so skip napi_schedule()
>   old poll exits
>   watchdog expires, sees SCHED=1:
>     no scheduling, no MISSED
>   watchdog returns
>                                      napi_complete_done(..., 0):
>                                        clear SCHED, return true
>                                      queue is empty, exit
> 
> At that point, the next used entry ends up with neither notifications
> enabled nor a pending timer or scheduled poll to process it.
> 
> Stepping back, the fundamental ordering issue here is:
> 
>   old releases SCHED
>     -> successor rearms callbacks
>     -> old masks callbacks
> 
> Right now, nothing guarantees that the old mask happens before the
> successor's rearm. Even if the successor still holds SCHED, it might
> have already done its final rearm. Similarly, having a queued timer
> doesn't guarantee another poll—the watchdog will simply bail out without
> scheduling because SCHED is already set. So all these state checks can
> look completely valid at the time, yet still fail to guarantee recovery.
> 
> The root cause is that with the timer introduced by NAPI defer,
> napi_complete_done() can return false while still giving up SCHED
> ownership, leaving us with nothing else to synchronize the callback
> state. Before NAPI defer, returning false meant we still held onto
> SCHED, so everything worked as expected.
> 
> To fix this properly, I think we either need to call
> virtqueue_disable_cb() before giving up SCHED ownership, or introduce a
> separate synchronization mechanism (like a lock) to ensure we can always
> recover NAPI execution. Simple flag checks alone don't seem enough to
> close this race completely.

Right. So I came up with this then. Pls note i could not repro the
problem so I am merely reasoning based on theoretical understanding
of it.

--->

virtio_net: mask callbacks before handing off NAPI ownership

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

This preserves interrupt suppression without a callback or an additional
data-path barrier. Ordinary napi_complete_done() compiles identically in
the tested configuration.

Tested on x86-64 KVM with lock debugging, including IRQ deferral, concurrent
scheduling, busy polling, netpoll, and threaded NAPI. Split and packed
virtqueue TCP RX tests with IRQ deferral and busy polling also passed.

Reported-by: Congjie Zhou <zcjie0802@qq.com>
Closes: https://lore.kernel.org/netdev/tencent_D0650F8CA2AAE4C258BFE5BCE805CDB4CA0A@qq.com/
Fixes: 6f8b12d661d0 ("net: napi: add hard irqs deferral feature")
Assisted-by: LLM

---

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

