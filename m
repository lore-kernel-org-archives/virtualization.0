Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9BB413D9C
	for <virtualization@lists.linux.dev>; Mon, 18 May 2026 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107992; cv=pass; b=aVsfIsnfOl3LVZ5E62G6U+gPHCpeUx/gx06UkoKO9pyPjQjGAftZGlvWk1sbw7AE+Djij3fmsmucUZwlS2Y85RqfD/fEAZLVoEWpiG+AZd2luhpkxRqIoG4e9Vw/k9y75IBCEuwTNujo06vpLE+E7ku8i/bmWkhUwF/RVOEnY90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107992; c=relaxed/simple;
	bh=JJ8fpDX8TBkCH5S0/z0dF6rSeIENeKcqacJPaMsAlPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ibaGppDqK82t/m8Z4ZSRdIauRkwgui7PdtSd7WdX/gJQqxcjdnJLD7/mlxE62ozsQkwcpOr2Mdf5BUo4pLyKSoagJLukMwyCOtuDEglRiOxAbm8zhc/JIdCqtrnCuNp1Q6Qlp3m5GpjfxNFPhnyEApltfbhX3alIKVmvtnGnlOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaV790KE; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaV790KE"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4889d0a9df0so2354595e9.3
        for <virtualization@lists.linux.dev>; Mon, 18 May 2026 05:39:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779107989; cv=none;
        d=google.com; s=arc-20240605;
        b=OIGCCmo9MOpHiyQMRFwR6TGeNCkBY/I5SdzgYF8n56mTMQVcLIJRM9lW0AP3hOq/S/
         8jiD7odAOCZ4Tcafq+V7nJPWVPG2ctU2e+JwTzm/gMLwzIMqg9MXfBvBuWOF8cWwOxiZ
         iAPKErJHc8qKh5lKReltLVpoceOKOegLw5LVetVPo9RiLkOzIy6kGqeDBx6oaLyaW2if
         dvJ0xv7topB9ur5LcOhn8tVdNDqCqcR50rwiL14Am5DGjzOfu2u1rERrFgJjLCblqFtc
         AlrDrSfHMXmiinpPHyFsQSvPq3kv8CpzSDOyOlalRlxHz4EoPYVaqW9D/qafYwdh9EbO
         DeQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EHa41K/hRVzK2I4pGuE2IMxhC4j0nuI5IQkkLe8Xajg=;
        fh=8vFdO1OogPN1FE/96LsusmFpcYFJgEde99LLNxY0kY0=;
        b=jNeO5fr9KXg3SIy/zUaI0o5qbPQTPb5PmQgpjye0WnP/p44CjxbkPTG4qtjkBiQoPP
         FKPCnujWtlLFcKVrd0eMBWSwsUVaxDUUko0iHZykw4aVKLuppJPucpwMYfgiZG0Gu5tm
         ooc9mLdlGia/VEPoQjuMrkpOq8mNObhYkjNDA/WHVk0kTMfeUR1UjoivDOCZDf8xw0F4
         gzHBiTDevgoydwgGksuStEaAyDKiUe9I9Huwl8augi4WkuiG1B5jWdQINwCB9m9Kdolu
         CUWm+MxbmnaxggmMNch/vrDvY3hqM7A9AOfbgYdk2p8GuxLs4op2UNUy25mikcyI83ta
         TVnQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779107989; x=1779712789; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EHa41K/hRVzK2I4pGuE2IMxhC4j0nuI5IQkkLe8Xajg=;
        b=KaV790KENbMZdMFn+i2CJkyFHmsCHthQZpDtZCg63nNZoyyt6k1beWtH0fKs4y97QF
         BvaUyR4feUsDz8LWdJp7/9kf5fQM6+bN9bR725A4IxtksRZeIMt4NndF4sC12BJeockX
         gRsgIHBf13R/zk0VVPhw14rHCAAEdPxOR8BbOTfs7UdXnVibbpZD3Q3G7qYbeyNHjvOa
         JEjJ5mF7kfPcjwrRCmYSaCOatkeCUNPbCktl9Oy4CakMDdShsC/0SCiTOcb4ypOBORKB
         eO4atg3UmSL9oDi5t6U0haR/YIsMSl2wVbxvnNmuHKeZI4PynGEx9eUcqVj1HqdQolE5
         Byrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779107989; x=1779712789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHa41K/hRVzK2I4pGuE2IMxhC4j0nuI5IQkkLe8Xajg=;
        b=HDKN7DTUrOMisZp6TtKcfI//nRzf5q3o0kkMOqwU7pMiqTtsKqts7RxX19rfIeSvmY
         aJpoK5fOk0katRcbicuXT2VG3P4tYTuMHN+G8ALNM4XPlqwMLMMY8+SvHxPUEeVoV2a9
         ++H0kTnovte/isYUOUriPU7P3LYyoxfAvDgLkkrQ9Sb0o6Zpy+OWfh9rsrfFPgt3f+Vv
         h3t9msz0DsUwkyrbSlE8vsP2nyXpxGftWdItlxAfGVwyFk4BitapGcp2HJfeufN2Ssp7
         UU5t3RAY9EMjjm7U3PVqX8UDzxV6hx62cloPtb/Owx9cDaDnC14sGIMPQghUWqJT5vBt
         56ZA==
X-Forwarded-Encrypted: i=1; AFNElJ/8u/1NPtkncZmC5b6UVtPrSXe+CS9oa5Cy8tMjKNn3c3bFiah3HEbbBe8L8U8OHaF7CccQXW8BuSNRYAKnsw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzpNJ37tK27GN9iU4e4+9y8gNwkpLkRi1OgKLHlHgAzEbYguV4G
	0OB2HCap8HUnabCP/RCi23udyowlh2GlfhJX2HXUBMHrQYNK5UrDwAlVfswszB1rhO11/R+FOap
	eQ/fl8W2aRtYDRdCR6+0hESfL3GHI+U8=
X-Gm-Gg: Acq92OF7WzCxG0SUsm7EafsFfysYjpQgEIuRZ1c1nKT6uqBKiJvLQJubmXyIRYXwzcf
	Phv+p/gQY2xkKKBYBKHbcc4t9uborkeLFCgaDPWi7VmXRkBQDK+VCoGvgByP6t0A20n3+A6DwyX
	cSlxodQ3DcOZE42rOJBF+oLbqzDKnyiHDXF8aSgqCtrnzgvFtTm5aLQ2DahyxwsVdUEIvCcX0Cg
	D0bi8QnhHxJ6cjxO5X7ZuPc2aoTowwS7KjpcngO3KNDHGgfDR41Qco62AjroTNc/lfDRhaRpzbP
	NQr8gTk=
X-Received: by 2002:a05:600c:198d:b0:487:1826:e138 with SMTP id
 5b1f17b1804b1-48fe6309a99mr126995475e9.1.1779107988810; Mon, 18 May 2026
 05:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260516034745.260442-1-ziyuzhang201@gmail.com> <agrldIdftDXvATYx@sgarzare-redhat>
In-Reply-To: <agrldIdftDXvATYx@sgarzare-redhat>
From: ziyu zhang <ziyuzhang201@gmail.com>
Date: Mon, 18 May 2026 20:39:37 +0800
X-Gm-Features: AVHnY4JBDiIRJU-61TJDNbnXqzlRWWvp1w4GkFiNKUv_vD4n0ZzkHb8gPQGL79w
Message-ID: <CACPoYJx6szY6HcvBf+aNr5+BgrxNNJM0su-qKxzp0qW+cJWO9w@mail.gmail.com>
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

On Mon, 18 May 2026 at 18:16, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Sat, May 16, 2026 at 11:47:45AM +0800, Ziyu Zhang wrote:
> >vsock_poll() reads vsk->peer_shutdown before taking the socket
> >lock to set EPOLLHUP and EPOLLRDHUP, then reads it again under the
> >lock to report EOF readability. A shutdown packet can update
> >peer_shutdown while poll is waiting for the lock, so one poll invocation
> >can report EPOLLIN without the corresponding HUP/RDHUP bits.
> >
> >Keep non-connectible sockets on a single lockless READ_ONCE()
>
> Should this be paired with WRITE_ONCE() on writers?

Yes, since the poll path uses lockless READ_ONCE() snapshots of
peer_shutdown, the writer side should be annotated with WRITE_ONCE() as
well. I will add that in v2.

>
> >snapshot. For connectible sockets, defer shutdown-derived poll bits
> >until after lock_sock() and use one READ_ONCE() snapshot for both EOF
> >readability and HUP/RDHUP. This preserves shutdowns that arrive before
> >the lock is acquired and keeps all peer-shutdown-derived bits consistent
> >for a poll pass.
> >
> >Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> >Signed-off-by: Ziyu Zhang <ziyuzhang201@gmail.com>
> >---
> > net/vmw_vsock/af_vsock.c | 40 ++++++++++++++++++++++++++--------------
> > 1 file changed, 26 insertions(+), 14 deletions(-)
> >
> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> >index adcba1b7b..bed42347b 100644
> >--- a/net/vmw_vsock/af_vsock.c
> >+++ b/net/vmw_vsock/af_vsock.c
> >@@ -1122,6 +1122,25 @@ static int vsock_shutdown(struct socket *sock, int mode)
> >       return err;
> > }
> >
> >+static __poll_t vsock_poll_shutdown(struct sock *sk, u32 peer_shutdown)
> >+{
> >+      __poll_t mask = 0;
> >+
> >+      /* INET sockets treat local write shutdown and peer write shutdown as a
> >+       * case of EPOLLHUP set.
> >+       */
> >+      if (sk->sk_shutdown == SHUTDOWN_MASK ||
> >+          ((sk->sk_shutdown & SEND_SHUTDOWN) &&
> >+           (peer_shutdown & SEND_SHUTDOWN)))
> >+              mask |= EPOLLHUP;
> >+
> >+      if (sk->sk_shutdown & RCV_SHUTDOWN ||
> >+          peer_shutdown & SEND_SHUTDOWN)
> >+              mask |= EPOLLRDHUP;
> >+
> >+      return mask;
> >+}
> >+
> > static __poll_t vsock_poll(struct file *file, struct socket *sock,
> >                              poll_table *wait)
> > {
> >@@ -1139,19 +1158,9 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
> >               /* Signify that there has been an error on this socket. */
> >               mask |= EPOLLERR;
> >
> >-      /* INET sockets treat local write shutdown and peer write shutdown as a
> >-       * case of EPOLLHUP set.
> >-       */
> >-      if ((sk->sk_shutdown == SHUTDOWN_MASK) ||
> >-          ((sk->sk_shutdown & SEND_SHUTDOWN) &&
> >-           (vsk->peer_shutdown & SEND_SHUTDOWN))) {
> >-              mask |= EPOLLHUP;
> >-      }
> >-
> >-      if (sk->sk_shutdown & RCV_SHUTDOWN ||
> >-          vsk->peer_shutdown & SEND_SHUTDOWN) {
> >-              mask |= EPOLLRDHUP;
> >-      }
> >+      if (!sock_type_connectible(sk->sk_type))
> >+              mask |= vsock_poll_shutdown(sk,
> >+                                          READ_ONCE(vsk->peer_shutdown));
>
> Can we move this in the `if (sock->type == SOCK_DGRAM)` branch ?
>
> Not a strong opinion about that, but in any case IMO we should add a
> comment here to explain why we are doing only for not connectible
> sockets.
>
> That said, if we use WRITE_ONCE in the writers, do we really need to
> move this after the lock_sock for the connectable ones?

Yes, I will move the non-connectible handling into the SOCK_DGRAM branch
and add a comment there.

For connectible sockets, my current understanding is that
READ_ONCE()/WRITE_ONCE() make the individual lockless accesses explicit, but
they do not make two separate reads in one vsock_poll() invocation observe the
same peer_shutdown value. So I still think using one peer_shutdown snapshot
after lock_sock() is useful for keeping the returned mask internally
consistent. Please let me know if you think WRITE_ONCE() is enough for this
case.

>
> >
> >       if (sk_is_readable(sk))
> >               mask |= EPOLLIN | EPOLLRDNORM;
> >@@ -1171,6 +1180,7 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
> >
> >       } else if (sock_type_connectible(sk->sk_type)) {
> >               const struct vsock_transport *transport;
> >+              u32 peer_shutdown;
> >
> >               lock_sock(sk);
> >
> >@@ -1203,10 +1213,12 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
> >                * terminated should also be considered read, and we check the
> >                * shutdown flag for that.
> >                */
> >+              peer_shutdown = READ_ONCE(vsk->peer_shutdown);
> >               if (sk->sk_shutdown & RCV_SHUTDOWN ||
> >-                  vsk->peer_shutdown & SEND_SHUTDOWN) {
> >+                  peer_shutdown & SEND_SHUTDOWN) {
> >                       mask |= EPOLLIN | EPOLLRDNORM;
> >               }
> >+              mask |= vsock_poll_shutdown(sk, peer_shutdown);
>
> nit: to keep the order the same as before, I would move this call just
> before this `if` block, but I don't think it makes any difference in the
> end.

Sure, I will restore the previous ordering in v2.

Thanks,
Ziyu

>
> >
> >               /* Connected sockets that can produce data can be written. */
> >               if (transport && sk->sk_state == TCP_ESTABLISHED) {
> >--
> >2.43.0
> >
>
