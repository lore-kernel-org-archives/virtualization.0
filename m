Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE4B14A4D6
	for <virtualization@lists.linux.dev>; Mon, 11 Nov 2024 04:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731298314; cv=none; b=PDKcekCOW4f7Yx6VqnlozNDMWzfbObJnaZC5ySeIowzFyWk1u6k98ItPNq4sAmMHx2u3G1ILNvOVUFztaodNrwJZ9PmW8zQAfwRNEQzBtYmnuNl+GxdOr5OlT4x+EX69RctCOXgw0qW5XKT6/rBkrNOVncDpaZRCsNR1m6vooNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731298314; c=relaxed/simple;
	bh=DLATnqdMGEF0WqdmHPcRRNdo+OHNczLANGm8ldMNdG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSjF1cU2JlZA+eZhgn4Xw9Kycdqfu/EPhR+m10SPKGKVyJpz9QW9XYgquplv89olG8PMh67fPPdNy/hHiRMVGCmVW9CKFNt2VNXFVAz0QcWlifLOfUQz6+g/66P4DPpGOhYdiimBlf/0S7H0BIausXiciT10XFjvmmbYuI+mEho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=am2+lfkf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="am2+lfkf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731298312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w2GV+7EwQ9ZLkRfoZhE0lui517nfX5U3dHrCpkmZzho=;
	b=am2+lfkf8c4JKLxvp8Rxp+YI8sYYmxR3JFFbGvHZllkj2SMlIbBeTPhJoywWpjhvzHhWdA
	pH3CNHWpjVjVfFZMKmt8BBfC3oHFmydzlDUg8UYP6fQ/ed3n6p0NtDSntyoBwshSeXeIku
	t+Y4WsMnhUzjIOSoLmNG8+aZAOVLZ+Q=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-SGteHgYGOeqW2pAKqArycA-1; Sun, 10 Nov 2024 23:11:49 -0500
X-MC-Unique: SGteHgYGOeqW2pAKqArycA-1
X-Mimecast-MFC-AGG-ID: SGteHgYGOeqW2pAKqArycA
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e9b5535940so1893287a91.1
        for <virtualization@lists.linux.dev>; Sun, 10 Nov 2024 20:11:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731298308; x=1731903108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2GV+7EwQ9ZLkRfoZhE0lui517nfX5U3dHrCpkmZzho=;
        b=LNDkPI5Y1g1sR2UWkFnLW2cWkwTHPZqvpIoSkpm2kuJHjM6tHjpUjpTAGZt689B2eb
         qxAo9bivegxK4vuilqaze12w6dmTaaX9i8TiGqKqRSWWZZCQGf4ECIH5XXl5vK1omGSg
         AcSTKr0YvsLNiSrreAKmeSuqNo5KZWkCFWbxuHMcyS8nNASJIHTXYs6DwAT1EgrrsjGh
         QxJDRfI9GDZYsfbGX//9bP9R4/9UDzjQfUWZeiE70OQj9d9N4X3+9kLz1J9hpCGFTeLq
         L4TdNd331oqse4MDsIQRN501ZB4O9+o6zFDmnAySxVqwT+rlHl041+gq8zgACVymW/Vp
         nimQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoLadSjnwzJWHX6QTV+GGDX0hbkkbWW2lq1zPUIE8uW5WeazZBLLE0UViSGcuTdYkSsU4mVNDMFM8NB1z+bw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcpNUf5bYxjoBLgRJxy/TD5GDCHB0Z4beibMA9Kmz4FUk2bAUE
	/wxn78NkM9Q23UKxiEQX2FvdblDZK87f/AX09wfr188dtixoPDS5JExCNFf7oahdyHrZjX2yISR
	eAVMxXiK9a0fFjb5Musn24C6lBSqMsMI2gcL2ALRXHi0lavRoeAcUQv59NwhumtiIOadMhWEn6b
	V/do8cOpISsyxj2dnwn+zXSBm6gLBK+nPp9NQEAso=
X-Received: by 2002:a17:90b:2d4e:b0:2e2:bdaa:baad with SMTP id 98e67ed59e1d1-2e9b1edc2e4mr17018410a91.7.1731298307830;
        Sun, 10 Nov 2024 20:11:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEc7ZYwHnxrg0FC/Z799Zoc1i4Spe4Nhk9xnNGMzEBDcw/KeGeVkU4qh3S2hfEgAgRusgumV+PhOR6e3ykmQ5M=
X-Received: by 2002:a17:90b:2d4e:b0:2e2:bdaa:baad with SMTP id
 98e67ed59e1d1-2e9b1edc2e4mr17018376a91.7.1731298307416; Sun, 10 Nov 2024
 20:11:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241107085504.63131-1-xuanzhuo@linux.alibaba.com>
 <20241107085504.63131-4-xuanzhuo@linux.alibaba.com> <1731293994.9676225-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1731293994.9676225-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Nov 2024 12:11:36 +0800
Message-ID: <CACGkMEt8wd=tq0Va=BwmZu20LFv59oegpAD2VzfLM8vaZJw+NA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 03/13] virtio_ring: packed: record extras for
 indirect buffers
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HUS5EW1g0nNhRg2bgiev6InNQqIYWMgEfGHbRvNjTy8_1731298308
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 11:53=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> On Thu,  7 Nov 2024 16:54:54 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com=
> wrote:
> > The subsequent commit needs to know whether every indirect buffer is
> > premapped or not. So we need to introduce an extra struct for every
> > indirect buffer to record this info.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
>
> Hi, Jason
>
> This also needs a review.

Sorry, I miss this.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

