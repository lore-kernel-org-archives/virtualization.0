Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E3C12E1FF
	for <virtualization@lists.linux.dev>; Mon, 26 Feb 2024 20:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708980139; cv=none; b=NfJ+rWaoQF2EigLsbQ+Y5eHVSHA/7z+rtXrqKz/q4KmEAt6nB0DpmNmbP0pyuVSzRku60bcadX5NcHqIDna1vfg2GectACRcH6B8vE6ukhuQW9quRASYAXIWdBvad0sPhQ14Sf9fhc+aIpr1wlLMNL2EUhc150G3KSFxeSliJAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708980139; c=relaxed/simple;
	bh=OWpEILxNCGKi9UijO32jbCo3J5K197DN5nUkWLCXD3w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=BaJgEmywTzr+XmWay5ifVG+B0AXV6uJH+Lvv1RdwjA8Nyo4Gt3MZJd0AWUQyH7LVnvsbeEy7dXk/zImcNL5qxlLM2tzwP0ij6lGxNgY3SspyJyYrpsJYqInXLFoRb0doyUQeG6g3aOmxlizsn95zqy4k1rhSadTEgw0RsMeemyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiDqIGkr; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiDqIGkr"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dc99a75be6so12454365ad.3
        for <virtualization@lists.linux.dev>; Mon, 26 Feb 2024 12:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708980138; x=1709584938; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8/sZv9YSQN5VoeMFHC9Ppfxe4Q4sN12GRL5yh7nIDA=;
        b=NiDqIGkrVS3cQNcLudXtT80YRe6KmuSEF0dmBzmMzSB6u5H/jR52Rry/DtpP5mUOpD
         6M6qXN9soSNwvg2IjGa1vvkZ8gjZ3wNY6znAfUHdFJkVRb4nkHhOuBTVP5MHOPrPyjoJ
         Dl2IIYI68yFllZtvX28C0Bg/6PHJWKvpzfNM/LGb76L0VQCWWBIBrUO7pprVUdZqoOJZ
         Pa2iMtv6NVmWEGpxyNpLvrMMUjaigi/SJBtLWo9QoaxAc4/zUncqqYRfEKyAxnA+idna
         DMN9WBaYojc8E1Pl8n0/4tQNgg/uM46dGgPlBMGc4uwmvmjZ5Z7H+5nkdlfHOju8uIx8
         SCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708980138; x=1709584938;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X8/sZv9YSQN5VoeMFHC9Ppfxe4Q4sN12GRL5yh7nIDA=;
        b=IID9nZtjeHrI5IByNrrr5mVMjJTh+2mWfp5jZvbO2D4SEebcrS8YFrRq1RVyGXN5GB
         oA7ta3dfkvFDcFWgO6oTB6oKCi3Fa5SaPhYhuyKpUBSmO0w7ZTTu4hFQTbNqMIndZBx+
         3bMfoIKlyiQDMX+oWmqJUz8r2l66+bYaNoVS+TH/w9DJpKJyeV4H3MXTAymhIe+VIXmG
         W0InK/YI26KI5qRcM9EgYnmNRMb7TReaqoi/i2MeORM3HgCcedkahgVlf5UofCIuwZnv
         ivdFSCxzWqAaq8eXLLqAMs7OkTEvflktG8U1/o7Kh/tg2T1BdHaRZRydbOcCZD7SE4Sg
         bRww==
X-Forwarded-Encrypted: i=1; AJvYcCVAjXgKDm+MvicAKY7lW79QukCgX8g4ovU+8LfZntJGlA/Cr1/0nIwtC3uqe46rrNbAGXg0I+GvsM3hIwKY80bkBeMBnuFBrjBVz/XR540=
X-Gm-Message-State: AOJu0YzMJ4vcnIFshBaBC/oxaEznR18/MGmxPZAvJ+0nBF54MQaewsNF
	apcBaBlfBFvBuYFH0JmdnpbokBrusfbYwe7m6ynbzZRPFB/oD6LN
X-Google-Smtp-Source: AGHT+IGwekaX4Ei1fFfoNjzsX11nAcGMnXREGSlHn4sg62b/PqcMNxEWgMrzf2y7rtNSewGJei8qQg==
X-Received: by 2002:a17:902:b906:b0:1dc:3294:f09b with SMTP id bf6-20020a170902b90600b001dc3294f09bmr7490733plb.26.1708980137547;
        Mon, 26 Feb 2024 12:42:17 -0800 (PST)
Received: from localhost ([98.97.116.12])
        by smtp.gmail.com with ESMTPSA id mh13-20020a17090309cd00b001dc9893b03bsm100695plb.272.2024.02.26.12.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 12:42:16 -0800 (PST)
Date: Mon, 26 Feb 2024 12:42:15 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 mst@redhat.com, 
 hengqi@linux.alibaba.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 john.fastabend@gmail.com, 
 daniel@iogearbox.net, 
 ast@kernel.org, 
 Liang Chen <liangchen.linux@gmail.com>
Message-ID: <65dcf7a775437_20e0a2087f@john.notmuch>
In-Reply-To: <CACGkMEuUeQTJYpZDx8ggqwBWULQS1Fjd_DgPvVMLq-_cjYfm7g@mail.gmail.com>
References: <20240202121151.65710-1-liangchen.linux@gmail.com>
 <c8d59e75-d0bb-4a03-9ef4-d6de65fa9356@kernel.org>
 <CAKhg4tJFpG5nUNdeEbXFLonKkFUP0QCh8A9CpwU5OvtnBuz4Sw@mail.gmail.com>
 <5297dad6499f6d00f7229e8cf2c08e0eacb67e0c.camel@redhat.com>
 <CAKhg4tLbF8SfYD4dU9U9Nhii4FY2dftjPKYz-Emrn-CRwo10mg@mail.gmail.com>
 <73c242b43513bde04eebb4eb581deb189443c26b.camel@redhat.com>
 <CAKhg4tJPjcShkw4-FHFkKOcgzHK27A5pMu9FP7OWj4qJUX1ApA@mail.gmail.com>
 <1b2d471a5d06ecadcb75e3d9155b6d566afb2767.camel@redhat.com>
 <1708652254.1517398-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuUeQTJYpZDx8ggqwBWULQS1Fjd_DgPvVMLq-_cjYfm7g@mail.gmail.com>
Subject: Re: [PATCH net-next v5] virtio_net: Support RX hash XDP hint
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Wang wrote:
> On Fri, Feb 23, 2024 at 9:42=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> >
> > On Fri, 09 Feb 2024 13:57:25 +0100, Paolo Abeni <pabeni@redhat.com> w=
rote:
> > > On Fri, 2024-02-09 at 18:39 +0800, Liang Chen wrote:
> > > > On Wed, Feb 7, 2024 at 10:27=E2=80=AFPM Paolo Abeni <pabeni@redha=
t.com> wrote:
> > > > >
> > > > > On Wed, 2024-02-07 at 10:54 +0800, Liang Chen wrote:
> > > > > > On Tue, Feb 6, 2024 at 6:44=E2=80=AFPM Paolo Abeni <pabeni@re=
dhat.com> wrote:
> > > > > > >
> > > > > > > On Sat, 2024-02-03 at 10:56 +0800, Liang Chen wrote:
> > > > > > > > On Sat, Feb 3, 2024 at 12:20=E2=80=AFAM Jesper Dangaard B=
rouer <hawk@kernel.org> wrote:
> > > > > > > > > On 02/02/2024 13.11, Liang Chen wrote:
> > > > > > > [...]
> > > > > > > > > > @@ -1033,6 +1039,16 @@ static void put_xdp_frags(stru=
ct xdp_buff *xdp)
> > > > > > > > > >       }
> > > > > > > > > >   }
> > > > > > > > > >
> > > > > > > > > > +static void virtnet_xdp_save_rx_hash(struct virtnet_=
xdp_buff *virtnet_xdp,
> > > > > > > > > > +                                  struct net_device =
*dev,
> > > > > > > > > > +                                  struct virtio_net_=
hdr_v1_hash *hdr_hash)
> > > > > > > > > > +{
> > > > > > > > > > +     if (dev->features & NETIF_F_RXHASH) {
> > > > > > > > > > +             virtnet_xdp->hash_value =3D hdr_hash->h=
ash_value;
> > > > > > > > > > +             virtnet_xdp->hash_report =3D hdr_hash->=
hash_report;
> > > > > > > > > > +     }
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > >
> > > > > > > > > Would it be possible to store a pointer to hdr_hash in =
virtnet_xdp_buff,
> > > > > > > > > with the purpose of delaying extracting this, until and=
 only if XDP
> > > > > > > > > bpf_prog calls the kfunc?
> > > > > > > > >
> > > > > > > >
> > > > > > > > That seems to be the way v1 works,
> > > > > > > > https://lore.kernel.org/all/20240122102256.261374-1-liang=
chen.linux@gmail.com/
> > > > > > > > . But it was pointed out that the inline header may be ov=
erwritten by
> > > > > > > > the xdp prog, so the hash is copied out to maintain its i=
ntegrity.
> > > > > > >
> > > > > > > Why? isn't XDP supposed to get write access only to the pkt=

> > > > > > > contents/buffer?
> > > > > > >
> > > > > >
> > > > > > Normally, an XDP program accesses only the packet data. Howev=
er,
> > > > > > there's also an XDP RX Metadata area, referenced by the data_=
meta
> > > > > > pointer. This pointer can be adjusted with bpf_xdp_adjust_met=
a to
> > > > > > point somewhere ahead of the data buffer, thereby granting th=
e XDP
> > > > > > program access to the virtio header located immediately befor=
e the
> > > > >
> > > > > AFAICS bpf_xdp_adjust_meta() does not allow moving the meta_dat=
a before
> > > > > xdp->data_hard_start:
> > > > >
> > > > > https://elixir.bootlin.com/linux/latest/source/net/core/filter.=
c#L4210
> > > > >
> > > > > and virtio net set such field after the virtio_net_hdr:
> > > > >
> > > > > https://elixir.bootlin.com/linux/latest/source/drivers/net/virt=
io_net.c#L1218
> > > > > https://elixir.bootlin.com/linux/latest/source/drivers/net/virt=
io_net.c#L1420
> > > > >
> > > > > I don't see how the virtio hdr could be touched? Possibly even =
more
> > > > > important: if such thing is possible, I think is should be some=
what
> > > > > denied (for the same reason an H/W nic should prevent XDP from
> > > > > modifying its own buffer descriptor).
> > > >
> > > > Thank you for highlighting this concern. The header layout differ=
s
> > > > slightly between small and mergeable mode. Taking 'mergeable mode=
' as
> > > > an example, after calling xdp_prepare_buff the layout of xdp_buff=

> > > > would be as depicted in the diagram below,
> > > >
> > > >                       buf
> > > >                        |
> > > >                        v
> > > >         +--------------+--------------+-------------+
> > > >         | xdp headroom | virtio header| packet      |
> > > >         | (256 bytes)  | (20 bytes)   | content     |
> > > >         +--------------+--------------+-------------+
> > > >         ^                             ^
> > > >         |                             |
> > > >  data_hard_start                    data
> > > >                                   data_meta
> > > >
> > > > If 'bpf_xdp_adjust_meta' repositions the 'data_meta' pointer a li=
ttle
> > > > towards 'data_hard_start', it would point to the inline header, t=
hus
> > > > potentially allowing the XDP program to access the inline header.=


Fairly late to the thread sorry. Given above layout does it make sense to=

just delay extraction to the kfunc as suggested above? Sure the XDP progr=
am
could smash the entry in virtio header, but this is already the case for
anything else there. A program writing over the virtio header is likely
buggy anyways. Worse that might happen is bad rss values and mappings?

I like seeing more use cases for the hints though.

Thanks!
John=
