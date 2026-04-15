Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D1337AA8B
	for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 11:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776254098; cv=none; b=R0E8Q1rtBD0P6Le4XRCxhnKdvmLuIS1a/Xl59oOUeHyI9yf+H4UUEBYouvp3tSR1v66v0gBxYW8L8y1+dVRj+1hWynKyaz++ZzWGN8ubNFx62FG4QwJRSvVsTKkKs0Pt0RXGR6XQZx2NblQrt/BP6Uccou0ufydFowTUfWCYiIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776254098; c=relaxed/simple;
	bh=IhundK6gvmdpIbwTKJkzDNzcKDA2uur/VnVrMcwemEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dOUba/pPRTVQyd1GyZRks8EzJ+Iu1sJ+0ZJDlTvrkKVuiVpHf+I2EDejKxAhRb9ZJbcJlR+JYg8g9mvl8XUKzx0B54ZewEdZyRqhZnoMZNlIl0tRQ22UGm5fp3DTehx2IlWb3TlCXjxhqWRg+mbKHEazsx3v8fDgyqRHoQY0Kqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KvnOvwam; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KvnOvwam"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776254096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unpQFuqYzr7/sma4T2UOR9+jmvcvHr7lpkU7c0Dl/SQ=;
	b=KvnOvwamjbqMjZx4OxTjdfCYuOdlawo7m+RwLoCYoVhymOc5o/BL1xpaplpmivPoqJpEHn
	gcw0xqxVBBQjWCd41QNzV353wdxQKtM2XC1JM7xusKSiuW0lMimnOW9sYdstvntp6p3jPT
	ZcOTqoEbqwLF/hTllrbSKj3npJ5c/BA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-42yTKmnlOcig9C2f_-8Waw-1; Wed, 15 Apr 2026 07:54:54 -0400
X-MC-Unique: 42yTKmnlOcig9C2f_-8Waw-1
X-Mimecast-MFC-AGG-ID: 42yTKmnlOcig9C2f_-8Waw_1776254093
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488d6ebe9cfso42504765e9.2
        for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 04:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776254093; x=1776858893;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=unpQFuqYzr7/sma4T2UOR9+jmvcvHr7lpkU7c0Dl/SQ=;
        b=H2MUJXpRQxqzpqxuwo7z0pDNJa3ytIMCblkODC1B95b2nIxI5Ow406YCyLPpGE9Lyy
         1HzFU6je4wFgZAdljofnaQ1bO4bz3VZe/jKxSlYuAGMcXAQH5MjrNmD9fk9+pS20J4oH
         kL69/cQTVmauBcCUJmO1VOwv3VsIL2CMo6ei7ZKpH59pNsqGvu+nj5eGXORG84dxIBbf
         aLCZWmbW7B1UeYrr0XQFx2aTHzlLOxNDdRKcl0x56712UrbNAZSokxy/l6/9go7yiZSD
         V78RYq6dUtPZANYp7IWcDlqglQadk/9lsgm+maAZeLlz0lbe+zLTJZbFA098CN1N5wS5
         WQ7w==
X-Forwarded-Encrypted: i=1; AFNElJ9+FmezJ152aUKtKEJsMeYto2xcDIGAQTsE507ArPg05+/a6eOBZguRT+XYUWjQXq3yhDWCOkvlijhuZthHBw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz40wqaJGbYuNwzmvws9jjdMVYiHyjl5wYYSac6Z2Igc9gfmyEk
	zv7bgwtgdjGBKk0Pfv1mElpz7MORxJWUNSi3W2JR471uZLXWNQFmUyUj9w/jI0GkeLPCDyCfIsu
	j2mc8wDkPJ+7qvH8qaefZ4LtgrqjQU7jZR+mQkskaHUWnlAUQEe/jThg8ELS8tomZpwvV
X-Gm-Gg: AeBDiev2UU7c+iHEfUXqkJoC06tnRtAmVATMUjcWwTJ/zzAM4/mRsePDjRcJxiVmpmZ
	9QMqjWmuXHg+RXW/AukgEztlsqDb/0rEmMEldRSnbp3z1O9hiNDe3yYFppq3l0utRIt5qooaYzk
	LEbL6inPEq2Mg24tissTZFDNjvU40jtxklMVGWzlXfZPO1SwQa1UEoMs9Ksl6le9RZfWYRLyz8Q
	QIvmdO9vOZHqlAjkD+yMnOAKDNEMGnjcG+wLCNuGhhRz4/IPhwR5zO5a/kt6CuDjjT1y8k9dZBo
	Ao7Gor7m7HQHok4T0W7SfOEekAQZsBRSNR9z3lkPJLkgV2ZG4pS4Yk3HsAJI4IlO2K4fplEE4sa
	zzQ4dK99n1Yzhj/Rv6CV6HMgVuaFzsGWiFjS6lSLPHTlJr+zdkECagIjpvdOhMuMEQQ7lU2WkYT
	ZPmfm9Fw==
X-Received: by 2002:a05:600c:64cd:b0:485:3cf3:1010 with SMTP id 5b1f17b1804b1-488d67df592mr301858635e9.2.1776254092798;
        Wed, 15 Apr 2026 04:54:52 -0700 (PDT)
X-Received: by 2002:a05:600c:64cd:b0:485:3cf3:1010 with SMTP id 5b1f17b1804b1-488d67df592mr301858195e9.2.1776254092308;
        Wed, 15 Apr 2026 04:54:52 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ee038752sm128635425e9.9.2026.04.15.04.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:54:51 -0700 (PDT)
Date: Wed, 15 Apr 2026 13:54:43 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/3] vsock/test: fix MSG_PEEK handling in
 recv_buf()
Message-ID: <ad96TgXHW_jKitls@sgarzare-redhat>
References: <20260414-fix_peek-v3-0-e7daead49f83@redhat.com>
 <20260414-fix_peek-v3-2-e7daead49f83@redhat.com>
 <ad9uYrUjgCkW1D_k@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ad9uYrUjgCkW1D_k@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v9CtcDIp9d7PYA9HP5YqV9bB6SWiKeSUWwGvC3b3p-s_1776254093
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Apr 15, 2026 at 01:31:11PM +0200, Stefano Garzarella wrote:
>On Tue, Apr 14, 2026 at 06:10:22PM +0200, Luigi Leonardi wrote:
>>`recv_buf` does not handle the MSG_PEEK flag correctly: it keeps calling
>>`recv` until all requested bytes are available or an error occurs.
>>
>>The problem is how it calculates the amount of bytes read: MSG_PEEK
>>doesn't consume any bytes, will re-read the same bytes from the buffer
>>head, so, summing the return value every time is wrong.
>>
>>Moreover, MSG_PEEK doesn't consume the bytes in the buffer, so if the
>>requested amount is more than the bytes available, the loop will never
>>terminate, because `recv` will never return EOF. For this reason we need
>>to compare the amount of read bytes with the number of bytes expected.
>>
>>Add a check, and if the MSG_PEEK flag is present, update the counter of
>>read bytes differently, and break if we read the expected amount.
>
>nit: "..., update the counter for bytes read only after all expected
>bytes have been read and break out of the loop; otherwise, try again
>after a short delay to avoid consuming too many CPU cycles."
>
>>
>>This allows us to simplify the `test_stream_credit_update_test`, by
>>reusing `recv_buf`, like some other tests already do.
>>
>>This also fixes callers that pass MSG_PEEK to recv_buf().
>
>nit: this is implicit from the first part of the description.
>
>>
>>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>---
>>tools/testing/vsock/util.c       | 15 +++++++++++++++
>>tools/testing/vsock/vsock_test.c | 13 +------------
>>2 files changed, 16 insertions(+), 12 deletions(-)
>>
>>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>>index 1fe1338c79cd..2c9ee3210090 100644
>>--- a/tools/testing/vsock/util.c
>>+++ b/tools/testing/vsock/util.c
>>@@ -381,7 +381,13 @@ void send_buf(int fd, const void *buf, size_t len, int flags,
>>	}
>>}
>>
>>+#define RECV_PEEK_RETRY_USEC 10
>
>10 usec IMO are a bit low, it could be the same order of the syscalls 
>involved in the loop, I'd go to some milliseconds like we do for 
>SEND_SLEEP_USEC.
>
>>+
>>/* Receive bytes in a buffer and check the return value.
>>+ *
>>+ * MSG_PEEK note: MSG_PEEK doesn't consume bytes from the buffer, so partial
>>+ * reads cannot be summed. Instead, the function retries until recv() returns
>>+ * exactly expected_ret bytes in a single call.
>
>I'd replace with something like this:
>
>   * When MSG_PEEK is set, recv() is retried until it returns exactly
>   * expected_ret bytes. The function returns on error, EOF, or timeout
>   * as usual.
>
>Thanks,
>Stefano
>
>> *
>> * expected_ret:
>> *  <0 Negative errno (for testing errors)
>>@@ -403,6 +409,15 @@ void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
>>		if (ret <= 0)
>>			break;
>>
>>+		if (flags & MSG_PEEK) {
>>+			if (ret == expected_ret) {

On second thought, I think it would be more appropriate to check for
`ret >= expected_ret` here, because all subsequent recv() will
definitely return more bytes, so there’s no point in continuing the
loop... and anyway, we’ll check the result later, so just that change
should be fine.

And of course I'd update the comment on top in this way:

    * When MSG_PEEK is set, recv() is retried until it returns at least
    * expected_ret bytes. The function returns on error, EOF, or timeout
    * as usual.

Thanks,
Stefano

>>+				nread = ret;
>>+				break;
>>+			}
>>+			timeout_usleep(RECV_PEEK_RETRY_USEC);
>>+			continue;
>>+		}
>>+
>>		nread += ret;
>>	} while (nread < len);
>>	timeout_end();
>>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>>index 5bd20ccd9335..bdb0754965df 100644
>>--- a/tools/testing/vsock/vsock_test.c
>>+++ b/tools/testing/vsock/vsock_test.c
>>@@ -1500,18 +1500,7 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
>>	}
>>
>>	/* Wait until there will be 128KB of data in rx queue. */
>>-	while (1) {
>>-		ssize_t res;
>>-
>>-		res = recv(fd, buf, buf_size, MSG_PEEK);
>>-		if (res == buf_size)
>>-			break;
>>-
>>-		if (res <= 0) {
>>-			fprintf(stderr, "unexpected 'recv()' return: %zi\n", res);
>>-			exit(EXIT_FAILURE);
>>-		}
>>-	}
>>+	recv_buf(fd, buf, buf_size, MSG_PEEK, buf_size);
>>
>>	/* There is 128KB of data in the socket's rx queue, dequeue first
>>	 * 64KB, credit update is sent if 'low_rx_bytes_test' == true.
>>
>>-- 
>>2.53.0
>>

