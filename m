Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F3D1C10
	for <virtualization@lists.linux.dev>; Sun, 17 Dec 2023 08:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ejrwr06D"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbd0be3a7e9so1210428276.0
        for <virtualization@lists.linux.dev>; Sun, 17 Dec 2023 00:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702800560; x=1703405360; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dx3B6aLRQGDHWIOJfDNBvVD3RlXkr+3jhLG4738eUjE=;
        b=Ejrwr06DErfr0ZyApFot7uagKMlFzu35GC1/Q66fIULETDaK1Tn/odp13MNapFHss+
         7MJGe4eX+F8F+Rv8HFbstNnrSZmMToZ6EUBD02kh4sjAyJ0S2ZYxFjyWhPPf3rUrHVhr
         V9VjU4CK4TU0tQzhzpY/nDUoAyeQhp/q0fTXZ7TQPhHfpnbzLjxqfIA46afhQaB+wHLd
         kexAmBd9DILPki9ZUpGOjVCNEncBRrXTqf0Zm+N5NwAbr96ZZneA3FdjEG2ib7Au3oRv
         x3EzKNqFj2KAVonlBEMhQrxyf98ZtOYkKuiS78Tnlb6wCcMgsqyfx96dZ6cj6/tTFxSm
         M77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702800560; x=1703405360;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dx3B6aLRQGDHWIOJfDNBvVD3RlXkr+3jhLG4738eUjE=;
        b=PEf54FyxR4U8lgjAm0j9Vpjubs5pLdTfEJhq4t47bRGbSCRfCrO0S6H7eQ6grODeBA
         frruzkcFmGDRTnaWNAResS3ukxSGfJ8+sYiYyJ7IGyd74t5MvXMPF8WBFpY83dOlCzJK
         LM71te6fnN3P7XfLh1plkq8vfDyDtbGGF/82oPYzk3UMH5DKb1CUjH/CXImJwfSap910
         kUWMnsC2KSl2S08D3gmqjgdFz5lzVC4ZdSBg2D+CBM85kZ1Qj7urh25gZ5b1NF4rND2F
         sJzAqyF2Leimi5N9yugkV0o0ixeirXB+5WvpC2GF6Z3uUKX8kRk2vYsmU2QBbCnQWRSS
         CDqg==
X-Gm-Message-State: AOJu0YxboGiBvXV95j6RPKLk5dRmJAtqZuuGquH8FBzox9pfnfWZanxm
	l2+SomjHA7i3BFVmbiNBs0570yM119xb7ZxVkg==
X-Google-Smtp-Source: AGHT+IEwZTJQinwLs899XxaD5GQX67+mFW+pdrHRCj7vW1TcxI+XrOUDAC3B4t5e+jZNBioLBKKYu7HWw6u6KGTvBg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:3eb4:e132:f78a:5ba9])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:1343:b0:dbd:13b8:2598 with
 SMTP id g3-20020a056902134300b00dbd13b82598mr628107ybu.3.1702800560127; Sun,
 17 Dec 2023 00:09:20 -0800 (PST)
Date: Sun, 17 Dec 2023 00:09:09 -0800
In-Reply-To: <20231217080913.2025973-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20231217080913.2025973-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231217080913.2025973-2-almasrymina@google.com>
Subject: [PATCH net-next v2 1/3] vsock/virtio: use skb_frag_*() helpers
From: Mina Almasry <almasrymina@google.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Minor fix for virtio: code wanting to access the fields inside an skb
frag should use the skb_frag_*() helpers, instead of accessing the
fields directly. This allows for extensions where the underlying
memory is not a page.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

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

