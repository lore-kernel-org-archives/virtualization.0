Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933CA1FF7C8
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 02:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781145572; cv=none; b=VMKYKorRRwVGv7j3m4GW5obyacX0CcQ0gYakk5zfDIVsuJEsctT79AmWf/8Acj/HAAwVi05gdm9sZ3y6HKKeP7vpJO2/th+Z+clBqN9zVsdsWh/no61lwRA1PdJHBXaoELe5qgNGJn9TTYg7SI2CtZ/Z1LlDXm7m9+2jYQ+pMmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781145572; c=relaxed/simple;
	bh=leDRZNtVDPP9d73vCCeklctQ8XYsvdkvPUlIE06AW54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jHWrPjdrdRpJnkhvTmvwbL0M34U73NgIEqPbC9V65qm02urLzaMT3ECgAaR5fT8TzApRCo3KNXgaq6WC6JJ3yGI5yNwg/Jd60XmeA34emrYxg/yuIsueLBp7UL0Dwq5PGdE9DBTOJ/nM8lz1CyCpimxtxCA5nXJaXj+7e2qKezs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vzl1dodp; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vzl1dodp"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8421f0e9c5bso3447819b3a.3
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 19:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781145571; x=1781750371; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zvAByViDtXG7wGWE+kqFWIG/+s+7WeIZBftsduJx00w=;
        b=Vzl1dodpEc/MBnGvgd69AFhKR6T6USbBedyR4hrqy+zTDFqr+/Ozv4s4dExrDfgJMZ
         FCwO6dzlmDhoiTm1DnbOMyckCx/3Vuw3kjD52Ko55xXnW2w2RWaVkLo4Vl7lZtPVcXRs
         BoiFKlqPjZeY3mCwbyPVr4Dpp3USZg3wDqERheT+OhpezW+JFRYFYXqpROVRVqnWzIfQ
         vYG16+u3ze2xjPB4Hx0Yrxj9+NOKhvaXxC6YvaTLqc+5xars1Zxb8Wjl/9XNgiZOpGgN
         5nBeY5KUF4hZ+TUmyNCWubiMCZKKyGd+FmIWBn+iWKKgkFFJx/rQ5FhBTD+BQm6A646s
         ok2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781145571; x=1781750371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvAByViDtXG7wGWE+kqFWIG/+s+7WeIZBftsduJx00w=;
        b=VUpizE5HJ4NSr1sc+YYhJnHS4YNYw8gvT5u3vCqgpefEShBsEbfZFujGG6h676KT9P
         5ddKYF2Wt3JQjmy3EOh3ungBnANg03l/V0UYOIIiNL2ZC6NQJbHM7rgOqDT3yX2qK3om
         vHqQvfbWUtpsWQJIpIV46AwbXZGsFBhcGL9we+5G9lY98yImeZ1iJh846mVxQa68zVP/
         fOtrqG3OHtHbxNvkH53u1Ci49QQr9p7xqN/sIerGhT3aejmKucau60RvGOurE4nOgjPb
         LNu40Dq0QAgkTlS9aB3tGujzQuU3pThAs09qzuVfBSgEpq5yLQu74ZJK+qECuS9ks7cC
         KfAA==
X-Forwarded-Encrypted: i=1; AFNElJ93u4KYSLCsxLbiSFIrwijUemtrDZ1bvFS/qLDttnXwRTJieM5uRcZ9uB/OzprQw6MbuW9g0LI7lPfZb+JoHw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywq5v2w7EadrXZoJJa8WXXlSMSyp7mpfEhLUsL1HbESNgt5eIRA
	SQhjILuA07PRQdKqyk/3pgikAYa6ZI4dtuy/cMiRszd7DdmNPJI+8yw=
X-Gm-Gg: Acq92OHlYzSrjxx5Nqz7jD7HEekYlAZRItcWtK4g+Z/xIz8BHsz6iKAifP/EZBm2KCE
	diejJ6jH6nIbcoOapJEAELQGJZWACuU4qHgTO94O49u7Y2xJQ2ZCZg2hceLlK2BXNum6GLvusFx
	7HSvrozNauQ+wzF3esfIqRD6Vp7uePa2rVO3JHEwC6AyPIx+4rM8MZQnyBJnxCLN9GAzJCVoAcm
	lor8ta0E3t4SqmiMMLx4ZO43bXuq8ypvav8Fi/pfjmDMcESgDbMS8Hl9U1t04XZc7w6AfrwHXqt
	QdhGeoxRQ7F2ApWXd0CfBNDLpKbku2SHcgYGG4q9ShbYfpvhLrK1ptxZdDenEarnuBpeZtjNdYL
	IrOGBDYacwAGQ5WCK7CiUr3I43Mc6TSgpnh9mNhEE0lkT65wVS3CdV3t3Rlz/wkWUnihNVviMJn
	DfPC8V25BaSg5hcxW5mvLx7rSDs3lg5H3S5X6Gdv5z/ioa3lvNC//1EcMa0X1SW1awjwx2QeKys
	CxDlQ==
X-Received: by 2002:a05:6a00:3e2a:b0:842:51af:b3af with SMTP id d2e1a72fcca58-843367eba81mr752476b3a.3.1781145570906;
        Wed, 10 Jun 2026 19:39:30 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-843382e60ebsm202392b3a.45.2026.06.10.19.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 19:39:29 -0700 (PDT)
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
Subject: [PATCH net-next] vsock/vmci: use sk_acceptq_is_full() helper
Date: Thu, 11 Jun 2026 02:38:30 +0000
Message-ID: <20260611023830.106259-1-rafdog35@gmail.com>
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
 net/vmw_vsock/vmci_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

