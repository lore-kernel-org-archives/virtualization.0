Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B80729B78E
	for <virtualization@lists.linux.dev>; Tue,  5 Aug 2025 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430564; cv=none; b=rl/adVA+GE8rq8SEvXQYVU3AZKkjy9Kxjoo72ak/fN6a9ydNytbJhpvE5oQZdyImMt9Skj10V55Pp/4jz7inG/99zIzsRrn3cQe5/321qdKsnReNMf9TUMVGDvJ31eqV2I96C63J14E1cB0hPr8rhpuWVWCG85Bp+/s5R1HDW/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430564; c=relaxed/simple;
	bh=iVkInzQ7uHzZMQZ7UxyeGw74/8iMWFmqHrGNUTfOeag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cVQrABHy6H1EngTGT7xSNPQsxMyfxgSf27TC2/Xc0KN5l7bWenhbqqpAjA1MPYQwbdXVzm9c4CYrMEljIvp4KPMBenxGstxZYJv/YFusmyYy+BJ9HO3OVLidTfLsH7TZF3v3SLC/QawW9CM/fqbnrP9fqVaypUoJneEqd1rcw7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTbPVpAI; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTbPVpAI"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31eb75f4ce1so5413749a91.3
        for <virtualization@lists.linux.dev>; Tue, 05 Aug 2025 14:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754430562; x=1755035362; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sm0/fMgK4tErQjYzZdv4phel9XrBq2Yycw99jmqjet8=;
        b=QTbPVpAIJU7nSjk+KNPIqKgK4QVyBDNSsay31L8FyEZykvMd4pv75HuogAHv91dJL+
         mgKm56nVyOJZGzD9Oi0IwxuQZv16r/uDyIHeKLnAVwlCFCgq3VkZwrQluuxQanxYko/F
         ry9BzBHcpYeDqVHKOmmdQYyTYRnKhFEI/09o2rTGXWF0obztTr6RtVvFWtdNW/m4dPCY
         0uEIOjZwWIeQQQWAbz69nNlsaEWY8i7+VHqL+d5cKzgNSfQQYELBLBo9B+07XwpKlS2K
         XbzwoF5qwDrFq1HFX+tPWKWV1z56Rjo16Y8/1Ky8upboAFIwPhG9+V/MGSRFui71c1X8
         CpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754430562; x=1755035362;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sm0/fMgK4tErQjYzZdv4phel9XrBq2Yycw99jmqjet8=;
        b=iIjjGtkL53JgFe2BSjbtXg3ZHYiiKyd1zihdFB9Xgjmk81r4QaXpmhrLPch+iiQala
         3JGfNX0LusvzCvyt5TjCvSzjJnBGqb5OoapeD3W3P8r/1PIuBDNcWDfXr9tdGdByG8Md
         iz+lYOC5KuLB8z9wRvNq+H2DIOjLU38uVzsW7GWOe9f+3F6cqzgtR44yPPdEPPP1CbMo
         3ShCsxAlLlqeAzPMzkwJlwvSOQHtDTqcVfmPIaJaIG/sZXUpJP5WuzVi87i8TXLL2+Rc
         GhRWIhj7EAtRa9tDiw3RNC5D1adueKVFY21zotI/yIpa0lWus/PtfLJqQ8PTDVI9vWxm
         rFSQ==
X-Gm-Message-State: AOJu0YzLTjmiHVbtX61zJcSCm33Q3tnzhyij0pYv7FgFzokF4rF4/50L
	tGSiUp8Dx1i3tDtQG0EiK1ac/fJYgfj2q9igZIYl/EIzbbaKG8vDcD5C
X-Gm-Gg: ASbGncu6h8Haf90UGMNHVOqpTO9GfWL34+PAx5hOq/O5W2qibTi8LcZzPdpl0edH/9m
	V3PZrW4xglxV8SAEH+MGYBY1g6rwPrK9hk+sHrTtoA0CVRvSdJIHyFIid62+tfvS87py2y3UQiI
	qwqz7djSI0n6tr5d0T484I/KByTZLpoa1Y3G9HI/4FqZrfgXZsO4B2p8uNlRw+PCXuKyZnyPquQ
	AgQtFQxOnGnB9lZU1GVN2t7mkY6L7XxF6f4Q6YN80/p+/lRI95SR8vd2amKsJr7P2DBIEpHu3hU
	6w/TC/EBOwXr9yraGoOgvj0QWFpi9pLtpP8rTpEpVpREbsPs0+R2iGSaPX2UDHTEfGomlVnNVKs
	t+wtD93z0HjmOMdePjcHO
X-Google-Smtp-Source: AGHT+IEkvDIFK5HkjsCOvoxAuFgibsDf9KbOCOhnG1IK5JHA4oFThHnwoGQ5xLGBLKlnGLxewHy3vQ==
X-Received: by 2002:a17:90b:2783:b0:311:c93b:3ca2 with SMTP id 98e67ed59e1d1-32166c1e68amr448003a91.6.1754430562315;
        Tue, 05 Aug 2025 14:49:22 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32161198f17sm1051118a91.17.2025.08.05.14.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 14:49:21 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 05 Aug 2025 14:49:14 -0700
Subject: [PATCH RFC net-next v4 06/12] vsock/virtio: use the global netns
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-vsock-vmtest-v4-6-059ec51ab111@meta.com>
References: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
In-Reply-To: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

This changes virtio-vsock to always use the global netns dummy so that
all guest vsock continues to operate in global mode. The guest vsock
behavior is unchanged.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/vmw_vsock/virtio_transport.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index f0e48e6911fc..25c1bca7b136 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -536,7 +536,7 @@ static bool virtio_transport_msgzerocopy_allow(void)
 	return true;
 }
 
-static bool virtio_transport_seqpacket_allow(u32 remote_cid);
+static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid);
 
 static struct virtio_transport virtio_transport = {
 	.transport = {
@@ -593,7 +593,7 @@ static struct virtio_transport virtio_transport = {
 	.can_msgzerocopy = virtio_transport_can_msgzerocopy,
 };
 
-static bool virtio_transport_seqpacket_allow(u32 remote_cid)
+static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 {
 	struct virtio_vsock *vsock;
 	bool seqpacket_allow;
@@ -649,6 +649,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			}
 
 			virtio_vsock_skb_rx_put(skb);
+			virtio_vsock_skb_set_net(skb, vsock_global_net());
 			virtio_transport_deliver_tap_pkt(skb);
 			virtio_transport_recv_pkt(&virtio_transport, skb);
 		}

-- 
2.47.3

