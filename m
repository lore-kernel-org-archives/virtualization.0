Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926325B211
	for <virtualization@lists.linux.dev>; Tue, 25 Feb 2025 03:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740453582; cv=none; b=X38Q6YBDPp9jKR4Xlt5QUUil8Jl3s13Vr5FXBMwppj4euTGylEfH6TP2n3NjdkQPfmVd9sGi2IW2bOVzZa8V0odYq6X9CjvPY7HeZbao5NqAO7rcitLS++TOXnC+jZa3Qctb9AO1xTcRzql1nUGMwifClmm/EOSB5ND10ykFAA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740453582; c=relaxed/simple;
	bh=KmqJ5UPyUn4QKWhlPOJYvXUy8SdtTAvRkRSjnFipiZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdOxvSOCSCJ4kI9FRNjHfmtG2J/6p41Y9cHvNzmGDVxdoLlI4F3EKXDW6h2hfuXDnSpdrR3smq0yUyrT+cCDsksluHpIFMYGeViG9W1FPuOv9KONux4gZ5rQJ5wY4x/feWJLY0eNlcjKLJ7vs6geMTaiF8TIbJ8EqfnC7/wqKcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fnxb/AFY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fnxb/AFY"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2212222d4cdso81265ad.0
        for <virtualization@lists.linux.dev>; Mon, 24 Feb 2025 19:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740453580; x=1741058380; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SG0vPvDkU+Cn7gEuriL77ttwykS6l1lmqIssAkQWxSI=;
        b=fnxb/AFYP0621NZC77u6DtZyE/Te8KCG/aNrARu+hs4EzipA/52z0HKAP4VCI8G6tY
         rfYpoA/YqU8Fxv+1x9F9MhEaVs27n/ScLJhxjqN77Z3cOh01gHJWXYc5QDDmf9izwQAR
         i2sP8MaG9w9wncsHuElBxoRVfBaZsVejqXSgZUUcObSKi5QZIIrlKV3Vfjfko83pimWA
         NG3hYKlCT5PGZBC/aQXKuRUREjqCQeAYLdRaikjEbMGrzWYINqa+a7sUXVh6zrJYh9I+
         0NdXa/jjQH+o065koITOuhBZyU5A0barG8w6cBW+Fz+VqofLhUQBJJa0+r1RIClYbGby
         qpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740453580; x=1741058380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SG0vPvDkU+Cn7gEuriL77ttwykS6l1lmqIssAkQWxSI=;
        b=bToEaefof3Y+QcY5W76ajxp2KhddOnBUPypQBWy/FSZHlX25wk2c06eYpllfnN5Vr+
         xBfIkKf9Sn/BPYm+kU8qD+LdmyfcK6cyAKZyOK5mAeDg8x2WABCENPWv+Cwb2QK97Tt4
         SnVQvWCsV5FtvDnBZdE4S+LPaB8WiWKILG4HqmQnJWRZpw8LGmcf/nDxzKYAoyW0k3Bq
         Kkg9SQXvtON6dl8I8T8/jK+S+GGlOHgcEjFpYDTLN9zfDzvvjqdqut7CC2ZswRDpKx2g
         K/l1eDoxgSLdxQzNB6fv6nX6LrJmfvTmRsLClb5cUrHoFmoURS2I7HzG6R2gaCMMk0wq
         HnGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv7ZajpTck0PqfMS/9Y4MwP6Z9CJAzxUjb9lXtpz008ou0CXoinPqKxpPAbOlT9pEJWq3JBVj5+Vv+40RDew==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx88ZM2IAvnfyBoxoHRRuG00u6QIZmKE5/cUWuaX1m1SG3E0K1l
	lZjIRC8oPHYvh7mUVcHG0jRPWOOeAFHaXNIo5+W1+lsSPloLPBVX4eqQQfDhQiCSkscXjEKxBo7
	M1/8L3+YGl6rKhzkO5frtnrLa1YjhM9pa2g8k
X-Gm-Gg: ASbGncvyxp2JwaEzrcngijSB/CONsTKZG5wtnZHF9mPDDP6Kktvc3RK4XFuZFXyzbxR
	9CyxjJSR9lIRp/lAbLyEpaTcVsy0l70B9M4gHjj1xVctBQJEeADwIU3HH/QOI5X+46jxn2eg1rg
	+7rRlu/kI=
X-Google-Smtp-Source: AGHT+IEtZxuCVd0tnzxcUGZ4gQTicVs14GYdJr0CNhWdXPCDZapgO9XyLPZYzQJgLaG9UA9AQIHRIeLixV4juXWMkIc=
X-Received: by 2002:a17:902:db10:b0:21f:2306:e453 with SMTP id
 d9443c01a7336-22307a3d994mr1928995ad.7.1740453579681; Mon, 24 Feb 2025
 19:19:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250222191517.743530-1-almasrymina@google.com> <CAPpAL=xvVYmiekEkQZO314JczbNK3kf_2Sw=15crgjQLfzQU4w@mail.gmail.com>
In-Reply-To: <CAPpAL=xvVYmiekEkQZO314JczbNK3kf_2Sw=15crgjQLfzQU4w@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 24 Feb 2025 19:19:25 -0800
X-Gm-Features: AWEUYZkE739kPYOS1vvRcfM-p2BwFYz8vTlR5KcbwCGeAbQzIBCCJ-WS6P6ifgA
Message-ID: <CAHS8izNtGrMV+6T83-tNGpXsFqLo5N5jZpHueZ=SkDZ24pvKsw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 0/9] Device memory TCP TX
To: Lei Yang <leiyang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jeroen de Borst <jeroendb@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 6:54=E2=80=AFPM Lei Yang <leiyang@redhat.com> wrote=
:
>
> Hi Mina
>
> I'd like to test this series of patches because these changes are network=
-related. But there was some conflict when I tried to apply this feature. C=
ould you please help review it.
> The latest commit id which I tested is following:
> # git log
> commit d082ecbc71e9e0bf49883ee4afd435a77a5101b6 (HEAD -> master, tag: v6.=
14-rc4, origin/master, origin/HEAD)
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sun Feb 23 12:32:57 2025 -0800
>
>     Linux 6.14-rc4
>
> About conflict content please review attachment.
>

Thanks Lei,

Did you just want me to review the code in the attached file to make
sure it looks good or was there a merge conflict with some repro steps
that you wanted me to look at? Or you do have a diff of the conflict
you want me to resolve?

The attached file in your email looks like an exact copy of my first
patch in the series,  "[PATCH net-next v5 1/9] net: add
get_netmem/put_netmem support", so it looks good to me.

--=20
Thanks,
Mina
