Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259E41B4159
	for <virtualization@lists.linux.dev>; Thu,  5 Dec 2024 07:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383984; cv=none; b=lv208G92zAJL4M86oeBUk7RacVgynvyW5YQDIen+nzdVL3tRTSGyMEcDRJF0vQN1KhE+WrpsZehiRNUAXqdA4Yx1QHcT83zOsY4Mp2T7Q0BhxPqpN6yDF2XjaVtqvc2GiPGGESU8okn58MPzwUF9ihncFpsvFtodmvSaXCCbTsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383984; c=relaxed/simple;
	bh=3vovcjPsrqh8Ljoz6njJUjJy7BIdDFIT/rdglPI+fT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gc2noe97zbJWzzZhhNWQgF7g4lUMJx92TGa5N9S2lSeBlauFUIMbFsqcIcEePhesIscCr9qcJKslzOQHsy/OYsUdJMtjU6IYWJu9CfZz38oMuDIkwqq9QGuL06RY6Yoc63PaFuOwGaqOPGxyt4CzYxELiCGNMJamFoM9Vblz+CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RyfWYvLW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RyfWYvLW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733383982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vovcjPsrqh8Ljoz6njJUjJy7BIdDFIT/rdglPI+fT4=;
	b=RyfWYvLWeAkRZIFiVs9oDX7gn6YRrlqfJcXNsTlsikVehT80Bv8Vh9wjij7C6y1UVWhgzF
	nBzbd/cRvTkH0pNqYtLc3E1L56A9JGjMcWL1JrxZ2TNirsrQGD3Hr+trjCzsyAKRVfj+6w
	luRrsVOHdyFQsQXMm8sitJFPQo5Vnf8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-93A1QE05OKaJAl6vXE2ZlA-1; Thu, 05 Dec 2024 02:33:01 -0500
X-MC-Unique: 93A1QE05OKaJAl6vXE2ZlA-1
X-Mimecast-MFC-AGG-ID: 93A1QE05OKaJAl6vXE2ZlA
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ee5f6fa3feso1030040a91.0
        for <virtualization@lists.linux.dev>; Wed, 04 Dec 2024 23:33:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383979; x=1733988779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vovcjPsrqh8Ljoz6njJUjJy7BIdDFIT/rdglPI+fT4=;
        b=DlWbreAdWXZB1p8eh/KWMgvsJRP2V/ra1gFs9TeZyc7khKZFadx+qHcpTO6NSx05ob
         SiV7r6YvtZdt6J8ns0TgeO/44PcioKBp+sd/7FCCK0NMYOjTvVWR9XG5M/g2VuIFzgO/
         zcM1i1PE/hjVBCVpe4y1nUNQUO55bQ9vM8yugq2eF8CkfMNMXd0kV0+QSdR+t4TCmppr
         WB9B9vUP8K7zvh1JlpNTtO8dUH7HCYp4EyN3PQX0cPcusXqLgWH35y5BGSqmaIdZuAEx
         83p975OnQQIvratv9OFejcPylmNf6SBy1bxfvKubpbWGKefn+C6zRZSYIQB7yqDefvTn
         45FQ==
X-Gm-Message-State: AOJu0YwtSyAnLWdbjqji58EL02wwYUQLVL0Q+lmPSGP36g7NoBnLYhLM
	rW8uht408/jvRlG3j4EAj5svzMWn1JEJPeWQ2eeBTIWndAE6P1vz6GXrKXyA8Gvmlwo+9dOWhh2
	SadEl775yY1j0v5MQPB+qw8li8S8tg7ETsamInnYys1jH6j16WtyBATYq9aWxYENFMyX5mPEWQd
	ydKfCHJDwVu7Ul6SwFeH0MtejQrXA2DFTdp5rjU0Ddh6/i9gBLtQ==
X-Gm-Gg: ASbGncvn+JEte2ixVVZTMQq0rmrhDesZ/E7/oy4o/Q1w5ssLigbMdBUik5FQFlJpAHL
	zLCAIngEfO1h/q7h8wFGPnTER3wIyN4EV
X-Received: by 2002:a17:90b:1b4e:b0:2ee:8abd:7254 with SMTP id 98e67ed59e1d1-2ef012748damr12712063a91.36.1733383978127;
        Wed, 04 Dec 2024 23:32:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDtQDoQaqM+3b+ntK9dqohRIca4r56a555HOpzjVOkBG5XoAIkxz5R1IAjDQ0aajFWY1uYgAI/ZNkMsaHUSWY=
X-Received: by 2002:a17:90b:1b4e:b0:2ee:8abd:7254 with SMTP id
 98e67ed59e1d1-2ef012748damr12711858a91.36.1733383974938; Wed, 04 Dec 2024
 23:32:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241204050724.307544-1-koichiro.den@canonical.com> <20241204050724.307544-7-koichiro.den@canonical.com>
In-Reply-To: <20241204050724.307544-7-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Dec 2024 15:32:43 +0800
Message-ID: <CACGkMEtkabmYmepsx-dyTbTJKq4RUh7fPVT6YubS6RFQD35XMg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 6/7] virtio_ring: add a func argument
 'recycle_done' to virtqueue_reset()
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zJ-Qxnv7sWsHdoypor9mnlI2QtOgpdffamU4-W0VJxw_1733383980
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:08=E2=80=AFPM Koichiro Den <koichiro.den@canonical=
.com> wrote:
>
> When virtqueue_reset() has actually recycled all unused buffers,
> additional work may be required in some cases. Relying solely on its
> return status is fragile, so introduce a new function argument
> 'recycle_done', which is invoked when it really occurs.
>
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

