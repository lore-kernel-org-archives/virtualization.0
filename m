Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C56C3D47AD
	for <virtualization@lists.linux.dev>; Wed, 13 May 2026 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669676; cv=none; b=bO9GwWIlBebnt45hjkcswShzT4mzjtlsx9cHHxsZ3yjkhxWe92aI1/NPPh1XzPgefUuLnwFPLAswEQ8jhAypuhsE/VYzGI1VyCREerWvp1nHP5SJXWIpiBcKRr4FB+nxP+ZN+oQ9ejAb5/Vaa3X7R9rjoBI41REsKMUDX+qcKlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669676; c=relaxed/simple;
	bh=IvdEZvwln3zcfx+cvlKQindvsy3EmR5EckwkcdVQXFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=KSMajMMOZyCBxK7U39MMxfRVoBTDv1emjd5WZpd7UgKwELO/yy4x6eQy2mRoVORlGTgorHJFWC2KlQvx1KBmzjjf1Ar5C43uh0Nm31kCL0Gzz3gIdHoF74N+rxM9y01TSyLINDgKdjMA0IA/4a++E+G4j8kDnHblCjqVFvXLuVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UqjB6YyE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UqjB6YyE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778669673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aGSDbvLykcv2buTIXBcK0yd8xK4cY9P0ZJuiRfh0cTI=;
	b=UqjB6YyEyWGXOW/u+3o3be+wcCiGqpALlp09kry46qo//Iw+vbiWJS3Ot9Md1q9GoeTcxh
	zAliSS2oRB0JUHJnqJxol6eIH7+8NwO7GIPZYRPePhrx0wzZEbsKv+0Itvto+l9YTbgwnz
	8+XTFjh5pKcAVpwu8J+EhisqSdtEK9M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-dncU1UDaPe6p03VYSb8aww-1; Wed, 13 May 2026 06:54:32 -0400
X-MC-Unique: dncU1UDaPe6p03VYSb8aww-1
X-Mimecast-MFC-AGG-ID: dncU1UDaPe6p03VYSb8aww_1778669671
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43efc93e4f6so4344392f8f.3
        for <virtualization@lists.linux.dev>; Wed, 13 May 2026 03:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778669671; x=1779274471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aGSDbvLykcv2buTIXBcK0yd8xK4cY9P0ZJuiRfh0cTI=;
        b=fyG3zyjdgDz7iAmnynQVLKtExqCM+xJSK3Imk1S0p1dKeaaUVa8IpmyzyDLuw4y9b2
         PQi02X5R8RbDRLXnxBUD8sf8Dq7hFDEBKqXTPGhh9KSz3r7s2RT/18HmhoXYNv+wNYr7
         OElcSuae+Egt9goo/+Im9LIachpQjoZe7BvlVe94poNcrx0DlWoWVchcHoUnHlB8/Vnx
         p04I9h7x3Hm+iF5k9Dwu7a3/TYvrKsK9C/5TwKamSPfYSrEodcHfFRmDKlb5N6pWJ7V0
         OUYzhNz/CFueHeImctkKTiaN6CpUru4v+Oock8/0aogkv/seRluAqOnnXzjERfuBmjT0
         L6aQ==
X-Forwarded-Encrypted: i=1; AFNElJ+H7TDAmL/EVGWF5wijOhywDcqi3ss0YFMDlzy+JOXT4+o8djKE4CApSNYAgblOiGwTTak/oyrx72JlsaRshw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9b2xERaaJgl16MRrGj+XBo9/G/6KIT0PgKMQ7Q4xxQ+pw3Pir
	rRR7HWk3Tl8w5tZb0xX+fjj48IWTWj5R0zPvouR1lAVB91/WMf6vIO7IAD7mVieRPrBhvhP6nen
	SQuwmRBAtw70oSV2OIxaKq/BPi5ySKeNpQXqboLXKef0Ucmjayh59h0Enawymt93VKFfz
X-Gm-Gg: Acq92OE9CRe4oe4cNJsgC5QKhEmJrJoif2NgPgp1X+wp84dp/poxTM26TNXqj1vXEAZ
	QKgPxy3chAW8ecDv4HGGfk4O84zlrLwRRrJcYP73I399A/rczfbFxlC4UhaFZdPlIR+J0QTb9DV
	2IyUx7SiNM+EeiPC/CjpyT3DB0pDBuAK0kL+O/hlLa0vDbT8TSnA6v0++hgRRMTeAX40Elt8402
	mvgWDIVT+szooE1u091aNpwjlq6t+QOYBiWjwaLc8qjwqVJUT9B+aZyw+zk/opiPHyNvVuI2HR0
	0XubUhiW8yckMmr6N7RjJ/fgAYnhF2ZqDuvF81LmrdeJckkPQBQRUcfrfGGI0yQ36+ATj/T1GU2
	rE0PPp22hgVC8XUlyAb2eyq2sfcOfx+tTt0OA68jDdQ8HRu3afzSsM92EacbD
X-Received: by 2002:a5d:64c7:0:b0:43d:68ad:3b7f with SMTP id ffacd0b85a97d-45c59228b05mr4395334f8f.21.1778669670771;
        Wed, 13 May 2026 03:54:30 -0700 (PDT)
X-Received: by 2002:a5d:64c7:0:b0:43d:68ad:3b7f with SMTP id ffacd0b85a97d-45c59228b05mr4395279f8f.21.1778669670260;
        Wed, 13 May 2026 03:54:30 -0700 (PDT)
Received: from stex1 (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454917d57aesm40237869f8f.26.2026.05.13.03.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 03:54:29 -0700 (PDT)
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
Subject: [PATCH net v3 2/2] vsock/virtio: fix skb overhead accounting to preserve full buf_alloc
Date: Wed, 13 May 2026 12:54:17 +0200
Message-ID: <20260513105417.56761-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513105417.56761-1-sgarzare@redhat.com>
References: <20260513105417.56761-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: f7nw5TIkyDsx2CgFaOPK4fP3WT7LMKVgjDZehN20za0_1778669671
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
buf_alloc when checking whether a new packet fits. This reduces the
effective receive buffer below what the user configured via
SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
silently dropped and applications that rely on the full buffer size
to deadlock.

Also, the reduced space is not communicated to the remote peer, so
its credit calculation accounts more credit than the receiver will
actually accept, causing data loss (there is no retransmission).

With this approach we currently have failures in
tools/testing/vsock/vsock_test.c. Test 18 sometimes fails, while
test 22 always fails in this way:
    18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch

    22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
    Resource temporarily unavailable

Fix this by using `buf_alloc * 2` as the total budget for payload plus
skb overhead in virtio_transport_inc_rx_pkt(), similar to how SO_RCVBUF
is doubled to reserve space for sk_buff metadata. This preserves the
full buf_alloc for payload under normal operation, while still bounding
the skb queue growth.

With this patch, all tests in tools/testing/vsock/vsock_test.c are
now passing again.

Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 4a4ac69d1ad1..e22117bf5dcd 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -434,7 +434,10 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 {
 	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
 
-	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
+	/* Use buf_alloc * 2 as total budget (payload + overhead), similar to
+	 * how SO_RCVBUF is doubled to reserve space for sk_buff metadata.
+	 */
+	if (skb_overhead + vvs->buf_used + len > (u64)vvs->buf_alloc * 2)
 		return false;
 
 	vvs->rx_bytes += len;
-- 
2.54.0

