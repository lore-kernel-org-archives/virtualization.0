Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009D939C017
	for <virtualization@lists.linux.dev>; Tue,  7 Apr 2026 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553251; cv=none; b=FIQiupvxcwDzOV1LNle3hgMfRci+ZS7xIru3oVEnfY+QODT1r+x59u6yvMpm4xSUYmNJEfXX38fTbl81OjGa67hNXyp9a2r9AQLytEnqsLzJm44FIpeGxPBzbFFiXoXbHqJg9uhpbfskkoPwg785VCUEXKkVDQOHY1AnFLfMtY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553251; c=relaxed/simple;
	bh=ip2wtGgcP4DvQiglidvGP+GnoassWfKVZlJvs+MlGRs=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=FPJxU+Kt4BucY9GM12oEjvH0aZ6Ap1Ow6PoqPrnWRKxnnmjkZ2yGyDWu/NgxQszG1wic4fcb0irzyMgUTrRM+QcFM1Vtd+lgIrOkPKGq/IsuHVCKvbWSt4filys6PG2t1pSmS0h5TR/Zkj9ETNPxOIw/PpLtNFNAx4qHOEszkp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dep0sHNL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dep0sHNL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775553248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5pofFwwc6ykPOXmyxDteFf7vraGRelyLMlwG/8lag20=;
	b=Dep0sHNLxICjsbyO3iSiNVFL9gPa6ldEDyrdBzY2e8QKq/W4rUXySaGa2EmgVIUzFRohQ9
	CvfUAIy3ywiuZIuGDPyrBDiALP5fuj+S6ZDQi8xLISoTGcUonGMzW6iQ3odocss0pESxao
	KANIfsZXlJNkwoQG4t6KHvlif8EuoMw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-fShngBFANw2UtmTOdCtahA-1; Tue, 07 Apr 2026 05:14:07 -0400
X-MC-Unique: fShngBFANw2UtmTOdCtahA-1
X-Mimecast-MFC-AGG-ID: fShngBFANw2UtmTOdCtahA_1775553246
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43b9b8e3af6so4466728f8f.0
        for <virtualization@lists.linux.dev>; Tue, 07 Apr 2026 02:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775553245; x=1776158045;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5pofFwwc6ykPOXmyxDteFf7vraGRelyLMlwG/8lag20=;
        b=sU+ckSxwcIbEvnWCWzgY5YsmjOQF4f+kxywsbcrgFtVtc1ExtW2atgt2wuTu6XOkJs
         CrylI3Xgc22XlrAaiKss+i5oPdJf1o14hTWzzIXiAslXw0xEs7115DjuohAmXSNu8iP9
         elPxgVTUJVXqmveH5c/bLDf+m1ggaYeC5jpYvt88hWAd67kx/SLLLxHqoJNPjuOqRCbZ
         Qc/uWGpw0+JUGtJfSSd9A8bBLm5v7LJQB102PIJ/jzgZgOAb1qizIRo5gDxMDtNbyzue
         bVuv9QRRt3henHk3AOqJffCxtfwKxUbFobwAiVwd7VJx9B8bPh+iyG/ades2FCmg8TlV
         1u4A==
X-Forwarded-Encrypted: i=1; AJvYcCVyn7nW5NXJ4gNuhA4Fu6CFA2rb40kraKbx7tmcTsDgLxOs7eEhXCTyHJcNwD96zBZ091Xk4s4hn2dYdFDmgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6gi+7wgnCMc5wimepap4ahmrebVEsn0k41d0DVc0ab9v2xRPE
	eqRpH58GzE0JcnldKeyWNEORtybqoN7Pjf50mH3XRWej2pB6K6OLCj8H9raiFbpSIN95TMSuMJ4
	PTtDCUfoaLvWMgsVJt3Aglah8qxsbsi/e7twK8/ANa0DR2N96Z+nTY9lZP/ibQRDX+WuTjc8MuG
	gWIZI=
X-Gm-Gg: AeBDiets0XM8zF7X4XiQkPtA7Z/zAUOQvoCII+kSIVqQAbVKJ7Y4OD/brr9qt1QPYA+
	920xQcxpNb/nHMiokThkHfVLmKmG0GnjGgxsT5tU5HcBQUuKl3UynXsc8I5+Dd9uzPFxjNxa400
	Le6LtavBTcw4+4lbQwpV2KhrZfPDvtRhaka5OnquFVPspf3iERznDPRjU7xq9YEVHdiClcGSjwz
	dPcnpP786vPZasdP5AzuvbMjR0YovHCliBjueKcFwRdXPnkT8vmlT1Xq9K+PtdUWL5CMTBiPjWZ
	7Ssno2dKl/vj7GrFBWe7sQg8tv7uY2x2hUHlAWlCrnHgXmayASA72VKiaX6vX0ke6CKaMwzGtve
	Wfp72BQl3ivcHNIhs182MCaDR/6LgoyC0WFFkjdg58kwtfoa3+LENLuiCkTt8
X-Received: by 2002:a05:600c:1d86:b0:485:4388:3492 with SMTP id 5b1f17b1804b1-4889970d844mr239703695e9.11.1775553245335;
        Tue, 07 Apr 2026 02:14:05 -0700 (PDT)
X-Received: by 2002:a05:600c:1d86:b0:485:4388:3492 with SMTP id 5b1f17b1804b1-4889970d844mr239703185e9.11.1775553244880;
        Tue, 07 Apr 2026 02:14:04 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48895e19c10sm342892015e9.8.2026.04.07.02.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 02:14:04 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 07 Apr 2026 11:13:57 +0200
Subject: [PATCH net v2 3/3] vsock/test: add MSG_PEEK after partial recv
 test
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20260407-fix_peek-v2-3-2e2581dc8b7c@redhat.com>
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
X-Mimecast-MFC-PROC-ID: nmNYo2oSGwVZmtVMv65inGkR4W9KyE1CXAXn-4DO80k_1775553246
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add a test that verifies MSG_PEEK works correctly after a partial
recv().

This is to test a bug that was present in the
`virtio_transport_stream_do_peek()` when computing the number of bytes to
copy: After a partial read, the peek function didn't take into
consideration the number of bytes that were already read. So peeking the
whole buffer would cause a out-of-bounds read, that resulted in a -EFAULT.

This test does exactly this: do a partial recv on a buffer, then try to
peek the whole buffer content.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 43 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index bdb0754965df..d38a90a86f34 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -346,6 +346,44 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
 	return test_msg_peek_server(opts, false);
 }
 
+static void test_stream_peek_after_recv_client(const struct test_opts *opts)
+{
+	unsigned char buf[MSG_PEEK_BUF_LEN];
+	int fd;
+
+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	memset(buf, 0, sizeof(buf));
+
+	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
+
+	close(fd);
+}
+
+static void test_stream_peek_after_recv_server(const struct test_opts *opts)
+{
+	unsigned char buf[MSG_PEEK_BUF_LEN];
+	int fd;
+
+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
+	if (fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	/* Partial recv to advance offset within the skb */
+	recv_buf(fd, buf, 1, 0, 1);
+
+	/* Ask more bytes than available */
+	recv_buf(fd, buf, sizeof(buf), MSG_PEEK, sizeof(buf) - 1);
+
+	close(fd);
+}
+
 #define SOCK_BUF_SIZE (2 * 1024 * 1024)
 #define SOCK_BUF_SIZE_SMALL (64 * 1024)
 #define MAX_MSG_PAGES 4
@@ -2509,6 +2547,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_tx_credit_bounds_client,
 		.run_server = test_stream_tx_credit_bounds_server,
 	},
+	{
+		.name = "SOCK_STREAM MSG_PEEK after partial recv",
+		.run_client = test_stream_peek_after_recv_client,
+		.run_server = test_stream_peek_after_recv_server,
+	},
 	{},
 };
 

-- 
2.53.0

