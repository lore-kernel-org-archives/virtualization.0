Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B58A175A5
	for <virtualization@lists.linux.dev>; Tue,  5 Aug 2025 06:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754374853; cv=none; b=H3L7JH9YtrzeCFAua/F5deUTRQhXFGUBAySwCOmdQ6Y13VxPtKm/dxGXj6B6LRswQb1WiXkmxrvBZagzeSv6lEiWE5rwDwntSLKlIDQyLHIMBLWoLL4d5A/auP9seJHB6WNNT5uyEPaakPbxDru3OG632M/EieCe4LKO6yWI/OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754374853; c=relaxed/simple;
	bh=HU3EoErcw718HgQs6DMndFnBksuEYx4Ps3O8g3pWdi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cae26djVLiTHI1y6SSpKu+ehuocwyN1hW2M3RgYdfyoK0JmbnGRyuNtWZjNErgNo9+4wZ1skbjs6ZDwJm1JS4qVkL6843BM9vfzi44NstVzzOtcOajCGYqn80/18AxCTA3wNWtLPAdSBCokbu3TcuIKNEq/uxsfbtwb/eLg1m0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwS7gWnR; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwS7gWnR"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-b422b31b1c0so3095474a12.0
        for <virtualization@lists.linux.dev>; Mon, 04 Aug 2025 23:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754374852; x=1754979652; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bxXdvCPPZKEryeBHh/ilhPWl4SN2qoBiCBLYJe9cq58=;
        b=TwS7gWnRlK6iLRSd1jrKeFYMSAKKWCKhZ8ZOu2JOYK0nK5nglapKnMUEsnY/hqMau5
         i4v3R1OpDcSTKHd3Ol6tb/rnQ4G3SW9711MWerS7w+s2pjHQ1jKK+GV3BASAc3JYBCGL
         LFsswMjrFiWw1RJkwVEIDQQ6t1UzbeBd3hCmLgWOC4pFKUPooOp10XSExVfRoBfDlP+Q
         MpFvy6nl1j6UE6yT94vMva/fisWt56qSiGAmOnQqTyTBQoq7l6Ojozs5OUcsbqvT7jGL
         77hyI59JD1FeDJyz9LwdBPGnjfgbWfrV4KXTLx+FhqgAGO2+iFQ5p+XgApPVS0uItvdQ
         dPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754374852; x=1754979652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bxXdvCPPZKEryeBHh/ilhPWl4SN2qoBiCBLYJe9cq58=;
        b=oSYRTszjpMonQYgU2w5Lkx28GxPbI/EP1X8MOQPu8DxloNk59YGF7hg+t3FwWZh+hl
         KRkIVv704wgHNab1sQ7ZpxIDAWGnQ5z28sayaqobZDdEsY45A9E8FLQYF1FuhO4v+MWH
         JycPFxPHgzey8Q5IyBhgqakrtkS2EVqKENhFD8YDiRdIz1Zdzr7GH/uFqBZsPYyw7cgK
         xtVCO0a8sFrQvzfT22DKBCbZTD7OjFtP/t1dV3SWnlASzyuqBezSss4H1j29tNdA4cKI
         9RxDDwnndzJ4fUrk6Rn2N/UQpRpg+Jh8Me5xO2XVcQ8BIXKrBOttRgzrrXltPfYQspr5
         mB/w==
X-Forwarded-Encrypted: i=1; AJvYcCUHQ0SU7trA6SInIhERKzMmzNCUX0fewaJZ/XXFDPMm+s6Ms00Iq8NBzN0hhOWoj7yyUvPpmMlYHAIihx1sUw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqiOl6WT5D/YhMxoyfhUJQIcI8HADPd6wqv/whu62tBrVXHhEJ
	s6rQpjxmyNkB/oAQJpIL+m3f7t7T9W3paasheSemUU/sZXDSjJ2pTect
X-Gm-Gg: ASbGncsrihyw0c+yHKGYLnw7ksoXbF2e5N8Smc3oobetAyXR1fKPUlc3hAGbYokCX4z
	74MYCzr1sq8bXkt1rXSmeX1yUG7ixlWUJOssqqFqJzCBU9VpE67RlKZYxqhto0tm22EDYfnScYI
	F9IXwAnR5dNXLR+GTbCCx/U2KWcLRp67rGQskpTZ3r/jlNYly+x42QgM/9o5esn/omIaKBTapuy
	G+hhVGXJp7SbGtDNVFi+jI0OgpiQPRM+7PRtFnKs1wMq6kw+UDXitt5q1SiBRXWCBn1wDWI47NK
	wQODEURrm4CpwP2Hu0md0zvmMgFGkR4QAPpUZ87Y6/K0F1AqhQzCn1R/JD2IiYUO0BDcm6JWJln
	9Rh7bBcQTLq0qbdBkrQbFjMMs6uedLkHqrlvYR2fIr+QFOCECcaLGmOrkyZj/
X-Google-Smtp-Source: AGHT+IE6My9ExfIadYycYh55LtSyfalv/17oohhFtIWDUvu7/IXwtZ4gsI1N0BiWTm7Fcv5PWkWCUA==
X-Received: by 2002:a17:90b:4a11:b0:321:59e7:c5c5 with SMTP id 98e67ed59e1d1-32159e7c72fmr955459a91.27.1754374851535;
        Mon, 04 Aug 2025 23:20:51 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207eca6e9asm13095030a91.18.2025.08.04.23.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 23:20:51 -0700 (PDT)
From: bsdhenrymartin@gmail.com
X-Google-Original-From: tcs_kernel@tencent.com
To: huntazhang@tencent.com,
	jitxie@tencent.com,
	landonsun@tencent.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	sgarzare@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	bsdhenrymartin@gmail.com,
	Henry Martin <bsdhenryma@tencent.com>,
	TCS Robot <tcs_robot@tencent.com>
Subject: [PATCH v1] VSOCK: fix Out-of-Bounds Read in vmci_transport_dgram_dequeue()
Date: Tue,  5 Aug 2025 14:20:41 +0800
Message-ID: <20250805062041.1804857-1-tcs_kernel@tencent.com>
X-Mailer: git-send-email 2.41.3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Henry Martin <bsdhenryma@tencent.com>

vmci_transport_dgram_dequeue lack of buffer length validation before
accessing `vmci_datagram` header.

Trigger Path:
1. Attacker sends a datagram with length < sizeof(struct
   vmci_datagram).
2. `skb_recv_datagram()` returns the malformed sk_buff (skb->len <
   sizeof(struct vmci_datagram)).
3. Code casts skb->data to struct vmci_datagram *dg without verifying
   skb->len.
4. Accessing `dg->payload_size` (Line: `payload_len =
   dg->payload_size;`) reads out-of-bounds memory.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Reported-by: TCS Robot <tcs_robot@tencent.com>
Signed-off-by: Henry Martin <bsdhenryma@tencent.com>
---
 net/vmw_vsock/vmci_transport.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 7eccd6708d66..0be605e19b2e 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1749,6 +1749,11 @@ static int vmci_transport_dgram_dequeue(struct vsock_sock *vsk,
 	if (!skb)
 		return err;
 
+	if (skb->len < sizeof(struct vmci_datagram)) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	dg = (struct vmci_datagram *)skb->data;
 	if (!dg)
 		/* err is 0, meaning we read zero bytes. */
-- 
2.41.3

