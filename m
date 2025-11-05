Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E13224B01
	for <virtualization@lists.linux.dev>; Wed,  5 Nov 2025 00:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762301992; cv=none; b=g09NvR0etfXF8tv022B67DeLlQcgQ7SUD099a6TMeW3Uw+rC3ZpnMwm+waDlziFIuxZ50nXaiVu5rViedo3j1waNRIzKK3fmG9+Fi/mN8zfZz82ztT8nBhC4iRoQmublCTJPAXNsv08BTETgVG9vfxx2ZOvFtIjpIx0y9hxmdDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762301992; c=relaxed/simple;
	bh=tPNyrSglXgzbTSxAtrtNr66B4b82eAkptaHPW68Y0SY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJOZkjp2If0z12edJJmn7V1DBHjkqP0rzBzMIiv50qFmcrOYEv2jXWta5bg8x+jBnYx58q6d6BC5i4JKhwT1b49xi5d4uRiyRv3B0xmzzhk5JmFTmdgeJFxbvbzGciQ7EcqkYr3sg/zk6QkLCt1z0h45Credmu4SYSZQ9vPgcZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkRN/Xm4; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkRN/Xm4"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-43326c748d5so1901455ab.0
        for <virtualization@lists.linux.dev>; Tue, 04 Nov 2025 16:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762301990; x=1762906790; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPNyrSglXgzbTSxAtrtNr66B4b82eAkptaHPW68Y0SY=;
        b=KkRN/Xm4pvvUl2KEGeEJC23Q7gxR2LFR9PWYOFuL+87UUm5Zu1+ii9SBLP1XqdW3KL
         9SKanE0h2tBPnmQ0cD9fEo1aVDuMdBR9XXvGfoHi8x1TeFpBCrpAqyeqkAanZh9Z4TLc
         u8cmrc/pQgycv3e1je7kfPJ72c/CCL1kvsWkQbZ33OHebvKMe3HbPvFTKjU5BgWH5hun
         RiI5IXkvDl0FYbumAOaaiUBu9AQ12zwVa6f+VeeX9ppPbHNA/asYe9EJNZmEvxSo/uzg
         wJ2esvl7nIbJYTxbVqi1c3UNS0hZCnTTQV+m8DjtIuJ7RUnLWVDISl9fET4r/YHZunsc
         QJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762301990; x=1762906790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPNyrSglXgzbTSxAtrtNr66B4b82eAkptaHPW68Y0SY=;
        b=xRaZ3WbEDP8fTe+32bwOHn8D1S62q/QPPT4nv4hJ1tXt1l4UBfxMt2aVLCDOUqDhny
         V6FskH6QbtojKcZ0s5XnNyKHAIoz6GihG5BEC9xC0NFyZ9plvLC6RJ6nJwH8hI/QNPUt
         pTbfnk/PF9PdTSS1HDs15X1iKybOgfWs63yg4EF5/kD764Rd5XyHvP6bhH2kONbyR9jd
         2UUgeXghSXx3i4z8LYzrbkL6GXFXZgWqcbvIP7YRyTxx0bmopB5a+lVvjpL+gkrQOVyc
         565Uk1JgSedHE2MMu1MOiCRlPjThpmZcBKA/50bbaL4ZLYKkF62zAqmtWpqflE5fVMWz
         X//g==
X-Forwarded-Encrypted: i=1; AJvYcCW8BbNsDU0IwYEm/+2Y2Y145fdHdTKCH87Ae0W/3eownZP2PyjrNKLlMUZohl6QshO3bWRb9xb8M+9rWtmi/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfsQ6QsK/XaCEObG2JWvML+PRIlc+mcM1ENGYLNYGyo+55dX6B
	5CRyOLRbLEgYwv9NVrZJhcwHABq5DOvTb77tDNdN/S4Js8dlxdvIYwmmWrfXaBIxoZNSmC912wh
	C3gG22XtAj2RKitr3CqyfXHTb9rTVvcw=
X-Gm-Gg: ASbGnctS8LVFt6R1FHsssOvXhltO4T86sv1PaJgeaJ72nk7eR0eXNJoaYi2MVqkIOoo
	iEHRjCCaRIv3H4U9+jRg8p29wNPfv0kx/2+eDipp+gLJgvabTGWA0eWXZntV4xZQ6FYnr6H13O4
	IUl49paQx6Yh/EThAPrYCWmyrtLMjMAOElPk1A0i7n3lKPinZ4ECI4BznCD/wvl2p/mIYkHTPS+
	2AbYnLJ8l6l8KaVpiVAsStMgPwUB5cdbQZhYpwLgJO4f8/QwXgya1iVdqqZbRQ=
X-Google-Smtp-Source: AGHT+IHlKDGDIG6BMqjPpmMiXRElX7CmlqHBVKFE5hB2vstBzsdvMVaGUbKSbC7UrpLHQfFggPSndMWaqnea6GXPLXI=
X-Received: by 2002:a05:6e02:1fc6:b0:433:37e9:c1ff with SMTP id
 e9e14a558f8ab-433401a21c1mr24512685ab.9.1762301990514; Tue, 04 Nov 2025
 16:19:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251030144438.7582-1-minhquangbui99@gmail.com>
 <1762149401.6256416-7-xuanzhuo@linux.alibaba.com> <CAPpAL=x-fVOkm=D_OeVLjWwUKThM=1FQFQBZyyBOrH30TEyZdA@mail.gmail.com>
In-Reply-To: <CAPpAL=x-fVOkm=D_OeVLjWwUKThM=1FQFQBZyyBOrH30TEyZdA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 5 Nov 2025 08:19:14 +0800
X-Gm-Features: AWmQ_bliMV8nE85ERHZI-EI4lokvoDwiY8yl4dOnlkgckxmIlBlgt3FBCpHKufM
Message-ID: <CAL+tcoAnhhDn=2qDCKXf3Xnz8VTDG0HOXW8x=GSdtHUe+qipvQ@mail.gmail.com>
Subject: Re: [PATCH net v7] virtio-net: fix received length check in big packets
To: Lei Yang <leiyang@redhat.com>
Cc: Bui Quang Minh <minhquangbui99@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lei,

On Wed, Nov 5, 2025 at 12:56=E2=80=AFAM Lei Yang <leiyang@redhat.com> wrote=
:
>
> Tested this patch with virtio-net regression tests, everything works fine=
.

I saw you mentioned various tests on virtio_net multiple times. Could
you share your tools with me, I wonder? AFAIK, the stability of such
benchmarks is not usually static, so I'm interested.

Thanks,
Jason
