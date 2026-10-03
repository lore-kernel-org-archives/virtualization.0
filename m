Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98121CAA6D
	for <virtualization@lists.linux.dev>; Sat,  3 Oct 2026 23:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791071653; cv=pass; b=jW+A6bfvrJIX2e4IqBUVvT8L0M+BsWWeWIIG3abOCUotmK/bO2gWr+frJGaoxhOwZzz1Jk6ONieGraDMcbdQMCrvElmxvEN74m0vZZx6Ia0GHkJjt/Vc+agCF5LyOG/dL37Ld8LUaSfc76O5bfNx+dVoyr9MT16uPy/9ddU+K0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791071653; c=relaxed/simple;
	bh=tLQXED6TnpPW56Dh+KHvxT+XAjreuYSqEVzU3htBIms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iK0KYGRm1Kxf9p0VVAAk3AxJ5xbSENxGZfqp3psbJRoGs1wUwH+9f4TuR6QM/ltf/8+GsmjDx8yHAcE1RexgYB10ogZOvI0Ut70PovlyMegsFdMsY917R7pNXp4sY27Euol+1ff4JuJK5BWeWx6QfD/vhsYrrS9jF/jPtdzJj/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2TH249c; arc=pass smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2TH249c"
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-93910ad20d4so59623785a.3
        for <virtualization@lists.linux.dev>; Sat, 03 Oct 2026 16:54:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791071650; cv=none;
        d=google.com; s=arc-20260327;
        b=rNr+MQ/CjsnDclcVWZIkkzaa4SG2159qpd00KPHqaamZ9xRmpv70z9lg1EY5k+57H6
         JD6VihQTqcb4jI5CrzuFAxHtbiwi8Wa93xW/92Ljjx7Ti18gm2NnkQUjZv5SY9xZkTIP
         gcN6VA7I0nuNqxTnkS5kPxTcWaQXlv8DUmFkWu20hV3an9jpCNqGYwMMCYR4VIQss8LH
         LqhaZ5cKicY3C+1ibhPwS7h3JxRbV2E1Q6HXtYMEXH1xE7suqMY/2afzTsMPRynKD94m
         aRwYDcnSnvWFzV4ZX3l7hNjb206t1LI+HR1VhJJ+BpuqxG+X1n9m/P1b01bNEESR8s1k
         r0+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mfJzD8Nrn5OBEx9DAMeICCEetrQp74ti+65lMtrTctk=;
        fh=G6POXxUe0D+UzNMNk41S8TRkfqiOm6gVh9B4byvBXQo=;
        b=ZIeryrEs2uEdiv5NPbDEh7q0u1WaQRo1mVEzdYtGrQ7kP9LQvC4uVQS924bb9qH8/8
         ZeWcaYg5iZWbSl7IHt63zTxEawJU6uKFidXNoYXGx/ZVAHaPIyVdj3mKZtBDgSRIZN1w
         nEgE6dTB1XJlYvSieCZM2q98JsLQab3Yfnu0AFhPPqemX3J13qzitfNq9eI8fgUAqu7B
         EoqOGlEW+Uk/IZlJDV6JK2eakJIQF14KL231+3yNXET3nVvWBOaq8poYSkzQggMmzt1H
         4EUwM8Ezii5At3soj+NYsVeZM7bfOyrcKv5laB+oDmYsAtwO5I8v5L9jRNEOyJbEtRMZ
         p5Cw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791071650; x=1791676450; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mfJzD8Nrn5OBEx9DAMeICCEetrQp74ti+65lMtrTctk=;
        b=M2TH249cN7cKaG28ibZ5SpCCTUKILB/fkUwLlGytz6e2TGBmoYD0ViRSJAUQa/1v9j
         md2FSFXfbMRV2/6QwZ9Bpd5YyvzN2XFmt+dZgpenz4tFza+e9IvLDYGahyV4C4XlG9xx
         sY5xE+/vnuSYGt55hPZCPrqJ3vm3qUe/5kQIPjiBIlgXkos5rJjTpCn5mEBtub3IvtwX
         weF/I/5kb5qt+shCBzqy/RNnIuhdyEWxPIxXXXZImBIkzMmoWe6fdzcyhbz+RxWvayLz
         UneXoJYVvmDnAIFdEu8MnwfZWeeFKHBqEGWX2FuvqY3FjqO9dluDB4gFEVLkUEFcFZVu
         NbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791071650; x=1791676450;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mfJzD8Nrn5OBEx9DAMeICCEetrQp74ti+65lMtrTctk=;
        b=KbUcWHXw+K3vnXs8sBM0k4aYZvZZk+DaknRUfQyEHLifgjZpaQMyJ4VsjzShzsNWzz
         VO1sWJDY7R04B0JJsDTaxOOqTf8pZXlGlU1KZr4r8/QWfg/kZBH6jRzA/tXvaLqevuPg
         BYUe/Vy0Puf2WglDMRlc7udSRhOulgSe+OtJ8myUXL0QK0KKClIpCzRGbbU7Fby02Kpe
         O16hUg8Fo4PhB1qqQ4Ss4mtkvEQMemlyZ0d2GevgVv3fk0tL0xPdAXzFbGNT9T+/zBB0
         Pn6tKPZRY99q7P8HtjAy+xyNuFAW6IDTMBKhbkgQdAiXw36hMw1Jr3EHBIOxjg3CJz8J
         TmKw==
X-Forwarded-Encrypted: i=1; AKwUvByukqxRPfHEFD6h8xJKFfPP1phRVg2MuY6HzMWQesGcVMRruFHgAS5Nlg5NJ+hVpPzQhZ+V4Eprxanyvux1bg==@lists.linux.dev
X-Gm-Message-State: AFuF++nBrvyjnr+MNElhMp/DgzrR3FYQcBENokLKoaCQ7R1kd7J9ZIrs
	alSqBZnDsAvSIXFkq4749VXauCcG0DJR4du0QG/pNgvxVFQSn8M9LJjN5YR68Dio+LKc9rNg5ed
	gz8Jy49b4I/V1ASLXvuAuqzh2m0Tw50A=
X-Gm-Gg: AYBFou3U0TbnizGEKDQF5UyyUysfey4lVWkRZZFSDdPHqrPOZQYXDUcSHVXiWTRkj7x
	ztYEdU2KbUq291J30xyNdjiW6ugRO1WWJdH2qLIqIvtGxYpuqAKLcef+yVtTSpAswKEhPPq4W5p
	M/61c7H60ldBABUSg0Ehe2F3SM418ZkfG4MIafVhqXsVuxN8GISh88zWcpi/WtAmc68wRS3G8p0
	oJ9MqPHIIGj7VJHQag1oiHp13wNQuDVc0L60oLT/gYhFCepALtBjCxNKbyxOc5Wg8JQutySV+hu
	L87i9NjAZRUg47akrxgh0mzlHBTXk0mfb/tOZLk7kK53jG4916XYWgU=
X-Received: by 2002:a05:620a:608c:b0:93e:4d60:d389 with SMTP id
 af79cd13be357-93e4d60d772mr857459885a.25.1791071650174; Sat, 03 Oct 2026
 16:54:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261002074551.318789-6-physicalmtea@gmail.com> <20261003074657.71AC91F0089C@smtp.kernel.org>
In-Reply-To: <20261003074657.71AC91F0089C@smtp.kernel.org>
From: Jia Jia <physicalmtea@gmail.com>
Date: Sun, 4 Oct 2026 07:53:34 +0800
X-Gm-Features: AclHuK9yiZzs7l16_RtJMlKQwOPOXk2Ehni0GrB9F0m8WE6NLxHkqNqpNjLmApI
Message-ID: <CAJwVaMLBRYhoZ9krgTt5X2e__AYXMtyJQhW_DEQ8_zqCM7WxZg@mail.gmail.com>
Subject: Re: [PATCH 5/5] vsock: defer RX readable notifications until batch unlock
To: sashiko-reviews@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Eugenio Perez <eperezma@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] vsock: unreachable callback replacement abort logic in batching
> --
>
> commit 811453fb266663fdded1db37d3b4cf3bde547c9f
> Author: Jia Jia <physicalmtea@gmail.com>
>
> vsock: defer RX readable notifications until batch unlock
>
> This commit defers vsock RX data-ready notifications until the batch fini=
shes
> and releases the socket lock. It records the initial callback to handle
> mid-batch replacements.
>
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/vi=
rtio_transport_common.c
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
>
> [ ... ]
>
> > @@ -2015,6 +2040,13 @@ void virtio_transport_recv_pkt_batch(struct virt=
io_transport *t,
> >                   vsock_addr_equals_addr(&batch->dst, &dst) &&
> >                   virtio_transport_recv_pkt_batchable(t, batch->sk)) {
> >                       sk =3D batch->sk;
> > +                     defer_data_ready =3D READ_ONCE(sk->sk_data_ready)=
 =3D=3D
> > +                                        vsock_sk(sk)->default_data_rea=
dy;
> > +                     if (batch->data_ready_pending && !defer_data_read=
y) {
> > +                             virtio_transport_rx_batch_finish(batch);
> > +                             goto lookup;
> > +                     }
> > +
>
> [Severity: Low]
> Can this branch ever execute?
>

Unless I'm mistaken, this branch can actually be reached.

> The condition checks if a custom callback was installed (!defer_data_read=
y)
> while a default notification is already pending.
>
> Since custom callback attachments (such as BPF sockmap insertion) require
> acquiring the exact same socket lock, and the lock is held continuously w=
hile
> the batch is active, is it possible for the callback to change from defau=
lt
> to custom mid-batch?
>
> Could this bailout branch be unreachable dead code due to the structural =
mutual
> exclusion provided by the socket lock?
>

The premise that sockmap updates always take lock_sock(sk) applies only to
the syscall path. When a BPF program calls bpf_map_update_elem(), for examp=
le
from SK_LOOKUP or BPF_TRACE_ITER, sock_map_update_elem() takes
bh_lock_sock(sk),

The batch reuse path checks sk->sk_prot in
virtio_transport_recv_pkt_batchable() before reading sk->sk_data_ready. A
concurrent BPF update can replace both callbacks between those reads while
the RX worker owns the socket.

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002074551.31=
8789-1-physicalmtea@gmail.com?part=3D5
