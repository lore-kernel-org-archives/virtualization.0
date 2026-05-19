Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACA3400E13
	for <virtualization@lists.linux.dev>; Tue, 19 May 2026 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206308; cv=pass; b=PRp84DZXNBumhWJIFP3qkOCTwhg/X61urdb9L0wqxReHcSZnsF01LkaHIJXjvA6dljn3c6rUap2pP6a6Y+tQf8vNnhhoLblKMOzn2fdAsFNhuhKcr8hCE5xNnlzY659wcIAla0igHm6e/8nlCbVTJxOB7S5NO+I0139gEjjKpBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206308; c=relaxed/simple;
	bh=UwfRDIGy2q3FUkgiUSA/dAFUOsVNn+iJpmUP4CYfdjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLcB1UOO93OYeL1A9iG0zxzEfvDGPxfUNE43KfUHwZ7D0d58o9YgeHd7eVmnkoyqbERUfmnWYW2dsiG9Xj9NfEldEefbMvQA7vG1Q1cbFMiI187MYceh90qe5VEem5s6ov3LKnwhVQU3FZgMLgD3r/1cULdxcVADCBjyEgMFn0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=infLD+CE; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="infLD+CE"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-452aacde862so275112f8f.0
        for <virtualization@lists.linux.dev>; Tue, 19 May 2026 08:58:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779206301; cv=none;
        d=google.com; s=arc-20240605;
        b=JtHyCrnqAQoM6YZwLuFzakY5oGOiMd1eba55Xl5dwwZiQKpxVqqzMaa0Y7FW6gh9se
         H7oByM8DsadQ1MX+PZ/7nSoxX+8mtfJxH7X268VYKDjVCxvfbxuj0TLMcqY4twMF2zWA
         BzvIAERrVdHckd0UVWMhVp33dlzYYe76qWjJyI+cbDlbp5EFXN0RXuY+3iGqaOKg6wNI
         qbujGjL3qe/EK/HXc+dzMcFeassxKff+u04qv3dtoNH6GrMx2hZg4fQREC5x3MospmQf
         UjI1o78+vaTakz3+6nImCylxMrgf2sfBHC283fSjNDLac2pONvmU3MeoZLoujjXzxa9G
         jpxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xJpp1n+QvIrZfr5BvihSJggMhnHMI8y+n8buQsHz600=;
        fh=kRSaLr4bRJme+JztyYaXGxBdn/uIUius522crkTN9+U=;
        b=dWYFPeavFy8QlZBsIx7rZQMQ5wHk3/nTZx2+7EMQ62tTshka87BE9XY2zNZIopAt3K
         RGWY0Jk6Btqe5ku5QW7BBk67JLqXQ2CG4PtbFx9vYBS42AyL/stGoG/ajPGLq0g7oxU8
         Hq4YyIr+M/Q9T6mOyKiJIx7U79CRaMlpEvNqzoEfHJQkXiV5sXkpLeBDwQD6ZOOloeA5
         wF/dB7LTkPXJ+/kw+h+djThrksCWy9O0aFvw0B48TUUj71cQ3RxmRtn5N2fcbdBxeOhO
         l/AlIem9isV2gcsHwL9Bw/QpccrwH1edWtYGlreZX0csJPIDjFVvH6SKeecD4I1PU4nk
         SHug==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779206301; x=1779811101; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xJpp1n+QvIrZfr5BvihSJggMhnHMI8y+n8buQsHz600=;
        b=infLD+CEtcHd2WzFAMZIYK1A8Q9oAhfreBMUqfaXBO8KR7nbWVwTZx42JUPB4ll61M
         GW2Ik1dSXdl+KpWVAB/x72u/+C8AD+c76VkmP+5M/lN1M9qhIBP95xY5wpaIAJO0VruC
         m85EowTPRrAa41yRfwigvMYM2MF/XimAw+2O0/AY4CUtkMbphDx28an/N4+h0tQwvJn6
         HA1jZy6beWeBTnMElkpJYUHp7O6ahQPa8awMKWTLgEd3CqgK1J2Uu5sI/D14vYqlllja
         WkfT1JXpEpO3VTQqEB+zdLx1ILKlU2kb0vJR15mNCIY5zv1tPV9peCKDccvtqi8S30M4
         0Vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779206301; x=1779811101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJpp1n+QvIrZfr5BvihSJggMhnHMI8y+n8buQsHz600=;
        b=MMZ35tTHB5WQmn9zcntZvf57F0QPSknJyWz4XSFNZWKNWPoJHQfRRzCz3BRGpVwYKX
         b63Thd4aR/DGY8rdLDT0RiSV2/+uds3YnTiAuynhbwrsAmpItVi1oUnBOix/BAOKxQ8t
         k9l+lzUAP7Q8hzajhQY3e71RjG1svVe8WBQFC2Ua/PlNZDXmZJMGbEqEhp6c+5FG5j+D
         rxY4Un5kwLxVqD4t3m2sqignPqdKqh4LxdTddkdv+yhaHshQ34UCSw/FI9hZWT330B00
         3l7XAoDZhuua8RgoVLUS6UvAvFFcK3B01JHAHgOJA7Xz9k+fIrvMroovMbeSsgAu9wvr
         3mdQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xeFijvcYP//o9xhgNTUpwNjCtD3Qpu60XV6Ps0r9944mjzHDX9b1wMGFlZL4apG+IJ86gJ4NFL7sD08YJlw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxwl5kUa5D3FAmeInWcDFwIIUmWX/EPwZDWqjE2XOSu1nUu23W1
	nCRWcCO52U374/c57A84X099sspSoTgfJlmr49Qds301JiC89Lp1pbJRV2jl12nrxhL9a07aUB3
	MM67AcIuF2FTsaCV5hk9SIBmWIMZbtble1/0wIkoq8Q==
X-Gm-Gg: Acq92OHXn6zc99u4SQoI314dCOW6CajQ0eOH/3tHaF2jqNdnkABHLasSJseOOcam5Cy
	e9i/jiCRsaPX/mh/WBDxr4LiWwZg1KzA9kroHpzk1HFCPQMv+CLXs9/yC++VUS0meQxO3gKDYnM
	0/5jFptSnE+HBDvMiGdgz48tKkhrxrkdHiidI4Q6z5EUo5FhDgDBCvdqtrUZMQ+hy7+yQVXDxh8
	3g+pYo1Qcdy2+Qhb7kTr6QVxBgvnXNNEnyi7mcuHv5uUfMI0Qjz7L9ZsnepQ+Q/86Al4BB7KN9e
	ZdujOgc=
X-Received: by 2002:a05:600c:1d02:b0:48a:5302:8ed9 with SMTP id
 5b1f17b1804b1-48fe5ea0842mr180244485e9.0.1779206300911; Tue, 19 May 2026
 08:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260516034745.260442-1-ziyuzhang201@gmail.com>
 <agrldIdftDXvATYx@sgarzare-redhat> <CACPoYJx6szY6HcvBf+aNr5+BgrxNNJM0su-qKxzp0qW+cJWO9w@mail.gmail.com>
 <agwugKMrTsNxQ2BD@sgarzare-redhat>
In-Reply-To: <agwugKMrTsNxQ2BD@sgarzare-redhat>
From: ziyu zhang <ziyuzhang201@gmail.com>
Date: Tue, 19 May 2026 23:58:05 +0800
X-Gm-Features: AVHnY4JF15iV8VNxh-zoQopw8snUWS1lixKwNhMLTZ44g5qqA7v69Lig3q9xBy4
Message-ID: <CACPoYJxJN0fmmK-7e7B9JaS7sqsCdEYxYMiaMK1gDaPMGuwhhA@mail.gmail.com>
Subject: Re: [PATCH net] vsock: keep poll shutdown state consistent
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andy King <acking@vmware.com>, George Zhang <georgezhang@vmware.com>, 
	Dmitry Torokhov <dtor@vmware.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, r33s3n6@gmail.com, 
	gality369@gmail.com, zhenghaoran154@gmail.com, hanguidong02@gmail.com, 
	zzzccc427@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 May 2026 at 17:36, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Mon, May 18, 2026 at 08:39:37PM +0800, ziyu zhang wrote:
> >On Mon, 18 May 2026 at 18:16, Stefano Garzarella <sgarzare@redhat.com> wrote:
> >>
> >> On Sat, May 16, 2026 at 11:47:45AM +0800, Ziyu Zhang wrote:
> >> >vsock_poll() reads vsk->peer_shutdown before taking the socket
> >> >lock to set EPOLLHUP and EPOLLRDHUP, then reads it again under the
> >> >lock to report EOF readability. A shutdown packet can update
> >> >peer_shutdown while poll is waiting for the lock, so one poll invocation
> >> >can report EPOLLIN without the corresponding HUP/RDHUP bits.
> >> >
> >> >Keep non-connectible sockets on a single lockless READ_ONCE()
> >>
> >> Should this be paired with WRITE_ONCE() on writers?
> >
> >Yes, since the poll path uses lockless READ_ONCE() snapshots of
> >peer_shutdown, the writer side should be annotated with WRITE_ONCE() as
> >well. I will add that in v2.
> >
> >>
> >> >snapshot. For connectible sockets, defer shutdown-derived poll bits
> >> >until after lock_sock() and use one READ_ONCE() snapshot for both EOF
> >> >readability and HUP/RDHUP. This preserves shutdowns that arrive before
> >> >the lock is acquired and keeps all peer-shutdown-derived bits consistent
> >> >for a poll pass.
> >> >
> >> >Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> >> >Signed-off-by: Ziyu Zhang <ziyuzhang201@gmail.com>
> >> >---
> >> > net/vmw_vsock/af_vsock.c | 40 ++++++++++++++++++++++++++--------------
> >> > 1 file changed, 26 insertions(+), 14 deletions(-)
> >> >
> >> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> >> >index adcba1b7b..bed42347b 100644
> >> >--- a/net/vmw_vsock/af_vsock.c
> >> >+++ b/net/vmw_vsock/af_vsock.c
> >> >@@ -1122,6 +1122,25 @@ static int vsock_shutdown(struct socket *sock, int mode)
> >> >       return err;
> >> > }
> >> >
> >> >+static __poll_t vsock_poll_shutdown(struct sock *sk, u32 peer_shutdown)
> >> >+{
> >> >+      __poll_t mask = 0;
> >> >+
> >> >+      /* INET sockets treat local write shutdown and peer write shutdown as a
> >> >+       * case of EPOLLHUP set.
> >> >+       */
> >> >+      if (sk->sk_shutdown == SHUTDOWN_MASK ||
> >> >+          ((sk->sk_shutdown & SEND_SHUTDOWN) &&
> >> >+           (peer_shutdown & SEND_SHUTDOWN)))
> >> >+              mask |= EPOLLHUP;
> >> >+
> >> >+      if (sk->sk_shutdown & RCV_SHUTDOWN ||
> >> >+          peer_shutdown & SEND_SHUTDOWN)
> >> >+              mask |= EPOLLRDHUP;
> >> >+
> >> >+      return mask;
> >> >+}
> >> >+
> >> > static __poll_t vsock_poll(struct file *file, struct socket *sock,
> >> >                              poll_table *wait)
> >> > {
> >> >@@ -1139,19 +1158,9 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
> >> >               /* Signify that there has been an error on this socket. */
> >> >               mask |= EPOLLERR;
> >> >
> >> >-      /* INET sockets treat local write shutdown and peer write shutdown as a
> >> >-       * case of EPOLLHUP set.
> >> >-       */
> >> >-      if ((sk->sk_shutdown == SHUTDOWN_MASK) ||
> >> >-          ((sk->sk_shutdown & SEND_SHUTDOWN) &&
> >> >-           (vsk->peer_shutdown & SEND_SHUTDOWN))) {
> >> >-              mask |= EPOLLHUP;
> >> >-      }
> >> >-
> >> >-      if (sk->sk_shutdown & RCV_SHUTDOWN ||
> >> >-          vsk->peer_shutdown & SEND_SHUTDOWN) {
> >> >-              mask |= EPOLLRDHUP;
> >> >-      }
> >> >+      if (!sock_type_connectible(sk->sk_type))
> >> >+              mask |= vsock_poll_shutdown(sk,
> >> >+                                          READ_ONCE(vsk->peer_shutdown));
> >>
> >> Can we move this in the `if (sock->type == SOCK_DGRAM)` branch ?
> >>
> >> Not a strong opinion about that, but in any case IMO we should add a
> >> comment here to explain why we are doing only for not connectible
> >> sockets.
> >>
> >> That said, if we use WRITE_ONCE in the writers, do we really need to
> >> move this after the lock_sock for the connectable ones?
> >
> >Yes, I will move the non-connectible handling into the SOCK_DGRAM branch
> >and add a comment there.
> >
> >For connectible sockets, my current understanding is that
> >READ_ONCE()/WRITE_ONCE() make the individual lockless accesses explicit, but
> >they do not make two separate reads in one vsock_poll() invocation observe the
> >same peer_shutdown value. So I still think using one peer_shutdown snapshot
> >after lock_sock() is useful for keeping the returned mask internally
> >consistent. Please let me know if you think WRITE_ONCE() is enough for this
> >case.
>
> What will be the issue of "do not make two separate reads in one
> vsock_poll() invocation observe the same peer_shutdown value." ?
>
> In any case, I'm not against it; I just want to understand the issue
> better.

The issue I was trying to avoid is a transiently inconsistent poll mask
from one vsock_poll() pass.

For example, the early peer_shutdown read can see 0, so the
shutdown-derived bits are not set, especially EPOLLRDHUP, and EPOLLHUP
in the cases where the existing logic would set it. Then, before
lock_sock() succeeds, the peer shutdown can be processed. The later read
after lock_sock() can see SEND_SHUTDOWN and set EPOLLIN|EPOLLRDNORM for
EOF readability.

So the returned mask can say that EOF is readable, but miss the
shutdown-derived indication from the same peer_shutdown state. If
userspace is waiting specifically for EPOLLRDHUP, that notification can
be missed or delayed for that poll pass.

I agree this is small and transient. A following read() or another poll
pass will observe the shutdown state. My intention with the single
snapshot is only to avoid mixing old and new peer_shutdown values in one
returned mask.

I will send a v2 as a new thread with WRITE_ONCE() on the writers, the
DGRAM comment, and your ordering suggestion.

Thanks,
Ziyu

>
> Thanks,
> Stefano
>
