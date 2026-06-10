Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E37B3A5989
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082837; cv=none; b=dVn9obIUom0JGDyCrh1MZHOHu1iYlVL6xF5tzl3/h4yVqjbmo3ciwUTKxSSnKmRDEiVHXiZ06PAxJBtay2pd/wWn8hGBjKiFfD0FmTtdn1IY9YnXl6XePQdWGgfa3vVvrJZerrsQyu87fTjtzbdcIX+VqIbllSL+P7zEz0Ht8FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082837; c=relaxed/simple;
	bh=n9Pb7a3axFjzxDMjrZkjjorf1UU1SU9m+G1T7dF5YAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OU5EPFgIV4OKv9ytefhxT4pVfWpgz0YIg/xyyzLxlvgvA89Sqbo38kmzPRBoHtUCz9OFCDiAdnt2gVQHeRuJG62P512vFXy0gnVzn9rUOGz2fTNcDF+Y12PWdCep1xdJwQdTYmsgi7bUYG+ILharUJ1iP8HAbI7wO+oV/PC8WZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIsf0Wfs; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIsf0Wfs"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0c2a68d01so44040835ad.1
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 02:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781082836; x=1781687636; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xujE92v9Fhi27fvUp8TSHkV9oiEzGhWhlzdRW6++/1E=;
        b=OIsf0WfsXcpT9CDMjnHRsZjI95jZaLlTFvOiyIBYMNcE/zw7bDh6lx3p8PrhQ2cRi8
         b5AdCitKcUy+g7ULHE/RTMW6nfSww8iOtrssoOs0o4RQG3xDD6O5rS9VfiaugiSyhIwq
         K33ZMkZOjKEwe7wce3JO6ZHRqSaJ/lZzUfdWfp8A6l/6SzbIdaKcT3ZfgPnYz9VB1E1F
         5D/Jh+LRrnSIOOcceT35+NsgltT0WzYl8INdJOPvTJioM8JxfO5ASRXhVp+xoHzFXU0l
         OLYjHxw4LkvigCRDRIspiG3VlaSof5pY1Y02YyPsFtSqQ7BXEKvIMNBsCE6zSN+4lHRB
         U5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781082836; x=1781687636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xujE92v9Fhi27fvUp8TSHkV9oiEzGhWhlzdRW6++/1E=;
        b=Ww4/9ibDpXBNGm/5ye/tk0MNay+pP3KAl7CQ8j6Be3gw9P6BLdtU5tDTtTMQEOGLty
         a5kvbTZOIN1wt2E9AXJEvULXCJj/Bor4fsIkGPDSIhkQ9lKGpgd2LqT+lc2R8SPOYRQ4
         efg/kmLvJGLkr1+KlxLyZBA6StIYtusePNU7zMrKeBa8Cfti+pNWN60DCj5wO4Wv3zNr
         frWfSJ0z2kteTF7djq6AXVfcT3CnM5UxKWESgZf9pQzLCk7IJC2h57XFE/s3mljtuoMR
         6wW6YGO0wc6KFEu7NInobWeA3dw1/19RzyXxt/kBJoaSgEhpuZF9di8vi01LNoWPGTQq
         mjKA==
X-Forwarded-Encrypted: i=1; AFNElJ+EHWIhJYTFCpg6gkI95ZFOhWgkK9wOypdEwjmNRm58U4af/B3Z53uyhIKAIZlT9QmTTxHB7FoSfs7x9NXuiw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJGbfBMzyhGGXHA8y0vBh2f/ywLuiNi2oLzlCTFvy1nmQ8O8uc
	J5p6OndsVTNvFHwLFiTuptDeuQvSJAciyod8p2KzNIhRI00Q8LGbwbQ=
X-Gm-Gg: Acq92OEOEeXOl5E+lLMTuI5t5wRoBUDYWXqexML78A9wEgK+BxAdZxMoxR5Pt+kmKFH
	CGSDJ+ReFmnyl/e2kdkvS/OC7hMXKblMDAGK49a5+ObFH3+Yh0oMakJxSlnYEupF+VkEEMddx7w
	ElMvwBYUWhMuwjmbgUEEFr+pSdSXdITIBa/K9aVoxqlK5MN9XANqbSWJqNnbYOE2CcXwtbjRWFk
	NdEJb+XZAOrOL9/e0h4W7K2eX5CbGlgUuyhJPgfZZTqRqWuGi4/5z6ubBIVeJ71yvtPCNTi1J6j
	hFw64btb7+wYVhEPSA0jv+TlLWMWKzOmFznFKJsfr5C1UOTtgnipukpQMtqDoSQEZble5W3ErCd
	Rd9w6RKnWD6IRLRLZ/m8UZSV/NquyKIwI6hQj/Om5gPEt9LxicOPvW2I2BQed471lls59zFgCLp
	HcUbnQyRP6YymqnoDF95iryvoGU6vlqfL8fqBPXkdhZyAg1rZB0y/clDxPOaZVImvzI4g5CvT8a
	ffmlA==
X-Received: by 2002:a17:902:c401:b0:2c2:cf20:213 with SMTP id d9443c01a7336-2c2cf200450mr7795645ad.29.1781082835600;
        Wed, 10 Jun 2026 02:13:55 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e096sm242991765ad.44.2026.06.10.02.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 02:13:55 -0700 (PDT)
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
Subject: [PATCH net-next 2/2] vsock: fold sk_acceptq_removed() into vsock_remove_pending()
Date: Wed, 10 Jun 2026 09:11:21 +0000
Message-ID: <20260610091121.213324-3-rafdog35@gmail.com>
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

Callers of vsock_remove_pending() must also call sk_acceptq_removed()
to keep sk_ack_backlog consistent. Move the call into
vsock_remove_pending() itself to make it automatic and prevent future
callers from forgetting it.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Raf Dickson <rafdog35@gmail.com>
---
 net/vmw_vsock/af_vsock.c       | 3 +--
 net/vmw_vsock/vmci_transport.c | 5 +----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 73e6416ee9..b9772a0205 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -493,6 +493,7 @@ void vsock_remove_pending(struct sock *listener, struct sock *pending)
 	list_del_init(&vpending->pending_links);
 	sock_put(listener);
 	sock_put(pending);
+	sk_acceptq_removed(listener);
 }
 EXPORT_SYMBOL_GPL(vsock_remove_pending);
 
@@ -761,8 +762,6 @@ static void vsock_pending_work(struct work_struct *work)
 
 	if (vsock_is_pending(sk)) {
 		vsock_remove_pending(listener, sk);
-
-		sk_acceptq_removed(listener);
 	} else if (!vsk->rejected) {
 		/* We are not on the pending list and accept() did not reject
 		 * us, so we must have been accepted by our user process.  We
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 4ce6660c11..356bebca7c 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -980,11 +980,8 @@ static int vmci_transport_recv_listen(struct sock *sk,
 			err = -EINVAL;
 		}
 
-		if (err < 0) {
+		if (err < 0)
 			vsock_remove_pending(sk, pending);
-			sk_acceptq_removed(sk);
-		}
-
 		release_sock(pending);
 		vmci_transport_release_pending(pending);
 
-- 
2.54.0

