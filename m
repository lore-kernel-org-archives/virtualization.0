Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71321E2614
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776786662; cv=pass; b=lY/V73h3+lQC/sJa4RO6te7JzRxZlsmQSyH7rwabKazT+whVv8PcYttIGsvotraxUDshBVVPp0ueuv9U5H2QFs//h4AnpCkWOY4b70YJtL5GNh3e21FQI3Hg6EvhLRq13Adsi/slhQY5+lQIKVqBJaiZ77lRK7bOXBoSpPJBW14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776786662; c=relaxed/simple;
	bh=U4CXEOtSoYorkPvRqPYq8ArpjdquGnQvRmO5OCcs5+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFA5ZHmI0aPFvnMBEX1SyEtXqqmBs0iwIoVgDJDHgJfcp27YOYF0XHOfWvch81CVJg1DVJAbxxE1hMP1rOslbUkGJFHe3eassbBailr42hq9+ZaBI/+eTwWNNqNgAyzALP8RPsmjG41Ae1uzHt+/atCgTtil3uvajkrXeM6WSdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXn2Fh3O; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXn2Fh3O"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-652fcd5a6d7so4937724d50.2
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 08:51:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776786661; cv=none;
        d=google.com; s=arc-20240605;
        b=OtoihQmw3kxk/j8/TYHEYnRYru3ZfPz+NHNNdqoaYNoJNwIZ1TIFcV0Wz9mivmX7CB
         K/dkUSnyX9C91jsoxPbNZAqjm6dp4rQ9Ar88f9Vlyb5kvLRrYF+Zy2DisqGRm98dL4so
         TUxaDDXh9zviQAOZSO7andvxYGXmhinfZYBNO/+cdZjorriinZT5dKVz0FxRav4wKpXK
         lg+TAWoxsAcsl9FOErdu6VnU+FEmK3LeSiwHMh9JMAr9VkZDun0p52iuLdLoRBLkZgPP
         dTdD1GVJW7RqWEDASkdvZZpcfvpv+ca/fWjL1DVo6BuvqmoxMFO2sAnl1BXR4jvbxfid
         XMMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7gkwtsa9/SFlK3SjZgMHdS8ZwnKS7c0CunXCC3y5DHM=;
        fh=YJeqvXm2iSB/Yx4zAU3OhmNc7EqVFmRA9KIJOGBf0oY=;
        b=fOSbzs9fAMtyiW79Se9GJiEvzVlN4YF6H2tFs3cECI0uMK3FShneDFfLEdCYkZZyat
         TPO0RlpX+wi2K57hxra2UmuthFOyUXVlzbDdMky0qTDS6inMplN0oQWkcmAkDvg9X3n1
         Tdm5rup/wQoDPBy6o83BeC9k2oMNCeKAfntXdsGCzwHzJleSB9Fytder9CvQfOL4ntXL
         jOtPHa0W4YKtcw+sWSiNHTGjffdBFearXqOb/89YKrp/u16B8op0CFsExfRu+9y8LdXW
         cjWy7tsyHrlqiLj9AbjsLxGuYi7BUJLPBEYpNsLLmSm2I6bjfNm43pKNhXALXCX2MoB/
         0NNA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776786661; x=1777391461; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gkwtsa9/SFlK3SjZgMHdS8ZwnKS7c0CunXCC3y5DHM=;
        b=YXn2Fh3OIJwjy5gnzqSg5rnEi/XcdiyIqt0NyvQ61h2ne2fJkQ8VDHfU7trJtx+sWx
         +fzjRE0nwib2iZTuYy57/niKOFu4hgnZ+q3tJpFQ4Tv/82TIRJsVFEHFLo+5gf6TIfz8
         2Bt5+sn5zHLXOo7vZspu5XleYiDE9a2c4RW8fsA9C8v67IpB9u7jcJ1H9XYS/W2G8n7o
         sxnBk44zV4YmVs2c7bHIH2ncW0AORw0qT58uas83T8QAwZPKyeTnfB8ajx/kIUQfGPxz
         dNge+NaQvQfeL6awbZEWnGMc+OLPttninv09HqxSRRfx1r4cTnjvoBpEb7HxcOwjVlGH
         z3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776786661; x=1777391461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7gkwtsa9/SFlK3SjZgMHdS8ZwnKS7c0CunXCC3y5DHM=;
        b=fcCAsrwiWerOX1Hj2NmkG7Ypad1ZN5aCR5mVgsC32h5qqulPdVcXzajcGTNlVf58FA
         Nq0YOC0xwghvKeoy6nDTe97KJ6XIU0xfVCqEOht9L051yzEVW6NrjZHZHlNmvWdjfm3B
         Dwrs/b7D6aUI9NG0GZaFI5/AD7EeR65oM0g5YSiKcxUUs4j1MfySWllpn06GCw8VtxKV
         OJ0EQWe5cN/NVDBMsbU8+ybuEji5qU5JtDpv3ALlB5LsxqnSsgnVXpm2zxKkLogvKnSb
         YTN61TpInLvvgzihul5Gg7vk8/aSjxvpbLBqD79abFNjiUVvNGdUhp4DkAA//b3x4eTb
         b44A==
X-Forwarded-Encrypted: i=1; AFNElJ++79LBcVNPbIoqL4Rh8BNM9/Nuc0P3AesggOc5bsROC2X9EKXwv3byExWL3nTTGMGLnfzBmx9zLuv2WeSaPw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywu73VN1em6/j0p4W8sp9via6a+w2XoAv/4Ih3rfi8w/rf9wd1c
	F7ohdG4AlZgaw0HNyT65yK7jChomjVp7v3PIpyGp/Tgcs/qlboxxK01zozOo5fGC660+ByKgV26
	FeWwO+ms29VUA8AczFcw90w/cCR+BPBw=
X-Gm-Gg: AeBDievrQ9Jys95BE/KmPZFPg42ZfmlOAJKkcTLf7/5qR0IENe2RxxO6aGtt0QIf8hx
	86iNYx0Xvxqc6y+qIP9q+bmTanjrujnzqCHXZIYE6s24iYRkt0p1SOamH8TMB9TbuD2cnApj1kv
	bBHHM51KVYRWBs715xeZcjTDn/Ala3diVklmTr803GqizogrONT52oMwPsRIcUUKJFBp1rICzbh
	LWu09o7DfWysXawdaE5rTcjOrfpw9fgp/A0+qrJxqFfimQ1Q7j9xRCGoJrabXJEMY6ouTDB/NHP
	E+Ouyjch5rNthCaZpa3csXi3eiz7Y9tbl6/YtwKpVeoOTnpbTWFxdAequREzKoIuR8Kn4BoCslD
	PLHe9
X-Received: by 2002:a53:4208:0:b0:651:9286:578a with SMTP id
 956f58d0204a3-6531086db46mr13066080d50.25.1776786660716; Tue, 21 Apr 2026
 08:51:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260418000138.1848813-1-michael.bommarito@gmail.com>
 <CABBYNZKP-Rwumw0c7FHEsL5e6XpFZCBA-O2avNujtYgRHeVZhA@mail.gmail.com> <CAJJ9bXz0nwWsFg-B0nn77bn4dh=ob-F11a6azK+VV8sbLOBmLw@mail.gmail.com>
In-Reply-To: <CAJJ9bXz0nwWsFg-B0nn77bn4dh=ob-F11a6azK+VV8sbLOBmLw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 21 Apr 2026 11:50:48 -0400
X-Gm-Features: AQROBzATa54Ha7FaSQMWgwIrzto8qj3R2qU1Itz5IXioBc-FKFmq2bwcN19d7rs
Message-ID: <CABBYNZKqx4ureNbRGEghGjGWcmMQSoiY4oUCECme_Vgn8RvYYw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: virtio_bt: clamp rx length before skb_put
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Soenke Huster <soenke.huster@eknoes.de>, 
	"Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Tue, Apr 21, 2026 at 11:19=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> On Mon, Apr 20, 2026 at 3:17=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > All seem like valid comments to me, first one is odd to me thought,
> > never would have though that skb_tailroom wouldn't be enough to check
> > if using `skb_put` is safe.
>
> Thanks, those were definitely gnarly.  Went back in with
> cscope/libclang and found another spot to guard too.
>
> Let me know if you want me to re-organize/separate these into a
> patchset instead of one bigger patch.

Yeah, let's have it split into different patches, otherwise the commit
message gets convoluted trying to explain the what and why of each
change.


--=20
Luiz Augusto von Dentz
