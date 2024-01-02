Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9201168B7
	for <virtualization@lists.linux.dev>; Tue,  2 Jan 2024 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UZTUDtCV"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e898eb4432so131710967b3.0
        for <virtualization@lists.linux.dev>; Tue, 02 Jan 2024 12:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704229149; x=1704833949; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6OrdrWvBDxOQfJ4vcbx726UKsh13Gg6rlqSW8b/m6AQ=;
        b=UZTUDtCVZVHcEpwwIgB7VmGmJlOLmgkwzLctvcgVEcHhLRHGAQ3xne4lh0poMVjJHZ
         +8cWk2j7JW1Lf16H2yqNd5Pl/rnorQR50TM6aoG4if1e87VVbyGmmgj8rYDKGVAA/9kQ
         xAhyl0isY5G9/UtyVyaW2k1SV3armpuRVShkEz9Ce8RgxcSc1HZ+oiZ9d9GtDDV1rk1R
         7y2kSloWGqXi2bX9G1mfqkWzdyUVppbaqnjKWg9/R495Vh5jqdyaQ8iQ/rnaQ4W7zWcG
         feTTgZkKuqj7hYRrFhB2FCM9EVuG8yFiu8AJagyZGvJDuqKo4y5yPSIhq0DPfEbljCG7
         tcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704229149; x=1704833949;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6OrdrWvBDxOQfJ4vcbx726UKsh13Gg6rlqSW8b/m6AQ=;
        b=MOUtk643gOwYfeKyAfN3iL5bIcA2z8+7LIKqIx8VcoWIYG3Vq9E9Cwc4mGptqTP8Rx
         vZylYXLZi2Fr2Rhlz3kWp6uatCQCX25S8z0x1SRWRzsJwoUhZFPOoQeWePqQx8jAESCc
         RRed4zhDO5MUabWoVSR/fqbmjMqX/kKs/H7cXXWwUBlA5Jdk29Q6LpqI3ECe234kU/7y
         wmrYcMauFexCC2fgdaFe2pJ30Y+HrrkFvofH4ud8vXxeZDHWEB6q51DIt6qc84F5bWcp
         q/jj5MQ8umNtmcFQNf299gWPvHHCXc1yk+uF5BoSkGJMEFXZ8xw73Ky6gqG6N8UGcSeE
         B5cw==
X-Gm-Message-State: AOJu0YyON5sjwK6q+T9zPH1RZt1zjuBR+xgqYsxyuaQGjisVza2H5zNG
	9M7rIhqbE/ISNnZBxcZypdl75ClH/hBLy8ini3JM6DRX
X-Google-Smtp-Source: AGHT+IEYBVWVkGFDvnDDwSh8ZR1uFwBIdUhOiKNQJdQm7yNcrBncdU6lu+BqxXTaSudF2V5VYA6E0+s7Hmgg6J64Ng==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:9a04:c262:c978:d762])
 (user=almasrymina job=sendgmr) by 2002:a25:b9c1:0:b0:dbd:b7cb:8a6b with SMTP
 id y1-20020a25b9c1000000b00dbdb7cb8a6bmr513742ybj.1.1704229148829; Tue, 02
 Jan 2024 12:59:08 -0800 (PST)
Date: Tue,  2 Jan 2024 12:59:04 -0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240102205905.793738-1-almasrymina@google.com>
Subject: [PATCH net-next v3] vsock/virtio: use skb_frag_*() helpers
From: Mina Almasry <almasrymina@google.com>
To: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Minor fix for virtio: code wanting to access the fields inside an skb
frag should use the skb_frag_*() helpers, instead of accessing the
fields directly. This allows for extensions where the underlying
memory is not a page.

Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v3:
- Applied Stefano's Acked-by.
- Forked this patch from 'Abstract page from net stack'.

v2:

- Also fix skb_frag_off() + skb_frag_size() (David)
- Did not apply the reviewed-by from Stefano since the patch changed
relatively much.

---
 net/vmw_vsock/virtio_transport.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index f495b9e5186b..1748268e0694 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -153,10 +153,10 @@ virtio_transport_send_pkt_work(struct work_struct *work)
 				 * 'virt_to_phys()' later to fill the buffer descriptor.
 				 * We don't touch memory at "virtual" address of this page.
 				 */
-				va = page_to_virt(skb_frag->bv_page);
+				va = page_to_virt(skb_frag_page(skb_frag));
 				sg_init_one(sgs[out_sg],
-					    va + skb_frag->bv_offset,
-					    skb_frag->bv_len);
+					    va + skb_frag_off(skb_frag),
+					    skb_frag_size(skb_frag));
 				out_sg++;
 			}
 		}
-- 
2.43.0.472.g3155946c3a-goog

