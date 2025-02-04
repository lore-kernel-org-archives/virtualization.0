Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C55F217647
	for <virtualization@lists.linux.dev>; Tue,  4 Feb 2025 18:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738692229; cv=none; b=ml7YRx1QEXLHJn/Fi6O0QNxwgkHRdpbcAt6GlslY34BgX95aQUi8XnZGk90knAGVtsGae1DJiRadLmY1FlltoAGHiSrFnlmZFzdlWGpN1Kc1dkQNtBMgc6pdyM/Jcd77n/RAI1SssIgUN1s0N3KcXdJ+6Ikiw4Ms4VWxuROZzUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738692229; c=relaxed/simple;
	bh=Oj0oNLn2yL6+fmX5W290/5q7EprAS3GBOQgkRODPBVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZkGqzc5UT4uGodHZZlKSKIWPvs1NKUw0Z/n1r1EpquYfbRtVxWiZ7IMD0ADv3KOu+4qCYNzstapof93DXq8G9DFuxRfPLQtDGTtKffnDThsYFaDb8CSP8kKbBrhu7eTDvWx4pxQQyJ3/2+fGWc7C+P6K/oQndzngcTtOfrMZUjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LWXGQ+yX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LWXGQ+yX"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2163affd184so146125ad.1
        for <virtualization@lists.linux.dev>; Tue, 04 Feb 2025 10:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738692226; x=1739297026; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnKb/NxDzwUPz79zbu5N/Xfg9BKIOLMoGS4rXOX07CA=;
        b=LWXGQ+yXZf2IADbB/OmAOdUGfpSTLjvBt+K938sgXMUwv+5lQ+FwHQAo7a/BLG90sB
         +bCxQ9gaFlh5e9QKvX6GphY9y7Gx7zCPcXI+bzClhcpX4PFHxqZ+78SsfCPMIkw5V0Py
         +z7WYkD4lWNHqf1gMjkLlZEWRjlwSdBevBl86uocyzyfuC40N3uPMgPb+aUV8ctJ+AAm
         e283uYDJVxCqqAH2NqL/cld6O31CFiHcOCNqnB6Zk+u2P5ZlhI2+bb0I9VSHj5fZPJhi
         j2OtX62HzKwjCQtbERThogD5HJqTBeqpywANLqwcTlvO1ykGSvKPqHeKXLSdvCidMBkU
         ZZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738692226; x=1739297026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnKb/NxDzwUPz79zbu5N/Xfg9BKIOLMoGS4rXOX07CA=;
        b=UpQ1FZr/s1hqcQQEE0uDQ7vh45Yz4GBF8uyXzBpVIAUlQsBKsj/VKCF0124D+TBHsS
         aTLTVEyJ5TXYWKwJSAV+uO3rEVdMazCnMrykjd4XObA9HY+8LdjGW0B4bfnwEC7ItW3U
         3WS7HTDGI184OZPz7jDCiZBnPiFseKgtzySzYlt7m4hz3rdObsuLgn5xlm0ryeZV0JSs
         YRnB2ULGHy5ccf2Yju1LNBj2nlFcq3IVAA5PjtMEQvjRabsQdNeIDP0tbdFtl8AOOdtP
         3v9Li3eOChgcXeoFUwS64lgB6dHRIfExmO5GIAbd3uchZpsQE2lRsaj6jYVuy+7HYLTu
         5C4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWl+8nzCjYl9uDBgit1h3g77Jt1JkpVGKlXE8N3PzSu7+qPoydtl268Y/+RFt9wFC+R4hyqbgFZBmY+S6gqcg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyEtvQ2YRhmPa4IESvHe8BlzG9ZMScwecz/0yiVygV5LZvJI9rB
	RDlwSQ1gHLbTjcqOTZWtiHJnSqzLtXU+qshrWyjsr53R7BZa6c69qZhPsPsSDyUKZYx/0K8gkkR
	Ae4DUyss4DGnG278j6OgkpzY3ktD+TaAisKZH
X-Gm-Gg: ASbGncvV/+iZMwLrdU+x10C0BwTcr91iIQkmHzhhs15Pp5UQvN5N2s8pSkbloIPpQCD
	PAmqiz/IJyPgsL7f+j8M4G9LkONarRhmFlN0rnHfHpknHLNo0JcOJzsNiJtuDq3e+Of9qqPBF
X-Google-Smtp-Source: AGHT+IFGO0WVuOzQMwTOIUL2zNV30YHnBBx/izI8+SQNwu12kEXS3uYQZz8FhcRE8mSTIdjM5HAUSbAmJ4VB9XKoqDo=
X-Received: by 2002:a17:902:bc8a:b0:215:44af:313b with SMTP id
 d9443c01a7336-21f000c1a2bmr3663845ad.0.1738692225592; Tue, 04 Feb 2025
 10:03:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250203223916.1064540-1-almasrymina@google.com>
 <20250203223916.1064540-3-almasrymina@google.com> <c8dd0458-b0a9-4342-a022-487e73542381@redhat.com>
 <CAHS8izOnrWdPPhVaCFT4f3Vz=YkHyJ5KgnAbuxfR5u-ffkbUxA@mail.gmail.com> <71336d4e-6a75-4166-9834-7de310df357e@redhat.com>
In-Reply-To: <71336d4e-6a75-4166-9834-7de310df357e@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 4 Feb 2025 10:03:33 -0800
X-Gm-Features: AWEUYZmiESSMokFwGB0BJqHNhJeqNgHpu960zdUgGcxEH4CFZhDgvoFYnYH4I-E
Message-ID: <CAHS8izPFe-1tf9Xetc8Znj04x9rKXVchR3DaspRGPDRbSFQFgw@mail.gmail.com>
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

On Tue, Feb 4, 2025 at 9:56=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 2/4/25 6:35 PM, Mina Almasry wrote:
> > On Tue, Feb 4, 2025 at 4:29=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >>>  .../selftests/drivers/net/hw/ncdevmem.c       | 300 ++++++++++++++++=
+-
> >>>  1 file changed, 289 insertions(+), 11 deletions(-)
> >>
> >> Why devmem.py is not touched? AFAICS the test currently run ncdevmem
> >> only in server (rx) mode, so the tx path is not actually exercised ?!?
> >>
> >
> > Yeah, to be honest I have a collection of local bash scripts that
> > invoke ncdevmem in different ways for my testing, and I have docs on
> > top of ncdevmem.c of how to test; I don't use devmem.py. I was going
> > to look at adding test cases to devmem.py as a follow up, if it's OK
> > with you, and Stan offered as well on an earlier revision. If not no
> > problem, I can address in this series. The only issue is that I have
> > some legwork to enable devmem.py on my test setup/distro, but the meat
> > of the tests is already included and passing in this series (when
> > invoked manually).
>
> I think it would be better if you could include at least a very basic
> test-case for the TX path. More accurate coverage could be a follow-up.
>

Thanks; will do.

--=20
Thanks,
Mina
