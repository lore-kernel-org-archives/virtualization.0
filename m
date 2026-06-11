Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA4D318EC1
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 02:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781144029; cv=none; b=WN5b/VU8nqihOKefRPZ6zq3VNOUrjWJ517Q/42MqpqRY6tbfbAPPnGPr+nhyI879v+DbEvb2wPz5ym3UjeudhsjUWxJP2zM3rbGPME1lr7KkcaSwzW6nFroB6j5M/EQoqty0Dst58VhVam76hYK1a2IreHvxQs4b8r9/XaR+tJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781144029; c=relaxed/simple;
	bh=pCv2uNV2MVL3fxbs5ZXcM2FwQJP2y6IJtwscrfbR71s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5aUTFP9IqI6uUywQos99uvAk/tUxk8+xYP8az+Df6DwdJDmUxJg1DzWDSebCcNAfkgguIF9RF/TEPQvI9jEDMV/a6o4pzpy7l8U2bd7FsbSZdFXKIKAHrN06GUDBpoQErQIys0XfnZs9xCqj+3PYheC1TtgnQTpDlZGlcaKeDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXkXn6ru; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXkXn6ru"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36d6bb38b44so4856555a91.0
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 19:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781144025; x=1781748825; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFklSXz22wlzAbFptOPmN5E20uk8JdhKComw8Vj+xSs=;
        b=aXkXn6ruTsVGiJ7xrbCR7+ffwnKKHcecFxlQ0KtbKm3mPPmtkXRrr8RH3rGZsJul7M
         wkMKO+DcuE/sIcfwjRg45pRkbyJ5r3qwLP3GsJ+oIFfsDW4rx4Xh979R0RItw/A/ryE7
         vTfAkX7PiSkbcXT83htPLNvcbZJVwrLP7xpjmHb1X5wPYr5Mzmx2TfpNgevzJPw8Q9KG
         DZlFdCDIRpamk509uAitTZVp2XZyAgovI1LqtnMx/BMRDoQmgSjj4CfZRt43KrTiJfPr
         cmQTYjJml3TiWZx4bRb+90Oo//5UTVjOmqb0VK+9mN7dBimhcgbV6o7XEXN4LB58mEM1
         yFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781144025; x=1781748825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PFklSXz22wlzAbFptOPmN5E20uk8JdhKComw8Vj+xSs=;
        b=Rc1EoPCt9vXdvgEGrlYBLxZF+7XicZwVjnpJQyUWh1yXrWUIT5oPD5G//ikZ/3Ir4I
         cAO64FfTx5PqXLEk6thSwej35M1aZtQzCwPPhgA9D5/87U9/4qRci/2Kd1NCq7+d+Hbt
         pKkvD2VicdQ4Nr0P2BCT+f+siyu7261tF46RQHON9VFbKpu09Kzs2WZ4TKco0dQLUZYW
         XIup2wOjhSk+Qt339buQfKvVabLlsk7sy7y2SZFWkxL+rTyLMbI098Hs3Ld09QJLugr5
         OAh6nBhzMh8Qxb5HdHRonRSyatqVPHz2sDZbfD5EvqkfpixlQsvMCRG1vPYhA8LYFfMB
         +LcQ==
X-Forwarded-Encrypted: i=1; AFNElJ83fxQPwtqc1jXaaf35x8SREJImC6LNrPyw+Uc2kLwhAUkFCo89U1AMZOQpAXDVfQnpTzfWfIk19VLmfREQSA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw63l7qU5zgZOVIRhtzxOVygyO2s2PWENhKcxU3IVV86aHQLxuI
	DlnHOFLiAWI6aFitpnDQineTu19Y7eDpzrzKP1VtSI8neO6szEF/qFE=
X-Gm-Gg: Acq92OEJpocaH44Vnjc/g2c8jiv7tCZjtv5rMFujU+WI1BFb0DCyemOk2a0I/OawdlN
	4Sn3VCnf3cO3T6vR2CkdWLnn+HR3AL5AMF9WRFA6mqhZECCqTVSk8sNI+yXi69xj2K+OCeHYCE9
	3kGHX4CwJCU02832Q+3Y0vsHf6S8GiXKZwEBv4wDPPsqsumfD+Ti9iylkHfq441qpknO3YEODh4
	eeumqQexE/hbeE+1dI9OZo7iVtl6tGYxEPkx6HmLaJwBiGO4/DYK0XbzV3gkw1YwY36n2RQhyGN
	nBwY9zWb0My0jaY7Q/SIG+/tlH7OxsvCHkzGp+HTzNCnUEqovForkGUa7p5N7bPLVdQz6pULoVR
	SrUKV0n6rJTX9WXVmfa3a8IHjYwQdDtgZIG/4Etp/i628WRua0sVrfyE/uD3bZzseL8XRgKohBK
	MIGrrTcSRCviEwYSbt7aKtDNieeuuE4cQS5UKKwNouh57WBYy5fLSfsnTt/fAZaPhaExi0nte4N
	9xKHw==
X-Received: by 2002:a17:90b:2e07:b0:36b:a0fa:ff96 with SMTP id 98e67ed59e1d1-377a75cc34amr931123a91.12.1781144025387;
        Wed, 10 Jun 2026 19:13:45 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a0eb9sm732006a91.4.2026.06.10.19.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 19:13:45 -0700 (PDT)
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
	Raf Dickson <rafdog35@gmail.com>
Subject: [PATCH net-next v2 2/2] vsock: fold sk_acceptq_removed() into vsock_remove_pending()
Date: Thu, 11 Jun 2026 02:13:17 +0000
Message-ID: <20260611021317.69362-3-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611021317.69362-1-rafdog35@gmail.com>
References: <20260611021317.69362-1-rafdog35@gmail.com>
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
index 91516488a7..a417403c8d 100644
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

