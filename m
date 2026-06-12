Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AD5392C32
	for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 04:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781239969; cv=none; b=RxxukizqgzXAptyH/JkjjCA4h+4VHQbowdyX78sglu+yv4bCbsQB7kBq+ju4852T4vCm5qL2nWKNBCGXovTWbluDlkqSGOQEGXLaEqm28UuZLxT06SCrkMn8l/tM/o5GwTMU7njlQlLoNy/WeNEhLPQeQaU9t3nmCNdUkLybup0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781239969; c=relaxed/simple;
	bh=T5KX5my/pwkB1VBFQsvsOQjLPEkU3WFPk0POQo19dM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yf9PRzlj6NufsGMFgS5K0KxAv0J1z8GdyVKhfmY+Orp6nyD6srwMPqQB/DQAYQ7a5me/5h4e4dG3ct5A8DOTCie64QTUemzUyd4pTYb3fSfmwocmjAbWcVLZ3tDqA9vE4P7cewfquy7Tg6B96k8jpByL9xUlZvLLjgxMG9zd6sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y80J3ggq; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y80J3ggq"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36b95eb4bb4so384141a91.3
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 21:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781239968; x=1781844768; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmatnySEe7N6+CsFplL1yTSQwiL8lRoVJvOz58vrZgI=;
        b=Y80J3ggqIyDmCaELpQW5gN8PNIroijguGzf/sTdCtXu5KrUG6+wzWMMSzqiMrunVsG
         dPGZC0GAE00ZilXnIhkSXa8TQA2TY3GuP9hXR/zAWDLp5+v0FgkzvzfRNEhVgYUH0lsY
         cf7+SXq8Uf9ekELyC626cEDDQE26vFP3bl3zWUss6+iyee5qe1qf4LIX9xxSV1ECHEyp
         iRptWazBnpOf8aGUQ8XJHB/hDy+6zmYKqOQq1gFbIES7zUQc3cSvKuNoK1db2SGeU2ae
         n+rOSbt4Y8p4rutUvbfkl4MgV8IFo9dkHMgnCfQgaLDb9e/jkL3WOpgfgRx0nAIr0qDj
         o8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781239968; x=1781844768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qmatnySEe7N6+CsFplL1yTSQwiL8lRoVJvOz58vrZgI=;
        b=oZar3e0fsauGvpCaNvjDle7E94AyLgjnt8stwGCHcUxRJQP+3CV5Xdky+f5hb3Hs+a
         sr8t8eCG9NGfvOZNwryKBhDjsNh10S0NPJnDM0pk2qGvo9HzrHXuYNweyGcdJXLIMIa6
         8y5GU5o3zwyV1pQx/CoIgrhdfx+xXJc2be2XztEoFau0N2GOf7xC/3xyVuVPfEmda6IS
         kR1NkTQMf1e872JU4H+h4Zx3thIj67RIXvenCx0lDyR9NhA5rCJfEg1th2WSi7L39IO7
         zZncbOjnFegwORnUaejxVSvhXhvq+qMl7o/+U9d5jqidMLvEElT0+JxWSzNlkXA671UM
         y+6A==
X-Forwarded-Encrypted: i=1; AFNElJ/PqwkzEVBgw4YbT4+kywxWaWVV75DZKoIdH1ugzwCeKw4N3ifwqWJ3TLosGto+ubWnM4428+/c8empXmNa8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YySTNgbryYuaANSiT6icf4ZU/aDVsICpWfqFeGjiDvfzWjY2DbV
	2MhAGvT5qSnR+RmYPdedS72htXyDr5hd8UalBJpkWHx/5OLY8nb3DYM=
X-Gm-Gg: Acq92OHgrWu/cB2MoNKJwO0z2pY25SscqsjziG6tVp9mcQ9qXBXp7sae5yPVSvgpmym
	5V/grTdraQBBPKpiopK7xs7onS6rip48OYiJ45woXcXzeV88cBWl5xt3wH0pnOAP5k10LeRfHuv
	9gJGdK1oAg3Hu/Pz6JBL5gLrezA7HhQYrdUgHciJw7amhyyxKkoVbOtagxoPgzncpEtDx0+A7nF
	MG75w2EJVfenPV/Hj17qJb9zhxZ3MAbstIJQLl/GYtAcb4GPi7pnlHLo4hFd11fY3HsoOYm9Yb9
	AvaGUSTM420kTyy8mDqpB5lP0FU9v73zqkj55JZgttLBzggK09DR2ikdD0ZOBJcZ7UXxrKPwerj
	NyNz9lGJSX8KMZTNf4lih9oWuGZZJs+RkAXSEIUfF6oYBSTQkVHMR9ganIGGM7EnSmgGdQnaCsh
	KHdJrv+AMOrRgmZmDD3dAhPeQZllQEbDDZNx3KNrhAC2BXvLKkTZZbJvUw4z9667Karqw=
X-Received: by 2002:a05:6a21:a8c:b0:3b4:85db:1bdc with SMTP id adf61e73a8af0-3b783fb1e96mr1684565637.34.1781239967697;
        Thu, 11 Jun 2026 21:52:47 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661b5b207sm827558a12.5.2026.06.11.21.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 21:52:47 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: pabeni@redhat.com,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	bobbyeshleman@gmail.com,
	leonardi@redhat.com,
	horms@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	Raf Dickson <rafdog35@gmail.com>
Subject: [PATCH net-next v3 3/4] vsock: fold sk_acceptq_added() into vsock_enqueue_accept()
Date: Fri, 12 Jun 2026 04:52:15 +0000
Message-ID: <20260612045216.105796-4-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612045216.105796-1-rafdog35@gmail.com>
References: <20260612045216.105796-1-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio and hyperv call sk_acceptq_added() immediately before
vsock_enqueue_accept(). Move the call into vsock_enqueue_accept()
itself so callers cannot forget it and the accounting is consistent.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Raf Dickson <rafdog35@gmail.com>
---
 net/vmw_vsock/af_vsock.c                | 1 +
 net/vmw_vsock/hyperv_transport.c        | 1 -
 net/vmw_vsock/virtio_transport_common.c | 1 -
 3 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 6cfa89b6f3..24916dd4e9 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -518,6 +518,7 @@ void vsock_enqueue_accept(struct sock *listener, struct sock *connected)
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
 
-- 
2.54.0

