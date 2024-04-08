Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5255F11725
	for <virtualization@lists.linux.dev>; Mon,  8 Apr 2024 06:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558500; cv=none; b=eEMHDJQUu6aQ7FBdAT2sTMpVztFT+zFRr3sspwHH1b7hJYdoXmS2DqB01cOPcRxKZM6hfOjEQadS0zJlKLqvJoiAO5ExM5kOIm5qzEvbYc1WvakW8h1AyUlSDQJtJA2M7MLhXACLz+MhrL9UWYBEhB7dTv2t2vWP/fB92BEKKsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558500; c=relaxed/simple;
	bh=vl/MXjOOz39LwJjBX3WH80CQfvJtTkh+w0pwIRngjEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q5H7mHU1NxbW7HbupQNIhdBhxGD92LVktYN0QUh09DC5GZBAAfLbK3TbggD7a17mWUrS8MbXClRxt/KvvZjWWvCkIRNBNXGOse3Q27bOGKD9jHN+hJd1qY8W6pD04K9addj95I+Qv0L2F/QrNDpnyojzRaOaxmi6+3hpBOgWqgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OqWRNo9R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OqWRNo9R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712558497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FCmNWkfo5GUFbtVOySsJFMDhWeCbtsTcHia/s/b3Mmg=;
	b=OqWRNo9RgSrb/3AzWInrTnpxlVdMx0CFm53fpwAiR8GUJ+Pt3w5dul95OhNlAEru7JU9aX
	iqGjkr9DaUgom/U8HhrtkvfjITb/7PRjRgoQjLv0w6qYcPgDLaKWo9z0bfZ0F4bSjX+Uvc
	EBdB3logH/LhnQuie7S/s8MYPoh+srk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-5oYMyeS5PyaFGHce6LHPUw-1; Mon, 08 Apr 2024 02:41:33 -0400
X-MC-Unique: 5oYMyeS5PyaFGHce6LHPUw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a300d6a299so2727439a91.3
        for <virtualization@lists.linux.dev>; Sun, 07 Apr 2024 23:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712558493; x=1713163293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCmNWkfo5GUFbtVOySsJFMDhWeCbtsTcHia/s/b3Mmg=;
        b=ke03FRpzfIA2WK4bYmj3bx7z9bnXOIeDiwpuQc5rRsxVzq0VwXs0QS8KPYcWNcdJb8
         A8eYdqA4bkd1ROhyQ8my8YiCFRqGe+3nYVqkE2ONCs2SxvHrXl9M1vbzSRIrLFiGGyuz
         PpnMD1l6syzGsidITnrSqBRpDAKrcsGaD8LySXL3s1XcMxw+jyO9JYe2nXxYQ+EBkbWs
         dii2gvHgBMK7ADDQAl77M2/BE1kQJcRFAbbGo3EhxZIDN/ssocMG57r8LYYn4gwusb+x
         tIQACMnTfqbWVnx68jbIlYBF1585iRpF+FSXVJMGU3j9hZ/5ihRV5JT1BwKVDFVjD+lY
         isRA==
X-Forwarded-Encrypted: i=1; AJvYcCUkP3kRhaBiDypvjVsf4dCpzIo5Wi14t4N0yg6H/xq83Xu60RU4a7ygCr9LElVmfPfLoAd0PP6DbxY7p+HfwPaZGK2Gr6dZ47RGFM2Gp3M=
X-Gm-Message-State: AOJu0Yy4ytHlCZTHW9ay1Vs2hwDTt5ZGw3a/NpZW5g4bgS/dYj4k57ZD
	oBPYLe2gYiOS37wKBsNGSo1ob420ULoZFHBzUT9E9SXisZQ3fFMXppVhJO7uRgKQBnswWaEvPTP
	wGFi7DPpmv5nSox0R3uuAJ8WO20tSmw3MW2giykZoUP3+pKi3tuZE9KRLJW8l3aE92JYgEnf1VR
	6Fw3r6t2OWEzTakmXPBAyaecH+CEbhVfTJLdOu5ik=
X-Received: by 2002:a17:90a:e2d3:b0:2a2:b308:f78f with SMTP id fr19-20020a17090ae2d300b002a2b308f78fmr6988291pjb.0.1712558492807;
        Sun, 07 Apr 2024 23:41:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1EhNPIBIXzS2xSanDvWcI/g5O0Zvd4MJxmFHTN59vf+HT/nKC7DyfJgSIZMUGdrA9TMs4ZdL/ikegnNrd3s0=
X-Received: by 2002:a17:90a:e2d3:b0:2a2:b308:f78f with SMTP id
 fr19-20020a17090ae2d300b002a2b308f78fmr6988280pjb.0.1712558492478; Sun, 07
 Apr 2024 23:41:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240202121151.65710-1-liangchen.linux@gmail.com>
 <c8d59e75-d0bb-4a03-9ef4-d6de65fa9356@kernel.org> <CAKhg4tJFpG5nUNdeEbXFLonKkFUP0QCh8A9CpwU5OvtnBuz4Sw@mail.gmail.com>
 <5297dad6499f6d00f7229e8cf2c08e0eacb67e0c.camel@redhat.com>
 <CAKhg4tLbF8SfYD4dU9U9Nhii4FY2dftjPKYz-Emrn-CRwo10mg@mail.gmail.com>
 <73c242b43513bde04eebb4eb581deb189443c26b.camel@redhat.com>
 <CAKhg4tJPjcShkw4-FHFkKOcgzHK27A5pMu9FP7OWj4qJUX1ApA@mail.gmail.com>
 <1b2d471a5d06ecadcb75e3d9155b6d566afb2767.camel@redhat.com>
 <1708652254.1517398-1-xuanzhuo@linux.alibaba.com> <CACGkMEuUeQTJYpZDx8ggqwBWULQS1Fjd_DgPvVMLq-_cjYfm7g@mail.gmail.com>
 <65dcf7a775437_20e0a2087f@john.notmuch> <CAKhg4t+dzRPjyRXAifS_TCGPv3SfMMm1CF3pCs18OR+o9v+S_Q@mail.gmail.com>
 <CAKhg4tLO7vG5jEYZ3xnzm=xKDHO0SNgDw=JT-j7gb5bjiQOqsw@mail.gmail.com>
In-Reply-To: <CAKhg4tLO7vG5jEYZ3xnzm=xKDHO0SNgDw=JT-j7gb5bjiQOqsw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Apr 2024 14:41:21 +0800
Message-ID: <CACGkMEsfW-j=W8fdTofUsF2a9rRujCs8TH6wkFvZkpLc68ZEEg@mail.gmail.com>
Subject: Re: [PATCH net-next v5] virtio_net: Support RX hash XDP hint
To: Liang Chen <liangchen.linux@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, mst@redhat.com, 
	hengqi@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	ast@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 11:38=E2=80=AFAM Liang Chen <liangchen.linux@gmail.c=
om> wrote:
>
> On Thu, Feb 29, 2024 at 4:37=E2=80=AFPM Liang Chen <liangchen.linux@gmail=
.com> wrote:
> >
> > On Tue, Feb 27, 2024 at 4:42=E2=80=AFAM John Fastabend <john.fastabend@=
gmail.com> wrote:
> > >
> > > Jason Wang wrote:
> > > > On Fri, Feb 23, 2024 at 9:42=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > On Fri, 09 Feb 2024 13:57:25 +0100, Paolo Abeni <pabeni@redhat.co=
m> wrote:
> > > > > > On Fri, 2024-02-09 at 18:39 +0800, Liang Chen wrote:
> > > > > > > On Wed, Feb 7, 2024 at 10:27=E2=80=AFPM Paolo Abeni <pabeni@r=
edhat.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, 2024-02-07 at 10:54 +0800, Liang Chen wrote:
> > > > > > > > > On Tue, Feb 6, 2024 at 6:44=E2=80=AFPM Paolo Abeni <paben=
i@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Sat, 2024-02-03 at 10:56 +0800, Liang Chen wrote:
> > > > > > > > > > > On Sat, Feb 3, 2024 at 12:20=E2=80=AFAM Jesper Dangaa=
rd Brouer <hawk@kernel.org> wrote:
> > > > > > > > > > > > On 02/02/2024 13.11, Liang Chen wrote:
> > > > > > > > > > [...]
> > > > > > > > > > > > > @@ -1033,6 +1039,16 @@ static void put_xdp_frags(=
struct xdp_buff *xdp)
> > > > > > > > > > > > >       }
> > > > > > > > > > > > >   }
> > > > > > > > > > > > >
> > > > > > > > > > > > > +static void virtnet_xdp_save_rx_hash(struct virt=
net_xdp_buff *virtnet_xdp,
> > > > > > > > > > > > > +                                  struct net_dev=
ice *dev,
> > > > > > > > > > > > > +                                  struct virtio_=
net_hdr_v1_hash *hdr_hash)
> > > > > > > > > > > > > +{
> > > > > > > > > > > > > +     if (dev->features & NETIF_F_RXHASH) {
> > > > > > > > > > > > > +             virtnet_xdp->hash_value =3D hdr_has=
h->hash_value;
> > > > > > > > > > > > > +             virtnet_xdp->hash_report =3D hdr_ha=
sh->hash_report;
> > > > > > > > > > > > > +     }
> > > > > > > > > > > > > +}
> > > > > > > > > > > > > +
> > > > > > > > > > > >
> > > > > > > > > > > > Would it be possible to store a pointer to hdr_hash=
 in virtnet_xdp_buff,
> > > > > > > > > > > > with the purpose of delaying extracting this, until=
 and only if XDP
> > > > > > > > > > > > bpf_prog calls the kfunc?
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > That seems to be the way v1 works,
> > > > > > > > > > > https://lore.kernel.org/all/20240122102256.261374-1-l=
iangchen.linux@gmail.com/
> > > > > > > > > > > . But it was pointed out that the inline header may b=
e overwritten by
> > > > > > > > > > > the xdp prog, so the hash is copied out to maintain i=
ts integrity.
> > > > > > > > > >
> > > > > > > > > > Why? isn't XDP supposed to get write access only to the=
 pkt
> > > > > > > > > > contents/buffer?
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Normally, an XDP program accesses only the packet data. H=
owever,
> > > > > > > > > there's also an XDP RX Metadata area, referenced by the d=
ata_meta
> > > > > > > > > pointer. This pointer can be adjusted with bpf_xdp_adjust=
_meta to
> > > > > > > > > point somewhere ahead of the data buffer, thereby grantin=
g the XDP
> > > > > > > > > program access to the virtio header located immediately b=
efore the
> > > > > > > >
> > > > > > > > AFAICS bpf_xdp_adjust_meta() does not allow moving the meta=
_data before
> > > > > > > > xdp->data_hard_start:
> > > > > > > >
> > > > > > > > https://elixir.bootlin.com/linux/latest/source/net/core/fil=
ter.c#L4210
> > > > > > > >
> > > > > > > > and virtio net set such field after the virtio_net_hdr:
> > > > > > > >
> > > > > > > > https://elixir.bootlin.com/linux/latest/source/drivers/net/=
virtio_net.c#L1218
> > > > > > > > https://elixir.bootlin.com/linux/latest/source/drivers/net/=
virtio_net.c#L1420
> > > > > > > >
> > > > > > > > I don't see how the virtio hdr could be touched? Possibly e=
ven more
> > > > > > > > important: if such thing is possible, I think is should be =
somewhat
> > > > > > > > denied (for the same reason an H/W nic should prevent XDP f=
rom
> > > > > > > > modifying its own buffer descriptor).
> > > > > > >
> > > > > > > Thank you for highlighting this concern. The header layout di=
ffers
> > > > > > > slightly between small and mergeable mode. Taking 'mergeable =
mode' as
> > > > > > > an example, after calling xdp_prepare_buff the layout of xdp_=
buff
> > > > > > > would be as depicted in the diagram below,
> > > > > > >
> > > > > > >                       buf
> > > > > > >                        |
> > > > > > >                        v
> > > > > > >         +--------------+--------------+-------------+
> > > > > > >         | xdp headroom | virtio header| packet      |
> > > > > > >         | (256 bytes)  | (20 bytes)   | content     |
> > > > > > >         +--------------+--------------+-------------+
> > > > > > >         ^                             ^
> > > > > > >         |                             |
> > > > > > >  data_hard_start                    data
> > > > > > >                                   data_meta
> > > > > > >
> > > > > > > If 'bpf_xdp_adjust_meta' repositions the 'data_meta' pointer =
a little
> > > > > > > towards 'data_hard_start', it would point to the inline heade=
r, thus
> > > > > > > potentially allowing the XDP program to access the inline hea=
der.
> > >
> > > Fairly late to the thread sorry. Given above layout does it make sens=
e to
> > > just delay extraction to the kfunc as suggested above? Sure the XDP p=
rogram
> > > could smash the entry in virtio header, but this is already the case =
for
> > > anything else there. A program writing over the virtio header is like=
ly
> > > buggy anyways. Worse that might happen is bad rss values and mappings=
?
> >
> > Thank you for raising the concern. I am not quite sure if the XDP
> > program is considered buggy, as it is agnostic to the layout of the
> > inline header.
> > Let's say an XDP program calls bpf_xdp_adjust_meta to adjust data_meta
> > to point to the inline header and overwrites it without even knowing
> > of its existence. Later, when the XDP program invokes the kfunc to
> > retrieve the hash, incorrect data would be returned. In this case, the
> > XDP program seems to be doing everything legally but ends up with the
> > wrong hash data.
> >
> > Thanks,
> > Liang
> >
>
> I haven=E2=80=99t received any feedback yet, so I=E2=80=99m under the imp=
ression that
> the XDP program is still considered buggy in the scenario mentioned
> above, and the overall behavior is as designed from XDP perspective.
> Looking up the intel igc driver, it also does not bother with this
> particular aspect.

So let's post a new version with all the detailed explanations as above and=
 see?

>
> Given this context, we don't need to be concerned about the hash value
> being overwritten. So if there aren't any objections, I plan to remove
> the preservation of the hash value in the next iteration.
>
> Thanks,
> Liang

Thanks

>
> > >
> > > I like seeing more use cases for the hints though.
> > >
> > > Thanks!
> > > John
>

