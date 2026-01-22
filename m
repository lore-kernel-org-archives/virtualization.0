Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE4B3DE338
	for <virtualization@lists.linux.dev>; Thu, 22 Jan 2026 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098459; cv=pass; b=WtnUxl7MtbA/bMoXWvGlIAvyQ3QqSnBLpd0DGowaiIjrqci7dxCAeLis6UwnxmHnjQxyETJTRKLByG95J3KKOz9crs3DYim3CmAsSugswO9dcmG69676nKsiZ6HVPWHZFZDiBGFTSctVf17RhL+9R1ZOsLEqvpNzposEltMhshk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098459; c=relaxed/simple;
	bh=DMMIT4OBOGCSABOIq/HSUVkir6AqQt0iZ7vlBLj9du4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aS+/VfIgt7+LSldAhFxUwFAiaqe9zMwz+rkWbB+4hXM+h+QOD+13zwV+Uih7RRlWxTyFr1sLLNYsZIgeUnurVQSftWU4957o7JqflCNjTYJCCxIzL+bccOt6arfaAT2zIOcIBWQHDsi+t2PIh0e7wbcyKJBgLFNJ1+aPho32EBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2Um4D7ms; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2Um4D7ms"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5013d163e2fso12475181cf.0
        for <virtualization@lists.linux.dev>; Thu, 22 Jan 2026 08:14:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769098447; cv=none;
        d=google.com; s=arc-20240605;
        b=AVT/KJk3nIqf3uwKzP3GCNVgCcPs0GKgE38oxuCo1+S0DRTgJ0u0dJLW/oO1xlVaiS
         zjD9zAhfihLDD/Z0my4w8mfoGvYWVPwTurKpKAHT6tj2dj7ysz5FItDrk8IP80PSwJ6l
         xatsvMKGOZZeBJFW24x5QF1LEmEeG3RxhNT40qIcWRJ2y1yuMjQYAOTRZOAHz2cMsPrj
         qU4eMmhq9CGzbcSuNhUtm5MXj07T6z7HV1Ymgjskvr2tP4+Tf65zDudDauPZnDWy1xjM
         1Uw3INGjgw3AIGwPhlN2+xlrzTaVvks2DsX0tU4WjnW/FiN9uT8nOU0YIsTL8hE5jvqi
         J3ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K6muVKn0SpU0orx+YFCCOdy33OaYBtEbvdotyL/4ShE=;
        fh=BMxwudIIDlgTpV+xlDZFJlDsdfspJsVjVr1DquY3nnw=;
        b=kjVcS1bk7aXM6hajs33jfALQWDRIiG1nYHDDh7YAFWLb3wXMoeGITEkBu5y9t02G/q
         i0NpUtqfXglbfAbrtC1iWLZ1G2LnzyMTqbxGVaZ8MFLf7Gx+6652TEmENr57L90uPdCm
         vu6b9Gmwefe7bbyMLkV90cWnfx4BM8KfrMVwwJ4cA+qz3XlROZSY08N2oCYeWzna3Rix
         HKZi4y09Vt1EuBKyByxTQQFeeiH/FKtCtx3N36pbX8Jju5hhlwxpoFlW23I30Nyr+/Ru
         lbSACpOIjU2XcfQDQBrvhaGMMVgmRuQX6w4n1sAf0IaR55dAAVm38sHOHC0mWdcNgj9+
         XeuQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769098447; x=1769703247; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6muVKn0SpU0orx+YFCCOdy33OaYBtEbvdotyL/4ShE=;
        b=2Um4D7msvMXQQH/EZVnZzzodSrC3PlRLiUGG2VaUWZcWHfDHH1h5qmv/1u0x3bqq9R
         31pocO8u0+vuhYHq2OnB6fhwWdJoq9vJvIzOkWceBqSjQ7s6nrclI5Q0tbPFWj/dpJyU
         5W2o9QzNqQrcVwqmzELttiMSC5eyDpMkQefuhkIEh378J17UwYKNkiwUUPOONp8GuPgD
         0zgIF4L7NRn6F6M6UgJy22a5LzWi4tG/1B1wxlvtrVnpytM1LWMk6t5apH3AqQuuc9ZU
         qgm5TcpQcOT1oOIDsCEcfHoZQEQOK64xriqGfUFDzQuJIwTT9DMC+tGE2F8gsFi1igUJ
         mWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769098447; x=1769703247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K6muVKn0SpU0orx+YFCCOdy33OaYBtEbvdotyL/4ShE=;
        b=Z0k+E5EihpNK/mAfGmdgmAj1rBTPKIBArBJt5LoomYjmdTsVUzyRAAdb6EzXyQkKwi
         1fT+bI26zhm9jmVp3yHLs/ZNGz49sh1DlSPD+ovzEtKnoVYUmXu4PiTqigpEB2+5zt1+
         JYWD1QckGlOesKrz5J5DqcdHl5im5RiJgBh02GIwTO2vXxMSDypRYIg3kbv54PbQ+pwD
         9x8h3OzAkF3E6QpuMNyKFZMRRKv9oHPb1o8WiXI0tN8bsOcB93b7Y+RDE+zy0rUrKEDF
         JpxUJ3xsFX1z5caUcre/OwKuPCuG57bh8BQdm9uL0gwit+BbC82yx8w1q6vM1KTSrfcx
         1NxA==
X-Forwarded-Encrypted: i=1; AJvYcCVKk9eOahcpi68IvbGS4HPomtw1+cmqxw7D/dvRDt6HWp8UHl8kZJsACDFJJRmUo5c0WMA8ik5Hf8XBez+oKA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzADh5EYYLreICExM8o45+8OpkZgDlNk9KK2qkw07pc0JYGQHYQ
	CnbmUwYk8qud/X6HDe2fu8JL+BVlBi0Q02F1tusux0JrRko1pwBkSuXTVOnAdy3dWwUzbdz4sZ0
	g1x0MeHnxm4nfGT0HgWExs874I0+JTsPKV1riZQbm
X-Gm-Gg: AZuq6aJcC6ig4eZlXcUpBGE9TpWoT4uM0Jv0wMv9ht8cTu9rKQYqYDXKB44CRZOJYpe
	twwjpDF455epZoFCWkNMZj3tEi8IBItbwlbnHUPFStkCisdGqJQuYKuw/1WgFe3CGDwFP9hWsQg
	z29SZq/JpwFHM1eN2AVDUrto1X+pXQVatJX175fxsSlxOIRe5xUwnDd0yQw0nDI/fXBdqjgratl
	7eGonm6DHNUQdWoGP52TqL431IK1IZlflV4gV659fNe9fuXHeXqoHPnUF/j/x8L9Xz4AHY4
X-Received: by 2002:ac8:7f49:0:b0:502:9a98:34cd with SMTP id
 d75a77b69052e-502f7764b86mr979651cf.22.1769098446887; Thu, 22 Jan 2026
 08:14:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260122091527.339180-1-schalla@marvell.com> <20260122075206.504ec591@kernel.org>
In-Reply-To: <20260122075206.504ec591@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Jan 2026 17:13:55 +0100
X-Gm-Features: AZwV_Qhok7oKZjawaEjN94P0-ccBoOOH9sRA_7UQ4L2cNNkzKf_7jQWnXt6qA6Y
Message-ID: <CANn89iL5s+egLhothNtnQf0jtAeftezUjNmbuXtUWgfVV3+bzg@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: Increase RSS max key size to match NETDEV_RSS_KEY_LEN
To: Jakub Kicinski <kuba@kernel.org>
Cc: Srujana Challa <schalla@marvell.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, pabeni@redhat.com, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, ndabilpuram@marvell.com, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 4:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 22 Jan 2026 14:45:27 +0530 Srujana Challa wrote:
> > Increase VIRTIO_NET_RSS_MAX_KEY_SIZE from 40 to 52 bytes to align with
> > the kernel's standard RSS key length defined by NETDEV_RSS_KEY_LEN.
>
> I've been meaning to bump NETDEV_RSS_KEY_LEN to 128 or some such.
> Most modern drivers can't use netdev_rss_key_fill() either because
> core generates a tiny key. And the devices support hashing over two
> layers of IPv6 for tunnels.

Seems fine to me. Back in 2014, RSS was limited to 52 bytes on all known NI=
C.

>
> Willem, WDYT? Is there a reason to keep the core key small?
> Or deprecate netdev_rss_key_fill()?

What do you mean by deprecating it ?

One of the ideas was to make sure multiple NIC would share the same key,
for some bonding setups.

commit 960fb622f85180f36d3aff82af53e2be3db2f888    net: provide a per
host RSS key generic infrastructure



>
> > The virtio specification requires devices to support at least 40 bytes
> > for the RSS key size. However, devices may support larger key sizes
> > up to 52 bytes (as reported by the device's rss_max_key_size config
> > field). This change allows such devices to work properly.
> > Previously, devices reporting rss_max_key_size > 40 would fail with
> > an error during initialization.
> >
> > The driver already handles variable key sizes dynamically through
> > vi->rss_key_size, so increasing the maximum limit is safe and
> > maintains backward compatibility with devices that support smaller
> > key sizes.
>
> > -#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> > +#define VIRTIO_NET_RSS_MAX_KEY_SIZE     52
