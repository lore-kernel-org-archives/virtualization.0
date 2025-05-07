Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB86228B3FA
	for <virtualization@lists.linux.dev>; Wed,  7 May 2025 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632531; cv=none; b=ejHdm0FxV+zS6LlPIV7HZYW6H8EBzf6Of/+7gNoDGjIjiW4zL7aZbQ6c1mNRPYc4uV++vHSYUcf8/CxkdNje2MtfqhHzbSPk5WS49wxo3j9Accr0kHWM0am/2nUPh+D8j5hWy1QLSOFnihFy9qrbjxHxR3sNGjBPWzz0OQJzask=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632531; c=relaxed/simple;
	bh=kNco2fCmuCqlZLOuCofYzSrVlJqJQWrGuA4zIfOv1wQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOzjCJM9PCNhK5F4D2VQtgmwAEboRWdyCHFoW9y+48L4h3gDQgkloSa740fzSNq6AD+X2QOxGf/BT+XOK8uZA8yi1MiEpQNuq+Zev95rKfjKlK0hUHUdWmZwakVMeAk08T9Y6Oq09Io8B56nNxemhJ56zgoUxjdPz/ZX92Xw/kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZCbUFM7B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCbUFM7B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746632527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+lio/+Ao1S9W+X9/4Leo17kpbIzqZzZSZhwzb8sw/wo=;
	b=ZCbUFM7BUiI9dAfcbh+RK/Le+9z3iXKXtSxHSgZImUuX7XoYPwkCSfOhUSHP1zuExq6th+
	CaynI8NOA3wxaaFHohhiPJI0tHWPLpibFqjYBk849lzAtK/IbXOVNcLFWSp5oNyFoN7YCd
	Y4A9KlLSNYEwTu4V0fcRK6zpgfFavLQ=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-mdgKaU6rNEScEMcWIcXEPQ-1; Wed, 07 May 2025 11:42:06 -0400
X-MC-Unique: mdgKaU6rNEScEMcWIcXEPQ-1
X-Mimecast-MFC-AGG-ID: mdgKaU6rNEScEMcWIcXEPQ_1746632526
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-700b176189dso97041857b3.3
        for <virtualization@lists.linux.dev>; Wed, 07 May 2025 08:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746632526; x=1747237326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+lio/+Ao1S9W+X9/4Leo17kpbIzqZzZSZhwzb8sw/wo=;
        b=iN9RMwOvYdrdtfCq4FZilrZ+qnDSo95AHuVhlJyzsF620ZtKIwe1ApADmh3GjUiONL
         Jp+ALzwRDaR/NgWTMVto763fBs909VV5wDxMwARqp/BjHWtefVM+4guzfZkWK4y1bTKM
         Mq8cg36RJGF5yGrwal/IJwNLP0XkBhvbobX6Rv+J8lDX2/ezp8W/lsEt5xZLRD5iQAgM
         Dk8QpdqrOczeAftndGvFh9/zo7i+u/DCoxcCZG2ppAwPHmj3Y2xfpskupjDTRSMnDHoR
         4LvUKDS9xjzavrYSh30J5JxehQ5Va8LsGCqwY0YEtidpJ59MMBTmFF4GwmPx5bcGaZre
         rw+g==
X-Gm-Message-State: AOJu0YzRRObLJZXi4xCs/xkroclE6yAezQS2nAR0AAg0liQqasq7ZZEy
	H18OF7Yg9My73DypddP09OYO5PqXU8HQeNMMBOxkuyqhlATAb6FEW5QLIvzFAXX7Mwxhyth/HRj
	aEaqTq5j9PaD9EXxGsqfBsJe4CYqD/O15aKQ+5xePsqrTjBj+wzbB9X7L/H9a9JjNmiCRp8S/r2
	hJr9QJGJw1+4dYte7QITwEaA9cjtPtT7hVnq28yGQ=
X-Gm-Gg: ASbGncvhB3tMcdAZunY2luXgrzaCRBk0LjirVy/j+hsyzuexTtKwHQ4N7Cmyoenc7nQ
	FGqHSYJD8jd8S4gMxc88cJIDqZ0fWYJZj4KzXQ136AJo6nAwnlZ8cR9yLr29Lar8tfPf0Mg==
X-Received: by 2002:a05:690c:7204:b0:703:d0b5:7abc with SMTP id 00721157ae682-70a1d9f796amr52747607b3.9.1746632525930;
        Wed, 07 May 2025 08:42:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8lPZotZaA5SL3FWz6OPzfNFbWEJ+cXzbhHRMG1e8KklFqxYBqaKjznxq7FTFilMNXTgNWtfPjnZtzwsZAvl4=
X-Received: by 2002:a05:690c:7204:b0:703:d0b5:7abc with SMTP id
 00721157ae682-70a1d9f796amr52747237b3.9.1746632525562; Wed, 07 May 2025
 08:42:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250507151456.2577061-1-kshk@linux.ibm.com>
In-Reply-To: <20250507151456.2577061-1-kshk@linux.ibm.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 7 May 2025 17:41:54 +0200
X-Gm-Features: ATxdqUEJ8STQu0YGygVRKeGWq1W_9YLNgZZxTRzXDHhASTqBwvXiIOk6Dpf4Fis
Message-ID: <CAGxU2F6ssoadHjCH9qi6HdaproC3rH=d-CdYh2mvK+_X4-C4nw@mail.gmail.com>
Subject: Re: [PATCH net v2] vsock/test: Fix occasional failure in SIOCOUTQ tests
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O0JgqxGKGub2MYMHprbwQCci4vbjt8EHOE6l_jO5XNM_1746632526
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 May 2025 at 17:15, Konstantin Shkolnyy <kshk@linux.ibm.com> wrote:
>
> These tests:
>     "SOCK_STREAM ioctl(SIOCOUTQ) 0 unsent bytes"
>     "SOCK_SEQPACKET ioctl(SIOCOUTQ) 0 unsent bytes"
> output: "Unexpected 'SIOCOUTQ' value, expected 0, got 64 (CLIENT)".
>
> They test that the SIOCOUTQ ioctl reports 0 unsent bytes after the data
> have been received by the other side. However, sometimes there is a delay
> in updating this "unsent bytes" counter, and the test fails even though
> the counter properly goes to 0 several milliseconds later.
>
> The delay occurs in the kernel because the used buffer notification
> callback virtio_vsock_tx_done(), called upon receipt of the data by the
> other side, doesn't update the counter itself. It delegates that to
> a kernel thread (via vsock->tx_work). Sometimes that thread is delayed
> more than the test expects.
>
> Change the test to poll SIOCOUTQ until it returns 0 or a timeout occurs.
>
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> ---
> Changes in v2:
>  - Use timeout_check() to end polling, instead of counting iterations.

Why removing the sleep?

Thanks,
Stefano

>
>  tools/testing/vsock/vsock_test.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
> index d0f6d253ac72..613551132a96 100644
> --- a/tools/testing/vsock/vsock_test.c
> +++ b/tools/testing/vsock/vsock_test.c
> @@ -1264,21 +1264,25 @@ static void test_unsent_bytes_client(const struct test_opts *opts, int type)
>         send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
>         control_expectln("RECEIVED");
>
> -       ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
> -       if (ret < 0) {
> -               if (errno == EOPNOTSUPP) {
> -                       fprintf(stderr, "Test skipped, SIOCOUTQ not supported.\n");
> -               } else {
> +       /* SIOCOUTQ isn't guaranteed to instantly track sent data. Even though
> +        * the "RECEIVED" message means that the other side has received the
> +        * data, there can be a delay in our kernel before updating the "unsent
> +        * bytes" counter. Repeat SIOCOUTQ until it returns 0.
> +        */
> +       timeout_begin(TIMEOUT);
> +       do {
> +               ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
> +               if (ret < 0) {
> +                       if (errno == EOPNOTSUPP) {
> +                               fprintf(stderr, "Test skipped, SIOCOUTQ not supported.\n");
> +                               break;
> +                       }
>                         perror("ioctl");
>                         exit(EXIT_FAILURE);
>                 }
> -       } else if (ret == 0 && sock_bytes_unsent != 0) {
> -               fprintf(stderr,
> -                       "Unexpected 'SIOCOUTQ' value, expected 0, got %i\n",
> -                       sock_bytes_unsent);
> -               exit(EXIT_FAILURE);
> -       }
> -
> +               timeout_check("SIOCOUTQ");
> +       } while (sock_bytes_unsent != 0);
> +       timeout_end();
>         close(fd);
>  }
>
> --
> 2.34.1
>

