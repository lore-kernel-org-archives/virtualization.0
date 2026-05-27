Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18DD44BC9F
	for <virtualization@lists.linux.dev>; Wed, 27 May 2026 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901857; cv=none; b=RkWgehiRcNbgwan/kDXA+u02xIhk0oDjCpXNEf3D31cvxcRxtEAqrD0tLHOS/jDWGis20JZzUaJpy7U6RrEpGgyHnMaEwAbvbXdL97bcBrCppFKDHekI/Z1yotMlcpz21SrhQADd++ZK5fkIH/JPwQ8tS9c/3t5pGBR5wFPeZsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901857; c=relaxed/simple;
	bh=Y9H0GY6k4T9clxSJ4yaRMplKa33pAMEcbXdMFf6KU6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=QpBHhliawnK1X+roeq+LbdgiJDiOCyLSrsUQ9Vfr2CBV02LytfDyRNCPoniw4WzhI6u5trZQzF4SjrGREMYIir+G+E12FsGWjLkzMnjxoWh5+4CbaGa7BWCgBjUtRfaSx9l2kV56/nCPbrizixXbjI56378+2dmyuYjFM6QrjBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LWiDreqf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWiDreqf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779901855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1yn5UxI8QEgnLkFElBqvhz3nwZebD8rthNLyz5wiHFs=;
	b=LWiDreqfXJ+WrrjkKv66uDWkc0ukQO/JxKTyXAanR719adClrBI2n3xdZjFVQ94876x7Uf
	oQ7+9m8L7d+Ps488nGoSeAv9vQrsKO+Z9FyS3oodrJ/FeFNl97GE3aQK3H5qKbmPvcPTeT
	vSmy5vtPWyggF107e+MGP5g7ECzSbr4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-WKrWY8HnNc2enUPPC2s1mw-1; Wed, 27 May 2026 13:10:52 -0400
X-MC-Unique: WKrWY8HnNc2enUPPC2s1mw-1
X-Mimecast-MFC-AGG-ID: WKrWY8HnNc2enUPPC2s1mw_1779901851
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49043386b3fso53175525e9.3
        for <virtualization@lists.linux.dev>; Wed, 27 May 2026 10:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901851; x=1780506651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yn5UxI8QEgnLkFElBqvhz3nwZebD8rthNLyz5wiHFs=;
        b=D+ihMQ6r7idSFQPAEvkP/zJpqKQu1WZ2L4CKcirKubW7GHefRLGWWINWxl50zqEDj7
         1/dGBgq5GiYyVMnbq67Tneg6KYH7i2m9Tz6zjuu1OkQq1U6PMW3jQ6JHTbsiJlMzEr3q
         2Hw9LBHgIuH09opGNQkCnhwRdknNaPltDrrOUYMLKlKza/58zBMgVctQ1Z6iidVekQsa
         f+2lg6AB1peQ65ayy/xKvOjRXXJzOy8zTr6XN9UeEiVg0u9UWr3SMIilPwruKHt1pBd7
         TrghbGVaIHUP2ojZzERisX9VzcvWXzIDy/2Ns+WzO7x66UqWzeD3YHSmV3MxtWrqf2D5
         3FhQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Vrmhd3HnSbjmc2wKfVDEXOEfS/4HBiohr8rqk8YzgbdMDVIupX6ftWhnQDmRQohDlQCZ1CVC5DYRVkLmqGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDU2w9nC7nPcr6DkcrfvNnYyoZz4ykECyyGmgmW9mnZtInxYZ9
	u4mHQW4LjiFYRykVJxZx7U62ycFvmIVbBGaL4zLUgEmWsgPX7SwnkX3UWDD0G++PE3g1kM4OdOY
	t4ln8G0NAHmWK/VVhWTg6wZ2m6EaJlIUgAc9TM9d2j2577P+JZ3V1TsueUkzP0dZZ1TyA
X-Gm-Gg: Acq92OGJuLIkSqOhJLen0p+OX51fN9ONNy+EBH1jRZB9s5x1s2NabAkPvjLEecNr/Uv
	DxWlvX7R0REvRRpNhsAeW4TbbXeN1Luqp5F3/qd0svCYx7Q7NF4ei4IVEpwnAAUBMGZYYq16hqs
	Dvz6/lB+y2BSJTuklUiQd06xbycnZ5RB/3/bDUz3Zs/0IebRg+ToohrvSnLC+N9PNJPyYAtKFcR
	sfreESdPKyJJIxQfPtc5kcfXDzLJT+LrllsvXlPv6GRsrU08Lrb/2C09nGsbwbvTufRgphZEyKU
	b2DnA9Cx9Tq4Zka5RJBMDLZdb4dT6csnib+ip+dllYQM+7M1tGvqA6T+MlaLZ+GLK+akwZUt25S
	EdGFuHd8iWi74iiW8srRChB/HuQnXyal9AkBTH3q1owwMqk5qIxQCFTWQmA==
X-Received: by 2002:a05:600c:35c8:b0:48f:f7cc:f703 with SMTP id 5b1f17b1804b1-490428e2d58mr447180105e9.30.1779901851352;
        Wed, 27 May 2026 10:10:51 -0700 (PDT)
X-Received: by 2002:a05:600c:35c8:b0:48f:f7cc:f703 with SMTP id 5b1f17b1804b1-490428e2d58mr447179465e9.30.1779901850888;
        Wed, 27 May 2026 10:10:50 -0700 (PDT)
Received: from stex1 (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4908097a320sm30225605e9.3.2026.05.27.10.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:10:48 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH RESEND net] Revert "vsock/virtio: fix skb overhead overflow on 32-bit builds"
Date: Wed, 27 May 2026 19:10:46 +0200
Message-ID: <20260527171046.130211-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SnkkVtT0RlTJyk2BSf_JfZaQtOWLqqPLo9uBF_Fba3E_1779901851
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

This reverts commit 4157501b9a8f ("vsock/virtio: fix skb overhead
overflow on 32-bit builds"). The fix was semantically correct (although
it would have been better to use mul_u32_u32(), as David pointed out),
but in practice we are estimating the memory used to allocate the SKBs,
and this will never cause a 32-bit variable to overflow on a 32-bit
system, since the memory would have run out long before that. On 64-bit,
SKB_TRUESIZE() already evaluates to size_t, so the multiplication is
already in 64-bit arithmetic without the cast.

Let's revert this to avoid unnecessary 64-bit multiplies on the
per-packet receive path on 32-bit systems.

Reported-by: David Laight <david.laight.linux@gmail.com>
Closes: https://lore.kernel.org/netdev/20260523173557.5cc4f4f6@pumpkin
Suggested-by: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index b143290a311d..d4d26fba9e37 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -417,7 +417,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 					u32 len)
 {
-	u64 skb_overhead = ((u64)skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
+	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
 
 	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
 	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
-- 
2.54.0

