Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CD92356D0
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742209110; cv=none; b=GKoQkLBxkfEGMbmgScvypyUGtTg1dZyrG4CId35OVBVaU5Ln7ehx9gwg7vNizA8dU/8jqfJSQ9lmbZPjvuNJlshKNY2F/LbA92y8qh4mu/tTdBXcGx1bBykaEUkkG3pWCd7M1pOsZ+TRJiKVuB0eSZ32N0JphuvVs40lpndx7F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742209110; c=relaxed/simple;
	bh=uj6BiB0IqVm8+xs3f9Zn6aCjK6f7zlPp0hv2djTMvTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=skxJEvQbwaduT+i2x8R7j1DW6cdl/yTBUHdFOqQb0mAEv+OgeeMpAj6/eYSd9zWgjrRSNdAQ1YPggLY5vDQc8pxLNknLulljiQm4xPVYQsPg/+WMY8J5OUlxHSVFjDaxmGkfpEDAptkD8HcHZxQa0bMuKfqLO1pGc+vz16nTels=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=TZUv0Kae; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="TZUv0Kae"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0E9C60AF9
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 10:58:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WkLXhvkmvXrd for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Mar 2025 10:58:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E377D60737
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E377D60737
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=TZUv0Kae
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E377D60737
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 10:58:27 +0000 (UTC)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-224341bbc1dso75061245ad.3
        for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 03:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742209107; x=1742813907; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CFouu/EN4lEKQm+2Nyv7q163Sd7hDT7Qc+wcMAoVrxU=;
        b=TZUv0Kae3V6OpsRJtO5w10Td4zVfmZnPQ+y4uE4ECclermo3NYgQ9XIfvl8gwrx49n
         iBIl9guaEFzo2WrVEIPLy08jo4T8xLb5lRx7MYwWq7ByunsPYZC+NzddPHqaHN9q4/9j
         OtFAhhtkMS3zHEU/KHd4zG6IZ/8NWDDvIlnUtTI4sz3TEdkoLVFly0yjDyKILQaqHjxo
         Cd90oB9NRXKwkw29YjE/ebBMl0Ig3u3wkq9n4j6E569tuO0mMM3WY5d/djiVrPDEd+3R
         xtBWCOYpesHeFim2NpzayYvWR6mEFgV35XL8qy0xIkuQpu32TJQQB0q5F8Ia+m/O9pgS
         4nWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742209107; x=1742813907;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFouu/EN4lEKQm+2Nyv7q163Sd7hDT7Qc+wcMAoVrxU=;
        b=QzSx5Z7oOMccWJn6lu+kAS8BG5lHNH2LE8mm0G+ubnbxqDZgktFi62Ln16Dt49bD0S
         1AGh1G5mJIec684zPLYXK6iNQVl6aB/0TH4U+QIEL57zaeSnAns5xuH6U02heMnkhhC1
         pg1NpLne4c1u0ZXWyEQhDVgzegwr+rEygfs131FjIhuAhUsnu7Qg7dAJMOiEc9fKE+b1
         2eBIwHibOjHkPMiWU2XSfGj5XlhrAPqJo0wW7VMrTCR0aUVeBS67pT0TJmdfUbhPF4K1
         9oCiVm3zNQ7hBzpK1Cs7Mn4rgXYHZbxiREhvVepq6vmoiuTVkLEKoHC1/aYMZUSSiG/b
         lz6g==
X-Forwarded-Encrypted: i=1; AJvYcCXXdK7xKsOJsLydsN9BZ1rHG1JdpDBfp3B+ED7U43qqO1/FWl5KQl62VniiLnI0reOLkkfwybnWgTjkOtfL+w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxR32O/HbDM2B4XEwdnUFhSH2AstO2AidbeSCRdNNlB05DlLxqV
	yerd0zKVsbEq0vn8VDQJ3V1e/l7SpdZISb/XtiCeDT9i9tSoXkf+2b3fKu+Dutg=
X-Gm-Gg: ASbGncsy+vSqp3fv1Eg7KRDdm1a7KJtNRB6QvnTQMyG5cI/c/pgr8GD5jJ29KYT7O4h
	z2kXoV5jrxCQ0qwDe2iWrTLwY5Naj4C1aAppXS6TP86lMuGrbeZt1jIKSJYM/mtc/wDw4mo6LnI
	YWTtJHn3xGU8YiPZcT+NGe8s5IKSesgSm7XZkCY4nbnRvM0usS2XMsambqswXtY/oVO/+elxi6b
	wsLcqAq8ga3iR6PmfcdjIGjUt8C0uVHnoni5AGEqn8h98meSfsIMciqF2oN7D39cM4mYHuTLgBK
	zNzW+5woE97xCusNe/aGxkUHzhuSoBPuiObnIEaf53LgQign
X-Google-Smtp-Source: AGHT+IHGq79Rsv/kZfRVhSkItW1GnSGSGi4cX7skmUfl1fStmFO3ltKgY+5Iw+7Yo4D17wVag2aDMg==
X-Received: by 2002:a17:902:d542:b0:223:58ff:c722 with SMTP id d9443c01a7336-225e0a75b3fmr179867305ad.28.1742209107158;
        Mon, 17 Mar 2025 03:58:27 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c68aa906sm72547105ad.88.2025.03.17.03.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 03:58:26 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 17 Mar 2025 19:57:53 +0900
Subject: [PATCH net-next v11 03/10] tun: Allow steering eBPF program to
 fall back
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-rss-v11-3-4cacca92f31f@daynix.com>
References: <20250317-rss-v11-0-4cacca92f31f@daynix.com>
In-Reply-To: <20250317-rss-v11-0-4cacca92f31f@daynix.com>
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
2.48.1

