Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D29A48CD48
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 11:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789471090; cv=pass; b=bl8pB/DP3dhT4sOKwFnuTbhPtpGC32yeCYpkyyPKsL18b2hwhlkDGtdw5hjullt0RfbZDZWTADuzznRrA9JDZnO1B2YrDSrkQP7S5xgKA3e6prSsGblXHQurLfBbHO+Qfcb7APO8jlrmprHQy6Ih1IMl7FFxXdc8FM17coyxZKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789471090; c=relaxed/simple;
	bh=oUH4hC6Ww7XAjKdUYRATAFY26h0AzpptVZOISTWg9uE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ox2jspkHLw6oyIA2yzZz3g6S8k1x6DDJHFIUCyVRIi21MdQ7PfuhnIinthYjsW8jqnmcNkca6CS7TPRLB0gJ/2uGoWDdL3Oy0BeFvvLqo/jyazF+SjbYVnnRvxmLCfLLd+XQu5yxKVs3dLFCAck6Kmd2jhVdaKm40cVcA2lWwAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlJswcFG; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlJswcFG"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-47c57070c52so336840fac.0
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 04:18:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789471087; cv=none;
        d=google.com; s=arc-20260327;
        b=egsjOpgGwGPAwUnFSvaqdirYo7zhcxltuCZh4sqQooidVJncYc4WVPpgHhwP8OWb7y
         pPOGu2Pt/TRNEDFBr+TYHGTBpeev4w42+YX49FAytvPPrho8mipyTX/RyLNITM/bBiRn
         3mXHoGpu3SDKPYkfGwcgZcI0BEdRB5tIYD9T4WHg2dn+CQVaTmcr+VSgvLS/0Hvi5xdT
         GA/eqNQD3K82oS7StGjB0tVBrq6AjCcrupc7dIgDF3JAKQHqiX48YnAG7/by+q2bFHD/
         q3JnZwisMNpgsqU0PcAyOd5Pv2BacVOqfbPFBL51TshgQTGtzciucg952JKxeauOs80c
         Fvag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u9pPdrxsMaMfQQaOgq4EdcgCcLofWpqOD8LyHtliMQA=;
        fh=ib92A5v6OWQoSEZqyrmfTbC9L8cfqhaqpFxmAxtNsn0=;
        b=sK+KlryHIpZP8gmIe8h8jbucUwmRKZh3jRfkLmaue+35/yWbXa5QaQe0aNKpYWv806
         daho3IhIKHXtHrc4nYKWAWF3VZNZXqVgwwdCnhPmVlBec/WoLEBjkLb0fBimQR/5PAG7
         NgdTJDyy0U6Nc8CL1+onFusrMx33YXybC59uBM5V0SkIVIgnRWB4Yz1VuaF93cHuoOCa
         aIHPPP4qrYA2SkNOZwzcF17/S2Rtutg+bo2lVHlK7Q0NjpzytcpZyjoSKBD8JB4TECFK
         mLc67UATPVGyimUNJt6Xy7z8jv8myshjbPEL1Xhr+wJ9vWLtdvL7Wj3ZCCD0cjYR8IFM
         KR6g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789471087; x=1790075887; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u9pPdrxsMaMfQQaOgq4EdcgCcLofWpqOD8LyHtliMQA=;
        b=jlJswcFGXPOyz8EWYa5S0Kq6LWxotjTgWmhVsfKRA1WvJziEIumOODMF6lXnuqujgM
         fdCBVDhTOPuFLGtaFhqJkYHaTjyGy+/xTqlztgPzxLQRETcPT1LWwk/vuHitiXllrEpC
         e5mp3CNmnYZOc7/h1CGta0JMRdAihgD+dksJlJBmYoajd3l54fVLZvCblvEnG/af2eiN
         SUZXYOLGmN/FAznXY8ca2R+yAXiVr3vrobBtbw8QGQxVErFYSy/O+IKO/UHr4UII2n/Q
         vlU54LFNBbsF4BJ82cf9pqbmuCpid9j+uypw+UaSg6RPUo/5YrSlQD5QZFbFrfZ5/wmy
         gqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789471087; x=1790075887;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u9pPdrxsMaMfQQaOgq4EdcgCcLofWpqOD8LyHtliMQA=;
        b=OBosw3kD0R+Ekjquf/jolYm1VitwDZRVnK70e6wEACl0HvF/uyHnJl35rpurSXpQ9+
         p4wUbBQpGz66SyIjGY9RxEIY8o8BxTv4qHUDR0VSJ14iIRk9IqaCiPQZUUO+KpMD3vbl
         BcZkXXfLRb7OlStgLPjHBCzYRUP+eMgHL2PITgqpmYMvGaLCuYZbmmIpk5u1YGS1Fqpa
         Rxux3U8AH9Hp5r6A9oLd8OfWTj8OHyQsUY5M73m1+TkQuvCerR+PdMy3S5pOGIxZ35+l
         PrBD4qR+Q86Cc+Jhl8xHpiA9Bz7KXyu1LlINPSPjm/P+L4+Apqqx56hQEi0AOtErIgvu
         PfOg==
X-Forwarded-Encrypted: i=1; AKwUvBw9r8DU4xv+NGtAO5YG+6eA8GYLFAUGOKfMbcljW8mL7MPePKgmmBkv6Y2GiVByUYzuYZJb2IBh8NcoE0wAdw==@lists.linux.dev
X-Gm-Message-State: AFuF++mRFUEyjPAF6c5T6+4l2tqe9JF6TVdHuAVFDF4bF/+hi+m6m2mQ
	S3sP0pEfpW07YG3LhQi5TflI0VHF77/ktft5xUUIpN9pf+7z+MqniHevaPuCCQlNa7T7FDGCmiN
	DIedtFtzDZUPiGNMwp2WH5oMZqo5uxudKqcMF
X-Gm-Gg: AYBFou2aPancu+gSW68Jw2dHz81sGjVzU962ycYsvURlAG2Q6iS/xjgZb++Occ6rVd8
	9SwIUhnsR4hmlfx4FnyzVUFdSB7qywLq8Ogq8KXLNNMSFZzm/VHrIwi6jrrfPTIUYAHLfzXBN7I
	028bj8kWvHXnAfeaj4G94E7nf8/J+FjnoKvYINdzyOlt2OGqqboJYeGDXc8mXePAp7cLwBM6PSr
	w5A8BGcMOd9XqV4nxdAT/2uqqhHeZTDzhrrnTPmCiprqNJK4tISqIUcL/9d5vgZXDQRF5B4eVuM
	DqxkKrigV3Q5vQUht0od0iwiL0P0xrLEV9wZOgkKaauLJ3oKIo1w2Y0K
X-Received: by 2002:a05:6820:168f:b0:6b4:5460:63fe with SMTP id
 006d021491bc7-6c6389bd1d0mr1627949eaf.15.1789471087242; Tue, 15 Sep 2026
 04:18:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260911081133.16434-1-flyingpeng@tencent.com> <20260911041337-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260911041337-mutt-send-email-mst@kernel.org>
From: Hao Peng <flyingpenghao@gmail.com>
Date: Tue, 15 Sep 2026 19:17:56 +0800
X-Gm-Features: AcwNN1XBIivMcx7-2S20nzqM75LCGfvHIUh6vnz24QEXFAc0D-fEalp85Bv7ADU
Message-ID: <CAPm50a++999Y35NVDoDk2g4E2ctbVT4ottv_UvbDK+Y5jhYJJA@mail.gmail.com>
Subject: Re: [PATCH] virtio_pci_modern: fall back to 64 bits features for
 devices without an extended features space
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowangio@gmail.com, virtualization@lists.linux.dev, 
	flyinggpeng@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 4:28=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Sep 11, 2026 at 04:11:33PM +0800, Peng Hao wrote:
> > From: Peng Hao <flyingingpeng@tencent.com>
> >
> > Since commit 69b9461512246 ("virtio_pci_modern: allow configuring
> > extended features") the modern virtio-pci driver unconditionally
> > accesses the whole 128 bits features space, i.e. it drives
> > device_feature_select / guest_feature_select with the values 0..3.
> >
> > Devices predating the extended features space only implement the
> > legacy 64 bits one, and what they report for the selectors above it is
> > not a valid features space.
>
>
> That's a device bug then? The spec says:
>
> \begin{description}
> \item[\field{device_feature_select}]
>         The driver uses this to select which feature bits \field{device_f=
eature} shows.
>         Value 0x0 selects Feature Bits 0 to 31, 0x1 selects Feature Bits =
32 to 63, etc.
>
> that "etc" means any value is valid)
>
> There's no "extended features space". It's a quick hack we did
> in the virtio code to avoid changing all drivers, but the spec
> treats all features uniformly.
>
>
> So you have a device that ignores a feature selector? Or some specific
> bits from it?

 It ignores every bit of the selector but bit 0, so the selector values 2
 and 3 alias 0 and 1.Reading the four dwords back on the virtio_net
 device of the smartNIC:
 device_feature[0..3] =3D 0x1043882b 0x80000023 0x1043882b 0x80000023
                                    \------------ real
--------------/\---------- aliased ----------/
 What that costs in practice, for virtio_net:
  bit 1  VIRTIO_NET_F_GUEST_CSUM  aliases onto
  bit 65 VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO
  bit 3  VIRTIO_NET_F_MTU         aliases onto
  bit 67 VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO
Both are in the driver's feature table, so the driver offers them back,
the AND keeps them, and virtnet_probe() takes the first branch here:

        if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) ||
            virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO))
                vi->hdr_len =3D sizeof(struct virtio_net_hdr_v1_hash_tunnel=
);

24 bytes of header where the device uses the 12 of
virtio_net_hdr_mrg_rxbuf, on every buffer in both directions, plus
vi->rx_tnl and vi->tx_tnl set.  The link comes up and carries no
traffic.
 The same card works fine on 6.6. 6.6 simply never drives the
selectors 2 and 3, so the aliasing stays latent.

> >  Negotiating it makes the driver and the
> > device end up with different features sets: on a smart NIC exposing a
> > virtio_net device the link comes up but carries no traffic, while the
> > same device works with a kernel that only accesses the low 64 bits.
> >
> > Reading the features space has no side effect, so keep reading all of
> > it and use the extended part to tell whether the device implements it:
> > report the legacy 64 bits only when the extended words read back as
> > all-ones or as an alias of the low words, and latch the device down for
> > good.
>
> So using all bits is illegal, and so is anything that will by luck
> mirror low bits?
>
> This is really VIRTIO_F_BAD_FEATURE mess replaying itself.
>
> Really quite a hack :(
>
Agreed, I have recognized this issue.
>
>
> >  As the features negotiation ANDs the device and driver features,
> > no feature above bit 63 can be negotiated afterwards.
> >
> > Writing a selector the device does not implement cannot be relied upon
> > the same way, so never drive one above the highest word that actually
> > carries a bit.
>
> This part is ok.
>
> >  The reset preceding the features negotiation zeroes the
> > device side features, hence the words left unwritten stay cleared.
> >
> > Also dump the raw device_feature dwords,
>
> dump?
>
The dump was debug residue and the parameter was me not
knowing how to identify the device.

> > and add a max_features_u64s
> > module parameter to force the legacy 64 bits space on devices whose
> > quirk the detection does not catch.
>
> This is even worse.
>
>
> > Conforming devices are unaffected: their extended words are neither
> > all-ones nor an alias of the low ones, so the detection does not
> > trigger.
> >
> > Signed-off-by: Peng Hao <flyingingpeng@tencent.com>
>
> Can you simply fix the device please? Why not?
>
I would need to know more about the hardware specifics to determine
 if a hardware-level fix is possible, but that wouldn't help the cards
already in the field.
 I will investigate whether the issue can be resolved via a hardware quirk.

Thanks.
