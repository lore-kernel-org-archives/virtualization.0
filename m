Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F2A39E18F
	for <virtualization@lists.linux.dev>; Wed,  8 Apr 2026 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775642633; cv=none; b=m4oYuHg5atjc44GshiMpHfNb4bLT+2cl9++gi+X86Sh22NlLnq1etVn0J68xikCcnUjZ1XMyR/AuTzLMO5IIZn/GObdl1CuzLKyWcNy4CTE6ndtLa1O2UmUvPMIN2VydCvAnvvPpUA4hgBzakWC8LOhk4wSK3fZjMqDVPPWHq3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775642633; c=relaxed/simple;
	bh=o4+1SC+5gK72xbVuKMA8stLflF08ngrXS2p6EHL26qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZGs0vRucFbNGN7kagdSpFab0GsnrQSoHqqu+MkGZeRG8KZQx9mBfMFnFtY4Ralces9ru+yydj2u0QCmCaTpBMRs92nn0bq1kKQ9oHY6j5mOOeDdRA7cATKGWZ6/Qx1lz2jy2zAzdyhRN+6q96C5wAIcvhx0U7nFDyTBfD6Gm7Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gDfDZ6VE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDfDZ6VE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775642622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GvW8ppuKlGxLvKsyNaJZSa2eFAuH1JA79Zx9MBFdNuc=;
	b=gDfDZ6VEH4OgGWkxTxJwPZ2wMYOH0Zi5oTHPONIFST2YbBD5Q8ZtRiLLpyI0GHYNsR1QUb
	5/Iy+fGWlHEg7cAoyjaeGn13rRQXbyW0gvJ6E2LDUAKimgUAXm/8Fsze/SF+lyWC8kDEnp
	A+ugLuY4rZEa7xBaYLzR3AI2pFNiew0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-xQWlihXqNpiWnIoojrZGEw-1; Wed, 08 Apr 2026 06:03:41 -0400
X-MC-Unique: xQWlihXqNpiWnIoojrZGEw-1
X-Mimecast-MFC-AGG-ID: xQWlihXqNpiWnIoojrZGEw_1775642620
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488b966e9dbso16000395e9.3
        for <virtualization@lists.linux.dev>; Wed, 08 Apr 2026 03:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775642620; x=1776247420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvW8ppuKlGxLvKsyNaJZSa2eFAuH1JA79Zx9MBFdNuc=;
        b=ep2vSmkD/HRvYJndyUvXwX3gFhroil65/8vud17m1m7BvgXGv5f5TNpmf088i36CTD
         hLL7lAtwk1qga9JI3KA+THTB1PYld//ewJqXepRby1p8fDkSOkKYrkMt8ejAAotPGAxd
         QGE+uNsoXkzKMP/Cy6whdK43EcHWH0FRf70iaQ4Fqs20XmJYD3dW0OgPkQee7qB5DVli
         gJqsd7YO3OtknKpCUf6xDQDBI/S5nbIKamXRbC0AtHiSk32D9j1wnoL6ePFHjzWTOXx/
         eVu0qxMjXAgy3MXPMshko5DyHQ86cj2pEyAN8g0fTbSpDbi9oiuQRbDt6OM7QGm5OOpy
         xETQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrRxZbqBcCK4QUCbzHZuAyAuJjNC4zIoBL5aVsgH1EnqD28vqC1y2ePWWGZLkmzTz3wQS8mIMpuPyUjeQhyw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyo8T1pXnt4dUQaKor1WL/o/7fq+uCkytyYlAdzjO4wIJ9uwWew
	DKgKIMl2n2WbqA77zst5zCFwV3rlkdfgBM9vs0tV2ur9zp1GV1a50CHZUHghxtKGutFL0Ezmjby
	N6S7pXb0AtKWpSDbj0HgG85TOq0Ot7aND8DqA45HQPWsWwo1Aq0hwC+VyzXLgjT+a9tBS
X-Gm-Gg: AeBDietfwZ1SbeazEa/DcYjRQHePtMLVd8exRWvpz4SSxgTnzx8qL2WjukzmFfaXtS1
	ApUrZdbe+TDDf1sxMcETQVjKTaAls8JDP0QxifOykiRLQY+n+7QaZOFktIvkt62DLWgNTHSZ4os
	tAo6p6DF8DUbRvWLbVJ88zOtnY2vSdyAM8mqhbaRKflRazpbL8FVa6WOCLct071UQTehUbnT2h0
	xpxYeH9Wy41yN7Q0rCL+TT3vN61tqzo1fNcxgL4sFExmFoKQ2kjR/MYAvJg8YhUvCV9YSfQ2VHL
	XTur7uM0t+CpOEEIw9j7L4dlXZvTIF+DmfftQKewVsa+1UrRY3sCvidLGczEs0jYc+V6R1iPfUM
	ATn1xxx8tsGHVMzsOLqbjd9KwBAUnPyB9um3hp6+rOSikLD10KYgEsZD+QMWRikZRVg/F5h96GQ
	==
X-Received: by 2002:a05:600c:8b03:b0:488:81b1:ae36 with SMTP id 5b1f17b1804b1-488997d3188mr291773185e9.23.1775642620044;
        Wed, 08 Apr 2026 03:03:40 -0700 (PDT)
X-Received: by 2002:a05:600c:8b03:b0:488:81b1:ae36 with SMTP id 5b1f17b1804b1-488997d3188mr291772635e9.23.1775642619553;
        Wed, 08 Apr 2026 03:03:39 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-236.retail.telecomitalia.it. [79.45.205.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488b0c53a27sm229454385e9.7.2026.04.08.03.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 03:03:38 -0700 (PDT)
Date: Wed, 8 Apr 2026 12:03:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/3] vsock/test: handle MSG_PEEK in `recv_buf`
Message-ID: <adYkNiNL18aOv74T@sgarzare-redhat>
References: <20260407-fix_peek-v2-0-2e2581dc8b7c@redhat.com>
 <20260407-fix_peek-v2-2-2e2581dc8b7c@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260407-fix_peek-v2-2-2e2581dc8b7c@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GuyNc633AFG-uTXMlWZYtwBwtkXk8usl6o6t6qEdJHo_1775642620
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Apr 07, 2026 at 11:13:56AM +0200, Luigi Leonardi wrote:
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
>
>This allows us to simplify the `test_stream_credit_update_test`, by
>reusing `recv_buf`.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> tools/testing/vsock/util.c       |  8 ++++++++
> tools/testing/vsock/vsock_test.c | 13 +------------
> 2 files changed, 9 insertions(+), 12 deletions(-)
>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 9430ef5b8bc3..f12425ca99ed 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -399,6 +399,14 @@ void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
> 		if (ret == 0 || (ret < 0 && errno != EINTR))
> 			break;
>

We should add a comment here or even better in the documentation on top 
of the function to explain better this behaviour for future reference.

>+		if (flags & MSG_PEEK) {
>+			if (ret == expected_ret) {
>+				nread = ret;
>+				break;
>+			}

Not that I expect this to happen often, but I wonder if it would be 
better to add a `timeout_usleep()` here to avoid using up too many CPU 
cycles.

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

Not sure about this change in this patch, but since they are just tests 
it could be fine.

mmm, on a second thought, we already used recv_buf() with MSG_PEEK in 
several other tests, so yep, better to add this change, but I'd make 
more clear in the commit title/description that this is at the end a fix 
for other tests using MSG_PEEK with recv_buf(), I mean something like 
this:

     vsock/test: fix MSG_PEEK handling in recv_buf()

And also pointing out that other tests already used MSG_PEEK with 
recv_buf(), but it can be broken in some cases.

Thanks,
Stefano

