Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201F820FAAB
	for <virtualization@lists.linux-foundation.org>; Fri, 30 May 2025 04:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748580642; cv=none; b=iRAgn+M8R5xQR32a1q1quj5cJcGhIUpZxfhrXyAVtQYbwzsmH6Ha3yifq82YGWvkWyUKRQAgkt0JjtXo5qgtKVug+vqH6Nwbwjo9tsbM+eyAzhheF/VAgZBDeKDqeSVR3tTXKBbh8wtzYpmucxa6Azdeof3djMP4VoijMJSGZmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748580642; c=relaxed/simple;
	bh=z6KshIl6HGgt4ZleKE35r87QcaFqdHr3p/xqcA1UR5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=mZewXva4sLswZ2I1x8N/xqWqeEo5LLpfj1HniPcHIv0iEe/VulxVzvNl2Oa+M+7+AWucf+ai2jjsEN1P9qxreXn9m9LtlQLrIbcX1EQWLAWOdRNlG9PWE0ji2vtXx7WhgXBDH4H52M1fdH9qPPy+35s3J92BYcehLODMmmUHtfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=AU22b/P4; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="AU22b/P4"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AC00240183
	for <virtualization@lists.linux-foundation.org>; Fri, 30 May 2025 04:50:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VsE7pG_F7mrB for <virtualization@lists.linux-foundation.org>;
 Fri, 30 May 2025 04:50:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org F163340084
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F163340084
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=AU22b/P4
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F163340084
	for <virtualization@lists.linux-foundation.org>; Fri, 30 May 2025 04:50:39 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2353a2bc210so1343815ad.2
        for <virtualization@lists.linux-foundation.org>; Thu, 29 May 2025 21:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748580639; x=1749185439; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2NOE/sRdLPMAnoL0j8jc6LLcC7i1+AiTcrUdSGiZf/w=;
        b=AU22b/P41CDKNET0k/3i3dFtc1DHRixvZXlmaR7yJWb6rCIWERf3s5yj/DdfpAa11v
         IYJTz78ylSvoCnzAxsd2woFQ28R8xup8NrHRNRV2RXBFnf2GczZZEnKZh3CHzptb4YDI
         +B7hWNzJKDsZCgF/AiEk8az6tN1VTguiLG18O/+DYIr9VRf5nxWKgclWAJgIB/xOT70r
         nTX6Ofo4GGyYTg4ZDP5XkQtzV84NESTOfxSFPrda3hNkJljPHPp8udLQH4GDfc0I7Z+5
         olt4Uo9ECEzHZrvpBCuGnglg8Que3BTgqXa0YiRx075GRy5+nTJtp8iKm0sJtE+j1Tdi
         p6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748580639; x=1749185439;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NOE/sRdLPMAnoL0j8jc6LLcC7i1+AiTcrUdSGiZf/w=;
        b=OHAzlBxaZ2QdCtnEePnCESF1qbt1w2joeOXy0w1njWhEnlYhxEOv/epinoDJZLLjds
         H2RVrdzn9tktK8fHIZr0pBwyPvHADF67PxnQngXxfW+GHu60tlXu9VPpzZPxhpHmVo+d
         jVSsqTAQcgKz5SGXI65qyEEOHCM1wk5SQVHWjZWC+kwQi1MaD4LzyUMPP0qiBA50yTYS
         6G56Ipf/+dNrHyrZsk/854h62LOMfjlDESH5do8hetdKCK9XQqcxAEGvLW9jwQnVc0Ai
         Ht/HbUOFMMb13id+WQJvEGlCjQMnGpjDV2ySIt+RCV6iRrcyRx6GqUM9q+bTumgH9OSv
         x7AA==
X-Forwarded-Encrypted: i=1; AJvYcCXRaPLc1Mb8nqKIRK3CqsdqWEmgY3Yw9dFM6yCXyCV0Fl5XG6Mb1H5XIck3S+wwETYPRvGI80tyTxiXIbw3Gw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzgD1COCCPMfHPn+l4LH5uD4R/UojNfKnZlUl//yHfD2keFS2w0
	o83YutAawZjPeOYDrc2dLQljydDQJbGp2V02lIJeR+Br/8Rlrpnr1hwUqjvUT89fHn4=
X-Gm-Gg: ASbGncvsFWuk8t4wnTKF/lfKzgrz4yNG+M0ml+9bgHnzKBJPZF6xrt86hfkbah/DUP1
	iszmKijwg/I0GyyQVh8TVLYBwwmnjagM+aM2u3UVzCSkbgQbDhtDfeeJ9kRWc42Hw8wORCpYyY0
	BCogTwF+KcCzB4zTlySc8Zwg163mtF3OOiuW15ZqB8QIj7R/FoDnK/pJzHAOfALw6dQweI4hkZJ
	q1yOu3TCo+0SQExh5457VMiQGdWltcTrmmnjijqAcGmZquDLl0kyOtOg+nU4ORvDBLm7q+Y/gk1
	ZolJJQdHsKgyKRZbgHUuvvwZUJe7vmLjEFHUBu6X01ZP1X88RHdv
X-Google-Smtp-Source: AGHT+IEeXcvMFrg0nyBJT3UCjMm5zR9avBrulDbs9crdoWtGa6Ob/x7/c2QyfE4WnvmKLh1jLX4/8w==
X-Received: by 2002:a17:903:2f89:b0:234:eb6:a35b with SMTP id d9443c01a7336-235396e2b3amr13431015ad.44.1748580639345;
        Thu, 29 May 2025 21:50:39 -0700 (PDT)
Received: from localhost ([157.82.128.1])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23506cf9181sm20055655ad.187.2025.05.29.21.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 21:50:39 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 30 May 2025 13:50:07 +0900
Subject: [PATCH net-next v12 03/10] tun: Allow steering eBPF program to
 fall back
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-rss-v12-3-95d8b348de91@daynix.com>
References: <20250530-rss-v12-0-95d8b348de91@daynix.com>
In-Reply-To: <20250530-rss-v12-0-95d8b348de91@daynix.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

This clarifies a steering eBPF program takes precedence over the other
steering algorithms.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 Documentation/networking/tuntap.rst |  7 +++++++
 drivers/net/tun.c                   | 28 +++++++++++++++++-----------
 include/uapi/linux/if_tun.h         |  9 +++++++++
 3 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/Documentation/networking/tuntap.rst b/Documentation/networking/tuntap.rst
index 4d7087f727be..86b4ae8caa8a 100644
--- a/Documentation/networking/tuntap.rst
+++ b/Documentation/networking/tuntap.rst
@@ -206,6 +206,13 @@ enable is true we enable it, otherwise we disable it::
       return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
   }
 
+3.4 Reference
+-------------
+
+``linux/if_tun.h`` defines the interface described below:
+
+.. kernel-doc:: include/uapi/linux/if_tun.h
+
 Universal TUN/TAP device driver Frequently Asked Question
 =========================================================
 
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index d8f4d3e996a7..9133ab9ed3f5 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -476,21 +476,29 @@ static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
 	return txq;
 }
 
-static u16 tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb)
+static bool tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb,
+				  u16 *ret)
 {
 	struct tun_prog *prog;
 	u32 numqueues;
-	u16 ret = 0;
+	u32 prog_ret;
+
+	prog = rcu_dereference(tun->steering_prog);
+	if (!prog)
+		return false;
 
 	numqueues = READ_ONCE(tun->numqueues);
-	if (!numqueues)
-		return 0;
+	if (!numqueues) {
+		*ret = 0;
+		return true;
+	}
 
-	prog = rcu_dereference(tun->steering_prog);
-	if (prog)
-		ret = bpf_prog_run_clear_cb(prog->prog, skb);
+	prog_ret = bpf_prog_run_clear_cb(prog->prog, skb);
+	if (prog_ret == TUN_STEERINGEBPF_FALLBACK)
+		return false;
 
-	return ret % numqueues;
+	*ret = (u16)prog_ret % numqueues;
+	return true;
 }
 
 static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
@@ -500,9 +508,7 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
 	u16 ret;
 
 	rcu_read_lock();
-	if (rcu_dereference(tun->steering_prog))
-		ret = tun_ebpf_select_queue(tun, skb);
-	else
+	if (!tun_ebpf_select_queue(tun, skb, &ret))
 		ret = tun_automq_select_queue(tun, skb);
 	rcu_read_unlock();
 
diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 287cdc81c939..980de74724fc 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -115,4 +115,13 @@ struct tun_filter {
 	__u8   addr[][ETH_ALEN];
 };
 
+/**
+ * define TUN_STEERINGEBPF_FALLBACK - A steering eBPF return value to fall back
+ *
+ * A steering eBPF program may return this value to fall back to the steering
+ * algorithm that should have been used if the program was not set. This allows
+ * selectively overriding the steering decision.
+ */
+#define TUN_STEERINGEBPF_FALLBACK -1
+
 #endif /* _UAPI__IF_TUN_H */

-- 
2.49.0

