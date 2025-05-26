Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB97115687D
	for <virtualization@lists.linux.dev>; Mon, 26 May 2025 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748267772; cv=none; b=OPmmFVGSzcl1NuhkVe0SFTJnPr/EkpFj6wDs4HV8Xg4/K1clCTHzTx1ARMpQMa2utclwXvdxHAFVi9vY/MQ/xEwyq1QFTZK4RSZ6uEQKGpAlYeveeDC5uPLNezdF7Rd9eAhs8dY3Mj8y2y1R3uN+DeZT5oIbKm5NDh4cSBoexL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748267772; c=relaxed/simple;
	bh=8/rgdMR7ZxeHT7lcm2WF5v/murhX9m6bqlwpbwbmYXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TwLBNnvWuS2n39dMcU6ZNy3siu9xl/VV/k6AxgpUC7accZgueVS9tMY8jqysoeizcAJYpUUzAgpvbC9RG+fLtOe7qgKSw1yoi3QfLmdyy2OB+XChN3o6Zn2KctjeXuWRf7TK9Dx0yCNeL0yTvnszRVHZLQKf1zq2X/FosbcjPSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=etoqA2Oq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="etoqA2Oq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748267769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHjg19p96sdYw4xDXVkvX1Jw1LT1R8JNp7/yMvD2jYc=;
	b=etoqA2Oq/tD7MVKlvvCj+8J5BXsKMFUHDbm7Ayk393SbUVjtrUATCKwF2eBJs3+bxRSAwJ
	EBb2Y44qxj7iS35z8sKF/H7FVEyQv+nOtAQ94ltkFf5fP05b/PyDKfdYpCEn6nZNW28fQu
	39Sg9ngN5UquwEti9TEpfzL8TsudqhU=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-q0EnL1f4MleQz-AYr3vQ6w-1; Mon, 26 May 2025 09:56:08 -0400
X-MC-Unique: q0EnL1f4MleQz-AYr3vQ6w-1
X-Mimecast-MFC-AGG-ID: q0EnL1f4MleQz-AYr3vQ6w_1748267768
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-707d49f9c3bso32074497b3.0
        for <virtualization@lists.linux.dev>; Mon, 26 May 2025 06:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748267768; x=1748872568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHjg19p96sdYw4xDXVkvX1Jw1LT1R8JNp7/yMvD2jYc=;
        b=XwY2scwweKhhlmQfjyG8B+qGlSW1F9rDFHV416zimyMQxFvhxMckCjyHi6oolcBRDW
         cMjOJbl6dfIiLv6YB2oZYue2FSmp9CJB568Rd+tsWDQ/Q65v1YKgSrU/eeAkmqa7UK17
         O4JYkoNsi7DONPs5j5I14I7LV3Cn7Ei3qqTQBTr2Cu0FrJ6U6UTvJqkeFzL4HqjTvfEC
         GDYWlifjOReRouMkSqM0G8ihUvX/LwRR2EOVsfhGzWRPXCRSXpcbaqtmMsJFW3zIXE4V
         dbR+hTVU6+ZtjHfkV5F7ELXh9dT6oaPNthnABE39CiP4cCqzPlaOANlIUzLhW7/6L2Up
         KxSA==
X-Gm-Message-State: AOJu0YxWCjRLg/7IgPRyprd6GHFKNiDm9TDufJHTVR3bnNsGuM1VCCx6
	Lth7pUE3fDNKlvoySRbe5dK87a6DSRQyk3WB9XvFQrv9A1a3iQUBuopLAzE+sQd1BX9N4i0XMzI
	u3Yl0tn3qwI8qO8o29zjlbXduVI46e5LIPHf308c4fCBcmXoz7JChGn4cSv0OvQ8IONWxZsM2fn
	+H108rHKusjbH6KomLSzHQ8EXN8c5FbowZLTnQX5g9c8w=
X-Gm-Gg: ASbGncvKLeO6p6vhtg7WrQ80xJ7iRAtZ6bu/ry+gYM75G+ROSnm/d22VAZGO8AdsSMb
	/lve9iUJlwNOyFpiBfSeqpAdWJhkVWl9SIFZKFdXYF8Nians8l5PU0S1VoNoiuUB4Luk=
X-Received: by 2002:a05:6902:726:b0:e7d:9926:8bfa with SMTP id 3f1490d57ef6-e7d992698bamr7492110276.40.1748267767950;
        Mon, 26 May 2025 06:56:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6/c9lr+TAbVpG6J4lomzrC+5Fqw+cD9liLOLTj4YHysZUc3zSZfIwwilBGPgcyufFRQ1Bu826/aDBdCJ/pfU=
X-Received: by 2002:a05:6902:726:b0:e7d:9926:8bfa with SMTP id
 3f1490d57ef6-e7d992698bamr7492081276.40.1748267767587; Mon, 26 May 2025
 06:56:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250526134949.907948-1-kshk@linux.ibm.com>
In-Reply-To: <20250526134949.907948-1-kshk@linux.ibm.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 26 May 2025 15:55:55 +0200
X-Gm-Features: AX0GCFu9lGy_XLKzXTOFqdveWLMPIwPqhG0BIVwB-1v6mcjATpC-MDj6A7atdG4
Message-ID: <CAGxU2F40O3xDSwA4m6r+O5bWoTJgRXqGfyMiLH_sMij+YmE5aw@mail.gmail.com>
Subject: Re: [PATCH net v2] vsock/test: Fix occasional failure in SOCK_STREAM
 SHUT_RD test
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g3-D1cZk_nQ8MtUloHJu9ZdG_Ycu0sZaXfZSG1Egql4_1748267768
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 May 2025 at 15:50, Konstantin Shkolnyy <kshk@linux.ibm.com> wrote:
>
> The test outputs:
> "SOCK_STREAM SHUT_RD...expected send(2) failure, got 1".
>
> It tests that shutdown(fd, SHUT_RD) on one side causes send() to fail on
> the other side. However, sometimes there is a delay in delivery of the
> SHUT_RD command, send() succeeds and the test fails, even though the
> command is properly delivered and send() starts failing several
> milliseconds later.
>
> The delay occurs in the kernel because the used buffer notification
> callback virtio_vsock_rx_done(), called upon receipt of the SHUT_RD
> command, doesn't immediately disable send(). It delegates that to
> a kernel thread (via vsock->rx_work). Sometimes that thread is delayed
> more than the test expects.
>
> Change the test to keep calling send() until it fails or a timeout occurs.
>
> Fixes: b698bd97c5711 ("test/vsock: shutdowned socket test")
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> ---
> Changes in v2:
>  - Move the new function to utils.c.

BTW I think I already fixed the same issue in this series:
https://lore.kernel.org/netdev/20250514141927.159456-1-sgarzare@redhat.com/

Can you check it?

Thanks,
Stefano

>
>  tools/testing/vsock/util.c       | 11 +++++++++++
>  tools/testing/vsock/util.h       |  1 +
>  tools/testing/vsock/vsock_test.c | 14 ++------------
>  3 files changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
> index de25892f865f..04ac88dc4d3a 100644
> --- a/tools/testing/vsock/util.c
> +++ b/tools/testing/vsock/util.c
> @@ -798,3 +798,14 @@ void enable_so_zerocopy_check(int fd)
>         setsockopt_int_check(fd, SOL_SOCKET, SO_ZEROCOPY, 1,
>                              "setsockopt SO_ZEROCOPY");
>  }
> +
> +void vsock_test_for_send_failure(int fd, int send_flags)
> +{
> +       timeout_begin(TIMEOUT);
> +       while (true) {
> +               if (send(fd, "A", 1, send_flags) == -1)
> +                       return;
> +               timeout_check("expected send(2) failure");
> +       }
> +       timeout_end();
> +}
> diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
> index d1f765ce3eee..58c17cfb63d4 100644
> --- a/tools/testing/vsock/util.h
> +++ b/tools/testing/vsock/util.h
> @@ -79,4 +79,5 @@ void setsockopt_int_check(int fd, int level, int optname, int val,
>  void setsockopt_timeval_check(int fd, int level, int optname,
>                               struct timeval val, char const *errmsg);
>  void enable_so_zerocopy_check(int fd);
> +void vsock_test_for_send_failure(int fd, int send_flags);
>  #endif /* UTIL_H */
> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
> index 613551132a96..b68a85a6d929 100644
> --- a/tools/testing/vsock/vsock_test.c
> +++ b/tools/testing/vsock/vsock_test.c
> @@ -1060,15 +1060,9 @@ static void sigpipe(int signo)
>
>  static void test_stream_check_sigpipe(int fd)
>  {
> -       ssize_t res;
> -
>         have_sigpipe = 0;
>
> -       res = send(fd, "A", 1, 0);
> -       if (res != -1) {
> -               fprintf(stderr, "expected send(2) failure, got %zi\n", res);
> -               exit(EXIT_FAILURE);
> -       }
> +       vsock_test_for_send_failure(fd, 0);
>
>         if (!have_sigpipe) {
>                 fprintf(stderr, "SIGPIPE expected\n");
> @@ -1077,11 +1071,7 @@ static void test_stream_check_sigpipe(int fd)
>
>         have_sigpipe = 0;
>
> -       res = send(fd, "A", 1, MSG_NOSIGNAL);
> -       if (res != -1) {
> -               fprintf(stderr, "expected send(2) failure, got %zi\n", res);
> -               exit(EXIT_FAILURE);
> -       }
> +       vsock_test_for_send_failure(fd, MSG_NOSIGNAL);
>
>         if (have_sigpipe) {
>                 fprintf(stderr, "SIGPIPE not expected\n");
> --
> 2.34.1
>

