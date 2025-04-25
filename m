Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13BA232386
	for <virtualization@lists.linux.dev>; Fri, 25 Apr 2025 07:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745565121; cv=none; b=kChbI2coUHp2dZjmfcnzb4QWzuiKeCn1RWIykVkhaSgzEZdho/mSPdiXRZb0BL67OYhPdsiy54G7Dc/XRC01bh5jMleh/UeA9tMlPjziap++CdByeC3uVWYybamPTnmVqU4pVTsOEw3rO/hXR3ZfBV1MXUNyabvqzMM7OKMagag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745565121; c=relaxed/simple;
	bh=HEECyfZinc+wH1214D5sqHe2jbzMGQUAA//2Fpca0iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mf46dIaC3mMVuw/n3b+pKHd0zHibM1pDz5AwI3UOEHw2fwM14ndelCyxSqzBS+z6bWcp7SqlL0pKw5MpjWxdUCd2tnQ79dcTNY8Dy+ww7OCE1kptQnV+u+i04JaNkSkOG7NVEpd8jymu6yXvlhaoA6D6y96+rY43awhra05pKAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8k3s0Qe; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8k3s0Qe"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22401f4d35aso23437445ad.2
        for <virtualization@lists.linux.dev>; Fri, 25 Apr 2025 00:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745565117; x=1746169917; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGgNXuFLvWdU6d7kOZ4c8+NmxWqqCA2URptaw+zqZE4=;
        b=R8k3s0Qew++1loBCn8iguxH+nDuuD9jFwM0cfwMhcP12lomMiYc3rSL1MomF4wD+hC
         ywtvsGG3AZaiFadgCpmzUMDI+oV7Nb3qhAJTpyI0U9mNV2asD8zrYZfOUjJOA5rgniL1
         uKZcITRJaPT1nWsT61vtg1ot2NI1VSI0DFSylWLFMglRgiT9ZmpDd4K+OQfQp3uhkczW
         +KBXi965rwM3NDYTeEiTU6BByJu6wo25wwTwvywK/Hb6RUvfdMrnDjhZkVvIsyTBvubY
         ucFWh9SZ3xoK5DFBhlaamf8fopf3JBOzV5ENW5oRpbyY0fMXIhQACttw4HKE7PBAqi1K
         wArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745565117; x=1746169917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGgNXuFLvWdU6d7kOZ4c8+NmxWqqCA2URptaw+zqZE4=;
        b=WxloNsI8kARO4JzqUNLIf7XC3VgiQR+3WNFznGKyHuVvR1rftI/kPLte6nmGC04nYJ
         ONM96J/uPCWA2ew8H/pLGdHorQZZY/iYINqGrdIlE0JbhiKqkQurnUCSf5x7BG4ovISb
         QHyo5EozpKJ6wMhI5oBkP0pTuuQFs3a1Leh0PFwIevhMIiQcFnfeptZ0GvMzB56QRvd6
         ysS1u2Bg5Asl3wrrGHlqRMNoQSZrWbtu3SiJQNS/RWYV45CXugaUiY8zhaPEBftD/rZk
         OsJTkZXfL4u57WHp+0PQgFoQDLWTpcYQ/Lu+DkyebMU/2khkaAQf60THMlatPzqnh9nJ
         AzQA==
X-Gm-Message-State: AOJu0YyZBhZ49eezUo4/sL2w+wPhxz/DKWTcu1zu+/LzJ5KqB4Xnqctx
	zVFgLFtxsMd6NDGAEPHELgylCFdAq3AbXX7/HM49azGk3U5TcYgteHSAG6jhjv0=
X-Gm-Gg: ASbGnctFv6vQn64dnqn9R/kxvo4CHl+yBQrHs1YQw7g0iE1ApE2+2QlS+zJVUVAdf9f
	F9LquCKcuCwbVQRGL2x5T77DjsI4wTczm6CIj6NhOT7TY2/YQrVML6WXZqiKpF1rWg3J+s8VxFs
	hLEMa66/m6KxhrxBXXHJk+6ICZPLX2ADrOcKNMwZnvlM/ABioNmiv6kfmpEER4Uqoc2uoTFmiQ4
	LaWIvLeKVljskzUCXUf6M9y6zWmLMTaxX78eKjC6Jd+/Rck1w82zbn2jW/yM/0l1etEPtW9OKDU
	xnbE6rrLjHCFi//WeZaRydN46whPWe8B4cvlX94pPHvy/PQyHJjQTm1LzlpW3jOAN/s=
X-Google-Smtp-Source: AGHT+IFpuBEDWJ4Jdf5U2gn8bRZq3DJLbe8GQt+jgcamP/LZqySE7mAq8G00x6oy8xUhODZjxUMyRQ==
X-Received: by 2002:a17:903:2987:b0:223:f408:c3cf with SMTP id d9443c01a7336-22dbf5eaa52mr19859965ad.21.1745565117500;
        Fri, 25 Apr 2025 00:11:57 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:1c5b:42af:3362:3840])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22db51028basm25322425ad.196.2025.04.25.00.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 00:11:57 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v6 2/4] selftests: net: add flag to force zerocopy mode in xdp_helper
Date: Fri, 25 Apr 2025 14:10:16 +0700
Message-ID: <20250425071018.36078-3-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425071018.36078-1-minhquangbui99@gmail.com>
References: <20250425071018.36078-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds an optional -z flag to xdp_helper. When this flag is
provided, the XDP socket binding is forced to be in zerocopy mode.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 tools/testing/selftests/net/lib/xdp_helper.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xdp_helper.c b/tools/testing/selftests/net/lib/xdp_helper.c
index d5bb8ac33efa..6327863cafa6 100644
--- a/tools/testing/selftests/net/lib/xdp_helper.c
+++ b/tools/testing/selftests/net/lib/xdp_helper.c
@@ -17,6 +17,12 @@
 #define NUM_DESC (UMEM_SZ / 2048)
 
 
+static void print_usage(const char *bin)
+{
+	fprintf(stderr, "Usage: %s ifindex queue_id [-z]\n\n"
+		"where:\n\t-z: force zerocopy mode", bin);
+}
+
 /* this is a simple helper program that creates an XDP socket and does the
  * minimum necessary to get bind() to succeed.
  *
@@ -36,8 +42,8 @@ int main(int argc, char **argv)
 	int sock_fd;
 	int queue;
 
-	if (argc != 3) {
-		fprintf(stderr, "Usage: %s ifindex queue_id\n", argv[0]);
+	if (argc != 3 && argc != 4) {
+		print_usage(argv[0]);
 		return 1;
 	}
 
@@ -87,6 +93,15 @@ int main(int argc, char **argv)
 	sxdp.sxdp_queue_id = queue;
 	sxdp.sxdp_flags = 0;
 
+	if (argc > 3) {
+		if (!strcmp(argv[3], "-z")) {
+			sxdp.sxdp_flags = XDP_ZEROCOPY;
+		} else {
+			print_usage(argv[0]);
+			return 1;
+		}
+	}
+
 	if (bind(sock_fd, (struct sockaddr *)&sxdp, sizeof(sxdp)) != 0) {
 		munmap(umem_area, UMEM_SZ);
 		perror("bind failed");
-- 
2.43.0

