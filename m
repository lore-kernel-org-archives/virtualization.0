Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11652E0407
	for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995159; cv=none; b=RxzgBpY5dUHIT/e/am7GP/qkEkki7zgW+X8BJaS3ARpwAdHTzaVxEWV5FiUOX00HJSE6FeqY7Z/6wnBdGTP6SDrn99Zym058fe/bbrZub2uuXdROgtPTpTKJ5yVoCElBp3MQ2MtkM+4SIzclVOacgWh2RHWFbKk45ZlydnjtODM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995159; c=relaxed/simple;
	bh=wEb7l9+dIaLrF3lOxuBu98VyqaJvK7HaA2qlpIF1m8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HP6wGlZSHsK8W1/4YNFBb79HIhbw/v8gC0Qr8yXlnlcEQ9mI+vhGCBblccfVbmo9DOwCio5W2HPFKD0P9ulNY7w0J22kR7RB/pydySx8WIzPfMUU3c8ow23MmNTJGliBX+Mx3KLNi3XgR8YNOLjDdgiPJKSYnvu+S24RItVGU/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THyKHmNr; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THyKHmNr"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-594285c6509so6944279e87.0
        for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 10:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765995154; x=1766599954; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbWRXdgRl3LSSNhNbS1goR3DTsrT8qwsPNUfgEKOHFM=;
        b=THyKHmNrLmqkKUQMWbWasQz4t6jFPXSeGmMDgEU6UUZmAB4sBh9Gn0gcxWQS44EY7v
         UzWcKcyRO/euIV0VP36WpuuQ5rwnHKPZR9awHlJtLPGk6sIDaXEJ6EIStMYxGK6Cm5q5
         5JrYJU/zVMAiodQDlV2Y+4bCy8HUhj8qG9401P7jUANHOUxIYahHjsJvDZY2b7zC7XnL
         myZ5NbqXcQpoTR1wSVbZtipjFwQxICLSQekZWewy+nXvpLhzjKExtFj2RCyfQMW/H5G3
         wIDLCkpbwZ/mzy/7ORLPeba44P5J5VbqjUFiAfXxxj8ClCgQ0gojwFt8IVhaxU+z5J7T
         CwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765995154; x=1766599954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NbWRXdgRl3LSSNhNbS1goR3DTsrT8qwsPNUfgEKOHFM=;
        b=ASunPsF4TGjJAeQnhhraj1DrfwfQHo5yzO/2eX5wTXfhIhx82HzZYKuxMdQG8bdq73
         5FTlya89b7VReRDCuD4d17f9of/E1uK8mEq+nfy7suUr6g03NPigOJ5OgxwmeCRaDb/t
         TbcN1MS5BGLr10pUWk9Vd25uqKht6fehoRqAVw5SUya2W9vGRzxTptb7Np/IvEAweRXO
         5+9op6kaTX3DbhHGP0/Ktx8oifG8pocdCKxv7ljX+i2lpt2SrMksfO3I8Lw/KSypvlwh
         jtpMZlb0jtrQXpkdJCua5x4XX37YUEWdh5JsVMa3Ooe4p5cvmLoKnRK1b3oMI/kiVBB3
         Z8tg==
X-Forwarded-Encrypted: i=1; AJvYcCUztcFpR4QGt+r/QMstTv583EL7BLHzbcbL5sPjbgpj8EdW3add4XerrpWY5Wz8J84TwOr+2EJfBjxo1qRo8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLZ3TOYTOAOkUtEOBJawwFCEw7db38FnzI9dhCzBSshKt37OL8
	ofe8nT36YaTOU/buqh20ETKlb05Fab6du87e3Quv/FqCP9csi23kahFz
X-Gm-Gg: AY/fxX7MU5rffd+BBSUVw3ou9Oy+SFyxZDsjKwOR9gvgqJnovHvAwzc12NM7cPu9Y/2
	1ZN9XhWt3b4K/r70ZGR5nzV8rWgqokIgE1DfCOymyWVNbEkHrnrCRcT/0HMjqtcqu2NKaO3xSe1
	CSr+p7skg0SE8zwkdD/emSvZNvPPLHwTYDizzB3rzlrmBAjHPR7rN+PVWJNBvgJ6MoAOgAAOYCQ
	OQEFJR6xccipC1fKjRL8gfB0ieIWYuAAxBfSbMtl8DIZtIqShfcY6sTWEoh7VEHmebp5ef5Aasz
	Tu1HTGr7FJOHMUC0NQhpmY0+ZKxLkjr5y8tzJk9zN/Du5DYJncosRz3BSPqel0ASF4zSG+7i+o7
	3xim0Q/tKJQlqUzuqDvwXQX/+nOeuKeYNwUaXC9Rf83PlZonKn2vQWaVLLfPolobidVVnjsYw3S
	GBLCMZ1VLjvVA3TWJVJKEiwg==
X-Google-Smtp-Source: AGHT+IEL8x2ZTlMBEs3LqicoHEeKL6huCiyi0aBC5yPRWitKdewpftY1eFTFYFReON3iTv0egPnjNQ==
X-Received: by 2002:a05:6512:230e:b0:598:dea9:4f4d with SMTP id 2adb3069b0e04-598faa98d29mr6053767e87.53.1765995153840;
        Wed, 17 Dec 2025 10:12:33 -0800 (PST)
Received: from Ubuntu-2204-jammy-amd64-base.. ([2a01:4f9:6a:4e9f::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5990da790efsm2591419e87.102.2025.12.17.10.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 10:12:32 -0800 (PST)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com
Cc: kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Melbin K Mathew <mlbnkm1@gmail.com>
Subject: [PATCH net v4 3/4] vsock/test: fix seqpacket message bounds test
Date: Wed, 17 Dec 2025 19:12:05 +0100
Message-Id: <20251217181206.3681159-4-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251217181206.3681159-1-mlbnkm1@gmail.com>
References: <20251217181206.3681159-1-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test requires the sender (client) to send all messages before waking
up the receiver (server).

Since virtio-vsock had a bug and did not respect the size of the TX
buffer, this test worked, but now that we have fixed the bug, it hangs
because the sender fills the TX buffer before waking up the receiver.

Set the buffer size in the sender (client) as well, as we already do for
the receiver (server).

Fixes: 5c338112e48a ("test/vsock: rework message bounds test")
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
 tools/testing/vsock/vsock_test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 9e1250790f33..0e8e173dfbdc 100644
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
+				sock_buf_size,
+				"setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
+
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
+				sock_buf_size,
+				"setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
+
 	/* Wait, until receiver sets buffer size. */
 	control_expectln("SRVREADY");
 
-- 
2.34.1

