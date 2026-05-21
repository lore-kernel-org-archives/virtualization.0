Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8AF3D47C6
	for <virtualization@lists.linux.dev>; Thu, 21 May 2026 12:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367661; cv=none; b=OeLQFu7ItMFWfRGcP3WeA4lmbQxQmLSNZJZlGBWeFJ3f2LpJJBaf0yLcudk8j5iN0kWoDMmUoX+zDbzkQD8oxIpdxPMMRgdRHhxSat2B34jvt4uxIL/CVqPWgsLe9k0kHul3ww6d2vF+KK+hiBqFkG5K7Z4vxFv7KAxRPYEezAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367661; c=relaxed/simple;
	bh=Dn6P2bkc/bzBUKXTydPjxy5n5j2Gvoyaa6sXWWpGFqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=PAvoNacgrWFSUnA3GgeC6FGKV1Un/lyoDyyamVrsx+qWSPeOoQQOCmnJrzn0UiXw6Os89eZ0priYr/nXET6RqyfnB4aZ//u5RuuK94Z5Xi6mcAQ0+S8vM4vr9RzVAEWPTudBuSoh2bGbEmgGbmRi+iFJjakNB70SmHRykU4KWW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BsJRVmIR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsJRVmIR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779367658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HUBSvYNIEeXrti7M5Q7uqS37K22xV9FH6FOTxmrZ3+g=;
	b=BsJRVmIRxO5gbieI2uYdC/xo8TMMSZHzGqZ2ZFGBfuY4pPrwUx1pJ8ebnb/kkbPAtn+cgA
	wu3ITd00zr46jXAFjPNakIZ1MCPcg5SaLUPhZehJAt5ZcrQobOPuC+Upv4I8T3XT8rAW2v
	5WHux8GdkMdIaV7fwcHLZf8Iq4kuJwQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-B_uAUlhEPmeKQULXrGNEgQ-1; Thu, 21 May 2026 08:47:37 -0400
X-MC-Unique: B_uAUlhEPmeKQULXrGNEgQ-1
X-Mimecast-MFC-AGG-ID: B_uAUlhEPmeKQULXrGNEgQ_1779367656
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44ffa15dc8cso3809047f8f.1
        for <virtualization@lists.linux.dev>; Thu, 21 May 2026 05:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779367656; x=1779972456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUBSvYNIEeXrti7M5Q7uqS37K22xV9FH6FOTxmrZ3+g=;
        b=WuqnFud6rudEDtAUglujt1cJJAhHM6FhPWaxb69RzPB6FYziE3nb9mzGCgIX97rEbZ
         TYkmz3jYt4/NpvPt/PD6+9G77jDxCD14cl2g6CLpo5qpr8MEQWlVOaRKjyQhnroIqrIY
         TAuGelx0RqXN14u1vjt8PQZjUot7HpTJb0tlzEQXxwiICvaV8TJEvc/gNr8SHPbsF21x
         k4aqBnBY4XgnaCvsdVRt1G2VuBL8j6LMdumxbljI7jNfmGHbd9zHn8g9OfCaxacILe54
         xU+U4mkjWgO1+hN0uLwtaXAdGT4CAUMcAqOQuEKdAgbA87jXScIPFUphMI1y9KpzmjNN
         m7lw==
X-Forwarded-Encrypted: i=1; AFNElJ8hISDBg1LjaGm4gQTw0NYf/3cpCHIca3Av3XwvoyJeJO2wgNHoKmSuEsK0V7VukFivYMZ6n4JDwEJCKWBlcg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxqDXEdRpE1TJBcEy3GDsrdld1PqZkPexk68g+BZ2l4OvAe5vLz
	Xv6em3BYfvoTJrmQ1JnXIgnc54De6cOnd+k4Sphj0/IBehPic3Mmr0AodQafJ4XaKdjVnhsukFL
	zvMFjXFEBcKl8Wccw77IY3v+UzUh5MCJWx9Lp9TROnoByJg8uQIf8O1g33bBuv76m/0Tb
X-Gm-Gg: Acq92OHGo6UPiLQo0uhEmjU3VrzlH/1J2xJGNi5affUIbAhe8tWUuxVJHajEucUxdHx
	E+J5zLEACxIkg1KURtjmaHkwJ5vNKWoCYy72+wLAHB2k3kX0p9JvDzPE/zn4F9IGy6JDZkutaFh
	JzUR0BCvQbVfD9jAGV6lhYZNdZTl3frOce8Q73SNzy4JfWciGXgoR7+TehjwB7VCq+pu66tmsfZ
	HbN0MqhMgR4UwGC2SvsxOq98v5Mz9ex0sv3sP/XN+Rt+lHN/8rtjwRtBwyOvMhI1TWLboi55SPP
	s4YC+ks/dsBqytqoCkDvLU7WD0w1DAlqUMhfWR5GJnNYXHFZvJHO/48nWEEDnC4/XKAYBTH6UKL
	dWTQEo0lhtK7EQkHWf1WDmR2UNTUSJ+BBf75VCzTQCop64H40oi7wXVY+YFc2IeRGvOq5+43iWk
	J0kLgv/zcdHIA=
X-Received: by 2002:a05:600c:3513:b0:48a:75b9:b0bc with SMTP id 5b1f17b1804b1-490360cce5fmr38604545e9.29.1779367655722;
        Thu, 21 May 2026 05:47:35 -0700 (PDT)
X-Received: by 2002:a05:600c:3513:b0:48a:75b9:b0bc with SMTP id 5b1f17b1804b1-490360cce5fmr38603965e9.29.1779367655227;
        Thu, 21 May 2026 05:47:35 -0700 (PDT)
Received: from stex1.redhat.corp (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d52c8bsm69391315e9.8.2026.05.21.05.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 05:47:34 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Simon Horman <horms@kernel.org>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jason Wang <jasowang@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	stable@vger.kernel.org
Subject: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit builds
Date: Thu, 21 May 2026 14:47:32 +0200
Message-ID: <20260521124732.125771-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fZT7FCBw1Wr2iRcrh0OS-U3MJT_kPSDMhqt8WDSJaKE_1779367656
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

On 32-bit architectures, both skb_queue_len() and SKB_TRUESIZE(0) evaluate
to 32-bit values. The multiplication can overflow before being assigned to
the u64 skb_overhead variable, making the skb overhead check ineffective.

Cast skb_queue_len() to u64 so the multiplication is always performed in
64-bit arithmetic.

This issue was reported by Sashiko while reviewing another patch.

Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
Closes: https://sashiko.dev/#/patchset/20260518090656.134588-1-sgarzare%40redhat.com
Cc: stable@vger.kernel.org
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index df3b418e0392..71198bf23fc4 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -417,7 +417,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 					u32 len)
 {
-	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
+	u64 skb_overhead = ((u64)skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
 
 	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
 	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
-- 
2.54.0

