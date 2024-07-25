Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D3C7347D
	for <virtualization@lists.linux.dev>; Thu, 25 Jul 2024 21:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721941376; cv=none; b=NrIgG5Avbu3ranau+gWUCXfplogxoLYi5wAfblofaCl8EY6kyoRPldmteTq2y59MXvxWnjQzTtpazv+EkIjqTJ7gp+VM7fngLgryU2b3cByaASIjBgbFdK2nxtyCeBzTOEFHILKBXSucbJlp7pEoEf6U7Pend4LKGHiGn/a00LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721941376; c=relaxed/simple;
	bh=EEs0PsVZtmXovIP4elBP1rkP5kAYWDF0gM35V4qrISY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9NkMH3MvOMrv+wDzQuQ9RrfRz8JfIymRpvz6xQgzf6hJ+CaFm7NaCNaKKyG2StVb0U1iWSahPjEhvAociCL24X3WEmsnMtV9IxotF8H7QYRjrljFvnEAMWCWbI1k7H3br37eJXWRcWS+Q6gzrZHeCKy6Q+55kqe6/zj2qr6s8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0xi4W6k; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0xi4W6k"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-70446231242so190121a34.1
        for <virtualization@lists.linux.dev>; Thu, 25 Jul 2024 14:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721941373; x=1722546173; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0R3aNtSay58/lkjvIqsiNk76d3Gj29c33jDe7aDrYg=;
        b=U0xi4W6k8TPIhElBhFAtFgWWpdhVPLHC+muDLfmne5syEjpvFSEJY8rs4+i7FBZpBr
         htIcu7DZkjy8pRy62ZsLz3jaFefZ9Gnsq+XGw2fSW6vAh/pcYaIlCnAbrOgBYIij1c6q
         LQrc62/oiV3uyfVqqQfPSDd8oAQCTNKh8zX+whAs5D3B7Ja2upRAffrXbVtBKYQYm+7w
         wFmlxT5RrZCrU37m7ufw/gZRUamRmW9CPgsak4mVmSPK/qtkxU1IJhOlrhOejvVJJzpQ
         BnH8pt0k68R5NDNLvA3Qj8wPNq/DYUDwXa0WS+hUIVv669xDhgEnfJkKA0L+nzULI0kQ
         LlSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721941373; x=1722546173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0R3aNtSay58/lkjvIqsiNk76d3Gj29c33jDe7aDrYg=;
        b=gwEzYYRTExqMfqREo5TmrddeYmzvCqp2t/ISZAelPbPbmC8LJv3GOBN04xrh1P8Oe7
         9RZ5IuApAEpxA67mS54cB33Gli/Q/L50LyOKOfnzoYZuBuq9wZnWQ+n6+MfK/JxIQxpT
         5/J8a24iUlMlC9HdDXdf75qTxsGM6hNui30jBBm6jyaaOareX/M+jwJpe+VCo9Xe6PKy
         mVscjVIEPeUioTHh3CeLzV+nwqf+B3tHdZxMcru+9HQxOdjdVv3WUNm8VkfoyavTjAQR
         4RboU1m6g7QJDjF45G09C1yI0DV4zEGzU1mCdf7PDLRlc9t48nKYxqVDu4ScIc+2I4XG
         XY4w==
X-Forwarded-Encrypted: i=1; AJvYcCVLoQwAAwRmgjkDauiIQmKe5Vat6N8U2HQVA2h2lrP31KFiQo3sce+o4o+0NyyTjHqwkcbPFlWQx6mvUfCRWdVGyc6LUdzhv0L1NSdcfao=
X-Gm-Message-State: AOJu0Yy33vtnNguLOvF3wDc+S6ObswizFRZV4m+MGgWdVNCTlWjJZruZ
	DV4ZxFB7b+T97e1HOk0azlD0I45R0UbO/6LWthIaSFp+bdHUyeYCJK8qI3dEgI6+aGaZbTQiGKc
	t5yiuPDqSw/iJvCGeC0/sWvYSFak=
X-Google-Smtp-Source: AGHT+IHpabHVk/SwCJqR5J+AVsCV6XSW/pF6eWZyyTvY8O3GCcoIlZgV1sQr+Tvs0AhJPuNVGamq2GTyOXZXWbEDO18=
X-Received: by 2002:a05:6358:7202:b0:1a6:799b:b06c with SMTP id
 e5c5f4694b2df-1acf8908280mr570291155d.23.1721941372869; Thu, 25 Jul 2024
 14:02:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240723223109.2196886-1-kuba@kernel.org> <20240725092203.26366-1-arefev@swemel.ru>
 <CAF=yD-Kz3PRncy4N0LkTSDGm95Zg7yfKDm+BOHBs4NfkEDSJUw@mail.gmail.com>
In-Reply-To: <CAF=yD-Kz3PRncy4N0LkTSDGm95Zg7yfKDm+BOHBs4NfkEDSJUw@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 25 Jul 2024 17:02:15 -0400
Message-ID: <CAF=yD-J7P=5V+Ksx9KRT2nm+UzK42HoBVCDed-EYH4KzMPWtkw@mail.gmail.com>
Subject: Re: [PATCH net] virtio: fix GSO with frames unaligned to size
To: Denis Arefev <arefev@swemel.ru>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	eperezma@redhat.com, jasowang@redhat.com, linux-kselftest@vger.kernel.org, 
	mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, shuah@kernel.org, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 10:27=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Thu, Jul 25, 2024 at 5:22=E2=80=AFAM Denis Arefev <arefev@swemel.ru> w=
rote:
> >
> > I checked the patch on three reproducers and all three DEFINITELY broke=
 the core.
> >
> > There are two malfunctions.
> >
> > 1. No flag skb_shinfo(skb)->tx_flags |=3D SKBFL_SHARED_FRAG;
> >  If it is not set then __skb_linearize will not be executed in skb_chec=
ksum_help.
> >  sk_buff remains fragmented (non-linear) and this is the first warning.
> >  OR add skb_shinfo(skb)->tx_flags |=3D SKBFL_SHARED_FRAG.
> >  OR ask Eric Dumazet (cef401de7be8c). Is checking if (skb_has_shared_fr=
ag(skb)) so important?
> >  in the skb_checksum_help function, is it enough if (skb_is_nonlinear(s=
kb)) ?
>
> Thanks for sharing the reproducers. Having a look.

Reproduced https://syzkaller.appspot.com/bug?extid=3De1db31216c789f552871

That is against a v6.1 kernel, and the syzkaller page reports that it
did not fail against a recent upstream commit. Will take a closer look
at that.

But on v6.1, at least, the following did catch it:

@@ -72,6 +72,18 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
        if (thlen < sizeof(*th))
                goto out;

+       if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL &&
+           skb->csum_start !=3D skb->transport_header) {
+               skb_dump(KERN_INFO, skb, false);
+               goto out;
+        }
+

And the geometry of the bad packet at that point:

[   52.003050][ T8403] skb len=3D12202 headroom=3D244 headlen=3D12093 tailr=
oom=3D0
[   52.003050][ T8403] mac=3D(168,24) mac_len=3D24 net=3D(192,52) trans=3D2=
44
[   52.003050][ T8403] shinfo(txflags=3D0 nr_frags=3D1 gso(size=3D1552 type=
=3D3 segs=3D0))
[   52.003050][ T8403] csum(0x60000c7 start=3D199 offset=3D1536
ip_summed=3D3 complete_sw=3D0 valid=3D0 level=3D0)

Sharing sketch patch for any feedback. A few downsides:

The patch adds a branch in the semi hot path of TCP software
segmentation for every packet. Including for the more common kernel
stack generated packets. And it needs the same test in two locations
in net/ipv4/udp_offload.c, for USO and UFO.

It is tempting to move it to the if (skb_gso_ok(skb, features |
NETIF_F_GSO_ROBUST)) branch below, as then it is limited to
SKB_GSO_DODGY. But that does not catch dodgy packets that need
software segmentation. Conversely, we could check in skb_segment
before calling skb_checksum_help.

I'll be out for four days over the weekend. May have to delay until next we=
ek.

> > Should we revert that and create a new fix against the original issue?
>
> We can, no strong preference.

On second thought, since this has to go to all the stable trees, let's
keep it a single patch. Rather than a revert + new fix.
