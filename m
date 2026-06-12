Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9056C25A2BB
	for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 04:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781240333; cv=none; b=ewekW24WnoZq00crgAh5oyRM+GCbBa59qxsGd0Nqtydi+JGwBFq42a+HsZwJZAM+Z9TW3EzQqaoYU7+M8n4UYLYXpuSk6dskSjW1g+XJDZ5N2nV3z0rDAVMFl+55LR7StYJvEg4W3Uq3BWUVqm3sj9+Af1c7BopWli/HYXK0l94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781240333; c=relaxed/simple;
	bh=7CDc1VC0CSAebI99AQNCddLZByGdXXRGb5+F59BiEOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hi3fSEW4ICGiisgF9yGsBX8s0pfHSZxGItZ7xMUXZHg6Hopx3Io+3NiKMzxrvnWHxZqa2eD2dJOXnQ4uUg/os4kVygaRFthYPpCWdiBv6hPkWDlcLEgI0kGGZbg+WdLHH/1aWZYAXRunbno1ehMRDzLyl7jNKCo+iFLtQkfNzbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTR4H0aO; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTR4H0aO"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c85825bbc4fso336940a12.2
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 21:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781240332; x=1781845132; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zVPVrX1hyAux39TAWqdA/40QGd90IV9ztdQhv1wsAhk=;
        b=BTR4H0aOJ1NeUqbXwDFVFQlxzSvkEmDcznKeNVYu7jFDnvTkrEFP7KGLZp1fySg1sv
         28E8mX+PM1XOwVNx9nyPbfgmZFAkAA9uJHSNcDRhgIUfycxoc7UBo8TwmV1xvAuVC3X8
         sHCnVoJLJhciyaeJw7YMyt5tzVHuoB1OK1AUsJpLeyoYIR+AZcrF/DN2bife+jI37g0I
         yYR1F37V/aBeqiUGyK9xgNZ7N6n87uJw7MU4SyeFuq9zjmem6qy/uMEJuHEUh6svpAUK
         VAlLJrGTEu8+1QTx1Jy51b7swDnfExfMx/agkdc4MesDkWBcuOWylvhyoqAIRzNRNPnf
         3wOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781240332; x=1781845132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVPVrX1hyAux39TAWqdA/40QGd90IV9ztdQhv1wsAhk=;
        b=qwSuq1Wx+BwrPIFREKracw4R6yGbK+EJmE5wqxcqaogyiUDy1Z+np18VKiNVqnJIYP
         /HYJB90+6Fz+8gQdemA2L5kFkhfRJQnardor9H32sP/rrhgSKfXluM2xpv2rulNPsP+6
         B3klQkimUFvggabm7oiy++VFqwazREeqzWuhznYKdm/M0ILvwisZkDwy7j9fLEbHhcZD
         OtI8gu5/oJc0EA+VvsnWLbbGgzQs1/Mxo+3Ui4ZRwLNGiKQxoAqCIuSyZlaRQXvI6m3C
         LxoCi93WCpLUVNkqrIToXJ8wMeNZvfuOEs5jApP/zfG1fTW0oYdx5yu7SFhjEp+4KefZ
         EXIw==
X-Forwarded-Encrypted: i=1; AFNElJ8tGuawGwPyCPkOck66vojVGRicpurUcw65fxMTAtLuIqrh3hawMhkPckg3IfzYUi4ofHFjycaikvX9Ild9RQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwH9zTqGyX2X7VAWOPI6wZVXe1TUgg/lM7S1bLbhduU1axz+mFs
	JxwPmsIfPk+Qmtl86NZRhHU7nUK8hDnw8x5GGG/DfRrGbcgHdbf0j2w=
X-Gm-Gg: Acq92OHgLyChpGM4UZJuigidDhWFIlMciVdfNJj3d13QUCR387nrJT2QnIb6VuHBjZz
	Bs+vQ8+cPNKovrxcsOreh07rWC/HTCGXejsEqP3qHqKlF69F8K32y6FcRgbEjvU1CJy/qM9jF1M
	GNT4yneh7Kb57QqaVHtfNUeH5VfULvVyyDKAvlUekUtH3cijPEEaQKHAY7hu7u8VFiPoGuGpHyw
	0ZeSS9JnebkR3md6ymk6c+97k4k0IYBwV+7gnx5pLgBvt0A/iCskYJLs8tFCdNHOkTjuFQSaNro
	IIw++uxlqURFC32lxbvFpKQdRzZfgjkhht7ciFrY+Xov4Qis/F4WRJZsk+BaR1dDwdSuNRFJ6zg
	uTA2jy2ryfwBOvvp6vPcVuD4nan/3Ytp1UJJKLX9kjpmh9GJ4qgp/95dZzQL/ye/zYFu0jfm9aG
	nSfhQXs0lFcn64admFadGx5WxEDYj0zgSxA5ZJjZSg02xFxP2Zf+NZkYtO/dCZ8h1bwcs=
X-Received: by 2002:a05:6300:670a:b0:398:8870:b58f with SMTP id adf61e73a8af0-3b783eed793mr1561419637.14.1781240331842;
        Thu, 11 Jun 2026 21:58:51 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8665186aefsm817838a12.15.2026.06.11.21.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 21:58:51 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: pabeni@redhat.com,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	leonardi@redhat.com,
	horms@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	Raf Dickson <rafdog35@gmail.com>
Subject: [PATCH net-next v2] vsock/vmci: use sk_acceptq_is_full() helper
Date: Fri, 12 Jun 2026 04:58:42 +0000
Message-ID: <20260612045842.122207-1-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the open-coded backlog check with sk_acceptq_is_full().
The helper uses > instead of >=, which is the correct comparison
per commit 64a146513f8f ("[NET]: Revert incorrect accept queue
backlog changes."), and adds READ_ONCE() for proper memory ordering.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Raf Dickson <rafdog35@gmail.com>
---
 net/vmw_vsock/hyperv_transport.c | 2 +-
 net/vmw_vsock/vmci_transport.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index b3394946b2..e6adbc4701 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -323,7 +323,7 @@ static void hvs_open_connection(struct vmbus_channel *chan)
 		goto out;
 
 	if (conn_from_host) {
-		if (sk->sk_ack_backlog >= sk->sk_max_ack_backlog)
+		if (sk_acceptq_is_full(sk))
 			goto out;
 
 		new = vsock_create_connected(sk);
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 91516488a7..56503bee31 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1010,7 +1010,7 @@ static int vmci_transport_recv_listen(struct sock *sk,
 	 * reset.  Otherwise we create and initialize a child socket and reply
 	 * with a connection negotiation.
 	 */
-	if (sk->sk_ack_backlog >= sk->sk_max_ack_backlog) {
+	if (sk_acceptq_is_full(sk)) {
 		vmci_transport_reply_reset(pkt);
 		return -ECONNREFUSED;
 	}
-- 
2.54.0

