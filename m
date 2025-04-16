Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BED6236440
	for <virtualization@lists.linux.dev>; Wed, 16 Apr 2025 10:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744798588; cv=none; b=kDy8/Ur6+2z2MY8BbC8GBVcL7fZWuOMLBv6B2wjZqqZJCIn2qDpKrbRGXRS8+E8rs9/A9ppW0YuX+jMIXXoBW8f5nX0uoE6om+5/VYklVrdLEwo4PYwdD2AU+75Wt86hXu+rd+VShF8oFVRO4qLg4D9wUSu+bAyjnHHXSEuVQ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744798588; c=relaxed/simple;
	bh=LR5XHJIsv4KSkncTHnzjZxFzOCeJ57mh3HG+NkOwuJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4sBAmeG0Co0/3ESWR3tqORVV9kKe36CNpNz00ACBBvvquEne5u4IjzdtIbjwkP2Kk36J5f/Mv/1y0bC+s657SVHHY8WJiBD6lYlGWJPp3JfSAMvZIoP1qQsW0ldSgLwfyrVNDCzzE8QNp8CunPci8k4vPpe8GmFULiuJu83UnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=btdDQsaM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="btdDQsaM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744798586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DyNtBtrm5YLzS/2qKU4Cviogs091o5wq6s+fDtuLR4s=;
	b=btdDQsaM47XOm7K32M/toCA9tZQCddngDcst1e5ecPMNjFOWY+ia1Yd1za/hLO+EApINu7
	+18Qznz1TKXQKvo2vGMsS/Li8D8e+4Mz7OyeqISSVFwWeNXXZ4X8c0FRXebp/6I/jZsOpi
	eck3LFK/G/e8nvRKMBxuAuKedCRTd8Y=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-aY6jW3IRPL6ElPCA0uUbiQ-1; Wed, 16 Apr 2025 06:16:25 -0400
X-MC-Unique: aY6jW3IRPL6ElPCA0uUbiQ-1
X-Mimecast-MFC-AGG-ID: aY6jW3IRPL6ElPCA0uUbiQ_1744798584
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff581215f7so5208275a91.3
        for <virtualization@lists.linux.dev>; Wed, 16 Apr 2025 03:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744798584; x=1745403384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DyNtBtrm5YLzS/2qKU4Cviogs091o5wq6s+fDtuLR4s=;
        b=A6h9u5qXyOJaoNortGVEmMPA7KlDK8mDqMY+Tlot7IZ00uvaaV35iMp9uu1rIkX0Jp
         1ux2ds1HuJUahFTF4cSDCLoLKZ13pQ26ooMcyb4D+KeJ2trcn5Ks8VB7GiWWJv5FQml3
         93kL0i9U0qS4xZSU7lXsnyF3mRLinM0sLTWB/rsT/Y8XLkO9TDYG0WErJJjNDROqParK
         u5nX+wb1dL0b0blcdVQC9fz7OXFFqEjME2XG9jNdiLpZ1mvoQScmatfaqmMyIifGuKrg
         dbTt1rkxKq+lO7p1KFnCcZI2FJ7Ps3nDxqLQLGVgGgbK1ABECtn6Qfbb3yEzKnuSRghO
         1rZg==
X-Forwarded-Encrypted: i=1; AJvYcCVmNAsxfLh2XxXzId4lrnGaecFyk/pSjWZ9JT0VKeIGugmT7Ar6iN2DECne3mJN44H3KO7bYoSHLd3a96SsUw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6VsGRBFSwp2D2mP5orYHuISfNQyl+w3Kfap9NP9x2ed4LhVfh
	cGgZiQbAOsDo4pHGOLWA+ncuSe9UPHneYBCUXgDYU2Sh1TAUnipUHmF7S/F1mlgnj0t2mQ6I1OO
	dojx4Y/uLBgUHIMt1M60l6gdQgVyD/MRNubl9aRCa/WQqLJFWLPvNu/0u+ltyOLaZ4GLdty44/H
	WcaJrKbjtRPJd/XeH+rzVFIwVKWdxTfJ7f9FzkPro=
X-Gm-Gg: ASbGncuUE1FUQsrAh4HC1IPMdePdW1n8QsEhDDoTbrRaoaxMgiseFMFsLW+Hg34Ty/8
	k7gqCQajGYbMmbPZ/w9U0F7mAaXUn9DNcaGENgZjKNpascT7nt2Fla9A8TMgZC84fkmw=
X-Received: by 2002:a17:90b:548d:b0:2ff:6488:e01c with SMTP id 98e67ed59e1d1-3086416ec3emr2001429a91.29.1744798583591;
        Wed, 16 Apr 2025 03:16:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5B8+MIOMuQKL/Q5Vh62fe3WjdrGJl1cNAbpCB38cbA9+YtL9G5ILgxGaQgBlKd18KrUdkzh0QkQQPJug9YUo=
X-Received: by 2002:a17:90b:548d:b0:2ff:6488:e01c with SMTP id
 98e67ed59e1d1-3086416ec3emr2001387a91.29.1744798583226; Wed, 16 Apr 2025
 03:16:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250404145241.1125078-1-jon@nutanix.com> <CACGkMEsFc-URhXBCGZ1=CTMZKcWPf57pYy1TcyKLL=N65u+F0Q@mail.gmail.com>
 <B32E2C5D-25FB-427F-8567-701C152DFDE6@nutanix.com> <CACGkMEucg5mduA-xoyrTRK5nOkdHvUAkG9fH6KpO=HxMVPYONA@mail.gmail.com>
In-Reply-To: <CACGkMEucg5mduA-xoyrTRK5nOkdHvUAkG9fH6KpO=HxMVPYONA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 16 Apr 2025 12:15:46 +0200
X-Gm-Features: ATxdqUHCH-V7i7CU2wT16iuVXDT1SGacdB6YBRKLTHXg-jyKPzbjSDLkTwgL2pg
Message-ID: <CAJaqyWdhLCNs_B0gcxXHut7xufw23HMR6PaO11mqAQFoGkdfXQ@mail.gmail.com>
Subject: Re: [PATCH] vhost/net: remove zerocopy support
To: Jason Wang <jasowang@redhat.com>
Cc: Jon Kohler <jon@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stefano Brivio <sbrivio@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: k3Z1IeEWAnIPRu2O6fSJ43Ss2KUQG-vP2AIRHBEoG7k_1744798584
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 8:28=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Tue, Apr 8, 2025 at 9:18=E2=80=AFAM Jon Kohler <jon@nutanix.com> wrote=
:
> >
> >
> >
> > > On Apr 6, 2025, at 7:14=E2=80=AFPM, Jason Wang <jasowang@redhat.com> =
wrote:
> > >
> > > !-------------------------------------------------------------------|
> > >  CAUTION: External Email
> > >
> > > |-------------------------------------------------------------------!
> > >
> > > On Fri, Apr 4, 2025 at 10:24=E2=80=AFPM Jon Kohler <jon@nutanix.com> =
wrote:
> > >>
> > >> Commit 098eadce3c62 ("vhost_net: disable zerocopy by default") disab=
led
> > >> the module parameter for the handle_tx_zerocopy path back in 2019,
> > >> nothing that many downstream distributions (e.g., RHEL7 and later) h=
ad
> > >> already done the same.
> > >>
> > >> Both upstream and downstream disablement suggest this path is rarely
> > >> used.
> > >>
> > >> Testing the module parameter shows that while the path allows packet
> > >> forwarding, the zerocopy functionality itself is broken. On outbound
> > >> traffic (guest TX -> external), zerocopy SKBs are orphaned by either
> > >> skb_orphan_frags_rx() (used with the tun driver via tun_net_xmit())
> > >
> > > This is by design to avoid DOS.
> >
> > I understand that, but it makes ZC non-functional in general, as ZC fai=
ls
> > and immediately increments the error counters.
>
> The main issue is HOL, but zerocopy may still work in some setups that
> don't need to care about HOL. One example the macvtap passthrough
> mode.
>
> >
> > >
> > >> or
> > >> skb_orphan_frags() elsewhere in the stack,
> > >
> > > Basically zerocopy is expected to work for guest -> remote case, so
> > > could we still hit skb_orphan_frags() in this case?
> >
> > Yes, you=E2=80=99d hit that in tun_net_xmit().
>
> Only for local VM to local VM communication.
>
> > If you punch a hole in that *and* in the
> > zc error counter (such that failed ZC doesn=E2=80=99t disable ZC in vho=
st), you get ZC
> > from vhost; however, the network interrupt handler under net_tx_action =
and
> > eventually incurs the memcpy under dev_queue_xmit_nit().
>
> Well, yes, we need a copy if there's a packet socket. But if there's
> no network interface taps, we don't need to do the copy here.
>

Hi!

I need more time diving into the issues. As Jon mentioned, vhost ZC is
so little used I didn't have the chance to experiment with this until
now :). But yes, I expect to be able to overcome these for pasta, by
adapting buffer sizes or modifying code etc.

> >
> > This is no more performant, and in fact is actually worse since the tim=
e spent
> > waiting on that memcpy to resolve is longer.
> >
> > >
> > >> as vhost_net does not set
> > >> SKBFL_DONT_ORPHAN.
>
> Maybe we can try to set this as vhost-net can hornor ulimit now.
>
> > >>
> > >> Orphaning enforces a memcpy and triggers the completion callback, wh=
ich
> > >> increments the failed TX counter, effectively disabling zerocopy aga=
in.
> > >>
> > >> Even after addressing these issues to prevent SKB orphaning and erro=
r
> > >> counter increments, performance remains poor. By default, only 64
> > >> messages can be zerocopied, which is immediately exhausted by worklo=
ads
> > >> like iperf, resulting in most messages being memcpy'd anyhow.
> > >>
> > >> Additionally, memcpy'd messages do not benefit from the XDP batching
> > >> optimizations present in the handle_tx_copy path.
> > >>
> > >> Given these limitations and the lack of any tangible benefits, remov=
e
> > >> zerocopy entirely to simplify the code base.
> > >>
> > >> Signed-off-by: Jon Kohler <jon@nutanix.com>
> > >
> > > Any chance we can fix those issues? Actually, we had a plan to make
> > > use of vhost-net and its tx zerocopy (or even implement the rx
> > > zerocopy) in pasta.
> >
> > Happy to take direction and ideas here, but I don=E2=80=99t see a clear=
 way to fix these
> > issues, without dealing with the assertions that skb_orphan_frags_rx ca=
lls out.
> >
> > Said another way, I=E2=80=99d be interested in hearing if there is a co=
nfig where ZC in
> > current host-net implementation works, as I was driving myself crazy tr=
ying to
> > reverse engineer.
>
> See above.
>
> >
> > Happy to collaborate if there is something we could do here.
>
> Great, we can start here by seeking a way to fix the known issues of
> the vhost-net zerocopy code.
>

Happy to help here :).

Jon, could you share more details about the orphan problem so I can
speed up the help? For example, can you describe the code changes and
the code path that would lead to that assertion of
skb_orphan_frags_rx?

Thanks!

