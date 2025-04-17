Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A98721C9EE
	for <virtualization@lists.linux.dev>; Thu, 17 Apr 2025 07:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744874981; cv=none; b=FxOWXBNmmhvyuX7W0zeYQzSxbBK/Z6ZF0wgU4NC882mbWgCqINKcjxMAEj1qMLA6clkN8DWjeCM/Pc1vPt5mVG1D7Sm1xFMrsv0hxCcPRN6fC3bmhnTKEZ6eUcXFCrpjW7E7k9Bw6krNIqbXlsCEhV77I//BOjRN6Lq6uNKED1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744874981; c=relaxed/simple;
	bh=NzBtddZRCsg1/4g3wwT54tpCt+iF1Q/Oq+nE2yGOUck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNfMbMcYd0jzE2uMVrtE8K14k3OLrVgzvIGOcn0xATAYT+AIFjeqICHPpuavwYxNSfrbKYelC2h+dqkt/QeQS7l6VUHjejqMzB6wtAHU7PejVUg+zTrJb/KueU0kSsROSg1oo+qzCi67dUyAdY+SWggQiHBAmT9kJ65YTBjNqBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnHSMCZA; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnHSMCZA"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7370a2d1981so321386b3a.2
        for <virtualization@lists.linux.dev>; Thu, 17 Apr 2025 00:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744874979; x=1745479779; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wxx88K9tSumEw+2ZtRWFe/vr19Ozn+M+DEZTmr3En7Y=;
        b=FnHSMCZAy1d0x4gxYSUKLY8cgMRSobefW67AGD7yTUdMQ0CJE5IIocXGPO3yBDd/tZ
         cUeihI3rlCi+yOTGCIK8eGFpRZ90Hj/fsHk/dmncKy7HKqmUs1MD22QuGAEA6yWmW90F
         g+1EKhLRlbyEnMkqC3smiFmCO1wXWBYPSpCSc21wxJV9WyMjKrO0GVZPJlmvDenZPWR+
         1hC01zXd6UC5R3U32yWjSY3dvBq54xUWvHZ9MquhuOGieSdoWbcbw0flKexZ2zjcQwUq
         6uvbLfeFYsgeCPZrbaWWa8VUQHaKoWf6fuoz77a+czHI14twHFw/N4OJyv+EzS2gi3pH
         /Oqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744874979; x=1745479779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wxx88K9tSumEw+2ZtRWFe/vr19Ozn+M+DEZTmr3En7Y=;
        b=sj7SP8+l2qaQKosLZ7hhLcVqITEjdRCb0NCzhP5zWUq510pmEYgGXhUO0EgFsl5rFB
         evcyyN6kea/UsVZz1oBbIxm6oYXxeTAlFv1pY67f7QU00I644uRzXGD7UvuumZIiqfzw
         V2DXzK/qfJjYYboTNZdoIa0eaRWaOlZy0ZPtgawBrWRUG6FQ+TwbvOJtddx0iXgGnqcg
         XX9o9ruKAaS5bklHFsWwadrIOr+xZMo+gv+CFa2sY7RPyGwE2MbRII6cb9O6Q/xRC4od
         SvxH2W2E1Ge3hjXsi1yg5PFeRkPpga7WoFOL51l/29ThdqLD52pcPtjItudZNQgNbj73
         T7pw==
X-Gm-Message-State: AOJu0YzyVBBvEHDGegALMlY+VhBNW5yEzyyoTDJ8KW1x4VTQeWCsu8BZ
	qZ6PyMyBax0eWmhYsBZ3fpqiB53vfKklOg5N6GjbB0RdtzQPsez24rmOk+RM
X-Gm-Gg: ASbGncs3pVXJrm1+wHmjXMaA6z5K5aqipluc/cAphqSmToEhIqiSSYGKmqjV5c+Th8+
	CWRUyEvdJjssAl0xipAtAYjgFQo4Z/OPNDH0PHW/bN6SvGfrvbW2bwSmF2SPdI34HIC/+sn3aij
	XEW5Jq2btEG+/wadOTBhzEeB0x6va4HQsEWhF7mXwWSTbZdbNnrJ3hNqByULzTCH0F65ALUtLau
	WcjkO6crEl1x1qagNUs4BYuLFak2T/yeOEmCRjnYnJGyGrEB671fYE74oeU0Gw/AtTxnb15ZXQR
	ZMK+Iu39jdOqXfV1KGBGtJBEcY6vdtrbCnoaBKsO2NJR22iS45Gpljme
X-Google-Smtp-Source: AGHT+IF/swlYlHVVTdpnx/l1Jc8S2a9LeAy6m92Hd3dKyvQqvGjdPqWMZCjUUCXypFPFgGvgke5VPw==
X-Received: by 2002:a05:6a00:3e27:b0:736:2ff4:f255 with SMTP id d2e1a72fcca58-73c267c183cmr6529845b3a.15.1744874978576;
        Thu, 17 Apr 2025 00:29:38 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:ab45:ee9c:5719:f829])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73bd22f0f3fsm11625344b3a.115.2025.04.17.00.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 00:29:38 -0700 (PDT)
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
Subject: [PATCH v4 3/4] selftests: net: add flag to force zerocopy mode in xdp_helper
Date: Thu, 17 Apr 2025 14:28:05 +0700
Message-ID: <20250417072806.18660-4-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417072806.18660-1-minhquangbui99@gmail.com>
References: <20250417072806.18660-1-minhquangbui99@gmail.com>
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
 tools/testing/selftests/net/lib/xdp_helper.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xdp_helper.c b/tools/testing/selftests/net/lib/xdp_helper.c
index aeed25914104..6afd77bfbe8b 100644
--- a/tools/testing/selftests/net/lib/xdp_helper.c
+++ b/tools/testing/selftests/net/lib/xdp_helper.c
@@ -81,8 +81,9 @@ int main(int argc, char **argv)
 	int sock_fd;
 	int queue;
 
-	if (argc != 3) {
-		fprintf(stderr, "Usage: %s ifindex queue_id\n", argv[0]);
+	if (argc != 3 && argc != 4) {
+		fprintf(stderr, "Usage: %s ifindex queue_id [-z]\n\n"
+			"where:\n\t-z: force zerocopy mode", argv[0]);
 		return 1;
 	}
 
@@ -132,6 +133,14 @@ int main(int argc, char **argv)
 	sxdp.sxdp_queue_id = queue;
 	sxdp.sxdp_flags = 0;
 
+	if (argc == 4 && strcmp(argv[3], "-z")) {
+		fprintf(stderr, "Usage: %s ifindex queue_id [-z]\n\n"
+			"where:\n\t-z: force zerocopy mode\n", argv[0]);
+		return 1;
+	} else if (argc == 4) {
+		sxdp.sxdp_flags = XDP_ZEROCOPY;
+	}
+
 	if (bind(sock_fd, (struct sockaddr *)&sxdp, sizeof(sxdp)) != 0) {
 		munmap(umem_area, UMEM_SZ);
 		perror("bind failed");
-- 
2.43.0

