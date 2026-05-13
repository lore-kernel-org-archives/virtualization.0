Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB94E3E639D
	for <virtualization@lists.linux.dev>; Wed, 13 May 2026 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669668; cv=none; b=YFgiqk3mvYKY2oF9Z/+CQEsBcwBxu5j6XiiZpKLC1Gt9Rctdc7D4FfH3jKHKfp43chp5qtSvTOLk0IytTQa6eGIUgPip6Z2bTWieUPlyg1JeH3vZIjv3l1E80W4tDbUj6vVMPYjOQNYZldP1WT7suuHTJCkBbfn/8jUGGHixD2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669668; c=relaxed/simple;
	bh=7yTfwJVH7KQt1qPTBB2JpVv7SoanftpfAUK/i+v825o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ac4xH6hzh+8pWQHLXGxw1D9ROiFQ33+DMZBTYZwBNiBUwRkUHmRFaAomD+JFAgF04DWrQ/wTRykh46YvV8cFNH1ZS/vH1dT9CgAQNNiqaQJ+zF5plAcyRoyIegN8fPIkY3nMRgLccT3+CUXvjRJ0eCk5ff9TadTz0V58iRSeJcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QQst75dz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQst75dz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778669663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j46NWqxlvtt9B8j2CsxWNzaR6FQyGRn7VT2uSJN4uKw=;
	b=QQst75dzs1Xpr3SXNzKbfnnX+Pt4uZkNDIAIu9vLu3h4nkUBMMinifitViN+XnK8DSQXfN
	izei8/lIhfm4Zmu2pO0LneJ0E8x+vRvJHcQ3SSC+FnWQBD7bW12pb/TYlTZuIb6bL9Itot
	TkzXC8v6FONxXp93AJLvYoSw2muoNH0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-3x292GxbO9iH0nrp3Za_CA-1; Wed, 13 May 2026 06:54:22 -0400
X-MC-Unique: 3x292GxbO9iH0nrp3Za_CA-1
X-Mimecast-MFC-AGG-ID: 3x292GxbO9iH0nrp3Za_CA_1778669661
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d789cebcfso5387584f8f.1
        for <virtualization@lists.linux.dev>; Wed, 13 May 2026 03:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778669661; x=1779274461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j46NWqxlvtt9B8j2CsxWNzaR6FQyGRn7VT2uSJN4uKw=;
        b=iWXfluUNgeQZg7tBiacG06+vstfuM5f/PLgSmNzsPftW5FO4HdU8nTRkH5pDdUnbV2
         ZVoYTpOuxDNBOaftsv1cVzfypcnGxCyGxwTo6NDw7GGFDfv0PACGVZs6IDZcHPPIUcdd
         v0rmg/0x3zWmObGHd4NaXigU4ICyFLrZiZxgXBPkD6Lyn4UkvVp8CYrg51NlgZ56JxX0
         7rsucUViIAA5a1TYDJcmrPQN/yfA7zFHVtU9aYzTbm32eSi6lv+QEuE4GanWoAM0BUEl
         ftnPRrKDO27Uvb6shsafxQemI5EKHzyHpPxWQXI0vJcQOovcS87ntc8NtmYY6GjZ+gD4
         YJhw==
X-Forwarded-Encrypted: i=1; AFNElJ9/BmQwp7P6xKK7FpMMEkpOVsZlcB2M2+xCo/4iSSnnQYsVVaR/uWXKXZ5Ww3RXgA8LY0RZs6TImHx0kwzz0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywh2pigITrX64BlMsRL6DHjY3bl8Y4zAlS2HNXEAZFsHFX/jPct
	2fuR6BTCQFlgka+FxDpZhW6UO5EmyrWrJAuYL+SsQOe0Ef6tizFnwkQR3Df063KEaV7hexnKMUx
	KrbvEAtFr4m+wV1bvJPE2VjD/TeXWWQ+Ck73qIFgAKWUWa2Fp15IOlJp5bDb6dkrt2hhr
X-Gm-Gg: Acq92OFJ1wWWkluZGJr6tSOP9QrPcM9eoiU8quN2Zr1/RBml1FglFQxdJtHxZOZlQXr
	hVwXLgYf4QvrXExpzcnTWRtLj1959XrMwWvSbLQ6ONjOzjMg/krUHKI1afk6FkDNnH1HDuJJFQn
	eakK1PzGiZ94pxYM57V02s3UxQ9UPWqktJ+ItEVcl6f1V//muQKB6fz7wsejISkFbicgZSRnCLv
	TGQq52+5CFBmUJBpnxhJxDtLZkRPIOxkc2wlj3egXEo1XRI+1+2UVTHwyjmWB30BzPUHseuFR6x
	XKA7y35KKG3KuYwA9DjT2s+tFjlmVMt0X8l7rpIz5iJcpfPReuQVQ4llc5NtT3fvLmtzUnAjNiO
	WdIbqaK1PCawMNhZBNdbbkduAyQ5gvHQYH5l4w7+V8W5DGhOpB/FrE+x1IHPn
X-Received: by 2002:a05:6000:1a52:b0:45d:4c30:81a6 with SMTP id ffacd0b85a97d-45d4c308261mr10945f8f.5.1778669660826;
        Wed, 13 May 2026 03:54:20 -0700 (PDT)
X-Received: by 2002:a05:6000:1a52:b0:45d:4c30:81a6 with SMTP id ffacd0b85a97d-45d4c308261mr10918f8f.5.1778669660370;
        Wed, 13 May 2026 03:54:20 -0700 (PDT)
Received: from stex1 (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549130549bsm41002672f8f.18.2026.05.13.03.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 03:54:19 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	kvm@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH net v3 0/2] vsock/virtio: fix skb overhead accounting to preserve full buf_alloc
Date: Wed, 13 May 2026 12:54:15 +0200
Message-ID: <20260513105417.56761-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uknPOHMP7RbwosEqh8F_eVdCFHrJ9O47WR0sdNtQ6sY_1778669661
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The code is exactly the same as in v2, but split into two patches as
Michael suggested in v2:
- Patch 1 resets the connection when we can no longer queue packets,
  this prevents silent data loss, and both peers are notified.
- Patch 2 increases the total budget to `buf_alloc * 2` for payload
  plus skb overhead similar to how SO_RCVBUF is doubled to reserve
  space for sk_buff metadata. This preserves the full buf_alloc for
  payload under normal operation, while still bounding the skb queue
  growth.

v3:
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

 net/vmw_vsock/virtio_transport_common.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

-- 
2.54.0

