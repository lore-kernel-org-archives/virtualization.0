Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0922580F3
	for <virtualization@lists.linux.dev>; Wed, 30 Apr 2025 10:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746009493; cv=none; b=UEWMB5rmwykCBCTF4ZnGfHogP5qbIT9imtfzteaMpBowleXjKx7lMsusAc7hE5ZvhtyGbRdjj65hWF377yWyfqCBbip9Etszd6mv0uunhNKHW7acd9p3k1xLKs/tJ6wJEqdh8njXzhskwpEm6wL54dmnk53YCpltbO+X+croWQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746009493; c=relaxed/simple;
	bh=L0SAAefyveDoX/FjdHc/xGaLZ37kY++Yjt697RpzkAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sKiziAtqMJ9aNT/wOir0b3Xgmltz4kibcgJCNVMuKexifC1J+pQdYKE2XPd1SDR2mGeLKQsuVOAAKM7nm81fftvpJeiCSMe5WCZ/fmwQ/StVuNw6BP2yv6Y9w+vsmhGj/b8JJBN9daA8nVyHVHj7/fmSHrOXSXxWr9jD1e8zZYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VSaaGBYn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VSaaGBYn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746009489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pi8G66LgJAq886SVmCWw3P+Bv6HYWhRZ3tZsp9fmenI=;
	b=VSaaGBYnZsbDN/u/h/hkm0eLQ//menwOIxwmF4p5BxtRGTdI38Q78i57GzFgkmq0nHRurx
	OPAi84ey85fFOfQ17nq/mCJ4FB13KfmMFK8g45jvuLSCnXm6p6JwVRKnejT26qInIxdg5o
	qxKqv4tvrXBkNRcp9MJudgKqaaOZfRY=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-kzloihIZN5SjS-Zbz_PyEw-1; Wed, 30 Apr 2025 06:38:06 -0400
X-MC-Unique: kzloihIZN5SjS-Zbz_PyEw-1
X-Mimecast-MFC-AGG-ID: kzloihIZN5SjS-Zbz_PyEw_1746009486
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e5b0f2778d6so5181000276.3
        for <virtualization@lists.linux.dev>; Wed, 30 Apr 2025 03:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746009486; x=1746614286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pi8G66LgJAq886SVmCWw3P+Bv6HYWhRZ3tZsp9fmenI=;
        b=KitNSbZg2ZNX5iUjZYgiai6owF47Pnj3GuJ+wX7OPuUS5uwXJl4gqHmmtHVPMw4NQN
         XiXfEnqRZ7AsiJpFsPFpQtf5rADvdeldFfOmneayUy1zGq+vWPIV6vVyag2RdZbbsS4B
         9SPVkBsDPgP4pCOQM3ik8oAmpAb1FYC3hzTdnK1UT3L/1OWr4eCo2pWiCayH/22WDPkw
         b3WA5MKMUqwyUUp84xC3lZVZ/E32Ng8e68J+1k9r7ypZMlwcon7ipMILCgFdYrElpz+Y
         VHtRN2IqoBzGonoOs0W1BlPee+QrROilMB21F7t2In2KbvZKUifDo/wRdPBSsXPvJ11e
         eXUA==
X-Forwarded-Encrypted: i=1; AJvYcCW9Sd07YQrDuu+fVubkrYaEnatMhY8ocoa8t6uFvhgorFRrjOeaJXRx3fZuas5ABXnApcutV1bu5oJBOoQs9g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPILW7ZOpJ2GCXkr4dPktGNSTDFJouDQZ3RiJEbaCymRf5wSMp
	sTM3FtLE1lJEUI4OGS0o3UR2piQ+XctJWh693ylNdryMZV1kvYPzlk0hY0FklDAJAmhRbSIrnA0
	FHgZhkTGe0UyjMRayy6RBS/WZ5AAoC2Hfw7Z/blDyclOSWQwZQvJyTGtjF7RVYlCO7XvQxOsEeO
	nqYbXl6vyIm9477g1A3OZSwX3AJZfOTl1axyPWq/M=
X-Gm-Gg: ASbGncubnvbsnpiQknf8L4foAzInO4GUQXGQbyAfNBr4lW4+O+Whgt1L56PJIlGp8z/
	kRUvn0dgyHWpM0G/sQ8+DVCP4+gW6i5n4IgGOE+1WOyD88Ih9nSxedjFgQ16QFqt3Z0ZVBo4=
X-Received: by 2002:a05:6902:70f:b0:e73:1a8c:b85c with SMTP id 3f1490d57ef6-e7404cf1cd6mr2499381276.27.1746009485714;
        Wed, 30 Apr 2025 03:38:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe4hS/4tTJe3wQp1DO4q16a9js38tPsRexlXFhwlVepkoC+asFZ9MA+8cxL1MgjRQ/gYtfO9kGzahI7xKCWA8=
X-Received: by 2002:a05:6902:70f:b0:e73:1a8c:b85c with SMTP id
 3f1490d57ef6-e7404cf1cd6mr2499358276.27.1746009485276; Wed, 30 Apr 2025
 03:38:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250430-vsock-linger-v3-0-ddbe73b53457@rbox.co>
 <20250430-vsock-linger-v3-3-ddbe73b53457@rbox.co> <oo5tmbu7okyqojwxt4xked4jvq6jqydrddowspz3p66nsjzajt@36mxuduci4am>
 <fa71ef5e-7603-4241-bfd3-7aa7b5ea8945@rbox.co>
In-Reply-To: <fa71ef5e-7603-4241-bfd3-7aa7b5ea8945@rbox.co>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 30 Apr 2025 12:37:54 +0200
X-Gm-Features: ATxdqUFYdEhpc2hMG3McWkKruB0g8l88EcvME9mfW0rN5K7PplMaQvDwSrnYRHE
Message-ID: <CAGxU2F62CTUKVjuG9Fjo29E6uopVzOK8zgr+HwooqMr4V_RvLQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/4] vsock: Move lingering logic to af_vsock core
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aKH6eJHJB_HG-Z9vRzZAGdLwKt7qAb7EaINonB3qQ0o_1746009486
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Apr 2025 at 12:33, Michal Luczaj <mhal@rbox.co> wrote:
>
> On 4/30/25 11:36, Stefano Garzarella wrote:
> > On Wed, Apr 30, 2025 at 11:10:29AM +0200, Michal Luczaj wrote:
> >> Lingering should be transport-independent in the long run. In preparation
> >> for supporting other transports, as well the linger on shutdown(), move
> >> code to core.
> >>
> >> Guard against an unimplemented vsock_transport::unsent_bytes() callback.
> >>
> >> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> >> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> >> ---
> >> include/net/af_vsock.h                  |  1 +
> >> net/vmw_vsock/af_vsock.c                | 25 +++++++++++++++++++++++++
> >> net/vmw_vsock/virtio_transport_common.c | 23 +----------------------
> >> 3 files changed, 27 insertions(+), 22 deletions(-)
> >>
> >> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> >> index 9e85424c834353d016a527070dd62e15ff3bfce1..bd8b88d70423051dd05fc445fe37971af631ba03 100644
> >> --- a/include/net/af_vsock.h
> >> +++ b/include/net/af_vsock.h
> >> @@ -221,6 +221,7 @@ void vsock_for_each_connected_socket(struct vsock_transport *transport,
> >>                                   void (*fn)(struct sock *sk));
> >> int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
> >> bool vsock_find_cid(unsigned int cid);
> >> +void vsock_linger(struct sock *sk, long timeout);
> >>
> >> /**** TAP ****/
> >>
> >> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> >> index fc6afbc8d6806a4d98c66abc3af4bd139c583b08..946b37de679a0e68b84cd982a3af2a959c60ee57 100644
> >> --- a/net/vmw_vsock/af_vsock.c
> >> +++ b/net/vmw_vsock/af_vsock.c
> >> @@ -1013,6 +1013,31 @@ static int vsock_getname(struct socket *sock,
> >>      return err;
> >> }
> >>
> >> +void vsock_linger(struct sock *sk, long timeout)
> >> +{
> >> +    DEFINE_WAIT_FUNC(wait, woken_wake_function);
> >> +    ssize_t (*unsent)(struct vsock_sock *vsk);
> >> +    struct vsock_sock *vsk = vsock_sk(sk);
> >> +
> >> +    if (!timeout)
> >> +            return;
> >> +
> >> +    /* unsent_bytes() may be unimplemented. */
> >> +    unsent = vsk->transport->unsent_bytes;
> >> +    if (!unsent)
> >> +            return;
> >> +
> >> +    add_wait_queue(sk_sleep(sk), &wait);
> >> +
> >> +    do {
> >> +            if (sk_wait_event(sk, &timeout, unsent(vsk) == 0, &wait))
> >> +                    break;
> >> +    } while (!signal_pending(current) && timeout);
> >> +
> >> +    remove_wait_queue(sk_sleep(sk), &wait);
> >> +}
> >> +EXPORT_SYMBOL_GPL(vsock_linger);
> >> +
> >> static int vsock_shutdown(struct socket *sock, int mode)
> >> {
> >>      int err;
> >> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> >> index 4425802c5d718f65aaea425ea35886ad64e2fe6e..9230b8358ef2ac1f6e72a5961bae39f9093c8884 100644
> >> --- a/net/vmw_vsock/virtio_transport_common.c
> >> +++ b/net/vmw_vsock/virtio_transport_common.c
> >> @@ -1192,27 +1192,6 @@ static void virtio_transport_remove_sock(struct vsock_sock *vsk)
> >>      vsock_remove_sock(vsk);
> >> }
> >>
> >> -static void virtio_transport_wait_close(struct sock *sk, long timeout)
> >> -{
> >> -    DEFINE_WAIT_FUNC(wait, woken_wake_function);
> >> -    ssize_t (*unsent)(struct vsock_sock *vsk);
> >> -    struct vsock_sock *vsk = vsock_sk(sk);
> >> -
> >> -    if (!timeout)
> >> -            return;
> >> -
> >> -    unsent = vsk->transport->unsent_bytes;
> >> -
> >> -    add_wait_queue(sk_sleep(sk), &wait);
> >> -
> >> -    do {
> >> -            if (sk_wait_event(sk, &timeout, unsent(vsk) == 0, &wait))
> >> -                    break;
> >> -    } while (!signal_pending(current) && timeout);
> >> -
> >> -    remove_wait_queue(sk_sleep(sk), &wait);
> >> -}
> >> -
> >> static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
> >>                                             bool cancel_timeout)
> >> {
> >> @@ -1283,7 +1262,7 @@ static bool virtio_transport_close(struct vsock_sock *vsk)
> >>              (void)virtio_transport_shutdown(vsk, SHUTDOWN_MASK);
> >>
> >>      if (sock_flag(sk, SOCK_LINGER) && !(current->flags & PF_EXITING))
> >> -            virtio_transport_wait_close(sk, sk->sk_lingertime);
> >> +            vsock_linger(sk, sk->sk_lingertime);
> >
> > Ah, I'd also move the check in that function, I mean:
> >
> > void vsock_linger(struct sock *sk) {
> >       ...
> >       if (!sock_flag(sk, SOCK_LINGER) || (current->flags & PF_EXITING))
> >               return;
> >
> >       ...
> > }
>
> One note: if we ever use vsock_linger() in vsock_shutdown(), the PF_EXITING
> condition would be unnecessary checked for that caller, right?

Right, for shutdown it should always be false, so maybe better to keep
the check in the caller.

Thanks,
Stefano

>
> > Or, if we move the call to vsock_linger() in __vsock_release(), we can
> > do the check there.
> >
> > Thanks,
> > Stefano
> >
> >>
> >>      if (sock_flag(sk, SOCK_DONE)) {
> >>              return true;
> >>
> >> --
> >> 2.49.0
> >>
> >>
>

