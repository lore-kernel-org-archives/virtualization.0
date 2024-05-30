Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116BC54917
	for <virtualization@lists.linux.dev>; Thu, 30 May 2024 03:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717039430; cv=none; b=GIxIgDuUY/73lyFJVh65cYz7HaNLJLvYvhBkx5LAAfWbsL1TaoONSJVcCDEIIv/Q2Hvw83IX9xc7o5zmJ2vmSHnGOB/qitArNnTIx6R2HJNLHOgv3YsEWRGcnpRyHTczsDE4lFi1MRGYwYY4fx/iON+4ejVBFuywY64IrJM5+dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717039430; c=relaxed/simple;
	bh=bOawJWWTPL3Lez7ujH/FSWgQkqRVTx64+xBiVlZ20hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mt2S3qZ65t+geaSWMtiGjRvUFFBXDxLSBDN98CA4caZmrJuKKjCZhUzny1D+4nWvJzhStkOQ4Xqe3y62S7u1ml/5gQ2LMtCIOMVo5tdjG+GUawcrE4160iIPmqATX1TA7whyJEkwWl9qnyx3gE24nCtdSiSxewndmz62SOEDTJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ad+vBcOn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ad+vBcOn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717039428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bOawJWWTPL3Lez7ujH/FSWgQkqRVTx64+xBiVlZ20hg=;
	b=ad+vBcOnA174Y78PxCcT1YnWKVLdRvGwBvbVAmSUhsNmJ0nsbviVcoc8J6rIM5KWlLffty
	WxM0/WY0giT1Nss6o4nLi+RSQ4XlB5wvKi7ZVSGuU2+1D/j2Arim7tK/CNkfm9r49r+DmP
	f3r8QQLJhhZbsf9PIKHciWKvYl+0Tz8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-rLWcNdtONWWmD5Qy171CiA-1; Wed, 29 May 2024 23:23:46 -0400
X-MC-Unique: rLWcNdtONWWmD5Qy171CiA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2bf9410c954so395301a91.3
        for <virtualization@lists.linux.dev>; Wed, 29 May 2024 20:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717039425; x=1717644225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOawJWWTPL3Lez7ujH/FSWgQkqRVTx64+xBiVlZ20hg=;
        b=Xs3m+fkDvr4LWa3R+ckE/LhM3hHfPY9v50VqYa3vxg0Gu2iB+Y2eKXQz7yETMHBNjg
         TdU3OPahrmtglSHW0WwBo86rmjFg6M2LikmAG6SvLTGSAZV0BM9U7BIkNH9BrIDlGFVb
         pwpSM8F/TDW66Dzhs2Tn1rkwyZsf4jbZ6R+ZmdMg1pZg38m6Djqat3+TXP6rad5dxBQG
         kiPtYve64X5FjZzxZlxArmGHbY/VOQyK3oVW9+chKWc/N6OdYgIwwjOmJOa9p4kYmtH4
         xURc0Dv39kTKpZHuJEXKeasi9vN1YN85MLEjrP2joPEjM4e6+2hIzUKQ2Jq6CEEgqK5o
         igEg==
X-Forwarded-Encrypted: i=1; AJvYcCVVq+lK7zZpzIGsek/M47BXKgQu4VlPeeJyLp4DEY9JOIrWP2D6yW/zwJ6eSNPJSPoD0wBPAlYSffxOBkoBtoOPEKDsMxLGVopwbf68D8Y=
X-Gm-Message-State: AOJu0YxbM1M9AP+J7bN1U0IZIjUSeONQWOxoPiFSAoA8zkeLtTLWI8N2
	oZoHcmYEl1SzKTUX1weTX+3o6iHEg2l3e4/qqUaq/IIrzywE7aN4pxbKPSv8FVBgC+dCIUNSpMB
	AHey/pSZt+YIifLKQHL9p8qUy22eNuLZ7eY1AsADIPnR7YQkmbQnGwK7dKgVt7sMQj5vyuc+eox
	x5c1czUvvafTG4wLcT7+Is0vFG+MbAWzk7PaSWRPU=
X-Received: by 2002:a17:90a:ce90:b0:2c0:3400:df40 with SMTP id 98e67ed59e1d1-2c1aabe9d88mr1616332a91.0.1717039425066;
        Wed, 29 May 2024 20:23:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY/pYUq0iajDlnpjMsBnh48kBWVYBIbXgSvQ/hOOE6EMpOmk07gTWNTuhtCbRp58KyXGCVbg/V7IP9Yi+YZlE=
X-Received: by 2002:a17:90a:ce90:b0:2c0:3400:df40 with SMTP id
 98e67ed59e1d1-2c1aabe9d88mr1616307a91.0.1717039424645; Wed, 29 May 2024
 20:23:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240508080514.99458-1-xuanzhuo@linux.alibaba.com> <20240508080514.99458-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240508080514.99458-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 May 2024 11:23:33 +0800
Message-ID: <CACGkMEvjaY1B6tG0M6HjLDPNZkFsvdgXNA-O4GrjyXomQiBmEQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/7] virtio_net: add prefix virtnet to all struct
 inside virtio_net.h
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 4:05=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> We move some structures to the header file, but these structures do not
> prefixed with virtnet. This patch adds virtnet for these.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

