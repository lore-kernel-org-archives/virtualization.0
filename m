Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FC985C5E
	for <virtualization@lists.linux.dev>; Sat,  1 Mar 2025 01:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740794019; cv=none; b=Taw8zYa73djZzN5PXXuIAj8texKItC6uDBrJ8OJulinkDiSmW1o1cjURm50utPX++CUjEhNtARpUxr8XR62IGqfoZYx6MH1q9i7DnqFoScLmt/j8IThhy1iHDc6sCPpmCsFNY0xm15312Sv3j03A1+VVAqchw8Bv9tvtIZciwPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740794019; c=relaxed/simple;
	bh=EKuULC55HQ3nbCCUfqRw7VZYjnjWI4RwxZ9r8CX/fpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXz3Ajy2KSsonw/pnBPgBBEBcGwNaYw2Lb3T4nFmQ3+DC19gTzzsRujaR+/hLl5D3p8d+2Bffym1hKzOAQA3MTDV6Yq+8XUStnZerMGMroTvjzlFzrw+RWAFjO38dsBaoI0BEdPD5KwJYJEEqa8HVXKSQTF4FCBZjVa1/a4zWmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HEWquWIr; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HEWquWIr"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223722270b7so39785ad.1
        for <virtualization@lists.linux.dev>; Fri, 28 Feb 2025 17:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740794017; x=1741398817; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLgNKvgK3MF8wXxYtxDEojHg1VBQZqgwWDhEQT1JUUI=;
        b=HEWquWIr5WRI3lgUlEtolStnNgmSZaavM3T/yg9EhnW3skytLgElBtoijwQ+FIV5gj
         lGmkX9iKg2dkYWn39N1eRs2VyJe/RpyPZ6ARTxQKAh5//7PZ6wMwKici07PVsY0YaOPH
         SwDwWWXzbti5i/FDyAVbRBN4l52vzdCkhC9XIDtyACHQXomlLRhEgNAUIF2WQetacEPO
         fNCNpNkXf5klmKZilV8ALC0+Anasfr2WLCpA87N6YKcoL89sFDKNPzqNNSKWyLUEWXf4
         nWNEbEDjNLn9uZ45cp+41zx9fQN5dHtxIJZhRDpPHf7lAmzom/N5vMpQ4de8JvFvfQO5
         NBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740794017; x=1741398817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLgNKvgK3MF8wXxYtxDEojHg1VBQZqgwWDhEQT1JUUI=;
        b=qf6CEYUOsg3Ji5jQAmb1OwxO0nFeRnldo1uZuVJ/RGI6mHb4c3Nj6W9vnW/8mLMPE/
         cLI7Hy8qqhIm51drnDpq5XBxtRCegHfh8tHniq34KL7sMXFFNQKo2z3JszShVVYpwPCb
         d8aFKSdUm2zk57aVk7j0LK7xMZPpjf8yRgmmSM1ARE1B9B2RYNbtJs0PfXQoYlS7nqNB
         rBxiKHWeahPyB7+0g2qc6DbLdW3gT59f0X1iLBX5woAob8mm7zfHD1YIw60jJ7J3dSuY
         Jlz6v7ZDJzQMUeTA5IC0Z0oleBu3sqnEPZUY9HqyOHpnJreInB6qnSCUVZCsDNwy+66+
         Nngw==
X-Forwarded-Encrypted: i=1; AJvYcCUc9lHv5Lwht19kMBOBKj/6DSshjFL8wKj0lHX3scSfYvBlvj1OljspxlQ96IRYX06le6Y8nanKzKsTgFHSHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZblnvubIu+E3N3fkaSQ7yeH8IXYqkTM14+F1WBmHT54seflx8
	ga8g6Qych/dEvgAiCLRSrBYRybVhiv8BlU/MDUO3s6gk8nrkSokrYkAXaCVQeWE9ZZBJZjkjGLR
	uSbcw+PkbmuJqhwyotAb0/yryhFL0kKkZAKO/
X-Gm-Gg: ASbGncuUHZ0g4BtjMWIc7MgQfAxxxhkscw8t3A1QvqRDYJbHFore94Cpzd5mHZel62R
	cSikk1NC/hgRc17ZxlS1O64JZnq3kXoqFIBnIBIKNUUGli82/gI4uwtREpL30WsGiYrZKwRj1IW
	ZTh+wa5BbT0uvc7YpyUySaEQzCGA==
X-Google-Smtp-Source: AGHT+IHKl2PLDaPwJZ72jov+1EwCLnYkzTru1UwRQte3i8ZHKbDpflK/NcgLRYMjS26dyimEoNSydoGDDo9IEsABteE=
X-Received: by 2002:a17:902:d4c5:b0:215:9327:5aed with SMTP id
 d9443c01a7336-22383684e49mr1174475ad.20.1740794016936; Fri, 28 Feb 2025
 17:53:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250227041209.2031104-1-almasrymina@google.com>
 <20250227041209.2031104-8-almasrymina@google.com> <20250228164301.07af6753@kernel.org>
In-Reply-To: <20250228164301.07af6753@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 28 Feb 2025 17:53:24 -0800
X-Gm-Features: AQ5f1JqJZCsnxITjcDH7bL98xxwfM9Akmi35L149mBq-r5HqPUJRq4YCYmUnRBY
Message-ID: <CAHS8izO-N4maVtjhgH7CFv5D-QEtjQaYKSrHUrth=aJje4NZgg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 7/8] net: check for driver support in netmem TX
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 4:43=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 27 Feb 2025 04:12:08 +0000 Mina Almasry wrote:
> > +     if (!skb_frags_readable(skb) && !dev->netmem_tx)
>
> How do you know it's for _this_ device tho?

Maybe a noob question, but how do we end up here with an skb that is
not targeted for the 'dev' device? We are checking in
tcp_sendmsg_locked that we're targeting the appropriate device before
creating the skb. Is this about a packet arriving on a dmabuf bound to
a device and then being forwarded through another device that doesn't
own the mapping, bypassing the check?

> The driver doesn't seem to check the DMA mapping belongs to it either.
>
> Remind me, how do we prevent the unreadable skbs from getting into the
> Tx path today?

I'm not sure if this is about forwarding, or if there is some other
way for unreadable skbs to end up in the XT path that you have in
mind. At some point in this thread[1] we had talked about preventing
MP bound devices from being lower devices at all to side step this
entirely but you mentioned that may not be enough, and we ended up
sidestepping only XDP entirely.

[1] https://lore.kernel.org/bpf/20240821153049.7dc983db@kernel.org/


--
Thanks,
Mina
