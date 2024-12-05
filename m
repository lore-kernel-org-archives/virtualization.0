Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30D91AF0CB
	for <virtualization@lists.linux.dev>; Thu,  5 Dec 2024 07:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383914; cv=none; b=du36h5xRHJWoqQB4VHfgMnoQ+2q3teBQ1zAupWfkyQIWoSaQxfCof+iH5H8uJivYwE7hLmqEz41SgGnIUHXF5c0YjXwAKf1tQfNMq3daZFTgIyUAJZgHuk9mfp25u6Ta2xbcoqeJiWagQrfwH3/9Kc6OOAD+NVrAxBkL3bOMhbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383914; c=relaxed/simple;
	bh=toFosSafYBFrQ7Vmksn/Bd7aqXnd1s0VzoOQWShwL04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+sRS/07PdwqoPI4l8V4I9zmTmnZDdTZkNheYbySTo2Ip0WH9lC7eCFuXImXCsunCZk3JL884HeTNonzXH+KclHMq7tqV8TormxCyeOzktm4rtbrP03f6v643j6GbDLxSA0NJKfqbyzcvhgacnBl0jVtyXp7tVpkEh3cYLdlzn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dFZjeXB4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFZjeXB4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733383911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=toFosSafYBFrQ7Vmksn/Bd7aqXnd1s0VzoOQWShwL04=;
	b=dFZjeXB4gYftJNRM2yFK9kmCKZBSfeKeOz8atk9TKmihyghO6h0cM6s2oRCLqtkiQNWTHX
	G9tsScV1UaLSfGxzsToHg+YbjXe0X97IL56QWGo9/fifoBMUPuPWXt4jR+iEiX1zB9O59y
	5sqIssxTP3Q9wZ1RbMePAb80OaJha00=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-SgI-uQ4_Meqdd59p_8TA0A-1; Thu, 05 Dec 2024 02:31:50 -0500
X-MC-Unique: SgI-uQ4_Meqdd59p_8TA0A-1
X-Mimecast-MFC-AGG-ID: SgI-uQ4_Meqdd59p_8TA0A
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2eebfd6d065so805559a91.3
        for <virtualization@lists.linux.dev>; Wed, 04 Dec 2024 23:31:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383909; x=1733988709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=toFosSafYBFrQ7Vmksn/Bd7aqXnd1s0VzoOQWShwL04=;
        b=nVmb1X8eWgRLbAn24Aoq/eR9tLHDz+EqenponxvocRsyQ1JRdqSvOFK3Plh/3hmFU/
         ATfDB1PVeRE+OYALwa52/T/66KyqpwcRKv5oAX6+oPJzgiH1CmLvx42OOCnUub9C2ZZr
         D3XLKcOLMHDP6TEuEhQgCn8v8IMIfc5wzUO6uAP8fThiKhdbSNjhnTLIadxZNBYAWRhR
         KJP0k/QiFCQR2u0DBRXZVZOsyLJDA51PSdnnKLNQgUJ0/tkMmoq8vl+9Usuk4WSol2te
         KRrPQfpndHjcGE7OU4Ymvnd2t5zpzLd91+swUUk02mTK+7RMCTIoQpN8uFub3Hic3kZU
         I4sg==
X-Gm-Message-State: AOJu0Yz9QFn9O+bVF2LRJDjL1Z5UV7yoXKTfY9UUdUCdxbvK8NcNSKXr
	zut6cIMzvJC7oT3p0A3jIdMCkPQlrOBC8NnEP/56sM9Ze/SldTTVq+//e9FJUaqji8cgtyD0TkB
	F2BPUeGaMpt9AfxTcKeCMJLVgKh+5CVB4l/qsCKQ1XY9JkuhQjl6vncy7j5H99ulGrb59J6LbRz
	KR5fXx7mXEJfdL+PQyWbcFLd2Pa6xip36DSHAKiGtyao2j6haIIw==
X-Gm-Gg: ASbGncvq+4T/OITrxYGwkog+UBZ0Ek18Cg/XzfLy9biVCg0/+jeiWvX7YAVjEapZiqs
	DhQAdRn/Rt1XFzciREngS0+bG7BYTP86V
X-Received: by 2002:a17:90b:3903:b0:2ef:2f49:7d7f with SMTP id 98e67ed59e1d1-2ef2f498ccamr5022354a91.18.1733383909075;
        Wed, 04 Dec 2024 23:31:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGixH+V19QXJVTaRQQMS7yMn8u7saE4FALdvwG/htpjGLWE45l6MvTr9cB/l1hOZceUtfHA1KOmc6KCU2mMM4A=
X-Received: by 2002:a17:90b:3903:b0:2ef:2f49:7d7f with SMTP id
 98e67ed59e1d1-2ef2f498ccamr5022336a91.18.1733383908747; Wed, 04 Dec 2024
 23:31:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241204050724.307544-1-koichiro.den@canonical.com> <20241204050724.307544-5-koichiro.den@canonical.com>
In-Reply-To: <20241204050724.307544-5-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Dec 2024 15:31:37 +0800
Message-ID: <CACGkMEsBKLkY5vRjWkP49LOOYmhY=Dw7U97xy0+xpL3-9Jnmiw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/7] virtio_ring: add a func argument
 'recycle_done' to virtqueue_resize()
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pmQYC8F1t4q2AuSJWDHWmjZai3f4gveI-kPweh8Z2Qo_1733383910
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:08=E2=80=AFPM Koichiro Den <koichiro.den@canonical=
.com> wrote:
>
> When virtqueue_resize() has actually recycled all unused buffers,
> additional work may be required in some cases. Relying solely on its
> return status is fragile, so introduce a new function argument
> 'recycle_done', which is invoked when the recycle really occurs.
>
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

