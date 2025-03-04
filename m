Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37321F0997
	for <virtualization@lists.linux.dev>; Tue,  4 Mar 2025 03:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741060439; cv=none; b=Bjof5OYm5yxu798zBtNY+lLiF2SKYHBYPhWuGixRssvMLESyMC6vtTClsDdmxCed9I9J33vKvi8PaltraHlpINg3hZcHPCjMMa0ycCoYhiQRpEKOiuwSVBxkGjZQjIhvNMFqFEsGMxOV2WHWVaTg+7nYmOf0DRfqG0W4pZR3wpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741060439; c=relaxed/simple;
	bh=v4ZIW03tXTq33ylUh9Hi3kvpmNUOTXtibE59mai2iZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OdZTQN2kIdJ3Pfz68slzJegLijaC8xu4gFgB+l9BD8qg6T20QMiK05jXCUgO03MLrs94FreZkhHYxfXuv7BXiguETd7YeBSfXz33B+MERT5Tp8PtITwE/FwFOCrEsY0FeTy/NC0PhfMZutjyn7RIrybTv4pHZP8sOTP43NyhBYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WiztTq5i; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WiztTq5i"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22342c56242so97265ad.0
        for <virtualization@lists.linux.dev>; Mon, 03 Mar 2025 19:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741060437; x=1741665237; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSFEb6cmbj6TrSKHrJmKO1hlYsPUC+0FUI58pDz1vl8=;
        b=WiztTq5iausfg8JUSRfusfNV+Iwl3Sse5qGwNcaBEVRKxOfFVpXMcb9KU4XXTRxNrh
         us424q3UKudESBaSO90fikXEQOI1BkSy2lniAc4KWP7Dd1+/41GgnmSAZ93XccWY/mqV
         cSxKwztS/4lLWVArJ4XMHM7uARPm5JUXFczdaq2NNhnnnNnocSspfVklcCKjT19/2FQ3
         0RSEjBWh2YSIpC5gCwe7h7gt5bpW9I6RDqo6Y91b2456fTW6+3RciCukxRN42Fz1Lx+v
         pYgNMQpUAN+YA/P12HGWHfksUlTbryPqfdxXLJAlHFEstujwlZfIVU6NHFhw244STuf4
         NxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741060437; x=1741665237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSFEb6cmbj6TrSKHrJmKO1hlYsPUC+0FUI58pDz1vl8=;
        b=VVtgJ0t1XO1TE8F4etF42hJT9A2U3bDOtBFkNkLgVZ/EBYzcXmHriBTk3PtB3X2qRs
         SS3Qm+czfazLQFoC5PwepNmdBXCB7u8iAcDqEq4t375wOlu/SeWGrnC5y8KYDxQdwDed
         cfH1HtBV3krY2oErRhGv2bvDkkoRJlLPgJe01li6Ca8NjsN8qHfGTNK6+0/uY6Xy07kr
         e+PumBqzewhligWw1D8NsEShp4s9X2VzJ4F9fskg1lM1gRInaYNi+tjbANcCa5XVzUcl
         vwMqeWca2SCXdCudSnLamX70bv/OxpWGHV9rD0AMQA1OAV8csBp65/IeOJKTf98sBl0j
         XIwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtoG3zkOMjVJ0rw8CIUQQYnOY24Au4LteaitBZQTpW5GLWBfrwxNljcUgmmwRZZO9Y2HKc1f/dTGjEeEXmPg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5DGTBmANoWeq9iqBpsD+ACrkqsPEk1O64NwRqZKdGJ132MP7i
	NCzi6AwJera/3wS+BGQv0rlPPw3d7Y6mBSXaE7o7yLcFAbVzYubDpIVKmaswzSiyabcAda89cyk
	qEPn1FNEq9d3nrVkDyUxrmb83SQABAj5fAFFZ
X-Gm-Gg: ASbGncuQ0XJ8AHatuT1mZsyVxn2K+6asFHh2+EnWYf8PC/5EXlq2Bcy+084E+2/NX/T
	+WdLnfi6bAwmVnFTuZYoBueOvNBV3gQJzi0lPRNwdnJd5UB2uUY2wgJi0mxlZIBAy7KU6Uuz4Oh
	HF1tbmhyCsjUQRE/Y7jOn3AHSA5g==
X-Google-Smtp-Source: AGHT+IHSpmXymQz0Hg2Nfi/UMM95jLNI0Agz8LxyDxK7J1nuQGrVPSq5ZOQpmxKAyc8gv2/Tg1AhK763Ctub08I/iBk=
X-Received: by 2002:a17:902:e892:b0:217:8612:b690 with SMTP id
 d9443c01a7336-223d9e008f0mr1582615ad.8.1741060436769; Mon, 03 Mar 2025
 19:53:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250227041209.2031104-1-almasrymina@google.com>
 <20250227041209.2031104-8-almasrymina@google.com> <20250228164301.07af6753@kernel.org>
 <CAHS8izO-N4maVtjhgH7CFv5D-QEtjQaYKSrHUrth=aJje4NZgg@mail.gmail.com> <20250303162901.7fa57cd0@kernel.org>
In-Reply-To: <20250303162901.7fa57cd0@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 3 Mar 2025 19:53:44 -0800
X-Gm-Features: AQ5f1JrYu9C4BjqccschILEVQXZn6ayr_hbqMYvwnSubi9nhcByOZkaDeGtsjTs
Message-ID: <CAHS8izOJfSCM+qZ=npPOK3kwuA1pyGHrPo73brRq2VXg8G450g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 7/8] net: check for driver support in netmem TX
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 4:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri, 28 Feb 2025 17:53:24 -0800 Mina Almasry wrote:
> > On Fri, Feb 28, 2025 at 4:43=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > > On Thu, 27 Feb 2025 04:12:08 +0000 Mina Almasry wrote:
> > > > +     if (!skb_frags_readable(skb) && !dev->netmem_tx)
> > >
> > > How do you know it's for _this_ device tho?
> >
> > Maybe a noob question, but how do we end up here with an skb that is
> > not targeted for the 'dev' device? We are checking in
> > tcp_sendmsg_locked that we're targeting the appropriate device before
> > creating the skb. Is this about a packet arriving on a dmabuf bound to
> > a device and then being forwarded through another device that doesn't
> > own the mapping, bypassing the check?
>
> Forwarded or just redirected by nft/bpf/tc
>
> > > The driver doesn't seem to check the DMA mapping belongs to it either=
.
> > >
> > > Remind me, how do we prevent the unreadable skbs from getting into th=
e
> > > Tx path today?
> >
> > I'm not sure if this is about forwarding, or if there is some other
> > way for unreadable skbs to end up in the XT path that you have in
> > mind. At some point in this thread[1] we had talked about preventing
> > MP bound devices from being lower devices at all to side step this
> > entirely but you mentioned that may not be enough, and we ended up
> > sidestepping only XDP entirely.
> >
> > [1] https://lore.kernel.org/bpf/20240821153049.7dc983db@kernel.org/
>
> Upper devices and BPF access is covered I think, by the skbuff checks.
> But I think we missed adding a check in validate_xmit_skb() to protect
> the xmit paths of HW|virt drivers. You can try to add a TC rule which
> forwards all traffic from your devmem flow back out to the device and
> see if it crashes on net-next ?

No crash, but by adding debug logs I'm detecting that we're passing
unreadable netmem dma-addresses to the dma_unmap_*() APIs, which is
known to be unsafe. I just can't reproduce an issue because my
platform has the IOMMU disabled.

I guess I do need to send the hunk from validate_xmit_skb() as a fix
to net and CC stable.

Another thing I'm worried about is ip_forward() inserting an
unreadable skb into the tx path somewhere higher up the stack which
calls more code that isn't expecting unreadable skbs? Specifically
worried about skb_frag_ref/unref. Does this sound like a concern as
well? Or is it a similar code path to tc?

--
Thanks,
Mina
