Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12851EB21
	for <virtualization@lists.linux.dev>; Tue,  6 Feb 2024 10:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707216246; cv=none; b=QesPqkyVi1ZK0UeHjxA2WdcuyC0SWCotnMWGy7Fs1yyaALmpSbijoSRya7U4/dL0S9CIzNjG9UY7ZEvHrgzuFFXvFBSO+73S02hG5kr/n0yScHN0uzuCKTdP+Kr4t7CNYpE6xgaqFR5NFh+u6XzcQM3r/fuS31yVAiDDm8YuKMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707216246; c=relaxed/simple;
	bh=3PO9HqabKlTeIf2oJndo4GKhZNWrhzSwkIySYL7yM4I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ikeVkglZUXlPjAFPe6wEBkngIFroxeMacy18sch8a+aIDdz3Ew0dxFTEfCAQFeYuQdZLg8+CGBMKmoCldxWLEF6lQJA6ruCHuDW7jn25trF4PXMsTBJQdd7/VbeD6lypf+xpAFT6Lrizfsiq0xUvjbLLydRbtX/pbT/xx/C6Sr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ks/pQXEQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ks/pQXEQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707216243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GUF0RwSqdPkltRDROFKguYIVUTaltKVb3IJtt9hFPTs=;
	b=Ks/pQXEQ5rsB25M52nLhkxyOAG3EtIUkS0RVnvuG8h6/zVk8H5AU5w3RU1eH3JOGpvXidt
	mvf74+L+PfhdqsVAl/wNj+3BLAwYrVIFgeO1NkmSFj19hHLRceclIcJBWlS2jZkQ92kkcZ
	nk9GORXqjuCZOWatXgp6/MlyfojmtnU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-dXDf5PzwNeaPUNuwKfFp-A-1; Tue, 06 Feb 2024 05:44:01 -0500
X-MC-Unique: dXDf5PzwNeaPUNuwKfFp-A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40efaee41dbso3985605e9.1
        for <virtualization@lists.linux.dev>; Tue, 06 Feb 2024 02:44:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707216241; x=1707821041;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GUF0RwSqdPkltRDROFKguYIVUTaltKVb3IJtt9hFPTs=;
        b=mlpPyB5aApa6g60W+KlnzIdEV0+tYWEAxI8V50ZuJjLhGIjrHckrNNODVRshYWiEtr
         1AK8TSj+xPaJ8C+KJUCL7G+SiWWZOywO5nIhcMbuUxVrz3dnKHah4O1Zwkt1oY1Zbn2J
         1OBI2qCaCvyMlLVXN5Y2zAkjunf20H2V1s71bT2a/2wVxxn7vqGfRg7em49fdX1FVjIH
         zns3xnXSdKzXpIAIwQoLr7v5eSiYE7I8B+ya0+jYqcl7FK8GJTZEVPcQ/C0Yfzhfmysw
         rI8HSicAu53KhKDq+eaw6fF7fpAhY3AnKDDfN+qzvoC7JhPuJw2r9/2auw/dClaGnLTz
         JC9Q==
X-Gm-Message-State: AOJu0Yw2URhlbXJ+fzvIsZ64U7oHEpQAOCNgmV7vMqEVoBNQ2sDSzsP8
	pPCtWrZSauH191GXCjg9nHwtP7HSJTPIsIXTdfGpbfKLXweSLByoMCGjVEM8jnyjTpzGkBr5iMA
	zIrdYGUamH0MrOr5BchCKIlM3mdR4pBv005QO2qrvKvsS7tndwMGFUR+9/W7Sw50e
X-Received: by 2002:a05:600c:3b8f:b0:40e:e9dd:c290 with SMTP id n15-20020a05600c3b8f00b0040ee9ddc290mr1927193wms.0.1707216240742;
        Tue, 06 Feb 2024 02:44:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0MIt8c0drvzNqUWklMcwdZFOc9WkhWGGhOkXSqaBVOw1OKYd0DgsREwjUGPkk8B4c4L5brA==
X-Received: by 2002:a05:600c:3b8f:b0:40e:e9dd:c290 with SMTP id n15-20020a05600c3b8f00b0040ee9ddc290mr1927182wms.0.1707216240402;
        Tue, 06 Feb 2024 02:44:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXD4Iyw4GA1rjha+/SnnJhNMfoByPZdOihJX1I0X+AVMj616Jp65SGXAfE/dxo11kFGfl2vv9h4rKb1lS6dqbdA1pdPl9sXJwpxoBos0cMvDSueCZRorqxk3rjbeYpmZ0agpCnLzjIGApiSI62LardTmjH94J+iWlBiLN8hiNOa4244A6JI50l1IBV76sNK6AcDrELN28j77mLP/93TgClCm1U1Ofk89tGuEZ9P4e91UQGGla+61Vx5ab5nSLvJNWhOqdYU3tpCmpJmeSB+34Vh/d+v/kpoHxKYUSYeI04STfzQ/1mA/eqJ8o/TxiPu4Yhm9V44pKzXRo1OMHUAy7v/g1U6BGMufFKfsb/ngPWGfqqiFxU2zphx+vbVJ578NWqHv39iA8HxGDUmQE0qAOn88eNYmvsIl+OwF3RfY72Lru7Lu3ylun5PQ0MK9lQ8Pih+KAI9f8dySeNP6MEvBRXAt0LdPRn6eDfMbsTy7yG/QA==
Received: from gerbillo.redhat.com (146-241-224-127.dyn.eolo.it. [146.241.224.127])
        by smtp.gmail.com with ESMTPSA id fc16-20020a05600c525000b0040feb8c71a0sm744646wmb.13.2024.02.06.02.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 02:43:59 -0800 (PST)
Message-ID: <5297dad6499f6d00f7229e8cf2c08e0eacb67e0c.camel@redhat.com>
Subject: Re: [PATCH net-next v5] virtio_net: Support RX hash XDP hint
From: Paolo Abeni <pabeni@redhat.com>
To: Liang Chen <liangchen.linux@gmail.com>, Jesper Dangaard Brouer
	 <hawk@kernel.org>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
 hengqi@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
 kuba@kernel.org, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 john.fastabend@gmail.com,  daniel@iogearbox.net, ast@kernel.org
Date: Tue, 06 Feb 2024 11:43:58 +0100
In-Reply-To: <CAKhg4tJFpG5nUNdeEbXFLonKkFUP0QCh8A9CpwU5OvtnBuz4Sw@mail.gmail.com>
References: <20240202121151.65710-1-liangchen.linux@gmail.com>
	 <c8d59e75-d0bb-4a03-9ef4-d6de65fa9356@kernel.org>
	 <CAKhg4tJFpG5nUNdeEbXFLonKkFUP0QCh8A9CpwU5OvtnBuz4Sw@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39)
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

On Sat, 2024-02-03 at 10:56 +0800, Liang Chen wrote:
> On Sat, Feb 3, 2024 at 12:20=E2=80=AFAM Jesper Dangaard Brouer <hawk@kern=
el.org> wrote:
> > On 02/02/2024 13.11, Liang Chen wrote:
[...]
> > > @@ -1033,6 +1039,16 @@ static void put_xdp_frags(struct xdp_buff *xdp=
)
> > >       }
> > >   }
> > >=20
> > > +static void virtnet_xdp_save_rx_hash(struct virtnet_xdp_buff *virtne=
t_xdp,
> > > +                                  struct net_device *dev,
> > > +                                  struct virtio_net_hdr_v1_hash *hdr=
_hash)
> > > +{
> > > +     if (dev->features & NETIF_F_RXHASH) {
> > > +             virtnet_xdp->hash_value =3D hdr_hash->hash_value;
> > > +             virtnet_xdp->hash_report =3D hdr_hash->hash_report;
> > > +     }
> > > +}
> > > +
> >=20
> > Would it be possible to store a pointer to hdr_hash in virtnet_xdp_buff=
,
> > with the purpose of delaying extracting this, until and only if XDP
> > bpf_prog calls the kfunc?
> >=20
>=20
> That seems to be the way v1 works,
> https://lore.kernel.org/all/20240122102256.261374-1-liangchen.linux@gmail=
.com/
> . But it was pointed out that the inline header may be overwritten by
> the xdp prog, so the hash is copied out to maintain its integrity.

Why? isn't XDP supposed to get write access only to the pkt
contents/buffer?

if the XDP program can really change the virtio_net_hdr, that looks
potentially dangerous/bug prone regardless of this patch.

Thanks,

Paolo

