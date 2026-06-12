Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89934392C32
	for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 04:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781239974; cv=none; b=d2GLLOJlTmS8wWRxWd4gjkneEODg2i3bCg7mLWq7ZDhV+iAswDnVSXBVVATAFg/nt+IpoRcSNk4ci8ZV/1tnwJSZgUPSzzuCzRZ1ait8NcC6bvlXC6WgBvJQycoFuOO5cIbU5rWBd44NqAXMj07Du4Bpzds6gfTkeUx/DPPlK8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781239974; c=relaxed/simple;
	bh=vY3xbWXpmJfv2OhO+gb5k1OC5My2WhH+Y/j1M6gKkOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DlPZhVHGgkChn5RJsauLCcUE5LXDQOsuhEJJtD1ZxNBJ9P/PKQ3xwZC/au/kX0jbpB3gk6n5NfZPV+HZDbl68Rlo1JnhuqAX6jfhzVrylngkp14aWmpSrFr7f2WKtI8QGNRoD/VMYkYBkCYWagC4QEEVxvERO7q8ijSDFvPYjBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KL9+UaoV; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KL9+UaoV"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36baec934b6so921167a91.0
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 21:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781239973; x=1781844773; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+nZnDKFOx91pDYvjVh0Hhda8Rw1ouTmm9qCxw7hHaI=;
        b=KL9+UaoVN+l4LKhSj8T9vDvN6BKge7mvIXKRX1+DtcoVP6dvxKTbXKgirju9hjeKIM
         ryDX0N0ATaUxzH81X6i3iauI2hn962UlnfpFu6u5CKntkXvDDi9p51qutY0A/M8yKw1X
         jFbD71Ur54yIR9EO3+wmBUMinelFewuP4d7e6aH00XghSkJAO7wgxyFMjlbSFlF0eA8H
         sfFY87GoRhZ+mNIP7AJsCB4QHR9PcbKQH487w45p2Q0HusK+vceLdj+NcRqFaakt+s1w
         /4djvGqYR3nIAp720e8J/yPaNlMcakXRmozM80f915r/12BbIUvL1tleyIjkc3h23LA6
         NQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781239973; x=1781844773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y+nZnDKFOx91pDYvjVh0Hhda8Rw1ouTmm9qCxw7hHaI=;
        b=f8yPsQ953i765EUS+IP/i7JqJisr3nBv7W78wHj4tfntlCnQ7W9Q2HqZ+d5YcotjeQ
         L4H4xs33eAHdZSzAOtkKfPXI2c/GP6dUQtQ9YC0yMSdG/u71OmxHnuQ6sqdRXoKaGs43
         Ygt4YxmDVfEI84UF21DorR6OBOmQQj3EvmoOci3w2JRCdQ8iav7qa/DvsG8MrebAPGL8
         WQEKuUt/qPThzGCF2u5b9j/qauMI+8kVPW92ORCDzTCLBf8QEO9bUeUoktyxAgmq5Joh
         3B7eT6Fe6cSLcUIbZA6MQianvqRdN9eHFUHxhvblVXzvon6m8sC3EdlTD8o44jMVfmHP
         3EHw==
X-Forwarded-Encrypted: i=1; AFNElJ8GYLZ1huqjtXi8WATO/DO1KDdXrHGr/BSNdwKbodntzFKCrNIZ2G11lzuDknUSBavW+Z+x593V0ruVHxI6qQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2oEWk1rDQRA2f6xP9jGa36o693wo8jVNLgym+r1W+nh5JC7mV
	qFfotbFduc6bkjIJJx2Pac0rXgoXvembhmSKBmo3CTRaqqQ8wseZxBc=
X-Gm-Gg: Acq92OFzd8bOnXgH+hj9FIY7C4ld139ZBEZ9yyjy+ceEUjlSOk/nh1MY+TtL9BSvTP4
	tUxo5zkogRWsITJ72gMIGGDP3C4Uwo+wHiJHv6n5AX+fp+tTBcoVC5TYyySX1tSsLPxksOCW5bq
	V4LVy23nM3AtLnWHJe6CUvjS+zMAaLXtNKcMVtosxJrM129tqoyMU8zEK2H4vmJehbPNE+HyCYz
	D5KZj2xtiwz/HMSHOPbopLBOk5Rpmzcxd000q42irdLnSdvqtjQeFrCLBJt1z3sKFL/IJedEZKE
	dD8WH5Wyg6IsV/SpBPvF0hoAqJGlqKtROcEYO7tjWCJcuVDazkqhDlu9eXfhChtTfLmxq+73XAf
	nbvT+PDDtPILenadzDTvlP8vtwR4y3oL2PPTCL4cPMNliwX1tlh9N08EuSBf4iBq8dqpTWg1RF8
	d4OyitDsm5gnGdhNKP+hTDmskWeukmpNkoIyt+ZT3WQO4wOBYxKsy4316I4j538ro1MBk=
X-Received: by 2002:a17:90b:2cc3:b0:36b:de66:92c3 with SMTP id 98e67ed59e1d1-379ef747839mr1322790a91.10.1781239972964;
        Thu, 11 Jun 2026 21:52:52 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661b5b207sm827558a12.5.2026.06.11.21.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 21:52:52 -0700 (PDT)
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
Subject: [PATCH net-next v3 4/4] vsock: fold sk_acceptq_removed() into vsock_remove_pending()
Date: Fri, 12 Jun 2026 04:52:16 +0000
Message-ID: <20260612045216.105796-5-rafdog35@gmail.com>
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

Callers of vsock_remove_pending() must also call sk_acceptq_removed()
to keep sk_ack_backlog consistent. Move the call into
vsock_remove_pending() itself to make it automatic and prevent future
callers from forgetting it.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Raf Dickson <rafdog35@gmail.com>
---
 net/vmw_vsock/af_vsock.c       | 2 +-
 net/vmw_vsock/vmci_transport.c | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 24916dd4e9..4a7d6d247a 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -494,6 +494,7 @@ void vsock_remove_pending(struct sock *listener, struct sock *pending)
 	list_del_init(&vpending->pending_links);
 	sock_put(listener);
 	sock_put(pending);
+	sk_acceptq_removed(listener);
 }
 EXPORT_SYMBOL_GPL(vsock_remove_pending);
 
@@ -773,7 +774,6 @@ static void vsock_pending_work(struct work_struct *work)
 	if (vsock_is_pending(sk)) {
 		vsock_remove_pending(listener, sk);
 
-		sk_acceptq_removed(listener);
 	} else if (!vsk->rejected) {
 		/* We are not on the pending list and accept() did not reject
 		 * us, so we must have been accepted by our user process.  We
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index c2db016cca..3e6445f4e1 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -980,10 +980,8 @@ static int vmci_transport_recv_listen(struct sock *sk,
 			err = -EINVAL;
 		}
 
-		if (err < 0) {
+		if (err < 0)
 			vsock_remove_pending(sk, pending);
-			sk_acceptq_removed(sk);
-		}
 
 		release_sock(pending);
 		vmci_transport_release_pending(pending);
-- 
2.54.0

