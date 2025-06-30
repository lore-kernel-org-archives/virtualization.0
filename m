Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D82B28D8F7
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 14:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751294577; cv=none; b=WTI5aHTna377OVlG3p/gc1+vccYU2VUw7SyMTtMAciK/CruGsmwwVtJYXM3vCBe44y52XLN1flQ9upylLJpx4IOdZdQqXPgDpk0jiMT8FEYAXfkIQy5ZOzSmsWiv54mTS9CTZqLYl0z3eEhLI9SYRNhFcaiMc5Z3w6U6zinL7/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751294577; c=relaxed/simple;
	bh=BSZ5vT3FSMrvM5IrsoJDnsX7sNGVr+Y34WTBiYQdwUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMCh9K9/oAHz34wf3/CVvGmT0ktzi+tAbj8vc6DDoqBiTIF3awf5+yyggEJPe5sYg+I3DQcOMojxk2Uxb4rV3CrCmMxmDq/SAYAqmzs+phSfxMkAttmPE3wAeHGZrF7gVSYuIkS1cQa0LU8FDbagRsSWeQQEdPyqani1D+tj0cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMdTbNeG; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMdTbNeG"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b1fd59851baso1757101a12.0
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 07:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751294575; x=1751899375; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLmL/hbSV60WQ5txcK/zp8yoe+ubCK5iYtglAmsrLSE=;
        b=HMdTbNeGg1v3RW4Rt8GmSl6qT9+YxkhzjNwTf/jCe60B/ZnWfFtiqNE8OLsOIXnmN/
         GsvNVl4WVrIMV3uoSsku1bxZSXjt2xZ2U1mu9MpWvgt6W4fakQ8/F43QqVEdRgi1veJD
         xTc4lzCqPwFi2v5dJK7ugW/AG4AlL3yCayNsumV0VcxrOMLBjoDvKbtNraaIqpKcL/2E
         cc/8GqEGY7Bnhcx44ZFxDoCgX64vfyyxMFYhhC+OnGBwRFm9K1Tnh5AzSajg9BEdqV+f
         sIFJlaKFRk1efmBTFQ2jlcMzFgQvE9Z6Rto4wbQA05DooGgAKc/QYREUA5oVFI27qRvy
         vofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751294575; x=1751899375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLmL/hbSV60WQ5txcK/zp8yoe+ubCK5iYtglAmsrLSE=;
        b=mT3nMsp13xtvUdTOMx83LaD2JpEGZPGC2Zua1Y/7CWBS7SqTgAhc6TYL4aRbtf4xGj
         zTroGLXcmAJJuh6lB+Ie4ApqTPin/BSbqfRUvcj31OpS2rWPtARzfsq5009duGqV2p+b
         o+TrKQKmuCxcWsgpEOJlCkR486CqFDEI/Vm/o9+Ds2MLqvCYthqiMm5ePjeOnkIWMl+b
         rvH6Ym0nmDVONn7fYmNvovvSFkpH2M/FdfRcYQe0V/iTtBNKm4wMcCU6CL41QAJDLHV2
         ITEAvuWE0kjNizf0n/LE9qEXIiZhLHXozAp6SnsIKJej+6SZ4ZjFtSfYGJf0I3cpq9HA
         K5Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXc1ktYxkB4sDeNB6whIkZU9OXDlecMg/zc6woxyB6Rbg0aPBpE5RYlHri1cmLQf8E4KBhzFLhANkl2WYnHkA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzeVDsqHBKi1YrIuJgKAazA0ME6C8gzDcD8VNDoEfoEt78FuvYr
	bN6xcmthEzV/L5sgdmY1/rUe+7g3HfQ7uEH9Gg1GZaO8EsyCA09Dycg8
X-Gm-Gg: ASbGncshL3wp6t7RhpRQjifUpZtHKSvOv7LP9rP4F4qmHNnZg3rXhcgV6huDb4UtWFq
	xAHlBsT1kF5vbVMn6o7LRgsNzcS4ZGgyO/6ddzvHFZVr3aDSbfLAUX5A2t1CRisKJul0/xRVQXG
	kvNAyHD3XU/9zVITZvmVZqsu3MS3pL+r2FwkUdFMu9bBOxOIhHEkrq6PlnLujWCXdsuKEvW2iBG
	k/+qKq8ZEgV5zaiVITWrJGboIveHOBy7S9Sd18DOlYwsKWERGDmF+bjhR8sN75f+drYlhY0EjXv
	9yIjhO2DwS96nubO2PnYqaRseV76aLdyHjYr09LnBVNTGjOwvc+GV+tOLpKNwm7PaYQEEilW2oS
	q
X-Google-Smtp-Source: AGHT+IFYuZr8i/s3T0h77aKO3ys5BfKYJLS5aKf0P+CB6IP+gtk0942n8ugs4IGHLFscQ/B6DDNpGw==
X-Received: by 2002:a17:90b:3b82:b0:315:c77b:37d6 with SMTP id 98e67ed59e1d1-318c92ef8e1mr17269051a91.23.1751294575415;
        Mon, 30 Jun 2025 07:42:55 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:2f51:de71:60e:eca9])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-318c13a270csm9170017a91.16.2025.06.30.07.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:42:55 -0700 (PDT)
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
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net v2 2/3] virtio-net: remove redundant truesize check with PAGE_SIZE
Date: Mon, 30 Jun 2025 21:42:11 +0700
Message-ID: <20250630144212.48471-3-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630144212.48471-1-minhquangbui99@gmail.com>
References: <20250630144212.48471-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The truesize is guaranteed not to exceed PAGE_SIZE in
get_mergeable_buf_len(). It is saved in mergeable context, which is not
changeable by the host side, so the check in receive path is quite
redundant.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 31661bcb3932..535a4534c27f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2157,9 +2157,9 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 {
 	struct virtio_net_hdr_mrg_rxbuf *hdr = buf;
 	unsigned int headroom, tailroom, room;
-	unsigned int truesize, cur_frag_size;
 	struct skb_shared_info *shinfo;
 	unsigned int xdp_frags_truesz = 0;
+	unsigned int truesize;
 	struct page *page;
 	skb_frag_t *frag;
 	int offset;
@@ -2207,9 +2207,8 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 		tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
 		room = SKB_DATA_ALIGN(headroom + tailroom);
 
-		cur_frag_size = truesize;
-		xdp_frags_truesz += cur_frag_size;
-		if (unlikely(len > truesize - room || cur_frag_size > PAGE_SIZE)) {
+		xdp_frags_truesz += truesize;
+		if (unlikely(len > truesize - room)) {
 			put_page(page);
 			pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
 				 dev->name, len, (unsigned long)(truesize - room));
-- 
2.43.0

