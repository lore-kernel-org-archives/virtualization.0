Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E5B279DC2
	for <virtualization@lists.linux.dev>; Thu, 18 Dec 2025 03:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766029980; cv=none; b=bbpnfuIegOxmJzrtsKxhzI10KdAv+41MLX8pUnBmZSwsSuw5usIAvQCy9UT8yQ7AqHVSxBRn5GmeP1VS0UmywXWBevFbphvmwEnioiw67eWCNmv8D6UP+mV9wV5VKdVicaxrVtDaudTdzRAECBcHPuJUZ52mbSWnjqgxfKFUrJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766029980; c=relaxed/simple;
	bh=QMWBJBUexqbwWDfCPvN8knkhyI690YN3Qu8L+4wssTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbxXy/QYrkeTpvneVStwMi+lpuVGoKngc6lf8jx1bGVUdnlKoSL9W6pxyaukoNU75vvb4RzpShUQeGAp0DOtofVJRBfpEBU72uUV/ewd3cm0bucdOkRaXnYakPWnAahQ25A0cB7XiJe+iPUFFryUFbGGRO4Qp70rHlKtzVEnAtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XFgxIyI8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFgxIyI8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766029977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QMWBJBUexqbwWDfCPvN8knkhyI690YN3Qu8L+4wssTM=;
	b=XFgxIyI80wiO9Ke9QYOExN7RBkE/QGtYMO15pXrm9PKZdLhqgUWPnAo/nD/2vqe/Shyjtr
	zL+f5w1tMaEVxhHxDo2X2RkJ0v/mPvdz4oC8VJS43E3Xic7WM6Nwz1NDXNNzrNPCi9oEO0
	Uw/VqJztsEbPis6tYXJrsOZG+UKQx2U=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-Bt0kDbB-M16C4fFp3X0cGQ-1; Wed, 17 Dec 2025 22:52:55 -0500
X-MC-Unique: Bt0kDbB-M16C4fFp3X0cGQ-1
X-Mimecast-MFC-AGG-ID: Bt0kDbB-M16C4fFp3X0cGQ_1766029974
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a0a4b748a0so4678125ad.1
        for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 19:52:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766029974; x=1766634774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QMWBJBUexqbwWDfCPvN8knkhyI690YN3Qu8L+4wssTM=;
        b=mb9HLcvMBI+NtMgBg5nd+1EGKdOjhknxBAIE/7UyKt99a9oT6EiiQgtvtRQzsXdQ77
         d2BWj+dhM3WncT/uNlZxdu/i1sW9fdeLjBIkd+BxNicyT07wYch83pY7oCZ63PUX6LRR
         8wVXi5HQn96DVJETbjp9azO5yPd7J7MYetsNMoxhwP7gS7dWwqvgUzSdDS46XjoU90sY
         R9t6N2NVW12QCPR/YcoGgNk7u2Kalexnafh9jShZBSNcSBaf/WYVGZ6s6dgyRjR3AFUy
         IXbuMi7c6uH6XIN7aI+nAGoc2MlplxMdFP/gctFYC2QqD3KTyD2XPMsvar5b1GnahHRe
         D7Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVXACshjsg7YkqtCCZLGgcUF3KnSgF313uwt7tVuImluuGF7G1I8ri+Ad//CDpDUR9nMkYF+upOAqDKSBOEGA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5ub+IAgMQyB4EFyvph3tM94Z6EYDvQBajTmcbq2kMKtlb70mU
	JFkObNgAYgwM+iGk1mhvq7Oe2KhXh1F7FMYGBkDNd69H4wPulP7UyFS0VFY+RuiQLbJSDSvZKs3
	Rv8FJ5zqu5BtTMkEVNVy1iU7q+U+xurPIEFtFhzzJJmVPPCLsy58HnWY95YJcswrg2WyOUc7Ffc
	YnnFzAEwAal6RWNQjnqmyQwkAfyMWCU+TcX0ASyYBRnsk=
X-Gm-Gg: AY/fxX5djZW8uJwrHZALh+NxXtlgTfhmFUtPNC5MgFzWDio9uRdbHTagYUJNYO2IAL9
	fryeQYM5linIUdGur0cF2z0bASfs4RiBrYwDcTcTB4lcrnevDulANep17ofKwnJMKTXl+6I8wC4
	MLCFLN0j1/XsMg0b7v+Y4tqTYczRU6Tv662ZaT+++gJ3HZ/pFfHOxNQtzC/MO8ztdU4ss=
X-Received: by 2002:a17:903:1aac:b0:298:5fde:5a93 with SMTP id d9443c01a7336-29f23c677edmr196912235ad.32.1766029974602;
        Wed, 17 Dec 2025 19:52:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHw9DNEwmWjxWfi+F7K4n2BB/diI3M5uZKNjbX0bS9zDqcVCQPXZbRoNc0uTilQyHet8P2VB9LVOiFRTvTgn7U=
X-Received: by 2002:a17:903:1aac:b0:298:5fde:5a93 with SMTP id
 d9443c01a7336-29f23c677edmr196912045ad.32.1766029974179; Wed, 17 Dec 2025
 19:52:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251218034846.948860-1-maobibo@loongson.cn> <20251218034846.948860-3-maobibo@loongson.cn>
In-Reply-To: <20251218034846.948860-3-maobibo@loongson.cn>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Dec 2025 11:52:42 +0800
X-Gm-Features: AQt7F2qn7yrgQLTm-jx-zOUUwaHI5CYNjj2jNdNQeouWQKRiXmdxNRu5gCHge8I
Message-ID: <CACGkMEv-zTNkyxQHx5v5FGZE12SHib_73Lf10wF50_7B1WrPbg@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] crypto: virtio: Remove duplicated virtqueue_kick
 in virtio_crypto_skcipher_crypt_req
To: Bibo Mao <maobibo@loongson.cn>
Cc: Gonglei <arei.gonglei@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Eric Biggers <ebiggers@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-crypto@vger.kernel.org, stable@vger.kernel.org, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _0sli_bCk9ZrmmUgtXwCaMVT2hJX_aU3ntNGNgmRIdw_1766029974
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 11:49=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
> With function virtio_crypto_skcipher_crypt_req(), there is already
> virtqueue_kick() call with spinlock held in function
> __virtio_crypto_skcipher_do_req(). Remove duplicated virtqueue_kick()
> function call here.
>
> Fixes: d79b5d0bbf2e ("crypto: virtio - support crypto engine framework")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

