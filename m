Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59D51EA65
	for <virtualization@lists.linux.dev>; Mon, 11 Nov 2024 01:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288709; cv=none; b=ipPa94ePNx3IwNkcfnNNtAorTXpVUIIaOVQ/8yiFkrLOaiavyXnQDsPK4a2syuzPTv8vNGsHhPhkx7T4qwkJkjSPhn6qze9NZ/xKFB+548Ix1gRvMVr96DYRBuPNZ7QvySDDoO4YekhCm3z3Y9Ii6XbaNf/9z1OMa7iju6qaelA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288709; c=relaxed/simple;
	bh=8RjtmP7zVZrflkjuPVjKxGfngY1SABY3DdXeQA3BEpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+putoK8iF081VHHcDsrFkbrG9JnrNl7QtVxiTbackRDRXpFwu44Uj0Ro/74PPCjel550RrM4QJOjcEUgk+mn1Krl3j/eKO0lk8DtWy7KKtVG1q/GCdNw5zvuA0eWfS86Jbp0wGQ0jQQC+7ta3QhFunk2jFG8L4hS/WUNNSoIUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wd3KrFZA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wd3KrFZA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731288706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8RjtmP7zVZrflkjuPVjKxGfngY1SABY3DdXeQA3BEpE=;
	b=Wd3KrFZA17kblj0bGv2Wrp1H7WPrw5nHjzOof1I8BnAyeIk4XOLORbE/yTALUh/o7ZscKP
	D1ShCd4BoogWp1qsQzon9QrllsSaW/MCSJwjX2c01vqy+El6lNDTJ6kv/PRqMZUeDDfX6K
	2lO0PM3zPJxgAkojSFviBzJTixDkicA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-bnfzK7JWOhGbODgCP5i2cQ-1; Sun, 10 Nov 2024 20:31:45 -0500
X-MC-Unique: bnfzK7JWOhGbODgCP5i2cQ-1
X-Mimecast-MFC-AGG-ID: bnfzK7JWOhGbODgCP5i2cQ
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2e5bd595374so3201936a91.0
        for <virtualization@lists.linux.dev>; Sun, 10 Nov 2024 17:31:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731288704; x=1731893504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RjtmP7zVZrflkjuPVjKxGfngY1SABY3DdXeQA3BEpE=;
        b=jZQgB7YElMLf1vtlZRhj1y6elhi6Lrt5K008rAT9zvkmq91e+2oBu0c+aVwkjw2yjM
         r8102wvHy67RITJyZkknwK8HBIhEjDasNEbH3JtzVIJEXCDWU//AdMnJEXjitnUNt5kI
         j5KFEwDEh1YdnLT1Ri7vD7GZ/x1w+AV0Juqa238ajVkJUP9+GlVYZMTcr90xuM6dNRL6
         pGffiuh4iOY/UGZ1fUEe4A6iD/2dXC+lVuECBDjyRzLiJNsnC/nqy+FJA+4/E9mfugfs
         RN7uqnNwgTNP2arCACa/wV1NusQ+tjFD5e2EckgHjnfemy9AN/tSuXbp+kXiS0zWD7EE
         iFqg==
X-Forwarded-Encrypted: i=1; AJvYcCUXd1hYEZQdnUCRDotzRvkRRiQJD2wY7yaJtIXychAFIGkpjxt8a2lcmOWwU3eIS8525meLU6IaR1QjldZXjg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3AEaZ2P9yNok4IUqvDi+9D2fcAnluTj6FdraASDAEE7aCABIH
	0w9nixLP9A85PIp7NMgNBWQ72Dh5IN7LzpCEQDqBNG464N1m8+xYLrVwn0hhKBdplZOf8O956U8
	kr40QsFcI1ndrXbmfMxSGN9t5QIFhrKMja1ktAfTkJ+HXMM4Jxt2oGWw5QHDaPQS1qMbP+aSmVv
	A5nzwqERiSXHIbZURyox8D98mUnwfkta9IAQECJ8c=
X-Received: by 2002:a17:90b:4b88:b0:2e0:f035:8027 with SMTP id 98e67ed59e1d1-2e9b1ec3ad9mr15212829a91.2.1731288704289;
        Sun, 10 Nov 2024 17:31:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJ45A0a7VJ+rtoKCuZ3Xjxf3vbO+kpA+QpYKgLnefQ2pNNeyLQuJUHLmrx4bENZUF5kjBfviP3ZWmPxNU8h7c=
X-Received: by 2002:a17:90b:4b88:b0:2e0:f035:8027 with SMTP id
 98e67ed59e1d1-2e9b1ec3ad9mr15212803a91.2.1731288703869; Sun, 10 Nov 2024
 17:31:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241107085504.63131-1-xuanzhuo@linux.alibaba.com> <20241107085504.63131-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20241107085504.63131-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Nov 2024 09:31:32 +0800
Message-ID: <CACGkMEtj=D7OPL8hAxJumhVL8AwLS51tm42t0qCxzGhMa+psMg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/13] virtio_ring: split: record extras for
 indirect buffers
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: R-Y1CYx2e73SzEoKrD2QbS_1B4ChHqY-1uSTUJRweZM_1731288704
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 4:55=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> The subsequent commit needs to know whether every indirect buffer is
> premapped or not. So we need to introduce an extra struct for every
> indirect buffer to record this info.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

