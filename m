Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6433E3DBC
	for <virtualization@lists.linux.dev>; Mon, 18 May 2026 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095224; cv=none; b=pelAFXFyfSwE+WVOYerErhKt1pjOZHZ5ct4uC5Tz3yqmzMAwsXif7YO1Xv1XvqeSSkz/G2DputK4FQFKzCy+pbqJB/LmyQFg7A1+gl4liS8yMhvNKMEpI+KCu6WBs0Fg2r8td23zkx6DsTh6BoO/77OuIPH3PI9RaBA37gV5dpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095224; c=relaxed/simple;
	bh=4Jgas6XMDUNHabFy3gLOXXGPd/CXV5aZuFt6IpzE+ME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c4smxgtyL/EVDb5fYyIovuCmjeAC67jO94OEWpo6c25k63BImilApkfcgw92dTntaX3A8r6L2rAzQWBiDafxAnVRhMCQ8FVHT3qiVYJIGlBlIk3obtp5lc9Rs1zw48Y0FUGV7DTdoUYMPGqkmxtiKd8x01wUBAVs1SB9qUyzIxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C3I7nypt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C3I7nypt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779095222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WVr+ozlWbMHYAfpi/swl/ldM7Por8GhrxE5XtzjKwI0=;
	b=C3I7nypt0CqHtwM4x6/+buG5pneBPdx7dxPyjAH8sUT6icPpIQD/952T9ZtAg0O5RLL8op
	t6vnHBCctI6KI7LSuIjAHeJ/jZuDwIiMQ9tbOZ5HHxXqWV1HHkcRmG2w1SHiGRY8gPRivP
	YBHbm8rm+eTxYSK4lE2xRjSfYojjGQM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-nYWmcpwuP7yodfRZgy-vmw-1; Mon, 18 May 2026 05:07:00 -0400
X-MC-Unique: nYWmcpwuP7yodfRZgy-vmw-1
X-Mimecast-MFC-AGG-ID: nYWmcpwuP7yodfRZgy-vmw_1779095219
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48fd233d1e2so18576885e9.1
        for <virtualization@lists.linux.dev>; Mon, 18 May 2026 02:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095219; x=1779700019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVr+ozlWbMHYAfpi/swl/ldM7Por8GhrxE5XtzjKwI0=;
        b=XhTqqjWs/+ETR+67kn/Xw+ElVfd4SHMudAgCzX6LMcg316qG+PA667OuM6a4VfK5V/
         YZvv7BjxMjLsnhN6mwxDFpreVRxXOzA+UbsXR8HpXYxvaQ+kg65Kcq1gQu3OqUbneSvN
         QHwLMUWAHmy51g8/ujbTf+QPQFi+Mepb5d40OthUX9J8VMMF/bwV4H3a0nUVhM/cgTL8
         uz6L2uTnU4LfmBI7lk88Y0bpvD2baoiuNN2FQguhvio9W9ycvpJKSo1O1tsFMo/m1XE6
         AjeOXJkG2MW/oeczYG1sZLZS8Zpjwti6BjbtUEhvkDGex3v/Uo8IUWbKQBIQFxdTUm5l
         UIBQ==
X-Forwarded-Encrypted: i=1; AFNElJ8rLhgJtrDV9G4yqvzAbOSygm6bblHtFz27PUTJna3WSv8VErkxxLNragwesZ0U3Grr8Viar/78Uv+0wCE7mg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyaflZPcPA5+43teecWBbCivRLNtIE3tPVftOnwI/+v2VaKoKox
	hwlt20VAJokeu3qtNaCIvyp4p2nt/5rDDLLBQR+z1zMEsTV1V9Hmr6YEcyoNl0ETMZFYM25SeCM
	IGOAzTosMMIhQi+UX9kr3FNJN186LBoFRNKbux/HNSo34AVraXG95oCRgfTgBlTgR+nGF
X-Gm-Gg: Acq92OGwj4GyMKgfJ+42DmWKIfd7/BO4/Y/jB/pZyLemyi858TG3hVJkNL9gTSTmEXY
	tRH/zL1ARPYMWBxsqyIlBZ4B68XTXBTFnLVGHH3WCb+kkGxByYam/7Aw+B+jVWJk8JXY2UP2DGg
	EMJPFrsUuCMjssN5zyyzSn7Pw3eca3X3IUQeFxsK58Do3mTkT9NnI/hRjyI5d8dC+oWnGdt1Apf
	Atuhek0n33QrY9ETvkatKU7OOe1FuK3mIHFE1vlnnUmeGEPg2IjadN2OG0blE8M4u3Znp0atJfi
	AWDL3+RSEC/Qpc0wEerXoOk+8rRiu4C71Lcaaz2xf3XloOUx4acTosD7HoJP0Mm40N0qefsD4xK
	CK5EJdchntQ8VN0LBqMWJiKoHQIo1axOh3Ve9k5Srei9YRYgVZ4imezIfLUIf
X-Received: by 2002:a05:600c:8184:b0:489:1c1f:35f1 with SMTP id 5b1f17b1804b1-48fe60e1451mr214884075e9.4.1779095219294;
        Mon, 18 May 2026 02:06:59 -0700 (PDT)
X-Received: by 2002:a05:600c:8184:b0:489:1c1f:35f1 with SMTP id 5b1f17b1804b1-48fe60e1451mr214883165e9.4.1779095218657;
        Mon, 18 May 2026 02:06:58 -0700 (PDT)
Received: from stex1 (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5e9d5d9sm279478545e9.15.2026.05.18.02.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:06:58 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	kvm@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH net v4 0/2] vsock/virtio: fix skb overhead accounting to preserve full buf_alloc
Date: Mon, 18 May 2026 11:06:54 +0200
Message-ID: <20260518090656.134588-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HHx5A6Ws6DwNQIJR7Dq8_B93riSgmADQr7KK5LmVjQw_1779095219
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Patch 1 resets the connection when we can no longer queue packets,
this prevents silent data loss, and both peers are notified.

Patch 2 increases the total budget to `buf_alloc * 2` for payload
plus skb overhead similar to how SO_RCVBUF is doubled to reserve
space for sk_buff metadata. This preserves the full buf_alloc for
payload under normal operation, while still bounding the skb queue
growth.

In the future, we plan to improve how we handle the merging of packets
to minimize overhead and avoid closing connections.

v4:
- Split the buf_alloc check to be sure the credit is still respected and
  to avoid overflow of buf_used [sashiko]
- call virtio_transport_do_close() and vsock_remove_sock() to properly
  close the connection and remove the socket from the connect table
  [sashiko]

v3: https://lore.kernel.org/netdev/20260513105417.56761-1-sgarzare@redhat.com/
- Split in 2 patches [MST]

v2: https://lore.kernel.org/netdev/20260512080737.36787-1-sgarzare@redhat.com/
- Close the connection when we can no longer queue new packets instead
  of losing data.
- No longer announce the reduced buf_alloc to avoid violating the
  spec. [MST]

v1: https://lore.kernel.org/netdev/20260508092330.69690-1-sgarzare@redhat.com/

Stefano Garzarella (2):
  vsock/virtio: reset connection on receiving queue overflow
  vsock/virtio: fix skb overhead accounting to preserve full buf_alloc

 net/vmw_vsock/virtio_transport_common.c | 29 ++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 6 deletions(-)

-- 
2.54.0

