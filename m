Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7631DF74F
	for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776252700; cv=none; b=pxmc9dmzWI0lIFEF1nKX0qZ/FNXa9/KoWLePA4Ci7MWODffBnIC5vCz+WzThFtKy95ZhkmDxODtYUjaFgIGg2ZKtP9fslboXPhIEP7p8OZhfP6OHnR/98aGy30wvAL2WyWojduCqq7QSIUpeFMSTD/fOlYPAL7Az9UxsNWxDEc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776252700; c=relaxed/simple;
	bh=QLX1J418M4jWHF/CD6zKmlQZG8fsqg6qyHarNz+l24E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bxXGSOwdFfuwRMrAzlrrsP7f5aLYCs538yiO3Znqz5x0YjxeBwJ3XiaSnul5Bvv+/GKzVvWvZrOlx23oSQAzAH38mth5bS5KkggCyBwGkQxCG76ODpcYD5vJHdqjiUEtydk9r83w3N+dlCmtA3RaZLOsFWRcHaBnuut+BUHwr0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f2nf7olA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2nf7olA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776252697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VGpVm/oGR94wogmAdWmA8vqPEnCDIzFyVWrXuXhdJ4U=;
	b=f2nf7olAztvNmNsEpMWPTH46rdxshFlVR/Y+o5kEmDhoyLX72y4zAboS9xTnrvmmIskzXs
	oM32zm2lX/AIIlK8BWqOhyw8dile2uMX12GmC5mmZ/beBYxct4U8wybF2cPRcPur/42LuV
	Xc9PEypVSLKw5lxPyLsdMqhNFPHr+nI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-q-cBvc6VMT2nefIcJKxvtQ-1; Wed, 15 Apr 2026 07:31:36 -0400
X-MC-Unique: q-cBvc6VMT2nefIcJKxvtQ-1
X-Mimecast-MFC-AGG-ID: q-cBvc6VMT2nefIcJKxvtQ_1776252695
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488d9e1e61aso35565805e9.0
        for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 04:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776252695; x=1776857495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGpVm/oGR94wogmAdWmA8vqPEnCDIzFyVWrXuXhdJ4U=;
        b=K2PnJGZb5KG3T7vJ8iUslRHUtD4EXeUK6ZNrgIHtV2zF9Ux0Bac6xyR7e5VeS3Vj+C
         xTzhvZTdvFQZb1axOCpyDxHyQsBaKmdkssUKSuXdUOBnqqa+zUHJZnXyrydgOWaN6Ogi
         lfJoIDgCBkYWVtAgfg5N4N3BnUSRz9boDvWyEtlKHuqkOX1t9NoKBeWFU3lx4jmj3uZh
         qqtPgVE2JUbspnPCJ+oRNVk3ugJ3+lCMi28I6WPfJE9QhOOOGYYh4yVdZeWiVrwkEvb7
         Wvp+f0r0JETxge+o4p2tWjtTvtxyhNhAG/aCPX2/9VInqDVtZONUAY4EQpRdFqXNzs2h
         iy4g==
X-Forwarded-Encrypted: i=1; AFNElJ+rYSlvyD6abm7PAAqw941uZRZuyN6ozbWdKSfYKRzqO8oI/cEM/JmqBj4nWm2j89s0MQkvpj5xqWjB6CAbUw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIJNYQbAJXPYFEuJ4DG3A8u4sbJCNnwZ7EmcV0Nx5OljphXswN
	15PsgB2hmJ+HPmTTJb76v3KRs2r9AoErNo/EnDXC8R6T01F0my4MAi//ZcQ9J6q68kCu+nzz7Qq
	KCJ/Ora0uzxaCMc78iVD1ngLAKJfc9Q6AsjhW/DdS0LW6ela3YU87bECLcdvm++tIkaBw
X-Gm-Gg: AeBDietQ0a2QrA2ov8GHegS/cr0aNGnZaK4nN65xN/F9mVDlRPj8i8F42M65T/lX5Jv
	PBYoA9EYGHJ8Kfp4raPscGbV4gbAgmGFE4Kh9F5Hb5rM6HazsmKgrHWf0cKjEr2PO4VOnMjU1RE
	tZJlha5XunLNNDX/yV/jiV1NbUY8krEclHsOv9HxfgtDY9YAfaXitNykEiS7QZJRbFhuCU9+ci/
	TuRgZmNetidkkiXmAtza7vxMsv0x9Qukk8Cx+7TiaZjjPVY68/ansg4J4I/3Aqk03hj2AcZKqvQ
	59zYOYYH5dmj6vf+zMqymvPKGm4K6GBD5wfCmAqfzdQzou+MqyfTCw0Vihc25TPeXha59nv2czr
	WtG7bucraMwe9a2I6+GcfG3Wyv/aH/Qrw0VNls8qeSEFxd5IHvtA1VlF1q/V0Nc8qg80ZBPHpsU
	30iIvz0Q==
X-Received: by 2002:a05:600c:c108:b0:488:c282:e78c with SMTP id 5b1f17b1804b1-488d684bd3amr202998355e9.19.1776252695213;
        Wed, 15 Apr 2026 04:31:35 -0700 (PDT)
X-Received: by 2002:a05:600c:c108:b0:488:c282:e78c with SMTP id 5b1f17b1804b1-488d684bd3amr202997745e9.19.1776252694669;
        Wed, 15 Apr 2026 04:31:34 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead33d6e9sm4680580f8f.1.2026.04.15.04.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:31:34 -0700 (PDT)
Date: Wed, 15 Apr 2026 13:31:11 +0200
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
Message-ID: <ad9uYrUjgCkW1D_k@sgarzare-redhat>
References: <20260414-fix_peek-v3-0-e7daead49f83@redhat.com>
 <20260414-fix_peek-v3-2-e7daead49f83@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260414-fix_peek-v3-2-e7daead49f83@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: adoDeyc-rWfiSxYAKzvptBrQ4AOzH9FOql6Solk72HM_1776252695
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Apr 14, 2026 at 06:10:22PM +0200, Luigi Leonardi wrote:
>`recv_buf` does not handle the MSG_PEEK flag correctly: it keeps calling
>`recv` until all requested bytes are available or an error occurs.
>
>The problem is how it calculates the amount of bytes read: MSG_PEEK
>doesn't consume any bytes, will re-read the same bytes from the buffer
>head, so, summing the return value every time is wrong.
>
>Moreover, MSG_PEEK doesn't consume the bytes in the buffer, so if the
>requested amount is more than the bytes available, the loop will never
>terminate, because `recv` will never return EOF. For this reason we need
>to compare the amount of read bytes with the number of bytes expected.
>
>Add a check, and if the MSG_PEEK flag is present, update the counter of
>read bytes differently, and break if we read the expected amount.

nit: "..., update the counter for bytes read only after all expected
bytes have been read and break out of the loop; otherwise, try again
after a short delay to avoid consuming too many CPU cycles."

>
>This allows us to simplify the `test_stream_credit_update_test`, by
>reusing `recv_buf`, like some other tests already do.
>
>This also fixes callers that pass MSG_PEEK to recv_buf().

nit: this is implicit from the first part of the description.

>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> tools/testing/vsock/util.c       | 15 +++++++++++++++
> tools/testing/vsock/vsock_test.c | 13 +------------
> 2 files changed, 16 insertions(+), 12 deletions(-)
>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 1fe1338c79cd..2c9ee3210090 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -381,7 +381,13 @@ void send_buf(int fd, const void *buf, size_t len, int flags,
> 	}
> }
>
>+#define RECV_PEEK_RETRY_USEC 10

10 usec IMO are a bit low, it could be the same order of the syscalls 
involved in the loop, I'd go to some milliseconds like we do for 
SEND_SLEEP_USEC.

>+
> /* Receive bytes in a buffer and check the return value.
>+ *
>+ * MSG_PEEK note: MSG_PEEK doesn't consume bytes from the buffer, so partial
>+ * reads cannot be summed. Instead, the function retries until recv() returns
>+ * exactly expected_ret bytes in a single call.

I'd replace with something like this:

    * When MSG_PEEK is set, recv() is retried until it returns exactly
    * expected_ret bytes. The function returns on error, EOF, or timeout
    * as usual.

Thanks,
Stefano

>  *
>  * expected_ret:
>  *  <0 Negative errno (for testing errors)
>@@ -403,6 +409,15 @@ void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
> 		if (ret <= 0)
> 			break;
>
>+		if (flags & MSG_PEEK) {
>+			if (ret == expected_ret) {
>+				nread = ret;
>+				break;
>+			}
>+			timeout_usleep(RECV_PEEK_RETRY_USEC);
>+			continue;
>+		}
>+
> 		nread += ret;
> 	} while (nread < len);
> 	timeout_end();
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 5bd20ccd9335..bdb0754965df 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1500,18 +1500,7 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
> 	}
>
> 	/* Wait until there will be 128KB of data in rx queue. */
>-	while (1) {
>-		ssize_t res;
>-
>-		res = recv(fd, buf, buf_size, MSG_PEEK);
>-		if (res == buf_size)
>-			break;
>-
>-		if (res <= 0) {
>-			fprintf(stderr, "unexpected 'recv()' return: %zi\n", res);
>-			exit(EXIT_FAILURE);
>-		}
>-	}
>+	recv_buf(fd, buf, buf_size, MSG_PEEK, buf_size);
>
> 	/* There is 128KB of data in the socket's rx queue, dequeue first
> 	 * 64KB, credit update is sent if 'low_rx_bytes_test' == true.
>
>-- 
>2.53.0
>

