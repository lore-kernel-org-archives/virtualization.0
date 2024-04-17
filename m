Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF157187F
	for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 02:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713322443; cv=none; b=FZymetiNcYHAVxlFKARn0i9XpVdSkMyjtHt39bHGq74JlkqNGnzG+2++gwYKhSs5Y13213ujMGMuGKU0P3CIye9iLeV8dU1m9eTukkbT4FCcwid7MlBDYWg0ic0+Llqvi1LULOJ7KxX2+OluDulAOcOp0jabS22o9FWBI94ejEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713322443; c=relaxed/simple;
	bh=avphAe2kkfvHzKls4jrz6Bq7fhTl4iSFQ0jw4sDwTvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/l+DRTgughQNoxZ/0NA5RaBGAsk0lYeTQbjG7H/RNerwJUul1nqVk2pP8IsXDF9CnGdyqL4tje8fWZZYavZPR1iSSTPkyxSifDCuQwwKt3Z7GGelwFTuxLm6T0uBbZu6xoYrMaBFVfUy66mqCAkGhVbxKQP9gun6+9/OFsiGDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3Qlm7qh; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3Qlm7qh"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a52582ecde4so373937966b.0
        for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 19:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713322440; x=1713927240; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avphAe2kkfvHzKls4jrz6Bq7fhTl4iSFQ0jw4sDwTvU=;
        b=l3Qlm7qhtZJnI4+nXSGAkP/h9KURxXPRdUYPWxyocS/sfKh3uQamxV5c1RjeQvr8RK
         sGLIPPieDDi9SccBgB6iaLk8PpFiRIJu6GRgzt7bsofjn9ljt2PZSfaW4Ey8boNsyRyc
         AHhunRUM9zb+JrmFVa5A7JmfTw+NbB+bRoXBmr5BKhEfd/PGAPPnbbSotKfG5ESZ2OI1
         RGnr9IwzDiNvkXBlbKIPU5HAvyWj/THtmU4CmowPLLAP4PKlYa8/5M6ZB4i5HVmxqHAq
         EjUBgvoQK1XsjMeNqsyaZMxvmd+ehC9ePWS6nDXANQP11NnBB/mFPVcsdTKYSeeXWPeZ
         LriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713322440; x=1713927240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avphAe2kkfvHzKls4jrz6Bq7fhTl4iSFQ0jw4sDwTvU=;
        b=cbe452sYG8IN6fNgOvL5iJPozWJG9iCk3S1l/Bb1Lo2PxsP8fjNLWKQSldP8z1VwOB
         GDbIKa/kYAPL90ue/qxfwpmoiVHL0tFK+kAdHBMsuJU1NTaiFp/EzqnREtuhQXSAe9tU
         x81gAkxBl0zWM//VOnGRyDqvGE4T+fv+C5EVyk8ONaf8FTmra+TEl0urv50AkJ+dKOqO
         UeaGuwIox5vvKQxmMGb8e7n6LSLayOawQM4g30jIZUbOq1VRQA4hSzCItLjI+w4WKNit
         IyxOWHvKQNihQYPKTKCpz8ruykwtZ7bAlWSqI5oWO4+O1asEqw197fwZ48gypNqIEQr9
         9+SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmsnHb5+cLn503avsEcs8BlU/1ddJ2C1QFZrf1JRtZcAftvNGIk3qc5fpDOGRrxHzzYJEAh+R3qxtLnvs7XEb2AZvorXAzks5YgdUW+eM=
X-Gm-Message-State: AOJu0YzUr5OhKC4U86A6Fc8HpoQU9/AZwb/3mEw01GLkyARuk9CPNWi+
	yJhEG3uy+Q5JrDYcT3ofSgC6dLG7dqTdrPHZWiDxo6gF3m1XQdZW2uw9gnf/z+3LB+ikbIb7Ba4
	zLa6VH85ZJACLoEjCHfhrvH0puT0=
X-Google-Smtp-Source: AGHT+IHgOytto0UtLgXXbpiyxS4wjrTtDFhU0uzHXJ/wB41RreYbGQMD0cKk3LQLqb2NzrmxF34RUmqjtedT1xaGbL4=
X-Received: by 2002:a17:907:7b9e:b0:a52:2ee4:def0 with SMTP id
 ne30-20020a1709077b9e00b00a522ee4def0mr13078612ejc.18.1713322439648; Tue, 16
 Apr 2024 19:53:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240416122950.39046-1-hengqi@linux.alibaba.com>
 <20240416173836.307a3246@kernel.org> <1abdb66a-a080-424e-847d-1d2f5837bbc4@linux.alibaba.com>
 <20240416192952.1e740891@kernel.org>
In-Reply-To: <20240416192952.1e740891@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 17 Apr 2024 10:53:22 +0800
Message-ID: <CAL+tcoDj11Y7o2f0Eh8-FMk0BxjtAwCupWaW7n7bOXTUVgAWSQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 0/4] ethtool: provide the dim profile
 fine-tuning channel
To: Jakub Kicinski <kuba@kernel.org>
Cc: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Simon Horman <horms@kernel.org>, 
	Brett Creeley <bcreeley@amd.com>, Ratheesh Kannoth <rkannoth@marvell.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jakub,

On Wed, Apr 17, 2024 at 10:30=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 17 Apr 2024 10:22:52 +0800 Heng Qi wrote:
> > Have you encountered compilation problems in v8?
>
> Yes, please try building allmodconfig:
>
> make allmodconfig
> make ..
>
> there's many drivers using this API, you gotta build the full kernel..
>

About compiling the kernel, I would like to ask one question: what
parameters of 'make' do you recommend just like the netdev/build_32bit
[1] does?

If I run the normal 'make' command without parameters, there is no
warning even if the file is not compiled. If running with '-Oline -j
16 W=3D1 C=3D1', it will print lots of warnings which makes it very hard
to see the useful information related to the commits I just wrote.

I want to build and then print all the warnings which are only related
to my patches locally, but I cannot find a good way :(

[1]: https://netdev.bots.linux.dev/static/nipa/845020/13631720/build_32bit/=
stderr

Thanks,
Jason
