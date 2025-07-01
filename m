Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491381442E8
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 02:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751336411; cv=none; b=YN5wozBRC9/NSTxHFh7rGi+xhorbhgDZ9vHfVYRlBQT8bQIuHOCdsVBgvhODKIB/jNOzEl1bXWTF4QLdTc/ML2RuSMfbllUa0Mo1NitN9JuJeDtjaq7rMU+c9oPZ/kaANC3eVv0NvZd2F5M+Hv9jlzQZ+GsVgWrK3vIbc/cqz8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751336411; c=relaxed/simple;
	bh=Bz/86j3mpJf6RZwOMLVBi8P/cdclQpstyJilpZn/LWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixLf0RWleMvf4xhRfEyheaF+qj/dFJZ0EzR2Vqx51G6qydV1mCh9uuZCZL4gglRK4jxs+cZb+m8BH7PYMgTvwsFCugZyjuT1VuWStRc279o2de2fYUIgHpXHeRMfDMO5bNfoiiXVMIQiUCso9um6lF0OOkfQ0QkMT1OW7/Ya+nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XitJT7rM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XitJT7rM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751336408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bz/86j3mpJf6RZwOMLVBi8P/cdclQpstyJilpZn/LWw=;
	b=XitJT7rMcVfVnvFvEtiTtsObSRPFK+a70L5scblewEeMF8TbMA+mhgVzETLB0tobE4VrZA
	mbEOHWZYl9pEa70KxAP314mQdty7ITBqKYq2cbRKGpJHzIlaokjTde4rr7YypwAxWMJRI+
	ffhw6htbZjLLQUaMAjYEafXX3btQSdE=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-NP0KwsNTN3u1KWAckntmMQ-1; Mon, 30 Jun 2025 22:20:06 -0400
X-MC-Unique: NP0KwsNTN3u1KWAckntmMQ-1
X-Mimecast-MFC-AGG-ID: NP0KwsNTN3u1KWAckntmMQ_1751336406
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-4e75a8ac11eso433886137.0
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 19:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751336406; x=1751941206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bz/86j3mpJf6RZwOMLVBi8P/cdclQpstyJilpZn/LWw=;
        b=Jq6R0xyMGN3Z4Kcqfd/090btiyD2obj4VZ8K0COXGYC0DhDy5hcB0L1rYYovqaJ+DO
         kiSK+VfM6exjS99FjKk+V05U+NVZteRkb/ROdundnfhf6RK5GtuVnukG9qlNkMjr0N9w
         lfJy3MbuX8G6ObBzSu4NqXbvW3sSq+YbnRuSqulmT3Oz38VyrxDmhFZc0F+hU68eVYSl
         jJSbv8C5MUY+8IRuMrJkqgi9K10CsXJ4etqJFcZc3W+PLeNqcbDzRBJVWrHn0amgceQ6
         XB2BGS/1C+TBMMsTFMgDecWMzhfplqBFVCGXfsFGDKYOTstV7bPLhIafz29GRlmXGEA1
         o9Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWCSz0xKNZVngbAWpHab5gu6GOBE+U1EGgx7sNdmQ0xFMl2XjIsbZPeTC5y0/vRZVDkKGt2165N3H4ldTg2pA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQs5lhNeGgEewRs3AvVAc/9FvfDe2VfQL5iYEG1h4LwpfYdNqh
	lI3MUcNduDGrdTSWz0iaeGu+Ip0k9TDJbU2IAJyUa0xdY/28C0X0uTxAv+S5pvrJZll4dCDEimm
	3U2ARJOu+zmBTTQnk84bqrf597m5jjPU58xxzLpKhPbPJ5vn8z0rWFNApR5UlOfBudKP+i5APWQ
	zcqcSn2dMdTvQU/ydshoa+CGM/EZWpYI91fitPYJsSr1A=
X-Gm-Gg: ASbGnct2odPetk4gwQ16mQfdlSMDvorQzzopd7c5fu5pPG1FDpOg3ICIo2PR7C0gMJP
	Eio6D/b14Pu4UApaHB5CDRqphOBWMmQQ4niJU8OaFMqghRvbl9odarbVU2S5cH4GfMcNUptDA+q
	RE
X-Received: by 2002:a05:6102:b0f:b0:4e7:db51:ea5d with SMTP id ada2fe7eead31-4ee4f57b220mr9035430137.6.1751336405877;
        Mon, 30 Jun 2025 19:20:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfwt0IUN9XzbcPTMYkve3OC1WK/0fpTeOcXovTvrlwz1DP2O24mIjCZg0vVcRzjUe2M01DvNuq273bCwcQw/Y=
X-Received: by 2002:a05:6102:b0f:b0:4e7:db51:ea5d with SMTP id
 ada2fe7eead31-4ee4f57b220mr9035421137.6.1751336405513; Mon, 30 Jun 2025
 19:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250630144212.48471-1-minhquangbui99@gmail.com> <20250630144212.48471-2-minhquangbui99@gmail.com>
In-Reply-To: <20250630144212.48471-2-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 1 Jul 2025 10:19:53 +0800
X-Gm-Features: Ac12FXwg9udMXpdfqk8skCNczA1b4cFLqKAJ_PlRVtyvo3Mi9xA6wAsp9nIVFQs
Message-ID: <CACGkMEuJk=PF2aGQj4FNhSv=VvOTzruK6PMpEykB9MVHwU4nDw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/3] virtio-net: ensure the received length does
 not exceed allocated size
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: flYrWEw-HQLrMneY__yaIak9B6JLoKfOVG7LvKSSOsY_1751336406
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 10:42=E2=80=AFPM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> In xdp_linearize_page, when reading the following buffers from the ring,
> we forget to check the received length with the true allocate size. This
> can lead to an out-of-bound read. This commit adds that missing check.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

