Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D51B193402
	for <virtualization@lists.linux.dev>; Tue, 27 May 2025 06:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748326497; cv=none; b=L9oM+y50tBIyZOUPMWUiUFWPJcUvmtsMu8nmWCMdymphIoJQf39dVKpZ8qe9CT+tIPu4szrYjgUXLr3O1M2PharzbEMZxu9dtKwxpBS8vjLE58tkTZ8xglm+XdnesDeVZJsHLF7uGRie9Hin46pAhuHEegmomMGRmZc7cE3m6MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748326497; c=relaxed/simple;
	bh=bPZlBi/TrOB7P9Rl1Y3T5ifdw7rwhtu0psVkBPl9Cy0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=Guazwvbn0wNhmEFnYrs37zonJowb2b56IcjgfEsSgoFlIc4q5W3NXizE+tIDRpFitGY2Gj0tsOFCT7o9vwwPoZT3VvmPBX1H46nNrjHP4upkjwt2wexV5IGTw7BBOp6GjW5HV7MzeXyWqjoccpptvFF+e2eFuaxBZ9YMwR8XSV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ivc2joM1; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ivc2joM1"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b271f3ae786so1658129a12.3
        for <virtualization@lists.linux.dev>; Mon, 26 May 2025 23:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748326495; x=1748931295; darn=lists.linux.dev;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eBBkE8s/YVneLq+9AwE4ItbtcJd3DVQnda+tTZ0Bolk=;
        b=Ivc2joM1quMdTb9pCelwsH85XAM8IHjial+eDGWCXL6njtnNqkNXvT5gME6X2xBnyZ
         p+1QYwIo97gVRA4JAj00YXeLqHM0EPz7qbLycksEZ+BS4AHC5sEzsqER3juYBS5eY+Eh
         yM9xCXm01ElUV9OYX/2+QeCf1Ao1daiRl6dHvUd+nlMxgCUwPGZbeRsbkbUHqrI4kAEB
         IAkfrz3c0fziT9Na8e6G24oEkTfDK24li8a3F7oaY5x2GKeHHMM0fSGLQ8Tw5rUmeCQw
         t4f/i4Kf3Cs1dytXGh1Xrz/REjp2J0axquXvscrni+vC7njqLIdX+yTNAm9TIZK0lO9a
         +jrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748326495; x=1748931295;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBBkE8s/YVneLq+9AwE4ItbtcJd3DVQnda+tTZ0Bolk=;
        b=EPV7ktLjwxNBIzYCvLDmvzhwsx7o+nUNsVNDv6SaG50GQd83VlxFqXj7lRrCQMp0iF
         ycqRwyU2mJb6twQq3ZVkSQ0Ue74c5CHPYo3KC6IXpPwS2TUiYVNakdD2/Ey2DEN8qEcb
         FNVRlEaxPipj+QYPcAkolClWSwp063d8t7G76h4ZSwvkFcBC4L1+g1D2ztZsIewRYzCp
         +kv6ojchEXGF7tGOumvykFpFcXsgAMBDZq3PVo2k5M0dUFzbHAyS1LuR/EvOrmMzSa0O
         bhT7L0zAvgYdilZz0CLzFL+SN3JXWuhM3ecpkxREz8QJITMJJVy8g49ApsPB+shUeMYk
         lQrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKIsEdvjD0k/NQMG0YC1twwY6cC862B8RNBr0QLIsSyPyLbKXEovEwi2OIcOtC0xmFnt64/lS/N4hKH1aCsg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEHTJejq71fq/A75xmTiUStpqwjIkaNR//XJff9/lTAPMb9QIq
	4huf+hX0ghyBCFKFBIn43EEkhaiDN8LhwQX43rbiHDFm64TDp1QM5gCN
X-Gm-Gg: ASbGncs2JT4BNQunnypZMYuzhogSjtmHqU8IGegNnnJztq4RnAKprw5/0ULHdCrybHi
	rR3Xa34bfV92UG/iTM2H82sxtFQKz9JFPJSF6nj6GkMR5PtLzgb6Uca8wxRd3nxZYXJeoKnfofu
	xNtksjrXGluayF49n0dhHGf1aYi/6WREXtFBc8bEtaRl2T/6tdUqh7zYbSaKGNOGYdw8y1lIXIs
	0Ry2jXaQR+djUdkEtpK59qnB7lN9ivR2O6EjSHpeIpb/si4KNIJu+/7P15q0Y0hTmliuWrwARtr
	1NgIFS/YLzyXnVai3ymIH7MatvgzqS2Egmt5k1bdy5s=
X-Google-Smtp-Source: AGHT+IH4ynIKhX0Q/W63W+KiOzYy2HiXf351MI+w2/z045fkfOry3JXmUePfhPVwSC7VlMVwFg7M1A==
X-Received: by 2002:a17:90a:c2c3:b0:30e:8f60:b4c with SMTP id 98e67ed59e1d1-3110f30d933mr19804287a91.16.1748326494695;
        Mon, 26 May 2025 23:14:54 -0700 (PDT)
Received: from localhost ([240d:1a:f76:b500:4431:46e3:c76b:79bc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365e5bd3sm13413809a91.37.2025.05.26.23.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 23:14:53 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 May 2025 15:14:50 +0900
Message-Id: <DA6Q0LZPGS2D.2QCV889PQL2A7@gmail.com>
Cc: "Mauro Carvalho Chehab" <mchehab@kernel.org>, "Hans Verkuil"
 <hverkuil@xs4all.nl>, "Albert Esteve" <aesteve@redhat.com>, "Jason Wang"
 <jasowang@redhat.com>, "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 <gurchetansingh@google.com>, <daniel.almeida@collabora.com>,
 <adelva@google.com>, <changyeon@google.com>,
 <nicolas.dufresne@collabora.com>, <linux-kernel@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <virtualization@lists.linux.dev>, "Alexandre
 Courbot" <acourbot@google.com>
Subject: Re: [PATCH v3] media: add virtio-media driver
From: "Alexandre Courbot" <gnurou@gmail.com>
To: "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>, "Michael S.
 Tsirkin" <mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250412-virtio-media-v3-1-97dc94c18398@gmail.com>
 <20250526141316.7e907032@foz.lan>
In-Reply-To: <20250526141316.7e907032@foz.lan>

Hi Mauro,

On Mon May 26, 2025 at 9:13 PM JST, Mauro Carvalho Chehab wrote:
> Hi Michael,
>
> Em Sat, 12 Apr 2025 13:08:01 +0900
> Alexandre Courbot <gnurou@gmail.com> escreveu:
>
>> Add the first version of the virtio-media driver.
>>
>> This driver acts roughly as a V4L2 relay between user-space and the
>> virtio virtual device on the host, so it is relatively simple, yet
>> unconventional. It doesn't use VB2 or other frameworks typically used in
>> a V4L2 driver, and most of its complexity resides in correctly and
>> efficiently building the virtio descriptor chain to pass to the host,
>> avoiding copies whenever possible. This is done by
>> scatterlist_builder.[ch].
>>
>> virtio_media_ioctls.c proxies each supported ioctl to the host, using
>> code generated through macros for ioctls that can be forwarded directly,
>> which is most of them.
>>
>> virtio_media_driver.c provides the expected driver hooks, and support
>> for mmapping and polling.
>>
>>  This version supports MMAP buffers, while USERPTR buffers can also be
>>  enabled through a driver option. DMABUF support is still pending.
>
> It sounds that you applied this one at the virtio tree, but it hasn't
> being reviewed or acked by media maintainers.
>
> Please drop it.
>
> Alexandre,
>
> Please send media patches to media maintainers, c/c other subsystem
> maintainers, as otherwise they might end being merged without a
> proper review.

Sorry about that, I put everyone in "To:" without giving it a second
thought.

>
> In this particular case, we need to double-check if this won't cause
> any issues, in special with regards to media locks and mutexes.

Agreed, I am not 100% confident about that part myself.

>
> I'll try to look on it after this merge window, as it is too late
> for it to be applied during this one.

Appreciate that - given the high traffic on the list I was worried that
this patch would eventually be overlooked. Not making it for this merge
window should not be a problem, so please take the time you need.

Cheers,
Alex.
