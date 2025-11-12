Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185472E8B8B
	for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 06:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930545; cv=none; b=Fm8IfNoJiJRfnukt4DtryIan8fC5Dxw8THPW9Or35znw3cRnjy8372o9s0gh7NBa4dwnemyhiqnugaHQsOepgQDmHTli64GoDIKWzK+IIq3ozaGpc/MVu9Ndx0AfEha1j8SRDPxfxzWGkaaiewSK+alGYtGjhbkgj4c9jqfAZZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930545; c=relaxed/simple;
	bh=01uUMlfiWTKv03h82J1+m084yYvxNbGX6LOW1sTU7AA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LLeSfgGLwfSLc+ylcYT1UyHxc8S0UfSz7osqYGlSRQOuTs7eEEw5A1U+o5Zy421R98EA0DEH2ePOKYGr+Colplqe0fjalZUVdY0/BAd44FYq7jNuigOSPbAxYJlZ4ju+SPWblyNLy8e66BcHYupriRgRukXOgWsyLwVl917yF6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htK78EDt; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htK78EDt"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so451648b3a.0
        for <virtualization@lists.linux.dev>; Tue, 11 Nov 2025 22:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762930540; x=1763535340; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PmM345PPlBdkJ7nEXyq1t64bQ5asJdDBfV1okwjOHnA=;
        b=htK78EDtLkEehtjIySgQ35r6Rc/7YIbYJK+tI9YXr10iSesM1TY/BNp1RAey36yIOy
         6sRHKRPCaDnbrrU8eGz/bx3MO/lMiAIMM1vrW04mE7+YGtWpktyWdS7zlxVbNUOeoLWx
         HLs/xb+2N6eN/7wm0VRdUynyrfY3pPZCOPrBRfPYEyPr5hN5ofWE2Bhn5nCbxX0/VNjZ
         m3/xNGQ8ytaKUkWbNC+3aKQ2/Vu3dH0KhOGQkddTgkrYzebxU4XUXW7IXXzIhifJPVin
         jZWUv/F8rU6KRvMiuo6mjXRdfV1OPUdBCaoLMAOYX/o+BbPBFLoKk2e2fdNuia9d6WgJ
         wL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762930540; x=1763535340;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PmM345PPlBdkJ7nEXyq1t64bQ5asJdDBfV1okwjOHnA=;
        b=fCn+D4OWsUXJVZD5fku6ySVoqq2evhldrMik0gtW788hQ9IqoVTqvsHHSlBLBwgPvo
         avjNmaQ3ANGEFmWHkVgqdpRosCVrp1Gd5VAGuEabMNhSW5m/eqSPbJniaIxgT9iD7y6r
         gEwt9eMrmsNVkhOG9rU8y9tHAE28W6CQSRZlh3CFE8zlchCdVAZuCRQLBLc6LHR/Q7C1
         +zf+vKtaYue7kg2NaREio0CJi1Md97Y7QK19kRY421kxjTQ1VVdzKh3pXoYP7zdiediZ
         8LbJ0JNXK4S4jJU7hFo+pMU8M/Ww4ioGZzcC+hWIAAlhsaxIN5HiyndSKCombWQEw3Hk
         jPYg==
X-Gm-Message-State: AOJu0YwGNHFPBnIqtWNZjryzexo186sztNiGz+YmsAkvk/0bZ3FyxxmY
	Syzy8VVLwM0dQcwejxGTb9M0W8/MlaH07Hh7ZhvkWYArOczYckaw1DfB
X-Gm-Gg: ASbGnctbUljASC1k6LOBH7uJ2ySnxoUImJaDR/EUNMZ+RDtijUh1BolyORWVXuMgl1Q
	CsLejmsSepDWRLx6ykOrmzs77X16SVTLSo1p3hqLWUkSMRr9ZYRzFf/gMH0uL12YJeulze8Q90f
	1A0hQZ7RVdJC1+Uiiwwdlfj38U1dMkhVG97GNoYrMHXK5k0jWDKfoFpagHkywC6ciDgPC97JqXh
	uJg7SK/8mRGb+jxKh4ZOQihx4TBmlqMnOkjex+v5c+CAoxfdiygNzhsOGHyT5Yfk2t0HEqC5Csr
	umh7+qIxiCYDGkftpXw3b119MsE+JZnPa2OwK/gWo4fN9vrFo1EYR5l3PezgjXyS+aEronWfekV
	gebR/QgMd2f72AHjdlNyAn92589jg923hSiybGMQBMwnyT9RWCv+aWbB16NExbIx/JOSnnw==
X-Google-Smtp-Source: AGHT+IGNhCkA23bPLUhPo1K8TP1fGLK1N8Jxj/eTUi5N0DaekLLmU2p8n1DIbr0n0Dbs2LkhzQbdKg==
X-Received: by 2002:a05:6a00:2d13:b0:7aa:8397:7754 with SMTP id d2e1a72fcca58-7b7a25aa4aamr2255142b3a.2.1762930540424;
        Tue, 11 Nov 2025 22:55:40 -0800 (PST)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17a956sm17716113b3a.44.2025.11.11.22.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 22:55:40 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 11 Nov 2025 22:54:48 -0800
Subject: [PATCH net-next v9 06/14] vsock/loopback: add netns support
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-vsock-vmtest-v9-6-852787a37bed@meta.com>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
In-Reply-To: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add NS support to vsock loopback. Sockets in a global mode netns
communicate with each other, regardless of namespace. Sockets in a local
mode netns may only communicate with other sockets within the same
namespace.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v9:
- remove per-netns vsock_loopback and workqueues, just re-using
  the net and net_mode in skb->cb achieved the same result in a simpler
  way. Also removed need for pernet_subsys.
- properly track net references

Changes in v7:
- drop for_each_net() init/exit, drop net_rwsem, the pernet registration
  handles this automatically and race-free
- flush workqueue before destruction, purge pkt list
- remember net_mode instead of current net mode
- keep space after INIT_WORK()
- change vsock_loopback in netns_vsock to ->priv void ptr
- rename `orig_net_mode` to `net_mode`
- remove useless comment
- protect `register_pernet_subsys()` with `net_rwsem`
- do cleanup before releasing `net_rwsem` when failure happens
- call `unregister_pernet_subsys()` in `vsock_loopback_exit()`
- call `vsock_loopback_deinit_vsock()` in `vsock_loopback_exit()`

Changes in v6:
- init pernet ops for vsock_loopback module
- vsock_loopback: add space in struct to clarify lock protection
- do proper cleanup/unregister on vsock_loopback_exit()
- vsock_loopback: use virtio_vsock_skb_net()

Changes in v5:
- add callbacks code to avoid reverse dependency
- add logic for handling vsock_loopback setup for already existing
  namespaces
---
 net/vmw_vsock/vsock_loopback.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index d3ac056663ea..e62f6c516992 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -32,6 +32,9 @@ static int vsock_loopback_send_pkt(struct sk_buff *skb, struct net *net,
 	struct vsock_loopback *vsock = &the_vsock_loopback;
 	int len = skb->len;
 
+	virtio_vsock_skb_set_net(skb, net);
+	virtio_vsock_skb_set_net_mode(skb, net_mode);
+
 	virtio_vsock_skb_queue_tail(&vsock->pkt_queue, skb);
 	queue_work(vsock->workqueue, &vsock->pkt_work);
 
@@ -116,8 +119,10 @@ static void vsock_loopback_work(struct work_struct *work)
 {
 	struct vsock_loopback *vsock =
 		container_of(work, struct vsock_loopback, pkt_work);
+	enum vsock_net_mode net_mode;
 	struct sk_buff_head pkts;
 	struct sk_buff *skb;
+	struct net *net;
 
 	skb_queue_head_init(&pkts);
 
@@ -131,7 +136,41 @@ static void vsock_loopback_work(struct work_struct *work)
 		 */
 		virtio_transport_consume_skb_sent(skb, false);
 		virtio_transport_deliver_tap_pkt(skb);
-		virtio_transport_recv_pkt(&loopback_transport, skb, NULL, 0);
+
+		/* In the case of virtio_transport_reset_no_sock(), the skb
+		 * does not hold a reference on the socket, and so does not
+		 * transitively hold a reference on the net.
+		 *
+		 * There is an ABA race condition in this sequence:
+		 * 1. the sender sends a packet
+		 * 2. worker calls virtio_transport_recv_pkt(), using the
+		 *    sender's net
+		 * 3. virtio_transport_recv_pkt() uses t->send_pkt() passing the
+		 *    sender's net
+		 * 4. virtio_transport_recv_pkt() free's the skb, dropping the
+		 *    reference to the socket
+		 * 5. the socket closes, frees its reference to the net
+		 * 6. Finally, the worker for the second t->send_pkt() call
+		 *    processes the skb, and uses the now stale net pointer for
+		 *    socket lookups.
+		 *
+		 * To prevent this, we acquire a net reference in vsock_loopback_send_pkt()
+		 * and hold it until virtio_transport_recv_pkt() completes.
+		 *
+		 * Additionally, we must grab a reference on the skb before
+		 * calling virtio_transport_recv_pkt() to prevent it from
+		 * freeing the skb before we have a chance to release the net.
+		 */
+		net_mode = virtio_vsock_skb_net_mode(skb);
+		net = virtio_vsock_skb_net(skb);
+
+		skb_get(skb);
+
+		virtio_transport_recv_pkt(&loopback_transport, skb, net,
+					  net_mode);
+
+		virtio_vsock_skb_clear_net(skb);
+		kfree_skb(skb);
 	}
 }
 

-- 
2.47.3

