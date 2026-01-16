Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A030A3A4AAD
	for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594536; cv=none; b=Eq5c47IGgYscJu6KIgfio90Fi8o6MqHzwtwDScbqodls4RJ8on0fMyHepxNTT+zzE0PFeOGPOBqy3vWwDXKZQ2Zy3/EykZgEJBV9lUvfuee/YgTR6pCG8sBkbuukHFv9fVpJDk4sjn8x1MzCnrnqsfUN4eIE4V7VCT/stG3OGDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594536; c=relaxed/simple;
	bh=JvMvAj7ZpINza73ylybZV6srp9RLkEGmGWUWUCTvQu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=l4GxL1DTNo4E8b1vDLdQnCFqp1xqUtW76KqbVRk2+Sd5V1SuguLKGDOVvs0AwPs0r+13lm+vzyKqe7vqpW/rsd2BzyUiW2WucVlxCol2lFXr5ICSr3/Iv0PRgyDwaBGdNwfwDGsfSALHGtB7SWPo/cCvnFg+gDfFhJToWg0L+/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ILpsUEcZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ILpsUEcZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768594533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=voXLQ/q07d6hv5Ud8qhwOuK2vYxSCpA8ze6BckDLUOE=;
	b=ILpsUEcZfRhkQBIAxXCZ9zOdILDyYdeqTaoA/vYpd+QV1PCknvaBjwHi1b79f7SHJ+eMVX
	aIHcigqM8SPSU42aBFG4XRhUBvl/GVQKw7Xj49ufVrdleNdwhZckL/bl6xZVESUAQUrzV5
	uLkoO9lGjkZT7TQ5nmrncobfWvSQlXk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-AohF8KHfMUaO9WvPJkuDzA-1; Fri, 16 Jan 2026 15:15:32 -0500
X-MC-Unique: AohF8KHfMUaO9WvPJkuDzA-1
X-Mimecast-MFC-AGG-ID: AohF8KHfMUaO9WvPJkuDzA_1768594531
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430fdaba167so1831879f8f.3
        for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 12:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768594531; x=1769199331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=voXLQ/q07d6hv5Ud8qhwOuK2vYxSCpA8ze6BckDLUOE=;
        b=tk/IFBAlaJuzJtQ5xeH7OPllF5jcfXh7bcjRUXnspdkAv+rijHYQoHIm3f5XRi35X+
         hYp8f7k6bvk3rR0H65Y29L6458lu60rV3H/pugwwiL35yic5PMuBpyUVS/yT0q9IJqg8
         oiveN0Rlp091Dtcs0bQOYSWAZKk2LFhha0m7r2BFUeRtIxoRspV1qn9ZvDNdC8g8VIYR
         cyk75i4mCsq04o6WCDZ6E76F5N/e4smO5rwWm1LNPDIw6vOigRCHoTEKNjRNQTuyOjTb
         o29pVJ4LGl2zWy9DoKa17gFnLDCjbnYRaR4DDvsWgGIpkcoWy2Dbi3fJp564pp/D6HbB
         zY2g==
X-Gm-Message-State: AOJu0Yy+NFsDa6mEV1GdMnAQPlOUflZKDsSa9eWLeRHTiDkw8vTo6P+s
	0HFCuIXX1fqQPNkvoptnm0ZANMCHMOj9yzEbpj+duZa4QDOvpxWVbiwmMN6V0uonCXnIElSJGx2
	/jNqBppVGZLRQVNEbfS6zJPr9f8toC7G9IxRUzfD1xfTZM2gndZBrRz7H43F/BVRq1sdX
X-Gm-Gg: AY/fxX7L7lBvzkqPV9iN+ahvXtGFS9f3d3wdkUBZE1LP0VtFQSRHPHEht/g+Xxtjzif
	Teb6g6wnhpZw5Ao7jXlbdLOW27FDiCjiwAS/quLoVLaA33NjdxkeB6Pk7P4+wZWCvF7Fy9GeDyV
	tEG6nERP8z5MEVLf12rWwtQ+HW6nQFW4bEyQEMt7cfmBZsu3PeeLYCe1Ti4gpkvkjkXX/Io1BoA
	oAi5Ap2XJ9BFOO0UFrhBu1krh5o6e/R00J+fM/Tgw9gwHjHoE6XMCRNmiPrG5IpgkvTtFcq46ni
	UU6yZWafc96w+d/H0AQrbZ9BgNGKX3F9SUGdpijno5Qj4HJVs75rPKuFtO3ACKpKUGtLmA/jWif
	F7A0/Xx422BEleNKgGHlk3gHhYO6ZH99UXx90e3t29DG4+67yNTtKeoSqcUOV
X-Received: by 2002:a05:6000:238a:b0:432:c07a:ee62 with SMTP id ffacd0b85a97d-43569bd48a4mr5632682f8f.62.1768594530762;
        Fri, 16 Jan 2026 12:15:30 -0800 (PST)
X-Received: by 2002:a05:6000:238a:b0:432:c07a:ee62 with SMTP id ffacd0b85a97d-43569bd48a4mr5632658f8f.62.1768594530330;
        Fri, 16 Jan 2026 12:15:30 -0800 (PST)
Received: from stex1.redhat.com (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992681esm7109861f8f.11.2026.01.16.12.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 12:15:28 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	kvm@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Asias He <asias@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH RESEND net v5 2/4] vsock/test: fix seqpacket message bounds test
Date: Fri, 16 Jan 2026 21:15:15 +0100
Message-ID: <20260116201517.273302-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116201517.273302-1-sgarzare@redhat.com>
References: <20260116201517.273302-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3IDOXWA6XSi9AVbqT04GMwBk_89eu9b9sZjw92AIOrw_1768594531
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
index bbe3723babdc..ad1eea0f5ab8 100644
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

