Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B213A872C
	for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 13:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691260; cv=none; b=gvNV67phkDtVbNkhXhHozCPWqVnDS1ksQJNGr72ROYxxEk6VUIBkHADZZnBiq6XxW/cCl9uzOjOppq4s2PNH//AUtxz4WDuLhCi6qc25zAOLiYpCFQrl8Ub6gfjr5KLlPXRMy2iZuVvdF95FAgLaZyckBeYxXMJQBEwXEyFQhUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691260; c=relaxed/simple;
	bh=oRz4R1uy7BvYcGv9q3SW450IGK8oQQE9HdAqw2IRtxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=f6EFgwTeZ5qVT6DVb+aQFfr5Q5kCduT2AHbsaj9PrkXoeYSDuMKoQDcu/d5hrJxFiADZAJLcw2e8/7WOEWH13a2sGyVPoWCnTvKX5kvHQ/jfWuT03EjBSvJw49QiIkw/oTBvL1x5GHY8Zc0n3gTqiorbSxSFNKLdV3hX/uKDbsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=brqkcqTw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="brqkcqTw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776691258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZNw8VU2wHUCMW8yOpvKsEhvAEIS86OBEtLoYfE3AKWY=;
	b=brqkcqTw2lD776U+ZskXKXuGMj/LsAN/vPFTBrGvGWQimjJ3n3Sh8vDdQ6fbFiY0uHeFJ1
	g2giUp9bT4Dw23oUzP4e1HoXCn/n9AF+qth0mWQFAdvN4Hqzw5I395Kb55L42ZUdZIqPWi
	a+bWt0HwUdn9x7JUtNGK225oGiJvXDU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-R3T58h1VMCumdYOq8lB1lQ-1; Mon, 20 Apr 2026 09:20:57 -0400
X-MC-Unique: R3T58h1VMCumdYOq8lB1lQ-1
X-Mimecast-MFC-AGG-ID: R3T58h1VMCumdYOq8lB1lQ_1776691256
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43ea7a5da42so2012737f8f.1
        for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 06:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776691256; x=1777296056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNw8VU2wHUCMW8yOpvKsEhvAEIS86OBEtLoYfE3AKWY=;
        b=hWLBu/FBetW0fVx8UpLz6dEtkpDljtW+OSlWGJVqJf0HPxq9v+MJbWCTKfjBW93K3k
         a5MON0jfpMEaiXlBYAysGc3VNfFFcSpIPuPCs5JVfQvTvHuBjcX4V8GTmdoOMouxjHbZ
         pu3LAA1Ts1HgqyquFEDscRriedq5ak59StpR10PGyXhy9zhBYlXVv97MKGQtBtUeGQME
         FmA+EhKaF0AmAx0cjkCN0md6Eoec/lg7Zk6rFA4UM7PE9x3J0SIr98U6AmoryYdkVB87
         2ZG0M0tzu7ey+9Xu9m9iNAYNBImtPBXxu0RGQ6H0R0Q6j8bf04nHlOZhhzuj4AM+RDKz
         dvDg==
X-Forwarded-Encrypted: i=1; AFNElJ8voiaVLk2/PxIRXCbaEpH4YNIh1UrGeHIGpfIG+egwPMQY8w5XMdZZNb6DpJeUZ6E+GwUb8K7VPu2Orpr6vA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMWWjPBBGD9GggvAMc0SMlmNnvbrTJighfB+60JKPhgzjZd9ge
	ONBTTLTQXZgx8YIDtfoN7uJe78To8eTv/0iUFr492y+9LjDqB1sGtidqKj73fLVTIyz3VDl3Odw
	Nf1Y6mWODGDVwrtfpga+55+O/T27SjlycVBnXTEF8j5jmwlB6YfEDmLKWOy2fmnUeEYWN
X-Gm-Gg: AeBDiesMKyVPcDtv+vSNhCh/QWGh9AcTaR7NhxfCs5WyjxxYWo10ix72j+fyFlTS3ou
	UiEZyQp5Wswe9D2yhCgm6BOrX1OsRvmoYZV32Dl7ZRPw4E/2MMltp3JoGDpwjfsZnCNlv4yfqbM
	Dv6YqXbQmFsjda+fHuyPECH8IYft9PXRcEhQvWBXjIbJwfiyEOVIDSlKoVObvvIwFs+xM2G1k/Q
	bLffNBzrhPps74dHOYTLAlrc6U1rZJmdqWebVu/B9A3ZmWEp6p3tugwTGXbFKHLe/V/0v1rqnYY
	x6gP4UoSdveYiJXiNEWhuS7WftwzFjxCVwW9iR0riTspX4dClUtAt5xyYg+XrnBCZhHAWXNHUn3
	60d4DHf2+wB/oceWlkgOpRXzuipNSzzXwf2h8F5QFFBE+kMrdDkpdm8hGWM0WuHZ5ivFBua1yrQ
	wKX/iLyrUh
X-Received: by 2002:a5d:5e01:0:b0:43d:c95c:5e75 with SMTP id ffacd0b85a97d-43fe3dbec67mr19818832f8f.4.1776691255874;
        Mon, 20 Apr 2026 06:20:55 -0700 (PDT)
X-Received: by 2002:a5d:5e01:0:b0:43d:c95c:5e75 with SMTP id ffacd0b85a97d-43fe3dbec67mr19818744f8f.4.1776691255247;
        Mon, 20 Apr 2026 06:20:55 -0700 (PDT)
Received: from stex1.redhat.corp (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1405sm28294807f8f.4.2026.04.20.06.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 06:20:53 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	kvm@vger.kernel.org,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Yiming Qian <yimingqian591@gmail.com>
Subject: [PATCH net] vsock/virtio: fix MSG_ZEROCOPY pinned-pages accounting
Date: Mon, 20 Apr 2026 15:20:51 +0200
Message-ID: <20260420132051.217589-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qmuXdVwUJ9BESdR67LulBjApeLcgNVcvxuerURvoAXU_1776691256
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

virtio_transport_init_zcopy_skb() uses iter->count as the size argument
for msg_zerocopy_realloc(), which in turn passes it to
mm_account_pinned_pages() for RLIMIT_MEMLOCK accounting. However, this
function is called after virtio_transport_fill_skb() has already consumed
the iterator via __zerocopy_sg_from_iter(), so on the last skb, iter->count
will be 0, skipping the RLIMIT_MEMLOCK enforcement.

Pass pkt_len (the total bytes being sent) as an explicit parameter to
virtio_transport_init_zcopy_skb() instead of reading the already-consumed
iter->count.

This matches TCP and UDP, which both call msg_zerocopy_realloc() with
the original message size.

Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 0742091beae7..416d533f493d 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -73,6 +73,7 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
 static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
 					   struct sk_buff *skb,
 					   struct msghdr *msg,
+					   size_t pkt_len,
 					   bool zerocopy)
 {
 	struct ubuf_info *uarg;
@@ -81,12 +82,10 @@ static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
 		uarg = msg->msg_ubuf;
 		net_zcopy_get(uarg);
 	} else {
-		struct iov_iter *iter = &msg->msg_iter;
 		struct ubuf_info_msgzc *uarg_zc;
 
 		uarg = msg_zerocopy_realloc(sk_vsock(vsk),
-					    iter->count,
-					    NULL, false);
+					    pkt_len, NULL, false);
 		if (!uarg)
 			return -1;
 
@@ -398,11 +397,17 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 		 * each iteration. If this is last skb for this buffer
 		 * and MSG_ZEROCOPY mode is in use - we must allocate
 		 * completion for the current syscall.
+		 *
+		 * Pass pkt_len because msg iter is already consumed
+		 * by virtio_transport_fill_skb(), so iter->count
+		 * can not be used for RLIMIT_MEMLOCK pinned-pages
+		 * accounting done by msg_zerocopy_realloc().
 		 */
 		if (info->msg && info->msg->msg_flags & MSG_ZEROCOPY &&
 		    skb_len == rest_len && info->op == VIRTIO_VSOCK_OP_RW) {
 			if (virtio_transport_init_zcopy_skb(vsk, skb,
 							    info->msg,
+							    pkt_len,
 							    can_zcopy)) {
 				kfree_skb(skb);
 				ret = -ENOMEM;
-- 
2.53.0

