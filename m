Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5E8138490
	for <virtualization@lists.linux.dev>; Tue, 28 Apr 2026 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364691; cv=pass; b=Ywea7dfw+tOBOJnkV4p0ryrlu4QPGtdq3sDyfc4CGp1y7AO+BDnmKoGxEXjQkfH9Sj+n0/g+IYJSYM+FcmfP8lmnTe0OzYdQ0PiMrm+QCxmbZY3arN4VDuJwFqPOSRFEKXpZDPNdyNVojzMBrEseix8SEoGrN5zwRo6n6BDgiLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364691; c=relaxed/simple;
	bh=rflQkKHjNVxCVgZtglvz+DJcNmjV4gDXBMOsyusJUg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WMC0s+OqHUqBdgiI8JJylN5R6106svVm6Y+FlWLRf9XSSXugVlGEKtI2qAGAlWnxYx5W3/Go4ltxeoCrj/CGh4KHTO/jxqybc1wtealkZ2zn/+halbzuykB9oWg92FHB031NMJEAV3eTs2yv5OMSH+m/IEaPE9MsJ42CgONt3+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgX1nWtX; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgX1nWtX"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7986e0553bdso105979127b3.2
        for <virtualization@lists.linux.dev>; Tue, 28 Apr 2026 01:24:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777364689; cv=none;
        d=google.com; s=arc-20240605;
        b=cvMQ8nBIdWP/fzyj/TVk3SxD35kX/sBoZudvM8jYJ/iQvf2ib3YbOAsQyRhtr09Trr
         loY0jQ+9MzqxI1xaMLGdHVZhaMj1EuwZSQR6STfBXI33gQHs6nJiafdHRtqEsRyq7YlR
         cHhfyfTncau2jvkO1DzJRGg5tOE/VgNty8OMbZ8ukcD9BqwAWGG9y4d1w0hcNKjjhHsq
         mURUXYK+H7f3G9GV0MssoZuG+MZedtuRNQ6m6cqwil9hXGAvrvkYDcoIm9eLwZ98rYDv
         G+cenRRpF2sY9dvXMjR7UWah6HMofN7JFtFlUNmIvdWS1+E1xvjygp6zW1H4yqhO3AIz
         6Ggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5nbTPPIa6lE5He4gxsryrRCR65xYKtTO0ggHOsJlUxQ=;
        fh=FrnJgcpkZ6SRpoOO9yl7IifPEPe2pbNHfeJ9yfmMOzQ=;
        b=CUwlt4bdovp3hgEPBdz+S8VrBORPqLqe1Xn14BVG/SlIYs6AZvRMh7qlO+X3AdQKth
         /E3CCc1H7sN+0mPyOi+5a1F+LpBzsuaCJ5WDacqWSFpRSrPStL4nGICXdBtx8Amfn9Dr
         3MzPoJFWb+NEC8EnlOmtKJrN1/Qd6ZJEbZZo06pPPDmK7T/lGomCgb9iR/eEB1tk4a5V
         OW2lop0hQKdxfeeumKKvzq20DA2yJw6HDNWpYuFqAFRO84pCKSleNG+P326CNpUKxLlu
         wa9glIo8b4wObSv0MAJufMR1hXgN4JnvfooKNOSPgO2yJ2cm1ooY6Zhl+39TU9i4lExU
         bYXw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777364689; x=1777969489; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nbTPPIa6lE5He4gxsryrRCR65xYKtTO0ggHOsJlUxQ=;
        b=HgX1nWtXZKAbitojnstHPXctKczUDFV6FsFPCu/tOufOgV97hqFmThCiNOtzF4mVDg
         pP0BQ4lgnYz65lgGECTWjqKZFa4Cp9W7WastInxFZ9QgVt/4bIxhMlwwKNahg47T4nG4
         fWDv2BGkno01XlG+Syqk+MIjQCvkaRmZYz/o7gQG3IO9fqYNZtMNWXXbr6uhs59Oonjq
         ID2X4HNlQo56FkofOLtfpeOTaB/WHYK+0HYXr3XgeLwuoJVChWBowW3A6V9JMI+zqSTD
         yK5e8Yhc218WwkZEl9iSMVNHiMBsrAEHcXW0Fg4LNswFYuxpsrSI8LmNTyBzONW99vmX
         ST7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777364689; x=1777969489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5nbTPPIa6lE5He4gxsryrRCR65xYKtTO0ggHOsJlUxQ=;
        b=HTRHq1euhBMB9e+xn3koVupix15POMh3g0Ks0oiZWEmnQgEk5p/hDy7knafO/vWdoR
         ip38Vs+ouEg+EZKCOzn0vIJGb3uOG0dEx+rcm1Cyfl0xWe8YD0Hl6Hpxb8YJ9U0qqjHp
         2FOD8YQXiTw6jkfmsQzugHV/3u9Obcj17+mXAeiHEOb2ACK9Lqqz1LsnyDN2qmwRAk0d
         /P3vr3TnAI9zZDLGKrKUR158bxNWY7cJMDBoBH2f+fJnKwg72WsXcUnq3/4jfclMk+wI
         rYDzjB2lfpzhuPhIa+TRF4oikCRH1XL3gI+UsT+NF/IoR/0arcBatLLJsV9ORA/HAQId
         BCxg==
X-Forwarded-Encrypted: i=1; AFNElJ85yT+3cDZFm6sCzSEYcQAqAtK0Ru1RKEDQKrImmi6TlZAjgIvPQl/GvWhoMmSekdCb9YVRiGa8eAJcVMoKzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw65WsppOXr5NlLsBMKAoFn/MDyYW0t1PJs/LJHywi6ZSQfxQB2
	FqB6N13+D6TvDVkbevLao0GVDDW+Wu3XlGJq8p5EcNVhwSeQH/upfYXx7Bu9u9/roYUla6EseZz
	YhJPEtL5YJWCgUSwU+2/NwUewC3Vrr1Q=
X-Gm-Gg: AeBDievt89zPV3NGyjiZAw+T7vgNCCuwGCeK8zwtrW96rCHeShRDksI+EHSFL5lHGCD
	TCHFO5O4RwkCDwskrlf7TqyLpllPBt+aWPVvhbPuq+pWEXdgUzbU/OoHpboU6RGEtlQaIJTbIbm
	HDWpQIJK3D2k3iGTsJ/UlLlfrL6QKgVw6U+Kl4dlaPG2z2WBMTXt0dd87X+9XT1Bc8ml5nj0Fya
	DgKTW5sSWuNLEZOIQkJSzONNmqVgRkQwXUz+z54uU/KHgGUigP21q+vKq5AzrV4xrBXK5dx+2sq
	rZjln79I75Vcdv3V7wyASwdhN6ZH9feslv4Wo1JQvfhMLFJUuxcBol+w0a3G4ZMjC1Qu8b5YHl8
	ZQ44xOTU=
X-Received: by 2002:a05:690c:2607:b0:7b6:422d:7623 with SMTP id
 00721157ae682-7bcf5212a91mr20867887b3.16.1777364688595; Tue, 28 Apr 2026
 01:24:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260424150310.57228-1-kartikey406@gmail.com> <ae9ilWoZI_-EMdWQ@sgarzare-redhat>
In-Reply-To: <ae9ilWoZI_-EMdWQ@sgarzare-redhat>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 28 Apr 2026 13:54:36 +0530
X-Gm-Features: AVHnY4LkfkfcAbNkAqMYMqsD9ddBBMlOtODTH4wKfniL5RjT_dtXJ2UJOta3HQA
Message-ID: <CADhLXY6APdmMQLSxN9b66pV5mp5sDwJRR7_BJAh13BaK-qoa=w@mail.gmail.com>
Subject: Re: [PATCH] vsock/virtio: fix memory leak in virtio_transport_recv_listen()
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, stefanha@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 7:15=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Fri, Apr 24, 2026 at 08:33:10PM +0530, Deepanshu Kartikey wrote:
> >Two bugs exist in virtio_transport_recv_listen():
>
> Two bugs, two fixes, two patches usually.
>
> >
> >1. On the transport assignment error path, sk_acceptq_added() is called
> >   but sk_acceptq_removed() is never called when vsock_assign_transport(=
)
> >   fails or assigns a different transport than expected. This causes the
> >   parent listener's accept backlog counter to be permanently inflated,
> >   eventually causing sk_acceptq_is_full() to reject legitimate incoming
> >   connections.
>
> Wait, I can't see this issue. sk_acceptq_added() is called after the
> vsock_assign_transport(), so why we should call sk_acceptq_removed()
> in the error path of vsock_assign_transport()?
>
> Maybe I'm missing something.
>
> >
> >2. There is a race between __vsock_release() and vsock_enqueue_accept().
> >   __vsock_release() sets sk->sk_shutdown to SHUTDOWN_MASK and flushes
> >   the accept queue under the parent socket lock. However,
> >   virtio_transport_recv_listen() checks sk_shutdown and subsequently
> >   calls vsock_enqueue_accept() without holding the parent socket lock.
>
> Are you sure about this?
>
> virtio_transport_recv_listen() is called only by
> virtio_transport_recv_pkt() after calling lock_sock(sk), so I'm really
> confused.
>
> >   This means a child socket can be enqueued after __vsock_release() has
> >   already flushed the queue, causing the child socket and its associate=
d
> >   resources to leak
> >   permanently. The existing comment in the code hints at this race but
> >   the fix was never implemented.
>
> Are you referring to:
>         /* __vsock_release() might have already flushed accept_queue.
>          * Subsequent enqueues would lead to a memory leak.
>          */
>         if (sk->sk_shutdown =3D=3D SHUTDOWN_MASK) {
>                 virtio_transport_reset_no_sock(t, skb, sock_net(sk));
>                 return -ESHUTDOWN;
>         }
>
> In this case I think we are saying that we are doing this check exactly
> to avoid that issue.
>
> >
> >Fix both issues: add sk_acceptq_removed() on the transport error path,
>
> Again, better to fix the 2 issues with 2 patches (same series is fine).
>
> >and re-check sk->sk_shutdown under the parent socket lock before calling
> >vsock_enqueue_accept() to close the race window. The child socket lock
> >is released before acquiring the parent socket lock to maintain correct
> >lock ordering (parent before child).
> >
>
> We are missing the Fixes tag, and I think we can target the `net` tree
> with this patch (i.e. [PATCH net]), see:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
>
> >Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
> >Closes: https://syzkaller.appspot.com/bug?extid=3D1b2c9c4a0f8708082678
> >Tested-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
> >Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> >---
> > net/vmw_vsock/virtio_transport_common.c | 13 +++++++++++--
> > 1 file changed, 11 insertions(+), 2 deletions(-)
> >
> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/vir=
tio_transport_common.c
> >index 416d533f493d..fad5fa4a4296 100644
> >--- a/net/vmw_vsock/virtio_transport_common.c
> >+++ b/net/vmw_vsock/virtio_transport_common.c
> >@@ -1578,6 +1578,7 @@ virtio_transport_recv_listen(struct sock *sk, stru=
ct sk_buff *skb,
> >        */
> >       if (ret || vchild->transport !=3D &t->transport) {
> >               release_sock(child);
> >+              sk_acceptq_removed(sk);
>
> Ditto, are we sure about this?
>
> >               virtio_transport_reset_no_sock(t, skb, sock_net(sk));
> >               sock_put(child);
> >               return ret;
> >@@ -1588,11 +1589,19 @@ virtio_transport_recv_listen(struct sock *sk, st=
ruct sk_buff *skb,
> >               child->sk_write_space(child);
> >
> >       vsock_insert_connected(vchild);
> >+      release_sock(child);
> >+      lock_sock(sk);
>
> IMO this is a deadlock with the lock_sock(sk) called by the caller.
>
> Also a comment would be helpful here to explain why we're doing this.
>
> >+      if (sk->sk_shutdown =3D=3D SHUTDOWN_MASK) {
> >+              release_sock(sk);
> >+              sk_acceptq_removed(sk);
> >+              virtio_transport_reset_no_sock(t, skb, sock_net(sk));
> >+              sock_put(child);
> >+              return -ESHUTDOWN;
>
> Since this is very similar to the error path of
> vsock_assign_transport(), I think it would be better to start by
> defining a common error path for the function and use labels to exit, so
> we can avoid duplicating the code multiple times.
>
> >+      }
> >       vsock_enqueue_accept(sk, child);
> >+      release_sock(sk);
> >       virtio_transport_send_response(vchild, skb);
> >
> >-      release_sock(child);
> >-
>
> TBH I'm really worried about this patch since both fixes are completely
> wrong IMO.
>
> Thanks,
> Stefano
>
> >       sk->sk_data_ready(sk);
> >       return 0;
> > }
> >--
> >2.43.0
> >
>


Hi Stefano,

Thank you for the detailed review!

You are correct on both points. I apologize for the confusion =E2=80=94 I w=
as
looking at an older version of the code where sk_acceptq_added() was
called BEFORE vsock_assign_transport(), which made the
sk_acceptq_removed() fix appear necessary. In the current kernel,
sk_acceptq_added() is already moved to after vsock_assign_transport(),
so that issue no longer exists.

Regarding the lock_sock(sk) fix =E2=80=94 you are also correct that
virtio_transport_recv_pkt() already holds lock_sock(sk) before calling
virtio_transport_recv_listen(), so our second fix would indeed cause a
deadlock. I missed that completely.

I am still investigating the root cause of the memory leak reported by
syzbot. The backtrace points to the vsock loopback path
(vsock_loopback_work), so I am looking there next. I will send a v2
once I have a correct analysis and fix.

Sorry again for the noise.

Thanks,
Deeranshu Kartikey
