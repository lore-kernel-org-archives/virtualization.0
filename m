Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E364A47DFB2
	for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 09:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988210; cv=none; b=fd8sdqmPGkHEc3eQjencGJF2YE+GlxkBcUAfbsnb0324TTIlO8XoGUBAts+nWnlPvAzQMI0vQwsjeV9LmGW572Zs9bA3QylehexrYwy9ub1fFzH8dOQZJwMnMfswHG+oUYnSqhs7C2I3v6QgWWVkSicrYCyeL2iTGQ3GJLRvSxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988210; c=relaxed/simple;
	bh=PcAOc3r6px2QPynOOTZs4aSgXDaZ3NGUJGTa4O51yqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Hxmr3mdcvLSrwlP4KqgCASUOQ96qhKfoQylZTP3FbR0A6vOSWD5zmTB/iLti/pwASkokM7GdbW5YEZKferNK07u3jxFAagaTEQtGAYarQyYF+gh61gVFBQwMmqNY5qyaU2PASa+U8lCGkwsI6NHzZdSe5lpG4A7y6jAQbMZgeSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YdxdWPNy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdxdWPNy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768988206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6zDKTURxMpN1giCRjW7fiv4qni6ys721eKds24IdkTk=;
	b=YdxdWPNyX4/yu4Fy2NU+6W8CrnrHm8JnoLNdiGZ6oSPkiOgKfQjKiAM/nQMTamDuurInNl
	lEqYPK1upjAW4oL95iew72LyNylhEyMEOd1jQjhrel07weyd9nhADXqpTQiIMb5cjGfS0B
	eJp97dUc28VVOq4od4FGOWCPNPyDXpc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-aqGMLn0fMQapci7WCuHUGA-1; Wed, 21 Jan 2026 04:36:43 -0500
X-MC-Unique: aqGMLn0fMQapci7WCuHUGA-1
X-Mimecast-MFC-AGG-ID: aqGMLn0fMQapci7WCuHUGA_1768988202
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47d62cc05daso45336015e9.3
        for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 01:36:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768988202; x=1769593002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6zDKTURxMpN1giCRjW7fiv4qni6ys721eKds24IdkTk=;
        b=tuv/VzcKTdTIpnJ0834gQhvEjiK1UnDRrxn5XixH7fYOv85H+fnVT+QG/E79Ebkd3x
         NrbOiWYG+viPBiZVFRsSh/A2FO3AUy/cag/g6SSzP1Wc3123IqHS+AEMy98P8kmV8Jz0
         Y/yL94sOCRhX0kmL0oqe5rHysW4E4nqdPjRPodtxw99JSK2jXlN7Y9zx7Uksu+1YQNxK
         nZ8wKd1OAFWD8Ofgg8SLMA++IhnKfrVIK50H6HTQ+ER++pK27Q67NsP3E4MDiMhI7Ub9
         DUXQ+5/ZQQy75u8SCufeimzSas/Ub6lsZzSbf4H2Idd/Mk/ZtUZV6D32ortc2u77ikQ2
         uUEg==
X-Forwarded-Encrypted: i=1; AJvYcCXcjDjGtj6+Ep1pmu9NEiF6G2YwyksKSbzsybxUK9M44fng649q9Difynx8shkszBZq2Xt1d0B9Ji70YtwsPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YziPYFusbzxpNoyYENYI4JO0xO4CrElGAIScZFCNLcgQXPdDAgQ
	T1HX7buAdGF89pu9H0NZYl4tz6LT54eUADmZQqx0ias+ynkTz2faVeCqj3WTEg8wDOh2R2GbW4r
	RHjO1igB9zI9MBIE+b2f3m/vIG+hzEQmfLO7CYQoyvFUrAqeljqjz4KU6sESLXYRMo5iE
X-Gm-Gg: AZuq6aKbubmXjKolO7QAnMPDesa8oAUX68z+nPtQs9aXG70zPWhfMUISLAm2ZzRJmzB
	OoSFu/S7feu97fTr8kIbc0bMLortFyMHjObk1ZGcbXl/3WsLqZMtjTbI+gmOGuRYelyJkqRz7RF
	rn7MRArbvMkGjicFhXQymm84Ym1OkTQ8E7Jb9YzEI50zA2LZYpvJr1y9Ydf7OjgbzYXCeZZJ3xX
	njpz/3KhYzNGb7jZw+3klcuiHIw/QN7sLJgW6VpkUL8ibxs0reu8dD29uACiyDpqu2FsiaUyTRO
	DBRqIAi/8PjdFPPzQKI4kluGhBld8Q1f6s14J+wKEGJLaUZv5XBTq4z+COSu+QHGlj0y0n6W8na
	huPPGdjLA39c1fyYq58jOEQkReBQT4Vj/Jmb78Wn7RzyxU6uVe5IVKEpOVnsn
X-Received: by 2002:a05:600c:3e0d:b0:479:3a86:dc1c with SMTP id 5b1f17b1804b1-4803e803c1amr77560895e9.36.1768988202224;
        Wed, 21 Jan 2026 01:36:42 -0800 (PST)
X-Received: by 2002:a05:600c:3e0d:b0:479:3a86:dc1c with SMTP id 5b1f17b1804b1-4803e803c1amr77560335e9.36.1768988201797;
        Wed, 21 Jan 2026 01:36:41 -0800 (PST)
Received: from stex1.redhat.com (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f42907141sm355976705e9.9.2026.01.21.01.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:36:40 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Asias He <asias@redhat.com>
Subject: [PATCH net v6 2/4] vsock/test: fix seqpacket message bounds test
Date: Wed, 21 Jan 2026 10:36:26 +0100
Message-ID: <20260121093628.9941-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121093628.9941-1-sgarzare@redhat.com>
References: <20260121093628.9941-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PrEo9oKDn9e7_u68_LhBjKYDPYGWBGTqKBfXqbW4mVc_1768988202
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

The test requires the sender (client) to send all messages before waking
up the receiver (server).
Since virtio-vsock had a bug and did not respect the size of the TX
buffer, this test worked, but now that we are going to fix the bug, the
test hangs because the sender would fill the TX buffer before waking up
the receiver.

Set the buffer size in the sender (client) as well, as we already do for
the receiver (server).

Fixes: 5c338112e48a ("test/vsock: rework message bounds test")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 27e39354499a..668fbe9eb3cc 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -351,6 +351,7 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
 
 static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
 {
+	unsigned long long sock_buf_size;
 	unsigned long curr_hash;
 	size_t max_msg_size;
 	int page_size;
@@ -363,6 +364,16 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
 		exit(EXIT_FAILURE);
 	}
 
+	sock_buf_size = SOCK_BUF_SIZE;
+
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
+
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
+
 	/* Wait, until receiver sets buffer size. */
 	control_expectln("SRVREADY");
 
-- 
2.52.0

