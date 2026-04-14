Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1463ED5CA
	for <virtualization@lists.linux.dev>; Tue, 14 Apr 2026 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183035; cv=none; b=UI+mxvbX2uuV2DrtZ8YC4m1lwtgPRX0H3n9VClSRvkIOLCs4fXmWxliJbQVpXL0WfFBG6uSsvtegZBEXtWES9bd8lXPEijo8n1I3eJM6v7+xB3mYtlZR09klN/YSKsWthzJWX2uJ+dWugMYSGrmoWUqPRTvQOCv1spA8wTYmTA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183035; c=relaxed/simple;
	bh=1yv4GGA0ycfjwtZCUCLrwar6tO3xyrHnQ4nzsY0/Lv4=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=XQXN3iWq06WNkJ6AkQsYtJklwJe96z/HAW5Si9HXdlrz+SP/ZhuC6AFhQftudEvQoxDm0TH9rayRcr5tCWxEWIC9FmOhxwWTwg+XxotFlSDnVtUTQ3BVruf2a43y6PlivZBEPhhZFSGj9+Q/wtJHrYpVvFvhtKOPe0HFBucM4Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i32qXAa6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i32qXAa6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776183033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O8VspJYK7a4i3bSoWqkVfUZf2SDjKFNStSqOdJah6ic=;
	b=i32qXAa6W1JKk5sDZ8C1rTx8txvthm/awzT9NHoVW/JDWebPiLvhlaFnwkY45pO34NqXfj
	ZNltLgRhiFnDXxrl1B4nK51f1k3MJM3v9SfilQMZvy4b8z3AcfzWO5ZvwBEPfkP36bAZNJ
	6Bkg6esinGMvp6/++V1YB7xWVfD7Hlw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503--37Kf_-jP_ybRQR7Q83grA-1; Tue, 14 Apr 2026 12:10:31 -0400
X-MC-Unique: -37Kf_-jP_ybRQR7Q83grA-1
X-Mimecast-MFC-AGG-ID: -37Kf_-jP_ybRQR7Q83grA_1776183030
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d14a4bcd0so5944409f8f.3
        for <virtualization@lists.linux.dev>; Tue, 14 Apr 2026 09:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776183028; x=1776787828;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O8VspJYK7a4i3bSoWqkVfUZf2SDjKFNStSqOdJah6ic=;
        b=Kqe/rfJEkIfkH2u7WRigJHljsHC4PAWt3H0Ie35wcJLYZ8nw3aCC05cLDD6hw+tuqa
         Yq7HKp3StVpPEOpF7BC2GhcEXtovbrH1DJ/7BxopXwkENxb2Au8efB6qMiQlTEKl8MaW
         N/z69/3WI7RHmVO2btGL3M902nvuG7goHy4n/awYEfjgP3ZBjd2A8ILBLEH+5q1Jl4hx
         14+fa7XuWVodoenvLHNnesAbqXtRTPy/zKeh3/qgBB+j/k4p8534eyF5PqRiE1dsO5Nn
         QseKZNKwkgkJ9V/K5mlpT1f/vNaDPM/rx55Sx5Vn+nJ3yf2B1ljmIufsIhDHTQXT1G5K
         HRFg==
X-Forwarded-Encrypted: i=1; AFNElJ+d1KVWbeNBZI6nndHmnziHa3saGSzx7fjePaJ8dX9itmTHHF69JMoPXJ7ACsnBDOqeSnlSJWFn0OZb+7VD+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyywZteMIzFafZyxo7/YLQaTvVbLX3gC6ZT+mbRkKcFv3IJdIp3
	5e3OmCtCEVrnkKZMgZSjFLMJe/X26WrST/poliNDajI07WTJxP3QTQ5HWFvjgilIZthKgYT8Gmj
	9F+ImZPyK+zeynH3eYfl2lz0GZp08+VKAfCsalU5nOgD8qHqzUtuo6r3G7AW1QPx1aHbG
X-Gm-Gg: AeBDievg5y1VJtmzmbgExfTgPYVhxR9uazhOsDWXmZ8q+a/7ui+VH1YqRh90CotDzy/
	BYo0M9q022MagQx8OXfvBrG0k3uon9U9J1eWvpMY+B+wjF+131gtQbXLjnSkA6LnLa4xwQyXLXf
	FaLiji+OFtVP2hwkOUZfBZLm4jts/pmRAmc7YHNWPfyoTVWq8tnz4SQldJ2ixGp7699q8bfsql8
	lk6lA+7whhyyS1ZGI8O6QhLUQ4/3RniNwrHiMm+McZG7iDvKCRnblh5NYzmxCfLZCQtctcOfi3P
	gnKzQgkeo6vGQwdICMARO+Kjq1GRPHkXNwOiMWpwjvIH1NkIR3XelS+dfFyp3fl0g9YynNmXcOx
	/2HVCfD2+AtowwecDbMQU0l+GlVYnpdKCpguDLOTBf8H5MwfaNP4LvOxq59Hi
X-Received: by 2002:a05:6000:230d:b0:439:bcc2:bf0a with SMTP id ffacd0b85a97d-43d642b8d4cmr26748919f8f.23.1776183028133;
        Tue, 14 Apr 2026 09:10:28 -0700 (PDT)
X-Received: by 2002:a05:6000:230d:b0:439:bcc2:bf0a with SMTP id ffacd0b85a97d-43d642b8d4cmr26748793f8f.23.1776183027431;
        Tue, 14 Apr 2026 09:10:27 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec090sm43035268f8f.12.2026.04.14.09.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 09:10:26 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 14 Apr 2026 18:10:22 +0200
Subject: [PATCH net v3 2/3] vsock/test: fix MSG_PEEK handling in recv_buf()
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20260414-fix_peek-v3-2-e7daead49f83@redhat.com>
References: <20260414-fix_peek-v3-0-e7daead49f83@redhat.com>
In-Reply-To: <20260414-fix_peek-v3-0-e7daead49f83@redhat.com>
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
X-Mimecast-MFC-PROC-ID: XFc_STj3ZzddT5QLuYo7rJhAKp3D_xq1QGmPKt4eNhs_1776183030
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
reusing `recv_buf`, like some other tests already do.

This also fixes callers that pass MSG_PEEK to recv_buf().

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 tools/testing/vsock/util.c       | 15 +++++++++++++++
 tools/testing/vsock/vsock_test.c | 13 +------------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 1fe1338c79cd..2c9ee3210090 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -381,7 +381,13 @@ void send_buf(int fd, const void *buf, size_t len, int flags,
 	}
 }
 
+#define RECV_PEEK_RETRY_USEC 10
+
 /* Receive bytes in a buffer and check the return value.
+ *
+ * MSG_PEEK note: MSG_PEEK doesn't consume bytes from the buffer, so partial
+ * reads cannot be summed. Instead, the function retries until recv() returns
+ * exactly expected_ret bytes in a single call.
  *
  * expected_ret:
  *  <0 Negative errno (for testing errors)
@@ -403,6 +409,15 @@ void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
 		if (ret <= 0)
 			break;
 
+		if (flags & MSG_PEEK) {
+			if (ret == expected_ret) {
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

