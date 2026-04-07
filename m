Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A3B3921C2
	for <virtualization@lists.linux.dev>; Tue,  7 Apr 2026 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553249; cv=none; b=b+GJxgET/b4gO/gTo7hqdVmmSkpq8nhqsq/LqNmNpky1+SXZuJWY+BQd/WJdGElGwczBxTaKEQiPTQb41EFbGMeI6m9RH0FEDIcClATogZne7oWqvxeVXXI04xO6BRu9eFXetAo0/2kPY9kc33j9SwxZsRLCoQBfR068aZb26cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553249; c=relaxed/simple;
	bh=gb7Ruua+gJ5a6hrcK6PHPahbGnBvVqCiLHNSA4MS8gc=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=LwlKGo4UWxuRT0oJ7+R8kewFCtMFz0utv6CqzDxvRwK7A7vumaQXLeQDPfST/euZS5VOB6kj2NFzXbNi2hlbZNWbBLPXKkbD3EOAeZQJgOw8HNKGAwRVYbqCrm1zEOVrgsjQVtHkZ6wPNK87cjx2L10K9MCOoytUoDWU850ZCgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fBwB2OQw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBwB2OQw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775553247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nou53lLTv7UEsO0o7KVxM0MjcDicbnJfC8/ClZPwZgg=;
	b=fBwB2OQwD24GySjbgVVskwCX61TtdBJDp2hhCUu2nwfBpWzO+9/N00mWlKU8ovSoFFy8ga
	oWMge3Q7bw14DaW0aozI6wSzWf/tFuyK4C98cADQeJqkK/MVFxp3SUjy7bnJtWt0KDcKfj
	PE6CFeTMy160hfzddoXPN0Ke0J6InKs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359---6YDTSlPK2gL1qw5jhE8A-1; Tue, 07 Apr 2026 05:14:04 -0400
X-MC-Unique: --6YDTSlPK2gL1qw5jhE8A-1
X-Mimecast-MFC-AGG-ID: --6YDTSlPK2gL1qw5jhE8A_1775553243
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488ba2f4094so4649055e9.1
        for <virtualization@lists.linux.dev>; Tue, 07 Apr 2026 02:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775553243; x=1776158043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nou53lLTv7UEsO0o7KVxM0MjcDicbnJfC8/ClZPwZgg=;
        b=hdeTYojlASp3y8t0nJHFNuUFvczdrqTdTI6p1a3xU57vrDaVqCvGD+MIT4UVP4YcYt
         Rw7JETwO0tNYaTwre0l5Kj0fDxeS1XDDSmoo9KrKzMYUPYgGDlZBJw2Y0xu4QIFhkdzE
         pT0NLbD1r34oQNbMPBPYshBoEQ3/qHdkPjr5VECFC+QKon1HkpsFE5UpENaC8Ce1M/pD
         TMvwBNB1d+ZjaNeqCjOmI1Hr17uwF+lOs+pOcEzonP+FadWfUh5XD0vf9SqzA5gDDSPz
         nU/hIJO73j7V8U70jukajJ7X3Nf5KKYkCs3GGcxkRAK/1VID8j2adda0q6BhHTLmFf1D
         PzcA==
X-Forwarded-Encrypted: i=1; AJvYcCVZRk7gPQ2EQAdRMHFFaXsOf0c+c+1ivQ7yiCuQOqXIBfIOp10V2IqRI3chrbNaGFbXhiw2ZhCi8Bs6Yqckeg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxOlT0i8kCc7X9GOzSM9NSQpEUeybMKBGqsuvdxEDBDrR4VrnI
	ly2/Vnna0qPo0vRt15Co//ZyWNXb+JywKnIY8sti4s8rFBKspdMIE1zGVq6TosG8wZBTTZU2hfh
	j+oBtLR7Mwqej9qH7J3S3z/szXU9Fg2/xod5ZL2JpGweJ01xQz1YzigBCZZlGj49OsOMj
X-Gm-Gg: AeBDieuUx7USShGXE3lZyvAtjR9BLL+NBzYJTFdo5bjVYSfYHB3Uuo4kEezyo35CgFn
	c6FTZhteQbbYsauf0DRpjcwmNVkBgcYMKYMCdx8Foc5pPJgEw7Bvyjd3jGMYkSnFZ82MTegHygY
	O1je/w+ODSnCoX4nwIyfqDu1tpa77YTJ8DXeDM3RpOZReFCZ9dCzOPovyU0QGeGPL2XBJbhxkCN
	AIFEBwKn3Sxyq6ScUAh0oLAA9TtO28Arce46eY92FhPd3yx9ZLRUx9uDIu5ePqD0ohAgU7yxZbl
	CljJ2jN6xxdHRkyFvHQcumyecQBFBOy1V5fV2yVaFOBgzC7hvlEnNSj1k+fFYGsH23esXtNikUc
	lgmDYuZgjMvKquxEjzCcz0k3AX7dtjEb1zdLWBcG14RKu9xJyMFMV/34NKp6/
X-Received: by 2002:a05:600c:8216:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-488ac017468mr111080395e9.21.1775553242818;
        Tue, 07 Apr 2026 02:14:02 -0700 (PDT)
X-Received: by 2002:a05:600c:8216:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-488ac017468mr111079805e9.21.1775553242317;
        Tue, 07 Apr 2026 02:14:02 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48895e19c10sm342892015e9.8.2026.04.07.02.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 02:14:01 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 07 Apr 2026 11:13:55 +0200
Subject: [PATCH net v2 1/3] vsock/virtio: fix MSG_PEEK ignoring skb offset
 when calculating bytes to copy
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20260407-fix_peek-v2-1-2e2581dc8b7c@redhat.com>
References: <20260407-fix_peek-v2-0-2e2581dc8b7c@redhat.com>
In-Reply-To: <20260407-fix_peek-v2-0-2e2581dc8b7c@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1bcAXr0t89E9OVWFbqDM0OnZDme65rV39_TfA2SNz2U_1775553243
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

`virtio_transport_stream_do_peek()` does not account for the skb offset
when computing the number of bytes to copy.

This means that, after a partial recv() that advances the offset, a peek
requesting more bytes than are available in the sk_buff causes
`skb_copy_datagram_iter()` to go past the valid payload, resulting in
a -EFAULT.

The dequeue path already handles this correctly.
Apply the same logic to the peek path.

Fixes: 0df7cd3c13e4 ("vsock/virtio/vhost: read data from non-linear skb")
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 net/vmw_vsock/virtio_transport_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 8a9fb23c6e85..4b65bfe5d875 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -547,9 +547,8 @@ virtio_transport_stream_do_peek(struct vsock_sock *vsk,
 	skb_queue_walk(&vvs->rx_queue, skb) {
 		size_t bytes;
 
-		bytes = len - total;
-		if (bytes > skb->len)
-			bytes = skb->len;
+		bytes = min_t(size_t, len - total,
+			      skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset);
 
 		spin_unlock_bh(&vvs->rx_lock);
 

-- 
2.53.0

