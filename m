Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762233E5EE4
	for <virtualization@lists.linux.dev>; Mon, 18 May 2026 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095229; cv=none; b=H1o2JerTnTIxxuCWiOGhj7+o0dIQIYNJJIPJqMRdHsd35kJHoJ1r9EBqGL3VS9aD/XN6qzsameVHdA7URlJRIAu9Rl+2zis7EffYUjZwMifIZ/U5Jpw0M7xDF62HO+Fjx6csKvZMStL+WbKj2ysHvC2eRHayH3T4JMGHnGU0C9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095229; c=relaxed/simple;
	bh=uQ6Wln7pJey/LF1d0dz2kzM3P6XyAQup1rTFP8pIs04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=lhacLSYfsyvXOVwVMpa50xebblm5pm/KcVHRz9dSYcU8AYUn7i5CUEZyqJoPa+xsyUC7ZpBkddE6/ugFw3qbBk2JZp0rOAtsNyWAHvvWtUxPxYYebOFx7ebagOpmFtml91ij9eWuS3ORWPpVr81XfByONyJaAZkgj1YdkVam/xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RUk6OyEI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUk6OyEI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779095226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=200SzWxPjUpvXvgPwqt07Qg/dRT4TNSJWBHGA2MWMbU=;
	b=RUk6OyEIcSZ316FWILtf3C1Dy0R1KDdQ5TdzN5gth09FOwwPRq3+3TCNMIwGg4Y0nrxn8T
	/jrJ1bxTtBWs/Xoux9F4qB2fBgO76wc06Q9N6clX1cJD6vDRe8YmhkkYz7jWnQeSA30BdV
	4LLbmYiH70kFeasdJN+FpzQnwgRhb/8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-DIgo5c2_Nt6kxMvTuA8dtQ-1; Mon, 18 May 2026 05:07:04 -0400
X-MC-Unique: DIgo5c2_Nt6kxMvTuA8dtQ-1
X-Mimecast-MFC-AGG-ID: DIgo5c2_Nt6kxMvTuA8dtQ_1779095224
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48906aa28cbso21128405e9.0
        for <virtualization@lists.linux.dev>; Mon, 18 May 2026 02:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095224; x=1779700024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=200SzWxPjUpvXvgPwqt07Qg/dRT4TNSJWBHGA2MWMbU=;
        b=RPyaVHuui1RWL12YlZScuQ9EKBLLz5mad6gLEL29OYz/m5AvamFTiHfxXCcyxojsyF
         70S6Vj9yDy2bY0Kbi0+09SlSkiVPRNFy5zbNlfj1C6dzvbKkOVH75ww7jAVapq4Eiwtj
         dGZ6jYtDEqKUcrrxn1+SBWobgT2SaTO9fJ5g57J8welHd4o7YsE/J19a8MnyNaVc+UB3
         hUD6wTaNYkyTd8r5UnN/xcOTwSmUj7n6H7IqPm9P61pcvghUh+5rbutaS9Wm2bzlUpkw
         OMLuPHiHiLCoPIy4PArM6rrlRROTngsy15T2oasGd077hWfJubiWEtdczaZAZhIIZJOQ
         yIsw==
X-Forwarded-Encrypted: i=1; AFNElJ9n4Djd/Q5zsQ2dBdUgk1jL/bpK+BnzRM4Tx3i1gUsBJrkcIBw1x3oSfT8/DTLqqd7TS96+xcFWORqi3byp6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwWemRmz6U7Qxz4mjktsAUIRm7odYlONLQD/ce0LZoF8Ak7DB6y
	QpAotRBNTROKUqdaXznGCNx2wkapy/U9lF9nIthuaOngALsTIX9slBWWK4Wjk5Rx8JVcN3byv47
	a+WKfHyj6fTgxRjBks6PYvGix7ii26dW7MMlWLLgUieFM2BPOv0Rxn91rj1TkirHKxT3G
X-Gm-Gg: Acq92OGP+DszuiWqFDmtnvERd73B0x2KpG4v7rphvzBN+htFjN/dMdI4B7tCMDEnNH6
	4AssvdQ0e1cv2SopW94w4Ovli6tVUntg7lNbBBgvHMobSZVHqWuIzpw+hwRicQ1Q6utt9QQH0vV
	GYnDO4yBWORD8nPAzOVEX3VCgbW0P9qFLv2yHjblfCAzcd5oWyGoXvdvcxd/0aVqSIefusa/nyI
	4KHh9o/9Kx9dFgwVdM7xo4euvkDok+MhV5xfjnAb6tehlnKetr8L9aI6dNPnJ55DDJ70fTEbFk2
	Lu4A6Xn2eVfRdYyN8nM3/etDmw9dYn0vn+vDLfTkfknX+UCko9G+dkdTf3AvB+zmwbcy53oDxgR
	9f2Km2JUE+DudwA844k28o0+v595N/gquOHSPa2WfhwtLKfVmANkyHh5ewfDp
X-Received: by 2002:a05:600c:1515:b0:48f:fe2a:107a with SMTP id 5b1f17b1804b1-48ffe2a10b7mr66193305e9.3.1779095223697;
        Mon, 18 May 2026 02:07:03 -0700 (PDT)
X-Received: by 2002:a05:600c:1515:b0:48f:fe2a:107a with SMTP id 5b1f17b1804b1-48ffe2a10b7mr66192625e9.3.1779095223029;
        Mon, 18 May 2026 02:07:03 -0700 (PDT)
Received: from stex1 (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe6b60csm105880345e9.6.2026.05.18.02.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:07:02 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	kvm@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH net v4 1/2] vsock/virtio: reset connection on receiving queue overflow
Date: Mon, 18 May 2026 11:06:55 +0200
Message-ID: <20260518090656.134588-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518090656.134588-1-sgarzare@redhat.com>
References: <20260518090656.134588-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ue5Vi1RG9FsT3zmZfnToCdD-oF21R2NIIkMObzPtj_Q_1779095224
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

When there is no more space to queue an incoming packet, the packet is
silently dropped. This causes data loss without any notification to
either peer, since there is no retransmission.

Under normal circumstances, this should never happen. However, it could
happen if the other peer doesn't respect the credit, or if the skb
overhead, which we recently began to take into account with commit
059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue"),
is too high.

Fix this by resetting the connection and setting the local socket error
to ENOBUFS when virtio_transport_recv_enqueue() can no longer queue a
packet, so both peers are explicitly notified of the failure rather than
silently losing data.

Fixes: ae6fcfbf5f03 ("vsock/virtio: discard packets if credit is not respected")
Cc: stable@vger.kernel.org
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 1e3409d28164..5028ff534888 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1335,7 +1335,7 @@ virtio_transport_recv_connecting(struct sock *sk,
 	return err;
 }
 
-static void
+static bool
 virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 			      struct sk_buff *skb)
 {
@@ -1350,10 +1350,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 	spin_lock_bh(&vvs->rx_lock);
 
 	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
-	if (!can_enqueue) {
-		free_pkt = true;
+	if (!can_enqueue)
 		goto out;
-	}
 
 	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
 		vvs->msg_count++;
@@ -1393,6 +1391,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 	spin_unlock_bh(&vvs->rx_lock);
 	if (free_pkt)
 		kfree_skb(skb);
+
+	return can_enqueue;
 }
 
 static int
@@ -1405,7 +1405,17 @@ virtio_transport_recv_connected(struct sock *sk,
 
 	switch (le16_to_cpu(hdr->op)) {
 	case VIRTIO_VSOCK_OP_RW:
-		virtio_transport_recv_enqueue(vsk, skb);
+		if (!virtio_transport_recv_enqueue(vsk, skb)) {
+			/* There is no more space to queue the packet, so let's
+			 * close the connection; otherwise, we'll lose data.
+			 */
+			(void)virtio_transport_reset(vsk, skb);
+			virtio_transport_do_close(vsk, true);
+			sk->sk_err = ENOBUFS;
+			sk_error_report(sk);
+			vsock_remove_sock(vsk);
+			break;
+		}
 		vsock_data_ready(sk);
 		return err;
 	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
-- 
2.54.0

