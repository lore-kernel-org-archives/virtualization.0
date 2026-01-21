Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A20F426688
	for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 22:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033530; cv=none; b=O/cYVrQMKjprYB2iyDPOGqfkHIre0KVC1nOVsoOHZHt0MG4e3ts1puH3ZIGxK52HgNHiARNsW61qmzhbNx/Rv6b7VoGgWIMlBeUVkwsukHrBryBrsposnqbDgnejEtdInXuWmas5XoQFNSNXi6kTTDYSSrT67Iemn25MjnuMuLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033530; c=relaxed/simple;
	bh=vD964Lj1wPSOw/16ssWykcRPX0KDwrhlz4wvw7+NTyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ri8WvnpiKPBEErcmqTVQwWhWTTnPl4Y+yDPiO6J/AbjtlFReag49bx57FEk6G9pNH4oU6V6gW6MfSrXeeWx/5fexDnd5wHCqBA8GuriqyKDeqZhEjUtU5XCArmqOUaZFQ8cZhkq9Q4apQWqvlrQI9BjvEFlOHP4TQfcOU6dIFq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3NMvTwJ; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3NMvTwJ"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-794279c3b00so3512627b3.1
        for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 14:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769033521; x=1769638321; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0yb8kb1LkqAc5YpKYa8ha5gJygHDPK65XDs8oEX3qw=;
        b=H3NMvTwJHCUYA1xBQakwegOJkSesqWmvV9DDzKW7E0J0vZGltI9OXxEP07e8SWsfRW
         RE9RIfND0rsty/S7YdfWXnU1raK30WlBbLqhVqP8rSQcuD3LK1DwUplPMoPoLdigv8bD
         xnPgOB4dCjTnVDW/kJxWkfIhHbx0q6Krm22O1nkzTeP+mztM0C8Ibccrae98lqeKmpbP
         /JeaD2N4LQy+Ml5PCheO3FQ4U8FWnlFrw+wGbWJT2y4icsmx7aRPrXtwd2X3MD0bW4z6
         NQf5B6fqJ0NnFyn666y+Qq2j0ad3EuH0acILAB2GgLzfd/5WU6tCeDUl9D6NJyglDUpD
         TTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769033521; x=1769638321;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N0yb8kb1LkqAc5YpKYa8ha5gJygHDPK65XDs8oEX3qw=;
        b=m4hFo+cCdHW9h83fZJ77KeDSI7gy4pkn+NU+iDAkrWH9VxOJ1WUNQmhSPfgAJB6PrL
         WxyaCEmkr7vLeXBFq1ItvimUuNDVPSi4DscRLhX73UQuGZACUXcR8MXIps7jRA/c6obv
         OsoCNtnexhZe2QIquJ4oUFCVojBHsBjnk+/eKEjxWbKrnNu1dSltdXkIy7o7LKfEVNJY
         ysHZOf2CyYQckwv3KzDfen1zBVe7zOKbGisXXJwHNO0MJ18dNo6TE82Xv/lqIbVnpPhn
         YiVWN1C3vYsnPXghWuLKuhyLFhvxJtJrxnCrKIrRjCalA2gZDnLYBUlCCoUn3kEgazT7
         FX0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZHG8Yumqy1tugmBRd2pcn5nDlPknOzOWUtJKvXm/4F54M6qFmQkGVjG1wnQ0sQ+MQ+mhF4IvEF7q0ZA2+iw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+Sx2+7qoP2tHj1YjDpu7bOK8voTGTJlIb4ztwtno1YOULbZ1N
	mV/kxc19CBfKoqQb55O9O5p5hPEJUPku6DCPnEUi6+2QnilH9nyPyRGY
X-Gm-Gg: AZuq6aLO8v1DxZXn5xlcYE95/71LljWmesruh7O9by++fxeW5cdRgPS7EnD+ddQXyQJ
	n+tdwfgUOOrvgnkI9gPfCmIKqQRZlXAHwFG3HkMDuBv1nwfN1rZOvjxqgODCwFNTlzu5TRN0odz
	QEs9qXUn9iaa6LBRuW+zquN8bMXZ4zOOS0ANdOOgP1huFEnkZiYXvFK8aD1SyAyuh8G0ck+fwBA
	mkU0BygiOMauXE6Qppyc95iGcq1IvmEfqKU22EcKWOhIILDuVFHYnjV8ubs6iDP1AXIVdYK74Cc
	hyoHHF2gnxjplCa5hO73VDS/RcMyJb/HiY+wqKB7JIb8tU19CMdGA2SvaVzGcG2MPXXn7knQzS1
	kEQoBhV07NeMvf/vmb3aNCfOs+qrdj1o/UK+kS05z80tj4RpEL0LZKQ6qtz7Y74Kx4VJ7efs8Ug
	cjK+hrWe6g
X-Received: by 2002:a05:690c:4990:b0:794:2ef:a445 with SMTP id 00721157ae682-79402efa762mr75302437b3.15.1769033520799;
        Wed, 21 Jan 2026 14:12:00 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794295ec411sm5665437b3.15.2026.01.21.14.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 14:12:00 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 21 Jan 2026 14:11:42 -0800
Subject: [PATCH net-next v16 02/12] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-vsock-vmtest-v16-2-2859a7512097@meta.com>
References: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
In-Reply-To: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, linux-doc@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Associate reply packets with the sending socket. When vsock must reply
with an RST packet and there exists a sending socket (e.g., for
loopback), setting the skb owner to the socket correctly handles
reference counting between the skb and sk (i.e., the sk stays alive
until the skb is freed).

This allows the net namespace to be used for socket lookups for the
duration of the reply skb's lifetime, preventing race conditions between
the namespace lifecycle and vsock socket search using the namespace
pointer.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v11:
- move before adding to netns support (Stefano)

Changes in v10:
- break this out into its own patch for easy revert (Stefano)
---
 net/vmw_vsock/virtio_transport_common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index fdb8f5b3fa60..718be9f33274 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1165,6 +1165,12 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.type = le16_to_cpu(hdr->type),
 		.reply = true,
+
+		/* Set sk owner to socket we are replying to (may be NULL for
+		 * non-loopback). This keeps a reference to the sock and
+		 * sock_net(sk) until the reply skb is freed.
+		 */
+		.vsk = vsock_sk(skb->sk),
 	};
 	struct sk_buff *reply;
 

-- 
2.47.3

