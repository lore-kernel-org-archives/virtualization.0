Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794883972;
	b=ar+yWMAeFGiOUrE+swdZFelPLMRpsoDCzmme+d1iXHPVaPdm0Evszw9qe+an+LSawry+
	 Zt04rygbgqDiNVI3XdAPCjMpRr0HIti1BZaMvZf7BLxpzNxqIVpMH2WbT9/70tHvYEdt+
	 zkTVxZVzrNYzARBwUEMTeXAzdYMfundiEkImGwdgnep+IJqB2HGok78JHWBaVOXT0dYOj
	 Lbv7wjMRXwMp5tEhGeVdenYb9PRORclOFZQuRyVNxviz2BDqID/OQRMPdw/JmsU9oH1Qm
	 G/OhbtauKpt/4HvxETnd0PuhqjVvLtrzh565p0kD8IP7RXn6JEDgogc4NWmrOkUU8nw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794883972;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=OlPS9Kfou8N6H/RDr1nqKaimcfFezjwaIA8OrMI9tXA=;
	b=GcDU6biVGjY9iwF4TIAkGWLSBNAGUytr2V/6nMdG9HB5pqVTMxCificICsGAq91fxd3k
	 NLoM1u37P+UiWJRPhsIr7V1tDfgegOAEqreZjLDgeWguxiEFbsLFn+pUUSeXT6pB+7Ra+
	 7dx3wtAkvP3V/Ia9aLEABLei325MV0mXjOu10OQYve+UaNmhNaQf+ztjBAkOqaio79aIn
	 UACVJFRbDxHcBoHscSZPlz86HG2KS8HtewF+E7K7acA5y+dg3fPssL4eGFDzn1WzHjCtr
	 SVDIU46cIAdEDRDGtgfHDXVcS4R7meqTktYMvUAYKkJGDGJvOxmuJXqRh55W7z2BPlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TSGINtSJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D299E606A323
	for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 02:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D299E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TSGINtSJ
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-943e8d35f74so463767185a.0
        for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 18:52:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794883971; cv=none;
        d=google.com; s=arc-20260327;
        b=XVorNzQZeBk2AM07Jj0hpA7H0w4yoGrInXiknxoyuM/yi6POWhg4wvKBnRf9XLYcML
         BRjgBTQsfQ8L2WNwUQnL/R5o17wQuOOclm6E9ZCeBcXSke0FDW0Gxgs5mSAdu4zCyFEt
         tTVNpCiVV84gIFnmwryjMSFzjShqo9Nede7TKo4HU2l68Hq9ikmLfNZ0UPPblPOjh5Eu
         Ztai1MWre1oyZAjdtRONjcChCn7Dg8Nh+IBXo1knwvN7/AVEPGpBYcZ7mSpI1DHuP3KI
         VTUm9kFWZxXQAn8uhcr5WFB/502pogUj4vmHr3X+cTkdecgSNP9Zpisc84OVx4Fxt72D
         xAaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OlPS9Kfou8N6H/RDr1nqKaimcfFezjwaIA8OrMI9tXA=;
        fh=EkW39vu8QRW2aIJQYX0WVPaC1VK2W13zqSNVzpjNu+0=;
        b=e9ZoxebovPYSK2qIX0VihjCUJ+gh2DxSaVorjgK9CfB3SOzfUmqvJ0SdRCnfndoqby
         1lO3LzPT9loUBWeEySb4MUhBBEFwvsTc6N4tS36wcF0P3R0i2ARf9EwpXxKcteRS2Vim
         J148unurOCiDDuCSjmH7/N4cDm6FCaa5y6WntyrV6XEgfjYfSHCl5C3hgZDEQk9K1GeI
         kWEfN2uFKZ2H8enmpOarFZusN6LlpDkN4sU5KjONkdMTJ7XDf8M2rUfCLAmkddL1f91a
         RUhD7SY4vQfnJ0BhdjCNPFHH6oxxOor3xt+BvQ0S6gTYau2GfCy2/UiKwOfBJjHhcGk/
         db6g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794883971; x=1795488771; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OlPS9Kfou8N6H/RDr1nqKaimcfFezjwaIA8OrMI9tXA=;
        b=TSGINtSJNJqLoUmdVkXOSkCaWvm+/PJoFlEYonKihsk0RM5X3d3SF4KIe3IAxoquNd
         frM15dfzdYeDXA442CjhwlAV0FHFrkIwn5i9z4/wWy8+ZfYey3wErnVnml3ZX8SzSXXj
         WtCBeuo9i2I3/QgBG7OvPv4HpKMPVFVS1FGEzfkKokUuz18nGxBwXdYqtgVlwqDUaX+X
         xRjj0HVkUkv7EvhWrfFBExIz0W3BuIk0+IeER+w11DQq5JYan3UY5/2xvBC7XEG1cCfa
         m0TtRRjsB1g2d7AyTNx4B6lS95fxX8G4BjIanhk0/NSzZa4AMJWj/ZhV2aoP0Iw3be3Q
         KS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794883971; x=1795488771;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OlPS9Kfou8N6H/RDr1nqKaimcfFezjwaIA8OrMI9tXA=;
        b=09N+RUyWKt+qY5rbh2A+eM57rjbWKJLQBshxP8O+/ZaQNq6PwcOegMK5rC50qrdBEo
         /gO4JzHAwOfq9Ibee9liKPJHZKh113GOd59HgzKC3LsbH9FCFvgHxnjAyd/BEshBW+KQ
         goGq0qb7p/yetfCrK4ck6LrS30ESAczrZNN6m+HH9ARIj2em31gFabcyA0gE6FtR/2Bp
         PwokR7KeBXomtM3uq96yCr75R++QvseeT+jrhA8SzyFNeNrfIlJNYKCAgko8WhbfETjJ
         UJtRp+9Wa2k5MqJOOGxfatBrN5pyAfzENWh2eYbX5nYTdG9OMVsXj7H2rb1BKIc3IdKH
         bpsA==
X-Forwarded-Encrypted: i=1; AL+hErEfuaeXyuhUBrCrZAEjnZDNvFoYCXkoRqb6TuKm8vznNbJaV4u7oPwINEduXSp8iTnowrlZp7UtA6iZHsPISA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/4/SfstI8IoqZylshyqXppDLsI34pD3ZiWMjSprELdkXYo/+Yh
	5xUU97hpWNeepQd1+Xbxc0ZdIfP+30y7Jogg0zdJr5MBJtTc7lku7EJyhs3wsXpj2/PEXDPvPcr
	xSi0uHGjSc92E4QNZ4n8TVpGWwO3BJzg=
X-Gm-Gg: AYBFou15KmxVI1e7gTjHzw7/izUjgH2Q98zBsH+sBhuvgZxRNpxcEhO4h0j927IiuZ2
	J2Pn6Sq1kxFYEsuG6YM13GiuTunqGS6hilJ9rZE0n1cUs64EPNhR+FMnmen+UPBRMWrk6QA6WXE
	YjG/g0fAWOLGg+wQ7xnu3ku0/3+0/F1HIq6a8uFsjt4DWDrg082zEq/Kz9myto/GYH8Z969kkhP
	P5oeTDWoSoPS22wIWvcA0UkN3WNFGQSwhHA7ao3CWw2z2HAH8CokugM48FOfP8qAzL6sw1ICawO
	yUjLyc48sLI5+eTtdJpUrAmogzGw4C96yvbp0apIX2Np6bOjmP0EMWx7mEBL8QM+uoft09gPQm6
	Xw+HV/ozxDFo0Yk0XkM2XKhqylpop3ameDmJHj0jz7aNvh085R7V2q4MUv43Fn0O6f5q3khY=
X-Received: by 2002:a05:620a:1b89:b0:949:7502:697 with SMTP id
 af79cd13be357-9497502087bmr1030338685a.63.1794883970561; Mon, 16 Nov 2026
 18:52:50 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261103041134.33310-1-physicalmtea@gmail.com>
 <20261103041134.33310-6-physicalmtea@gmail.com> <avYF8fZqDhizgpN7@devvm29614.prn0.facebook.com>
In-Reply-To: <avYF8fZqDhizgpN7@devvm29614.prn0.facebook.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Tue, 17 Nov 2026 10:52:13 +0800
X-Gm-Features: AclHuK9nxC3MJujdBNPcQbeswYQRZoCydaZv79v1XYlRN3G5tbfjWjS8yWNku_A
Message-ID: <CAJwVaMKe8ntHu0dWUO0EirdtzQAQu=wH60sYKThMOZrtPUysXQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 5/5] vsock/virtio: defer native RX readiness
 notifications until batch unlock
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: netdev@vger.kernel.org, stefanha@redhat.com, sgarzare@redhat.com, 
	mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Tue, Nov 03, 2026 at 12:11:34PM +0800, Jia Jia wrote:
> > An RX batch can make a socket readable while the RX worker retains its
> > socket lock. Waking a blocked reader before release_sock() merely makes it
> > wait for the same lock.
> >
> > P4 coalesces native sk_write_space notifications while retaining their
> > under-lock callback context. This patch also coalesces native sk_data_ready
> > notifications and moves both callbacks after release_sock(), so awakened
> > tasks do not immediately block on the RX worker's socket lock.
> >
> > Save the native data-ready callback before the AF_VSOCK socket is
> > published. Batch only while the native protocol and both native readiness
> > callbacks are present and no psock is observed under sk_callback_lock. A
> > socket with a replacement callback continues down the existing per-packet
> > path.
> >
> > At batch finish, deliver write-space before data-ready and hold the
> > connected lookup reference until both callbacks return. Packets admitted on
> > the native path continue to use their saved native callbacks. Loading a
> > current sockmap callback at finish would not serialize its invocation
> > against sockmap teardown and could lose the native wakeup or invoke a stale
> > data-ready wrapper.
> >
> > Extract the data-ready predicate from vsock_data_ready() so the deferred
> > and regular paths share the low-watermark test.
> >
> > Performance:
> >
> > P4-P5 contribution (P1-P3 vs P1-P5):
> >
> > End-to-end RX throughput (64K Guest recv() size, SO_RCVLOWAT=1; Gbit/s):
> >
> >   payload  P1-P3 RX  P1-P5 RX  throughput change (95% CI)
> >            (Gbit/s)      (Gbit/s)
> >   64B        0.2449       0.2463    +0.55% [-3.86%, +5.17%]
> >   256B       0.9649       0.9931    +2.93% [+0.83%, +5.07%]
> >   512B       1.8205       1.8260    +0.30% [-4.27%, +5.10%]
> >   1K         3.3431       3.3420    -0.03% [-2.15%, +2.12%]
> >   4K         5.6541       5.8428    +3.34% [+1.10%, +5.63%]
> >   8K         5.4280       5.3364    -1.69% [-15.55%, +14.46%]
> >   16K        5.5935       5.6701    +1.37% [-1.41%, +4.23%]
> >   64K        5.6917       5.8351    +2.52% [-0.20%, +5.31%]
> >
> > Fixed-syscall stress test (receiver recv() size = sender write size;
> > Gbit/s):
> >
> >   payload P1-P3 RX P1-P5 RX throughput change (95% CI)
> >   recv() calls are listed as P1-P3/P1-P5.
> >   64B      0.2553   0.2575   +0.87% [-3.68%, +5.63%]
> >            1048577/1048577
> >   256B     0.9069   0.9183   +1.26% [-3.96%, +6.76%]
> >            1048577/1048577
> >   512B     1.6048   1.6459   +2.56% [+0.98%, +4.18%]
> >            1048577/1048577
> >   1K       2.6939   2.7357   +1.55% [-1.35%, +4.54%]
> >            1048577/1048577
> >   4K       4.9168   4.9678   +1.04% [-1.84%, +4.00%]
> >            524965/525283
> >   8K       5.1476   5.2005   +1.03% [-4.02%, +6.34%]
> >            262926/263156
> >   16K      5.5964   5.6609   +1.15% [-2.86%, +5.33%]
> >            131311/131475
> >   64K      5.9439   5.9073   -0.62% [-3.00%, +1.83%]
> >            32875/32937
> >
> > Guest CPU1 aggregate cycles per received byte
> > (fixed 64K receiver, with perf):
> >
> >   payload     P1-P3     P1-P5  change (95% CI)
> >   64B        60.281    58.258  -3.36% [-8.74%, +2.35%]
> >   256B       14.242    13.648  -4.17% [-9.81%, +1.82%]
> >   512B        7.547     7.211  -4.45% [-9.73%, +1.13%]
> >   1K          3.987     3.853  -3.35% [-8.52%, +2.12%]
> >   4K          1.983     1.880  -5.17% [-7.97%, -2.27%]
> >   8K          1.665     1.620  -2.75% [-9.03%, +3.96%]
> >   16K         1.409     1.346  -4.52% [-10.94%, +2.37%]
> >   64K         1.322     1.281  -3.11% [-6.49%, +0.38%]
> >
> > Full-series cycles/B (baseline vs P1-P5):
> >
> > Guest CPU1 aggregate cycles per received byte
> > (fixed 64K receiver, with perf):
> >
> >   payload  baseline     P1-P5  change (95% CI)
> >   64B        65.282    57.843  -11.40% [-13.77%, -8.95%]
> >   256B       14.710    13.813   -6.10% [ -7.89%, -4.28%]
> >   512B        7.709     7.188   -6.75% [ -8.79%, -4.66%]
> >   1K          4.075     3.862   -5.23% [ -6.80%, -3.63%]
> >   4K          2.034     1.887   -7.21% [ -8.67%, -5.72%]
> >   8K          1.664     1.568   -5.78% [ -7.83%, -3.69%]
> >   16K         1.450     1.385   -4.48% [ -6.08%, -2.86%]
> >   64K         1.338     1.317   -1.51% [ -3.21%, +0.22%]
> >
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> >  include/linux/virtio_vsock.h            |  5 ++-
> >  include/net/af_vsock.h                  |  9 +++--
> >  net/vmw_vsock/af_vsock.c                | 27 ++++++++++---
> >  net/vmw_vsock/virtio_transport_common.c | 52 +++++++++++++++----------
> >  4 files changed, 62 insertions(+), 31 deletions(-)
> >
> > Tested:
> >   Concurrent map-entry attach/detach during sequenced RX and duplex traffic
> >   passed on baseline, P1-P3, P1-P4, and P1-P5. The active SK_PASS case also
> >   passed on each state, with 200,000 verdict invocations. The concurrent
> >   SK_PASS attach/detach case completed 1,000 insert/remove pairs per state;
> >   its 10,000-record suffix after the final detach was verified. No kernel
> >   diagnostic markers were found in successful runs.
> >
> >   Sockmap may replace sk_data_ready and sk_write_space. With non-native
> >   callbacks, native RX batching must be declined and the ordinary per-packet
> >   receive path used. The active SK_PASS case covers the condition expected to
> >   trigger this fallback. The test does not trace each packet's internal
> >   branch, so it verifies the fallback scenario without asserting that every
> >   packet took that branch.
> >
> >   The duplex cases exercised write-space backpressure: the guest's nonblocking
> >   send reached EAGAIN while the host was not reading. After the host began
> >   draining data, the guest observed POLLOUT and resumed sending. Counts below
> >   are observed EAGAIN/POLLOUT recoveries.
> >
> >     Test / result                              baseline   P1-P3   P1-P4   P1-P5
> >     No-verdict RX churn: attach/detach pairs     433493  455507  430985  380351
> >     No-verdict duplex: attach/detach pairs       229793  212410  214198  148755
> >     No-verdict duplex: EAGAIN/POLLOUT            365/365  266/266  264/264  443/443
> >     Active SK_PASS: EAGAIN/POLLOUT              2548/2548 3013/3013 3093/3093 4208/4208
> >     SK_PASS attach/detach: intervals with verdict progress 705 616 631 692
> >     SK_PASS attach/detach: verdict invocations  99747   99894   97475   82409
> >     Post-detach SK_PASS suffix                 10,000/10,000 records per run
>
> I'd probably shorten the long description.
>

Sure, I'll shorten it.

> I wonder if the sockmap tests in the bpf selftests cover some of these
> scenarios and coulde be extended for vsock?
>

I had a look, and they do not seem to cover this scenario. I have not
worked on the bpf selftests before, but I can try to add these tests as
a follow-up.

> >
> > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > index bf28e8e32e280..2aa0e81e655d5 100644
> > --- a/include/linux/virtio_vsock.h
> > +++ b/include/linux/virtio_vsock.h
> > @@ -287,14 +287,15 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> >   * Initialize a batch to zero before use. A non-empty batch owns @sk's socket
> >   * lock and the reference returned by vsock_find_connected_socket_net(). The
> >   * caller retains both until it calls virtio_transport_rx_batch_finish(). An
> > - * empty batch owns neither. A pending native write-space notification belongs
> > - * to the lock holder and is delivered by virtio_transport_rx_batch_finish().
> > + * empty batch owns neither. Pending native readiness notifications belong to
> > + * the lock holder and are delivered by virtio_transport_rx_batch_finish().
> >   */
> >  struct virtio_transport_rx_batch {
> >       struct sock *sk;
> >       unsigned int pkts;
> >       size_t bytes;
> >       bool write_space_pending;
> > +     bool data_ready_pending;
> >  };
> >
> >  static inline bool
> > diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> > index b76ab565ea58b..57ee545fdb496 100644
> > --- a/include/net/af_vsock.h
> > +++ b/include/net/af_vsock.h
> > @@ -64,9 +64,10 @@ struct vsock_sock {
> >       bool sent_request;
> >       bool ignore_connecting_rst;
> >       /*
> > -      * Captured before the socket is published. This identifies AF_VSOCK's
> > -      * native write-space callback after a consumer has replaced it.
> > +      * Captured before the socket is published. These identify AF_VSOCK's
> > +      * native readiness callbacks after a consumer has replaced them.
> >        */
> > +     void (*native_data_ready)(struct sock *sk);
> >       void (*native_write_space)(struct sock *sk);
> >
> >       /* Protected by lock_sock(sk) */
> > @@ -83,7 +84,9 @@ s64 vsock_stream_has_data(struct vsock_sock *vsk);
> >  s64 vsock_stream_has_space(struct vsock_sock *vsk);
> >  struct sock *vsock_create_connected(struct sock *parent);
> >  void vsock_data_ready(struct sock *sk);
> > -bool vsock_write_space_is_native(const struct sock *sk);
> > +bool vsock_data_ready_pending(struct sock *sk);
> > +bool vsock_callbacks_are_native(const struct sock *sk);
> > +void vsock_call_native_data_ready(struct sock *sk);
> >  void vsock_call_native_write_space(struct sock *sk);
> >
> >  /**** TRANSPORT ****/
> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > index e39567990539f..0617073e99ed8 100644
> > --- a/net/vmw_vsock/af_vsock.c
> > +++ b/net/vmw_vsock/af_vsock.c
> > @@ -958,6 +958,7 @@ static struct sock *__vsock_create(struct net *net,
> >               sk->sk_type = type;
> >
> >       vsk = vsock_sk(sk);
> > +     vsk->native_data_ready = sk->sk_data_ready;
> >       vsk->native_write_space = sk->sk_write_space;
> >       vsock_addr_init(&vsk->local_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
> >       vsock_addr_init(&vsk->remote_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
> > @@ -1113,24 +1114,38 @@ s64 vsock_stream_has_space(struct vsock_sock *vsk)
> >  }
> >  EXPORT_SYMBOL_GPL(vsock_stream_has_space);
> >
> > -void vsock_data_ready(struct sock *sk)
> > +bool vsock_data_ready_pending(struct sock *sk)
> >  {
> >       struct vsock_sock *vsk = vsock_sk(sk);
> >
> > -     if (vsock_stream_has_data(vsk) >= sk->sk_rcvlowat ||
> > -         sock_flag(sk, SOCK_DONE))
> > +     return vsock_stream_has_data(vsk) >= sk->sk_rcvlowat ||
> > +            sock_flag(sk, SOCK_DONE);
> > +}
> > +EXPORT_SYMBOL_GPL(vsock_data_ready_pending);
> > +
> > +void vsock_data_ready(struct sock *sk)
> > +{
> > +     if (vsock_data_ready_pending(sk))
> >               sk->sk_data_ready(sk);
> >  }
> >  EXPORT_SYMBOL_GPL(vsock_data_ready);
> >
> > -bool vsock_write_space_is_native(const struct sock *sk)
> > +bool vsock_callbacks_are_native(const struct sock *sk)
> >  {
> >       const struct vsock_sock *vsk = vsock_sk(sk);
> >
> > -     return READ_ONCE(sk->sk_write_space) ==
> > +     return READ_ONCE(sk->sk_data_ready) ==
> > +            READ_ONCE(vsk->native_data_ready) &&
> > +            READ_ONCE(sk->sk_write_space) ==
> >              READ_ONCE(vsk->native_write_space);
> >  }
> > -EXPORT_SYMBOL_GPL(vsock_write_space_is_native);
> > +EXPORT_SYMBOL_GPL(vsock_callbacks_are_native);
> > +
> > +void vsock_call_native_data_ready(struct sock *sk)
> > +{
> > +     vsock_sk(sk)->native_data_ready(sk);
> > +}
> > +EXPORT_SYMBOL_GPL(vsock_call_native_data_ready);
> >
> >  void vsock_call_native_write_space(struct sock *sk)
> >  {
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index af26344678e41..9d02e81042c21 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -1598,7 +1598,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> >
> >  static int
> >  virtio_transport_recv_connected(struct sock *sk,
> > -                             struct sk_buff *skb)
> > +                             struct sk_buff *skb,
> > +                             bool *data_ready_pending)
> >  {
> >       struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> >       struct vsock_sock *vsk = vsock_sk(sk);
> > @@ -1617,7 +1618,12 @@ virtio_transport_recv_connected(struct sock *sk,
> >                       vsock_remove_sock(vsk);
> >                       break;
> >               }
> > -             vsock_data_ready(sk);
> > +             if (data_ready_pending) {
> > +                     if (!*data_ready_pending && vsock_data_ready_pending(sk))
> > +                             *data_ready_pending = true;
> > +             } else {
> > +                     vsock_data_ready(sk);
> > +             }
> >               return err;
> >       case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
> >               virtio_transport_send_credit_update(vsk);
> > @@ -1874,20 +1880,19 @@ __virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
> >               return false;
> >
> >       /*
> > -      * Sockmap can replace sk_prot or sk_write_space, and publish a psock,
> > -      * without the socket lock. Coalescing is safe only for the native
> > -      * write-space callback, so a boundary that sees a replacement returns to
> > -      * the existing per-packet path.
> > +      * Sockmap can replace sk_prot or either readiness callback, and publish a
> > +      * psock, without the socket lock. Coalescing is safe only for native
> > +      * callbacks, so a boundary that sees a replacement returns to the existing
> > +      * per-packet path.
> >        */
> >       return READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
> > -            vsock_write_space_is_native(sk) &&
> > +            vsock_callbacks_are_native(sk) &&
>
> It'd be nice to avoid inter-patch churn.
>

Sure. My earlier understanding of this part across P4/P5 wasn't quite
accurate; I'll fold the final callback check into the earlier patch.

> >              !virtio_transport_sock_has_psock(sk);
> >  }
> >
> >  /*
> > - * Sockmap teardown restores the native protocol and write-space callback
> > - * under sk_callback_lock. Serialize each packet admission check with those
> > - * updates.
> > + * Sockmap teardown restores the native protocol and callbacks under
> > + * sk_callback_lock. Serialize each packet admission check with those updates.
> >   */
> >  static bool
> >  virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
> > @@ -1905,9 +1910,8 @@ virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
> >  /*
> >   * The caller holds sk's socket lock. If @batchable is non-NULL, update it
> >   * after processing @skb to say whether a native STREAM/RW batch can continue.
> > - * When @batch is non-NULL, record a native write-space notification for batch
> > - * finish. A writer cannot consume the updated credit until this lock is
> > - * released.
> > + * When @batch is non-NULL, record native readiness notifications for batch
> > + * finish. A reader or writer cannot make progress until this lock is released.
> >   */
> >  static void
> >  virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> > @@ -1917,6 +1921,7 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> >  {
> >       struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> >       struct vsock_sock *vsk = vsock_sk(sk);
> > +     bool *data_ready_pending;
> >       struct sockaddr_vm src;
> >       bool space_available;
> >
> > @@ -1926,6 +1931,8 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> >       if (batchable)
> >               *batchable = false;
> >
> > +     data_ready_pending = batch ? &batch->data_ready_pending : NULL;
> > +
> >       /*
> >        * The socket may have been closed or reassigned after lookup but before
> >        * its socket lock was acquired. Listener sockets have no assigned
> > @@ -1962,7 +1969,7 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> >               kfree_skb(skb);
> >               break;
> >       case TCP_ESTABLISHED:
> > -             virtio_transport_recv_connected(sk, skb);
> > +             virtio_transport_recv_connected(sk, skb, data_ready_pending);
> >               break;
> >       case TCP_CLOSING:
> >               virtio_transport_recv_disconnecting(sk, skb);
> > @@ -2036,32 +2043,37 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
> >
> >  /*
> >   * Release an active RX batch. A non-empty batch holds the socket lock and the
> > - * reference returned by vsock_find_connected_socket_net(). Deliver any
> > - * deferred native write-space notification while holding the lock, preserving
> > - * the callback context of the regular receive path. An empty batch holds
> > - * neither.
> > + * reference returned by vsock_find_connected_socket_net(). Release the lock,
> > + * deliver deferred native write-space and data-ready notifications in that
> > + * order, then drop the reference. An empty batch holds neither.
> >   */
> >  void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
> >  {
> >       bool write_space_pending = batch->write_space_pending;
> > +     bool data_ready_pending = batch->data_ready_pending;
> >       struct sock *sk = batch->sk;
> >
> >       batch->sk = NULL;
> >       batch->pkts = 0;
> >       batch->bytes = 0;
> >       batch->write_space_pending = false;
> > +     batch->data_ready_pending = false;
> >
> >       if (!sk)
> >               return;
> >
> > +     release_sock(sk);
> > +
> >       /*
> > -      * The packet was admitted with the native callback. Do not reload a current
> > +      * Packets were admitted with native callbacks. Do not reload a current
> >        * callback here: sockmap can replace or remove its wrapper independently.
> >        */
> >       if (write_space_pending)
> >               vsock_call_native_write_space(sk);
> >
> > -     release_sock(sk);
> > +     if (data_ready_pending)
> > +             vsock_call_native_data_ready(sk);
> > +
> >       sock_put(sk);
> >  }
> >  EXPORT_SYMBOL_GPL(virtio_transport_rx_batch_finish);
> > --
> > 2.53.0
>
> I think all of this goes away if we support batching in the read_skb()
> call? That is how TCP does it, and they coalesce the sk_data_ready()
> call until after processing a batch I think. This way they don't have to
> drop out if the callback changes.
>
> I think this is probably okay for this series, but long term I wouldn't
> mind seeing the data ready ptr stuff get reverted, and read_skb()
> batching + coalesced sk_data_ready implemented instead.
>

Thanks for pointing out this direction. If we can avoid saving the
native callback pointers altogether, that would be much better. I'll
focus on getting the current series right first, and then look into the
TCP implementation as a follow-up.

> Best,
> Bobby
