Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8324D35F19A
	for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827297; cv=none; b=ucqUl/bRv9aNlbavm7vSOV8Byx+DhzKf1uvQwtr/fefnd3XOfdZHFL1wtHQ/DJXfMFAR0kI+ByMdH3t8BwtVoeAIwjsaYZdYNzBHaSCIiOjbvdpsE/QJpyOxfnbYgGuM/XV4rwAG3edVH8AwIIeOL9xhSxMWinm7GRyb2YoNgsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827297; c=relaxed/simple;
	bh=k+4nMpcoQz97bn369q+zy/rYAZg95mHwCblqq+PQHkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDaa2RiDBzkNpmAjPno1ZN7PaZq5fa2tJ9BU22ae8GANiPLJkmBFNHzahxFnobjzZkbpzMkaCReJgFe8zay+RmdeAmTPDBz0T3JyKBivMa0f2ChVM6VuWb1d7QkW+uqcGKwoooZcNjgVOJ5KSjY2XwmXT3ZnSHEOmoZAhqmAWSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYBZiFC2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYBZiFC2"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ce98cb8165so8645695ad.1
        for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 10:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784827296; x=1785432096; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LJeMWpwJDiKmOBxcOAr9yxPeFdYnA9I6db3ePnFBGMA=;
        b=VYBZiFC20+RzyULV6qSiqQaMerbH0ERcgBg5GZ2OSdj/bBL7RrXeTF9sPlOndXisj4
         rWJv5OpIKwi7+WV73QrdUM6oAM2A1jsKsBNFzN4j6l4ovmuPWYJ0zTDFAyvVTQCuAEs4
         hz6474gy0/cxwp5+/5fwOgKPsTHblAsp2h7kyBK/3qLqoCIoHVGPSs7mJEpzBFRWMBgY
         a1sHi6ITNwwl7M6icOtqxN+dr6efXAUlpbao8tLDw2FlJWz7o+a/mQUiwzK4voz5YmRf
         J9bECGxsgk0picUL6B5yns9PyAoDj1zooPEkAEnAPZKE6sQtnEd1q5IpNWuHz1UmLExK
         bOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784827296; x=1785432096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LJeMWpwJDiKmOBxcOAr9yxPeFdYnA9I6db3ePnFBGMA=;
        b=ESJrnnCoJpvMXtZkYpyVFmKYEiubbWOwnk8OXhPeOcZB3ls8ikRmgt2F7rngyQj2CN
         DpH9GOQEDdQWbf+AmY1uDkc+qWwGbDSY0SDqTHs+6Qhzp4uw7Uo1XwjAeJzXRgPvPgKY
         pCZ9U782muTj1qrRZjT4//8mOIbnzAVYjitiRqGo/VNTV16oSnmvnlpF8nKNfbYrHPjU
         mMaoKubZjce23zCdDPg4V+NodX8TGqUbR8F8PFG7R5VKA92yIUy3ny90U3y8feuT17cX
         jSbELt/SwjiFTqwWiDz1WqvVXV6Td+t2js41oee7CzUE7xFqtyNYD0r7OUfzX4cTuNX4
         DRxQ==
X-Gm-Message-State: AOJu0YxCFVqRSgElWfbb8IS0FoBCyIv0bNjTn+b5f0MMSbzH+swNsYx8
	ykudsIaUxslyzgymYqhcx3lPRTyUmMFdjYZC/OxFMtAH5azUeN1guBa+gytNoFi5L6o=
X-Gm-Gg: AR+sD10VVP2y3XUi6DGPdgWLU3wZtx8g4LBSjs9hOWPnLs51878BTo0JZ7YI4hSxWcT
	xBUMCGMBNAdwaSmcCi/PbDG5QTodOv5fQIHamwvBmwH9Hcl8El2aY2ImB6Pxm0ihXIe3V8nOMCY
	vW3lwO3RHJA1zHhUVNg8qIEArYZ/ldx2v6275UZj95EcRZLI3dKfJVX/bsn0j/DOoHYslaeha0B
	Sn5D4HiemVJM/EpERKyEjjpqwvGr2ozHLJ1pV0vM3Q4EVnBouBWvtd2y6v5/ZIlebfxvrQPkN1G
	DhJ66WS5fGAFn08caJxi9zQYfJ5j+v62z2IWUyZQynCFWZ/sfCs6urMDVGb9wT9xQ708HJvk2v+
	Pw4woZ2MaKs9mGfFFKpidghYpvSwMCxAmp/2ESi1Ib/IdWRIWo5s02UDQesER9RuMSbeB1LD8Xx
	EhsyMe/W0wANunCG8mA1A=
X-Received: by 2002:a17:902:c407:b0:2cb:402:70cc with SMTP id d9443c01a7336-2cfa95867b4mr41040635ad.28.1784827295640;
        Thu, 23 Jul 2026 10:21:35 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147df09a9dsm20967373eec.19.2026.07.23.10.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:21:35 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	dtor@vmware.com,
	georgezhang@vmware.com,
	acking@vmware.com,
	vega@nebusec.ai,
	zihanx@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH net 1/1] vsock: clear stale sk_err before listen()
Date: Fri, 24 Jul 2026 01:21:14 +0800
Message-ID: <dfc66494f95ad847e58409a9fc4bcbb7b0d12766.1784649300.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784649300.git.zihanx@nebusec.ai>
References: <cover.1784649300.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <zihanx@nebusec.ai>

A failed loopback connect() can leave sk_err set on a reusable
AF_VSOCK socket. If userspace then calls listen() on the same socket,
the stale error remains attached to the listener. When a later child
reaches vsock_accept(), the accept path sees listener->sk_err,
rejects the child, and drops only the transient accept reference.

On virtio-based loopback this can leave the rejected child orphaned in
the vsock tables, so repeated iterations leak children and can
ultimately drive the guest into OOM.

Clear sk_err when a socket is transitioned into TCP_LISTEN so an
earlier failed connect() does not poison a new listening socket.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 net/vmw_vsock/af_vsock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index a06f708f3..3482ba594 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1729,6 +1729,10 @@ static int vsock_listen(struct socket *sock, int backlog)
 		goto out;
 	}
 
+	/* sk_err might have been set as a result of an earlier
+	 * (failed) connect attempt.
+	 */
+	sk->sk_err = 0;
 	sk->sk_max_ack_backlog = backlog;
 	sk->sk_state = TCP_LISTEN;
 
-- 
2.43.0
