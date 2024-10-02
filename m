Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A2919F403
	for <virtualization@lists.linux-foundation.org>; Wed,  2 Oct 2024 23:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727913406; cv=none; b=tOmanUrkMXTGvsjnDVywD94zaFXCoZFcFOrjT2sPbILZZDifxCjBeUddCuKgg9qyG4TNaDcIhA1n8TWkPe/CXy88XYlkUU1DczZrIcIOvam4VJw3Tonikp3BdanQ/YtsHCwL8/ZtVXnnJFcYwskRMyJqWRsTA2g6gKV6ycy3+ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727913406; c=relaxed/simple;
	bh=TkWmaNjobsczGTdIkYhn5D1IoEQfdT3pZ7qtwt0+v94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVtIoEObdPl7aSD0w25VnIlkkMZpeU/d96LpnHA+FxpGEJqy/kgPS1WV44dka18yrRke3AHKbmocvuNQLrVDTlevvVb0YLPHoAe0ehWcPo4JCf6gGonKu+/VpIvhU6P+scR7/5YnVrocTaouOlK1hHe9Ydyt8/dPJCujxp7oSpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CKv2HoHI; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CKv2HoHI"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C974406EC
	for <virtualization@lists.linux-foundation.org>; Wed,  2 Oct 2024 23:56:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4seTy5bdt5Hw for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Oct 2024 23:56:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=dverkamp@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D493E4011A
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D493E4011A
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=CKv2HoHI
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D493E4011A
	for <virtualization@lists.linux-foundation.org>; Wed,  2 Oct 2024 23:56:42 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a90deec0f8bso4944166b.1
        for <virtualization@lists.linux-foundation.org>; Wed, 02 Oct 2024 16:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727913400; x=1728518200; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkWmaNjobsczGTdIkYhn5D1IoEQfdT3pZ7qtwt0+v94=;
        b=CKv2HoHI3p9u/kkuIy5S93CpZRpAxO/cS+kubSFFhhES9hHaPFiRziXnaaEQhmRrF0
         6AE7P+EC+AmCw8b+UnVGfx3iw34wAelcar2ht0P+AITPDaVvhnlF0TIpDXGpPbSP+S6Z
         qiZy+fh2sS2notrt+h7peJ0Fz3UCQecwOCsgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727913400; x=1728518200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkWmaNjobsczGTdIkYhn5D1IoEQfdT3pZ7qtwt0+v94=;
        b=dCwOmI6s+ssiB1nUQx5f2B2evqu7k0Q5mat5WdsLdan//EDobgwCS1BQw7YIUPRjOS
         FBBI5ir0lmqznm5Vaqf7gIklQYg3Cwls4YJClaSomGRYEWfHaLCqT2NsZwhEY37aNlF4
         muv7hvo8xS1lkFfoPQkWpTpGkl8wHTmax4X3pKFeKGUuKH67z+8IKhFnw4O+z/U7pmNb
         NO29Kt/b5e8/NRTGR/Z9WpNoxAKVJM3Fa+/PddpH4XUIc3okSLoMQ9dXNJs32N2Lj9bd
         44K2D9vskuRZKsR7i59Z6m7RcBawoQnt2zdQTiHLSGM0016/jv/jmNnR8Hw3FmzZkwJX
         0CKA==
X-Forwarded-Encrypted: i=1; AJvYcCWsSNc2P2Mv4rW/ITEeNMbX0MC5YPfHqrztOE1d0UNXWkwrRmWdplybqzLA3B95+jg9ZdhsVB28dzIvOezauQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzNiG2dwMM0G4ya0gpwsBmS1oY4ZZ1qC2xnxd4itXqyZG/6yiyF
	10wJk67jTD4WHg5xeTAFssx7Af55JYlEssnTMKDbDQyC6zCxULUlL6UcW+pBWn+7Bo9ulwWjElk
	=
X-Google-Smtp-Source: AGHT+IEbSYxqUSJNHFAvxbFIRZK3dA8v7RCQC17QzG4FExcl/bXbTwBGESNIHRc2fkdGt7DSuhkE7A==
X-Received: by 2002:a05:6402:35c6:b0:5c2:6850:7b2 with SMTP id 4fb4d7f45d1cf-5c8b1b7a6cdmr1506429a12.6.1727913400461;
        Wed, 02 Oct 2024 16:56:40 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8ca4f7075sm16042a12.95.2024.10.02.16.56.38
        for <virtualization@lists.linux-foundation.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 16:56:39 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d3cde1103so31719466b.2
        for <virtualization@lists.linux-foundation.org>; Wed, 02 Oct 2024 16:56:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqmzlv1mU4bqqw9uKcJZ1l1PiPOlddQg3Vnabr/jd1SfNQg4fpKaFKALRqlceEMqUgEZgQoohPnRWs5AHP9Q==@lists.linux-foundation.org
X-Received: by 2002:a17:907:7fa7:b0:a8a:8cdb:838c with SMTP id
 a640c23a62f3a-a98f838aa6emr496483866b.53.1727913397985; Wed, 02 Oct 2024
 16:56:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240925145228.27953-1-mgurtovoy@nvidia.com> <CABVzXAntBt+5L4a1ntud_7j_EHiB4yG6FuskNaPBirOfLJ7i6w@mail.gmail.com>
 <ca954af2-4c61-41f5-8cf0-69a1233704ba@nvidia.com> <CABVzXAma4T+=meTSRNKhq70w4imc=A5imy2zofX2ndJz-XVByg@mail.gmail.com>
 <adf195c4-6d7e-47ff-ac62-dc4c0f463f21@nvidia.com> <CABVzXA=wov8OgADXbDiVVnhncc=zgET4MAGd3H1pr26XS38JBw@mail.gmail.com>
In-Reply-To: <CABVzXA=wov8OgADXbDiVVnhncc=zgET4MAGd3H1pr26XS38JBw@mail.gmail.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Wed, 2 Oct 2024 16:56:10 -0700
X-Gmail-Original-Message-ID: <CABVzXAmxuVngKjNvc9AsnkuNcOK+7JeEuBE9CDaMxAA=b3f=fw@mail.gmail.com>
Message-ID: <CABVzXAmxuVngKjNvc9AsnkuNcOK+7JeEuBE9CDaMxAA=b3f=fw@mail.gmail.com>
Subject: Re: [PATCH 1/1] virtio-blk: Add description for blk_size field
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, 
	stefanha@redhat.com, virtio-dev@lists.linux.dev, oren@nvidia.com, 
	parav@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 6:45=E2=80=AFPM Daniel Verkamp <dverkamp@chromium.o=
rg> wrote:
> On Wed, Sep 25, 2024 at 4:42=E2=80=AFPM Max Gurtovoy <mgurtovoy@nvidia.co=
m> wrote:
[...]
> > I'm curious if you've encountered any actual implementations where
> > drivers send non-block-size-aligned requests to block devices. I never
> > saw such implementation.
>
> I don't know of any real-world implementations like this, but the
> point of the spec is to allow interoperability without having to know
> about every implementation.

I did find at least one existing real-world driver implementation that
ignores blk_size and VIRTIO_BLK_F_BLK_SIZE - the u-boot virtio-blk
driver: https://github.com/u-boot/u-boot/blob/master/drivers/virtio/virtio_=
blk.c

So this is not just spec language lawyering; this driver depends on
the ability to read/write at arbitrary 512-byte sector addresses and
data sizes, and it seems like it should be allowed to do that based on
my reading of the spec.

(Perhaps u-boot's driver does not work with the QEMU's virtio-blk
device with certain storage configurations, per Stefan's note, but
that is again just one device implementation.)

-- Daniel
