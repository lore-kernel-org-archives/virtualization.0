Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928E228DD5
	for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 08:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613548; cv=none; b=MVDRMIwUTEs3PMMKgK/hSxpA/RUg0OnHeGSttZdS1/nNTPweleV4vesPKCVWA5SFlpjU7KLJpaZLyIzJ94oz/QDVF90zRzdyVn1F4wMdBCVEqD/f5QhStGImlmJqU2M9D79k0RYDqqKn975+L43JplNZQUBphg3YAz528kBU8EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613548; c=relaxed/simple;
	bh=gb6MKVyB1Z8XbC5BzK8Z2vs4Yz7PgGAmQ7D3YG5+8D4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+BfOHscyuZ2igH05lxX3lzAcujyKp9h5soV+DHW9hRJ/a75037zWm/ByLXFgAwjO1UdRCPIaaAy6JNFc6v5b3sU2Nn0X6yytVpw+VfNIrUGuac92JrNlhbT4SOvPn42MfpEDkUZq/A84WxaZ3KdMcdit9s9pV8An2bwLWvXjE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=KUIhzkaA; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="KUIhzkaA"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56c404da0ebso989556a12.0
        for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 01:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711613545; x=1712218345; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7rvoFRBKxf0yE7YY8RQnWrAo8fviROdMGC4hs1RKLE=;
        b=KUIhzkaAE7vEbRPhUnlpevAyQ94s9dWOCTwHVej7ChNFvUhhouI7kB610sLQ3Xyoe6
         QizTiNS+5yUHmwNr92uLfBmq08n3tRQeI6iJWO6xnVrU3bdcBGhr4zx1bbHuFRw+rCHO
         DlLlv6XoA+EwHXuvAgtDq67Gfjs2B+1MeNQxn3eg895MNZNYAsOlHotXy/onnWankhjf
         v5aW/LCSao5/ACxcKBrg7o1D847kAUQ33mzgPy+n4BLYZgYSzwVYqCIANo+SgGM2pPEr
         nK+00MYdbnMpiwEWHHvBxmeD74/Sw+evT6U2Ktse/P4YHHwuE0lf0L4PO6dErZdig8he
         dL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711613545; x=1712218345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7rvoFRBKxf0yE7YY8RQnWrAo8fviROdMGC4hs1RKLE=;
        b=d1X8S7/n/aAgO56Svig5+MNPmTfGYmKZ/VdhQVCkd0Sx2/14T6TwBkSFRw3yz3hzyy
         P8pqaD+6B4oKA/5ODjAJJFpSZNhI9jUZzm/YINLZTSrYOnB+ZiyffjbL4MJmgUCBGbU/
         SGG3RX42VI+IYbpH+YSHqsIz/LVpZddy7umYRXcimZ9LkBK7tmUxEkNqP/dc/rjq8R0F
         fvsIz6SyOOBV9tCywXM4I3um7dGlrZhbLHc7QhgvHWMJSR12CvaNMRlZ4QUggkCEOQKT
         0C26EuyRUNiLgFyPSx91AajGkkEq2if3wkUyyz3i5DbbudIwmLJoGeBcSyhlG0d2l4qS
         zg3A==
X-Forwarded-Encrypted: i=1; AJvYcCWDf0zrZowJsVY2wptn+YRZcNAf5jmSf1E8PCwmPwU+VfTy0NeJ8NmVydyPCilO5L9rnzCshuvnh9m+hg6iyJup/zDWcHCwLtbGmFcZnGU=
X-Gm-Message-State: AOJu0YxOeed1+BJU1nVrdD1Vb6hfBI4RX4iKtPQKoCXwf0iHcwK6RxUy
	TX36bI+XPSMSPxJLeCE81v8FastfGkxof1zIvfgAqDpS2LAVC2WQLcrRYMzT5FAzOP4RTlQ22gL
	p9CiAYfALqq8WgZ+c1xr4HHwld6YPuU/oBQOG8w==
X-Google-Smtp-Source: AGHT+IFhAfd17DEM8g97DoHFH/S7dRUsoNxHZs84UzKZHQqH0hGnUpb1JsLJhLdhVjny84cLIFvqAV6Qd+lOthHSzAA=
X-Received: by 2002:a50:c318:0:b0:56c:d64:26b2 with SMTP id
 a24-20020a50c318000000b0056c0d6426b2mr1397511edb.9.1711613544772; Thu, 28 Mar
 2024 01:12:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240327231826.1725488-1-andrew@daynix.com> <CACGkMEuW8jLvje0_oqCT=-ih9JEgxOrWRsvjvfwQXw=OWT_RtQ@mail.gmail.com>
In-Reply-To: <CACGkMEuW8jLvje0_oqCT=-ih9JEgxOrWRsvjvfwQXw=OWT_RtQ@mail.gmail.com>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Thu, 28 Mar 2024 09:46:36 +0200
Message-ID: <CABcq3pFRookhQ8a8Sf9ri2ONOhHME9mXBMUZEOG1eGkJvAxQNw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] vhost: Added pad cleanup if vnet_hdr is not present.
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	yuri.benditovich@daynix.com, yan@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, I'll look into it.

On Thu, Mar 28, 2024 at 6:03=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Mar 28, 2024 at 7:44=E2=80=AFAM Andrew Melnychenko <andrew@daynix=
.com> wrote:
> >
> > When the Qemu launched with vhost but without tap vnet_hdr,
> > vhost tries to copy vnet_hdr from socket iter with size 0
> > to the page that may contain some trash.
> > That trash can be interpreted as unpredictable values for
> > vnet_hdr.
> > That leads to dropping some packets and in some cases to
> > stalling vhost routine when the vhost_net tries to process
> > packets and fails in a loop.
> >
> > Qemu options:
> >   -netdev tap,vhost=3Don,vnet_hdr=3Doff,...
> >
> > From security point of view, wrong values on field used later
> > tap's tap_get_user_xdp() and will affect skb gso and options.
> > Later the header(and data in headroom) should not be used by the stack.
> > Using custom socket as a backend to vhost_net can reveal some data
> > in the vnet_hdr, although it would require kernel access to implement.
> >
> > The issue happens because the value of sock_len in virtqueue is 0.
> > That value is set at vhost_net_set_features() with
> > VHOST_NET_F_VIRTIO_NET_HDR, also it's set to zero at device open()
> > and reset() routine.
> > So, currently, to trigger the issue, we need to set up qemu with
> > vhost=3Don,vnet_hdr=3Doff, or do not configure vhost in the custom prog=
ram.
> >
> > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> It seems it has been merged by Michael.
>
> Thanks
>
> > ---
> >  drivers/vhost/net.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > index f2ed7167c848..57411ac2d08b 100644
> > --- a/drivers/vhost/net.c
> > +++ b/drivers/vhost/net.c
> > @@ -735,6 +735,9 @@ static int vhost_net_build_xdp(struct vhost_net_vir=
tqueue *nvq,
> >         hdr =3D buf;
> >         gso =3D &hdr->gso;
> >
> > +       if (!sock_hlen)
> > +               memset(buf, 0, pad);
> > +
> >         if ((gso->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
> >             vhost16_to_cpu(vq, gso->csum_start) +
> >             vhost16_to_cpu(vq, gso->csum_offset) + 2 >
> > --
> > 2.43.0
> >
>
