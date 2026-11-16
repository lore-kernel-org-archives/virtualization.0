Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822790;
	b=iw2ksFs7DgY2+l43gvC7OBBaLeg7mO2B/VcULUWVBUyz583+yinxEJyWkMy7ZMRauUJo
	 +iHMwAIT0YnHP5gdWMRNVPeptnXZ5W1RbfBCGMTYtz14nLpcjhQhTQyrvMG8zRAi+US/o
	 QG2X9XS62yht4ugm9yvRtJs9hbdcCC0xFwo7m89euqZtzxQtEqd/36llfGwC0yMKSrdbe
	 swbuj5TDpHwN+XgmI8SkD61sbAAfFL0Ulcd3snDdenT0O3C4qEpOKZrOH5054HyMkuXyW
	 78Sb8HlxCT3Cj8N3tNmMULusviZkJEW6M4Qekd8J0q8jIw0s/PQcxtYQeHSAWVzB2MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822790;
	h=DMARC-Filter:DKIM-Signature:X-MC-Rep:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=SgMJefBKejfBBWtoRWd6v8uWkLAJ3E6A5yIR7lhjHIg=;
	b=2zISLpeO9p/Re+av53Jkmq9wFiyOfTlgOhC4W0L3sz5woaEsdkcJPnNJle+xYfK6j36l
	 YCcv0jzEcj1Cno0iUAKH+FRxELA6hsINC3yZWjz0a1zJ7ke8B+IUARyhjLaAbcO8+h82i
	 NHdZ+moGAlB9zOY7AU0zAkUKxzkkXcbjEAo+z9xGbIHNN0aKFcsfuYqRXkmu5nlaUo64+
	 GiXcl3sAGaz7KjTEsGPObvlNMQlUPfABjovkUQQNXZfGcNTahf7myY9W1NI7sW8z/VuF1
	 0UwRSAs2BxXgJmgFTzplKOjJz0D4s8GCj4bKtc4I9nUOqLs/bBchfNlhWQDCrMtq+LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R16aFhJJ;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22FD606A334
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 09:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A22FD606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R16aFhJJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794822788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SgMJefBKejfBBWtoRWd6v8uWkLAJ3E6A5yIR7lhjHIg=;
	b=R16aFhJJypPwUXVCNblGjdUvWoleF3MgY20ibIu2onkMhHT2mTt87Ou3LoTyuHPPQUeqwZ
	xTUS3sZWn5Zi74LY27RDoc/XKjSgwXPWM7vtyhp0cwYYfgGICJ7gX+87/ib1PDqEJVB4Ok
	Y7F4psMcHFDqsugBHnwBGcu9qKJVroU=
X-MC-Rep: binary re single
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-PE4d0IZZP5ywczLIlBBpMA-1; Mon, 16 Nov 2026 04:53:04 -0500
X-MC-Unique: PE4d0IZZP5ywczLIlBBpMA-1
X-Mimecast-MFC-AGG-ID: PE4d0IZZP5ywczLIlBBpMA_1794822783
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e0389d6f9so1727027f8f.1
        for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 01:53:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794822783; x=1795427583;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SgMJefBKejfBBWtoRWd6v8uWkLAJ3E6A5yIR7lhjHIg=;
        b=zndRXHMhmXY2+7gP5NKYT18ROePxG7ybLMv1yH+qyPcG4CzIFonliGEVvEjAZ0ICCX
         j9GAJKkfepbv95jPk8LsKDBrxkRZI/DZJLnJzR2tu45ZU6eWZVLR4D9UKICBmW5r2OHl
         pOBwdpWz1E6Kgp8koE+JknH8NegVcGtloG0YFSLUO8vJbTa78GnVGZfGG2PzY1VwAKhN
         /XrC4C53mEQanZhLV2w5oh/YS2LXLYLqe9n1teP3eMIVA1slGd5E/rraNtJPdmod+Glm
         WMzz67eDXUd35imxa8t5Fk5xsbDh9iMJq/eqNOP5PilTYSp3kdhuPGmtZxn6HnBlB7C2
         +wvA==
X-Forwarded-Encrypted: i=1; AL+hErG6kF5lZ769suYQ2wHEdNh5ChoOQ1KMyTtVWzRr8apNkYEYCaKp7LEBqYaKiZQHEihmr6Yux384gpTIAlcYoQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/emfxQx5e8q+HdiwM8OnwM1N/hOolnujTY+19t0OPPyGOmpo1t
	AJpbXyxoKdZz51JCW8eLCnKHBBLoUS5Lgq7WAQdH0cY0PgzAIs1dBhyJnWqzBPstjqx9TOUW7/A
	/eZUTQmfDGm2SzU2a8UobTMQJxDzr5vkzgF12NlQQwwJef7HCK/wbIx01Yp24XZOZcdzJ
X-Gm-Gg: AYBFou2+Q5tjjCDhhtcij9XmZz5DaXHqM8KNVE5fpgT7GVtG0gT35b6EmOVFNhVuMwb
	XZa3aNLetA1UUb9xLDiFRng0sSRFcFztlBzbkj8pv6dmIQBd7QSKhq1tbjiCkNv1QSWeMNrNGxC
	bu3S0KcIg1pEFxVcY2WBY2jdVwDlfeXys0rwEGH2SoW8p5ba77MWljXab3bdSipQgmYEVE9Z2St
	FUxy9oc82kNEtWnvf9pft6KZBwggNK6h/pCtQRmIZRJJki8w07q7hp6vaiaHdolUm/8QKhaMEnW
	28vxe0iTFUxP9YMYaFlgBZBQIGxudDnTxIolDV26yYpdksyPBBhQ5XDykUCPV4jZha54yzzUgxz
	WnllsYsma793RCypFmonse8i2sp5y9dLIBy1zv9f93A==
X-Received: by 2002:a05:600c:524a:b0:4bb:6cef:d14b with SMTP id 5b1f17b1804b1-4bb6cefd40dmr73286055e9.2.1794822783069;
        Mon, 16 Nov 2026 01:53:03 -0800 (PST)
X-Received: by 2002:a05:600c:524a:b0:4bb:6cef:d14b with SMTP id 5b1f17b1804b1-4bb6cefd40dmr73285555e9.2.1794822782478;
        Mon, 16 Nov 2026 01:53:02 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:151e:a200:7a96:1b15:81f:ebed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2842e6sm384663765e9.4.2026.11.16.01.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 01:53:01 -0800 (PST)
Date: Mon, 16 Nov 2026 04:52:58 -0500
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
Message-ID: <20261116044750-mutt-send-email-mst@kernel.org>
References: <tencent_AA4F39DA7ADE330C721C03AAA832B92DD608@qq.com>
 <20261115175445-mutt-send-email-mst@kernel.org>
 <tencent_94953697D2BA27275BEF7A26404E69800605@qq.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <tencent_94953697D2BA27275BEF7A26404E69800605@qq.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vdxfZ_1n2s63jr499uqGYSZAWfsTgRO-5OQFvotbvGQ_1794822783
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 16, 2026 at 04:47:17PM +0800, Congjie Zhou wrote:
> Tried your patch with my earlier TCP test. No more complete NAPI
> stalls so far, thanks!
> 
> But LLM found another possible interleaving, though. I reproduced it
> in an instrumented KUnit test with injected delays, but haven't hit
> it in the TCP test.
> 
> With defer_hard_irqs=1, it goes like this:
> 
> CPU1 / old poll                  CPU2 / busy-poll
> -----------------------------    -----------------------------
> Complete: clear SCHED,
> arm timer, return false.
>                                  Take NAPI ownership.
>                                  Enter busy_poll_stop(), clear
>                                  IN_BUSY_POLL. The final poll
>                                  enables callbacks, then pauses
>                                  before completion.
> Watchdog expires, sees
> SCHED=1, exits without
> scheduling or setting MISSED.
> Disable callbacks.
> Timer=0, SCHED=1, so skip
> napi_schedule() and exit.
>                                  napi_complete_done(..., 0):
>                                  defer count=0, no MISSED.
>                                  Clear SCHED, return true.
>                                  Queue is empty, exit.
> 
> Then the device adds a used entry, but callbacks are still disabled,
> with no timer or poll pending.
> 
> So SCHED=1 at the check, but that poll has already enabled callbacks
> and won't enable them again after the old poll masks them.
> 


Oh good point.  Maybe let's just check the poll list.  And I guess it's
cleaner to add a helper in net core than poke at low level fields like
this.


diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index dd2c41ef6fbe7..0984f81848174 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -740,6 +740,8 @@ static bool virtqueue_napi_complete(struct napi_struct *napi,
 			return true;
 	} else {
 		virtqueue_disable_cb(vq);
+		if (!napi_has_pending_poll(napi))
+			napi_schedule(napi);
 	}
 
 	return false;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c0ae442c4344b..f728499872e8d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -22,6 +22,7 @@
 #define _LINUX_NETDEVICE_H
 
 #include <linux/timer.h>
+#include <linux/hrtimer.h>
 #include <linux/bug.h>
 #include <linux/delay.h>
 #include <linux/atomic.h>
@@ -553,6 +554,21 @@ static inline bool napi_is_scheduled(struct napi_struct *n)
 	return test_bit(NAPI_STATE_SCHED, &n->state);
 }
 
+/**
+ * napi_has_pending_poll - test if NAPI will be polled again
+ * @n: NAPI context
+ *
+ * True if the deferral watchdog is armed or a poll is queued.  A
+ * false answer is "best-effort": a poll can be queued right after
+ * the check.
+ *
+ * Return: True if NAPI will be polled again, False otherwise.
+ */
+static inline bool napi_has_pending_poll(struct napi_struct *n)
+{
+	return hrtimer_active(&n->timer) || !list_empty(&n->poll_list);
+}
+
 bool napi_schedule_prep(struct napi_struct *n);
 
 /**

