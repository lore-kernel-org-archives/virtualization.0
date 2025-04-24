Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F086E200B99
	for <virtualization@lists.linux.dev>; Thu, 24 Apr 2025 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745490288; cv=none; b=KuwPwhuuNG6VuLp02RZhR/VfyyH0OxiGBeS3mab7WghZ/9RYbtXdhF9zcuOdr1RTKgcdOYFDVTYsCo+eh+Fxa+Xhq3P/6xkEZht4qdyvHie2wK5qmuY5pFk82p5W+Jax4zmrVx2yU6/3WzU2Z7lICc5bjDvi+U0lxb8q/jDqOmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745490288; c=relaxed/simple;
	bh=xRGlQ+YuAfq0yjKo537Wvq+MxdVlDxgBBdCxFEB1sqw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=l5wIc85qVtbcFA3WHNKC/w3eh4rM5OVEIZH+RT6I8yMjb8jBD+2d5xW5x4nRWkRzTzX+QPyS1a3sKFKdml03+1zYLkg0CTc7DwRU4GgZxL4ePGcIcvUpCT7JhBNuPj4Wn/pEAR+Sv6rVE9aAD9dsDFLXz4PC+0c6kGzFzqXFS/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnYrgzrt; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnYrgzrt"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39ee5ac4321so908698f8f.1
        for <virtualization@lists.linux.dev>; Thu, 24 Apr 2025 03:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745490284; x=1746095084; darn=lists.linux.dev;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xRGlQ+YuAfq0yjKo537Wvq+MxdVlDxgBBdCxFEB1sqw=;
        b=FnYrgzrtqe7V4IWQdhegOMpF1CQZrxuB9fV3IGOcnxzdS8GHZ/v4gWcMieFD7vIKMV
         nAmTGR3iN95vmncBQwwMuuYKW7toG7zGoOMcT0+fmx53K5eNJT7gkKItYDsj3LPYIT72
         w3Xr4tWiq2l83oybsDvgSu3XNxiWEjj1vhVPrrOJfhvi/SGHvGp6epE3iuVxqa1IwHn9
         rqDSQm/4L2nuuIBvXB04w9nPFk/DZwZgzADOh5a60YL7ihvRI3vBuCgG0TBrDx3Nxqv7
         KeDXz9WfCtFAOWZS3U31vMQRn/u5F+1Y0ExTEF6olW+plNu1SGopljjV0m76Gaqf906o
         cgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745490284; x=1746095084;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRGlQ+YuAfq0yjKo537Wvq+MxdVlDxgBBdCxFEB1sqw=;
        b=VegoqLsWp7CmdJrKaL4ZgWgq586246pPHgpM0y00scm1HKhD1gR2Jh/7atRa7Y9Vnb
         XlS6jSViEp1lJ1/g+cES2rtniKV6canPFs+Z1s56GeR1mgpM0YVkaz6BlfDtodpgWeRu
         6k89I6kiH5xahSzfCzm/0ImAjbZEV0TvyGU6AqJD0c8cH4343mVKBWMfonowm479v7Ph
         TJ/ppPcE242QXWUjab2vdnLZImodO6TPeqYX7ItmdxHy/RxqXxa71xmtQ6gAkF53AE+U
         nJfFCB8odUtb489jRWxlpHIzmek8uzv0TrLE+Slav5BFlG8NdxKX5dl3+ZVyqiXmiL/p
         YOQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX84RImT8GAg55Gzmn4kowyBJ3p2/Z2e9Qn9TykvDrYiW+GFssylxaTJ16TFFV0JztnGR5f9sK11+e1HkVf7g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyY9I7zFhiWN0kL/hE/Z7JyD6DK2EQe4wPfaZJA6BSgn8M1VYw6
	DNuzgExObosTaZbwEPyUpPDHl1z/y1XNPaP8hYr2rDp1OslRfEX8
X-Gm-Gg: ASbGncuLaTbiRWc8x0rnpOeIlEPx6vIoM66bDpUFQkRwb/4TfIe+iO3G4lNXz1q8q/P
	qebYY/6CSJL0APQKO4tiWtTUPWCIFT/FB22rjK+ktULYOyAWqEp94Zqc6Kkb/NO3vOaRvjfLQUS
	LZPVSPS3PV9ViLKoukRM9In5qTn/uDvNnQK5Wj8ksn/t1m5rYjDZR6kWoxnEyrtXzRRwYolB15r
	TtH4VaxczhtQ86Nz+PH8D42I1FrPfyAABrB2RN3N7YcndPGQ0E95T+5EuLq3/J5Do98nw7mVf7z
	l2T3x3rqcsjE+6fkE5uixsXYbRbcy2Qhu+Qrk4T2cRfFmd5OXBUbOe5umWg=
X-Google-Smtp-Source: AGHT+IHEb3DW07bLAA/VXg08jEDjB059mOzNk65AI9NhSRJOViAxq2muSv9evi1rARkf40X091csiA==
X-Received: by 2002:a5d:5983:0:b0:39e:e438:8e4b with SMTP id ffacd0b85a97d-3a06cfab546mr1827774f8f.50.1745490283934;
        Thu, 24 Apr 2025 03:24:43 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:7d34:7f0d:292f:fa10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d569b38sm1578696f8f.100.2025.04.24.03.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 03:24:43 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-doc@vger.kernel.org,  io-uring@vger.kernel.org,
  virtualization@lists.linux.dev,  kvm@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,
  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Simon Horman
 <horms@kernel.org>,  Jonathan Corbet <corbet@lwn.net>,  Andrew Lunn
 <andrew+netdev@lunn.ch>,  Jeroen de Borst <jeroendb@google.com>,
  Harshitha Ramamurthy <hramamurthy@google.com>,  Kuniyuki Iwashima
 <kuniyu@amazon.com>,  Willem de Bruijn <willemb@google.com>,  Jens Axboe
 <axboe@kernel.dk>,  Pavel Begunkov <asml.silence@gmail.com>,  David Ahern
 <dsahern@kernel.org>,  Neal Cardwell <ncardwell@google.com>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Stefano Garzarella <sgarzare@redhat.com>,
  "Michael S. Tsirkin" <mst@redhat.com>,  Jason Wang <jasowang@redhat.com>,
  Xuan Zhuo <xuanzhuo@linux.alibaba.com>,  Eugenio =?utf-8?Q?P=C3=A9rez?=
 <eperezma@redhat.com>,  Shuah Khan <shuah@kernel.org>,  sdf@fomichev.me,
  dw@davidwei.uk,  Jamal Hadi Salim <jhs@mojatatu.com>,  Victor Nogueira
 <victor@mojatatu.com>,  Pedro Tammela <pctammela@mojatatu.com>,  Samiullah
 Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v10 3/9] net: devmem: TCP tx netlink api
In-Reply-To: <CAHS8izNUOO-X0WHFTMd3_yEjCDu4sPYADE1oDEtWTYFNNMB5wQ@mail.gmail.com>
	(Mina Almasry's message of "Wed, 23 Apr 2025 10:59:17 -0700")
Date: Thu, 24 Apr 2025 10:06:42 +0100
Message-ID: <m21ptiszbx.fsf@gmail.com>
References: <20250423031117.907681-1-almasrymina@google.com>
	<20250423031117.907681-4-almasrymina@google.com>
	<m2y0vrtd5i.fsf@gmail.com>
	<CAHS8izNUOO-X0WHFTMd3_yEjCDu4sPYADE1oDEtWTYFNNMB5wQ@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Mina Almasry <almasrymina@google.com> writes:
>>
>> The bind-rx op has "flags: [ admin-perm ]", should bind-tx also?
>
> The omission of admin-perm for tx is intentional.
>
> Binding a dmabuf to an rx queue should and is a privileged operation,
> because basically the application doing the binding is taking
> ownership of this rx queue. For TX, no such queue ownership is being
> taken. The TX binding just gives the netdevice access to the dmabuf
> dma-addresses so the netdevice can send from there. It's very similar
> to a normal dma-map with normal memory. There is no need for privilege
> checks.

Thanks for the explanation. I couldn't find any mention of ownership in
the docs.
