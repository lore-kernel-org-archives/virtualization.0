Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E621627979A
	for <virtualization@lists.linux.dev>; Tue,  7 Apr 2026 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572326; cv=none; b=U3AidlxBMICc16NqYbZnDlPpuuwOOCcwfTK6mjVNxelyohcwfAlGbZle4LnvDJRvqT/xLP6iZ8Y3MzbXZfA/nCKjY4FK2ctvoCseJorcpzmprzLGL9k/viYax8Y2Vf/lpGrOEKxlnAPcsJrqVodwFeqNPBSJRN+cUPB0Z2CzdIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572326; c=relaxed/simple;
	bh=L/JCFvTPVv0HlOE0c8AmntduyQpe67fTxZL7BZ7I2Dw=;
	h=From:Date:Subject:MIME-Version:Message-Id:To:Cc:Content-Type; b=l0we/2SuZw9DNrOU866hnzoQwG7smlGQrZMR2x8+PygnYVmPOk9qoLrKp+se1wG0hYqhtjQ6z5eljj3fm6fXHbrVtJ8wUrd8M7BFEjZ1k3jlXklMWtEnxtQrtuHLGgqpgZLCVbG/U00sZ7d5oV3ZP770zXQns5csUJWDppqEvWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RY9p1rGe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RY9p1rGe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775572324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wN4PMrlLhWPP7lFFAEz7bnVJ7qzQh0MFMJBBTUMTFgM=;
	b=RY9p1rGeo6R4Nng20Bgj5IEwILBDcUlz2h27QNmJbIYv94QVH1qfs7qXvVKzbB1KbyKJ9V
	eL+RSJiL95Zqmoz8bfNn+c1HtRmhtxdap8o6JIlPFIwGjgbXVSvdxERpnbZwxH4eDP2lCN
	rmVtsx4gEUqBp64dzb024fh0pecF7pw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-3BaBn2OaPHKXudU4Iqqy7w-1; Tue, 07 Apr 2026 10:32:02 -0400
X-MC-Unique: 3BaBn2OaPHKXudU4Iqqy7w-1
X-Mimecast-MFC-AGG-ID: 3BaBn2OaPHKXudU4Iqqy7w_1775572322
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488ac66236bso16704085e9.1
        for <virtualization@lists.linux.dev>; Tue, 07 Apr 2026 07:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775572321; x=1776177121;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wN4PMrlLhWPP7lFFAEz7bnVJ7qzQh0MFMJBBTUMTFgM=;
        b=SdFKmbrZC5agkxkRHtRBVgRupEurpSZlvjAjs5hmVWZiP8fEpSgKDO59mqOmTZaVMO
         +BWjxITyfdMSIgbTZW+X71L10kiRavIG1uzzttv9Trp8T1wmiocCXn2Ovsap/Cp6/qPC
         GjK8VnGGadGw5WFgU6j5UnmYgO9ZeMwI1iJNXSjwf5KnqxKkAg3cWOLHHFx42WLC7taR
         OKqEAx5uSm2a3Sd3rC6MntndYkLN1MHjyNKexDf3k/QwxWrBX42r9RzGvC+AwyOf+JNX
         qy8eHQHpg0kRWozoNiYY086LijcjY9K1+iQvvOC6J3gNYnJnhzaG0UoFKd6ObrFKfYHC
         EYgA==
X-Forwarded-Encrypted: i=1; AJvYcCVynAbh+nmpKaB/wv3Mp0ALY9LGeIJy+K2aRzu5SF2sgXnbPq3UH+2rvmzy7nFHfKMLpOKvf0kbSTCqiYo2WA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6caUdaZfAfBm+E0eyWVWt6md43KKaitZ8IiSanXef0GCui/M4
	F3Edp0F6sVjkcnK39UXtyTmY6HHIIWYuILxr7QYjnp5H0m8eH9NWc5+2m8G5/C2aeu2OIIQZBbo
	xOeXIck/e7qGjkjN5D8IqGa4gu6Ij7YLxH6erK2DOrRIi9tf9acRK/yQdRUzFR6a0jOl0
X-Gm-Gg: AeBDievWHP+f1D3A9n+GjQjVV/ZCqpEnfRMNjkDOJiFfIk8WvDu1+2DNndA0JLG4Q2+
	IWWF7Tc+jZJLouPdwHqEFwuWiLlbcPvxSktg9+3OWnfOTJ+kBtaUkZSrF7W9uUDwGouz1Ihy25D
	D9TyBLHlsr+6kwh4XSJm5HENpvW4jlAv+3+4gHVXVojCX9Tnj9i4mEqdlX0ITlvfS+Rl/gISnRL
	+1bJT5OYRGdfo7B2xnrWpJUs12HKj+/0qBQzSYu/2YC/T4nxRftE0dj39CD/Qaxe1lS/NRGFqtw
	RsgpvbOPnftuZ5I4/Y5mwHILZQxoo0crN5TG25y3NjLcHuHBZu9mXOuYsBP/yy27BtXS2ABb/Ix
	Y9hiF8bb7PhQxUst7BQaaD+1BqJqlvhRuF4f6A2GzLSKZFrQ0SZOLX37p4TdZ
X-Received: by 2002:a05:600c:45cf:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-4889945f8c3mr203346915e9.3.1775572321452;
        Tue, 07 Apr 2026 07:32:01 -0700 (PDT)
X-Received: by 2002:a05:600c:45cf:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-4889945f8c3mr203346525e9.3.1775572320964;
        Tue, 07 Apr 2026 07:32:00 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48897fdd2cesm146677635e9.4.2026.04.07.07.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 07:32:00 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 07 Apr 2026 16:31:56 +0200
Subject: [PATCH net-next] vsock/virtio: remove unnecessary call to
 `virtio_transport_get_ops`
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20260407-remove_parameter-v1-1-e9729360a2be@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqAMAxF0a1IxhbiB0W3IiJFXzUDq6RFBHHvF
 odncO9DASoI1GcPKS4JcviEIs9o3qxfYWRJppLLhmtujWI/LkynVbsjQo1rCluh5tl1TCk7FU7
 ufzmQRzQed6TxfT/F+e0xbAAAAA==
X-Change-ID: 20260407-remove_parameter-f61a3e40cf90
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lmT8sI9W8pRZsCggoDaJMDnHqsfZ05YfMbv3K1vw_yo_1775572322
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

`virtio_transport_send_pkt_info` gets all the transport information
from the parameter `t_ops`. There is no need to call
`virtio_transport_get_ops()`.

Remove it.

Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
I marked this as net-next material, but honsetly I'm not sure if I
should have targeted net. It's not a bug after all, it's just a cleanup.
---
 net/vmw_vsock/virtio_transport_common.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 8a9fb23c6e85..a152a9e208d0 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -60,8 +60,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
 		return false;
 
 	/* Check that transport can send data in zerocopy mode. */
-	t_ops = virtio_transport_get_ops(info->vsk);
-
 	if (t_ops->can_msgzerocopy) {
 		int pages_to_send = iov_iter_npages(iov_iter, MAX_SKB_FRAGS);
 

---
base-commit: bfe62a454542cfad3379f6ef5680b125f41e20f4
change-id: 20260407-remove_parameter-f61a3e40cf90

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>

