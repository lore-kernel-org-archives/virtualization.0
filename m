Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B443B42CA
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 07:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781162003; cv=none; b=RhARh8d0gcEONCmzpMUm/fkHBbT0okc0co7LsGx9c7j79JO5WKkJGcEQkbApYo4R/MCMHk1rmPn0Jp/QEeLSvfJPZQR5OQ3bvGYNgCzCV6l91bzN3YlpPN4+mhsAGBS+g9LA2vjG2T4Ha3MpLMhkkIgjrmvqYHjTHDc7pWPJxEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781162003; c=relaxed/simple;
	bh=xIYuk1b0GTpsWcIVIg4zf/5vOm0XAhvVbZrtDZjApvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZ/OPEG+k+WrOIZLflLSjZeBys12USgeTJTrCmd/AtLi1DUu+D7jyeiRGkMOYy0HD+JEo9q8IPrNHFIm9D2ihRM3P92780diSNkoIHv6VY9ZPZ578rdK3vlJkkZBfDeAD/k8xWKmnUv5dSNnJftj8CXV/4cH0UmjSWyxbJx8Vig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOOfkD3y; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOOfkD3y"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-7f5eb760240so11383487b3.0
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 00:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781162002; x=1781766802; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuaK5tAXGNz9SIgM947GwEn0x65wr34XvqFUv1VfkTw=;
        b=MOOfkD3yG2YdbMdNlNbyORjAEkiuJlLlepidG2gT2nBJBWdQ8FoAfkMrqN1BDra+dk
         yZuvTRnTDi8JCSEJMLb5idR+f5ZG3AhRo5eXOJPLf9uX5rZHKeiJvLWeVn/goBOqD0Mj
         +CvcbxeGcVEm5PJmYNPTdqwGftYL1Ihf5RHv5FVg/9aqYR1THk5P6GfAas9FQJFb17tc
         YQxSY4tR2869kbRRZU7a70EDPLs9Zv1fY/oIzIWmkLqUfUcIHqDNZH7NLWXm8xygF5sx
         37pWv+TGFNuslBgjzGKpXlDJCDEZ8VYbf9NKbKNovA7qCLW2TXsJeejAEovbz4mPKXj/
         J3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781162002; x=1781766802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KuaK5tAXGNz9SIgM947GwEn0x65wr34XvqFUv1VfkTw=;
        b=YiDvmB14T+9twimRX3n/nBG0mwWW7C/OecTQjHpXILxsHXiXqz1FbIEj3vIw9lDmn2
         S4JVgOp8OgDmFk2r9xohmID5eHcba4Ieiyo9m8j6TfJPEM5ksFC4e8pyIieH0+3Ng6Zq
         dHOksCyfHRhzPXH/nkjscq6GJbDRk6otQp1vt/2rsudFR8kP/6tzmeIWeO5swLNe7N9w
         SV0jOcdVhgxgylBkTKssBX5I9I/n9F3Y2hR/XK2oQxVLs7FF/Q7wBxwkLbDLUiVA6Mfv
         fiSFY6f2c7Gss+HmQhNzQ8n6DIoAT2EWCG/xzn3oWllpKJvJyckEka1h/n3WS+j/hokl
         sMxA==
X-Forwarded-Encrypted: i=1; AFNElJ/bUqzMO/uoGRpCYPhtnxWOjmg4dA/8zcnf3WmBB8whbx/eDXl4eWG6Qo+eBs/qTdJu3fc21ejYKWhoRyz4cw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJatGxj8YBlEQLVuj/OK3x/8dzR2RkaFOKLCihtnxTcs2w3RcC
	+ynUVkQxfW2PZ6gL+azkb/2S7z9LuikuS286BHgUstx6X4FnZARrorA1
X-Gm-Gg: Acq92OFazRLFVlHszE96XuDtKs3ZBXEC8z93++nUxtocrqoxXW0VPmjSnbmZdMPAfw/
	ABJyAaIaY230/dJtDY/bPZU0rSAw+zBXtDah9EB6Z+KGcbFbI5sMa1qYDyLOXpCgue1zX8j45+H
	gv5IX5RNLnqWeDhrpFFB8mzPdLUt4w9ssSZbRRbK+7+Y4r8DGYujUh74/TXQ7zOdhI5n9UxLu1J
	/b8bp+R3Rd38+eEN9lSy9nVcw+MHj9rcaDSMd+8GhYS6BlkbDX1volx1Fg3KzB1Sxj5TLJNomCB
	n3NqZKcXh4wBF7xV2HGHboPBHQ9dlbZumrZ2I7mEHNkSryIS9kOyYXS1xehAAUYJY90zTOUkKqz
	AZ0memBQip0tYCy6OBQR2T3S7etXfWzEFQAfn1Au1HiL1ynPpzywEnnQ88ORTosPpD/mEeq0lhA
	p9nC7AByGqTgLvc2zUea0GHoLTXD7YwNGIXTyzYAnFAjvP1BOHWh8=
X-Received: by 2002:a05:690c:6b83:b0:7bf:55b:8f97 with SMTP id 00721157ae682-7f6561dc497mr17405317b3.14.1781162001681;
        Thu, 11 Jun 2026 00:13:21 -0700 (PDT)
Received: from localhost.localdomain ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7f693504701sm2551487b3.15.2026.06.11.00.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 00:13:21 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: dongml2@chinatelecom.cn
To: jasowang@redhat.com
Cc: mst@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bjorn@kernel.org,
	kerneljasonxing@gmail.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next 2/3] virtio_net: initialize napi.tx_napi in virtnet_alloc_queues()
Date: Thu, 11 Jun 2026 15:12:41 +0800
Message-ID: <20260611071242.2485058-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611071242.2485058-1-dongml2@chinatelecom.cn>
References: <20260611071242.2485058-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <dongml2@chinatelecom.cn>

Ininialize the tx_napi for the rx queue, which will allow us get the tx
napi from the rx napi.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/virtio_net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 86b5c1ca568c..d72c124c9760 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6543,6 +6543,7 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 					 virtnet_poll_tx,
 					 napi_tx ? napi_weight : 0);
 
+		vi->rq[i].napi.tx_napi = &vi->sq[i].napi;
 		sg_init_table(vi->rq[i].sg, ARRAY_SIZE(vi->rq[i].sg));
 		ewma_pkt_len_init(&vi->rq[i].mrg_avg_pkt_len);
 		sg_init_table(vi->sq[i].sg, ARRAY_SIZE(vi->sq[i].sg));
-- 
2.54.0

