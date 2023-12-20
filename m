Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A14498A7
	for <virtualization@lists.linux.dev>; Wed, 20 Dec 2023 21:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vgEwToLI"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e7547e98f1so14142397b3.1
        for <virtualization@lists.linux.dev>; Wed, 20 Dec 2023 13:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703108711; x=1703713511; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dx3B6aLRQGDHWIOJfDNBvVD3RlXkr+3jhLG4738eUjE=;
        b=vgEwToLIi09PY+2SW2nfnaE9yzhvpZSBTZxVhv7KiO6G9uOGpeXFQApI/eY8PH5DZ6
         9oVf9e5RrYHJk16Wi0iQMuBHYfRob0LVjgMFDCVG8Pj9N3o+RA95EADMBpkzzgqMI8Un
         E2tUlqi1UjU7ZPSr9oDxxiWcM5lU5pJxUzjSE5Km1/FSXFm8QmFG0EVQY/9rJVUY4CL5
         6FO+nS98yFfDltzuGkPcdwUAy1YVM6+LiMtJ5l1W2SMaSRsPJvL3jWkWV4NAD1M3DonD
         LxEA1syu77yEUhv2BGpcDS2VLR4gXTZ0ionvJnmvTBHNagDLzsLRKzCCM/MaA4U9t8u8
         1IZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703108711; x=1703713511;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dx3B6aLRQGDHWIOJfDNBvVD3RlXkr+3jhLG4738eUjE=;
        b=DcVTBguKhoUT1DSLjtpRPSNOzam+oNYXHC9qzMVsneIYFUjTDXNz0s9EqGwqnHqoH7
         ueHG3xlvduLms/DCI5e+IW7pQhnXnMIF/WaVvmWoq5hRzYNKt8wyuprDLJtcuUiFyDPQ
         wcy7rOm/YYLlo4neDD0Ny1G2e3kGIskcBgVyUU2koCCFXgm+jCTJcZJR/BsJ7N6SplLH
         e5jcTIvDSgEVP0HYV9Tk2tgkyBjaYsNzt+dlMjGCSqSoEHNqE7GYyzQtfK2GsfjpoU1B
         pdu6j4gywxL+LgBlyslvG0RRSuQdWfB3wARpD5Xf5r9KE+CmaXuxfiRxkYC9Cv1LLTCy
         juIQ==
X-Gm-Message-State: AOJu0YxwLhZ9WI2szoWG+RVjVHGbgYvlCmFdAgeXR+NtxRuUuR0vcWx3
	BuYheo0GGkVomfeyKGXdey40vEzbDso+MdWDvA==
X-Google-Smtp-Source: AGHT+IHeeVda1fzWpC2MyIipIVgO0VQgD0ORR43fQFWg6vkMg277efZauOAp6kk/JYNZ/heCWJCa9Vn36QS5XwGBZg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:13cc:a33:a435:3fe9])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:c01:b0:5d6:f1d2:2e5e with
 SMTP id cl1-20020a05690c0c0100b005d6f1d22e5emr170815ywb.0.1703108710831; Wed,
 20 Dec 2023 13:45:10 -0800 (PST)
Date: Wed, 20 Dec 2023 13:45:00 -0800
In-Reply-To: <20231220214505.2303297-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20231220214505.2303297-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231220214505.2303297-2-almasrymina@google.com>
Subject: [PATCH net-next v3 1/3] vsock/virtio: use skb_frag_*() helpers
From: Mina Almasry <almasrymina@google.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	David Howells <dhowells@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, 
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

