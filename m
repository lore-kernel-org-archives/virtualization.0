Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AF3481C3
	for <virtualization@lists.linux.dev>; Wed, 20 Dec 2023 21:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rw7fvy8L"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbdb69bc114so221662276.0
        for <virtualization@lists.linux.dev>; Wed, 20 Dec 2023 13:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703108709; x=1703713509; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o2KyAbQGeXRxX9Kez0BA+ghL8Ur6r9y2yNTe+BsOa4w=;
        b=Rw7fvy8LhchFcSwNzISuWFJtsZX7CZpJAa0IMQYdq2mV7toeIo1AMUy8+a95QZ2p8i
         60HMojsiWomLl1E7nk1j7vk3PDtDMqXj1HZO5ngz9TuuIYhJcp9bWKpmvdJY3rRSPfth
         rq0+i5Zt4A9TniwxK3kMQhwr1CS8tv9QmS74DX27vq9zIfgKA1fansa2fY9wrmMA8qBj
         0Nro+r7nqfMSlH1rWYq9YxALO0R05OMfkhaiUZYVROyNPub+sVWm/gxKfhwG49R2wOmi
         0AXJ//A0KnBgeeN0ezHvJAfCLTkEx36s3CuJQAuSkZ198h8v7g7ZDpvKRIQsiYpUbQNq
         FU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703108709; x=1703713509;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2KyAbQGeXRxX9Kez0BA+ghL8Ur6r9y2yNTe+BsOa4w=;
        b=ENXQQM0MmkBHneddL9kcNkkKl+QtMBlDaciQb/g5T5PyV0/Vhsq1qxInZy3I2r+1tO
         E7I6d/m0PJlLcql8ra8KSCYCXZ/77/piItdQ5Nx+NgR3YZpBitrEpMbkX8xmbizuz/9I
         VvqNBvgcH6QrWNl7YabU2GTuWNZImGuKG6yqxwRQ9Ckc8nbAJchdMLtz7ZA0SOw3OD9D
         Qzn2/Gv0MdhDt6TsyPVqaxxZlD52TO/D0e3yckcBetueg1aT+yzF/ocH/YjskoFjyXSZ
         fUaZXLaLtOOdA6HmEgRa/N5GuyvgmQ1JEXp/HfOx4jyAdDZQ1ws5D1TgiHQ1HXN0AWcG
         ZfPg==
X-Gm-Message-State: AOJu0YwKOspwn2LzKTue9NvkC2SxizLqcMWt8sdrowGLuHdi95LNHHhO
	F9xLKQsIJOFemrCtWiEkq5HipqmXC1A8YPKFAA==
X-Google-Smtp-Source: AGHT+IE7ilKkOrmL46A3RgdxBVn3MVyI3yL7d5zpBM8duX8cRIhEiIVPqPMQ8eT8oJpLJ5c6kFU+WvEOFOrBl7hI6Q==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:13cc:a33:a435:3fe9])
 (user=almasrymina job=sendgmr) by 2002:a25:8701:0:b0:dbd:bce2:82f9 with SMTP
 id a1-20020a258701000000b00dbdbce282f9mr157856ybl.10.1703108708803; Wed, 20
 Dec 2023 13:45:08 -0800 (PST)
Date: Wed, 20 Dec 2023 13:44:59 -0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231220214505.2303297-1-almasrymina@google.com>
Subject: [PATCH net-next v3 0/3] Abstract page from net stack
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
Content-Transfer-Encoding: quoted-printable

Changes in v3:

- Replaced the struct netmem union with an opaque netmem_ref type.
- Added func docs to the netmem helpers and type.
- Renamed the skb_frag_t fields since it's no longer a bio_vec

-----------

Changes in v2:
- Reverted changes to the page_pool. The page pool now retains the same
  API, so that we don't have to touch many existing drivers. The devmem
  TCP series will include the changes to the page pool.

- Addressed comments.

This series is a prerequisite to the devmem TCP series. For a full
snapshot of the code which includes these changes, feel free to check:

https://github.com/mina/linux/commits/tcpdevmem-rfcv5/

-----------

Currently these components in the net stack use the struct page
directly:

1. Drivers.
2. Page pool.
3. skb_frag_t.

To add support for new (non struct page) memory types to the net stack, we
must first abstract the current memory type.

Originally the plan was to reuse struct page* for the new memory types,
and to set the LSB on the page* to indicate it's not really a page.
However, for safe compiler type checking we need to introduce a new type.

struct netmem is introduced to abstract the underlying memory type.
Currently it's a no-op abstraction that is always a struct page underneath.
In parallel there is an undergoing effort to add support for devmem to the
net stack:

https://lore.kernel.org/netdev/20231208005250.2910004-1-almasrymina@google.=
com/

Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>

Mina Almasry (3):
  vsock/virtio: use skb_frag_*() helpers
  net: introduce abstraction for network memory
  net: add netmem_ref to skb_frag_t

 include/linux/skbuff.h           | 92 ++++++++++++++++++++++----------
 include/net/netmem.h             | 41 ++++++++++++++
 net/core/skbuff.c                | 22 +++++---
 net/kcm/kcmsock.c                | 10 +++-
 net/vmw_vsock/virtio_transport.c |  6 +--
 5 files changed, 133 insertions(+), 38 deletions(-)
 create mode 100644 include/net/netmem.h

--=20
2.43.0.472.g3155946c3a-goog

