Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D273F2D997A
	for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 20:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745354800; cv=none; b=ac0SClAJx6Tf9YZ/DG9FRNOUrR58nG4HYasv8v+wBqsWqbbjgaVjaYuOVSphEE3zq3nvILyMEBBNW0dkXjN/dGL8Ok4tHTCKrythfZ5O29gTOw9kijNnkuR2iEofXRolSWZRkk51y+uhkXueRQd1iUQKUVl+bYR/hnceBPiX4SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745354800; c=relaxed/simple;
	bh=AepzvkTaXC3tf015Trnt4kidHqKonWdB6m9AqTJB5Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4H4M+oBcNIhts4v7vdSZDliwPhGMdsxL4ZiXFvDHyNyfrh1nOprB41ggdnKm+8IG6uoon/EpujwegmCvGRsL5V7fGE1SQoAgSAwP9teALqgXPSZHgesAzz0ZE+qm2NpfRhjYlayDo864L1kgJ3STpP5piUdpmh4HY+VojU8ADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k9OM2iyT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k9OM2iyT"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2263428c8baso13365ad.1
        for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 13:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745354798; x=1745959598; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hbnVvENaVU3NRLrUDXLjqPtRsqZnanRvkC7zMsTFmw=;
        b=k9OM2iyTMtcPMasjZNuivzf6jZwX5cqL3gaVWT8Hf7LcdkwdLg0lzXPz2tZFL0vsFX
         QDcSVdMBnqlMAA2oX6kYvriudKxUz9ha6AstH9GWfAzqg7E684dXOONHQZee+aDawzz/
         X3Bs9Y2KYUhyFilaLtBwqtYPgT5Lo+U+c98Rgv348mx+tJ1m4zBvQ1cVqCa3qYCW5Afu
         6s45mVnOMucWLdC7B4pFpJzeLZxvG52tIumKHLfzkQIC9xitLSG9Ma6VQgtF88ASrHCw
         3+B6T91Oy5A/a3Kg0hXlY/8li27xuJBK5U0aBlNdji2tw+uBDyQ0AwnkC3wjAiX7wTpz
         rHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745354798; x=1745959598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hbnVvENaVU3NRLrUDXLjqPtRsqZnanRvkC7zMsTFmw=;
        b=tp0X8cxF8XZh/GwV1xeVtJBu5573Q5HLW0qrxvnYCkBZVjUQAYZBl0MsrOOqrNu364
         uQ5yycsBgs2hO/8Me5zpMcL9ho8jwutrSRjJ0uYcLbG0M6uvFhRQSqdUPYz4F2dR6G8g
         N/ApnClEziKqiUD62b8QJQBZBLn91RTv5XyJjVTZCCoZgxiEf5mJkkgBLd2hTmhEsBKE
         KAcLCYe8a8Hww5sEm7Y5YP/JY4GCnupuDhePJlH3MbgZHaiFsc7mTzHZXvRd/bUB3aOB
         8jh/dcjA479xFIe5DVa5EZlWL7BmdTzL2U3PLzfraapx9CT5Es4FqnfvI1+NkmCmrpcX
         z5Pg==
X-Forwarded-Encrypted: i=1; AJvYcCW/vReYnIW/dJgBRkyA/ovhnnSV9JI28lWG/w2MmjURTlZWjdZlDDGTlPUTcJaye4laY0D78Y5j0EfG2vptoQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxGiLOyjm2M7XmtlUHvUoyqBjOyrEVtFIkzWWh6xF8PALjrW7U6
	aqsAnTkiqkG6Qn9aRGy/Vp6ecma3jYobcMgYitN/X/Rj6rSmLHHUGUcpwf2OpN6lwJhng++9jhO
	uVyNq5TgM5vEKeDhAzp1WtPRS6sYBPWWydbsT
X-Gm-Gg: ASbGncsDYOQVb/xApTkGh3CFsltExJ9XEaOOhzMMpyGeHU3jtK4sBjTpJ2a9c2Z1kZ7
	GXyQe4SwyC+MN4jgQPmd9HQ0mGZIA/TZt+s75np30AKWHKoIdMGUULgx06Cp3UwqJ12ZaohDfMT
	jC3iqLj9Uih0r9eq5sAVTgEs1JUxZ6/LmZCa5qqAU8xKRuTsi996RT
X-Google-Smtp-Source: AGHT+IEri+jHg7nzBWYce/s95T8w1odDrVsc9bNQomfJRGLKE9zLufWZUYri8enjRiH0NTmCrON34chxcEP4+8+fy1g=
X-Received: by 2002:a17:902:f78d:b0:224:1fb:7b65 with SMTP id
 d9443c01a7336-22da2c3fe23mr741975ad.22.1745354797940; Tue, 22 Apr 2025
 13:46:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250417231540.2780723-1-almasrymina@google.com>
 <20250417231540.2780723-2-almasrymina@google.com> <f7a96367-1bb0-4ed2-8fbf-af7558fccc20@gmail.com>
 <CAHS8izMFxDG5E07ZdqnDH_2D_g1fW8X0M7u3gGyV8efzxDNZbg@mail.gmail.com> <5d2f86ce-e2bb-406a-8d53-58a464958d2d@gmail.com>
In-Reply-To: <5d2f86ce-e2bb-406a-8d53-58a464958d2d@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 22 Apr 2025 13:46:24 -0700
X-Gm-Features: ATxdqUFHY8ewiDnZPwv9bGxstV-8bLqJUqf0obD0wDTOy1se33mAidQpqaIoPl0
Message-ID: <CAHS8izMZbt=NAK0GF6VqJNBRKy+iZQGMFG+jFJEesbz=5RiLXg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 1/9] netmem: add niov->type attribute to
 distinguish different net_iov types
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 12:52=E2=80=AFPM Pavel Begunkov <asml.silence@gmail=
.com> wrote:
>
> On 4/22/25 15:03, Mina Almasry wrote:
> > On Tue, Apr 22, 2025 at 1:16=E2=80=AFAM Pavel Begunkov <asml.silence@gm=
ail.com> wrote:
> >>
> >> On 4/18/25 00:15, Mina Almasry wrote:
> >>> Later patches in the series adds TX net_iovs where there is no pp
> >>> associated, so we can't rely on niov->pp->mp_ops to tell what is the
> >>> type of the net_iov.
> >>
> >> That's fine, but that needs a NULL pp check in io_uring as well,
> >> specifically in io_zcrx_recv_frag().
> >>
> >
> > I think you mean this update in the code:
> >
> > if (!niov->pp || niov->pp->mp_ops !=3D &io_uring_pp_zc_ops ||
> >      io_pp_to_ifq(niov->pp) !=3D ifq)
> > return -EFAULT;
> >
> > Yes, thanks, will do.
>
> That will work. I'm assuming that those pp-less niovs can
> end up in the rx path. I think it was deemed not impossible,
> right?
>

I'm not sure these pp-less niovs can ever end up in the RX path, but
I'm not sure, and I guess better safe than sorry. We usually get
yelled at for defensive checks but I don't think this one is too
defensive. There could be a path where a TX skb somehow ends up here.

--
Thanks,
Mina
