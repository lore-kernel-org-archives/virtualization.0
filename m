Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8727E216387
	for <virtualization@lists.linux.dev>; Tue,  4 Feb 2025 17:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738690527; cv=none; b=k9qhtxoStw/0ry52+zaYq6IpIabSAiIAAGbphDfd637EMn42X26xGtcmGrBf+ICJcLwLqKBQE9wPF1FefblbqbayOL3pDLi3mHFdBticeyHpctXfr/Dsb5xi6L4mh7nIkop+jIKzQBtd/dbk4q/045hq9yvCru6Ii3SzwwugoFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738690527; c=relaxed/simple;
	bh=zCHNKGA6MIC6IBXzZGco0x6H0vkuSlEA7G+5gjB5WwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QkggQFklhHxue/v02sI0xj0Bhm3F7qkZlpCS+xpUlSZklRZbLgrwFCo2LUPyssfTXZ79otZgbdwtky9672wTLAKxhUC1Epai4VbHBVxfnS9Zp4ZAOtRDz5XNgIe4Giw8n94l6I16zyzxst3QRKc5808U5KAulPwFeszvkM9HPlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rPDXgcfE; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rPDXgcfE"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21f032484d4so156145ad.0
        for <virtualization@lists.linux.dev>; Tue, 04 Feb 2025 09:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738690525; x=1739295325; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84XRGI+7lwmGL6GUPwbtH7AhjEYYUVi2GeiyJJ7VXBw=;
        b=rPDXgcfEdxPus5Y45tgjQmLSJpl+Y8VmtNy90N6s3yw3gyYvW3gLbx3PGhFQoteVtR
         qmSM8JbxD8iGoU7UA2IUek840jN1FYyJWQK7JJDdOi97j9gXSJ1WwngDApL2CDD8fMtR
         0c6aehzPSvb4M3rABQ7K6cdMEZUVP/qBY3+02wSOEFOHMFD7N/Ht2ATR+FeikvMPLq81
         HPM5N3tfSQXS5jgA84zBthB4HxiqgeTUNRJN0BBA75kNfHe7B4j+hyZ3M9/7/ySMW6n6
         xWecE5B9rdk3DktLKkRj9kpR9l+0mU7urvdO+RCpA257ghY0IPrP/Qfv5OWjJrvWeAvh
         eOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738690525; x=1739295325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84XRGI+7lwmGL6GUPwbtH7AhjEYYUVi2GeiyJJ7VXBw=;
        b=I4syAO1IwKWWFfqdJEasgfCwvwUbnnsZ/o3BNbFKTOtfPjdxCDAZ17Ut8U6k2rsmFu
         8IgaAoYe7pd4HB90i+wZ/HH8bie0CuTAbT5WgEpYiwLtrQCjSDj8M/939MetAdR82fRr
         bRHs3nEYPS9orQBCQDLwQc2Q8zehzAqKx77J4/IRpCZzqFWasFmxuli7ZuA6p/h18ViR
         NBnRNOuZw4wjfORQI6/4qws8pvQcETX26yMEOAJbvtiSHWK6oGFmHYup2PUQ6ZbX5enC
         c6wKBcg1E6Fh9PtZat3eHJziQmClQ0Q/qRimcyaYWRP/dssrOCx3vyvLi/LQ2CNIgFlQ
         qzZg==
X-Forwarded-Encrypted: i=1; AJvYcCXyOjcqbsV9TjqfGqHgf1FI18EwsKt7mRMLq9srP+8OulC669Dr9oyf7LeDIOts2x3eC99yjAc2Nw06L2IcCg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfzM9U9IPoH8V0o1bUAE2CXdLpWArh0LwsFNFX/lrOWzQpYEoS
	EusqHBwXkkHbjyBoSBJfox89wpM2XxcT0XemM0ZwAJJaGcZT8kpO3hJMbtNXc6A1GIjzv8q7yTg
	8eLyh1Jvj6Md3cqbkZz2tegGXWEwa9DCYGoG5
X-Gm-Gg: ASbGncvJDnAfpjq/gWPoPXpsGmFe8eJzBlBLruFC/tNvGpFWVjPdOmHtVp0VyQ6BBnZ
	f2gCL8VhZjjgcyxXLm+/xWlNdq8H4ckJG2D58bv8MY19ptxLilUW+5gp8+etwotF4tIgYuuR0
X-Google-Smtp-Source: AGHT+IHg8SF867Yy+z2GXbKry2r0iDmWlZunHewA79883dWtyyKDj6PGknuUr+EeJwHqGa1SQwzcF0gj8w2TziRSjaE=
X-Received: by 2002:a17:902:d9ce:b0:215:7ced:9d67 with SMTP id
 d9443c01a7336-21f005bbe36mr3250755ad.24.1738690524517; Tue, 04 Feb 2025
 09:35:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250203223916.1064540-1-almasrymina@google.com>
 <20250203223916.1064540-3-almasrymina@google.com> <c8dd0458-b0a9-4342-a022-487e73542381@redhat.com>
In-Reply-To: <c8dd0458-b0a9-4342-a022-487e73542381@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 4 Feb 2025 09:35:11 -0800
X-Gm-Features: AWEUYZn1moYHmrXoVYPPn5psMSRlqxODAnsNkR2q6mSq4IS5EB-8iProLqujYec
Message-ID: <CAHS8izOnrWdPPhVaCFT4f3Vz=YkHyJ5KgnAbuxfR5u-ffkbUxA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/6] selftests: ncdevmem: Implement devmem TCP TX
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 4:29=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 2/3/25 11:39 PM, Mina Almasry wrote:
> > Add support for devmem TX in ncdevmem.
> >
> > This is a combination of the ncdevmem from the devmem TCP series RFCv1
> > which included the TX path, and work by Stan to include the netlink API
> > and refactored on top of his generic memory_provider support.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
>
> Usually the self-tests are included towards the end of the series, to
> help reviewers building-up on previous patches knowledge.
>

I noticed reviewers like to go over docs + selftests in my previous
series so I thought I'd put them in the beginning. Looks like the
gambit was not welcome. I'll move the selftests to the end. May also
move the docs to the end as is customary as well.

> >  .../selftests/drivers/net/hw/ncdevmem.c       | 300 +++++++++++++++++-
> >  1 file changed, 289 insertions(+), 11 deletions(-)
>
> Why devmem.py is not touched? AFAICS the test currently run ncdevmem
> only in server (rx) mode, so the tx path is not actually exercised ?!?
>

Yeah, to be honest I have a collection of local bash scripts that
invoke ncdevmem in different ways for my testing, and I have docs on
top of ncdevmem.c of how to test; I don't use devmem.py. I was going
to look at adding test cases to devmem.py as a follow up, if it's OK
with you, and Stan offered as well on an earlier revision. If not no
problem, I can address in this series. The only issue is that I have
some legwork to enable devmem.py on my test setup/distro, but the meat
of the tests is already included and passing in this series (when
invoked manually).

--
Thanks,
Mina
