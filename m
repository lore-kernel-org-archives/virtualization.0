Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACE3C8DE
	for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 06:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729365; cv=none; b=M5F+L5UcqeOvulSeH/am7vm2ZKdbjH17EfbL3ohS2dwuRE0uFSPn+5yq28H9Ep/vs35dp1GnWcOC3deOrPtoUfbuPZovW3PfcY6pvHALyRzchhR6LnSZJZCn5/jkOBlJOryL3pR4NHGL1LO1JqbldQEXPGSewtsKHcefr5+SWbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729365; c=relaxed/simple;
	bh=pdL+Y7ykVNlw9tRl/D3HqOcFigRQwSpgo5w487bNlaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzJ/k11v3QEcyDefjS+APcnEiueAtzXcUBm/5HWP9M8E8Vd36wpuUnFHYtxasUgiytakZFxgkGMo9fVC0qBi5CLuoeNOr/ctYoTFxdU9FHm2iDAt5ufPVeOCWuOflHzIhW9Xqh5meHqKFb9F0B+9SozqyOWc7hh4w02jcBJ3aQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dJLM5oMU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJLM5oMU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712729362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdL+Y7ykVNlw9tRl/D3HqOcFigRQwSpgo5w487bNlaM=;
	b=dJLM5oMUkCUFDXCjCuTf0mWTjQtKFu7RP/kKUjRPDg663N2iWcRAU+dtW/9ZhvG0KCzhM8
	NCu5A9UmSmLRntS+XbFB1p5SD1TuMCZ71zSyzjENMay374dEpy7umMxNDgnPba3siRBmOJ
	fndvdRSZePfb4uN1YTIv55CpmQkSfUo=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-_rb47PqcMxeYjVWEgUAPJg-1; Wed, 10 Apr 2024 02:09:20 -0400
X-MC-Unique: _rb47PqcMxeYjVWEgUAPJg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6ece02cfbf2so5893630b3a.2
        for <virtualization@lists.linux.dev>; Tue, 09 Apr 2024 23:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712729359; x=1713334159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdL+Y7ykVNlw9tRl/D3HqOcFigRQwSpgo5w487bNlaM=;
        b=KFjVchQDWn/G+TWnIt7tsQVifwUAWHTzfOv/Suz8jpC39nFq5OfxroUW69WhbC7xOh
         KFVllIgtZK858b2+RaMP6CP4G2eCvSnBV9bg42vmbxYO5akExISCd3pks7nFiuOISvSD
         wRfu4b0OUgh0jMVJPpCoVe2U83OHLNas1huZ1ZpiubSZ6fP21lJQfIb60bqGLCmgoqaH
         wkVHS2IzhY8LFV64sBOAHiLRjO/R2l75dlOtT1eCL1GTLSr8Sh1DagNTVY1x8C7hRzHi
         5Zvfo4iE/6VfJ1H0g1KBc1Jxcsm1No2SUcHMHox2vCFwut/JDvEMMIw21/MeRTLpr2Rp
         Aaiw==
X-Forwarded-Encrypted: i=1; AJvYcCXSDA4qgo/2GUTW6gv25Da4Bci0yGy6+hWNM06qpkKss37P99CvxxUxpZiIDRHMezRFwFrR3bfqeehzCPezRz9HUyrQlWWnSjVqxPw7tRI=
X-Gm-Message-State: AOJu0Yy66M+32ANPPUwdoMCy7RTgVefNi5na4xsQJnRjSO9gkfEC+Lor
	9UC51PYpJugUIKDgZ7cqqBJBG2IDOOm1P9PW4lHG3aEv9Oyx3AujnPW5V6ChYLz57rT55fVM0eW
	7HIQs1NSj5Bn4sHFhQvZB7RTvHAxR3MhzNHiuWnBzHUBQPpWu7tDWe9+uRy6LHgTlStMrnJD4E8
	lX7bwc4+ZTfZdVtV4dbG33yAY4ndOtiTAiHV8Uzhk=
X-Received: by 2002:a05:6a21:1707:b0:1a7:af88:486 with SMTP id nv7-20020a056a21170700b001a7af880486mr1953127pzb.9.1712729359652;
        Tue, 09 Apr 2024 23:09:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExWA7dtfa6ijnoDUCu1UfmNatwKbyCe84k67lqsG0ruoxaZc3zh2CUgoM4nLptDf+SMRE8btzrFCMB+Gqw878=
X-Received: by 2002:a05:6a21:1707:b0:1a7:af88:486 with SMTP id
 nv7-20020a056a21170700b001a7af880486mr1953106pzb.9.1712729359357; Tue, 09 Apr
 2024 23:09:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com> <20240318110602.37166-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240318110602.37166-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Apr 2024 14:09:08 +0800
Message-ID: <CACGkMEsVeCS0ABNeDfSvRa0GVqFN9EhrB-47LJG0_NnsDN_mpg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 1/9] virtio_net: introduce device stats
 feature and structures
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 7:06=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> The virtio-net device stats spec:
>
> https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd=
243291ab0064f82
>
> We introduce the relative feature and structures.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

