Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971EA4E36E8
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791889122; cv=none; b=qYs8PPWxzIlaylYkB1Iw1Pfz9sxezxBLqy8NHpiKIL3DnIXLo9zFtfhR1XvCN/szxPDqB8woTcs86TFrxTrDAHIIt3LZL/95d4sizLW4DgLmUjIEZM+CxgBAZyGesBs9Vae6vnSNAGWcbJ9eK6JFWwDvWtE9BdMG2vWWzfxzNRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791889122; c=relaxed/simple;
	bh=7ONX4vDOeMj5oyXc0wpCu79X47WQjrqzwSNypYSUYbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WtbIxBRQp9F/j328Cy4OQ9TUmY8vhK7VFIXtpJLSj90ZyO/0V/J8NyhEhXmNJvyLWnKX80/IxrqAxWfK7yhSgdrFU4MLlfSR6LnpdM967LTDuacg8s9MVP/sfPCBf83TJJUuk3jIO3JVt4R6WgyqnP62DUggDqfRblTh90Fj10k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZELKi8+s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZELKi8+s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791889115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IntiDFOBDv3N4E6ikCGJ+h2ZJ02HJSndIefAXObsa/U=;
	b=ZELKi8+s+pSqDekhNRe1eN3Ou0yc0m/LA1rkbPiVLhOpmAWcX89bdegOYfsx5YT8eX/pQn
	9Usy5ekOlA1p2eN73ZHjiSCOVZ0ct2ccyRR4QfXPWJAoon45YwrSIrB7NSNH8x5Ozxr8ol
	b5OkFgHTbsXBvnwAbzuiuuuZTP4WN2o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-awMZhSGzOjWynHRshqkRpw-1; Tue, 13 Oct 2026 10:58:34 +0000
X-MC-Unique: awMZhSGzOjWynHRshqkRpw-1
X-Mimecast-MFC-AGG-ID: awMZhSGzOjWynHRshqkRpw_1791889113
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a1612c4b80so29414795e9.0
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 03:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791889113; x=1792493913;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IntiDFOBDv3N4E6ikCGJ+h2ZJ02HJSndIefAXObsa/U=;
        b=gt3L6BFtxX7XHvMXQTUYwcd0g2LPL88UCQv6v3OXEJZ4C5APedkqHJVvnuvJYwB5aY
         1EuF/KHnd7VztwVNvK8I4Zlr4v3Sv38+zHnQnHWQalyB9psu+7rL8ZMXr+/WTKLv6LIZ
         DmiXI4sQ2TRGir6Yyip2T4MTcu2MAHmDoiKro1DSMA97wq1iqPie4WORLXJIqnf+Rczh
         +tzy/Fk0n8iFvuqYSoNRQMjajd/etE1TeghbQk7M2O4Utwk2kBDcKrhPFjXgrRj2pVLB
         qlZzK4TvvuY3eWGFYp0CZkIufdCf6lJK1nuCn70KcevOgJQ3QSDbIX//1Nbs7sK61gAH
         Rxfw==
X-Forwarded-Encrypted: i=1; AKwUvBx4xQ7PmQO1xGdKPbHFFPuYtleOOAqe8fG9D77S8yiv4SXyhD79BYLnNUMIl6QJWJzV5fqcc4wmQAR7gxFGZA==@lists.linux.dev
X-Gm-Message-State: AFq9FYIFcpC3X+a5qeB2w2j+XwRHvf2I3uTFjWEEiJXqxRTYvM38vVPD
	r31aFjc7sYLQHBpKUvxyPesGfuMK2sqDdGq06rDzjJzoAwcLupjMydXjQEEjb2WhxKJ5s7PF5Ax
	FVx1DwwL3/O9q8RQDwlofVSjss4GWJIcRLyrkr+48EfN4aI54Pm6Fm2Ft3pAR6g8vvZb4XrZDRQ
	7r
X-Gm-Gg: AYBFou0uNS8+6JrxSGBQqr0tUSCNqyoR+AcaQAWT+gPUrOFqI8qS7GXUKhcNHmH1U04
	UiN6UWvwPOMKhcblayXJAjug9D7jrpofjq9U4LGqZ7n5rwT1AFc9ROXr//S+UNLgYVM3FAjRGJV
	Pm6Yrhn3Gbp451sOe30PHt0MxLyyFX4fKfXB/c+Qg+OjyUhU0eOEQGA2cCDPEpcqYes+kZPTkTI
	oz3/CJkO1nI1T+QGtxsbiGhw0eHBZA+0z18siDZXOP/NANMeztt4M0+vXuejvBtKlQffpsbYKvO
	X0OkutVRIXjJfQseGgq3ox+tv6aU2tw+Csr1JX0fbV5rD81ErCab8mdrF/6O1TtQJnzGVw==
X-Received: by 2002:a05:600c:4e91:b0:4a1:7ec7:a479 with SMTP id 5b1f17b1804b1-4a18e4f56bcmr247248965e9.33.1791889112579;
        Tue, 13 Oct 2026 03:58:32 -0700 (PDT)
X-Received: by 2002:a05:600c:4e91:b0:4a1:7ec7:a479 with SMTP id 5b1f17b1804b1-4a18e4f56bcmr247248425e9.33.1791889111969;
        Tue, 13 Oct 2026 03:58:31 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf3e044sm344208705e9.14.2026.10.13.03.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:58:30 -0700 (PDT)
Date: Tue, 13 Oct 2026 06:58:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH net-next 1/4] net: add ip4_parse()
Message-ID: <bfd6257f8fc8a5c6cd876b8ebc498b8a4ee0be8e.1791887415.git.mst@redhat.com>
References: <cover.1791887415.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1791887415.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EwoCTqT1C-0sKwrmSYfD5C7WVKvcWEouXIPZ8q_8RNU_1791889113
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Multiple places in the net stack open-code the same minimal IPv4 header
validation: pull the fixed header, check version 4 and IHL >= 5 (where 5
is the fixed header size in 32-bit units) - and locate the transport
header at IHL * 4 past the network header.

Add a helper for doing that: it returns the validated header and
the transport header offset, or NULL if truncated or malformed.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: LLM
---
 include/linux/ip.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/ip.h b/include/linux/ip.h
index d11c25f5030a0..98012f6d0efb5 100644
--- a/include/linux/ip.h
+++ b/include/linux/ip.h
@@ -56,4 +56,28 @@ static inline void iph_set_totlen(struct iphdr *iph, unsigned int len)
 {
 	iph->tot_len = len <= IP_MAX_MTU ? htons(len) : 0;
 }
+
+/*
+ * Pull and minimally validate the IPv4 header at @nhoff.
+ * Returns the header and stores the transport header offset in
+ * @thoff, or NULL if truncated or malformed.  Only the fixed header
+ * is guaranteed linear; callers that need the options or the
+ * transport header must pull further.
+ */
+static inline struct iphdr *ip4_parse(struct sk_buff *skb,
+				      unsigned int nhoff,
+				      unsigned int *thoff)
+{
+	struct iphdr *iph;
+
+	if (!pskb_may_pull(skb, nhoff + sizeof(struct iphdr)))
+		return NULL;
+
+	iph = (struct iphdr *)(skb->data + nhoff);
+	if (iph->version != 4 || iph->ihl < sizeof(struct iphdr) / sizeof(u32))
+		return NULL;
+
+	*thoff = nhoff + iph->ihl * sizeof(u32);
+	return iph;
+}
 #endif	/* _LINUX_IP_H */
-- 
MST

