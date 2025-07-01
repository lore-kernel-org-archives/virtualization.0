Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4A11917ED
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 02:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751336425; cv=none; b=Ye2zTPcKQysVN5ax4pQManRpeqHo4vonlLKLUHR25MKrABfqm6zdI7SeyLL2FNa5i4IfvRvMzUwUSjhSmsnNgfpaAiEtukCwvv4uQgBjdl+Gius0TuVFUZ3cbRe8mnkvXV9PY8LIGgeMZoQMmfLFPBvn97qbio5lMzYRSMPEhWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751336425; c=relaxed/simple;
	bh=WRkNpi1+u755d+RTOomAEvo4QL0439YSaBkjP0jh4c0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F3CWLlHjvp8RfYVcSIHD691WaVS24HxNDM4RU2P3lefeq3V/guJD0T8z3Eih9xaYs7+O95gsfpfotAGai1HPSd/HiyIUWXbOtsx6hmzVLmlTbZeiI0Df8Kg5FvHPRikY3uGSlZ6ceNw/yOOW6Ot1VBuSBBHo8EBx8cIj0BiwwiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TqFxtGTT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TqFxtGTT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751336423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WRkNpi1+u755d+RTOomAEvo4QL0439YSaBkjP0jh4c0=;
	b=TqFxtGTT+Xl6hV9PvImmZ8naU+2SeXAa0BWxPSkCSB+6r4gn7fpPTwDH6kTP2OaIeVFz0X
	DRpzfvBALO1PAj3rd/IZFhbpWJh5U4rbrXDpKFJF1eXD9i7RxIlE69VxNeuJbRh5RN3ANI
	d0JluGzzKDA0nb8/CrFblcdiQCjYYzo=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-a5WlQKBTNYSxg47NNuD6QQ-1; Mon, 30 Jun 2025 22:20:21 -0400
X-MC-Unique: a5WlQKBTNYSxg47NNuD6QQ-1
X-Mimecast-MFC-AGG-ID: a5WlQKBTNYSxg47NNuD6QQ_1751336421
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5316d00ecfcso870458e0c.0
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 19:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751336421; x=1751941221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRkNpi1+u755d+RTOomAEvo4QL0439YSaBkjP0jh4c0=;
        b=P81PsMxEVPSEi5CCy1xiMe8MnwAMu6u2X8zLsu7dEWwsDhO807ky+jCYsWM+tPbGwM
         tD1r3D8766UGjtiPhxd6oQqz4WzwgBGx+KvIvP0ZXmZlgbxbemJOue5MVuLvo07l/o6B
         EWfn2rT0/GAXjVv/oo3a2PQzPnkb/mYekgANvAkNB8ELsHAQZqje4nuzKr/pUfq2CU/1
         F9y6U/JCRY91jiSzqQ0LmQqvGyfXkOk12pOTsrNOwmx1qZAc7ZcEyijPsCbSt0s+AMgP
         Mus5XYTki8QQb+aJxzXAF81iVIn0ppjsol1lSFawD9XEJdFPxxoz7J3mtjNuyvpX6Ftc
         SXKg==
X-Forwarded-Encrypted: i=1; AJvYcCUELLa4+tJ8+jMhRfNNY/1KofSftOmAzI8/GX9NBRng3gU6w/kiWIVQ2pm/tOqTaBzpUtYhPmGlBJJ05NMsNg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEePw03uZEjSP6M9ov+4zuyYrPCallpRqwXI2WuMv8fa8icAj5
	JnBo4Vj/EMWw+JJMB7nbeCmK4VQg939WNrAy9B+amW3jDJ7UgGvkvCrcZZ9Y9FfbU8Y3utN3sWx
	imGJ/LsZvDg3qTZJbFMkV7WzfvBXuSEb+V47g5lobxIZhMzAPLTNglWTRGm46+V0nil2qqLQh4h
	aiLd98+TKYAlNC7Qrp1WkDC7k6+D9QPyxxiCjQJ/WvgoM=
X-Gm-Gg: ASbGncseFrrGwU7My/HtHTs1Zo6TooCTGO1f4FRpWf46IyMA3IVKTWm5mjMQdgORvtA
	j79PQCT4sJ/WNc/jXAW+Uz9tPm1WrxRrti1TOQVRnw7oXvObAVi7IjlCHxUl94m4+Bk7h7wCO1/
	cL
X-Received: by 2002:a05:6102:2c05:b0:4e5:abd3:626e with SMTP id ada2fe7eead31-4ee4f9e6313mr10405282137.24.1751336421325;
        Mon, 30 Jun 2025 19:20:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcgqA4GY5HeNzIXNDy3m2/0QUTCkMPWazV2oM4SlXLsY44Iog87PMmTUv3dD5hme1ectzbCFF6OxMHcOYRnvk=
X-Received: by 2002:a05:6102:2c05:b0:4e5:abd3:626e with SMTP id
 ada2fe7eead31-4ee4f9e6313mr10405270137.24.1751336420966; Mon, 30 Jun 2025
 19:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250630144212.48471-1-minhquangbui99@gmail.com> <20250630144212.48471-4-minhquangbui99@gmail.com>
In-Reply-To: <20250630144212.48471-4-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 1 Jul 2025 10:20:08 +0800
X-Gm-Features: Ac12FXzTGbPc8d1stXK-UyjLYhm6Mh_lf0LlWolyX6yBYCOFZ2SRlUxOM8CEHbs
Message-ID: <CACGkMEt9za5v2tWDBOs_1d8nCk20CC4XyadszKB7ezKRz=sBmg@mail.gmail.com>
Subject: Re: [PATCH net v2 3/3] virtio-net: use the check_mergeable_len helper
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
X-Mimecast-MFC-PROC-ID: Q36sdBIoXirKe8H3ab1jSQ7-5ljHjGvJHlxkbB-IA0Q_1751336421
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 10:43=E2=80=AFPM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> Replace the current repeated code to check received length in mergeable
> mode with the new check_mergeable_len helper.
>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

