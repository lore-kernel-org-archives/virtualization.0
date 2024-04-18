Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7989E16ABC2
	for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455345; cv=none; b=WRDKwknvxjWc13I19W7ebWdMSsfo37gacd1gFV6eNFdZnGP0oPF1/SXjF3zUHrl8S2fb/vTHFLmQ6IcIwCu8JTX4ydJP7zawPrxh8RSJ9bFUv1T+NvYzXGHPeBgnkS0tkMUfkNM01Wxbaefszq5eynUDOajxTtZCy637F5eeLHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455345; c=relaxed/simple;
	bh=/S4Wr9Ctxehq6wP4SFSNA6Gm00dOARW6SOuFOuqSFB8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aEJMuwj0fG5aED3gQrlGyH9S5VhPEcTXGr7kC6yu63SPNp7PN+O7iHaqnl9FUR8vaAY3upYlxJs/veX+6s9EvWbO1lx4ljxt4coX3GKExBrUwGfdn7MgTeJ3ufyzgw+xXwYi9TR+AB1fAVxBtPXXbV9ja9/1dVocHIGD1Ry55kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zvx/Wtl4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zvx/Wtl4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713455342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=va4i/x0dZyIZBOxER7PLpjS/f+86MqGnHP5beB2doos=;
	b=Zvx/Wtl4jsyjpeALgcixU46EMi3KAzGma3mM2PbaiLRnwyXLm0CqAAW+S/81/TH8suIUoA
	hMatY4+TTNXqf6OW49oWGqKoc9HiRVWkrcW5XiG5ex91siCfMOCOAN+8d07mdMxEof3Ap4
	dPdaD7KhwVEVdUa6PZ6qkCSOzbWJ7Mg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-8ymItnqYOu2KmJaU0z2WTA-1; Thu, 18 Apr 2024 11:49:01 -0400
X-MC-Unique: 8ymItnqYOu2KmJaU0z2WTA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-349c454bd6fso142532f8f.3
        for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 08:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713455339; x=1714060139;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=va4i/x0dZyIZBOxER7PLpjS/f+86MqGnHP5beB2doos=;
        b=I/a1T0TGt/0RB0d87fmCcD107TJMxCbYlB21p/FC67QZ2RqsqKRvWs8q68KG6ZFgsn
         ajGIEVvf1R1PscbrTw31qExem2OEJJs/yvSAt1or+mT+gckXaXBEJgWG9qWytishXACR
         NXOjEkza/9Ilcfv5jq1eO53FOvIbCaika7F0dn0pay3yEcKm5BCih2bXetLM2lN6XpWf
         JW2/vsUECzRLcPm831j4Yky55BSeOjWs4OvOHR6EnOUo6XTrdnR5zMp/bJiSZQ8tygDe
         qz+tCgLWT2PG7VUxtzL3Ou7/b5fHj4WE+UwMvS0m9Rh6NvFLb+00BVgR/djXresNwx3R
         pMSg==
X-Forwarded-Encrypted: i=1; AJvYcCV4e+SzO+33SwiMUz4TSh2t97OPBXmbkfvHw0Ve95X3oiecDvbX4aHTZkffAKE7v1nVGL1ZOFQX645trMYdGWetumyGWDCT/RLUv1VwG4g=
X-Gm-Message-State: AOJu0YylSGTw+1IouyZTAuaKD6b2AEPW3MgaQ04U5t5RbUoOkO+NUluU
	nIqwIcFcEf80vQDABGaMz98brTWdy7RFfrApaRF4WEvaXbHCKY83xIo7e/XQMJFmisxVe4pLj9B
	Yo3MfjYB0QvfiYkSx9WJB1AlfK3EuRpG+342/yjbi9cyJezRupf3R89EoWkxxco2SL3aFgcK+
X-Received: by 2002:adf:fa41:0:b0:346:500f:9297 with SMTP id y1-20020adffa41000000b00346500f9297mr2288089wrr.2.1713455339695;
        Thu, 18 Apr 2024 08:48:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHO8hs6f5EkRacO2XzgV79/IwiCQnlfCN+NZ4GHssVROmNO11vY3r7ogkRGeqW1a1eoWHxu3A==
X-Received: by 2002:adf:fa41:0:b0:346:500f:9297 with SMTP id y1-20020adffa41000000b00346500f9297mr2288074wrr.2.1713455339315;
        Thu, 18 Apr 2024 08:48:59 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-98-176.dyn.eolo.it. [146.241.98.176])
        by smtp.gmail.com with ESMTPSA id e32-20020a5d5960000000b0033ec9ddc638sm2124227wri.31.2024.04.18.08.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 08:48:58 -0700 (PDT)
Message-ID: <72f6c8a55adac52ad17dfe11a579b5b3d5dc3cec.camel@redhat.com>
Subject: Re: [PATCH net-next v4 3/6] virtio_net: Add a lock for the command
 VQ.
From: Paolo Abeni <pabeni@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>, Heng Qi <hengqi@linux.alibaba.com>, 
	Jason Wang <jasowang@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mst@redhat.com"
 <mst@redhat.com>, "xuanzhuo@linux.alibaba.com"
 <xuanzhuo@linux.alibaba.com>,  "virtualization@lists.linux.dev"
 <virtualization@lists.linux.dev>, "davem@davemloft.net"
 <davem@davemloft.net>,  "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, Jiri Pirko <jiri@nvidia.com>
Date: Thu, 18 Apr 2024 17:48:57 +0200
In-Reply-To: <CH0PR12MB85802CBD3808B483876F8C77C90E2@CH0PR12MB8580.namprd12.prod.outlook.com>
References: <20240416193039.272997-1-danielj@nvidia.com>
	 <20240416193039.272997-4-danielj@nvidia.com>
	 <CACGkMEsCm3=7FtnsTRx5QJo3ZM0Ko1OEvssWew_tfxm5V=MXvQ@mail.gmail.com>
	 <28e45768-5091-484d-b09e-4a63bc72a549@linux.alibaba.com>
	 <ad9f7b83e48cfd7f1463d8c728061c30a4509076.camel@redhat.com>
	 <CH0PR12MB85802CBD3808B483876F8C77C90E2@CH0PR12MB8580.namprd12.prod.outlook.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2024-04-18 at 15:38 +0000, Dan Jurgens wrote:
> > From: Paolo Abeni <pabeni@redhat.com>
> > Sent: Thursday, April 18, 2024 5:57 AM
> > On Thu, 2024-04-18 at 15:36 +0800, Heng Qi wrote:
> > >=20
> > > =E5=9C=A8 2024/4/18 =E4=B8=8B=E5=8D=882:42, Jason Wang =E5=86=99=E9=
=81=93:
> > > > On Wed, Apr 17, 2024 at 3:31=E2=80=AFAM Daniel Jurgens <danielj@nvi=
dia.com>
> > wrote:
> > > > > The command VQ will no longer be protected by the RTNL lock. Use =
a
> > > > > spinlock to protect the control buffer header and the VQ.
> > > > >=20
> > > > > Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> > > > > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> > > > > ---
> > > > > =C2=A0=C2=A0drivers/net/virtio_net.c | 6 +++++-
> > > > > =C2=A0=C2=A01 file changed, 5 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 0ee192b45e1e..d02f83a919a7 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -282,6 +282,7 @@ struct virtnet_info {
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Has cont=
rol virtqueue */
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool has_cv=
q;
> > > > > +       spinlock_t cvq_lock;
> > > > Spinlock is instead of mutex which is problematic as there's no
> > > > guarantee on when the driver will get a reply. And it became even
> > > > more serious after 0d197a147164 ("virtio-net: add cond_resched() to
> > > > the command waiting loop").
> > > >=20
> > > > Any reason we can't use mutex?
> > >=20
> > > Hi Jason,
> > >=20
> > > I made a patch set to enable ctrlq's irq on top of this patch set,
> > > which removes cond_resched().
> > >=20
> > > But I need a little time to test, this is close to fast. So could the
> > > topic about cond_resched + spin lock or mutex lock be wait?
> >=20
> > The big problem is that until the cond_resched() is there, replacing th=
e
> > mutex with a spinlock can/will lead to scheduling while atomic splats. =
We
> > can't intentionally introduce such scenario.
>=20
> When I created the series set_rx_mode wasn't moved to a work queue,=C2=A0
> and the cond_resched wasn't there.=C2=A0

Unfortunately cond_resched() is there right now.

> Mutex wasn't possible, then. If the CVQ is made to be event driven, then=
=C2=A0
> the lock can be released right after posting the work to the VQ.

That should work.

> > Side note: the compiler apparently does not like guard() construct, lea=
ding to
> > new warning, here and in later patches. I'm unsure if the code simplifi=
cation
> > is worthy.
>=20
> I didn't see any warnings with GCC or clang. This is used other places in=
 the kernel as well.
> gcc version 13.2.1 20230918 (Red Hat 13.2.1-3) (GCC)
> clang version 17.0.6 (Fedora 17.0.6-2.fc39)
>=20

See:

https://patchwork.kernel.org/project/netdevbpf/patch/20240416193039.272997-=
4-danielj@nvidia.com/
https://netdev.bots.linux.dev/static/nipa/845178/13632442/build_32bit/stder=
r
https://netdev.bots.linux.dev/static/nipa/845178/13632442/build_allmodconfi=
g_warn/stderr

Cheers,

Paolo

