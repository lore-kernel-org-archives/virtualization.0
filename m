Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E511CAAF
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 03:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721792945; cv=none; b=tDfi/2/dFHZBF0KM1j4PkU8JCMN3yySGp8GWcKFB4gF0kH7Zbq8MwpW/Y95F9kC19DANJ1tgeaGr7vvDvSmAc/QJZWcDig67BflTf6e4FF6qyi0x2MAVVW/MFdRwDncm5FDGXGEwvZ97Id4rvT7aUVeu2A7+8CYyDGuVWTtOvr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721792945; c=relaxed/simple;
	bh=NKrj4Xe15h7P+/8akw56axN+QjFD9WXReSS4RVzKxwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q3HTPSDppaIQSYFbTTmpJkDHqBOBLSWSUrD9LkMu1crRTEp2isGY8RoPh08SgYy16aGhx9bFfnmLOQkRcdyaM2T8VyLI6MjDpAhcYsJ55BdCB7f7t16Wd0AYQIKLMvWHje8NYVYUGHdquKtOJnykADFqwzlREiRsIyfChpzl/PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcCQ22Cr; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcCQ22Cr"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-8307e9b9d9fso55889241.3
        for <virtualization@lists.linux.dev>; Tue, 23 Jul 2024 20:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721792942; x=1722397742; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIIzMgLof7Cy8pOJkAUdfmjOzPX18xl1X4zt9wdck1I=;
        b=HcCQ22CrPlqQ1ez9CdzMFdYxpXuus/n3pTAoLzLeMSG2YvdUPLmwz/6x5CrNbPF9dV
         +3XipACgcTfDL2HHjRES5TrebxWXq1u3JHcXTeVrkP60p3f+rlDLXRzoyqmEzNDv6hXQ
         Yg4ezaVuu6n1Jv+dOsl1reCcxR8UloJryhqxIEF50r1xPohnbyInvt8BMkqJgCh9cq2h
         P6kYfX2bVxU+Ck1+nJ/wI0Ren2nH3jqoXpltTCF4u5EePEEzrel9/eCHaxcjf3tjoaut
         MX+e7IRwDFZplqatzDyTZQteT+imH+X8goM9mVDicqSbn8LLQPSbLiS9M0P1u/cE8iRZ
         Qkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721792942; x=1722397742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIIzMgLof7Cy8pOJkAUdfmjOzPX18xl1X4zt9wdck1I=;
        b=Rm/6h+JWtZ6xyiBAFKaP4qQU0wLTZvZocgUshAbh+mSdJW5IApTnlzt1OieryssRu1
         oJGZTMCXKIRnH0iknYXxNPxGEGAJkKRyZgLM+JuFDQVOJKg7uFL9RVdo5GfdbE7vuZGG
         1TMp3dncOL15XJQtFDzEsV6bdDMka35VzM3tq0UwEMAfIk+sCz0C5Xav1Hb6efezRf4N
         6kUuDVoEvrJPPdOFYJWSTE+IQLdmlKNnbIlpeRFK9FadkpFyfgAXufV/dTuyysdTz3g8
         MJ3ta+eabImE4a2jX/u833RxbtLu1/ex9PRjCMZcLuhUURflr7mXiqKPKPafUI/lGnSx
         RmtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO0/MJ4Gb0WSebU8kaMiIuccqVIPtRQwKNPtmGSjiSi/1j77z0mJ1BuiE7n3nZtN5RZ8o7UK1DAsi+fleoYEC23VQdeSgOGxDpNAUOMQE=
X-Gm-Message-State: AOJu0YwmuCkWISHLLEuoNHA1aw6iIiPyUi0O1mWvfKpDfKa0rby1XK38
	fqC8JLe9gcbJoHFIKiXwkZBEIqW7FuNiUd+nwQ688/WefBO/E9Rfxu1AHJp6YVs4S0/4d89vMji
	7b30COWbSDlS0MWtUr8SMhyezNaI=
X-Google-Smtp-Source: AGHT+IFDvtbe82NNASQ0oM9M0v5+nZcAsCCLz1k3PmRjYQzgoGqz5vUMO4HDkw4dQsjBUNVozxiQ1PzitWivbSxe5zU=
X-Received: by 2002:a05:6102:158b:b0:493:c631:5eda with SMTP id
 ada2fe7eead31-493c63160d9mr769729137.9.1721792941922; Tue, 23 Jul 2024
 20:49:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240723223109.2196886-1-kuba@kernel.org>
In-Reply-To: <20240723223109.2196886-1-kuba@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 23 Jul 2024 23:48:24 -0400
Message-ID: <CAF=yD-LJ+-S4gC9EVo6ijJTGjR6KfPMNPrpxoffgoQBFpo8GNQ@mail.gmail.com>
Subject: Re: [PATCH net] virtio: fix GSO with frames unaligned to size
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, shuah@kernel.org, 
	arefev@swemel.ru, virtualization@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 3:31=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> The commit under fixes added a questionable check to
> virtio_net_hdr_to_skb(). I'm guessing the check was supposed
> to protect from csum offset being outside of a segment
> (especially if len is not multiple of segment size).
>
> The condition can't be right, tho, as it breaks previously
> working sending of GSO frames with only one segment
> (i.e. when gso_size <=3D len we silently ignore the GSO
> request and send a single non-GSO frame).
>
> Fix the logic and move it to the GSO part.

I missed the previous patch. Should we revert that and create a new
fix against the original issue?

Normally the checksum start + offset should always be in the header,
so not even part of gso_size. So needed need not be related to
gso_size.

The exception to this is UDP fragmentation offload, I suppose. As
there the network and transport headers are part of the UFO payload.

But even for the normal TSO and USO cases we cannot verify in
virtio_net_hdr_to_skb that the csum_start + csum_off passed from
userspace are really pointing into the transport header.

For SKB_GSO_UDP_L4 I added a minimal check that csum_off must be
offsetof(struct udphdr, check). We can arguably tighten these csum_off
for all requests, as only UDP and TCP offsets are valid. But no such
simple check exists for csum_start. This requires full packet parsing,
which we don't do until skb_gso_segment.

One option may be to test csum_start in tcp_gso_segment and
udp_gso_fragment and fail segmentation when it points not where
expected.

Btw, do we have a better idea what exact packet triggered this
WARN_ON_ONCE in skb_checksum_help? Usually, more interesting than the
skb_dump of the segment that reached the WARN is the skb_dump at the
time of virtio_net_hdr_to_skb, along with the vnet_hdr.

> This has been caught by net/tap and net/psock_send.sh tests.

That's very nice!

> Fixes: e269d79c7d35 ("net: missing check virtio")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

> +               if (csum_needed) {
> +                       unsigned int p_rem, p_size;
> +
> +                       p_size =3D gso_size;
> +                       p_rem =3D (skb->len - nh_off) % gso_size;
> +                       if (p_rem)
> +                               p_size =3D p_rem;
> +
> +                       /* Make sure csum still within packet after GSO *=
/
> +                       if (p_size + nh_off < csum_needed)
> +                               return -EINVAL;
> +               }
> +

A check could even go in the below branch.

The warning apparently was not that csum_needed is outside the segment
entirely, but that the segment is non-linear and csum_start points in
the non-linear part (offset >=3D skb_headlen(skb)).

I don't think we should be playing SKBFL_SHARED_FRAG tricks to trigger
linearization, to be clear.

We also cannot just silence the WARN and trust that the stack detects
these bad packets and drops them (as ip_do_fragment does), as they
might end up not in ip_do_fragment, but in a device ndo_start_xmit.

>                 /* Too small packets are not really GSO ones. */
>                 if (skb->len - nh_off > gso_size) {
>                         shinfo->gso_size =3D gso_size;
> diff --git a/tools/testing/selftests/net/tap.c b/tools/testing/selftests/=
net/tap.c
> index 247c3b3ac1c9..8527d51449cf 100644
> --- a/tools/testing/selftests/net/tap.c
> +++ b/tools/testing/selftests/net/tap.c
> @@ -418,6 +418,36 @@ TEST_F(tap, test_packet_valid_udp_csum)
>         ASSERT_EQ(ret, off);
>  }
>
> +TEST_F(tap, test_packet_invalid_udp_gso_csum)
> +{
> +       uint8_t pkt[TEST_PACKET_SZ];
> +       uint16_t payload;
> +       size_t off;
> +       int ret;
> +       int i;
> +
> +       payload =3D ETH_DATA_LEN - sizeof(struct iphdr) - sizeof(struct u=
dphdr);
> +
> +       memset(pkt, 0, sizeof(pkt));
> +       off =3D build_test_packet_valid_udp_gso(pkt, payload);
> +
> +       for (i =3D -16; i < 16; i++) {
> +               ret =3D write(self->fd, pkt, off + i);
> +
> +               if (i <=3D 0 ||
> +                   i > __builtin_offsetof(struct udphdr, check) + 1) {
> +                       EXPECT_EQ(ret, off + i)
> +                               TH_LOG("mismatch with offset: %d (%zd)",
> +                                      i, off + i);
> +               } else {
> +                       EXPECT_EQ(ret, -1)
> +                               TH_LOG("mismatch with offset: %d (%zd)",
> +                                      i, off + i);
> +                       EXPECT_EQ(errno, 22);
> +               }
> +       }
> +}
> +
>  TEST_F(tap, test_packet_crash_tap_invalid_eth_proto)
>  {
>         uint8_t pkt[TEST_PACKET_SZ];
> --
> 2.45.2
>
