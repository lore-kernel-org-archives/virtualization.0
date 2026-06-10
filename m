Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4762C3268
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 09:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082832; cv=none; b=OZ8sB2lFKh1O+AWf+UTJ2VnfCu3vOo40pKtjMJ/CMYQdIS6SzmRBa71k7WS5fbOXDoipFEoVniXEH6jo9bbJKmcSPhNyBFMuOhphUfnop146HBtwKSulVL+73G1smGg4hhVvkDQt0dv1wr4VSFgazatCwavI5QRe0ItabYqHNNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082832; c=relaxed/simple;
	bh=8yiNPwqyK43QFy6Ol5H0aA610nBvzzJ0X5Ewgi6/K4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCgPZj8z52JfOxtbSK9QNXvKd7WDc60dPdn98hJrEDGt3OMi14VEb1cuT6FKdGrNqplXihPk6uLwfqBKjsce/ppJcZyaXFHT3UKQquZLHvPqi4HhxNbDzj9PYZTWBPmBHgHQOxftfzeZ0Uz0zlrSG2c6PJS4JVfk42Wl1tp4PSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxqGF8BC; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxqGF8BC"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c0c20f0c0aso50203765ad.0
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 02:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781082831; x=1781687631; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B29ZuDjmbatWsfgDCYAMxPZ1omkDfUZq2rNYK60Wnps=;
        b=IxqGF8BCTTCLKwh9CKBdxgJWmWDQZ4G409ViPySdWN2zNFqsAqtlimHbc0S0v3esac
         5xLJPkLxhezZWhLCwLHbJbHI0uJ1vrN3yrV8sh8u++zx3ttq++0uAy55tIzJTyCRhaS8
         WQYVESg2MdZLll+eBvy7X9G82t/rPbt/WIrVJYat68rliIKDJNG015EMRnilyBQ6vY4o
         alYJ/2piFXXYFFdCN4yb0csxZVSw/vw9FkCFX9iHxoatLNyCpPrirmegvlw6HSXlVaqb
         o1LUQe56DRH496Mrjj+Afd2GTT0rMz6fPVh0axQjBE/FGgDElXuKIkYcOw74JvZZrBEK
         Gqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781082831; x=1781687631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B29ZuDjmbatWsfgDCYAMxPZ1omkDfUZq2rNYK60Wnps=;
        b=bE0QD58E4YXMhlRhj6bErwGM9RsgUDH+cVaaOgd/SFfGaKcLarXSB/vR3RsB5uJ/2D
         s1S0UKJ/P8ORpO22PZFCmUPi3uvmAH0a3aMexaCDGINmNr4sljS8cGWvL+Jnr9yvcC6e
         1VrOYUde4VCBo2Us7i/P2hxDzKz0DQtGqB/iQ/9rRdnfQrlOkjQ0P6i8eSRBMKRl+NcU
         JXQl/J+yNZ8RIBi3Q5mprZfc5Qul2ji/BskG9tVIu2d6yEWtFds1rIUDe3KFt0AbIzNS
         As4MsguiqAcERnaKeo6P4ehK65q6azIBigTd8MreUsDdvssNaTvUcJr6+QJBW/R0V0q8
         pP+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+ty4lUr1Ek39A/oTMpk+L4dnxcCXvh87id6GVAjlSTJKBKOLaRHlS9YkCAWhBcgR0XANPqgSwrb6H74dGx0g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9OHDFca2fJzw13ku4LAr3UdZ1evtb6sx7BEBIjKLpoQJMbIaY
	2D4MVn83aILtEQPL+CYHpeFqZgfXV9JIX2zGWDDOq7q4BQ60yIeAxOg=
X-Gm-Gg: Acq92OHYRi1XbdUNBDki8IQavS2fILEgEp5IjyumlwWg5L6hkWKpCUvHRXkLAh4Q4Nc
	jQQ8NCpbk/bW0Rbfya2K/QcyXlmeB7NLIVbhdtm98Gq2OP9s7EB0CBaKJLNw6Apr6ZzWkQ+VaAo
	FaA8q8fuBT8+oRzN8nfAnLFa4rO5f40BVNHVuB4NsUZ9itsA0kBvImvS78xZvU2M59iQZzmGP9x
	DzR5V5tHn0eIai8m70SPpeYEzoiGv9L7QJJsStPQ2agVG6piXZwnn3L/smA+/2sx5C4Vlm1eQN1
	39cNYNdhgUII/wv8msC8wKNjRu85FrbJFnr5zJVIV9667rIrwN1H8zCBjQXicc3Apk1sdPrIrZ9
	1cbbN+Fshxj3xcnwDqhkP5ZoVbC8e2gEe6iEyyxq1Z3nWtC32HznoPKuxAa0esC+fILMyOk1BIe
	aN9jabTHUsJ7R4McaXEDEhIL18Mn/pNWzMXyER7xjGVAxpTchlV8jx/731wZRidPcRvUkaNoGgd
	T6mrg==
X-Received: by 2002:a17:903:4b46:b0:2b2:5314:e96a with SMTP id d9443c01a7336-2c1e80fc534mr276460955ad.34.1781082830780;
        Wed, 10 Jun 2026 02:13:50 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e096sm242991765ad.44.2026.06.10.02.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 02:13:50 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: pabeni@redhat.com,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	Raf Dickson <rafdog35@gmail.com>
Subject: [PATCH net-next 1/2] vsock: fold sk_acceptq_added() into vsock_enqueue_accept()
Date: Wed, 10 Jun 2026 09:11:20 +0000
Message-ID: <20260610091121.213324-2-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610091121.213324-1-rafdog35@gmail.com>
References: <20260610091121.213324-1-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All three transports (vmci, virtio, hyperv) call sk_acceptq_added()
immediately before vsock_enqueue_accept(). Move the call into
vsock_enqueue_accept() itself so callers cannot forget it and the
accounting is always consistent.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>

Signed-off-by: Raf Dickson <rafdog35@gmail.com>
---
 net/vmw_vsock/af_vsock.c                | 1 +
 net/vmw_vsock/hyperv_transport.c        | 1 -
 net/vmw_vsock/virtio_transport_common.c | 1 -
 net/vmw_vsock/vmci_transport.c          | 1 -
 4 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 2ce1063d4a..73e6416ee9 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -507,6 +507,7 @@ void vsock_enqueue_accept(struct sock *listener, struct sock *connected)
 	sock_hold(connected);
 	sock_hold(listener);
 	list_add_tail(&vconnected->accept_queue, &vlistener->accept_queue);
+	sk_acceptq_added(listener);
 }
 EXPORT_SYMBOL_GPL(vsock_enqueue_accept);
 
diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index b3394946b2..0de8148877 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -410,7 +410,6 @@ static void hvs_open_connection(struct vmbus_channel *chan)
 
 	if (conn_from_host) {
 		new->sk_state = TCP_ESTABLISHED;
-		sk_acceptq_added(sk);
 
 		hvs_new->vm_srv_id = *if_type;
 		hvs_new->host_srv_id = *if_instance;
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index b10666937c..4a39d48db9 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1582,7 +1582,6 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 		return ret;
 	}
 
-	sk_acceptq_added(sk);
 	if (virtio_transport_space_update(child, skb))
 		child->sk_write_space(child);
 
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 91516488a7..4ce6660c11 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1109,7 +1109,6 @@ static int vmci_transport_recv_listen(struct sock *sk,
 	}
 
 	vsock_add_pending(sk, pending);
-	sk_acceptq_added(sk);
 
 	pending->sk_state = TCP_SYN_SENT;
 	vmci_trans(vpending)->produce_size =
-- 
2.54.0

