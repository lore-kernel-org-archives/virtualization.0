Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901422FB0B9
	for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 21:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764193569; cv=none; b=U/2Bg+zamlf/MgOrpVbGtPstp8qfLsZjYlPfhoKNEMy+WIpPqwu8O6HdHJl2OQ3Blq9prNri9IhMr2MdE3bG0uHtAsgfzkdr3RtUx1C36G7GPeKRVYbz2Awh+lvVFPgced2Yt7l3xGohXh3iuQ40VGshI0QRAmHfzhCZe7YAwsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764193569; c=relaxed/simple;
	bh=eHQD5ZWYTKJ5pBQ2l+KQFGoT1AEPijvyxf4X4cwZ+8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDRIgFaQIKgyO0/4uq/dP66r4vHN8rn2GApnRJgdLV23OqJIEgCtYgpDE5D1cRPPsZ0BmC8HZ3mJrPOh1ScQham4Hkd4N9qIVtqjEYSRhcuyJ5H/zoZdufVgbdsjmtqIWj8pCZgo+5ADbLtDI9olNpVP8Ub6fEwVt11eBNRFD/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cZ8nz71+; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cZ8nz71+"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b739b3fc2a0so37340666b.3
        for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 13:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764193566; x=1764798366; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DR4A76Dv8qf/+6WmZVEh6koqxlO2WxAmz56oNgGMFDY=;
        b=cZ8nz71+Yn6WaE3cu1gNFiGqfreFrbfYtYm6EVoQlIobH+YsOrAaEkdz7teIr1868u
         6BUyle3edod+BLkuQ4J50lz4yNvzs2O8Y93RGgGTLgiiWKLlFvCv624W1FxCxK73yiIx
         ujnT5RqCeuY0B4aXaMADkitrJLMGWluOfjJRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764193566; x=1764798366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DR4A76Dv8qf/+6WmZVEh6koqxlO2WxAmz56oNgGMFDY=;
        b=nO3Jcl3gnFlTqwD8JRZPpXBoTWYj4aSpDYveKkpBdzM1tlxmzFZ+SRn8+UNkbzrytZ
         J3YYywm2ICUVIVfcDHwRFWcv5RnpXrLf9uvec10rPK0WiW0kWE+co7AwgZD2obAUiLyK
         3IsaTIh+O2RHgGe5pvSWx9fRJ+p2CnnTYvrlhaNhtT5ry1XF4ttrom3tC93TEEarFsno
         NjPgamOq+pRYRjkPxA6sG/D0IxCUa2MleKTGIN1mkGdMG19Z3d/yNxZkIMicsdHDr46Z
         ZscGhd7w6/9gKjKP4aU3LGtQxbDS0N4IMMeYDUxquimwnpuXfJtTHng9SCKJPVArjQ7B
         Ttiw==
X-Forwarded-Encrypted: i=1; AJvYcCWTnEz1FVQQPgAahgQLPE8D+PwsgUhZinpntuzsW9WEc3g8cGG2IztNaSsRBKBsiICn49dn6cy1bsYwFu2hFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwLmKAqxDSw8qhVzGCJqYR5afk0f+a0n8o+O6sDq9BbUIIayBR8
	SxbELArwOfIxOCSo/KdHNhosWFKNcZ5mbo2n4joS8OUNqyoxmO/Xmk33BB45p1FA4KLuqfFTgVY
	esY6sFLW4/w==
X-Gm-Gg: ASbGncvSqQhsVaFsO83Sbyls3oiTAj+JegMZpJ8KTzqpP0AlTJnk3lLwXDr3TdLb979
	mN4cAo20RwejTDSW3rLhSQ0EHJQLSeSRGOXV8BvpT1ZmmheokQDr29OtsyS34j0HPBhI+WVB6yf
	JkTkbMsaK0c2IWTyII06rh4xh2js1edUK6ZzDNppKSvssiIT60+KTgILUMk/gzJac6F7aDgM+cD
	7tzBhgEIvz8M5/tE5T9k0EzGlbQteaGcjI81uGU9sUS7rKJw4kRu/ba8aMY9EH8UXtF/1CM3Fha
	eL1jCZS7LHanR1MXddjOxamdvMJdeV3rQCIgeZOWNJ7gcJFCGE5tq/3eLw5IvPwWyY6koCnQARm
	S8joYuobPcR6Jt1dvSs1kdo8WdRD9qqyFa/6JPCsC4GHnQ59suqMi5AIkx597W8M9yHfxAi4tvB
	Rhm1OLHaVx0jqFzRov4xkPbb0Ur1oKKyIz5jWc1JIulMqjRr7DcZQMztnGOPjw
X-Google-Smtp-Source: AGHT+IFijyxd4dcYEg1ljz2A6hdvrBH5d9jvVJCsdpKmpWpBARvwYhJNHm5DuNmPiqGGDZ92314/cg==
X-Received: by 2002:a17:907:782:b0:b73:8639:cd96 with SMTP id a640c23a62f3a-b76c53c4adbmr837249466b.24.1764193565696;
        Wed, 26 Nov 2025 13:46:05 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd43b1sm1955358366b.38.2025.11.26.13.46.02
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 13:46:03 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso412794a12.3
        for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 13:46:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW5+A+PjLkSVJEoi+q1zTbnF825lzFW3NueYp224W2gG5LHCCQ3ba+mfyWm3bcRxGZ4JlqQ1j+6dj030QW6fQ==@lists.linux.dev
X-Received: by 2002:a05:6402:13cb:b0:640:c454:e8 with SMTP id
 4fb4d7f45d1cf-645eb2b7f7emr8102794a12.30.1764193562184; Wed, 26 Nov 2025
 13:46:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251113005529.2494066-1-jon@nutanix.com> <CACGkMEtQZ3M-sERT2P8WV=82BuXCbBHeJX+zgxx+9X7OUTqi4g@mail.gmail.com>
 <E1226897-C6D1-439C-AB3B-012F8C4A72DF@nutanix.com> <CACGkMEuPK4=Tf3x-k0ZHY1rqL=2rg60-qdON8UJmQZTqpUryTQ@mail.gmail.com>
 <A0AFD371-1FA3-48F7-A259-6503A6F052E5@nutanix.com> <CACGkMEvD16y2rt+cXupZ-aEcPZ=nvU7+xYSYBkUj7tH=ER3f-A@mail.gmail.com>
 <121ABD73-9400-4657-997C-6AEA578864C5@nutanix.com> <CACGkMEtk7veKToaJO9rwo7UeJkN+reaoG9_XcPG-dKAho1dV+A@mail.gmail.com>
 <61102cff-bb35-4fe4-af61-9fc31e3c65e0@app.fastmail.com> <02B0FDF1-41D4-4A7D-A57E-089D2B69CEF2@nutanix.com>
 <32530984-cbaa-49e8-9c1e-34f04271538d@app.fastmail.com> <0D4EA459-C3E5-4557-97EB-17ABB4F817E5@nutanix.com>
In-Reply-To: <0D4EA459-C3E5-4557-97EB-17ABB4F817E5@nutanix.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Nov 2025 13:45:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiEg3yO5znyPD+soCkVi_emP=wHrRZk2sv4VS768S3a2g@mail.gmail.com>
X-Gm-Features: AWmQ_bkSLlyCoqZg3bYaZu1P_V2VILWs6lgJjJBJnYgDxxhAqc51xHDCsThFNYo
Message-ID: <CAHk-=wiEg3yO5znyPD+soCkVi_emP=wHrRZk2sv4VS768S3a2g@mail.gmail.com>
Subject: Re: [PATCH net-next] vhost: use "checked" versions of get_user() and put_user()
To: Jon Kohler <jon@nutanix.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jason Wang <jasowang@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Netdev <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Sean Christopherson <seanjc@google.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Drew Fustini <fustini@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Nov 2025 at 13:43, Jon Kohler <jon@nutanix.com> wrote:
>
> Linus mentioned he might get into the mix and do a bulk
> change and kill the whole thing once and for all, so I=E2=80=99m
> simply trying to help knock an incremental amount of work
> off the pile in advance of that (and reap some performance
> benefits at the same time, at least on the x86 side).

So I'm definitely going to do some bulk conversion at some point, but
honestly, I'll be a lot happier if most users already self-converted
before that, and I only end up doing a "convert unmaintained old code
that nobody really cares about".

                  Linus
