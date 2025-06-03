Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D56523BD0B
	for <virtualization@lists.linux.dev>; Tue,  3 Jun 2025 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748963231; cv=none; b=IjmDrgCToPYUvB/L+8cF1bAuAP15CfizQgXrmx6t21JHdccksNu1bJg6D8iz1/HIQA6EbhaTsjZCWEITO3FbTtn+/wXFi5x8lMwHhCI5YHhy5iRAfzi1bA3t0uNTezppyviCyzCI1IEfYFtH6AQCiTuNmuJcVY+D3X6/IzC8bjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748963231; c=relaxed/simple;
	bh=8V2kmbUZiu9hSlXFWJGJ4smleoQNWTcBNXYPPBlHjmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sy3Tt7tzNa8LN+fLqRB04sWQ/7P7o3IfYOirEp1Ed4Ihjn1pdtpxMxR3l3FE3CYvAPppyyOHjdY3sSV6gxJWOzejqRYvtDQIJJmZV+Ll+CC2+SkrwW09YB5rTFVf3PCPqGpQtU1dFkMRhUzE7UnHTikirbNk/dvPjPPG7XtXR4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJNOjSCO; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJNOjSCO"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-747fba9f962so951578b3a.0
        for <virtualization@lists.linux.dev>; Tue, 03 Jun 2025 08:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748963229; x=1749568029; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rHRcx0Q2kd7s5w9xmY/qLmUUkyxdFzsoRB5ggIvT+6M=;
        b=AJNOjSCOoCn8/FWFye1iP8RDb+5VHkIViSmeQKMGhmlKGBsQX9VCs5U/u1zQJRXoAR
         iAlMGN/W3+RvS6Ts/EAUnVLbwJzvgNDs12vVcRCNG1TlthEPFfgeUbkLS2FYwzeK8+XK
         PDDHR8bT29GuHjzUmWp3ouSWBTM/r/HhNOnWlO27JFIAc8NP+TZDFX2JsvoeX9lfMX4j
         nEuzFVj8tbZAiNzKQYgrkhJ1Ojh+H7pEbH/uIluzPtNKAjOO6pQs6LilixcOSZxsatoQ
         CntR/qOFPyr7bTP5QpoW8mYRifF4VJRg3buGZM4YgKsjQEMTtfFtXP7LOGnivzHQg4sC
         s6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748963229; x=1749568029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rHRcx0Q2kd7s5w9xmY/qLmUUkyxdFzsoRB5ggIvT+6M=;
        b=ZeezvObSzdFOKlzgZ1ZIVFPvbI4d9ibomPspAR725YlV7ASjD1cTaFX5/wmvjXQzL4
         WgRVUarw11Hh7G1wGU6qzBES+UjAjgrxvTu5Th+vch6GahqV8yPlZFllDujIqwpX7p2O
         IsP4rGsawb03rgYjZ/xmbUFXyqK/ur1Rew2voKHOwz1v4AgHpp26e/D+YquJnM45lVOr
         29MZ10Ja2lL49B6R7VaOYS3a4JHiFIFx6gqewTBN4nw9XRq7H9mHjSQf5mrqMtKZg4wv
         2S8gzzCLfCah/Gl94X/gXJmMT3le2DH2+0/6e1UurnJOIu3U2bVJLZdpgMV5BVZfm3/q
         vjLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXedQO/oc4RtHbG1ltQ1+/ImXJXGGFDSgTVZJbjLYfHcG/APYHwIekQvR+EV8CUaIw3T5igdlyjCk5jSwd04Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YziWYSgabXojAvLCRScKfPrO0+jpOlVdrwzB0bep6NTPbzwHb5G
	aNgYsb4LCrewbwkP8X7t+jxFrQZ2YYqt7ukjrPnMpCaFHBCHNG7GUPDh
X-Gm-Gg: ASbGncsdfKaTuPpGUzj/Rv/TbHn0i+jt4/vpbeajsRwgg8qDMMa049RxVL97pD78dCb
	EKjTamc5lDJqg1SQ7g9ah0X+pDwMT+StOjJ6dducUeyjIRiKvA72MK4tNhbMpo/RBlhjnxLpw0Z
	HQmRbMvVYw0K0/RRmR3SI7vni4yWIFMK8menxFSOAY3EbLVVMQ9GuL2LW/XyymLTRZeruy/8Tmo
	XdAZph5esSLTURhnFUREn49GirvskS2KCvgN8kZj7R+r7UII0anjz3zFThm5hsLqlxRiFvbPmi9
	BjqWUgVEJCXaxwKiKl/Siz1tWznm0tfcQzLAgJzL6TULg25DR1a1rQOulcfpCpEGJYtJKsF26mF
	VoQ==
X-Google-Smtp-Source: AGHT+IF0pZpF9yVqhFdo6KrG71N2ZNsh9D4aeXFDJnmId/+aHoYpiDUuxam3stwW5F7pvrA6H0vAzA==
X-Received: by 2002:a05:6a00:194a:b0:746:2ae9:fc49 with SMTP id d2e1a72fcca58-747fe29e165mr3581505b3a.9.1748963229373;
        Tue, 03 Jun 2025 08:07:09 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:c672:ef11:a97b:5717])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-747afeab0d0sm9461782b3a.44.2025.06.03.08.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 08:07:08 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] virtio-net: drop the multi-buffer XDP packet in zerocopy
Date: Tue,  3 Jun 2025 22:06:13 +0700
Message-ID: <20250603150613.83802-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In virtio-net, we have not yet supported multi-buffer XDP packet in
zerocopy mode when there is a binding XDP program. However, in that
case, when receiving multi-buffer XDP packet, we skip the XDP program
and return XDP_PASS. As a result, the packet is passed to normal network
stack which is an incorrect behavior. This commit instead returns
XDP_DROP in that case.

Fixes: 99c861b44eb1 ("virtio_net: xsk: rx: support recv merge mode")
Cc: stable@vger.kernel.org
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e53ba600605a..4c35324d6e5b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1309,9 +1309,14 @@ static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct
 	ret = XDP_PASS;
 	rcu_read_lock();
 	prog = rcu_dereference(rq->xdp_prog);
-	/* TODO: support multi buffer. */
-	if (prog && num_buf == 1)
-		ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats);
+	if (prog) {
+		/* TODO: support multi buffer. */
+		if (num_buf == 1)
+			ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit,
+						  stats);
+		else
+			ret = XDP_DROP;
+	}
 	rcu_read_unlock();
 
 	switch (ret) {
-- 
2.43.0

