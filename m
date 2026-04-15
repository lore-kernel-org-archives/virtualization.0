Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAECC3D8919
	for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 15:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265788; cv=none; b=uGJuGCnCv1u8i/kczMkdJcUbIrSKM3pRtgjYAYGwgoytx8aX2/IkvqYkVaZf60hgzOP+AcRwqzN7qkCh7mCimKxZiIItefMem5OtLstGN/l3HUIgReDCcGpXdefYbEullHX8jt7x8Qdg/m0iX1KdicdqHmUByX3ZNNnoE9RXhzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265788; c=relaxed/simple;
	bh=/iCPhgiq7mE33glA4s7a0f83jNJCKI2MOCQ/JRlKmDg=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=SD6X4dwz8pmp01AKHxI+n+495UWDTdPT9IoLFDikYawbXL3y5ooExZ7s2t2IpLiNdyLyOm1hyNOpcQKj6bmIegSxE0r18zfcux/lkTppcvTgAgfyIkLvaYXRM4ao5YR3B1A3DERtLXKUuuIiaFHmYr9oy/WWKSaLE/+SkCMWxXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ArvZ98Xn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ArvZ98Xn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776265785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FA7f9IhhC8d9N5AuSbx4NBgDg1Ch+I8A/gLFTYNnbg8=;
	b=ArvZ98XnsDq4G79gVxP1LIkp5/iMBm2BXcRhUOm/LytB1pRfz9XStQDcVoLfglltZrmM3D
	Y7FWCCyxCMCi/UkC6m1sevbY+bz5W7K/Vi8eVD6vTe08kubWQ5GFezwWE2iUZ3reU0dRW4
	vD0ZX17EdHMKg83w6+GLJ2ZqTQ+HJ4U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-sTf_7pMCM2KRZpgSdowcYQ-1; Wed, 15 Apr 2026 11:09:44 -0400
X-MC-Unique: sTf_7pMCM2KRZpgSdowcYQ-1
X-Mimecast-MFC-AGG-ID: sTf_7pMCM2KRZpgSdowcYQ_1776265783
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso62560165e9.1
        for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 08:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776265783; x=1776870583;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FA7f9IhhC8d9N5AuSbx4NBgDg1Ch+I8A/gLFTYNnbg8=;
        b=ZR6iKwFBooBv76apbyzTop6pVXOw40n9+UCqTxFyqt3CNO1vTABL3q4KjIX5l9sELk
         x1YyS8vWxxtDTjffYb5W46bPGQm0sMvmXbOBKFoPBXEr9CC5GBowxdxLQy6qTNl71Omz
         nFa/8Mq2TjRKNq6azdNKITNH8b4dhGwKOMNYVSyK988jRt+L6tETI6fLxHCpZpDnHQnK
         /CVUj6/cHZizsN4SVVQJHqxXBG1aC/VaKny1yGR+oxbNN9oiZBKWqkhWm+IHYi5LTuDs
         UC5f9ZmeKx29nuC29zue7MtdYq8raJ/nszkHvAIEDHfgsjmoW34TMdw5imc/27g1SlfY
         71+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/4Ofz5zE06Gaowe1vERZajaP22WOaRoho9i1tVi3G8543feK0RDxUQcFc7guV0c+/CTW3Rs4737j40vmc3lA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzg1Is1Ge05ATZbOF8VKKnMqn2E8Skhn8U9l1vZV/k8JRs9i8kh
	/My3pAsei2X1xDKU5UG5uMF40v+/3iLGXgefAU2vNTkEJ20VYPAvFfuwSOSt9dE//rz7d9DzvGt
	sPW2t1e2mCqCXCAzrx0S4DOpAiKW/x1bxhjoE5tDkAEcNWWmj4kIBaP0ajakuzLJ4+Avb
X-Gm-Gg: AeBDievH0zjYLkAtKyksjGo7eOHV5XF0/La2f2b3JAU70YK6VPc0MpzIDGLRK+FUBz5
	+Ff1oyESMcPRhwJuuQl/mq7SvadURksJnxJz6jMdTBHezZ6tte2Z87lzHGwGynSYMtc1pt6eoJM
	xOdeSb0Iim+EbX0VT8D1Q0YfHTYTMtAOI8AlzkkhUUF9fhSxWvehtR5QmEdHcZD/oX+EBQ+5iOc
	kPVsyRxxPjf44Sr849FTfc5+m3VG0oOuNrG7I+lkv+g8RxRg/7f2rM6bVoBCR0oSWYUqfMQRctd
	Ima2RDUhyV/lGqFdRuyTx/4pjdMhf0pmhXUE/6sT6Y311G/ek+37ig8bfX/2+01zk687mr7SX0d
	c6kq3W35t2wm6JvupObJE7x4Uy2jjOMVjD0UAI6Ru2Fj+68yH0wtWoD6QEz5R
X-Received: by 2002:a05:600c:a413:b0:488:a639:b787 with SMTP id 5b1f17b1804b1-488d67f39admr230392015e9.11.1776265783238;
        Wed, 15 Apr 2026 08:09:43 -0700 (PDT)
X-Received: by 2002:a05:600c:a413:b0:488:a639:b787 with SMTP id 5b1f17b1804b1-488d67f39admr230391525e9.11.1776265782768;
        Wed, 15 Apr 2026 08:09:42 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead35bf1esm5907557f8f.16.2026.04.15.08.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:09:42 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Wed, 15 Apr 2026 17:09:29 +0200
Subject: [PATCH net v4 2/3] vsock/test: fix MSG_PEEK handling in recv_buf()
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20260415-fix_peek-v4-2-8207e872759e@redhat.com>
References: <20260415-fix_peek-v4-0-8207e872759e@redhat.com>
In-Reply-To: <20260415-fix_peek-v4-0-8207e872759e@redhat.com>
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
X-Mimecast-MFC-PROC-ID: WU2pvnb0468ku5I_nkaFRUTrQ2JOyIShx_tiQcdIJDs_1776265783
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

`recv_buf` does not handle the MSG_PEEK flag correctly: it keeps calling
`recv` until all requested bytes are available or an error occurs.

The problem is how it calculates the number of bytes read: MSG_PEEK
doesn't consume any bytes and will re-read the same bytes from the buffer
head, so summing the return value every time is wrong.

Moreover, MSG_PEEK doesn't consume the bytes in the buffer, so if more
bytes are requested than are available, the loop will never terminate,
because `recv` will never return EOF. For this reason, we need to compare
the number of bytes read with the number of bytes expected.

Add a check: if the MSG_PEEK flag is present, update the byte counter and
break out of the loop only after at least the expected number of bytes
have been received; otherwise, retry after a short delay to avoid
consuming too many CPU cycles.

This allows us to simplify the `test_stream_credit_update_test` by
reusing `recv_buf`, like some other tests already do.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 tools/testing/vsock/util.c       | 15 +++++++++++++++
 tools/testing/vsock/vsock_test.c | 13 +------------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 1fe1338c79cd..fe316b02a590 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -381,7 +381,13 @@ void send_buf(int fd, const void *buf, size_t len, int flags,
 	}
 }
 
+#define RECV_PEEK_RETRY_USEC (10 * 1000)
+
 /* Receive bytes in a buffer and check the return value.
+ *
+ * When MSG_PEEK is set, recv() is retried until it returns at least
+ * expected_ret bytes. The function returns on error, EOF, or timeout
+ * as usual.
  *
  * expected_ret:
  *  <0 Negative errno (for testing errors)
@@ -403,6 +409,15 @@ void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
 		if (ret <= 0)
 			break;
 
+		if (flags & MSG_PEEK) {
+			if (ret >= expected_ret) {
+				nread = ret;
+				break;
+			}
+			timeout_usleep(RECV_PEEK_RETRY_USEC);
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

