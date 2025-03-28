Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C48C16BE3A
	for <virtualization@lists.linux.dev>; Fri, 28 Mar 2025 14:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743171345; cv=none; b=PzWPm+FEr+S+z30OzI0yPGbLPgwu85VB2SrS9huubXkgLokW7EWAcrQENIZyRmAZLc1/ODGGRFHoKmdJJ0QZdiQMTsSPQvpeXaDgothHFUYO1ksCsXQsL/Lxwi4dfE2LZDP5z6dy5R22UX9GFhYlMtW959dySLWoyihH2ez1mGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743171345; c=relaxed/simple;
	bh=FRgwR9NVLePyoA/jx/Us5P4QY3HAIJ4YkA7LAoces9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=lPwitSP/3ld+zSz5UGPhQKEu4OFYz3lsqz0T1HuTOS4Uf5VmzALRVQ3OQdSy0vxo3ff6tUuSLAk0dxFvFYrVd9JNv0cUVR1oD8hKrdPEzBcznDz0lFcnVQWW9yD04nj4SfKoN5htZL16HK2hti6svG8QUkjCmwcphU2lFpHCo4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ABM0Lmoh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABM0Lmoh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743171342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xooqL8JNylDfTCuXDGiM3ZS3m3cKnxP7jiQvva2sy6M=;
	b=ABM0LmohefAAC9AqeTcGsCtv6+N+5xjZ0IKMYbBEeuxBYwETv/Kot1q+13FhVrb0hXgPYV
	FO8IQzVyqvi/ozTxDt+K7P9nfD3r3lICwLdANe6MtVUxA6QGj+vB87b3bCF5klHVmv72TF
	HzlY2KN9ABeeQVBRlHsjB9/4Ihhx7x8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-WqZwfvIsO12AsaXL2vyv-w-1; Fri, 28 Mar 2025 10:15:41 -0400
X-MC-Unique: WqZwfvIsO12AsaXL2vyv-w-1
X-Mimecast-MFC-AGG-ID: WqZwfvIsO12AsaXL2vyv-w_1743171340
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac3c219371bso52423666b.0
        for <virtualization@lists.linux.dev>; Fri, 28 Mar 2025 07:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743171340; x=1743776140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xooqL8JNylDfTCuXDGiM3ZS3m3cKnxP7jiQvva2sy6M=;
        b=NGNnT+AdYv99na+MrOYOrVS083PybRXjm6PSj6oUATLW5bC4MOo5rqKrRmOiVg3T3H
         aVS5OPbwtsiYP7XPRNTZDNCCt+HF4zjGTldCspheFJqCsr5fWDZFAMtZYuN5yU/zifEV
         nViJIlgTxuqbiXJx9mq7gn5uw+d+oXIkhLOrq2zt4p5rgKPr2PePCulAEaNgUBVCHS3b
         bHdaw9EYgzL65EAohayxHVaHuLkIbyRMxDLjMZ6weYCw2wDRBX5lHjSAcxeSGazeuoIV
         SwnHUI7x/Ly49+NIMO3bBY5ecsRDHcRrd6hPU8gCDl3WWrZD2aHE1srRXF28wYXdYWJy
         tHYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ1a4to7LvF7JDPD0heJkofCnLhVSUE1piYni4aj0hWiNqt2+ASJPHcuYxAkiDYtOqiCyqlumxk81ymuzUxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAoJvehlUYo2fnk8rk7l5ZKCKZGODrmoirScKF4ca3FL3BKP1Y
	EeZRtQ8rhrMS4HxIwmLnGQtF6ffHNK/KD1/SrkW4sJDsI5dkhEBlqrGPpgoSqTm3JSumsZXklog
	CgO8SJGkUL2ssV1aEMr0YDwplAbwBufrWVes0ayEdvStkXhXe4M492zALw7l25lRr
X-Gm-Gg: ASbGncuXJvbdmrWHJ/8rJrIuQ4uczLKDC5sWpaTnCtdgx51MP8UgR+gJii2mDj1tbI6
	tkprEY7o0vz+gbygD6gKidSaee4ZoY1v1cNc4GAgEhh6MpBBu8fIH1VrAo+wH1RwWZdZQesx+6X
	40cd1KxDrFG7YQEF2w0cBrCaThARlPiZC5A5JZUL5Z0tMPWX0/RuOBs0FotVxoKcUtQOop0kmaw
	oSf8K4ekNwLRJfjN47fSxizAj+myu2vniz9AkSsnXeLH+TPN+0uXPEZni1KZEGQ7yDoLVFatg0J
	otqJcXQ6oROo092UGdE7eSp4pIAKF+CRfxYPoRfhr1RJxJsXoBByFrRltZqTwpaZWSEK7sdY
X-Received: by 2002:a17:907:6091:b0:abf:750b:93b8 with SMTP id a640c23a62f3a-ac6faeb60camr729515966b.22.1743171338907;
        Fri, 28 Mar 2025 07:15:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF1MvdaI0gZUTJ8fsf5IgoIHUlwoojKm+uMy9J1qv93tB206JFCOV8hdYvaYSnFXxyhmZ7Zg==
X-Received: by 2002:a17:907:6091:b0:abf:750b:93b8 with SMTP id a640c23a62f3a-ac6faeb60camr729508066b.22.1743171338172;
        Fri, 28 Mar 2025 07:15:38 -0700 (PDT)
Received: from localhost.localdomain (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71961f8fbsm166142266b.107.2025.03.28.07.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 07:15:37 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Michal Luczaj <mhal@rbox.co>,
	Paolo Abeni <pabeni@redhat.com>,
	George Zhang <georgezhang@vmware.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andy King <acking@vmware.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Dmitry Torokhov <dtor@vmware.com>,
	Simon Horman <horms@kernel.org>,
	Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH net] vsock: avoid timeout during connect() if the socket is closing
Date: Fri, 28 Mar 2025 15:15:28 +0100
Message-ID: <20250328141528.420719-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2T6tUBehY7Yt7Xv6d4lBXNDwn89tLi_YGs3LPZOKvks_1743171340
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

When a peer attempts to establish a connection, vsock_connect() contains
a loop that waits for the state to be TCP_ESTABLISHED. However, the
other peer can be fast enough to accept the connection and close it
immediately, thus moving the state to TCP_CLOSING.

When this happens, the peer in the vsock_connect() is properly woken up,
but since the state is not TCP_ESTABLISHED, it goes back to sleep
until the timeout expires, returning -ETIMEDOUT.

If the socket state is TCP_CLOSING, waiting for the timeout is pointless.
vsock_connect() can return immediately without errors or delay since the
connection actually happened. The socket will be in a closing state,
but this is not an issue, and subsequent calls will fail as expected.

We discovered this issue while developing a test that accepts and
immediately closes connections to stress the transport switch between
two connect() calls, where the first one was interrupted by a signal
(see Closes link).

Reported-by: Luigi Leonardi <leonardi@redhat.com>
Closes: https://lore.kernel.org/virtualization/bq6hxrolno2vmtqwcvb5bljfpb7mvwb3kohrvaed6auz5vxrfv@ijmd2f3grobn/
Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/af_vsock.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 7e3db87ae433..fc6afbc8d680 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1551,7 +1551,11 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
 	timeout = vsk->connect_timeout;
 	prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
 
-	while (sk->sk_state != TCP_ESTABLISHED && sk->sk_err == 0) {
+	/* If the socket is already closing or it is in an error state, there
+	 * is no point in waiting.
+	 */
+	while (sk->sk_state != TCP_ESTABLISHED &&
+	       sk->sk_state != TCP_CLOSING && sk->sk_err == 0) {
 		if (flags & O_NONBLOCK) {
 			/* If we're not going to block, we schedule a timeout
 			 * function to generate a timeout on the connection
-- 
2.49.0

