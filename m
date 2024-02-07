Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E0BF9DB
	for <virtualization@lists.linux.dev>; Wed,  7 Feb 2024 02:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707274491; cv=none; b=mXUpeEY4uB98xS9nmSg295ocNsDsSG9ya0UReLR1sScCmIiDg0PebNreC9oYyiNTGOyZXDI0aHdWhxU/F+yh8KVG1Fq1tCK1mSACH0LFAXWJDRqLgKKnLASW38Czai+LrbI1fe/nCYTflh4+d9IlA3M1KDeoTBLRW+1z280ofYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707274491; c=relaxed/simple;
	bh=izzKotNhl6nS4a8y+QeBVLKruDDSX4lKOD5zWyCcE1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EfRDWzP5YD8Mj2Ea6RchZLHdPM3v7JMxP8XcrT7ACfVjkJEJhCaLwY30TrCmJXGl44Gs9qseQC2TZ/sfTb9uy6G1sUkkkxI3YLI/ChgS2G10IkoVJtNG+fEJuNqTVx9Ep3yBKs5/e/kakaGRLZ8+GckT6+uGMGOtjL8n82ISnWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UW4Pe0DD; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UW4Pe0DD"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d09bdddfc9so1445621fa.2
        for <virtualization@lists.linux.dev>; Tue, 06 Feb 2024 18:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707274488; x=1707879288; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoIOOxji4pc7f3dSEqTOlg7tfxN8y/E3ioEBRG57wt4=;
        b=UW4Pe0DD513358iNgFSZWUEOENKMZUDM9gRZizaL0/6GENGIXozsj5YIOuEfOVEufa
         ecSj7K0/QL32Dt2kIIwQHL0M/V77vsu0br3rIelgZzsKEciaaURs+zihJ6tUZFeEUKAV
         Z20dj6JYoa6Vq1C70iDGRxTJ6TJ4w6rrxK+rVgJDZuBChZthgRkLD0m3RA0dUAeC8lRI
         6xA5oIxf1ovS5GXJ/S+KqpSp/tL3MO2S/hA0TKWbzjNvZUa7wkZqxvfEBEGHzzeOTeP9
         3m3cnFi/6W7euYV3RMhnccdawEQmXUVNCd2Ra0Qmc1s+ahbpbGviATiZ7QcE/IirWyLt
         HwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707274488; x=1707879288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XoIOOxji4pc7f3dSEqTOlg7tfxN8y/E3ioEBRG57wt4=;
        b=I6l1RTcWaZ2j1nHp/9helRQMK9jA5TWk2DT5sihWTv99TrYFe6T/tfx6pTpDHSprk2
         eVSU5oNSiM84LWIUD9/IWQwpozcSPemWNO7wDlAy197uUGiJt3M0mOKBXNXOdX4Yerdn
         UvqLrPCh6rktJJFsGUtLb3BjiHpnSj4UpGqhBOtQ9teQ0lSF/W2/x4u12OFYvlxfwS2z
         Y6wtGdwYziuRDQ0tdlQj1/xxpXqRh49LBS0hEooDkTTxva/LzI2/HggafIp3TnbOrUap
         Q8VL4y1t34nP9v2ek8nXi81417WS9U2bMF1Lp5Cw+8ScGedh5G939MAYH1Bnh4NkU/Rc
         cjvw==
X-Gm-Message-State: AOJu0YxRPKGLmDKHVLhSAMnFdGu1TrSzrHk4F8e1Iz6f6H/CI0JNsRNq
	DGjTwBxvD9mhmIgK5xmzjfbBhnAR0n34nxiwQoNYLErjlp5WRrShD30r2StmTS8BxvKTMS1nG4o
	ZvCnWgyTs0ZuttZVgZetoiqWcN04=
X-Google-Smtp-Source: AGHT+IF3rb6fk+H3mqZLW47aVEtrxdK9lm8nOPl/s/iR0+oq5OEhMyVeZ3WfU58ADvmGaCrovLr35WO8WMCiFhtmw+o=
X-Received: by 2002:a2e:99d1:0:b0:2d0:ab31:69e9 with SMTP id
 l17-20020a2e99d1000000b002d0ab3169e9mr2585677ljj.49.1707274487860; Tue, 06
 Feb 2024 18:54:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240202121151.65710-1-liangchen.linux@gmail.com>
 <c8d59e75-d0bb-4a03-9ef4-d6de65fa9356@kernel.org> <CAKhg4tJFpG5nUNdeEbXFLonKkFUP0QCh8A9CpwU5OvtnBuz4Sw@mail.gmail.com>
 <5297dad6499f6d00f7229e8cf2c08e0eacb67e0c.camel@redhat.com>
In-Reply-To: <5297dad6499f6d00f7229e8cf2c08e0eacb67e0c.camel@redhat.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Wed, 7 Feb 2024 10:54:35 +0800
Message-ID: <CAKhg4tLbF8SfYD4dU9U9Nhii4FY2dftjPKYz-Emrn-CRwo10mg@mail.gmail.com>
Subject: Re: [PATCH net-next v5] virtio_net: Support RX hash XDP hint
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, hengqi@linux.alibaba.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, john.fastabend@gmail.com, daniel@iogearbox.net, 
	ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 6:44=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Sat, 2024-02-03 at 10:56 +0800, Liang Chen wrote:
> > On Sat, Feb 3, 2024 at 12:20=E2=80=AFAM Jesper Dangaard Brouer <hawk@ke=
rnel.org> wrote:
> > > On 02/02/2024 13.11, Liang Chen wrote:
> [...]
> > > > @@ -1033,6 +1039,16 @@ static void put_xdp_frags(struct xdp_buff *x=
dp)
> > > >       }
> > > >   }
> > > >
> > > > +static void virtnet_xdp_save_rx_hash(struct virtnet_xdp_buff *virt=
net_xdp,
> > > > +                                  struct net_device *dev,
> > > > +                                  struct virtio_net_hdr_v1_hash *h=
dr_hash)
> > > > +{
> > > > +     if (dev->features & NETIF_F_RXHASH) {
> > > > +             virtnet_xdp->hash_value =3D hdr_hash->hash_value;
> > > > +             virtnet_xdp->hash_report =3D hdr_hash->hash_report;
> > > > +     }
> > > > +}
> > > > +
> > >
> > > Would it be possible to store a pointer to hdr_hash in virtnet_xdp_bu=
ff,
> > > with the purpose of delaying extracting this, until and only if XDP
> > > bpf_prog calls the kfunc?
> > >
> >
> > That seems to be the way v1 works,
> > https://lore.kernel.org/all/20240122102256.261374-1-liangchen.linux@gma=
il.com/
> > . But it was pointed out that the inline header may be overwritten by
> > the xdp prog, so the hash is copied out to maintain its integrity.
>
> Why? isn't XDP supposed to get write access only to the pkt
> contents/buffer?
>

Normally, an XDP program accesses only the packet data. However,
there's also an XDP RX Metadata area, referenced by the data_meta
pointer. This pointer can be adjusted with bpf_xdp_adjust_meta to
point somewhere ahead of the data buffer, thereby granting the XDP
program access to the virtio header located immediately before the
packet data.

Thanks,
Liang

> if the XDP program can really change the virtio_net_hdr, that looks
> potentially dangerous/bug prone regardless of this patch.
>
> Thanks,
>
> Paolo
>
