Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD2217B506
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778854952; cv=none; b=rn0xiOrKoauFQzfuTIAxVRIn7Q1icPU0xsVYMfNB9AwMWBPZEwf8ti0LCymnFaPDlaPOOg1eGH6ZBsmOTsxof4hfT52MgKUhb7HR8t1Gu3HSbUsjtGl0CckVaAJOZ/Un0vc57AxYf5WV3KAqhJbyhziemCKERUg/Ar4R7ZhvwIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778854952; c=relaxed/simple;
	bh=4tkmWdr6khBnvueIXG5owwtPoJDfRf7F71EXLOezePQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UYMbJqiPmVkRUBZBR55Z7MEVQp7bp0Mb6iYygyzwxTQ7x+fkfTj7HEc+pgOKtOvJkf4ouIawBs7KOdzuXLW8KiOHcz/eKhv2yqEiKx1wAI5QfhHK4wpqzj3GJ5fLy0eiQTf2FbZ81/YvLcTAMk+OyduSS+3A4gEYn/vsBRj+zA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ACTbTN/j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ACTbTN/j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778854950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Sk8Y35SRjUOXJt7VGjNApwhzLk5NuWjeB/6xvK4VHMg=;
	b=ACTbTN/jkNeLk6sxajo+u8DJ9XKbZjY1972Opwdo96tfdmqe3hJuHxFAPmelS6BIYpj+wr
	0mNoGBtMUh8Q3NBuINzX8M1T9YCgNS66nu5iYJWr9JVP3X+uHVU6qSGDv+fOtDhC/i+d8T
	qA5LV8m2KtaN98dQX2FQ0+jjp3KQvKc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-WPycJTaiOomU7AkYlgzY8w-1; Fri, 15 May 2026 10:22:28 -0400
X-MC-Unique: WPycJTaiOomU7AkYlgzY8w-1
X-Mimecast-MFC-AGG-ID: WPycJTaiOomU7AkYlgzY8w_1778854948
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8badccc9194so149284716d6.1
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 07:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778854948; x=1779459748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sk8Y35SRjUOXJt7VGjNApwhzLk5NuWjeB/6xvK4VHMg=;
        b=UhMDL62EpU4lOMalH6FJ/xMYz2nJXO4mDxbrN0pGqCudYokn4h8hHQF4m488QN1CRg
         kd5wxLLnUJk84hAiRlND5PDIfJJcAyIdEFvZa8o1NlLGE/N5S5eeorMY+8VMK71GMX7K
         Sc760DkWMFmMhWi8w21ViSKXPP7I9Q538LO5ZCy9SDVUrp+EFHgMUdU5Yj12AelSyVCS
         wyQX+80yrisEq1ztzTdNx3BxNNihanO1WhjljEBQ4pN2qWbkrar4MkCChWG18sSDHT05
         G3n9YTttwqnobWPRLWoiYfnsf2SPjAMnkS3MECPOCwIfae0myf/p8IrgFHZ46jr55QZ5
         qxTQ==
X-Forwarded-Encrypted: i=1; AFNElJ/aVfEMHyMQimKwJ1U4z6PVCC4v7qzsijIark5x+RetgBy7GGm2NKJyCwIHbRuypS2EbxKCB7pIte6vjAsqbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzug/+aVWtjWFOiaAlqWP7W1XXx6cTU5ep9nQZG+59xvGMRbz3u
	oJM0YhSfQmWeQCu4ADteIOXCHDOIhM3C12skpIktZx7ABGbDb6I62K6LbqKPYOzbFKc2T+Je82/
	r8zq1UTqBiJEUsv2LlmMbMVmlCMgGR18jyKSjIC9NILM8d9ggIwElHVtFBT0uw9RnKfEz
X-Gm-Gg: Acq92OGm2EBKNfdoFQ6oALxVnJjaM1bkrTKQ4PCnYkj0REfBu5kJYjxvQjo6RbxKOVY
	lw68qh2/oKEtEvsZ/pMDcTVUk7H4bx8o0+ij3LG92GvyPgN4XhzuuNOO+rl75WBxSTMwrPdimIk
	EsWC/kBxLWdiZiHGS70uIO2Cr066gv0olk+jEFeXtR9dIZdX83C0l2uutrRIPLDepJ8ZczisryS
	9+6lV9SQfWLKlfR86SlXDYb1vVB2CubgzhtO9KaJ7ib42aa/Ag9o2qu0D5uLkZpY3JWYrfq1Ut+
	c3pOqUYho62QXb5sIiJeUmYhtLT3wywWhfbrNjG+lmx+B3Jd6EjIzl5RSChFuUrD2dZIf/aGz80
	9Lq5+VvIPhBLNgTa5Feb61KC08GpF4snIr7a9/79MQHmRN8wWb8GgB97a8qartwwnEnUNCq2qTA
	hB/30hOqLUob5vfDywcIOng6iUeuQ=
X-Received: by 2002:a0c:fe0f:0:b0:89c:bcbd:c26e with SMTP id 6a1803df08f44-8ca0f6893b0mr53899896d6.25.1778854947824;
        Fri, 15 May 2026 07:22:27 -0700 (PDT)
X-Received: by 2002:a0c:fe0f:0:b0:89c:bcbd:c26e with SMTP id 6a1803df08f44-8ca0f6893b0mr53899356d6.25.1778854947274;
        Fri, 15 May 2026 07:22:27 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90c358539sm53014106d6.41.2026.05.15.07.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:22:27 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
To: stable@vger.kernel.org
Cc: Luigi Leonardi <leonardi@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH] vsock/virtio: fix potential unbounded skb queue
Date: Fri, 15 May 2026 16:22:12 +0200
Message-ID: <20260515-dumazet-v1-1-73468c902889@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Change-ID: 20260515-dumazet-07c0c855a9e2
X-Mailer: b4 0.14.3
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TcxplgPMfdf0TNpbXgK4v2D3a4oI3-R628CzrpswinE_1778854948
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

Upstream commit 059b7dbd20a6f0c539a45ddff1573cb8946685b5

virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.

virtio_transport_recv_enqueue() skips coalescing for packets
with VIRTIO_VSOCK_SEQ_EOM.

If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
a very large number of packets can be queued
because vvs->rx_bytes stays at 0.

Fix this by estimating the skb metadata size:

	(Number of skbs in the queue) * SKB_TRUESIZE(0)

Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Eugenio Pérez <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev
Link: https://patch.msgid.link/20260430122653.554058-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[LL: Fixed conflict since this tree does not use buf_used added by commit
 45ca7e9f0730 ("vsock/virtio: fix `rx_bytes` accounting for stream sockets")]
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 4c374c36c29d..86e3051d000e 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -283,7 +283,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 					u32 len)
 {
-	if (vvs->rx_bytes + len > vvs->buf_alloc)
+	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
+
+	if (skb_overhead + vvs->rx_bytes + len > vvs->buf_alloc)
 		return false;

 	vvs->rx_bytes += len;

---
base-commit: 3b9f64db049687c0d38b4b3ef2f297f0642179af
change-id: 20260515-dumazet-07c0c855a9e2

Best regards,
--
Luigi Leonardi <leonardi@redhat.com>

