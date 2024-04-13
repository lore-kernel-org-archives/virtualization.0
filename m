Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D3A10F4
	for <virtualization@lists.linux.dev>; Sat, 13 Apr 2024 03:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712979710; cv=none; b=d1r+ZLvFHU7ZD8/gIiChttQs4+p1wLli+kDyNdZ1/2HP1/CSqkgwERG4+bbOagK4cb/t/JgFXtWnTvbKp3QMwui4gzWM+HG6OJPZMr537rIsawSTDXxdC7KoTZgh45eOU2g62cQ2RFqd8TCwFeac6IXSZZtaCKuBNPStUuq8+FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712979710; c=relaxed/simple;
	bh=EzIJDIFGO6tTHTDtbY4vVKSK0KtEPlqsxufT9y3CHy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sM5FaacOfoZaeVa4/bKP4mFjQCXfVSGeUP/lCKZN0k1/22QWhk4erHavRtZYY5R/nL5ezINrdq5bLwmTMkUucBeIP0FG30dTbBnC/kWFNyctxsb83a8sPpu9z785QFUZnPcseKI8ZFlBKH9w7jnr46pD0FzZKGSoKcqkvHl9oJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/9tFTPx; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/9tFTPx"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a523524e5baso158784266b.3
        for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 20:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712979707; x=1713584507; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2e9eGT03DumsVv11aD7PWuRwtdqCrtgRsT4jgzvJaDY=;
        b=E/9tFTPxs3NQtAsBrWZ3dgpI3laWdAAC9JL+W7g6IwRKSLeQU64K2ggkbL+1zVRQBX
         DPO0kBch4eFTwCQ4jpwounHOx2bH9pwN+ORT0FKneHsjUtyYxk6dtHThgHo1QC57cWEi
         Di4W/2lPEP1vs5T0x6hUxiSQR/ITGPT4wewTk/YfFTTiNk7DxjQlyV9tSJ1bTJ7CBMtm
         cF0bq2Tl212wR3lr5AIOMxQlIobK0z9x1pKMMBoG2ZBdKFW2q7xCr9BGC0HBK3cleauA
         jmsVuU8M7dtPmHXrQhIK387pnd+Jxm8OOKdYpn1AHgurhMntpuB/VXdTtN8QSyFPjQnk
         eVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712979707; x=1713584507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2e9eGT03DumsVv11aD7PWuRwtdqCrtgRsT4jgzvJaDY=;
        b=kB1sdTLtdCZh56ZlE6bDyjcbZ47833CMSApnlCwipCL5aEJkrsBPcgxf51Ajd7N7v1
         Hg87HGnG1lB4VMCQPRj56/OhswEMgBabh8BI6jaS9QYDRyQM/ivkGpo1EsfVyGCQYKdo
         lWCDgmqZEq9PGK05/Al4lJX2YW/wO7bKeFhG6PSAox9vEays9LLNtaTQiiMT9prj0E+u
         wpCtc0AxHsPsqrYIFTKc+YvcoCgwo6YHsTPucYkzZ/TV0zPpC7A7DVHbTr6KMdePO34H
         iy/jhUktwMr35Zn3OBa/UcSwhAVlAIRNOizNofF4I5+KpKxXp3J2CqsCSlu3CUEVF3lL
         BLtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFJDwBPqG2WnTuPAbTgTub65qIiEkKTYIoz7yR0v4t3o/LDjZq4NY171BKQ7uPlqr7pT33ks+u16K7IQ3gPJXACYTdwytJsUV27tCPj94=
X-Gm-Message-State: AOJu0YxLo5qrzEsRPDThc3HOKVLXS7UeJZeD+RhC5/ma28WK4/dgf7pA
	Oza2Z/NRpyWHs7OUS7RU2mRr/eJexFlobvw1RNEJ9Jar7gW3r7KPWHiuU+KbHH9YZ3nwUqvu9OY
	IHK596fu0knlgKHXIcQjGfjaGCig=
X-Google-Smtp-Source: AGHT+IFxLN6f7T+mKsKK3f/fufoSjjrGbTgcrhzzCYSePfGDWQAap1LNr1fx1YFldVsS2oW1jFk4SeUF1g2CMBl78gQ=
X-Received: by 2002:a17:906:c445:b0:a51:e43b:cb20 with SMTP id
 ck5-20020a170906c44500b00a51e43bcb20mr3028014ejb.41.1712979707244; Fri, 12
 Apr 2024 20:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240411085216.361662-1-liangchen.linux@gmail.com> <20240412191126.1526ce85@kernel.org>
In-Reply-To: <20240412191126.1526ce85@kernel.org>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Sat, 13 Apr 2024 11:41:34 +0800
Message-ID: <CAKhg4t+c31Qf5tnARsw_Vbduh+2mUMvEUJAiDE+UbE8u7_sgZA@mail.gmail.com>
Subject: Re: [PATCH net-next v6] virtio_net: Support RX hash XDP hint
To: Jakub Kicinski <kuba@kernel.org>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	hengqi@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, john.fastabend@gmail.com, 
	hawk@kernel.org, daniel@iogearbox.net, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 10:11=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 11 Apr 2024 16:52:16 +0800 Liang Chen wrote:
> > +     switch (__le16_to_cpu(hdr_hash->hash_report)) {
> > +             case VIRTIO_NET_HASH_REPORT_TCPv4:
>
> Please indent things according to the kernel coding style.
>

Sure. Thanks!

> Checkpatch finds 2 problems in this change.
> --
> pw-bot: cr
