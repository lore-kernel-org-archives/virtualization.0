Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71F93A0B1D
	for <virtualization@lists.linux.dev>; Tue,  7 Apr 2026 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553251; cv=none; b=GYXzhpKnbNJKaz3sQa1OXVcrsjtO0Rpl29b4lBSAkJSDToo5NLeLR5oXgWfGvAXj/H4QoeKPbTsPv7A4FO8nvMypOBcsb2ayTHLklZx6tBVbSfugL8n8dZdD0dji+GZINNskEXBqyrCKJ3jrHFzx1SDq6btRih374gzFFNHsk8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553251; c=relaxed/simple;
	bh=TPyeaXldjZ/vNi3cTj7MlzLbGl/Ixp9Pbj/uTFr2sk4=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=bj52qMWZdHXZ9soK0vjd2pVwpS6VsbahSw3ETNaS1tNOZOozUZTZUvwOMcZZdJ0PWypv9wiOVGW3G+5GA3jSxrGSEcspjIGmF7zzInNWojgyb4J42dgICFchrShJ+54WeXshxt+RLDaEouxDEZyAGsK9KA5sVfd8gftM4a81I8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KkbVsg/B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KkbVsg/B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775553246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5MvBSgtjWIPj7YtiYQ1QdgeAu7KbULO0Duu0OFbmnZU=;
	b=KkbVsg/BGk866pUFTw9KdxzP4cD33xxofsxI9lrn/ZVUajcXinvur++vXHX/juRUjYVK0+
	qgklgVujHGH7+HbkWq43bxDoSNMiwoHXY14gLZGJHxyVz8JNAz/D8E5bAb4N2gU0/LMzif
	fOez/lc2kGYV9QY8JjS4k8ldLZDID0o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-WpNEBunKPr6KKoGU975VKg-1; Tue, 07 Apr 2026 05:14:05 -0400
X-MC-Unique: WpNEBunKPr6KKoGU975VKg-1
X-Mimecast-MFC-AGG-ID: WpNEBunKPr6KKoGU975VKg_1775553244
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43cfbe041b2so4029194f8f.1
        for <virtualization@lists.linux.dev>; Tue, 07 Apr 2026 02:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775553244; x=1776158044;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5MvBSgtjWIPj7YtiYQ1QdgeAu7KbULO0Duu0OFbmnZU=;
        b=qEW6UrsFklFjZPuQYlZaQhBnAIos9KRueFYi0I5DixE0dwcMNoHYMHBdKOOk2tVHNd
         ulEFAuflBypsdbfWF/+PgDv+zmV7qIktBMs5mk5fBWAtD7XKiLBSPpyERKDkLWtAx5Jv
         DRBbHXxB4DCyeE+4ZNWq7LsGPNCY1UsO9fFUItA+W74xgTEI/r/j+tQijPzwj0i7DQA6
         jER8YP9TRgL9yeXF0i1keOhBH+4GzPbZjoIoCJ2v3uuPPVA3LSa06sAETGs9Z0jghYjC
         lVcWC799NF03gWYI30s/U2qcqh0MnI3+msIlNIq+UDxIuX08CFzWvmZo8sRv0jUqy8ts
         5IsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW16pi1oCpZmf7Uhw3iJyMAKjZa1N5kH1yOKb4P+Ujlg3/btNGOD/yyQRR0OoyoYD4/e0gzy5QTPuy9AkmlHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwR+QglBWhiz89EwL/8f3GPbJzoxjgMlOfMNWASZnuwt8owMkG5
	2Irpa4rjJ1+s300aiOkJqNlqMXeaU1GQkxK3Fia9W+AWrT0mV3lVGkeN5IhQVS0xDpi96AgOpoL
	/No9LQ1xGdtAoEA0UIPB47vZ2jxdgEhylHr8abonIfN69zNWatdcUlqnLvIRMA8hXH5jK
X-Gm-Gg: AeBDievoPmClfZreqnDkV+5seL98GRnQl0AX2Mlu7xbCUinpw1vBQsHkayhBPs9KXLn
	VbUzA9KQSULOTLKMFgF6BJFtNa8OIGUxsHyzigwQqfYaiX9afmd0vUxDJQ+SVkp2Kjcr0uNpvMh
	sNuLtPI5t0xznrsuO+DAUHoBPo8m7D/ze2TeOuQZyxMs2hFJwUYKYunirAc9jpJYFSy0hp1JuN1
	mo0qn85F+Pu7gHXV5Tu3YyP1vgdCMqdJbF8JRyGKStBChUtouMJEfhlLvypzX4UtVtX+PT262+x
	9kBZqNbAx6oAKz1MQd4HKD9Kd5AfvjJ0suL7tdQdt3dEo+i5Tmy2Eddsa8JC27WoHb0mSvp8fat
	NOgW2DA7CXJcWXStyLZOp8cTEStQ5Ranlko3intInIOPmE49BL7yvF+WubHXH
X-Received: by 2002:a05:600c:620d:b0:485:fbd2:f72 with SMTP id 5b1f17b1804b1-4889945faa5mr212240055e9.1.1775553244223;
        Tue, 07 Apr 2026 02:14:04 -0700 (PDT)
X-Received: by 2002:a05:600c:620d:b0:485:fbd2:f72 with SMTP id 5b1f17b1804b1-4889945faa5mr212239435e9.1.1775553243640;
        Tue, 07 Apr 2026 02:14:03 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48895e19c10sm342892015e9.8.2026.04.07.02.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 02:14:03 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 07 Apr 2026 11:13:56 +0200
Subject: [PATCH net v2 2/3] vsock/test: handle MSG_PEEK in `recv_buf`
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20260407-fix_peek-v2-2-2e2581dc8b7c@redhat.com>
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
X-Mimecast-MFC-PROC-ID: eq_xcPEG2cuhiz5r2-K8RmqF4Jg04ulfY42mz5jsvqI_1775553244
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

`recv_buf` does not handle the MSG_PEEK flag correctly: it keeps calling
`recv` until all requested bytes are available or an error occurs.

The problem is how it calculates the amount of bytes read: MSG_PEEK
doesn't consume any bytes, will re-read the same bytes from the buffer
head, so, summing the return value every time is wrong.

Moreover, MSG_PEEK doesn't consume the bytes in the buffer, so if the
requested amount is more than the bytes available, the loop will never
terminate, because `recv` will never return EOF. For this reason we need
to compare the amount of read bytes with the number of bytes expected.

Add a check, and if the MSG_PEEK flag is present, update the counter of
read bytes differently, and break if we read the expected amount.

This allows us to simplify the `test_stream_credit_update_test`, by
reusing `recv_buf`.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 tools/testing/vsock/util.c       |  8 ++++++++
 tools/testing/vsock/vsock_test.c | 13 +------------
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 9430ef5b8bc3..f12425ca99ed 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -399,6 +399,14 @@ void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
 		if (ret == 0 || (ret < 0 && errno != EINTR))
 			break;
 
+		if (flags & MSG_PEEK) {
+			if (ret == expected_ret) {
+				nread = ret;
+				break;
+			}
+			continue;
+		}
+
 		nread += ret;
 	} while (nread < len);
 	timeout_end();
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 5bd20ccd9335..bdb0754965df 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1500,18 +1500,7 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
 	}
 
 	/* Wait until there will be 128KB of data in rx queue. */
-	while (1) {
-		ssize_t res;
-
-		res = recv(fd, buf, buf_size, MSG_PEEK);
-		if (res == buf_size)
-			break;
-
-		if (res <= 0) {
-			fprintf(stderr, "unexpected 'recv()' return: %zi\n", res);
-			exit(EXIT_FAILURE);
-		}
-	}
+	recv_buf(fd, buf, buf_size, MSG_PEEK, buf_size);
 
 	/* There is 128KB of data in the socket's rx queue, dequeue first
 	 * 64KB, credit update is sent if 'low_rx_bytes_test' == true.

-- 
2.53.0

