Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B123E6DC1
	for <virtualization@lists.linux.dev>; Mon, 18 May 2026 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095234; cv=none; b=YqrcJN+VoGOcrsDFKChJPb9uk3M8j7s393GI6bPGWa2K28+260xtULpdcVygg953aIxaub1xVs1kOdPgNtFcP1I89glifdag44X8IinZ3mPe7qmmuMvt0I/To1eQmpQY5iIgYOI10GuEN4Ge8X0qKDfil6dCGUkcQP2kExk8gGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095234; c=relaxed/simple;
	bh=eYAsyzlcZhIaTkBbynj1OR7+7bApP1e2I2Pa+c+c3J8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=goimYgmpMfqhBh2MAFNKERIcJhSy0Yd6CH5UF7DFk2BSFpKLNGDqItUNBl+78VH93IEJJM+Ju9+DTqMxobMPX+FAxUGOYHgrAOs+v2pUQE02RhMUMaaa78MIbArXj9T1Wl3ZHKzb6PecY3nqgmkH3/asy0kWczzgyOe2Smq3kbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PGBV+CCt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGBV+CCt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779095231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dsBo8SZnL+tIoKyB10yuoDT3WWwlz7J8lfIk8OOzpIc=;
	b=PGBV+CCtbWuVwgRgZ62ha2ndaSj0IpMje4AcvGOZY0172oUWU9Y3Ej2tx+LvF/l0lGxWkJ
	ZeEkCozLDZC5n2lmw37jM4+bUcXJblTiCazbKZkgGmKUwK8At9GtUXqf/2xsgokDoVSa8q
	AfD5JIi+m3SKR8pApnzy1pOGUFOCorY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-Ibbbe7_WMoGml46wuAo7zQ-1; Mon, 18 May 2026 05:07:10 -0400
X-MC-Unique: Ibbbe7_WMoGml46wuAo7zQ-1
X-Mimecast-MFC-AGG-ID: Ibbbe7_WMoGml46wuAo7zQ_1779095229
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44f56d5523eso2302329f8f.1
        for <virtualization@lists.linux.dev>; Mon, 18 May 2026 02:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095228; x=1779700028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dsBo8SZnL+tIoKyB10yuoDT3WWwlz7J8lfIk8OOzpIc=;
        b=KMCDcgQFHF1MIQRSGEEpeEwlLEg5e+pzRbT0Egjyzk+Dy+iMHAN+Up/9Rz3Rl8gXfd
         kxc8ZHjQg/67RmK+vx8pgkZE+7h1H/xTWXflE5WPmmIeRYCQ1mUQuycPaUWabxZpm4yy
         npRcabvVfGjht5JzvqB7QF6wOC4wGbWwR5kO9qEAwb6gKuKWZbopTGkK1SBsmSwuq/lO
         JCtB9N0YqNUJYrrwADpvcLMBl3fG4/RQehtR3CVXwDAi/cCD5jkFubjThRdjpH3yasX3
         dLyxUbvv+RTVbI7dTzgUyuCz/Luy0iDWm3p6jBf3oBE4gN0kpZ8gEoclM8r09Ym29/6L
         jAvQ==
X-Forwarded-Encrypted: i=1; AFNElJ95lzaFrKEGPmSBmgL7xEvb+Kf7uQOgsZZFg+r0jeRzs8fDJSXNfslWumXN7Wf0iEt2NEcnpicvG12Pkecs9g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVjfy7Z2AR56xVtUu5LvH6P0UP3uBXxQLHJIr0guer/dGzpQZV
	ea02tgLPNr3JzRh4yEyWplW0QdnDbHDW2nokH7FW1VSYWCxWK+vOQL8XfnXcMNVikcadtsMzN0P
	165VGmeDe7LPXyxIcpQqpJWOwcLU07b5Ln27B6P1JAVYZC8q/v7gKz3U018FfNwyjoXob4mNzQS
	Mc
X-Gm-Gg: Acq92OHJOZeJ77M2J8t7eMo/QlgHvQOHB2y0lEJea0QvFkq7GOmdNpk5gw9Y4Fojl4d
	r/g1aZJHN2Be63q7bnQrLHx+GhC5dJk5hD8d7oEmimuji1R0vbrnNGuqat4VpepGeid1+a19knA
	d0X+BGQ+K6bnOsJF0KhHoqv+UuCfa5zT7clZPGA5+c7pJsVl4Zpc80APU1sleOLOFZo564FVTrp
	G9nBYNI0FkUbuvmc50/MxZFwye8JYB+B1aD+J3Z8D66alYQS/cx1xC0S28IjmcTJN4HM96i124E
	zTyyVn0FOSOb13brJ6QwPbE/xWAeKp0lMZbDmOX18tzvjkGDh1qQYae91SE/CQF55VrCSJ1ewOr
	E84xHiFiTb56ArbF2PslQAH7b8wdHpqEhLFTezABP5Y4bGEr5J/dUaFUmzfhNH5pjpfQAKmk=
X-Received: by 2002:adf:e681:0:b0:45e:633e:a7cc with SMTP id ffacd0b85a97d-45e633eb4e9mr14807934f8f.24.1779095228406;
        Mon, 18 May 2026 02:07:08 -0700 (PDT)
X-Received: by 2002:adf:e681:0:b0:45e:633e:a7cc with SMTP id ffacd0b85a97d-45e633eb4e9mr14807870f8f.24.1779095227874;
        Mon, 18 May 2026 02:07:07 -0700 (PDT)
Received: from stex1 (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768072sm35104134f8f.5.2026.05.18.02.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:07:07 -0700 (PDT)
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
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH net v4 2/2] vsock/virtio: fix skb overhead accounting to preserve full buf_alloc
Date: Mon, 18 May 2026 11:06:56 +0200
Message-ID: <20260518090656.134588-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518090656.134588-1-sgarzare@redhat.com>
References: <20260518090656.134588-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UOfB5TJ7_ZrnRdxCdavmUcL00pAJJDmhmdey1Nfp1Uw_1779095229
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

Fix by allowing at most `buf_alloc * 2` as the total budget for payload
plus skb overhead in virtio_transport_inc_rx_pkt(), similar to how
SO_RCVBUF is doubled to reserve space for sk_buff metadata.
This preserves the full buf_alloc for payload under normal operation,
while still bounding the skb queue growth.

With this patch, all tests in tools/testing/vsock/vsock_test.c are
now passing again.

Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
Cc: stable@vger.kernel.org
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 5028ff534888..df3b418e0392 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -419,7 +419,14 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 {
 	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
 
-	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
+	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
+	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
+	 * metadata. Check payload against buf_alloc to be sure the other
+	 * peer is respecting the credit, and sk_buff overhead to bound
+	 * queue growth.
+	 */
+	if ((u64)vvs->buf_used + len > vvs->buf_alloc ||
+	    skb_overhead > vvs->buf_alloc)
 		return false;
 
 	vvs->rx_bytes += len;
-- 
2.54.0

