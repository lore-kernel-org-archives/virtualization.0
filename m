Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A7B217722
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 00:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766537577; cv=none; b=Uwz2+YJAkT9dDrBkY3nek/DXBdnlIe94y2abyid0HQJsk9Zzwo8gb0G42SsgWM/2xW9/5JzhP21DiSxWTmoRbZTLi9wVM+T8IGtpsBwnJD7vj5T/UGGbpCmyAPFAaVrYJY/QAtx/lZ4olw71s00ZtNniWkP27txG8BOZhBhm+aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766537577; c=relaxed/simple;
	bh=po6RpdovHRdcPdJ7ye60KpUAACBfvE59Xqd+JhqKwnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sj3z+vDjpOdQqVMkEqxdGAIw/q+nIJNMULJoMd40AkOItHC1YrIIvIDZ1ACKqvccrp1g0H7uT0TWSvlvBgyDMu3Q1CYPKaEUT5FcUNZyf1wAtZ7Jg5LBpeGLbKqGRFFSc8jOKZi+2fagp5PbDNnOD1nBNYzkr0r0NV3WsxZOSOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PldzWIMu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PldzWIMu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766537574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=po6RpdovHRdcPdJ7ye60KpUAACBfvE59Xqd+JhqKwnI=;
	b=PldzWIMuqzzrcpDG5PiD8qwzN5acWsU3lp5U5GizmM9HeT1AXJO+Z5HcNQ2Pad60lRLCkB
	6SfC17lSuuvpD6Xs2TctmGx7FeFAv7dTrUURMqC+B5BNmJZdX5qya9jHpMO8e3yRuDTZY2
	VCxw2RJqBlW1MXPK7lHa07H2LkW6DAA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-M7pr8ZoXPXeJI-YENFa9wA-1; Tue, 23 Dec 2025 19:52:51 -0500
X-MC-Unique: M7pr8ZoXPXeJI-YENFa9wA-1
X-Mimecast-MFC-AGG-ID: M7pr8ZoXPXeJI-YENFa9wA_1766537570
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34ec823527eso5173552a91.2
        for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 16:52:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766537570; x=1767142370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=po6RpdovHRdcPdJ7ye60KpUAACBfvE59Xqd+JhqKwnI=;
        b=tbh75iRLy35C3ogfNHZzhuytDFUPXnu2mI2QWh77k3h8Cb1fu8uJrORIu53NuMH40q
         qOcKGl7gRIrJpqYB20EOOAHpuIWzABceLNoreLrHTAwxxiZxkWx2bY2hJBE/N58BqSpX
         SoCXkU+jHZ+lyN1W+1Nwe6e25Oh//IeKbohxrhb/JxilUIClG+nJpo2XdZywTDKEZi8q
         qkxZP4xD1ROYVCamlR2WrSuFs6vDIQ2U5c6X28O/1GZRkYgCPuhH4kmFnTfYw8vGqXyL
         pMTXRRtkzQr9NkfOuRFWuvrH/e0q4LN39RVaFg62pXvhOWJHKjVAFWiKelgLXlDcqRvo
         /6UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuHYGlMIYv4DealvzAk1qfcU4Hfnw2B+R6ibWQlDCe0fs2Nx2Nnzrdx29ITWKGCbIeEBLLArk5r1BZFpDCtg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlwmaG6wWtxSiOe9M7d8GKeytEq9lJlmfafqJem05OOvHpirpu
	MxIV0HVzdhaHpPfN5ncB9nHpE7uPXwo35cdD9kgYQ1CZxWttfUa3wpbmayfTiHtHa5jiO88g93s
	k/pXf+f9b4zCkjcEo34tW1iHf/y5g0t8DfcbynWShXanRnySS1b4NuIl3XMEmHZ7FhiojAeb2hz
	8ZmG5vtt1dpxEmuLh4Ihqgcpfado2z2aIZ/irM5OOawJ8=
X-Gm-Gg: AY/fxX7TTizLLHjtvmb2ojzH2J7H2VNoPr4Elg0KfQpr1g1NkbPlqba/sSV6EM/i19J
	ImUZLvc24BqQtqHZb/cO1xy2eiRJ8n5D6SEe2JHkhK1sbKsk9HpLM5x8bndL3ovKzSrJ5OAhUoJ
	6hrFr+onhBOXU+vCGvzCbUrYI623PjHMgYP2kFoK2vK+nVl5n5k4Rjxe157OLQYHkH2FY=
X-Received: by 2002:a17:90b:56cc:b0:340:a1a8:eb87 with SMTP id 98e67ed59e1d1-34e921f6feemr13113374a91.35.1766537570567;
        Tue, 23 Dec 2025 16:52:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHF+noWfN2ySEUI8GZb3Ntf51HoydRghcYL05TuV9bQ1tdT4T7RAnx9LFZiea6uBQnWuwOmdQQ+4Kqavimq6ZU=
X-Received: by 2002:a17:90b:56cc:b0:340:a1a8:eb87 with SMTP id
 98e67ed59e1d1-34e921f6feemr13113351a91.35.1766537570192; Tue, 23 Dec 2025
 16:52:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251223152533.24364-1-minhquangbui99@gmail.com> <20251223152533.24364-2-minhquangbui99@gmail.com>
In-Reply-To: <20251223152533.24364-2-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Dec 2025 08:52:36 +0800
X-Gm-Features: AQt7F2oh4rVbS-8aQ3gvuoAlLwJB54Xn2U1CBKxMODTcXeAZWD0c1j8udrn6yHE
Message-ID: <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue work
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N-I0mur5gXA0RVgI5a4_ARXLwAnxNPINk3RR8t_jfl0_1766537570
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 11:27=E2=80=AFPM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> Currently, the refill work is a global delayed work for all the receive
> queues. This commit makes the refill work a per receive queue so that we
> can manage them separately and avoid further mistakes. It also helps the
> successfully refilled queue avoid the napi_disable in the global delayed
> refill work like before.
>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---

I may miss something but I think this patch is sufficient to fix the proble=
m?

Thanks

