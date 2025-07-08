Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91E121639B
	for <virtualization@lists.linux.dev>; Tue,  8 Jul 2025 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751976967; cv=none; b=tNd3RUjTLMqiJb7SeyVWNaN9+0iT7QbSIq9IMaEA/N4F2S+nkNOlPR55sotPbaZbBASX1pIRm4VQQ600xC24QUsFCZl3bQ9yI3ZHejqTOOvV5Et1kdGFsAF3X4bnAOe8jwRajy9foz7Kr3+PsUGpdKR9byVQ1/xiP0vp3ExfUxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751976967; c=relaxed/simple;
	bh=mMvwMZD9hLg9tRND9y9AFG++SVAM192V2riYe9IuSMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nGIffIboOIttfFJmmOTItMxEaivC6QSJcZ2yld/+71iMBMA37K7aBhndCLvDUFK0RQpTtxwp+Ksg6et+05Bid0p5Cp0pFg3IuNtU0pW9+eMXsPIAzp9VtsryRX6Z4Evd2cY2G3/t1egAUKi5SYggr57GS/aUa/bnFggApNKBCtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MJCJhGu6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJCJhGu6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751976963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XZQq54vH7L1wrrcZbYcmRkAtOhIXsJTAbiqEq5oFXQM=;
	b=MJCJhGu61XrCOZ1XZ6QdudkpYAdpQ0MTcubVe3cQFu2wRcocLDqTR8KJawcpRBS88Kvd0B
	mDwx7ZrPOWhE4JSs25cG6mvOdR/DYAO90IRG+gkM8p5AZTAPbAgow0f48yC6MpJt1S0j2f
	U6hgEBNvEuPkJ5maVS0Af6WRGxqBceY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-cdxKlWYdP7-fcAovngG05w-1; Tue, 08 Jul 2025 08:16:02 -0400
X-MC-Unique: cdxKlWYdP7-fcAovngG05w-1
X-Mimecast-MFC-AGG-ID: cdxKlWYdP7-fcAovngG05w_1751976962
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d3f0958112so628398085a.0
        for <virtualization@lists.linux.dev>; Tue, 08 Jul 2025 05:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751976962; x=1752581762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZQq54vH7L1wrrcZbYcmRkAtOhIXsJTAbiqEq5oFXQM=;
        b=aS0I5yGus0oSLqNT5dfpMLGwTwtu82VEbpycWEZf2j1ka/AuD4aI82oWgw9ITYm3Nk
         QD1A3ygok9G6c7qp66fsBXqWZ3OCUm1fXwV0esyzynoHwJuEg2uFdEoyXmtXbjbdAgu/
         Q4VGjHDwSL2KrmvPSTO7LUda10/LeFrFr6jXPisrBzo8xJygqM0Xfe9hVow8BvIuKiaM
         h+1KAE1KrCDeCGJ7PLHzXvZq+6SPcNiLZqwlmJSFe5Igjhm48x8+rE8rX6aUNXaG9duH
         cVJsyGUQ6hR/fCtvBOHvTE4/AgE0sN3eIAWr6O4N6MDp/xg5xFNebrGeMtEI+PVTp6F5
         dbLg==
X-Forwarded-Encrypted: i=1; AJvYcCU1Cm9efRLj3CaSTOjZkuA/NDQ2T+D6kb1jYTsOCkUklbcf5wqC9+8a5s7hgj0qDfxJT3u9gSqxAf8wHSQhVw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRualOesjTnoJqmF4aS5kCd3lqe6h2UMdXxGtr5ijSrLQm8JQ2
	DEjnDdgnEWV7J4aKtZyhuQwOjgsSaramthAenNA5Bw56Stekq5pFxVLlsW77WW+xcVRUdUaFONY
	tLJ6I5L2SaTMhRIkeEkqEfgzbJoYWSIiiQwVSToDir6FO+6UBKWE67wRc8grzQSEcc94UHPcKSy
	7NVV0=
X-Gm-Gg: ASbGncuinKqQDtGgt+54Zy8IC+GmFiORMPFmZJzeJJFvlUu/zgh+IOyjk4GyLHtQ+L5
	FMCM/4Yyegnjy+pFP4fhXer4dMPz9egcosE2ZVAiUuv6+CIHOKjvU32TK4YedUQozqqrQTaXsT1
	Qm2jATkV3CDxuZ20sVWt88PIDSh7MXaG1/D5YHH9LCk86M/1gcP0H/rpDzVLupj8hPxdF0Km281
	wK8qgvnpqAcY/I/vG16MoQc0qHMS8WUgHDIn56fpipWjrk45y9GOUpUnDNOGJyRmZtPh6w73mUL
	/uHV2ocuUFYkLF7oBM7KT3Ce2vU=
X-Received: by 2002:a05:620a:1789:b0:7d4:5854:32ab with SMTP id af79cd13be357-7da034a52bfmr499248285a.36.1751976962014;
        Tue, 08 Jul 2025 05:16:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp808SkN2VjVP2MnyxHqj6j8BNYJYFMs1ro4neDCuuVkG+IqYJqwBjuFfETrwpfdtLPBIpUA==
X-Received: by 2002:a05:620a:1789:b0:7d4:5854:32ab with SMTP id af79cd13be357-7da034a52bfmr499245485a.36.1751976961632;
        Tue, 08 Jul 2025 05:16:01 -0700 (PDT)
Received: from leonardi-redhat ([176.206.17.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbdbb957sm769232885a.37.2025.07.08.05.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 05:16:01 -0700 (PDT)
Date: Tue, 8 Jul 2025 14:15:58 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock/test: fix test for null ptr deref when
 transport changes
Message-ID: <2bqmwv7oyo4zs2fszonhkt5vup5zhbuai4p6ylevkwktihm6au@kokjoj5dgnbb>
References: <20250708111701.129585-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250708111701.129585-1-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G-s-C9R1V9RPwoIl8Q6mFWg3rvSRA4lLPtJo0ST7OBM_1751976962
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jul 08, 2025 at 01:17:01PM +0200, Stefano Garzarella wrote:
>From: Stefano Garzarella <sgarzare@redhat.com>
>
>In test_stream_transport_change_client(), the client sends CONTROL_CONTINUE
>on each iteration, even when connect() is unsuccessful. This causes a flood
>of control messages in the server that hangs around for more than 10
>seconds after the test finishes, triggering several timeouts and causing
>subsequent tests to fail. This was discovered in testing a newly proposed
>test that failed in this way on the client side:
>    ...
>    33 - SOCK_STREAM transport change null-ptr-deref...ok
>    34 - SOCK_STREAM ioctl(SIOCINQ) functionality...recv timed out
>
>The CONTROL_CONTINUE message is used only to tell to the server to call
>accept() to consume successful connections, so that subsequent connect()
>will not fail for finding the queue full.
>
>Send CONTROL_CONTINUE message only when the connect() has succeeded, or
>found the queue full. Note that the second connect() can also succeed if
>the first one was interrupted after sending the request.
>
>Fixes: 3a764d93385c ("vsock/test: Add test for null ptr deref when transport changes")
>Cc: leonardi@redhat.com
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> tools/testing/vsock/vsock_test.c | 21 ++++++++++++++++-----
> 1 file changed, 16 insertions(+), 5 deletions(-)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index be6ce764f694..630110ee31df 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1937,6 +1937,7 @@ static void test_stream_transport_change_client(const struct test_opts *opts)
> 			.svm_cid = opts->peer_cid,
> 			.svm_port = opts->peer_port,
> 		};
>+		bool send_control = false;
> 		int s;
>
> 		s = socket(AF_VSOCK, SOCK_STREAM, 0);
>@@ -1957,19 +1958,29 @@ static void test_stream_transport_change_client(const struct test_opts *opts)
> 			exit(EXIT_FAILURE);
> 		}
>
>+		/* Notify the server if the connect() is successful or the
>+		 * receiver connection queue is full, so it will do accept()
>+		 * to drain it.
>+		 */
>+		if (!ret || errno == ECONNRESET)
>+			send_control = true;
>+
> 		/* Set CID to 0 cause a transport change. */
> 		sa.svm_cid = 0;
>
>-		/* Ignore return value since it can fail or not.
>-		 * If the previous connect is interrupted while the
>-		 * connection request is already sent, the second
>+		/* There is a case where this will not fail:
>+		 * if the previous connect() is interrupted while the
>+		 * connection request is already sent, this second
> 		 * connect() will wait for the response.
> 		 */
>-		connect(s, (struct sockaddr *)&sa, sizeof(sa));
>+		ret = connect(s, (struct sockaddr *)&sa, sizeof(sa));
>+		if (!ret || errno == ECONNRESET)
>+			send_control = true;
>
> 		close(s);
>
>-		control_writeulong(CONTROL_CONTINUE);
>+		if (send_control)
>+			control_writeulong(CONTROL_CONTINUE);
>
> 	} while (current_nsec() < tout);
>
>-- 2.50.0
>

LGTM!
Thanks for the fix!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

