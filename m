Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C603839A1
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 23:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781134185; cv=none; b=iHVfFjEeHZ68Q7DeYOZAni5VlKeH+ONYvUhE5WEvco31sYcK+AE5wh1JC/6Rwhqd2Lfp04Tsk878UQosffJ0KG2A3f5MRTcYJ2ePfaQP84+o3lZpwb3mUZbbaKMTdq8aLyugBQp+zWXw7TqySw/F7AV+DPrWO1FbsL7LOY/Vkmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781134185; c=relaxed/simple;
	bh=VmL/XyDWEuE0QsbaGtnBZ4YmZiYfGkfte0l+rUVpi6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mniEQk5gcopp7zMAiSSJBy95wMgy0lPHg8JiQ1q6+owDyXLEM2iwFmXt747gwSuF1IrA8j+UIZPwib7d/g2rArQu9+EuakMwhVtaF2gMFmUtELquZWhBTba/BYY9oRo0aDkxuMy7JTBHRcNxYpP/Xm2owYrSzWXlsp3ud6V9k5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Vi1e7C74; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Vi1e7C74"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c0c3315c5dso76246665ad.3
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 16:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781134184; x=1781738984; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tbtqprzo1bFuxnDYsSnM79zDHYhOXlVVzm5C0yyeVNM=;
        b=Vi1e7C74n/Otb+QeD91uLEuwc1z6U/a2O2I58zBUQxOt+EltwC660YvYWzmA7pi67l
         8H4+PCDkDMoTIJgg8HNqX6S9zgXvWnPGJW3hGrOpEXdCiFHPqf6DU/gaUZJcp4jdTiC3
         5rJoAgFiTF8IRelY44H5SNRN/+K7EexF/mYLLheTIgZsW+4oQ+Ru/jqKqgcos+H5inma
         AuDbe4tTmcKcZIk3Rz/UkTONPZd88wud9IVlLOMHmE0+eYllfHSbegXwNb/ZWnebRd0p
         TsKOlJfgX4TZE/UDZkRPgjNQlCtrSP97HhgdFTr8yeec0gmfwqmXod+NHw1/oVmfmyx4
         m0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781134184; x=1781738984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tbtqprzo1bFuxnDYsSnM79zDHYhOXlVVzm5C0yyeVNM=;
        b=HwHCMVt6n3LOAn0AfxQAX6UqJWUFVxzQsteLbgJFXPCbxx0aOK21O/8o1fUcRPUjVS
         /N4ClzUqG5sf99AawLLSzOvcqkxiHDRm13MgzzYUY/j/5rjhuXCSvv0RCE7KMlZpXjQn
         djRqnKa0jvsRRhTImvcRRfXfTbAzC1NVOTnqWsgLK78OwmSfnKz4j4+3w669OL3Fmy4X
         9AsbXQDd+bxU67NYevL1shC5c/re8CosgRc8gAaZ2w2qLDwyJfK6JLEfiChAy0sSykIc
         wCJolVuTJJjZAIuhIfBvu+EUlXuNf7fKIJhNOeA2bmPWmk9hgxTNb4MnJBL+s2KDSS5/
         Zw7A==
X-Forwarded-Encrypted: i=1; AFNElJ8whj4I3/c28YOvdHhfj52btAi8ItRu1F50Kz7Q6jtRGK/118FYQdG+UgD2z4C7IxNokIuwSKDipqGQflx2Ww==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSFdwbQomAEoY3UY1DqZaHOF0N7lp+SZU+XbJyUzuhZeBqw4O9
	WGLoO2EgoiTyrvSNgxdVQ6qnWNAbKiVrirz5ffN2XuMI5OVnnldQ7AJMC5cAlK9fmQ==
X-Gm-Gg: Acq92OGIXOGznHiBXr15QokmjmjBFd5Q+snFQGJuHqQBcdJATcfmFWIbvD8Q/y5Vc2+
	C4VqtUukQ18t29Eh7C/5f8Xdz5haFlvn/ScHrRlDI72soPqqaRqGWQYzlvtmf+TDLb3MbiIXkm2
	N+aEPr81AJtXVog2lmQG2BlgZ/LzVK/V9D6O6Hb5dsgyKaSmwYqHkF8K6osknIw/GTLSoUkoFoO
	aLgc/HUQznGct2SeGU5wmwkvBE1OwLa8EuBy4U8sLHOeQ1Mx92RJwW6lFG/a3Yj7A5otfnwaKAQ
	fPFCnSR2uX/ySczwEKD/lKEuV58vKwcrnIBFFvB9YYwjcbHLHvXvFtLyDvr7rh83X14yf4yp4Vv
	p2jJnUAhB1H295WrLQGO73tF1x9Xz5SIFdeAeln+b68TDg9FLmSYkaqjTSkX2R7uUrMpQTIuf+n
	n5qlM7kKySP3yIrv2vhtgBlZLqZnPZqA==
X-Received: by 2002:a17:903:3b83:b0:2c0:ab82:6ba7 with SMTP id d9443c01a7336-2c2f3055e26mr1288055ad.33.1781134183883;
        Wed, 10 Jun 2026 16:29:43 -0700 (PDT)
Received: from p1.. ([2607:fb91:1582:d2f1:7bbf:a7c4:749b:120a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d090sm242781845ad.55.2026.06.10.16.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 16:29:43 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	minhquangbui99@gmail.com,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v2 2/2] virtio-net: harden page_to_skb() big-packet frag loop
Date: Wed, 10 Jun 2026 16:29:36 -0700
Message-ID: <20260610232936.1176094-2-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610232936.1176094-1-xmei5@asu.edu>
References: <20260610232936.1176094-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a robustness hardening patch. The slow-path frag loop in
page_to_skb() walks the page chain via page->private until the
device-reported len is consumed, implicitly trusting that len fits the
chain. It does not stop when the chain is exhausted (page becomes NULL
at the tail), nor when nr_frags reaches the end of the static
skb_shinfo()->frags[MAX_SKB_FRAGS] array.

Both bounds are needed: the chain length is big_packets_num_skbfrags + 1
pages, which for an MTU-driven configuration can be well below
MAX_SKB_FRAGS, so neither guard implies the other.

Make the loop self-defending so it no longer relies on the caller having
validated len: stop once the chain is exhausted, and never index past
MAX_SKB_FRAGS. No functional change for well-formed input.

Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v2: robustness patch

 drivers/net/virtio_net.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index afe73eda1491..518c22fa1b68 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -906,8 +906,11 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 	}
 
 	BUG_ON(offset >= PAGE_SIZE);
-	while (len) {
+	while (len && page) {
 		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
+
+		if (unlikely(skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS))
+			break;
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
 				frag_size, truesize);
 		len -= frag_size;
-- 
2.43.0

